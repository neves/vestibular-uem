mkdir -p downloads
cd downloads

# 43 arquivos

wget -N http://www.vestibular.uem.br/2013-V/uem_verao_2013_listao.zip
wget -N http://www.vestibular.uem.br/2013-EAD/uem_ead_2013_listao.zip
wget -N http://www.vestibular.uem.br/2013-I/uem_inverno_2013_listao.zip

wget -N http://www.vestibular.uem.br/2012-V/uem_verao_2012_listao.zip
wget -N http://www.vestibular.uem.br/2012-I/uem_inverno_2012_listao.zip

wget -N http://www.vestibular.uem.br/2011-V/uem_verao_2011_listao.zip
wget -N http://www.vestibular.uem.br/2011-V/uem_verao_2011_ead_listao.zip
wget -N http://www.vestibular.uem.br/2011-I/uem_inverno_2011_listao.zip

wget -N http://www.vestibular.uem.br/2010-V/uem_verao_2010_listao.zip
wget -N http://www.vestibular.uem.br/2010-EAD/uem_ead_julho_2010_listao.zip
wget -N http://www.vestibular.uem.br/2010-I/uem_inverno_2010_listao.zip

wget -N http://www.vestibular.uem.br/2009-V/uemve09l.zip
wget -N http://www.vestibular.uem.br/2009-EAD2/uem_ead_2_2009_listao.zip
wget -N http://www.vestibular.uem.br/2009-I/uemin09l.zip
wget -N http://www.vestibular.uem.br/2009-EAD/uem_ead2009_listao.zip

wget -N http://www.vestibular.uem.br/2008-EAD/uem_ead2008_listao.zip
wget -N http://www.vestibular.uem.br/2008-V/uemve08l.zip
wget -N http://www.vestibular.uem.br/2008-I/uemin08l.zip

wget -N http://www.vestibular.uem.br/2007-V/uemve07l.zip
wget -N http://www.vestibular.uem.br/2007-I/uemin07l.zip

wget -N http://www.vestibular.uem.br/2006-V/uemve06l.zip
wget -N http://www.vestibular.uem.br/2006-I/uemin06l.zip
wget -N http://www.vestibular.uem.br/2006-EAD/uemead06.zip
wget -N http://www.vestibular.uem.br/2006-2/uem206l.zip
wget -N http://www.vestibular.uem.br/2006-1/uem106l.zip

wget -N http://www.vestibular.uem.br/2005-EAD/uemead05.zip
wget -N http://www.vestibular.uem.br/2005-2/uem_2_2005_listao.zip
wget -N http://www.vestibular.uem.br/2005-1/uem_1_2005_listao.zip

wget -N http://www.vestibular.uem.br/2004-2/uem_2_2004_listao.zip
wget -N http://www.vestibular.uem.br/2004-1/uem_1_2004_listao.zip

wget -N http://www.vestibular.uem.br/2003-2/uem_2_2003_listao.zip
wget -N http://www.vestibular.uem.br/2003-1/uem_1_2003_listao.zip

wget -N http://www.vestibular.uem.br/2002-1/uem_verao_2002_listao.zip

wget -N http://www.vestibular.uem.br/2001-2/uem_inverno_2001_listao.zip
wget -N http://www.vestibular.uem.br/2001-1/uem_verao_2001_listao.zip

wget -N http://www.vestibular.uem.br/2000-E/uem_verao_2000_especial_listao.zip
wget -N http://www.vestibular.uem.br/2000-2/uem_inverno_2000_listao.zip
wget -N http://www.vestibular.uem.br/2000-1/uem_verao_2000_listao.zip

wget -N http://www.vestibular.uem.br/1999-2/uem_inverno_1999_listao.zip
wget -N http://www.vestibular.uem.br/1999-1/uem_verao_1999_listao.zip

wget -N http://www.vestibular.uem.br/1998-2/uem_inverno_1998_listao.zip
wget -N http://www.vestibular.uem.br/1998-1/uem_verao_1998_listao.zip

wget -N http://www.cvu.uem.br/1997-2/uem_inverno_1997_listao.zip

mkdir -p ../txts
unzip -o -d ../txts '*.zip'

ls -la *.zip | wc -l
ls -la ../txts/*.txt | wc -l

cd ..

ack -i --nocolor --no-filename 'CURSO:' txts/ | iconv -f ISO-8859-1 -t UTF-8 | sort > cursos.txt
cat cursos.txt | cut -c 1-80 | uniq > cursos-uniq.txt
cat cursos-uniq.txt | cut -c 8-11 | uniq > cursos-codigos.txt
