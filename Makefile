progs.dat: progs/client.qc
	cd progs; fteqcc64

clean:
	rm -f progs.dat

run: progs.dat
	cd ..; ./quakespasm -game quague-legacy

test: clean progs.dat run

zip: progs.dat
	rm -rf /tmp/quaguelegacy
	mkdir -p /tmp/quaguelegacy/quaguelegacy
	cp -r readme.txt progs.dat LICENSE progs /tmp/quaguelegacy/quaguelegacy/
	cd /tmp/quaguelegacy; zip -r quaguelegacy_v1_2.zip .
	cp /tmp/quaguelegacy/*.zip .
