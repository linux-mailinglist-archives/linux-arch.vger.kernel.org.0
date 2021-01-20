Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49892FC800
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 03:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbhATCaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 21:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732091AbhATC36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824AC061786
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:18 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 15so14224207pgx.7
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukFLi8SfHH7JOTF6uMoOouc4W0jUZNKodiX01WqC/74=;
        b=TNoaCocqfS4WyF6nQ7iy4vs3sXGccQ9c6lMYhv8jyNbhFNG382FTAk3EDWXcBTBRk5
         BJv4Z+3ecqX7nxaMaV5SxmQ75eOEieCxKwWB/BpAfmJ+UBTZ9sJYJuAyUNqXw45Dvg4n
         rp9mmy3hwjvyXIGu5cHs1JMp9HDcnj8Pa1xyJLK66PgZIrsQ2x8sKXBP/F/Oqs4Ua3mu
         S6OYJawr8aLQpQTQxecgLV6bAEvN3d7yOry2JTl3FmODIdMDqQIPTpH++fPE0aVoccpc
         v11RRHVTmmnbPL1cdOmgnR21zcgOTNqRYZY8qYJbtzPvI2A1uX5Nt9tiJTVrj3OZW13p
         scZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukFLi8SfHH7JOTF6uMoOouc4W0jUZNKodiX01WqC/74=;
        b=ubHAZoPrGo8ReDldvjO4C+6U4cE9O3mFmgcvPh0aSV15XniSPtxEXaOTFKYUPSeEiF
         5A3qGxdLeVOEla+yMkydfDpdGnyoQOnJP+vbmUn9fdOscSnLXW0BjSCiCFF8GMVvLX9Z
         Vrr4mKyQdTXxuWtC3IGKzCEDUBHOvpogmww5qTqqd/NHXrFkVaNaf1T1qqFUo9Ub2EBR
         puxlIhSipfr/2XQCnlL8gqSw9+f9743QeRFs9+FPpBOFqNGOO97W1O2ddGIZeg46zjiZ
         EA48ZriuDrskxYZqddFDYwzvM8ffszNbqBQtmlg1sKTM6uQERg79+y15p10od2Qj52Wf
         6sIA==
X-Gm-Message-State: AOAM531mFlvEDpUH0B4HifUWQ54o/nMsKLef7IIYgUgz5fDLWhTnFOO2
        r8ojIxnDlVMpGKqJ7YUSCis=
X-Google-Smtp-Source: ABdhPJxs9RK1WykVJEXo1OUadMoHgqYGDgiSVBzyArFPsX0sU7mpum/trJUIQGICH1sRIL5fExYNlQ==
X-Received: by 2002:a65:6290:: with SMTP id f16mr7233977pgv.69.1611109757529;
        Tue, 19 Jan 2021 18:29:17 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id d10sm361880pfn.218.2021.01.19.18.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:29:16 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id E54EE20442D3B5; Wed, 20 Jan 2021 11:29:14 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 14/20] um: lkl: plug in the build system
Date:   Wed, 20 Jan 2021 11:27:19 +0900
Message-Id: <b5383a51016b2369ab5cf2a7d883ae00c0e4498b.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Basic Makefiles for building library of library mode. Add a new
architecture specific target for installing the resulting library files
and headers.

To make LKL binaries build, we can specify the SUBARCH name as "lkl"
to switch the output file of build: kernel (default), or library
(library mode).  Those modes are not able to be ON at the same time.

To build on library mode, users do the following:

  make defconfig ARCH=um SUBARCH=lkl
  make ARCH=um SUBARCH=lkl

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile              | 27 +++++++++----
 arch/um/configs/lkl_defconfig | 73 +++++++++++++++++++++++++++++++++++
 arch/um/kernel/Makefile       | 14 ++++---
 arch/um/lkl/um/Makefile       |  4 ++
 tools/um/Makefile             |  3 +-
 tools/um/Targets              |  3 ++
 6 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 arch/um/configs/lkl_defconfig
 create mode 100644 arch/um/lkl/um/Makefile

diff --git a/arch/um/Makefile b/arch/um/Makefile
index bce0cccae085..6ddc900604a5 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -34,6 +34,10 @@ ifneq ($(filter $(SUBARCH),x86 x86_64 i386),)
 	HEADER_ARCH := x86
 endif
 
+ifeq ($(SUBARCH),lkl)
+	HEADER_ARCH := um/lkl
+endif
+
 ifdef CONFIG_64BIT
 	KBUILD_CFLAGS += -mcmodel=large
 endif
@@ -97,19 +101,27 @@ KBUILD_CFLAGS += $(KERNEL_DEFINES)
 LDFLAGS_vmlinux += -r
 
 INSTALL_PATH=$(objtree)/tools/um
-all: linux
-pre-2nd: linux.o
-	@echo "  INSTALL $(INSTALL_PATH)/lib/$<"
-	@mkdir -p $(INSTALL_PATH)/lib/
-	@cp $< $(INSTALL_PATH)/lib/
+ifeq ($(CONFIG_UMMODE_LIB),y)
+all: pre-2nd
+	$(Q)$(MAKE) -C $(srctree)/tools/um
 
-PHONY += linux.o
+pre-2nd: linux.o um_headers_install
+
+else
+all: linux
 
 linux: pre-2nd
 	$(Q)$(MAKE) -C $(srctree)/tools/um
 	$(Q)cp $(objtree)/tools/um/uml/linux $(objtree)/
 	$(Q)cp $(objtree)/linux $(objtree)/vmlinux
 
+pre-2nd: linux.o
+endif
+	@echo "  INSTALL $(INSTALL_PATH)/lib/$<"
+	@mkdir -p $(INSTALL_PATH)/lib/
+	@cp $< $(INSTALL_PATH)/lib/
+
+PHONY += linux.o
 linux.o: vmlinux
 #revert vmlinux file from vmlinux.a
 ifneq ("$(wildcard vmlinux.a)","")
@@ -117,7 +129,8 @@ ifneq ("$(wildcard vmlinux.a)","")
 endif
 	$(Q)cp vmlinux vmlinux.a
 	@echo "  LINK    $@"
-	$(Q)$(OBJCOPY) -R .eh_frame $< $@
+# symbols in ipc/sem.c conflict with sem_init(3) etc, thus localize the kernel one.
+	$(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
 
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
diff --git a/arch/um/configs/lkl_defconfig b/arch/um/configs/lkl_defconfig
new file mode 100644
index 000000000000..7bea9e5b1b09
--- /dev/null
+++ b/arch/um/configs/lkl_defconfig
@@ -0,0 +1,73 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+# CONFIG_PID_NS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SLAB=y
+CONFIG_UMMODE_LIB=y
+CONFIG_HOSTFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_XTERM_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL_CHAN="pts"
+CONFIG_UML_SOUND=m
+CONFIG_UML_NET=y
+CONFIG_UML_NET_ETHERTAP=y
+CONFIG_UML_NET_TUNTAP=y
+CONFIG_UML_NET_SLIP=y
+CONFIG_UML_NET_DAEMON=y
+CONFIG_UML_NET_MCAST=y
+CONFIG_UML_NET_SLIRP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_IOSCHED_BFQ=m
+CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_IPV6 is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_UBD=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_DUMMY=m
+CONFIG_TUN=m
+CONFIG_PPP=m
+CONFIG_SLIP=m
+CONFIG_LEGACY_PTY_COUNT=32
+# CONFIG_HW_RANDOM is not set
+CONFIG_UML_RANDOM=y
+CONFIG_EXT4_FS=y
+CONFIG_REISERFS_FS=y
+CONFIG_BTRFS_FS=y
+CONFIG_QUOTA=y
+CONFIG_AUTOFS4_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_VFAT_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_RAID6_PQ_BENCHMARK is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_FRAME_WARN=1024
+CONFIG_DEBUG_KERNEL=y
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 9b63831a69e1..781c39b21403 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -14,17 +14,21 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
 			$(LDS_EXTRA)
 extra-y := vmlinux.lds
 
-obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
-	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o skas/
+obj-y = config.o exitcode.o irq.o ksyms.o \
+	process.o reboot.o sigio.o \
+	signal.o syscall.o time.o \
+	um_arch.o umid.o maccess.o kmsg_dump.o
+
+ifndef CONFIG_UMMODE_LIB
+obj-y += exec.o mem.o physmem.o ptrace.o sysrq.o tlb.o trap.o skas/
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-y += user_syms.o
+obj-$(CONFIG_MMU) += user_syms.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/lkl/um/Makefile b/arch/um/lkl/um/Makefile
new file mode 100644
index 000000000000..b29b598a1bac
--- /dev/null
+++ b/arch/um/lkl/um/Makefile
@@ -0,0 +1,4 @@
+include/generated/user_constants.h: $(srctree)/arch/um/lkl/um/user_constants.h
+	$(Q)cp -f $^ $@
+
+obj-y = bootmem.o console.o cpu.o delay.o setup.o syscalls.o threads.o unimplemented.o
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 0fdf77261e74..877d0bdefa67 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -32,6 +32,7 @@ export CFLAGS += -I$(OUTPUT)/include -Iinclude -Wall -g -O2 -Wextra -fPIC \
 	 -Wno-unused-parameter \
 	 -Wno-missing-field-initializers -fno-strict-aliasing
 
+-include $(OUTPUT)/../../include/config/auto.conf
 -include Targets
 
 TARGETS := $(progs-y:%=$(OUTPUT)%)
@@ -69,6 +70,6 @@ clean:
 	$(call QUIET_CLEAN, $(TARGETS))$(RM) $(TARGETS)
 
 FORCE: ;
-.PHONY: all clean FORCE
+.PHONY: all clean FORCE $(OUTPUT)/../../include/config/auto.conf
 .IGNORE: clean
 .NOTPARALLEL : lib/linux.o
diff --git a/tools/um/Targets b/tools/um/Targets
index cfe1d3c3c6ff..e8b43c7758fe 100644
--- a/tools/um/Targets
+++ b/tools/um/Targets
@@ -1,4 +1,7 @@
+ifneq ($(CONFIG_UMMODE_LIB),y)
 progs-y += uml/linux
+endif
+
 LDLIBS_linux-y := -lrt -lpthread -lutil
 LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 LDFLAGS_linux-$(CONFIG_STATIC_LINK) += -static
-- 
2.21.0 (Apple Git-122.2)

