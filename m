Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7611526F3
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgBEHb2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:31:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36994 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBEHb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so516865plz.4
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeGkYni7LJnQM11cC/ZJMS21tEqO7nFsGMOBX356P0E=;
        b=GnQ2bClCWLsD55OakblMBpb0RraY3EtgGWac1GRk5k2PNA5z0iTpfKQ1SrHxVIRz1p
         MLzqEhOYyKn12oH68LNZGH+stXVlqqFho+D4qYRZA0k87ovfa/ZzdHik9skjN6vOAhvn
         Qn24kRc/xhiUd2pcM7aY+HsoAD4Z9r7GhkPIYQ0JcmVkyVbBLjX4+DHuGsm9BMsmfWLg
         9jVBx9rLcfor2pUSKVdifrYDg3zUO5FCtydtZVYNXJuMEwO64ea8Y+FGzRDOlB43K37b
         0OZkEBW55EQeNpOlFkPgXA+8DoYcgU8W9X5U9lUhBDlyDr09YGpqxe8c+lFaj6wzugO1
         Ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeGkYni7LJnQM11cC/ZJMS21tEqO7nFsGMOBX356P0E=;
        b=uh+7Si5NGeb1q5VtvozNu9F4ngtCs7gAv1ErxlJaDHsYYz67DL+1FEtHT+l7nbMUYR
         0qvua06D6BSzXnMik9KbERHdN55dr4OPas+ptMlBv2Wb3BbVNLM61hQVtGjL9k3SUWsv
         8ojH82/ZUQJ+YlO8CzrQgyEhbMKkAz9LwuORQkoRCjnSJIwPgATYCrSDUB9wEdf44lvu
         FyDnJGMo2idnpVMSvHFbssl8geBOW+m81DqY+fEjdjC6YRVChpjsDFXooQWlZC18eCvf
         ApWe2LoRsUDuO0Ajqgsspf1WUvugEsuWFqbgRpMNYJmuag6mdln43FhZeRmQiYzjcY9s
         xbgA==
X-Gm-Message-State: APjAAAUvh9Zln2oNINiBzJrrCesO3lItd++xaXwh3S3xAMhHfEgkWT27
        gV+jN3RXxi8vl13MivclOiw=
X-Google-Smtp-Source: APXvYqxa8t7djYc8qi6HKIJEKZ1YPCytcxKktlVYF3+LpmO64/usfCvShGAz/lVB6Q8Ry2TFj4KE4g==
X-Received: by 2002:a17:902:7009:: with SMTP id y9mr34221255plk.254.1580887886319;
        Tue, 04 Feb 2020 23:31:26 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id n2sm28404600pfq.50.2020.02.04.23.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:31:25 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id CC401202573078; Wed,  5 Feb 2020 16:31:23 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>, Dan Peebles <pumpkin@me.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Yuriy Taraday <yorik.sar@gmail.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 19/26] lkl tools: cptofs that reads/writes to/from a filesystem image
Date:   Wed,  5 Feb 2020 16:30:28 +0900
Message-Id: <3ebc55a46aa101db6262d277792629aca1c7e0a4.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

A tool to read/write to/from a filesystem image without mounting the
file to host filesystem.  Thus there is no root privilege to modify the
contents.

Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: Dan Peebles <pumpkin@me.com>
Cc: Petros Angelatos <petrosagg@gmail.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Yuriy Taraday <yorik.sar@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/.gitignore |   2 +
 tools/lkl/Build      |   2 +
 tools/lkl/Makefile   |   3 +
 tools/lkl/Targets    |   4 +
 tools/lkl/cptofs.c   | 636 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 647 insertions(+)
 create mode 100644 tools/lkl/cptofs.c

diff --git a/tools/lkl/.gitignore b/tools/lkl/.gitignore
index 4e08254dbd46..1a8210f4d9c4 100644
--- a/tools/lkl/.gitignore
+++ b/tools/lkl/.gitignore
@@ -7,3 +7,5 @@ tests/disk
 tests/boot
 tests/valgrind*.xml
 *.pyc
+cptofs
+cpfromfs
diff --git a/tools/lkl/Build b/tools/lkl/Build
index e69de29bb2d1..a9d12c5ca260 100644
--- a/tools/lkl/Build
+++ b/tools/lkl/Build
@@ -0,0 +1,2 @@
+cptofs-$(LKL_HOST_CONFIG_ARCHIVE) += cptofs.o
+
diff --git a/tools/lkl/Makefile b/tools/lkl/Makefile
index 0abccb9d86b6..03750aab98d8 100644
--- a/tools/lkl/Makefile
+++ b/tools/lkl/Makefile
@@ -86,6 +86,9 @@ $(OUTPUT)%$(EXESUF): $(OUTPUT)%-in.o $(OUTPUT)liblkl.a
 $(OUTPUT)%-in.o: $(OUTPUT)lib/lkl.o FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
+$(OUTPUT)cpfromfs$(EXESUF): $(OUTPUT)cptofs$(EXESUF)
+	$(Q)if ! [ -e $@ ]; then ln -s $< $@; fi
+
 
 clean:
 	$(call QUIET_CLEAN, objects)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd'\
diff --git a/tools/lkl/Targets b/tools/lkl/Targets
index a9f74c3cc8fb..17de965f92b3 100644
--- a/tools/lkl/Targets
+++ b/tools/lkl/Targets
@@ -4,3 +4,7 @@ progs-y += tests/boot
 progs-y += tests/disk
 progs-y += tests/net-test
 
+progs-$(LKL_HOST_CONFIG_ARCHIVE) += cptofs
+progs-$(LKL_HOST_CONFIG_ARCHIVE) += cpfromfs
+LDLIBS_cptofs-y := -larchive
+LDLIBS_cptofs-$(LKL_HOST_CONFIG_NEEDS_LARGP) += -largp
diff --git a/tools/lkl/cptofs.c b/tools/lkl/cptofs.c
new file mode 100644
index 000000000000..fb34f570fa1e
--- /dev/null
+++ b/tools/lkl/cptofs.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef __FreeBSD__
+#include <sys/param.h>
+#endif
+
+#include <stdio.h>
+#include <time.h>
+#include <argp.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <libgen.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <fnmatch.h>
+#include <dirent.h>
+#include <lkl.h>
+#include <lkl_host.h>
+
+static const char doc_cptofs[] = "Copy files to a filesystem image";
+static const char doc_cpfromfs[] = "Copy files from a filesystem image";
+static const char args_doc_cptofs[] = "-t fstype -i fsimage path... fs_path";
+static const char args_doc_cpfromfs[] = "-t fstype -i fsimage fs_path... path";
+
+static struct argp_option options[] = {
+	{"enable-printk", 'p', 0, 0, "show Linux printks"},
+	{"partition", 'P', "int", 0, "partition number"},
+	{"filesystem-type", 't', "string", 0,
+	 "select filesystem type - mandatory"},
+	{"filesystem-image", 'i', "string", 0,
+	 "path to the filesystem image - mandatory"},
+	{"selinux", 's', "string", 0, "selinux attributes for destination"},
+	{0},
+};
+
+static struct cl_args {
+	int printk;
+	int part;
+	const char *fsimg_type;
+	const char *fsimg_path;
+	int npaths;
+	char **paths;
+	const char *selinux;
+} cla;
+
+static int cptofs;
+
+static error_t parse_opt(int key, char *arg, struct argp_state *state)
+{
+	struct cl_args *cla = state->input;
+
+	switch (key) {
+	case 'p':
+		cla->printk = 1;
+		break;
+	case 'P':
+		cla->part = atoi(arg);
+		break;
+	case 't':
+		cla->fsimg_type = arg;
+		break;
+	case 'i':
+		cla->fsimg_path = arg;
+		break;
+	case 's':
+		cla->selinux = arg;
+		break;
+	case ARGP_KEY_ARG:
+		// Capture all remaining arguments in our paths array and stop
+		// parsing here. We treat the last one as the destination and
+		// everything before it as sources, just like cp does.
+		cla->paths = &state->argv[state->next - 1];
+		cla->npaths = state->argc - state->next + 1;
+		state->next = state->argc;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static struct argp argp_cptofs = {
+	.options = options,
+	.parser = parse_opt,
+	.args_doc = args_doc_cptofs,
+	.doc = doc_cptofs,
+};
+
+static struct argp argp_cpfromfs = {
+	.options = options,
+	.parser = parse_opt,
+	.args_doc = args_doc_cpfromfs,
+	.doc = doc_cpfromfs,
+};
+
+static int searchdir(const char *fs_path, const char *path, const char *match);
+
+static int open_src(const char *path)
+{
+	int fd;
+
+	if (cptofs)
+		fd = open(path, O_RDONLY, 0);
+	else
+		fd = lkl_sys_open(path, LKL_O_RDONLY, 0);
+
+	if (fd < 0)
+		fprintf(stderr, "unable to open file %s for reading: %s\n",
+			path, cptofs ? strerror(errno) : lkl_strerror(fd));
+
+	return fd;
+}
+
+static int open_dst(const char *path, int mode)
+{
+	int fd;
+
+	if (cptofs)
+		fd = lkl_sys_open(path, LKL_O_RDWR | LKL_O_TRUNC | LKL_O_CREAT,
+				  mode);
+	else
+		fd = open(path, O_RDWR | O_TRUNC | O_CREAT, mode);
+
+	if (fd < 0)
+		fprintf(stderr, "unable to open file %s for writing: %s\n",
+			path, cptofs ? lkl_strerror(fd) : strerror(errno));
+
+	if (cla.selinux && cptofs) {
+		int ret = lkl_sys_fsetxattr(fd, "security.selinux", cla.selinux,
+					    strlen(cla.selinux), 0);
+		if (ret)
+			fprintf(stderr,
+				"unable to set selinux attribute on %s: %s\n",
+				path, lkl_strerror(ret));
+	}
+
+	return fd;
+}
+
+static int read_src(int fd, char *buf, int len)
+{
+	int ret;
+
+	if (cptofs)
+		ret = read(fd, buf, len);
+	else
+		ret = lkl_sys_read(fd, buf, len);
+
+	if (ret < 0)
+		fprintf(stderr, "error reading file: %s\n",
+			cptofs ? strerror(errno) : lkl_strerror(ret));
+
+	return ret;
+}
+
+static int write_dst(int fd, char *buf, int len)
+{
+	int ret;
+
+	if (cptofs)
+		ret = lkl_sys_write(fd, buf, len);
+	else
+		ret = write(fd, buf, len);
+
+	if (ret < 0)
+		fprintf(stderr, "error writing file: %s\n",
+			cptofs ? lkl_strerror(ret) : strerror(errno));
+
+	return ret;
+}
+
+static void close_src(int fd)
+{
+	if (cptofs)
+		close(fd);
+	else
+		lkl_sys_close(fd);
+}
+
+static void close_dst(int fd)
+{
+	if (cptofs)
+		lkl_sys_close(fd);
+	else
+		close(fd);
+}
+
+static int copy_file(const char *src, const char *dst, int mode)
+{
+	long len, to_write, wrote;
+	char buf[4096], *ptr;
+	int ret = 0;
+	int fd_src, fd_dst;
+
+	fd_src = open_src(src);
+	if (fd_src < 0)
+		return fd_src;
+
+	fd_dst = open_dst(dst, mode);
+	if (fd_dst < 0)
+		return fd_dst;
+
+	do {
+		len = read_src(fd_src, buf, sizeof(buf));
+
+		if (len > 0) {
+			ptr = buf;
+			to_write = len;
+			do {
+				wrote = write_dst(fd_dst, ptr, to_write);
+
+				if (wrote < 0) {
+					ret = wrote;
+					goto out;
+				}
+
+				to_write -= wrote;
+				ptr += len;
+
+			} while (to_write > 0);
+		}
+
+		if (len < 0)
+			ret = len;
+
+	} while (len > 0);
+
+out:
+	close_src(fd_src);
+	close_dst(fd_dst);
+
+	return ret;
+}
+
+static int stat_src(const char *path, unsigned int *type, unsigned int *mode,
+		    long long *size, struct lkl_timespec *mtime,
+		    struct lkl_timespec *atime)
+{
+	struct stat stat;
+	struct lkl_stat lkl_stat;
+	int ret;
+
+	if (cptofs) {
+		ret = lstat(path, &stat);
+		if (type)
+			*type = stat.st_mode & S_IFMT;
+		if (mode)
+			*mode = stat.st_mode & ~S_IFMT;
+		if (size)
+			*size = stat.st_size;
+		if (mtime) {
+			mtime->tv_sec = stat.st_mtim.tv_sec;
+			mtime->tv_nsec = stat.st_mtim.tv_nsec;
+		}
+		if (atime) {
+			atime->tv_sec = stat.st_atim.tv_sec;
+			atime->tv_nsec = stat.st_atim.tv_nsec;
+		}
+	} else {
+		ret = lkl_sys_lstat(path, &lkl_stat);
+		if (type)
+			*type = lkl_stat.st_mode & S_IFMT;
+		if (mode)
+			*mode = lkl_stat.st_mode & ~S_IFMT;
+		if (size)
+			*size = lkl_stat.st_size;
+		if (mtime) {
+			mtime->tv_sec = lkl_stat.lkl_st_mtime;
+			mtime->tv_nsec = lkl_stat.st_mtime_nsec;
+		}
+		if (atime) {
+			atime->tv_sec = lkl_stat.lkl_st_atime;
+			atime->tv_nsec = lkl_stat.st_atime_nsec;
+		}
+	}
+
+	if (ret)
+		fprintf(stderr, "fsimg lstat(%s) error: %s\n",
+			path, cptofs ? strerror(errno) : lkl_strerror(ret));
+
+	return ret;
+}
+
+static int mkdir_dst(const char *path, unsigned int mode)
+{
+	int ret;
+
+	if (cptofs) {
+		ret = lkl_sys_mkdir(path, mode);
+		if (ret == -LKL_EEXIST)
+			ret = 0;
+	} else {
+		ret = mkdir(path, mode);
+		if (ret < 0 && errno == EEXIST)
+			ret = 0;
+	}
+
+	if (ret)
+		fprintf(stderr, "unable to create directory %s: %s\n",
+			path, cptofs ? strerror(errno) : lkl_strerror(ret));
+
+	return ret;
+}
+
+static int readlink_src(const char *src, char *out, int outsize)
+{
+	int ret;
+
+	if (cptofs)
+		ret = readlink(src, out, outsize);
+	else
+		ret = lkl_sys_readlink(src, out, outsize);
+
+	if (ret < 0)
+		fprintf(stderr, "unable to readlink '%s': %s\n", src,
+			cptofs ? strerror(errno) : lkl_strerror(ret));
+
+	return ret;
+}
+
+static int symlink_dst(const char *path, const char *target)
+{
+	int ret;
+
+	if (cptofs)
+		ret = lkl_sys_symlink(target, path);
+	else
+		ret = symlink(target, path);
+
+	if (ret)
+		fprintf(stderr, "unable to symlink '%s' with target '%s': %s\n",
+			path, target, cptofs ? lkl_strerror(ret) :
+			strerror(errno));
+
+	return ret;
+}
+
+static int copy_symlink(const char *src, const char *dst)
+{
+	int ret;
+	long long size, actual_size;
+	char *target = NULL;
+
+	ret = stat_src(src, NULL, NULL, &size, NULL, NULL);
+	if (ret) {
+		ret = -1;
+		goto out;
+	}
+
+	target = malloc(size + 1);
+	if (!target) {
+		fprintf(stderr, "Unable to allocate memory (%lld bytes)\n",
+			size + 1);
+		ret = -1;
+		goto out;
+	}
+
+	actual_size = readlink_src(src, target, size);
+	if (actual_size != size) {
+		fprintf(stderr,
+			"readlink(%s) bad size: got %lld, expected %lld\n",
+			src, actual_size, size);
+		ret = -1;
+		goto out;
+	}
+	target[size] = 0; // readlink doesn't append the trailing null byte
+
+	ret = symlink_dst(dst, target);
+	if (ret)
+		ret = -1;
+
+out:
+	if (target)
+		free(target);
+
+	return ret;
+}
+
+static int do_entry(const char *_src, const char *_dst, const char *name)
+{
+	char src[PATH_MAX], dst[PATH_MAX];
+	struct lkl_timespec mtime, atime;
+	unsigned int type, mode;
+	int ret;
+
+	snprintf(src, sizeof(src), "%s/%s", _src, name);
+	snprintf(dst, sizeof(dst), "%s/%s", _dst, name);
+
+	ret = stat_src(src, &type, &mode, NULL, &mtime, &atime);
+
+	switch (type) {
+	case S_IFREG:
+	{
+		ret = copy_file(src, dst, mode);
+		break;
+	}
+	case S_IFDIR:
+		ret = mkdir_dst(dst, mode);
+		if (ret)
+			break;
+		ret = searchdir(src, dst, NULL);
+		break;
+	case S_IFLNK:
+		ret = copy_symlink(src, dst);
+		break;
+	case S_IFSOCK:
+	case S_IFBLK:
+	case S_IFCHR:
+	case S_IFIFO:
+	default:
+		printf("skipping %s: unsupported entry type %d\n", src, type);
+	}
+
+	if (!ret) {
+		if (cptofs) {
+			struct lkl_timespec lkl_ts[] = { atime, mtime };
+
+			ret = lkl_sys_utimensat(-1, dst,
+						(struct __lkl__kernel_timespec
+						 *)lkl_ts,
+						LKL_AT_SYMLINK_NOFOLLOW);
+		} else {
+			struct timespec ts[] = {
+				{ .tv_sec = atime.tv_sec,
+				  .tv_nsec = atime.tv_nsec, },
+				{ .tv_sec = mtime.tv_sec,
+				  .tv_nsec = mtime.tv_nsec, },
+			};
+
+			ret = utimensat(-1, dst, ts, AT_SYMLINK_NOFOLLOW);
+		}
+	}
+
+	if (ret)
+		printf("error processing entry %s, aborting\n", src);
+
+	return ret;
+}
+
+static DIR *open_dir(const char *path)
+{
+	DIR *dir;
+	int err;
+
+	if (cptofs)
+		dir = opendir(path);
+	else
+		dir = (DIR *)lkl_opendir(path, &err);
+
+	if (!dir)
+		fprintf(stderr, "unable to open directory %s: %s\n",
+			path, cptofs ? strerror(errno) : lkl_strerror(err));
+	return dir;
+}
+
+static const char *read_dir(DIR *dir, const char *path)
+{
+	struct lkl_dir *lkl_dir = (struct lkl_dir *)dir;
+	const char *name = NULL;
+	const char *err = NULL;
+
+	if (cptofs) {
+		struct dirent *de = readdir(dir);
+
+		if (de)
+			name = de->d_name;
+	} else {
+		struct lkl_linux_dirent64 *de = lkl_readdir(lkl_dir);
+
+		if (de)
+			name = de->d_name;
+	}
+
+	if (!name) {
+		if (cptofs) {
+			if (errno)
+				err = strerror(errno);
+		} else {
+			if (lkl_errdir(lkl_dir))
+				err = lkl_strerror(lkl_errdir(lkl_dir));
+		}
+	}
+
+	if (err)
+		fprintf(stderr, "error while reading directory %s: %s\n",
+			path, err);
+	return name;
+}
+
+static void close_dir(DIR *dir)
+{
+	if (cptofs)
+		closedir(dir);
+	else
+		lkl_closedir((struct lkl_dir *)dir);
+}
+
+static int searchdir(const char *src, const char *dst, const char *match)
+{
+	DIR *dir;
+	const char *name;
+	int ret = 0;
+
+	dir = open_dir(src);
+	if (!dir)
+		return -1;
+
+	while ((name = read_dir(dir, src))) {
+		if (!strcmp(name, ".") || !strcmp(name, "..") ||
+		    (match && fnmatch(match, name, 0) != 0))
+			continue;
+
+		ret = do_entry(src, dst, name);
+		if (ret)
+			goto out;
+	}
+
+out:
+	close_dir(dir);
+
+	return ret;
+}
+
+static int match_root(const char *src)
+{
+	const char *c = src;
+
+	while (*c) {
+		switch (*c) {
+		case '.':
+			if (c > src && c[-1] == '.')
+				return 0;
+			break;
+		case '/':
+			break;
+		default:
+			return 0;
+		}
+		c++;
+	}
+
+	return 1;
+}
+
+int copy_one(const char *src, const char *mpoint, const char *dst)
+{
+	char *src_path_dir, *src_path_base;
+	char src_path[PATH_MAX], dst_path[PATH_MAX];
+
+	if (cptofs) {
+		snprintf(src_path, sizeof(src_path),  "%s", src);
+		snprintf(dst_path, sizeof(dst_path),  "%s/%s", mpoint, dst);
+	} else {
+		snprintf(src_path, sizeof(src_path),  "%s/%s", mpoint, src);
+		snprintf(dst_path, sizeof(dst_path),  "%s", dst);
+	}
+
+	if (match_root(src))
+		return searchdir(src_path, dst, NULL);
+
+	src_path_dir = dirname(strdup(src_path));
+	src_path_base = basename(strdup(src_path));
+
+	return searchdir(src_path_dir, dst_path, src_path_base);
+}
+
+int main(int argc, char **argv)
+{
+	struct lkl_disk disk;
+	long ret, umount_ret;
+	int i;
+	char mpoint[32];
+	unsigned int disk_id;
+
+	if (strstr(argv[0], "cptofs")) {
+		cptofs = 1;
+		ret = argp_parse(&argp_cptofs, argc, argv, 0, 0, &cla);
+	} else {
+		ret = argp_parse(&argp_cpfromfs, argc, argv, 0, 0, &cla);
+	}
+
+	if (ret < 0)
+		return -1;
+
+	if (!cla.printk)
+		lkl_host_ops.print = NULL;
+
+	disk.fd = open(cla.fsimg_path, cptofs ? O_RDWR : O_RDONLY);
+	if (disk.fd < 0) {
+		fprintf(stderr, "can't open fsimg %s: %s\n", cla.fsimg_path,
+			strerror(errno));
+		ret = 1;
+		goto out;
+	}
+
+	disk.ops = NULL;
+	disk.dev = (char *)cla.fsimg_path;
+
+	ret = lkl_disk_add(&disk);
+	if (ret < 0) {
+		fprintf(stderr, "can't add disk: %s\n", lkl_strerror(ret));
+		goto out_close;
+	}
+	disk_id = ret;
+
+	lkl_start_kernel(&lkl_host_ops, "mem=100M");
+
+	ret = lkl_mount_dev(disk_id, cla.part, cla.fsimg_type,
+			    cptofs ? 0 : LKL_MS_RDONLY,
+			    NULL, mpoint, sizeof(mpoint));
+	if (ret) {
+		fprintf(stderr, "can't mount disk: %s\n", lkl_strerror(ret));
+		goto out_close;
+	}
+
+	lkl_sys_umask(0);
+
+	for (i = 0; i < cla.npaths - 1; i++) {
+		ret = copy_one(cla.paths[i], mpoint, cla.paths[cla.npaths - 1]);
+		if (ret)
+			break;
+	}
+
+	umount_ret = lkl_umount_dev(disk_id, cla.part, 0, 1000);
+	if (ret == 0)
+		ret = umount_ret;
+
+out_close:
+	close(disk.fd);
+
+out:
+	lkl_sys_halt();
+
+	return ret;
+}
-- 
2.21.0 (Apple Git-122.2)

