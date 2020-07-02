Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6E2125BB
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgGBOKh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgGBOKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:10:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550FC08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:10:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so2095361pjh.5
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jZ9ucJgzaGJcve8HRFfOBpWerNPZMEPqCmMEElR9RU=;
        b=NaD5BkqyYvLFDn6GNoITIlinCqAz4KdOBUlUnKK5XFK+7P2KPDQZWQQPeZaqoPcT7s
         6vgsjF+jljkD9Yo+azElq6MCeDCxAI0y584BkJZ5fTM7tY6rkP+2+sG/MO9v6b817JEN
         IPxKeiqpJi/07vRdBmym9xWZC5kIR/OABGQyC8gjRWmPwf61aE55bgBBTzF4KzjZGKUu
         E27CJo9/UGoORSDNuHtD93eRsrfGoCDKru1ZMgL2VLfRdnvEjhT552izxcGYFxZtdscX
         OoReCHWEuRRQtbTKATtdhEMuIyJyvyNqPZPDGFct0eUlzT8nHF8gQPIfRNDayOhmj/hT
         K0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jZ9ucJgzaGJcve8HRFfOBpWerNPZMEPqCmMEElR9RU=;
        b=tdrMjuAIkeFHmtwBSWeYXdx1YqCU7VowRGU+DxVgi/md1cucJ6P1kip1NREDQiHgEA
         v1IXHj44Qmr09xdNQlvDIvttQ+XebAMof934JWxP+YmkKT0aBHU2yvI09I2wLyqQwjz7
         boWI0nQE+RUOIlld3N8hIj48OO76MneZSdiseUVvzc/LS7ii2tFEX9+Di2djieIfp21/
         aTfARzfv45oZaSwgzt6+YWFRzrx5Leb0QStd1VXYr1px9AOnUJvIMXyEFK5sxtRs+QU9
         WIT00ncYnFIBVhWnxDZI+qTPCn6ERmzVDi0iYXxPhH8iTDoyiPfv2grr5VW9ZP1KGuZg
         I1Jg==
X-Gm-Message-State: AOAM533EJLcFvoG8tuq2KwjpMZDWEU2MYUI2yB1kl5FfcT18GRDje9rz
        Zu/rpRCt1dOhp+4s1hs9vaA=
X-Google-Smtp-Source: ABdhPJwdU5ryu3jMiLa0NptKkIlCe5ZzDV+Iff9JbWh347n3CkRJFUOzXISUqAvkUzV4J1vIkS9u5Q==
X-Received: by 2002:a17:902:bcc1:: with SMTP id o1mr26159060pls.246.1593699035178;
        Thu, 02 Jul 2020 07:10:35 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id b4sm8187655pjn.38.2020.07.02.07.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:10:34 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 735B6202D31D9B; Thu,  2 Jul 2020 23:10:32 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 21/21] um: nommu: add block device support of UML
Date:   Thu,  2 Jul 2020 23:07:15 +0900
Message-Id: <b6eab5512a8168bbb46a485e9386e8cbd812b511.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds block device support for nommu mode, and also added
several host utilities to run a simple test program
(tools/um/test/disk.c) successfully.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/xor.h                 |   3 +-
 arch/um/include/shared/as-layout.h        |   1 +
 arch/um/kernel/um_arch.c                  |   5 +
 arch/um/nommu/include/uapi/asm/host_ops.h |   7 +
 arch/um/nommu/include/uapi/asm/unistd.h   |   2 +
 arch/um/nommu/um/Kconfig                  |   8 +
 arch/um/nommu/um/setup.c                  |  12 +
 tools/um/Targets                          |   2 +
 tools/um/include/lkl.h                    | 206 ++++++++++
 tools/um/include/lkl_host.h               |   1 +
 tools/um/lib/Build                        |   1 +
 tools/um/lib/fs.c                         | 461 ++++++++++++++++++++++
 tools/um/lib/posix-host.c                 |   1 +
 tools/um/lib/utils.c                      |   3 +
 tools/um/tests/Build                      |   1 +
 tools/um/tests/cla.c                      | 159 ++++++++
 tools/um/tests/cla.h                      |  33 ++
 tools/um/tests/disk.c                     | 168 ++++++++
 tools/um/tests/disk.sh                    |  70 ++++
 tools/um/tests/run.py                     |   2 +
 20 files changed, 1145 insertions(+), 1 deletion(-)
 create mode 100644 tools/um/lib/fs.c
 create mode 100644 tools/um/tests/cla.c
 create mode 100644 tools/um/tests/cla.h
 create mode 100644 tools/um/tests/disk.c
 create mode 100755 tools/um/tests/disk.sh

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 36b33d62a35d..a5ea458a1ae9 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -4,4 +4,5 @@
 
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
+	(time_travel_mode == TT_MODE_INFCPU || (!IS_ENABLED(CONFIG_MMU)) ? \
+	 &xor_block_8regs : NULL)
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 5f286ef2721b..4423437a5ace 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -57,6 +57,7 @@ extern unsigned long host_task_size;
 
 extern int linux_main(int argc, char **argv);
 extern void uml_finishsetup(void);
+extern void uml_set_args(char *args);
 
 struct siginfo;
 extern void (*sig_info[])(int, struct siginfo *si, struct uml_pt_regs *);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 78d6042fd2e6..ed0149821518 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -42,6 +42,11 @@ static void __init add_arg(char *arg)
 	strcat(command_line, arg);
 }
 
+void __init uml_set_args(char *args)
+{
+	strcat(command_line, args);
+}
+
 /*
  * These fields are initialized at boot time and not changed.
  * XXX This structure is used only in the non-SMP case.  Maybe this
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 0811494c080c..1b2507502969 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -15,6 +15,11 @@ struct lkl_jmp_buf {
  *
  * These operations must be provided by a host library or by the application
  * itself.
+ *
+ * @um_devices - string containg the list of UML devices in command line
+ * format. This string is appended to the kernel command line and
+ * is provided here for convenience to be implemented by the host library.
+ *
  * @print - optional operation that receives console messages
  * @panic - called during a kernel panic
  *
@@ -65,6 +70,8 @@ struct lkl_jmp_buf {
  *
  */
 struct lkl_host_operations {
+	const char *um_devices;
+
 	void (*print)(const char *str, int len);
 	void (*panic)(void);
 
diff --git a/arch/um/nommu/include/uapi/asm/unistd.h b/arch/um/nommu/include/uapi/asm/unistd.h
index 1762ebb829f5..320762099a62 100644
--- a/arch/um/nommu/include/uapi/asm/unistd.h
+++ b/arch/um/nommu/include/uapi/asm/unistd.h
@@ -3,6 +3,8 @@
 #define __UM_NOMMU_UAPI_UNISTD_H
 
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+
 #include <asm/bitsperlong.h>
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/um/nommu/um/Kconfig b/arch/um/nommu/um/Kconfig
index 20b3eaccb6f0..c6a3f472fe75 100644
--- a/arch/um/nommu/um/Kconfig
+++ b/arch/um/nommu/um/Kconfig
@@ -4,6 +4,10 @@ config UML_NOMMU
 	select UACCESS_MEMCPY
 	select ARCH_THREAD_STACK_ALLOCATOR
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select VFAT_FS
+	select NLS_CODEPAGE_437
+	select NLS_ISO8859_1
+	select BTRFS_FS
 
 config 64BIT
 	bool
@@ -35,3 +39,7 @@ config STACKTRACE_SUPPORT
 config PRINTK_TIME
 	bool
 	default y
+
+config RAID6_PQ_BENCHMARK
+	bool
+	default n
diff --git a/arch/um/nommu/um/setup.c b/arch/um/nommu/um/setup.c
index f74baea50bd3..6b49bf7a99fb 100644
--- a/arch/um/nommu/um/setup.c
+++ b/arch/um/nommu/um/setup.c
@@ -45,13 +45,25 @@ static void __init *lkl_run_kernel(void *arg)
 	return NULL;
 }
 
+static char _cmd_line[COMMAND_LINE_SIZE];
 int __init lkl_start_kernel(struct lkl_host_operations *ops,
 			    const char *fmt, ...)
 {
+	va_list ap;
 	int ret;
 
 	lkl_ops = ops;
 
+	va_start(ap, fmt);
+	ret = vsnprintf(_cmd_line, COMMAND_LINE_SIZE, fmt, ap);
+	va_end(ap);
+
+	if (ops->um_devices)
+		strscpy(_cmd_line + ret, ops->um_devices,
+			COMMAND_LINE_SIZE - ret);
+
+	uml_set_args(_cmd_line);
+
 	init_sem = lkl_ops->sem_alloc(0);
 	if (!init_sem)
 		return -ENOMEM;
diff --git a/tools/um/Targets b/tools/um/Targets
index 2bb90381843c..f5f8ec4b9dbb 100644
--- a/tools/um/Targets
+++ b/tools/um/Targets
@@ -1,10 +1,12 @@
 ifeq ($(UMMODE),library)
 progs-y += tests/boot
+progs-y += tests/disk
 else
 progs-y += uml/linux
 endif
 
 LDFLAGS_boot-y := -pie
+LDFLAGS_disk-y := -pie
 
 LDLIBS := -lrt -lpthread -lutil
 LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff --git a/tools/um/include/lkl.h b/tools/um/include/lkl.h
index 707e01b64a70..4a9d874bfbf0 100644
--- a/tools/um/include/lkl.h
+++ b/tools/um/include/lkl.h
@@ -113,6 +113,16 @@ static inline long lkl_sys_creat(const char *file, int mode)
 }
 #endif
 
+#ifdef __lkl__NR_faccessat
+/**
+ * lkl_sys_access - wrapper for lkl_sys_faccessat
+ */
+static inline long lkl_sys_access(const char *file, int mode)
+{
+	return lkl_sys_faccessat(LKL_AT_FDCWD, file, mode);
+}
+#endif
+
 #ifdef __lkl__NR_mkdirat
 /**
  * lkl_sys_mkdir - wrapper for lkl_sys_mkdirat
@@ -123,6 +133,36 @@ static inline long lkl_sys_mkdir(const char *path, mode_t mode)
 }
 #endif
 
+#ifdef __lkl__NR_unlinkat
+/**
+ * lkl_sys_rmdir - wrapper for lkl_sys_unlinkrat
+ */
+static inline long lkl_sys_rmdir(const char *path)
+{
+	return lkl_sys_unlinkat(LKL_AT_FDCWD, path, LKL_AT_REMOVEDIR);
+}
+#endif
+
+#ifdef __lkl__NR_unlinkat
+/**
+ * lkl_sys_unlink - wrapper for lkl_sys_unlinkat
+ */
+static inline long lkl_sys_unlink(const char *path)
+{
+	return lkl_sys_unlinkat(LKL_AT_FDCWD, path, 0);
+}
+#endif
+
+#ifdef __lkl__NR_mknodat
+/**
+ * lkl_sys_mknod - wrapper for lkl_sys_mknodat
+ */
+static inline long lkl_sys_mknod(const char *path, mode_t mode, dev_t dev)
+{
+	return lkl_sys_mknodat(LKL_AT_FDCWD, path, mode, dev);
+}
+#endif
+
 #ifdef __lkl__NR_epoll_create1
 /**
  * lkl_sys_epoll_create - wrapper for lkl_sys_epoll_create1
@@ -144,6 +184,172 @@ static inline long lkl_sys_epoll_wait(int fd, struct lkl_epoll_event *ev,
 }
 #endif
 
+/**
+ * struct lkl_dev_blk_ops - block device host operations, defined in lkl_host.h.
+ */
+struct lkl_dev_blk_ops;
+
+/**
+ * lkl_disk - host disk handle
+ *
+ * @dev - a pointer to private information for this disk backend
+ * @fd - a POSIX file descriptor that can be used by preadv/pwritev
+ * @handle - an NT file handle that can be used by ReadFile/WriteFile
+ */
+struct lkl_disk {
+	void *dev;
+	union {
+		int fd;
+		void *handle;
+	};
+	struct lkl_dev_blk_ops *ops;
+};
+
+/**
+ * lkl_disk_add - add a new disk
+ *
+ * @disk - the host disk handle
+ * @returns a disk id (0 is valid) or a strictly negative value in case of error
+ */
+int lkl_disk_add(struct lkl_disk *disk);
+
+/**
+ * lkl_disk_remove - remove a disk
+ *
+ * This function makes a cleanup of the @disk's private information
+ * that was initialized by lkl_disk_add before.
+ *
+ * @disk - the host disk handle
+ */
+int lkl_disk_remove(struct lkl_disk disk);
+
+/**
+ * lkl_encode_dev_from_sysfs_blkdev - extract device id from sysfs
+ *
+ * This function returns the device id for the given sysfs dev node.
+ * The content of the node has to be in the form 'MAJOR:MINOR'.
+ * Also, this function expects an absolute path which means that sysfs
+ * already has to be mounted at the given path
+ *
+ * @sysfs_path - absolute path to the sysfs dev node
+ * @pdevid - pointer to memory where dev id will be returned
+ * @returns - 0 on success, a negative value on error
+ */
+int lkl_encode_dev_from_sysfs(const char *sysfs_path, uint32_t *pdevid);
+
+/**
+ * lkl_mount_dev - mount a disk
+ *
+ * This functions creates a device file for the given disk, creates a mount
+ * point and mounts the device over the mount point.
+ *
+ * @disk_id - the disk id identifying the disk to be mounted
+ * @part - disk partition or zero for full disk
+ * @fs_type - filesystem type
+ * @flags - mount flags
+ * @opts - additional filesystem specific mount options
+ * @mnt_str - a string that will be filled by this function with the path where
+ * the filesystem has been mounted
+ * @mnt_str_len - size of mnt_str
+ * @returns - 0 on success, a negative value on error
+ */
+long lkl_mount_dev(unsigned int disk_id, unsigned int part, const char *fs_type,
+		   int flags, const char *opts,
+		   char *mnt_str, unsigned int mnt_str_len);
+
+/**
+ * lkl_umount_dev - umount a disk
+ *
+ * This functions umounts the given disks and removes the device file and the
+ * mount point.
+ *
+ * @disk_id - the disk id identifying the disk to be mounted
+ * @part - disk partition or zero for full disk
+ * @flags - umount flags
+ * @timeout_ms - timeout to wait for the kernel to flush closed files so that
+ * umount can succeed
+ * @returns - 0 on success, a negative value on error
+ */
+long lkl_umount_dev(unsigned int disk_id, unsigned int part, int flags,
+		    long timeout_ms);
+
+/**
+ * lkl_umount_timeout - umount filesystem with timeout
+ *
+ * @path - the path to unmount
+ * @flags - umount flags
+ * @timeout_ms - timeout to wait for the kernel to flush closed files so that
+ * umount can succeed
+ * @returns - 0 on success, a negative value on error
+ */
+long lkl_umount_timeout(char *path, int flags, long timeout_ms);
+
+/**
+ * lkl_opendir - open a directory
+ *
+ * @path - directory path
+ * @err - pointer to store the error in case of failure
+ * @returns - a handle to be used when calling lkl_readdir
+ */
+struct lkl_dir *lkl_opendir(const char *path, int *err);
+
+/**
+ * lkl_fdopendir - open a directory
+ *
+ * @fd - file descriptor
+ * @err - pointer to store the error in case of failure
+ * @returns - a handle to be used when calling lkl_readdir
+ */
+struct lkl_dir *lkl_fdopendir(int fd, int *err);
+
+/**
+ * lkl_rewinddir - reset directory stream
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ */
+void lkl_rewinddir(struct lkl_dir *dir);
+
+/**
+ * lkl_closedir - close the directory
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ */
+int lkl_closedir(struct lkl_dir *dir);
+
+/**
+ * lkl_readdir - get the next available entry of the directory
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ * @returns - a lkl_dirent64 entry or NULL if the end of the directory stream is
+ * reached or if an error occurred; check lkl_errdir() to distinguish between
+ * errors or end of the directory stream
+ */
+struct lkl_linux_dirent64 *lkl_readdir(struct lkl_dir *dir);
+
+/**
+ * lkl_errdir - checks if an error occurred during the last lkl_readdir call
+ *
+ * @dir - the directory handler as returned by lkl_opendir
+ * @returns - 0 if no error occurred, or a negative value otherwise
+ */
+int lkl_errdir(struct lkl_dir *dir);
+
+/**
+ * lkl_dirfd - gets the file descriptor associated with the directory handle
+ *
+ * @dir - the directory handle as returned by lkl_opendir
+ * @returns - a positive value,which is the LKL file descriptor associated with
+ * the directory handle, or a negative value otherwise
+ */
+int lkl_dirfd(struct lkl_dir *dir);
+
+/**
+ * lkl_mount_fs - mount a file system type like proc, sys
+ * @fstype - file system type. e.g. proc, sys
+ * @returns - 0 on success. 1 if it's already mounted. negative on failure.
+ */
+int lkl_mount_fs(char *fstype);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/tools/um/include/lkl_host.h b/tools/um/include/lkl_host.h
index 85e80eb4ad0d..12dd95616e43 100644
--- a/tools/um/include/lkl_host.h
+++ b/tools/um/include/lkl_host.h
@@ -10,6 +10,7 @@ extern "C" {
 #include <lkl.h>
 
 extern struct lkl_host_operations lkl_host_ops;
+extern char lkl_um_devs[4096];
 
 /**
  * lkl_printf - print a message via the host print operation
diff --git a/tools/um/lib/Build b/tools/um/lib/Build
index dddff26a3b4e..29491b40746c 100644
--- a/tools/um/lib/Build
+++ b/tools/um/lib/Build
@@ -4,3 +4,4 @@ CFLAGS_posix-host.o += -D_FILE_OFFSET_BITS=64
 liblinux-$(CONFIG_UMMODE_LIB) += utils.o
 liblinux-$(CONFIG_UMMODE_LIB) += posix-host.o
 liblinux-$(CONFIG_UMMODE_LIB) += jmp_buf.o
+liblinux-$(CONFIG_UMMODE_LIB) += fs.o
diff --git a/tools/um/lib/fs.c b/tools/um/lib/fs.c
new file mode 100644
index 000000000000..948aac9730c2
--- /dev/null
+++ b/tools/um/lib/fs.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <lkl_host.h>
+
+#define MAX_FSTYPE_LEN 50
+
+static struct lkl_disk *lkl_disks[16];
+static int registered_blk_dev_idx;
+
+static int lkl_disk_um_add(struct lkl_disk *disk, const char *blkparams)
+{
+	/* concat strings */
+	snprintf(lkl_um_devs + strlen(lkl_um_devs), sizeof(lkl_um_devs),
+		 " ubd%d=%s", registered_blk_dev_idx, blkparams);
+
+	return registered_blk_dev_idx++;
+}
+
+int lkl_disk_add(struct lkl_disk *disk)
+{
+	int ret = -1;
+
+	ret = lkl_disk_um_add(disk, disk->dev);
+
+	lkl_disks[ret] = disk;
+
+	return ret;
+}
+
+int lkl_disk_remove(struct lkl_disk disk)
+{
+	/* FIXME */
+	return 0;
+}
+
+int lkl_mount_fs(char *fstype)
+{
+	char dir[MAX_FSTYPE_LEN+2] = "/";
+	int flags = 0, ret = 0;
+
+	strncat(dir, fstype, MAX_FSTYPE_LEN);
+
+	/* Create with regular umask */
+	ret = lkl_sys_mkdir(dir, 0xff);
+	if (ret && ret != -LKL_EEXIST) {
+		lkl_perror("mount_fs mkdir", ret);
+		return ret;
+	}
+
+	/* We have no use for nonzero flags right now */
+	ret = lkl_sys_mount("none", dir, fstype, flags, NULL);
+	if (ret && ret != -LKL_EBUSY) {
+		lkl_sys_rmdir(dir);
+		return ret;
+	}
+
+	if (ret == -LKL_EBUSY)
+		return 1;
+	return 0;
+}
+
+static uint32_t new_encode_dev(unsigned int major, unsigned int minor)
+{
+	return (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
+}
+
+static int startswith(const char *str, const char *pre)
+{
+	return strncmp(pre, str, strlen(pre)) == 0;
+}
+
+static int get_node_with_prefix(const char *path, const char *prefix,
+				char *result, unsigned int result_len)
+{
+	struct lkl_dir *dir = NULL;
+	struct lkl_linux_dirent64 *dirent;
+	int ret;
+
+	dir = lkl_opendir(path, &ret);
+	if (!dir)
+		return ret;
+
+	ret = -LKL_ENOENT;
+
+	while ((dirent = lkl_readdir(dir))) {
+		if (startswith(dirent->d_name, prefix)) {
+			if (strlen(dirent->d_name) + 1 > result_len) {
+				ret = -LKL_ENOMEM;
+				break;
+			}
+			memcpy(result, dirent->d_name, strlen(dirent->d_name));
+			result[strlen(dirent->d_name)] = '\0';
+			ret = 0;
+			break;
+		}
+	}
+
+	lkl_closedir(dir);
+
+	return ret;
+}
+
+int lkl_encode_dev_from_sysfs(const char *sysfs_path, uint32_t *pdevid)
+{
+	int ret;
+	long fd;
+	int major, minor;
+	char buf[16] = { 0, };
+	char *bufptr;
+
+	fd = lkl_sys_open(sysfs_path, LKL_O_RDONLY, 0);
+	if (fd < 0)
+		return fd;
+
+	ret = lkl_sys_read(fd, buf, sizeof(buf));
+	if (ret < 0)
+		goto out_close;
+
+	if (ret == sizeof(buf)) {
+		ret = -LKL_ENOBUFS;
+		goto out_close;
+	}
+
+	bufptr = strchr(buf, ':');
+	if (bufptr == NULL) {
+		ret = -LKL_EINVAL;
+		goto out_close;
+	}
+	bufptr[0] = '\0';
+	bufptr++;
+
+	major = atoi(buf);
+	minor = atoi(bufptr);
+
+	*pdevid = new_encode_dev(major, minor);
+	ret = 0;
+
+out_close:
+	lkl_sys_close(fd);
+
+	return ret;
+}
+
+#define SYSFS_DEV_UMBLK_CMDLINE_PATH \
+	"/sysfs/devices/platform/uml-blkdev.%d"
+
+struct abuf {
+	char *mem, *ptr;
+	unsigned int len;
+};
+
+static int snprintf_append(struct abuf *buf, const char *fmt, ...)
+{
+	int ret;
+	va_list args;
+
+	if (!buf->ptr)
+		buf->ptr = buf->mem;
+
+	va_start(args, fmt);
+	ret = vsnprintf(buf->ptr, buf->len - (buf->ptr - buf->mem), fmt, args);
+	va_end(args);
+
+	if (ret < 0 || (ret >= (int)(buf->len - (buf->ptr - buf->mem))))
+		return -LKL_ENOMEM;
+
+	buf->ptr += ret;
+
+	return 0;
+}
+
+static int __lkl_get_blkdev(int disk_id, unsigned int part, uint32_t *pdevid,
+			    const char *sysfs_path_fmt, const char *drv_prefix,
+			    const char *disk_prefix)
+{
+	char sysfs_path[LKL_PATH_MAX];
+	char drv_name[LKL_PATH_MAX];
+	char disk_name[LKL_PATH_MAX];
+	struct abuf sysfs_path_buf = {
+		.mem = sysfs_path,
+		.len = sizeof(sysfs_path),
+	};
+	int ret;
+
+	if (disk_id < 0)
+		return -LKL_EINVAL;
+
+	ret = lkl_mount_fs("sysfs");
+	if (ret < 0)
+		return ret;
+
+	ret = snprintf_append(&sysfs_path_buf, sysfs_path_fmt, disk_id);
+	if (ret)
+		return ret;
+
+	ret = get_node_with_prefix(sysfs_path, drv_prefix, drv_name,
+				   sizeof(drv_name));
+	if (ret)
+		return ret;
+
+	ret = snprintf_append(&sysfs_path_buf, "/%s/block", drv_name);
+	if (ret)
+		return ret;
+
+	ret = get_node_with_prefix(sysfs_path, disk_prefix, disk_name,
+				   sizeof(disk_name));
+	if (ret)
+		return ret;
+
+	if (!part)
+		ret = snprintf_append(&sysfs_path_buf, "/%s/dev", disk_name);
+	else
+		ret = snprintf_append(&sysfs_path_buf, "/%s/%s%d/dev",
+				      disk_name, disk_name, part);
+	if (ret)
+		return ret;
+
+	return lkl_encode_dev_from_sysfs(sysfs_path, pdevid);
+}
+
+int lkl_get_blkdev(int disk_id, unsigned int part, uint32_t *pdevid)
+{
+	char *fmt;
+
+	fmt = SYSFS_DEV_UMBLK_CMDLINE_PATH;
+	return __lkl_get_blkdev(disk_id, part, pdevid, fmt, "", "ubd");
+}
+
+long lkl_mount_dev(unsigned int disk_id, unsigned int part,
+		   const char *fs_type, int flags,
+		   const char *data, char *mnt_str, unsigned int mnt_str_len)
+{
+	char dev_str[] = { "/dev/xxxxxxxx" };
+	unsigned int dev;
+	int err;
+	char _data[4096]; /* FIXME: PAGE_SIZE is not exported by LKL */
+
+	if (mnt_str_len < sizeof(dev_str))
+		return -LKL_ENOMEM;
+
+	err = lkl_get_blkdev(disk_id, part, &dev);
+	if (err < 0)
+		return err;
+
+	snprintf(dev_str, sizeof(dev_str), "/dev/%08x", dev);
+	snprintf(mnt_str, mnt_str_len, "/mnt/%08x", dev);
+
+	err = lkl_sys_access("/dev", LKL_S_IRWXO);
+	if (err < 0) {
+		if (err == -LKL_ENOENT)
+			err = lkl_sys_mkdir("/dev", 0700);
+		if (err < 0)
+			return err;
+	}
+
+	err = lkl_sys_mknod(dev_str, LKL_S_IFBLK | 0600, dev);
+	if (err < 0)
+		return err;
+
+	err = lkl_sys_access("/mnt", LKL_S_IRWXO);
+	if (err < 0) {
+		if (err == -LKL_ENOENT)
+			err = lkl_sys_mkdir("/mnt", 0700);
+		if (err < 0)
+			return err;
+	}
+
+	err = lkl_sys_mkdir(mnt_str, 0700);
+	if (err < 0) {
+		lkl_sys_unlink(dev_str);
+		return err;
+	}
+
+	/* kernel always copies a full page */
+	if (data) {
+		strncpy(_data, data, sizeof(_data));
+		_data[sizeof(_data) - 1] = 0;
+	} else {
+		_data[0] = 0;
+	}
+
+	err = lkl_sys_mount(dev_str, mnt_str, (char *)fs_type, flags, _data);
+	if (err < 0) {
+		lkl_sys_unlink(dev_str);
+		lkl_sys_rmdir(mnt_str);
+		return err;
+	}
+
+	return 0;
+}
+
+long lkl_umount_timeout(char *path, int flags, long timeout_ms)
+{
+	long incr = 10000000; /* 10 ms */
+	struct lkl_timespec ts = {
+		.tv_sec = 0,
+		.tv_nsec = incr,
+	};
+	long err;
+
+	do {
+		err = lkl_sys_umount(path, flags);
+		if (err == -LKL_EBUSY) {
+			lkl_sys_nanosleep((struct __lkl__kernel_timespec *)&ts,
+					  NULL);
+			timeout_ms -= incr / 1000000;
+		}
+	} while (err == -LKL_EBUSY && timeout_ms > 0);
+
+	return err;
+}
+
+long lkl_umount_dev(unsigned int disk_id, unsigned int part, int flags,
+		    long timeout_ms)
+{
+	char dev_str[] = { "/dev/xxxxxxxx" };
+	char mnt_str[] = { "/mnt/xxxxxxxx" };
+	unsigned int dev;
+	int err;
+
+	err = lkl_get_blkdev(disk_id, part, &dev);
+	if (err < 0)
+		return err;
+
+	snprintf(dev_str, sizeof(dev_str), "/dev/%08x", dev);
+	snprintf(mnt_str, sizeof(mnt_str), "/mnt/%08x", dev);
+
+	err = lkl_umount_timeout(mnt_str, flags, timeout_ms);
+	if (err)
+		return err;
+
+	err = lkl_sys_unlink(dev_str);
+	if (err)
+		return err;
+
+	return lkl_sys_rmdir(mnt_str);
+}
+
+struct lkl_dir {
+	int fd;
+	char buf[1024];
+	char *pos;
+	int len;
+};
+
+static struct lkl_dir *lkl_dir_alloc(int *err)
+{
+	struct lkl_dir *dir = lkl_host_ops.mem_alloc(sizeof(struct lkl_dir));
+
+	if (!dir) {
+		*err = -LKL_ENOMEM;
+		return NULL;
+	}
+
+	dir->len = 0;
+	dir->pos = NULL;
+
+	return dir;
+}
+
+struct lkl_dir *lkl_opendir(const char *path, int *err)
+{
+	struct lkl_dir *dir = lkl_dir_alloc(err);
+
+	if (!dir) {
+		*err = -LKL_ENOMEM;
+		return NULL;
+	}
+
+	dir->fd = lkl_sys_open(path, LKL_O_RDONLY | LKL_O_DIRECTORY, 0);
+	if (dir->fd < 0) {
+		*err = dir->fd;
+		lkl_host_ops.mem_free(dir);
+		return NULL;
+	}
+
+	*err = 0;
+
+	return dir;
+}
+
+struct lkl_dir *lkl_fdopendir(int fd, int *err)
+{
+	struct lkl_dir *dir = lkl_dir_alloc(err);
+
+	if (!dir)
+		return NULL;
+
+	dir->fd = fd;
+
+	return dir;
+}
+
+void lkl_rewinddir(struct lkl_dir *dir)
+{
+	lkl_sys_lseek(dir->fd, 0, LKL_SEEK_SET);
+	dir->len = 0;
+	dir->pos = NULL;
+}
+
+int lkl_closedir(struct lkl_dir *dir)
+{
+	int ret;
+
+	ret = lkl_sys_close(dir->fd);
+	lkl_host_ops.mem_free(dir);
+
+	return ret;
+}
+
+struct lkl_linux_dirent64 *lkl_readdir(struct lkl_dir *dir)
+{
+	struct lkl_linux_dirent64 *de;
+
+	if (dir->len < 0)
+		return NULL;
+
+	if (!dir->pos || dir->pos - dir->buf >= dir->len)
+		goto read_buf;
+
+return_de:
+	de = (struct lkl_linux_dirent64 *)dir->pos;
+	dir->pos += de->d_reclen;
+
+	return de;
+
+read_buf:
+	dir->pos = NULL;
+	de = (struct lkl_linux_dirent64 *)dir->buf;
+	dir->len = lkl_sys_getdents64(dir->fd, de, sizeof(dir->buf));
+	if (dir->len <= 0)
+		return NULL;
+
+	dir->pos = dir->buf;
+	goto return_de;
+}
+
+int lkl_errdir(struct lkl_dir *dir)
+{
+	if (dir->len >= 0)
+		return 0;
+
+	return dir->len;
+}
+
+int lkl_dirfd(struct lkl_dir *dir)
+{
+	return dir->fd;
+}
+
+int lkl_set_fd_limit(unsigned int fd_limit)
+{
+	struct lkl_rlimit rlim = {
+		.rlim_cur = fd_limit,
+		.rlim_max = fd_limit,
+	};
+	return lkl_sys_setrlimit(LKL_RLIMIT_NOFILE, &rlim);
+}
diff --git a/tools/um/lib/posix-host.c b/tools/um/lib/posix-host.c
index b6b5b2902254..8fd88031bf2b 100644
--- a/tools/um/lib/posix-host.c
+++ b/tools/um/lib/posix-host.c
@@ -263,6 +263,7 @@ static void *tls_get(struct lkl_tls_key *key)
 }
 
 struct lkl_host_operations lkl_host_ops = {
+	.um_devices = lkl_um_devs,
 	.panic = panic,
 	.print = print,
 	.mem_alloc = (void *)malloc,
diff --git a/tools/um/lib/utils.c b/tools/um/lib/utils.c
index 4930479a8a35..ac65cd744a14 100644
--- a/tools/um/lib/utils.c
+++ b/tools/um/lib/utils.c
@@ -4,6 +4,9 @@
 #include <string.h>
 #include <lkl_host.h>
 
+/* XXX: find a better place */
+char lkl_um_devs[4096];
+
 static const char * const lkl_err_strings[] = {
 	"Success",
 	"Operation not permitted",
diff --git a/tools/um/tests/Build b/tools/um/tests/Build
index 26a607f90dc8..b62919cadc50 100644
--- a/tools/um/tests/Build
+++ b/tools/um/tests/Build
@@ -1 +1,2 @@
 boot-y += boot.o test.o
+disk-y += disk.o test.o cla.o
diff --git a/tools/um/tests/cla.c b/tools/um/tests/cla.c
new file mode 100644
index 000000000000..694e3a3822be
--- /dev/null
+++ b/tools/um/tests/cla.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#ifdef __MINGW32__
+#include <winsock2.h>
+#else
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#endif
+
+#include "cla.h"
+
+static int cl_arg_parse_bool(struct cl_arg *arg, const char *value)
+{
+	*((int *)arg->store) = 1;
+	return 0;
+}
+
+static int cl_arg_parse_str(struct cl_arg *arg, const char *value)
+{
+	*((const char **)arg->store) = value;
+	return 0;
+}
+
+static int cl_arg_parse_int(struct cl_arg *arg, const char *value)
+{
+	errno = 0;
+	*((int *)arg->store) = strtol(value, NULL, 0);
+	return errno == 0;
+}
+
+static int cl_arg_parse_str_set(struct cl_arg *arg, const char *value)
+{
+	const char **set = arg->set;
+	int i;
+
+	for (i = 0; set[i] != NULL; i++) {
+		if (strcmp(set[i], value) == 0) {
+			*((int *)arg->store) = i;
+			return 0;
+		}
+	}
+
+	return (-1);
+}
+
+static int cl_arg_parse_ipv4(struct cl_arg *arg, const char *value)
+{
+	unsigned int addr;
+
+	if (!value)
+		return (-1);
+
+	addr = inet_addr(value);
+	if (addr == INADDR_NONE)
+		return (-1);
+	*((unsigned int *)arg->store) = addr;
+	return 0;
+}
+
+static cl_arg_parser_t parsers[] = {
+	[CL_ARG_BOOL] = cl_arg_parse_bool,
+	[CL_ARG_INT] = cl_arg_parse_int,
+	[CL_ARG_STR] = cl_arg_parse_str,
+	[CL_ARG_STR_SET] = cl_arg_parse_str_set,
+	[CL_ARG_IPV4] = cl_arg_parse_ipv4,
+};
+
+static struct cl_arg *find_short_arg(char name, struct cl_arg *args)
+{
+	struct cl_arg *arg;
+
+	for (arg = args; arg->short_name != 0; arg++) {
+		if (arg->short_name == name)
+			return arg;
+	}
+
+	return NULL;
+}
+
+static struct cl_arg *find_long_arg(const char *name, struct cl_arg *args)
+{
+	struct cl_arg *arg;
+
+	for (arg = args; arg->long_name; arg++) {
+		if (strcmp(arg->long_name, name) == 0)
+			return arg;
+	}
+
+	return NULL;
+}
+
+static void print_help(struct cl_arg *args)
+{
+	struct cl_arg *arg;
+
+	fprintf(stderr, "usage:\n");
+	for (arg = args; arg->long_name; arg++) {
+		fprintf(stderr, "-%c, --%-20s %s", arg->short_name,
+			arg->long_name, arg->help);
+		if (arg->type == CL_ARG_STR_SET) {
+			const char **set = arg->set;
+
+			fprintf(stderr, " [ ");
+			while (*set != NULL)
+				fprintf(stderr, "%s ", *(set++));
+			fprintf(stderr, "]");
+		}
+		fprintf(stderr, "\n");
+	}
+}
+
+int cla_parse_args(int argc, const char **argv, struct cl_arg *args)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		struct cl_arg *arg = NULL;
+		cl_arg_parser_t parser;
+
+		if (argv[i][0] == '-') {
+			if (argv[i][1] != '-')
+				arg = find_short_arg(argv[i][1], args);
+			else
+				arg = find_long_arg(&argv[i][2], args);
+		}
+
+		if (!arg) {
+			fprintf(stderr, "unknown option '%s'\n", argv[i]);
+			print_help(args);
+			return (-1);
+		}
+
+		if (arg->type == CL_ARG_USER || arg->type >= CL_ARG_END)
+			parser = arg->parser;
+		else
+			parser = parsers[arg->type];
+
+		if (!parser) {
+			fprintf(stderr, "can't parse --'%s'/-'%c'\n",
+				arg->long_name, args->short_name);
+			return (-1);
+		}
+
+		if (parser(arg, argv[i + 1]) < 0) {
+			fprintf(stderr, "can't parse '%s'\n", argv[i]);
+			print_help(args);
+			return (-1);
+		}
+
+		if (arg->has_arg)
+			i++;
+	}
+
+	return 0;
+}
diff --git a/tools/um/tests/cla.h b/tools/um/tests/cla.h
new file mode 100644
index 000000000000..3d879233681f
--- /dev/null
+++ b/tools/um/tests/cla.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LKL_TEST_CLA_H
+#define _LKL_TEST_CLA_H
+
+enum cl_arg_type {
+	CL_ARG_USER = 0,
+	CL_ARG_BOOL,
+	CL_ARG_INT,
+	CL_ARG_STR,
+	CL_ARG_STR_SET,
+	CL_ARG_IPV4,
+	CL_ARG_END,
+};
+
+struct cl_arg;
+
+typedef int (*cl_arg_parser_t)(struct cl_arg *arg, const char *value);
+
+struct cl_arg {
+	const char *long_name;
+	char short_name;
+	const char *help;
+	int has_arg;
+	enum cl_arg_type type;
+	void *store;
+	void *set;
+	cl_arg_parser_t parser;
+};
+
+int cla_parse_args(int argc, const char **argv, struct cl_arg *args);
+
+
+#endif /* _LKL_TEST_CLA_H */
diff --git a/tools/um/tests/disk.c b/tools/um/tests/disk.c
new file mode 100644
index 000000000000..325934935e6a
--- /dev/null
+++ b/tools/um/tests/disk.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <time.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <lkl.h>
+#include <lkl_host.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+
+#include "test.h"
+#include "cla.h"
+
+static struct {
+	int printk;
+	const char *disk;
+	const char *fstype;
+	int partition;
+} cla;
+
+struct cl_arg args[] = {
+	{"disk", 'd', "disk file to use", 1, CL_ARG_STR, &cla.disk},
+	{"partition", 'P', "partition to mount", 1, CL_ARG_INT, &cla.partition},
+	{"type", 't', "filesystem type", 1, CL_ARG_STR, &cla.fstype},
+	{0},
+};
+
+
+static struct lkl_disk disk;
+static int disk_id = -1;
+
+int lkl_test_disk_add(void)
+{
+	disk.fd = open(cla.disk, O_RDWR);
+	if (disk.fd < 0)
+		goto out_unlink;
+
+	disk.ops = NULL;
+	disk.dev = (char *)cla.disk;
+
+	disk_id = lkl_disk_add(&disk);
+	if (disk_id < 0)
+		goto out_close;
+
+	goto out;
+
+out_close:
+	close(disk.fd);
+
+out_unlink:
+	unlink(cla.disk);
+
+out:
+	lkl_test_logf("disk fd/handle %x disk_id %d", disk.fd, disk_id);
+
+	if (disk_id >= 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+int lkl_test_disk_remove(void)
+{
+	int ret;
+
+	ret = lkl_disk_remove(disk);
+
+	close(disk.fd);
+
+	if (ret == 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+
+static char mnt_point[32];
+
+LKL_TEST_CALL(mount_dev, lkl_mount_dev, 0, disk_id, cla.partition, cla.fstype,
+	      0, NULL, mnt_point, sizeof(mnt_point))
+
+static int lkl_test_umount_dev(void)
+{
+	long ret, ret2;
+
+	ret = lkl_sys_chdir("/");
+
+	ret2 = lkl_umount_dev(disk_id, cla.partition, 0, 1000);
+
+	lkl_test_logf("%ld %ld", ret, ret2);
+
+	if (!ret && !ret2)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+struct lkl_dir *dir;
+
+static int lkl_test_opendir(void)
+{
+	int err;
+
+	dir = lkl_opendir(mnt_point, &err);
+
+	lkl_test_logf("lkl_opedir(%s) = %d %s\n", mnt_point, err,
+		      lkl_strerror(err));
+
+	if (err == 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+static int lkl_test_readdir(void)
+{
+	struct lkl_linux_dirent64 *de = lkl_readdir(dir);
+	int wr = 0;
+
+	while (de) {
+		wr += lkl_test_logf("%s ", de->d_name);
+		if (wr >= 70) {
+			lkl_test_logf("\n");
+			wr = 0;
+			break;
+		}
+		de = lkl_readdir(dir);
+	}
+
+	if (lkl_errdir(dir) == 0)
+		return TEST_SUCCESS;
+
+	return TEST_FAILURE;
+}
+
+LKL_TEST_CALL(closedir, lkl_closedir, 0, dir);
+LKL_TEST_CALL(chdir_mnt_point, lkl_sys_chdir, 0, mnt_point);
+LKL_TEST_CALL(start_kernel, lkl_start_kernel, 0, &lkl_host_ops,
+	     "mem=16M loglevel=8");
+LKL_TEST_CALL(stop_kernel, lkl_sys_halt, 0);
+
+struct lkl_test tests[] = {
+	LKL_TEST(disk_add),
+	LKL_TEST(start_kernel),
+	LKL_TEST(mount_dev),
+	LKL_TEST(chdir_mnt_point),
+	LKL_TEST(opendir),
+	LKL_TEST(readdir),
+	LKL_TEST(closedir),
+	LKL_TEST(umount_dev),
+	LKL_TEST(stop_kernel),
+	LKL_TEST(disk_remove),
+
+};
+
+int main(int argc, const char **argv)
+{
+	if (cla_parse_args(argc, argv, args) < 0)
+		return (-1);
+
+	lkl_host_ops.print = lkl_test_log;
+
+	return lkl_test_run(tests, sizeof(tests)/sizeof(struct lkl_test),
+			    "disk %s", cla.fstype);
+}
diff --git a/tools/um/tests/disk.sh b/tools/um/tests/disk.sh
new file mode 100755
index 000000000000..e2ec6cf69d4b
--- /dev/null
+++ b/tools/um/tests/disk.sh
@@ -0,0 +1,70 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+
+source $script_dir/test.sh
+
+function prepfs()
+{
+    set -e
+
+    file=`mktemp`
+
+    dd if=/dev/zero of=$file bs=1024 count=204800
+
+    yes | mkfs.$1 $file
+
+    if ! [ -z $ANDROID_WDIR ]; then
+        adb shell mkdir -p $ANDROID_WDIR
+        adb push $file $ANDROID_WDIR
+        rm $file
+        file=$ANDROID_WDIR/$(basename $file)
+    fi
+    if ! [ -z $BSD_WDIR ]; then
+        $MYSSH mkdir -p $BSD_WDIR
+        ssh_copy $file $BSD_WDIR
+        rm $file
+        file=$BSD_WDIR/$(basename $file)
+    fi
+
+    export_vars file
+}
+
+function cleanfs()
+{
+    set -e
+
+    if ! [ -z $ANDROID_WDIR ]; then
+        adb shell rm $1
+        adb shell rm $ANDROID_WDIR/disk
+    elif ! [ -z $BSD_WDIR ]; then
+        $MYSSH rm $1
+        $MYSSH rm $BSD_WDIR/disk
+    else
+        rm $1
+    fi
+}
+
+if [ "$1" = "-t" ]; then
+    shift
+    fstype=$1
+    shift
+fi
+
+if [ -z "$fstype" ]; then
+    fstype="ext4"
+fi
+
+if [ -z $(which mkfs.$fstype) ]; then
+    lkl_test_plan 0 "disk $fstype"
+    echo "no mkfs.$fstype command"
+    exit 0
+fi
+
+lkl_test_plan 1 "disk $fstype"
+lkl_test_run 1 prepfs $fstype
+lkl_test_exec $script_dir/disk -d $file -t $fstype $@
+lkl_test_plan 1 "disk $fstype"
+lkl_test_run 1 cleanfs $file
+
diff --git a/tools/um/tests/run.py b/tools/um/tests/run.py
index c96ede90b6ad..97d6dedc217c 100755
--- a/tools/um/tests/run.py
+++ b/tools/um/tests/run.py
@@ -50,6 +50,8 @@ mydir=os.path.dirname(os.path.realpath(__file__))
 
 tests = [
     'boot.sh',
+    'disk.sh -t ext4',
+    'disk.sh -t vfat',
 ]
 
 parser = argparse.ArgumentParser(description='LKL test runner')
-- 
2.21.0 (Apple Git-122.2)

