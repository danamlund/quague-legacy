progs.dat: progs/client.qc
	cd progs; fteqcc64

clean:
	rm -f progs.dat

run: progs.dat
	cd ..; ./quakespasm -game quague-legacy


test: clean progs.dat run

zip: progs.dat
	zip -r quaguelegacy_v1_0.zip readme.txt progs.dat
