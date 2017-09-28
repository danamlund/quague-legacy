progs.dat: progs/client.qc
	cd progs; ../../ftqqcc/fteqcc64

clean:
	rm -f progs.dat

run: progs.dat
	cd ..; ./quakespasm -game quaguelegacy


test: clean progs.dat run

zip: progs.dat
	zip -r quaguelegacy_v1_0.zip readme.txt progs.dat
