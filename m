Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753E7F3F17
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHFDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42128 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHFDH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id j12so3225214plt.9
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neIaeN5/owMgXMqvOFQW8nvUKJB7R4lxRO1n/5251YE=;
        b=TkuliFTfApWoEi15CMJtKZh7pGjZzR96KXluhC9c5LzCe4xA1LswMCj8wTzYUPkaGD
         OmnM1jT7+NfGND/0K5MiOgp3c8vxQ2aNflLVoStzVpC/BMnGO0iMoaQTiroe0l3vft7u
         7AOodXRs6OJQovVnvctSfcn4nGSm0ucdabc/jM60hSTEPDx6zeIajZXrct3OKgoszyM+
         C/RD3IZpvc1q5lHxvvcuMD2C1LOkRFpNspcydKreQ9V2gQWNWzL7y+hceqd/O59K75g5
         Ith8NTesLtD+ltVLBc71oH6NiG6/7rOU1m9QYGkTe/RRuHM7eUiwo8TmMwzkj8oJaGz4
         jCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neIaeN5/owMgXMqvOFQW8nvUKJB7R4lxRO1n/5251YE=;
        b=ndS7bONMyPJ5vb3WMai3JsLJYwB0XZ//k86zS/ktrJSpXppIXK0L6LWYpZjXnG3KVl
         1nsbxpAVkgJz4OxCin1HGoiCsqdKLVXxeTyAwuzrTyQBKky4AHVcOYw7/tYLdXcAhiNJ
         xeye7mzvemn4OmtTtr6IEURQN8abHMBQmeDW5d5k5A8C9SHKebM1MxlB/MFJ3UaLQAD0
         CY/5Hz9DXuUGQPg72rkY8SRBc04dbRiwvzrlF/yQ9kk60uCCM9WDi7/w1Z4oQs7Sjub3
         4xX+RiCEzsg4DMhsFr3kLiwDfh5ipUbnWJFB7MZEIGpZ9y6QL6RmENqpl/xwLYJgHxDA
         MPcg==
X-Gm-Message-State: APjAAAXe4e6UAnmoafE468Sjfrw/5DIOVnpGi3JgWzMEF46oIgb2cOHp
        nsjIzrFzpUd0TaB/ERPyfbONGnocl9fE+Q==
X-Google-Smtp-Source: APXvYqy7EiP+rAXiWk85GC06o/zZhJnmum9u7kIOesjRrMvKUPv78+7OAFyAhzrqbteU6OOf46p2Dw==
X-Received: by 2002:a17:90a:3526:: with SMTP id q35mr10739861pjb.1.1573189385858;
        Thu, 07 Nov 2019 21:03:05 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id b82sm4423118pfb.33.2019.11.07.21.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:03 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id A1484201ACFC46; Fri,  8 Nov 2019 14:03:01 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>,
        "Edison M . Castro" <edisonmcastro@hotmail.com>,
        Hajime Tazaki <thehajime@gmail.com>,
        Jens Staal <staal1978@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Levente Kurusa <levex@linux.com>,
        Luca Dariz <luca.dariz@gmail.com>,
        Mark Stillwell <mark@stillwell.me>,
        Matthieu Coudron <mattator@gmail.com>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>, Xiao Jia <xiaoj@google.com>,
        Yuan Liu <liuyuan@google.com>
Subject: [RFC v2 03/37] lkl: architecture skeleton for Linux kernel library
Date:   Fri,  8 Nov 2019 14:02:18 +0900
Message-Id: <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Adds the LKL Kconfig, vmlinux linker script, basic architecture
headers and miscellaneous basic functions or stubs such as
dump_stack(), show_regs() and cpuinfo proc ops.

The headers we introduce in this patch are simple wrappers to the
asm-generic headers or stubs for things we don't support, such as
ptrace, DMA, signals, ELF handling and low level processor operations.

The kernel configuration is automatically updated to reflect the
endianness of the host, 64bit support or the output format for
vmlinux's linker script. We do this by looking at the ld's default
output format.

Signed-off-by: Andreas Abel <aabel@google.com>
Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
Signed-off-by: Edison M. Castro <edisonmcastro@hotmail.com>
Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Jens Staal <staal1978@gmail.com>
Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Levente Kurusa <levex@linux.com>
Signed-off-by: Luca Dariz <luca.dariz@gmail.com>
Signed-off-by: Mark Stillwell <mark@stillwell.me>
Signed-off-by: Matthieu Coudron <mattator@gmail.com>
Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Petros Angelatos <petrosagg@gmail.com>
Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
Signed-off-by: Xiao Jia <xiaoj@google.com>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 MAINTAINERS                                |   8 +
 arch/um/lkl/.gitignore                     |   2 +
 arch/um/lkl/Kconfig                        |  95 ++++++
 arch/um/lkl/Kconfig.debug                  |   0
 arch/um/lkl/configs/lkl_defconfig          |  91 ++++++
 arch/um/lkl/include/asm/Kbuild             |  80 +++++
 arch/um/lkl/include/asm/bitsperlong.h      |  11 +
 arch/um/lkl/include/asm/byteorder.h        |   7 +
 arch/um/lkl/include/asm/cpu.h              |  14 +
 arch/um/lkl/include/asm/elf.h              |  15 +
 arch/um/lkl/include/asm/mutex.h            |   7 +
 arch/um/lkl/include/asm/processor.h        |  60 ++++
 arch/um/lkl/include/asm/ptrace.h           |  25 ++
 arch/um/lkl/include/asm/sched.h            |  23 ++
 arch/um/lkl/include/asm/syscalls.h         |  18 ++
 arch/um/lkl/include/asm/syscalls_32.h      |  43 +++
 arch/um/lkl/include/asm/tlb.h              |  12 +
 arch/um/lkl/include/asm/uaccess.h          |  64 ++++
 arch/um/lkl/include/asm/unistd_32.h        |  31 ++
 arch/um/lkl/include/asm/vmlinux.lds.h      |  14 +
 arch/um/lkl/include/asm/xor.h              |   9 +
 arch/um/lkl/include/uapi/asm/Kbuild        |   9 +
 arch/um/lkl/include/uapi/asm/bitsperlong.h |  13 +
 arch/um/lkl/include/uapi/asm/byteorder.h   |  11 +
 arch/um/lkl/include/uapi/asm/siginfo.h     |  11 +
 arch/um/lkl/include/uapi/asm/swab.h        |  11 +
 arch/um/lkl/include/uapi/asm/syscalls.h    | 348 +++++++++++++++++++++
 arch/um/lkl/kernel/asm-offsets.c           |   2 +
 arch/um/lkl/kernel/misc.c                  |  60 ++++
 arch/um/lkl/kernel/vmlinux.lds.S           |  51 +++
 30 files changed, 1145 insertions(+)
 create mode 100644 arch/um/lkl/.gitignore
 create mode 100644 arch/um/lkl/Kconfig
 create mode 100644 arch/um/lkl/Kconfig.debug
 create mode 100644 arch/um/lkl/configs/lkl_defconfig
 create mode 100644 arch/um/lkl/include/asm/Kbuild
 create mode 100644 arch/um/lkl/include/asm/bitsperlong.h
 create mode 100644 arch/um/lkl/include/asm/byteorder.h
 create mode 100644 arch/um/lkl/include/asm/cpu.h
 create mode 100644 arch/um/lkl/include/asm/elf.h
 create mode 100644 arch/um/lkl/include/asm/mutex.h
 create mode 100644 arch/um/lkl/include/asm/processor.h
 create mode 100644 arch/um/lkl/include/asm/ptrace.h
 create mode 100644 arch/um/lkl/include/asm/sched.h
 create mode 100644 arch/um/lkl/include/asm/syscalls.h
 create mode 100644 arch/um/lkl/include/asm/syscalls_32.h
 create mode 100644 arch/um/lkl/include/asm/tlb.h
 create mode 100644 arch/um/lkl/include/asm/uaccess.h
 create mode 100644 arch/um/lkl/include/asm/unistd_32.h
 create mode 100644 arch/um/lkl/include/asm/vmlinux.lds.h
 create mode 100644 arch/um/lkl/include/asm/xor.h
 create mode 100644 arch/um/lkl/include/uapi/asm/Kbuild
 create mode 100644 arch/um/lkl/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/um/lkl/include/uapi/asm/byteorder.h
 create mode 100644 arch/um/lkl/include/uapi/asm/siginfo.h
 create mode 100644 arch/um/lkl/include/uapi/asm/swab.h
 create mode 100644 arch/um/lkl/include/uapi/asm/syscalls.h
 create mode 100644 arch/um/lkl/kernel/asm-offsets.c
 create mode 100644 arch/um/lkl/kernel/misc.c
 create mode 100644 arch/um/lkl/kernel/vmlinux.lds.S

diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5210fd..df8151c6fd9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9369,6 +9369,14 @@ F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
 
+LINUX KERNEL LIBRARY
+M:	Octavian Purdila <tavi.purdila@gmail.com>
+M:	Hajime Tazaki <thehajime@gmail.com>
+L:	linux-kernel-library@freelists.org
+S:	Maintained
+F:	arch/um/lkl/
+F:	tools/lkl/
+
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
diff --git a/arch/um/lkl/.gitignore b/arch/um/lkl/.gitignore
new file mode 100644
index 000000000000..ced1c60d8235
--- /dev/null
+++ b/arch/um/lkl/.gitignore
@@ -0,0 +1,2 @@
+kernel/vmlinux.lds
+include/generated
diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
new file mode 100644
index 000000000000..1dae70f16c43
--- /dev/null
+++ b/arch/um/lkl/Kconfig
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config UML_LKL
+       def_bool y
+       depends on !SMP && !MMU && !COREDUMP && !SECCOMP && !UPROBES && !COMPAT && !USER_RETURN_NOTIFIER
+       select ARCH_THREAD_STACK_ALLOCATOR
+       select RWSEM_GENERIC_SPINLOCK
+       select GENERIC_ATOMIC64
+       select GENERIC_HWEIGHT
+       select FLATMEM
+       select FLAT_NODE_MEM_MAP
+       select GENERIC_CLOCKEVENTS
+       select GENERIC_CPU_DEVICES
+       select NO_HZ_IDLE
+       select NO_PREEMPT
+       select ARCH_WANT_FRAME_POINTERS
+       select HAS_DMA
+       select DMA_DIRECT_OPS
+       select PHYS_ADDR_T_64BIT if 64BIT
+       select 64BIT if "$(OUTPUT_FORMAT)" = "elf64-x86-64"
+       select 64BIT if "$(OUTPUT_FORMAT)" = "elf64-x86-64-freebsd"
+       select NET
+       select MULTIUSER
+       select INET
+       select IPV6
+       select IP_PNP
+       select IP_PNP_DHCP
+       select TCP_CONG_ADVANCED
+       select TCP_CONG_BBR
+       select HIGH_RES_TIMERS
+       select NET_SCHED
+       select NET_SCH_FQ
+       select IP_MULTICAST
+       select IPV6_MULTICAST
+       select IP_MULTIPLE_TABLES
+       select IPV6_MULTIPLE_TABLES
+       select IP_ROUTE_MULTIPATH
+       select IPV6_ROUTE_MULTIPATH
+       select IP_ADVANCED_ROUTER
+       select IPV6_ADVANCED_ROUTER
+       select ARCH_NO_COHERENT_DMA_MMAP
+       select HAVE_MEMBLOCK
+       select NO_BOOTMEM
+
+config OUTPUT_FORMAT
+       string "Output format"
+       default "$(OUTPUT_FORMAT)"
+
+config ARCH_DMA_ADDR_T_64BIT
+       def_bool 64BIT
+
+config 64BIT
+       def_bool n
+
+config COREDUMP
+       def_bool n
+
+config BIG_ENDIAN
+       def_bool n
+
+config GENERIC_CSUM
+       def_bool y
+
+config GENERIC_HWEIGHT
+       def_bool y
+
+config NO_IOPORT_MAP
+       def_bool y
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+
+config BTRFS_FS
+	tristate
+	default n
+
+config XFS_FS
+	tristate
+	default n
+
+config HZ
+        int
+        default 100
+
+config CONSOLE_LOGLEVEL_QUIET
+	int "quiet console loglevel (1-15)"
+	range 1 15
+	default "4"
+	help
+	  loglevel to use when "quiet" is passed on the kernel commandline.
+
+	  When "quiet" is passed on the kernel commandline this loglevel
+	  will be used as the loglevel. IOW passing "quiet" will be the
+	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
diff --git a/arch/um/lkl/Kconfig.debug b/arch/um/lkl/Kconfig.debug
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/um/lkl/configs/lkl_defconfig b/arch/um/lkl/configs/lkl_defconfig
new file mode 100644
index 000000000000..1a281480839b
--- /dev/null
+++ b/arch/um/lkl/configs/lkl_defconfig
@@ -0,0 +1,91 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_NO_HZ_IDLE=y
+# CONFIG_SYSFS_SYSCALL is not set
+CONFIG_KALLSYMS_USE_DATA_SECTION=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_AIO is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_NET=y
+CONFIG_INET=y
+# CONFIG_WIRELESS is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_VIRTIO_BLK=y
+CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
+# CONFIG_ETHERNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_VT is not set
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_VFAT_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_737=y
+CONFIG_NLS_CODEPAGE_775=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
+CONFIG_NLS_CODEPAGE_855=y
+CONFIG_NLS_CODEPAGE_857=y
+CONFIG_NLS_CODEPAGE_860=y
+CONFIG_NLS_CODEPAGE_861=y
+CONFIG_NLS_CODEPAGE_862=y
+CONFIG_NLS_CODEPAGE_863=y
+CONFIG_NLS_CODEPAGE_864=y
+CONFIG_NLS_CODEPAGE_865=y
+CONFIG_NLS_CODEPAGE_866=y
+CONFIG_NLS_CODEPAGE_869=y
+CONFIG_NLS_CODEPAGE_936=y
+CONFIG_NLS_CODEPAGE_950=y
+CONFIG_NLS_CODEPAGE_932=y
+CONFIG_NLS_CODEPAGE_949=y
+CONFIG_NLS_CODEPAGE_874=y
+CONFIG_NLS_ISO8859_8=y
+CONFIG_NLS_CODEPAGE_1250=y
+CONFIG_NLS_CODEPAGE_1251=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+CONFIG_NLS_ISO8859_3=y
+CONFIG_NLS_ISO8859_4=y
+CONFIG_NLS_ISO8859_5=y
+CONFIG_NLS_ISO8859_6=y
+CONFIG_NLS_ISO8859_7=y
+CONFIG_NLS_ISO8859_9=y
+CONFIG_NLS_ISO8859_13=y
+CONFIG_NLS_ISO8859_14=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_KOI8_R=y
+CONFIG_NLS_KOI8_U=y
+CONFIG_NLS_MAC_ROMAN=y
+CONFIG_NLS_MAC_CELTIC=y
+CONFIG_NLS_MAC_CENTEURO=y
+CONFIG_NLS_MAC_CROATIAN=y
+CONFIG_NLS_MAC_CYRILLIC=y
+CONFIG_NLS_MAC_GAELIC=y
+CONFIG_NLS_MAC_GREEK=y
+CONFIG_NLS_MAC_ICELAND=y
+CONFIG_NLS_MAC_INUIT=y
+CONFIG_NLS_MAC_ROMANIAN=y
+CONFIG_NLS_MAC_TURKISH=y
+CONFIG_NLS_UTF8=y
+CONFIG_HZ_100=y
+CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/um/lkl/include/asm/Kbuild b/arch/um/lkl/include/asm/Kbuild
new file mode 100644
index 000000000000..f6308985c61c
--- /dev/null
+++ b/arch/um/lkl/include/asm/Kbuild
@@ -0,0 +1,80 @@
+generic-y += atomic.h
+generic-y += barrier.h
+generic-y += bitops.h
+generic-y += bug.h
+generic-y += bugs.h
+generic-y += cache.h
+generic-y += cacheflush.h
+generic-y += checksum.h
+generic-y += cmpxchg-local.h
+generic-y += cmpxchg.h
+generic-y += compat.h
+generic-y += cputime.h
+generic-y += current.h
+generic-y += delay.h
+generic-y += device.h
+generic-y += div64.h
+generic-y += dma.h
+generic-y += dma-mapping.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += extable.h
+generic-y += exec.h
+generic-y += ftrace.h
+generic-y += futex.h
+generic-y += hardirq.h
+generic-y += hw_irq.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += irq_regs.h
+generic-y += irqflags.h
+generic-y += irq_work.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += linkage.h
+generic-y += local.h
+generic-y += local64.h
+generic-y += mcs_spinlock.h
+generic-y += mmiowb.h
+generic-y += mmu.h
+generic-y += mmu_context.h
+generic-y += module.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += parport.h
+generic-y += pci.h
+generic-y += percpu.h
+generic-y += pgalloc.h
+generic-y += poll.h
+generic-y += preempt.h
+generic-y += resource.h
+generic-y += rwsem.h
+generic-y += scatterlist.h
+generic-y += seccomp.h
+generic-y += sections.h
+generic-y += segment.h
+generic-y += sembuf.h
+generic-y += serial.h
+generic-y += shmbuf.h
+generic-y += signal.h
+generic-y += simd.h
+generic-y += sizes.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += string.h
+generic-y += swab.h
+generic-y += switch_to.h
+generic-y += syscall.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += time.h
+generic-y += timex.h
+generic-y += tlbflush.h
+generic-y += topology.h
+generic-y += trace_clock.h
+generic-y += unaligned.h
+generic-y += user.h
+generic-y += word-at-a-time.h
+generic-y += kprobes.h
diff --git a/arch/um/lkl/include/asm/bitsperlong.h b/arch/um/lkl/include/asm/bitsperlong.h
new file mode 100644
index 000000000000..5745d5e51274
--- /dev/null
+++ b/arch/um/lkl/include/asm/bitsperlong.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LKL_BITSPERLONG_H
+#define __LKL_BITSPERLONG_H
+
+#include <uapi/asm/bitsperlong.h>
+
+#define BITS_PER_LONG __BITS_PER_LONG
+
+#define BITS_PER_LONG_LONG 64
+
+#endif
diff --git a/arch/um/lkl/include/asm/byteorder.h b/arch/um/lkl/include/asm/byteorder.h
new file mode 100644
index 000000000000..5d0c4efaa44b
--- /dev/null
+++ b/arch/um/lkl/include/asm/byteorder.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_BYTEORDER_H
+#define _ASM_LKL_BYTEORDER_H
+
+#include <uapi/asm/byteorder.h>
+
+#endif /* _ASM_LKL_BYTEORDER_H */
diff --git a/arch/um/lkl/include/asm/cpu.h b/arch/um/lkl/include/asm/cpu.h
new file mode 100644
index 000000000000..d2b8c501c7b1
--- /dev/null
+++ b/arch/um/lkl/include/asm/cpu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_CPU_H
+#define _ASM_LKL_CPU_H
+
+int lkl_cpu_get(void);
+void lkl_cpu_put(void);
+int lkl_cpu_try_run_irq(int irq);
+int lkl_cpu_init(void);
+void lkl_cpu_shutdown(void);
+void lkl_cpu_wait_shutdown(void);
+void lkl_cpu_change_owner(lkl_thread_t owner);
+void lkl_cpu_set_irqs_pending(void);
+
+#endif /* _ASM_LKL_CPU_H */
diff --git a/arch/um/lkl/include/asm/elf.h b/arch/um/lkl/include/asm/elf.h
new file mode 100644
index 000000000000..bb2456d638f4
--- /dev/null
+++ b/arch/um/lkl/include/asm/elf.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_ELF_H
+#define _ASM_LKL_ELF_H
+
+#define elf_check_arch(x) 0
+
+#ifdef CONFIG_64BIT
+#define ELF_CLASS ELFCLASS64
+#else
+#define ELF_CLASS ELFCLASS32
+#endif
+
+#define elf_gregset_t long
+#define elf_fpregset_t double
+#endif
diff --git a/arch/um/lkl/include/asm/mutex.h b/arch/um/lkl/include/asm/mutex.h
new file mode 100644
index 000000000000..492d04183f9c
--- /dev/null
+++ b/arch/um/lkl/include/asm/mutex.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_MUTEX_H
+#define _ASM_LKL_MUTEX_H
+
+#include <asm-generic/mutex-dec.h>
+
+#endif
diff --git a/arch/um/lkl/include/asm/processor.h b/arch/um/lkl/include/asm/processor.h
new file mode 100644
index 000000000000..c1aa8b3a266e
--- /dev/null
+++ b/arch/um/lkl/include/asm/processor.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_PROCESSOR_H
+#define _ASM_LKL_PROCESSOR_H
+
+struct task_struct;
+
+static inline void cpu_relax(void)
+{
+	unsigned long flags;
+
+	/* since this is usually called in a tight loop waiting for some
+	 * external condition (e.g. jiffies) lets run interrupts now to allow
+	 * the external condition to propagate
+	 */
+	local_irq_save(flags);
+	local_irq_restore(flags);
+}
+
+#define current_text_addr() ({ __label__ _l; _l: &&_l; })
+
+static inline unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	return 0;
+}
+
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+static inline void prepare_to_copy(struct task_struct *tsk)
+{
+}
+
+static inline unsigned long get_wchan(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void flush_thread(void)
+{
+}
+
+static inline void trap_init(void)
+{
+}
+
+struct thread_struct { };
+
+#define INIT_THREAD { }
+
+#define task_pt_regs(tsk) (struct pt_regs *)(NULL)
+
+/* We don't have strict user/kernel spaces */
+#define TASK_SIZE ((unsigned long)-1)
+#define TASK_UNMAPPED_BASE 0
+
+#define KSTK_EIP(tsk) (0)
+#define KSTK_ESP(tsk) (0)
+
+#endif
diff --git a/arch/um/lkl/include/asm/ptrace.h b/arch/um/lkl/include/asm/ptrace.h
new file mode 100644
index 000000000000..28199be26dc0
--- /dev/null
+++ b/arch/um/lkl/include/asm/ptrace.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_PTRACE_H
+#define _ASM_LKL_PTRACE_H
+
+#include <linux/errno.h>
+
+struct task_struct;
+
+#define user_mode(regs) 0
+#define kernel_mode(regs) 1
+#define profile_pc(regs) 0
+#define instruction_pointer(regs) 0
+#define user_stack_pointer(regs) 0
+
+static inline long arch_ptrace(struct task_struct *child, long request,
+			       unsigned long addr, unsigned long data)
+{
+	return -EINVAL;
+}
+
+static inline void ptrace_disable(struct task_struct *child)
+{
+}
+
+#endif
diff --git a/arch/um/lkl/include/asm/sched.h b/arch/um/lkl/include/asm/sched.h
new file mode 100644
index 000000000000..4c2635921ec8
--- /dev/null
+++ b/arch/um/lkl/include/asm/sched.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_SCHED_H
+#define _ASM_LKL_SCHED_H
+
+#include <linux/sched.h>
+#include <uapi/asm/host_ops.h>
+
+static inline void thread_sched_jb(void)
+{
+	if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD)) {
+		set_ti_thread_flag(current_thread_info(), TIF_SCHED_JB);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		lkl_ops->jmp_buf_set(&current_thread_info()->sched_jb,
+				     schedule);
+	} else {
+		lkl_bug("%s() can be used only for host task\n", __func__);
+	}
+}
+
+void switch_to_host_task(struct task_struct *);
+int host_task_stub(void *unused);
+
+#endif /*  _ASM_LKL_SCHED_H */
diff --git a/arch/um/lkl/include/asm/syscalls.h b/arch/um/lkl/include/asm/syscalls.h
new file mode 100644
index 000000000000..2eaa870a9020
--- /dev/null
+++ b/arch/um/lkl/include/asm/syscalls.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_SYSCALLS_H
+#define _ASM_LKL_SYSCALLS_H
+
+int syscalls_init(void);
+void syscalls_cleanup(void);
+long lkl_syscall(long no, long *params);
+void wakeup_idle_host_task(void);
+
+#define sys_mmap sys_mmap_pgoff
+#define sys_mmap2 sys_mmap_pgoff
+#define sys_clone sys_ni_syscall
+#define sys_vfork sys_ni_syscall
+#define sys_rt_sigreturn sys_ni_syscall
+
+#include <asm-generic/syscalls.h>
+
+#endif /* _ASM_LKL_SYSCALLS_H */
diff --git a/arch/um/lkl/include/asm/syscalls_32.h b/arch/um/lkl/include/asm/syscalls_32.h
new file mode 100644
index 000000000000..0e1a7649c81b
--- /dev/null
+++ b/arch/um/lkl/include/asm/syscalls_32.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_SYSCALLS_32_H
+#define _ASM_SYSCALLS_32_H
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/signal.h>
+
+#if __BITS_PER_LONG == 32
+
+/* kernel/syscalls_32.c */
+asmlinkage long sys32_truncate64(const char __user *, unsigned long,
+				 unsigned long);
+asmlinkage long sys32_ftruncate64(unsigned int, unsigned long, unsigned long);
+
+#ifdef CONFIG_MMU
+struct mmap_arg_struct32;
+asmlinkage long sys32_mmap(struct mmap_arg_struct32 __user *);
+#endif
+
+asmlinkage long sys32_wait4(pid_t, unsigned int __user *, int,
+			    struct rusage __user *);
+
+asmlinkage long sys32_pread64(unsigned int, char __user *, u32, u32, u32);
+asmlinkage long sys32_pwrite64(unsigned int, const char __user *, u32, u32,
+			       u32);
+
+long sys32_fadvise64_64(int a, __u32 b, __u32 c, __u32 d, __u32 e, int f);
+
+asmlinkage ssize_t sys32_readahead(int, unsigned int, unsigned int, size_t);
+asmlinkage long sys32_sync_file_range(int, unsigned int, unsigned int,
+				      unsigned int, unsigned int, unsigned int);
+asmlinkage long sys32_sync_file_range2(int, unsigned int, unsigned int,
+				       unsigned int, unsigned int,
+				       unsigned int);
+asmlinkage long sys32_fadvise64(int, unsigned int, unsigned int, size_t, int);
+asmlinkage long sys32_fallocate(int, int, unsigned int, unsigned int,
+				unsigned int, unsigned int);
+
+#endif /* __BITS_PER_LONG */
+
+#endif /* _ASM_SYSCALLS_32_H */
diff --git a/arch/um/lkl/include/asm/tlb.h b/arch/um/lkl/include/asm/tlb.h
new file mode 100644
index 000000000000..d474890d317d
--- /dev/null
+++ b/arch/um/lkl/include/asm/tlb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_TLB_H
+#define _ASM_LKL_TLB_H
+
+#define tlb_start_vma(tlb, vma)				do { } while (0)
+#define tlb_end_vma(tlb, vma)				do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, pte, address)	do { } while (0)
+#define tlb_flush(tlb)					do { } while (0)
+
+#include <asm-generic/tlb.h>
+
+#endif /* _ASM_LKL_TLB_H */
diff --git a/arch/um/lkl/include/asm/uaccess.h b/arch/um/lkl/include/asm/uaccess.h
new file mode 100644
index 000000000000..f267ac3be8b3
--- /dev/null
+++ b/arch/um/lkl/include/asm/uaccess.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_UACCESS_H
+#define _ASM_LKL_UACCESS_H
+
+/* copied from old include/asm-generic/uaccess.h */
+static inline __must_check long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	if (__builtin_constant_p(n)) {
+		switch (n) {
+		case 1:
+			*(u8 *)to = *(u8 __force *)from;
+			return 0;
+		case 2:
+			*(u16 *)to = *(u16 __force *)from;
+			return 0;
+		case 4:
+			*(u32 *)to = *(u32 __force *)from;
+			return 0;
+#ifdef CONFIG_64BIT
+		case 8:
+			*(u64 *)to = *(u64 __force *)from;
+			return 0;
+#endif
+		default:
+			break;
+		}
+	}
+
+	memcpy(to, (const void __force *)from, n);
+	return 0;
+}
+
+static inline __must_check long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	if (__builtin_constant_p(n)) {
+		switch (n) {
+		case 1:
+			*(u8 __force *)to = *(u8 *)from;
+			return 0;
+		case 2:
+			*(u16 __force *)to = *(u16 *)from;
+			return 0;
+		case 4:
+			*(u32 __force *)to = *(u32 *)from;
+			return 0;
+#ifdef CONFIG_64BIT
+		case 8:
+			*(u64 __force *)to = *(u64 *)from;
+			return 0;
+#endif
+		default:
+			break;
+		}
+	}
+
+	memcpy((void __force *)to, from, n);
+	return 0;
+}
+
+#include <asm-generic/uaccess.h>
+
+#endif
diff --git a/arch/um/lkl/include/asm/unistd_32.h b/arch/um/lkl/include/asm/unistd_32.h
new file mode 100644
index 000000000000..8582a55e61e2
--- /dev/null
+++ b/arch/um/lkl/include/asm/unistd_32.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/bitsperlong.h>
+
+#ifndef __SYSCALL
+#define __SYSCALL(x, y)
+#endif
+
+#if __BITS_PER_LONG == 32
+__SYSCALL(__NR3264_truncate, sys32_truncate64)
+__SYSCALL(__NR3264_ftruncate, sys32_ftruncate64)
+
+#ifdef CONFIG_MMU
+__SYSCALL(__NR3264_mmap, sys32_mmap)
+#endif
+
+__SYSCALL(__NR_wait4, sys32_wait4)
+
+__SYSCALL(__NR_pread64, sys32_pread64)
+__SYSCALL(__NR_pwrite64, sys32_pwrite64)
+
+__SYSCALL(__NR_readahead, sys32_readahead)
+#ifdef __ARCH_WANT_SYNC_FILE_RANGE2
+__SYSCALL(__NR_sync_file_range2, sys32_sync_file_range2)
+#else
+__SYSCALL(__NR_sync_file_range, sys32_sync_file_range)
+#endif
+/* mm/fadvise.c */
+__SYSCALL(__NR3264_fadvise64, sys32_fadvise64_64)
+__SYSCALL(__NR_fallocate, sys32_fallocate)
+
+#endif
diff --git a/arch/um/lkl/include/asm/vmlinux.lds.h b/arch/um/lkl/include/asm/vmlinux.lds.h
new file mode 100644
index 000000000000..a3c285882dc4
--- /dev/null
+++ b/arch/um/lkl/include/asm/vmlinux.lds.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_VMLINUX_LDS_H
+#define _LKL_VMLINUX_LDS_H
+
+/* we encode our own __ro_after_init section */
+#define RO_AFTER_INIT_DATA
+
+#ifdef __MINGW32__
+#define RODATA_SECTION .rdata
+#endif
+
+#include <asm-generic/vmlinux.lds.h>
+
+#endif
diff --git a/arch/um/lkl/include/asm/xor.h b/arch/um/lkl/include/asm/xor.h
new file mode 100644
index 000000000000..286ce75b5d9d
--- /dev/null
+++ b/arch/um/lkl/include/asm/xor.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_XOR_H
+#define _ASM_LKL_XOR_H
+
+#include <asm-generic/xor.h>
+
+#define XOR_SELECT_TEMPLATE(x) (&xor_block_8regs)
+
+#endif /* _ASM_LKL_XOR_H */
diff --git a/arch/um/lkl/include/uapi/asm/Kbuild b/arch/um/lkl/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..39d9a1f2e8f5
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/Kbuild
@@ -0,0 +1,9 @@
+# UAPI Header export list
+
+generic-y += elf.h
+generic-y += kvm_para.h
+generic-y += shmparam.h
+generic-y += timex.h
+
+# no header-y since we need special user headers handling
+# see arch/lkl/script/headers.py
diff --git a/arch/um/lkl/include/uapi/asm/bitsperlong.h b/arch/um/lkl/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..8b4ebf2b0264
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_BITSPERLONG_H
+#define _ASM_UAPI_LKL_BITSPERLONG_H
+
+#ifdef CONFIG_64BIT
+#define __BITS_PER_LONG 64
+#else
+#define __BITS_PER_LONG 32
+#endif
+
+#define __ARCH_WANT_STAT64
+
+#endif /* _ASM_UAPI_LKL_BITSPERLONG_H */
diff --git a/arch/um/lkl/include/uapi/asm/byteorder.h b/arch/um/lkl/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..3c4a58d2062f
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/byteorder.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_BYTEORDER_H
+#define _ASM_UAPI_LKL_BYTEORDER_H
+
+#if defined(CONFIG_BIG_ENDIAN)
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#endif /* _ASM_UAPI_LKL_BYTEORDER_H */
diff --git a/arch/um/lkl/include/uapi/asm/siginfo.h b/arch/um/lkl/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..811916cf42c8
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/siginfo.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_LKL_SIGINFO_H
+#define _ASM_LKL_SIGINFO_H
+
+#ifdef CONFIG_64BIT
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#endif
+
+#include <asm-generic/siginfo.h>
+
+#endif /* _ASM_LKL_SIGINFO_H */
diff --git a/arch/um/lkl/include/uapi/asm/swab.h b/arch/um/lkl/include/uapi/asm/swab.h
new file mode 100644
index 000000000000..1a1773e1bd35
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/swab.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_LKL_SWAB_H
+#define _ASM_LKL_SWAB_H
+
+#ifndef __arch_swab32
+#define __arch_swab32(x) ___constant_swab32(x)
+#endif
+
+#include <asm-generic/swab.h>
+
+#endif /* _ASM_LKL_SWAB_H */
diff --git a/arch/um/lkl/include/uapi/asm/syscalls.h b/arch/um/lkl/include/uapi/asm/syscalls.h
new file mode 100644
index 000000000000..a81534ffccb7
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/syscalls.h
@@ -0,0 +1,348 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_SYSCALLS_H
+#define _ASM_UAPI_LKL_SYSCALLS_H
+
+#include <autoconf.h>
+#include <linux/types.h>
+
+typedef __kernel_uid32_t	qid_t;
+typedef __kernel_fd_set		fd_set;
+typedef __kernel_mode_t		mode_t;
+typedef unsigned short		umode_t;
+typedef __u32			nlink_t;
+typedef __kernel_off_t		off_t;
+typedef __kernel_pid_t		pid_t;
+typedef __kernel_key_t		key_t;
+typedef __kernel_suseconds_t	suseconds_t;
+typedef __kernel_timer_t	timer_t;
+typedef __kernel_clockid_t	clockid_t;
+typedef __kernel_mqd_t		mqd_t;
+typedef __kernel_uid32_t	uid_t;
+typedef __kernel_gid32_t	gid_t;
+typedef __kernel_uid16_t        uid16_t;
+typedef __kernel_gid16_t        gid16_t;
+typedef unsigned long		uintptr_t;
+#ifdef CONFIG_UID16
+typedef __kernel_old_uid_t	old_uid_t;
+typedef __kernel_old_gid_t	old_gid_t;
+#endif
+typedef __kernel_loff_t		loff_t;
+typedef __kernel_size_t		size_t;
+typedef __kernel_ssize_t	ssize_t;
+typedef __kernel_time_t		time_t;
+typedef __kernel_clock_t	clock_t;
+typedef __u32			u32;
+typedef __s32			s32;
+typedef __u64			u64;
+typedef __s64			s64;
+
+#define __user
+
+#include <asm/unistd.h>
+/* Temporary undefine system calls that don't have data types defined in UAPI
+ * headers
+ */
+#undef __NR_kexec_load
+#undef __NR_getcpu
+#undef __NR_sched_getattr
+#undef __NR_sched_setattr
+#undef __NR_sched_setparam
+#undef __NR_sched_getparam
+#undef __NR_sched_setscheduler
+#undef __NR_name_to_handle_at
+#undef __NR_open_by_handle_at
+
+/* deprecated system calls */
+#undef __NR_epoll_create
+#undef __NR_epoll_wait
+#undef __NR_access
+#undef __NR_chmod
+#undef __NR_chown
+#undef __NR_lchown
+#undef __NR_open
+#undef __NR_creat
+#undef __NR_readlink
+#undef __NR_pipe
+#undef __NR_mknod
+#undef __NR_mkdir
+#undef __NR_rmdir
+#undef __NR_unlink
+#undef __NR_symlink
+#undef __NR_link
+#undef __NR_rename
+#undef __NR_getdents
+#undef __NR_select
+#undef __NR_poll
+#undef __NR_dup2
+#undef __NR_futimesat
+#undef __NR_utimes
+#undef __NR_ustat
+#undef __NR_eventfd
+#undef __NR_bdflush
+#undef __NR_send
+#undef __NR_recv
+
+#undef __NR_umount
+#define __NR_umount __NR_umount2
+
+#ifdef CONFIG_64BIT
+#define __NR_newfstat __NR3264_fstat
+#define __NR_newfstatat __NR3264_fstatat
+#endif
+
+#define __NR_mmap_pgoff __NR3264_mmap
+
+#include <linux/time.h>
+#include <linux/times.h>
+#include <linux/timex.h>
+#include <linux/capability.h>
+#define __KERNEL__ /* to pull in S_ definitions */
+#include <linux/stat.h>
+#undef __KERNEL__
+#include <linux/errno.h>
+#include <linux/fcntl.h>
+#include <linux/fs.h>
+#include <asm/statfs.h>
+#include <asm/stat.h>
+#include <linux/bpf.h>
+#include <linux/msg.h>
+#include <linux/resource.h>
+#include <linux/sysinfo.h>
+#include <linux/shm.h>
+#include <linux/aio_abi.h>
+#include <linux/socket.h>
+#include <linux/perf_event.h>
+#include <linux/sem.h>
+#include <linux/futex.h>
+#include <linux/poll.h>
+#include <linux/mqueue.h>
+#include <linux/eventpoll.h>
+#include <linux/uio.h>
+#include <asm/signal.h>
+#include <asm/siginfo.h>
+#include <linux/utime.h>
+#include <asm/socket.h>
+#include <linux/icmp.h>
+#include <linux/ip.h>
+
+/* Define data structures used in system calls that are not defined in UAPI
+ * headers
+ */
+struct sockaddr {
+	unsigned short int sa_family;
+	char sa_data[14];
+};
+
+#define __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO 1
+#define __UAPI_DEF_IF_IFNAMSIZ	1
+#define __UAPI_DEF_IF_NET_DEVICE_FLAGS 1
+#define __UAPI_DEF_IF_IFREQ	1
+#define __UAPI_DEF_IF_IFMAP	1
+#include <linux/if.h>
+#define __UAPI_DEF_IN_IPPROTO	1
+#define __UAPI_DEF_IN_ADDR	1
+#define __UAPI_DEF_IN6_ADDR	1
+#define __UAPI_DEF_IP_MREQ	1
+#define __UAPI_DEF_IN_PKTINFO	1
+#define __UAPI_DEF_SOCKADDR_IN	1
+#define __UAPI_DEF_IN_CLASS	1
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/sockios.h>
+#include <linux/route.h>
+#include <linux/ipv6_route.h>
+#include <linux/ipv6.h>
+#include <linux/netlink.h>
+#include <linux/neighbour.h>
+#include <linux/rtnetlink.h>
+#include <linux/fib_rules.h>
+
+#include <linux/kdev_t.h>
+#include <asm/irq.h>
+#include <linux/virtio_blk.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ring.h>
+#include <linux/pkt_sched.h>
+#include <linux/io_uring.h>
+
+struct user_msghdr {
+	void		__user *msg_name;
+	int		msg_namelen;
+	struct iovec	__user *msg_iov;
+	__kernel_size_t	msg_iovlen;
+	void		__user *msg_control;
+	__kernel_size_t	msg_controllen;
+	unsigned int	msg_flags;
+};
+
+typedef __u32 key_serial_t;
+
+struct mmsghdr {
+	struct user_msghdr  msg_hdr;
+	unsigned int        msg_len;
+};
+
+struct linux_dirent64 {
+	u64		d_ino;
+	s64		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
+struct linux_dirent {
+	unsigned long	d_ino;
+	unsigned long	d_off;
+	unsigned short	d_reclen;
+	char		d_name[1];
+};
+
+struct ustat {
+	__kernel_daddr_t	f_tfree;
+	__kernel_ino_t		f_tinode;
+	char			f_fname[6];
+	char			f_fpack[6];
+};
+
+typedef __kernel_rwf_t		rwf_t;
+
+#define AF_UNSPEC       0
+#define AF_UNIX         1
+#define AF_LOCAL        1
+#define AF_INET         2
+#define AF_AX25         3
+#define AF_IPX          4
+#define AF_APPLETALK    5
+#define AF_NETROM       6
+#define AF_BRIDGE       7
+#define AF_ATMPVC       8
+#define AF_X25          9
+#define AF_INET6        10
+#define AF_ROSE         11
+#define AF_DECnet       12
+#define AF_NETBEUI      13
+#define AF_SECURITY     14
+#define AF_KEY          15
+#define AF_NETLINK      16
+#define AF_ROUTE        AF_NETLINK
+#define AF_PACKET       17
+#define AF_ASH          18
+#define AF_ECONET       19
+#define AF_ATMSVC       20
+#define AF_RDS          21
+#define AF_SNA          22
+#define AF_IRDA         23
+#define AF_PPPOX        24
+#define AF_WANPIPE      25
+#define AF_LLC          26
+#define AF_IB           27
+#define AF_MPLS         28
+#define AF_CAN          29
+#define AF_TIPC         30
+#define AF_BLUETOOTH    31
+#define AF_IUCV         32
+#define AF_RXRPC        33
+#define AF_ISDN         34
+#define AF_PHONET       35
+#define AF_IEEE802154   36
+#define AF_CAIF         37
+#define AF_ALG          38
+#define AF_NFC          39
+#define AF_VSOCK        40
+
+#define SOCK_STREAM		1
+#define SOCK_DGRAM		2
+#define SOCK_RAW		3
+#define SOCK_RDM		4
+#define SOCK_SEQPACKET		5
+#define SOCK_DCCP		6
+#define SOCK_PACKET		10
+
+#define MSG_TRUNC 0x20
+#define MSG_DONTWAIT 0x40
+
+/* avoid colision with system headers defines */
+#define sa_handler sa_handler
+#define st_atime st_atime
+#define st_mtime st_mtime
+#define st_ctime st_ctime
+#define s_addr s_addr
+
+long lkl_syscall(long no, long *params);
+long lkl_sys_halt(void);
+
+#define __MAP0(m, ...)
+#define __MAP1(m, t, a) m(t, a)
+#define __MAP2(m, t, a, ...) m(t, a), __MAP1(m, __VA_ARGS__)
+#define __MAP3(m, t, a, ...) m(t, a), __MAP2(m, __VA_ARGS__)
+#define __MAP4(m, t, a, ...) m(t, a), __MAP3(m, __VA_ARGS__)
+#define __MAP5(m, t, a, ...) m(t, a), __MAP4(m, __VA_ARGS__)
+#define __MAP6(m, t, a, ...) m(t, a), __MAP5(m, __VA_ARGS__)
+#define __MAP(n, ...) __MAP##n(__VA_ARGS__)
+
+#define __SC_LONG(t, a) (long)a
+#define __SC_TABLE(t, a) {sizeof(t), (long long)(a)}
+#define __SC_DECL(t, a) t a
+
+#define LKL_SYSCALL0(name)					       \
+	static inline long lkl_sys##name(void)			       \
+	{							       \
+		long params[6];					       \
+		return lkl_syscall(__lkl__NR##name, params);	       \
+	}
+
+#if __BITS_PER_LONG == 32
+#define LKL_SYSCALLx(x, name, ...)					\
+	static inline							\
+	long lkl_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))		\
+	{								\
+		struct {						\
+			unsigned int size;				\
+			long long value;				\
+		} lkl_params[x] = { __MAP(x, __SC_TABLE, __VA_ARGS__) }; \
+		long sys_params[6], i, k;				\
+		for (i = k = 0; i < x && k < 6; i++, k++) {		\
+			if (lkl_params[i].size > sizeof(long) &&	\
+			    k + 1 < 6) {				\
+				sys_params[k] =				\
+					(long)(lkl_params[i].value & (-1UL)); \
+				k++;					\
+				sys_params[k] =				\
+					(long)(lkl_params[i].value >>	\
+					       __BITS_PER_LONG);	\
+			} else {					\
+				sys_params[k] = (long)(lkl_params[i].value); \
+			}						\
+		}							\
+		return lkl_syscall(__lkl__NR##name, sys_params);	\
+	}
+#else
+#define LKL_SYSCALLx(x, name, ...)					\
+	static inline							\
+	long lkl_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))		\
+	{								\
+		long lkl_params[6] = { __MAP(x, __SC_LONG, __VA_ARGS__) }; \
+		return lkl_syscall(__lkl__NR##name, lkl_params);	\
+	}
+#endif
+
+#define SYSCALL_DEFINE0(name, ...) LKL_SYSCALL0(name)
+#define SYSCALL_DEFINE1(name, ...) LKL_SYSCALLx(1, name, __VA_ARGS__)
+#define SYSCALL_DEFINE2(name, ...) LKL_SYSCALLx(2, name, __VA_ARGS__)
+#define SYSCALL_DEFINE3(name, ...) LKL_SYSCALLx(3, name, __VA_ARGS__)
+#define SYSCALL_DEFINE4(name, ...) LKL_SYSCALLx(4, name, __VA_ARGS__)
+#define SYSCALL_DEFINE5(name, ...) LKL_SYSCALLx(5, name, __VA_ARGS__)
+#define SYSCALL_DEFINE6(name, ...) LKL_SYSCALLx(6, name, __VA_ARGS__)
+
+#if __BITS_PER_LONG == 32
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpointer-to-int-cast"
+#endif
+
+#include <asm/syscall_defs.h>
+
+#if __BITS_PER_LONG == 32
+#pragma GCC diagnostic pop
+#endif
+
+#endif
diff --git a/arch/um/lkl/kernel/asm-offsets.c b/arch/um/lkl/kernel/asm-offsets.c
new file mode 100644
index 000000000000..6be0763698dc
--- /dev/null
+++ b/arch/um/lkl/kernel/asm-offsets.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
diff --git a/arch/um/lkl/kernel/misc.c b/arch/um/lkl/kernel/misc.c
new file mode 100644
index 000000000000..60f048f02ae6
--- /dev/null
+++ b/arch/um/lkl/kernel/misc.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/ptrace.h>
+#include <asm/host_ops.h>
+
+#ifdef CONFIG_PRINTK
+void dump_stack(void)
+{
+	unsigned long dummy;
+	unsigned long *stack = &dummy;
+	unsigned long addr;
+
+	pr_info("Call Trace:\n");
+	while (((long)stack & (THREAD_SIZE - 1)) != 0) {
+		addr = *stack;
+		if (__kernel_text_address(addr)) {
+			pr_info("%p:  [<%08lx>] %pS", stack, addr,
+				(void *)addr);
+			pr_cont("\n");
+		}
+		stack++;
+	}
+	pr_info("\n");
+}
+#endif
+
+void show_regs(struct pt_regs *regs)
+{
+}
+
+#ifdef CONFIG_PROC_FS
+static void *cpuinfo_start(struct seq_file *m, loff_t *pos)
+{
+	return NULL;
+}
+
+static void *cpuinfo_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return NULL;
+}
+
+static void cpuinfo_stop(struct seq_file *m, void *v)
+{
+}
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= cpuinfo_start,
+	.next	= cpuinfo_next,
+	.stop	= cpuinfo_stop,
+	.show	= show_cpuinfo,
+};
+#endif
diff --git a/arch/um/lkl/kernel/vmlinux.lds.S b/arch/um/lkl/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..efe420f38110
--- /dev/null
+++ b/arch/um/lkl/kernel/vmlinux.lds.S
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/vmlinux.lds.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+#include <linux/export.h>
+
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
+
+VMLINUX_SYMBOL(jiffies) = VMLINUX_SYMBOL(jiffies_64);
+
+SECTIONS
+{
+	VMLINUX_SYMBOL(__init_begin) = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	VMLINUX_SYMBOL(__init_end) = .;
+
+	VMLINUX_SYMBOL(_stext) = .;
+	VMLINUX_SYMBOL(_text) = . ;
+	VMLINUX_SYMBOL(text) = . ;
+	.text      :
+	{
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		CPUIDLE_TEXT
+	}
+	VMLINUX_SYMBOL(_etext) = .;
+
+	VMLINUX_SYMBOL(_sdata) = .;
+	RO_DATA_SECTION(PAGE_SIZE)
+	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	VMLINUX_SYMBOL(_edata) = .;
+
+	VMLINUX_SYMBOL(__start_ro_after_init) = .;
+	.data..ro_after_init : { *(.data..ro_after_init)}
+	EXCEPTION_TABLE(16)
+	VMLINUX_SYMBOL(__end_ro_after_init) = .;
+	NOTES
+
+	BSS_SECTION(0, 0, 0)
+	VMLINUX_SYMBOL(_end) = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
-- 
2.20.1 (Apple Git-117)

