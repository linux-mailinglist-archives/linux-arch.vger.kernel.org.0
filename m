Return-Path: <linux-arch+bounces-15057-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E555C7E48A
	for <lists+linux-arch@lfdr.de>; Sun, 23 Nov 2025 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E6D3A9B00
	for <lists+linux-arch@lfdr.de>; Sun, 23 Nov 2025 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDB1FFC6D;
	Sun, 23 Nov 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="bHRX0y9G";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="eLiJDv2b"
X-Original-To: linux-arch@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E514F125;
	Sun, 23 Nov 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917516; cv=none; b=TtB7wJx54EcOEHh6wU+RHJxHllNuAuNsix0st8rblcxFqwIXXHr/PdhIPs1UQsE1Ux7ieJgz7qw2RbE2bjox8jOEP3IwYPBiUXiF9twx/QijQse7HjcBlq4YWV/OF8fHirZK8KsFaaLkp+C21Hy3cDNpOQUf55PlF9QUiLN1tmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917516; c=relaxed/simple;
	bh=Nj5JB3XAJLRyVIjEumeD9FVQkC1hq0YOzphU0In+fVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6QgTHq9tD4tY9YByCBlza88dvc4ziL7T/bBJZyrqSvBDY3zUVhqcKbmj0z8l7VHXeiyonHx6seMI3qCTR+V4jcNJ7gcKF2NtWhv58g/i6mwO9zT6Xh/ZNO0EE4qWd+k/y9/VjEUzeTGuhzIZUjsyvxrDbSKZmqDhQ+Q7o50h1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=bHRX0y9G; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=eLiJDv2b; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Date: Sun, 23 Nov 2025 18:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1763917504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ6buai6EBWSD8LmmfmrQPMqAmWKgltB1mTsvfume4I=;
	b=bHRX0y9GC2dSySARiyWGiMmrp/Xe96irqn0m9ozILmBYs6yV2zb/fA9R+6p0XjUSLcFsMx
	vAEQ3ThKgIriI3d1xBfZz10HDnnJ1Qu4IplfQEC5/BG0U7pFjkinz5RNiB5OOnOodqurLL
	rBtfdrfmkTW1g57sLR/uwRP+vD7BIkHFSzCEjA2gLhe6M4QdIqNr7thtmgyRbXHLEMzz6z
	ZFC5X00QxbjVqmP6ZyjhxGlkMJLTrC1EEYg4LMJFljJfoi4MCyUJ2hELJNaZmy2KJscnrz
	IJm9CAbGvkzsztKGABF71wt3hAlYfraokWs/aUk60LSaeG1zpjfQduS7/tkvGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1763917504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ6buai6EBWSD8LmmfmrQPMqAmWKgltB1mTsvfume4I=;
	b=eLiJDv2bkfc0QH49mP1xeveb0IgqR2Kb5m/smULeZHuXH+L/8GJdHV6BxAx7MFEPi8mVsP
	r6Dhlwj0lu1R2DBQ==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
Message-ID: <20251123170502.Ai5Ig66Z@breakpoint.cc>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>
 <20251119154834.A-tQsLzh@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119154834.A-tQsLzh@linutronix.de>

On 2025-11-19 16:48:34 [+0100], Sebastian Andrzej Siewior wrote:
> I fully agree with this approach. I don't like the big hash array but I
> have an idea how to optimize that part. So I don't see a problem in the
> long term.

The following PoC creates a merkle tree from a set files ending with .ko
within the specified directory. It will write a .hash files containing
the required hash for each file for its validation. The root hash is
saved as "hash_root" and "hash_root.h" in the directory.

The Debian kernel shipps 4256 modules:

| $ time ./compute_hashes mods_deb
| Files 4256 levels: 13 root hash: 97f8f439d63938ed74f48ec46dbd75c2b5e5b49f012a414e89b6f0e0f06efe84
| 
| real    0m0,732s
| user    0m0,304s
| sys     0m0,427s

This computes the hashes for all the modules it found in the mods_deb
folder.
The kernel needs the root hash (for sha256 32 bytes) and the depth of
the tree (4 bytes). That are 36 bytes regardless of the number of
modules that are built.
In this case, the attached hash for each module is 420 bytes. This is 4
bytes (position in the tree) + 13 (depth) * 32.
The verification process requires 13 hash operation to hash through the
tree and verify against the root hash.

For convience, the following PoC can also be found at
	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/mtree-hashed-mods.git/

which also includes a small testsuite.

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000000000..e4a35c15f0a94
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,7 @@
+CC := gcc
+CFLAGS := -O2 -g -Wall
+LDLIBS := -lcrypto
+
+all: compute_hashes mk-files verify_hash
+test: compute_hashes mk-files verify_hash
+	./verify_test.sh
diff --git a/compute_hashes.c b/compute_hashes.c
new file mode 100644
index 0000000000000..da61b214137b8
--- /dev/null
+++ b/compute_hashes.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Compute hashes for individual files and build a merkle tree.
+ *
+ * Author: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
+ *
+ */
+#define _GNU_SOURCE 1
+#include <ftw.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include <openssl/evp.h>
+
+#include "helpers.h"
+
+struct file_entry {
+	char *name;
+	size_t fsize;
+	unsigned int pos;
+	unsigned char hash[EVP_MAX_MD_SIZE];
+};
+
+static struct file_entry *fh_list;
+static size_t num_files;
+
+struct leaf_hash {
+	unsigned char hash[EVP_MAX_MD_SIZE];
+};
+
+struct mtree {
+	struct leaf_hash **l;
+	unsigned int *entries;
+	unsigned int levels;
+};
+
+static unsigned int get_pow2(unsigned int val)
+{
+	return 31 - __builtin_clz(val);
+}
+
+static unsigned int roundup_pow2(unsigned int val)
+{
+	return 1 << (get_pow2(val - 1) + 1);
+}
+
+static unsigned int log2_roundup(unsigned int val)
+{
+	return get_pow2(roundup_pow2(val));
+}
+
+static int str_endswith(const char *s, const char *suffix)
+{
+	size_t ls, lf;
+
+	ls = strlen(s);
+	lf = strlen(suffix);
+
+	if (ls <= lf)
+		return -1;
+	return strcmp(s + ls - lf, suffix);
+}
+
+static void __print_hash(unsigned char *h)
+{
+	int i;
+
+	for (i = 0; i < hash_size; i++)
+		printf("%02x", h[i]);
+}
+
+static void print_hash(unsigned char *h)
+{
+	__print_hash(h);
+	printf("\n");
+}
+
+static int hash_file(struct file_entry *fe)
+{
+	void *mem;
+	int fd;
+
+	fd = open(fe->name, O_RDONLY);
+	if (fd < 0) {
+		printf("Failed to open %s: %m\n", fe->name);
+		exit(1);
+	}
+
+	mem = mmap(NULL, fe->fsize, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
+
+	if (mem == MAP_FAILED) {
+		printf("Failed to mmap %s: %m\n", fe->name);
+		exit(1);
+	}
+
+	hash_data(mem, fe->pos, fe->fsize, fe->hash);
+
+	munmap(mem, fe->fsize);
+	return 0;
+}
+
+static int add_files_cb(const char *fpath, const struct stat *sb, int tflag,
+			struct FTW *ftwbuf)
+{
+	if (tflag != FTW_F)
+		return 0;
+
+	if (str_endswith(fpath, ".ko"))
+		return 0;
+
+	fh_list = xrealloc(fh_list, (num_files + 1) * sizeof (struct file_entry));
+
+	fh_list[num_files].name = strdup(fpath);
+	if (!fh_list[num_files].name) {
+		printf("Failed to allocate memory\n");
+		exit(1);
+	}
+
+	fh_list[num_files].fsize = sb->st_size;
+
+	num_files++;
+	return 0;
+}
+
+static int cmp_file_entry(const void *p1, const void *p2)
+{
+	const struct file_entry *f1, *f2;
+
+	f1 = p1;
+	f2 = p2;
+
+	return strcmp(f1->name, f2->name);
+}
+
+static struct mtree *build_merkle(struct file_entry *fh, size_t num)
+{
+	unsigned int i, le;
+	struct mtree *mt;
+
+	mt = xmalloc(sizeof(struct mtree));
+	mt->levels = log2_roundup(num);
+	mt->l = xcalloc(sizeof(struct leaf_hash *), mt->levels);
+
+	mt->entries = xcalloc(sizeof(unsigned int), mt->levels);
+	le = num / 2;
+	if (num & 1)
+		le++;
+	mt->entries[0] = le;
+	mt->l[0] = xcalloc(sizeof(struct leaf_hash), le);
+
+	/* First level of pairs */
+	for (i = 0; i < num; i+= 2) {
+		if (i == num - 1) {
+			/* Odd number of files, no pair. Hash with itself */
+			hash_entry(fh[i].hash, fh[i].hash, mt->l[0][i/2].hash);
+		} else {
+			hash_entry(fh[i].hash, fh[i + 1].hash, mt->l[0][i/2].hash);
+		}
+	}
+	for (i = 1; i < mt->levels; i++) {
+		int n;
+		int odd = 0;
+
+		if (le & 1) {
+			le++;
+			odd++;
+		}
+
+		mt->entries[i] = le / 2;
+		mt->l[i] = xcalloc(sizeof(struct leaf_hash), le);
+
+		for (n = 0; n < le; n += 2) {
+			if (n == le - 2 && odd) {
+				/* Odd number of pairs, no pair. Hash with itself */
+				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n].hash,
+					   mt->l[i][n/2].hash);
+			} else {
+				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n +1].hash,
+					   mt->l[i][n/2].hash);
+			}
+		}
+		le =  mt->entries[i];
+	}
+	return mt;
+}
+
+static void free_mtree(struct mtree *mt)
+{
+	int i;
+
+	for (i = 0; i < mt->levels; i++)
+		free(mt->l[i]);
+
+	free(mt->l);
+	free(mt->entries);
+	free(mt);
+}
+
+static void write_be_int(int fd, unsigned int v)
+{
+	unsigned int be_val = host_to_be32(v);
+
+	if (write(fd, &be_val, sizeof(be_val)) != sizeof(be_val)) {
+		printf("Failed writting to file: %m\n");
+		exit(1);
+	}
+}
+
+static void write_hash(int fd, const void *h)
+{
+	ssize_t wr;
+
+	wr = write(fd, h, hash_size);
+	if (wr != hash_size) {
+		printf("Failed writting to file: %m\n");
+		exit(1);
+	}
+}
+
+static void build_proof(struct mtree *mt, unsigned int n, int fd)
+{
+	unsigned char cur[EVP_MAX_MD_SIZE];
+	unsigned char tmp[EVP_MAX_MD_SIZE];
+	struct file_entry *fe, *fe_sib;
+	unsigned int i;
+
+	fe = &fh_list[n];
+
+	if ((n & 1) == 0) {
+		/* No pair, hash with itself */
+		if (n + 1 == num_files)
+			fe_sib = fe;
+		else
+			fe_sib = &fh_list[n + 1];
+	} else {
+		fe_sib = &fh_list[n - 1];
+	}
+	/* First comes the node position into the file */
+	write_be_int(fd, n);
+
+	if ((n & 1) == 0)
+		hash_entry(fe->hash, fe_sib->hash, cur);
+	else
+		hash_entry(fe_sib->hash, fe->hash, cur);
+
+	/* Next is the sibling hash, followed by hashes in the tree */
+	write_hash(fd, fe_sib->hash);
+
+	for (i = 0; i < mt->levels - 1; i++) {
+		n >>= 1;
+		if ((n & 1) == 0) {
+			void *h;
+
+			/* No pair, hash with itself */
+			if (n + 1 == mt->entries[i])
+				h = cur;
+			else
+				h = mt->l[i][n + 1].hash;
+
+			hash_entry(cur, h, tmp);
+			write_hash(fd, h);
+		} else {
+			hash_entry(mt->l[i][n - 1].hash, cur, tmp);
+			write_hash(fd, mt->l[i][n - 1].hash);
+		}
+		memcpy(cur, tmp, hash_size);
+	}
+
+	 /* After all that, the end hash should match the root hash */
+	if (memcmp(cur, mt->l[mt->levels - 1][0].hash, hash_size))
+		printf("MISS-MATCH\n");
+}
+
+static void write_merkle_root(struct mtree *mt, const char *fp)
+{
+	char buf[1024];
+	int fd;
+
+	if (snprintf(buf, sizeof(buf), "%s/hash_root", fp) >= sizeof(buf)) {
+		printf("Root dir too long\n");
+		exit(1);
+	}
+	fd = open(buf, O_WRONLY | O_CREAT | O_TRUNC, DEF_F_PERM);
+	if (fd < 0) {
+		printf("Failed to create %s: %m\n", buf);
+		exit(1);
+	}
+
+	write_be_int(fd, mt->levels);
+	write_hash(fd, mt->l[mt->levels - 1][0].hash);
+	close(fd);
+	printf("Files %ld levels: %d root hash: ", num_files, mt->levels);
+	print_hash(mt->l[mt->levels - 1][0].hash);
+}
+
+static void write_merkle_root_h(struct mtree *mt, const char *fp)
+{
+	char buf[1024];
+	unsigned int i;
+	unsigned char *h;
+	FILE *f;
+
+	if (snprintf(buf, sizeof(buf), "%s/hash_root.h", fp) >= sizeof(buf)) {
+		printf("Root dir too long\n");
+		exit(1);
+	}
+	f = fopen(buf, "w");
+	if (!f) {
+		printf("Failed to create %s: %m\n", buf);
+		exit(1);
+	}
+	h = mt->l[mt->levels - 1][0].hash;
+
+	fprintf(f, "#ifndef __HASH_ROOT_TREE_H__\n");
+	fprintf(f, "#define __HASH_ROOT_TREE_H__\n\n");
+	fprintf(f, "unsigned int hashed_mods_levels = %u;\n", mt->levels);
+	fprintf(f, "unsigned char hashed_mods_root[%d] = {", hash_size);
+	for (i = 0; i < hash_size; i++) {
+		char *space = "";
+
+		if (!(i % 8))
+			fprintf(f, "\n\t");
+
+		if ((i + 1) % 8)
+			space = " ";
+
+		fprintf(f, "0x%02x,%s", h[i], space);
+	}
+	fprintf(f, "\n};\n#endif\n");
+	fclose(f);
+}
+
+int main(int argc, char *argv[])
+{
+	const EVP_MD *hash_evp;
+	char *fp;
+	struct mtree *mt;
+	int i;
+
+	ctx = EVP_MD_CTX_new();
+	if (!ctx)
+		goto err_ossl;
+
+	if (argc != 2) {
+		printf("%s: folder\n", argv[0]);
+		return 1;
+	}
+	fp = argv[1];
+
+	hash_evp = EVP_sha256();
+	hash_size = EVP_MD_get_size(hash_evp);
+	if (hash_size <= 0)
+		goto err_ossl;
+
+	if (EVP_DigestInit_ex(ctx, hash_evp, NULL) != 1)
+		goto err_ossl;
+
+	nftw(fp, add_files_cb, 64, 0);
+
+	qsort(fh_list, num_files, sizeof(struct file_entry), cmp_file_entry);
+
+	for (i = 0; i < num_files; i++) {
+		fh_list[i].pos = i;
+		hash_file(&fh_list[i]);
+	}
+
+	mt = build_merkle(fh_list, num_files);
+	write_merkle_root(mt, fp);
+	write_merkle_root_h(mt, fp);
+	for (i = 0; i < num_files; i++) {
+		char signame[1024];
+		int fd;
+		int ret;
+
+		ret = snprintf(signame, sizeof(signame), "%s.hash", fh_list[i].name);
+		if (ret >= sizeof(signame)) {
+			printf("path + name too long\n");
+			return 1;
+		}
+		fd = open(signame, O_WRONLY | O_CREAT | O_TRUNC, DEF_F_PERM);
+		if (fd < 0) {
+			printf("Can't create %s: %m\n", signame);
+			return 1;
+		}
+		build_proof(mt, i, fd);
+		close(fd);
+	}
+
+	free_mtree(mt);
+	for (i = 0; i < num_files; i++)
+		free(fh_list[i].name);
+	free(fh_list);
+
+	EVP_MD_CTX_free(ctx);
+	return 0;
+
+err_ossl:
+	printf("libssl operation failed\n");
+	return 1;
+}
diff --git a/helpers.h b/helpers.h
new file mode 100644
index 0000000000000..f52ad3543f890
--- /dev/null
+++ b/helpers.h
@@ -0,0 +1,109 @@
+#ifndef __HELPERS_H__
+#define __HELPERS_H__
+
+static EVP_MD_CTX *ctx;
+static int hash_size;
+
+#define DEF_F_PERM (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH) /* 0644*/
+#define DEF_D_PERM (S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH) /* 0755*/
+
+static unsigned int host_to_be32(unsigned int v)
+{
+#if __BYTE_ORDER__ == __LITTLE_ENDIAN
+	return __builtin_bswap32(v);
+#elif __BYTE_ORDER__ == __BIG_ENDIAN
+	return  v;
+#else
+#error Missing endian define
+#endif
+}
+
+static inline void *xcalloc(size_t n, size_t size)
+{
+	void *p;
+
+	p = calloc(n, size);
+	if (p)
+		return p;
+	printf("Memory allocation failed\n");
+	exit(1);
+}
+
+static void *xmalloc(size_t size)
+{
+	void *p;
+
+	p = malloc(size);
+	if (p)
+		return p;
+	printf("Memory allocation failed\n");
+	exit(1);
+}
+
+static inline void *xrealloc(void *oldp, size_t size)
+{
+	void *p;
+
+	p = realloc(oldp, size);
+	if (p)
+		return p;
+	printf("Memory allocation failed\n");
+	exit(1);
+}
+
+static void hash_data(void *p, unsigned int pos, size_t size, void *ret_hash)
+{
+	unsigned char magic = 0x01;
+	unsigned int pos_be;
+
+	pos_be = host_to_be32(pos);
+	if (EVP_DigestInit_ex(ctx, NULL, NULL) != 1)
+		goto err;
+
+	if (EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1)
+		goto err;
+
+	if (EVP_DigestUpdate(ctx, &pos_be, sizeof(pos_be)) != 1)
+		goto err;
+
+	if (EVP_DigestUpdate(ctx, p, size) != 1)
+		goto err;
+
+	if (EVP_DigestFinal_ex(ctx, ret_hash, NULL) != 1)
+		goto err;
+
+	return;
+
+err:
+	printf("libssl operation failed\n");
+	exit(1);
+}
+static void hash_entry(void *left, void *right, void *ret_hash)
+{
+	unsigned char magic = 0x02;
+
+	if (EVP_DigestInit_ex(ctx, NULL, NULL) != 1)
+		goto err;
+
+	if (EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1)
+		goto err;
+
+	if (EVP_DigestUpdate(ctx, left, hash_size) != 1)
+		goto err;
+
+	if (EVP_DigestUpdate(ctx, right, hash_size) != 1)
+		goto err;
+
+	if (EVP_DigestFinal_ex(ctx, ret_hash, NULL) != 1)
+		goto err;
+
+	return;
+
+err:
+	printf("libssl operation failed\n");
+	exit(1);
+}
+
+
+
+#endif
diff --git a/verify_hash.c b/verify_hash.c
new file mode 100644
index 0000000000000..0a842f27f1ebc
--- /dev/null
+++ b/verify_hash.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Verify a file against and its hash against a merkle tree hash.
+ *
+ * Author: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
+ *
+ */
+#define _GNU_SOURCE 1
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include <openssl/evp.h>
+
+#include "helpers.h"
+
+struct hash_root {
+	unsigned int level;
+	unsigned char hash[EVP_MAX_MD_SIZE];
+};
+
+struct verify_sig {
+	unsigned int pos;
+	char hash_sigs[];
+};
+
+static int hash_file(const char *f, unsigned char *hash, unsigned int pos)
+{
+	struct stat sb;
+	int fd, ret;
+	void *mem;
+
+	fd = open(f, O_RDONLY);
+	if (fd < 0) {
+		printf("Failed to open %s: %m\n", f);
+		exit(1);
+	}
+
+	ret = fstat(fd, &sb);
+	if (ret) {
+		printf("stat failed %m\n");
+		exit(1);
+	}
+
+	mem = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
+
+	if (mem == MAP_FAILED) {
+		printf("Failed to mmap file: %m\n");
+		exit(1);
+	}
+
+	hash_data(mem, pos, sb.st_size, hash);
+
+	munmap(mem, sb.st_size);
+	return 0;
+}
+
+static void verify_hash(struct hash_root *hr, struct verify_sig *vs, unsigned char *cur,
+			const char *fn)
+{
+	unsigned char tmp[EVP_MAX_MD_SIZE];
+	unsigned sig_ofs = 0;
+	unsigned int i, n;
+
+	n = vs->pos;
+	if ((n & 1) == 0)
+		hash_entry(cur, &vs->hash_sigs[sig_ofs], tmp);
+	else
+		hash_entry(&vs->hash_sigs[sig_ofs], cur, tmp);
+
+	memcpy(cur, tmp, hash_size);
+	sig_ofs += hash_size;
+	for (i = 0; i < hr->level - 1; i++) {
+		n >>= 1;
+		if ((n & 1) == 0) {
+			hash_entry(cur, &vs->hash_sigs[sig_ofs], tmp);
+		} else {
+			hash_entry(&vs->hash_sigs[sig_ofs], cur, tmp);
+		}
+		memcpy(cur, tmp, hash_size);
+		sig_ofs += hash_size;
+	}
+
+	if (!memcmp(cur, hr->hash, hash_size)) {
+		exit(0);
+	} else {
+		printf("MISS-MATCH on %s\n", fn);
+		exit(1);
+	}
+}
+
+static void read_be_int(int fd, unsigned int *val)
+{
+	unsigned int val_be;
+
+	if (read(fd, &val_be, sizeof(val_be)) != sizeof(val_be)) {
+		printf("Can't read from file\n");
+		exit(1);
+	}
+	*val = host_to_be32(val_be);
+}
+
+struct hash_root *read_root_hash(const char *f)
+{
+	int fd;
+	struct hash_root *hr;
+
+	hr = xmalloc(sizeof(*hr));
+	fd = open(f, O_RDONLY);
+	if (fd < 0) {
+		printf("Can't open %s: %m\n", f);
+		exit(1);
+	}
+	read_be_int(fd, &hr->level);
+	if (read(fd, hr->hash, hash_size) != hash_size) {
+		printf("Can't read complete hash (%u): %m\n",
+		       hash_size);
+		exit(1);
+	}
+	close(fd);
+	return hr;
+}
+
+static void load_hash_sig(const char *f, struct verify_sig *verify_sig,
+			  unsigned int sig_num)
+{
+	ssize_t total_hash_size;
+	struct stat sb;
+	char buf[1024];
+	int fd;
+	int ret;
+
+	total_hash_size = sig_num * hash_size;
+
+	ret = snprintf(buf, sizeof(buf), "%s.hash", f);
+	if (ret >= sizeof(buf)) {
+		printf("Too long\n");
+		exit(1);
+	}
+	fd = open(buf, O_RDONLY);
+	if (fd < 0) {
+		printf("Failed to open %s\n", buf);
+		exit(1);
+	}
+	read_be_int(fd, &verify_sig->pos);
+
+	ret = fstat(fd, &sb);
+	if (ret < 0) {
+		printf("Failed to stat %s: %m\n", f);
+		exit(1);
+	}
+
+	if (sb.st_size != total_hash_size + 4) {
+		printf("Unexpected signature size: Expected %ld vs found %ld\n",
+		       total_hash_size + 4, sb.st_size);
+		exit(1);
+	}
+	if (read(fd, verify_sig->hash_sigs, total_hash_size) != total_hash_size) {
+		printf("Failed to read the signature: %m\n");
+		exit(1);
+	}
+	close(fd);
+}
+
+int main(int argc, char *argv[])
+{
+	struct hash_root *hash_root;
+	struct verify_sig *vsig;
+	unsigned char fhash[EVP_MAX_MD_SIZE];
+	const EVP_MD *hash_evp;
+
+	ctx = EVP_MD_CTX_new();
+	if (!ctx)
+		goto err;
+
+	if (argc != 3) {
+		printf("%s: hash_root module\n", argv[0]);
+		return 1;
+	}
+
+	hash_evp = EVP_sha256();
+	hash_size = EVP_MD_get_size(hash_evp);
+	if (hash_size <= 0)
+		goto err;
+
+	if (EVP_DigestInit_ex(ctx, hash_evp, NULL) != 1)
+		goto err;
+
+	hash_root = read_root_hash(argv[1]);
+	vsig = xmalloc(sizeof(struct verify_sig) + hash_root->level * hash_size);
+
+	load_hash_sig(argv[2], vsig, hash_root->level);
+	hash_file(argv[2], fhash, vsig->pos);
+	verify_hash(hash_root, vsig, fhash, argv[2]);
+
+	EVP_MD_CTX_free(ctx);
+	return 0;
+err:
+	printf("libssl operation failed\n");
+	return 1;
+}
-- 
2.51.0


Sebastian

