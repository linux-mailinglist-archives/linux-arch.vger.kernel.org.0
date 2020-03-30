Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692AE197EC2
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgC3Oqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:46:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44847 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgC3Oqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:46:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id 142so8742765pgf.11
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tasqe+KHkch3NqicbWnxAtiVrmw5OI+ygzHxuJEijeQ=;
        b=qTHVTJoOynjlSzfdjtOgPYjXe3f0XdHQIvBDJWvqTFXdwMZI+M4wlwPNvwR3RZPH36
         NSHdG+rqoDpG/4UE07NzGjzVw8m/97MwUWlSdV9sSsgMedOYuvTA7qeT8Qo1mMk6HGt8
         kxaCw4P5IXDT8S80nP+BtAOkePhmX/Tve8TYNaxrTznlm6OBIQK+gjaYiEhNZuc5RYsc
         5CochCuwdMOZXaJK/MOW/fE/xccvwhIZCyVCAfhPJkYe1eIbSLWBJfDoD/KZR95VUm1h
         EFkxlOwjCGajef+482UcyYUKC0WdsPSmNxyPkswnGNcW+IyWhrEI+hzpldTl2/1j+oFX
         LXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tasqe+KHkch3NqicbWnxAtiVrmw5OI+ygzHxuJEijeQ=;
        b=lvpE+dmf/y+IEt6D2LGWWp0qNffMDCxHGa7g8csEPwUzUFF4wJuTG4dHK5s49yJ0BC
         lpVhLaV3ykDPNo01LTE/h46YXljZnQO6Cdb4KEYojM5rSzNB4mwzx+H/3i1JFg6lNDtK
         i8uSOlb/Ri6+pwnZEqO0rHX5b19ALSgb4MSL6O5f/f2Tg0h0H3PSYqUp/us7/UtZ3fx9
         hrn858ri19UE6m2w2rXOa5FMe0Waz1Q9MJ+JGrRNDoZcsB2AYw7KraIgcdIe5knsupAN
         fafVjLQ7Fe5x6JR6yvvnqI4AjwAeutUCo/H95F4mc+26FTD8ecFLWz7sYTPnjB4/dpIq
         Llkw==
X-Gm-Message-State: ANhLgQ179Un7XfrGrgygWN3mzniDnQ8wUHh0kGWx3CJuRrLoK1AJ63Yx
        KoUHoYTTTMGRlSzQszJGmOg=
X-Google-Smtp-Source: ADFU+vvkdjoGTVmjbK0mFs8EpXU3FOTtZTgETdyW9cMJnu2ec20rwaIE7bJWwLsUdXXUQfHPDJ9w/A==
X-Received: by 2002:aa7:870b:: with SMTP id b11mr13417428pfo.134.1585579604389;
        Mon, 30 Mar 2020 07:46:44 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id g2sm10429351pfh.193.2020.03.30.07.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:46:43 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 692A3202804C3F; Mon, 30 Mar 2020 23:46:41 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>,
        "Edison M . Castro" <edisonmcastro@hotmail.com>,
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
        Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 02/25] um lkl: architecture skeleton for Linux kernel library
Date:   Mon, 30 Mar 2020 23:45:34 +0900
Message-Id: <dca6ea7260830a03c060f57e6ab9961f16ad55ed.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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

Cc: Andreas Abel <aabel@google.com>
Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: Edison M. Castro <edisonmcastro@hotmail.com>
Cc: H.K. Jerry Chu <hkchu@google.com>
Cc: Jens Staal <staal1978@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Levente Kurusa <levex@linux.com>
Cc: Luca Dariz <luca.dariz@gmail.com>
Cc: Mark Stillwell <mark@stillwell.me>
Cc: Matthieu Coudron <mattator@gmail.com>
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Motomu Utsumi <motomuman@gmail.com>
Cc: Patrick Collins <pscollins@google.com>
Cc: Petros Angelatos <petrosagg@gmail.com>
Cc: Pierre-Hugues Husson <phh@phh.me>
Cc: Xiao Jia <xiaoj@google.com>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 MAINTAINERS                                |    8 +
 arch/um/lkl/.gitignore                     |    2 +
 arch/um/lkl/Kconfig                        |   56 ++
 arch/um/lkl/Kconfig.debug                  |    0
 arch/um/lkl/configs/lkl_defconfig          | 1052 ++++++++++++++++++++
 arch/um/lkl/include/asm/Kbuild             |   79 ++
 arch/um/lkl/include/asm/atomic.h           |   11 +
 arch/um/lkl/include/asm/atomic64.h         |  114 +++
 arch/um/lkl/include/asm/bitsperlong.h      |   11 +
 arch/um/lkl/include/asm/byteorder.h        |    7 +
 arch/um/lkl/include/asm/cpu.h              |   14 +
 arch/um/lkl/include/asm/elf.h              |   15 +
 arch/um/lkl/include/asm/processor.h        |   60 ++
 arch/um/lkl/include/asm/ptrace.h           |   25 +
 arch/um/lkl/include/asm/sched.h            |   23 +
 arch/um/lkl/include/asm/syscalls.h         |   18 +
 arch/um/lkl/include/asm/syscalls_32.h      |   43 +
 arch/um/lkl/include/asm/tlb.h              |   12 +
 arch/um/lkl/include/asm/uaccess.h          |   64 ++
 arch/um/lkl/include/asm/unistd_32.h        |   31 +
 arch/um/lkl/include/asm/vmalloc.h          |    5 +
 arch/um/lkl/include/asm/vmlinux.lds.h      |   14 +
 arch/um/lkl/include/asm/xor.h              |    9 +
 arch/um/lkl/include/uapi/asm/Kbuild        |   11 +
 arch/um/lkl/include/uapi/asm/bitsperlong.h |   13 +
 arch/um/lkl/include/uapi/asm/byteorder.h   |   11 +
 arch/um/lkl/include/uapi/asm/syscalls.h    |  348 +++++++
 arch/um/lkl/kernel/asm-offsets.c           |    2 +
 arch/um/lkl/kernel/misc.c                  |   60 ++
 arch/um/lkl/kernel/vmlinux.lds.S           |   51 +
 30 files changed, 2169 insertions(+)
 create mode 100644 arch/um/lkl/.gitignore
 create mode 100644 arch/um/lkl/Kconfig
 create mode 100644 arch/um/lkl/Kconfig.debug
 create mode 100644 arch/um/lkl/configs/lkl_defconfig
 create mode 100644 arch/um/lkl/include/asm/Kbuild
 create mode 100644 arch/um/lkl/include/asm/atomic.h
 create mode 100644 arch/um/lkl/include/asm/atomic64.h
 create mode 100644 arch/um/lkl/include/asm/bitsperlong.h
 create mode 100644 arch/um/lkl/include/asm/byteorder.h
 create mode 100644 arch/um/lkl/include/asm/cpu.h
 create mode 100644 arch/um/lkl/include/asm/elf.h
 create mode 100644 arch/um/lkl/include/asm/processor.h
 create mode 100644 arch/um/lkl/include/asm/ptrace.h
 create mode 100644 arch/um/lkl/include/asm/sched.h
 create mode 100644 arch/um/lkl/include/asm/syscalls.h
 create mode 100644 arch/um/lkl/include/asm/syscalls_32.h
 create mode 100644 arch/um/lkl/include/asm/tlb.h
 create mode 100644 arch/um/lkl/include/asm/uaccess.h
 create mode 100644 arch/um/lkl/include/asm/unistd_32.h
 create mode 100644 arch/um/lkl/include/asm/vmalloc.h
 create mode 100644 arch/um/lkl/include/asm/vmlinux.lds.h
 create mode 100644 arch/um/lkl/include/asm/xor.h
 create mode 100644 arch/um/lkl/include/uapi/asm/Kbuild
 create mode 100644 arch/um/lkl/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/um/lkl/include/uapi/asm/byteorder.h
 create mode 100644 arch/um/lkl/include/uapi/asm/syscalls.h
 create mode 100644 arch/um/lkl/kernel/asm-offsets.c
 create mode 100644 arch/um/lkl/kernel/misc.c
 create mode 100644 arch/um/lkl/kernel/vmlinux.lds.S

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18cb5d18..f3913964eabe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9710,6 +9710,14 @@ F:	Documentation/core-api/atomic_ops.rst
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
index 000000000000..f7e8d707a12b
--- /dev/null
+++ b/arch/um/lkl/Kconfig
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config UML_LKL
+       def_bool y
+       depends on !SMP && !MMU && !COREDUMP && !SECCOMP && !UPROBES && !COMPAT && !USER_RETURN_NOTIFIER
+       select ARCH_THREAD_STACK_ALLOCATOR
+       select RWSEM_GENERIC_SPINLOCK
+       select GENERIC_ATOMIC64 if !64BIT
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
+config HZ
+        int
+        default 100
diff --git a/arch/um/lkl/Kconfig.debug b/arch/um/lkl/Kconfig.debug
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/um/lkl/configs/lkl_defconfig b/arch/um/lkl/configs/lkl_defconfig
new file mode 100644
index 000000000000..7050c233a17e
--- /dev/null
+++ b/arch/um/lkl/configs/lkl_defconfig
@@ -0,0 +1,1052 @@
+CONFIG_CC_IS_GCC=y
+CONFIG_GCC_VERSION=80301
+CONFIG_CLANG_VERSION=0
+CONFIG_CC_CAN_LINK=y
+CONFIG_CC_HAS_ASM_GOTO=y
+CONFIG_CC_HAS_ASM_INLINE=y
+CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
+CONFIG_IRQ_WORK=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+# CONFIG_COMPILE_TEST is not set
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_BUILD_SALT=""
+CONFIG_DEFAULT_HOSTNAME="(none)"
+# CONFIG_SYSVIPC is not set
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_USELIB is not set
+# CONFIG_AUDIT is not set
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ_COMMON=y
+# CONFIG_HZ_PERIODIC is not set
+CONFIG_NO_HZ_IDLE=y
+# CONFIG_NO_HZ is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_TICK_CPU_ACCOUNTING=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_PSI is not set
+CONFIG_TINY_RCU=y
+# CONFIG_RCU_EXPERT is not set
+CONFIG_SRCU=y
+CONFIG_TINY_SRCU=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKHEADERS is not set
+CONFIG_LOG_BUF_SHIFT=17
+CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
+CONFIG_CC_HAS_INT128=y
+# CONFIG_CGROUPS is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+# CONFIG_SYSFS_DEPRECATED is not set
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_BPF=y
+CONFIG_EXPERT=y
+CONFIG_MULTIUSER=y
+# CONFIG_SGETMASK_SYSCALL is not set
+# CONFIG_SYSFS_SYSCALL is not set
+CONFIG_FHANDLE=y
+CONFIG_POSIX_TIMERS=y
+# CONFIG_KALLSYMS_USE_DATA_SECTION is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+CONFIG_EPOLL=y
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+CONFIG_EVENTFD=y
+# CONFIG_AIO is not set
+CONFIG_IO_URING=y
+# CONFIG_ADVISE_SYSCALLS is not set
+CONFIG_MEMBARRIER=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_BASE_RELATIVE=y
+# CONFIG_BPF_SYSCALL is not set
+CONFIG_EMBEDDED=y
+# CONFIG_PC104 is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+CONFIG_SLAB_MERGE_DEFAULT=y
+# CONFIG_SLAB_FREELIST_RANDOM is not set
+# CONFIG_SLAB_FREELIST_HARDENED is not set
+# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
+# CONFIG_MMAP_ALLOW_UNINITIALIZED is not set
+# CONFIG_PROFILING is not set
+CONFIG_LKL=y
+# CONFIG_COREDUMP is not set
+CONFIG_GENERIC_CSUM=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_NO_IOPORT_MAP=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_HZ=100
+# CONFIG_STDERR_CONSOLE is not set
+# CONFIG_SSL is not set
+# CONFIG_NULL_CHAN is not set
+# CONFIG_PORT_CHAN is not set
+# CONFIG_PTY_CHAN is not set
+# CONFIG_TTY_CHAN is not set
+# CONFIG_XTERM_CHAN is not set
+CONFIG_NOCONFIG_CHAN=y
+CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
+CONFIG_CON_CHAN="xterm"
+CONFIG_SSL_CHAN="pty"
+# CONFIG_UML_SOUND is not set
+# CONFIG_SOUND is not set
+CONFIG_UML_NET=y
+# CONFIG_UML_NET_ETHERTAP is not set
+CONFIG_UML_NET_TUNTAP=y
+# CONFIG_UML_NET_SLIP is not set
+# CONFIG_UML_NET_DAEMON is not set
+# CONFIG_UML_NET_VECTOR is not set
+# CONFIG_UML_NET_VDE is not set
+# CONFIG_UML_NET_MCAST is not set
+# CONFIG_UML_NET_PCAP is not set
+CONFIG_UML_NET_SLIRP=y
+# CONFIG_VIRTIO_UML is not set
+CONFIG_ARCH_THREAD_STACK_ALLOCATOR=y
+CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
+CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
+CONFIG_PGTABLE_LEVELS=2
+CONFIG_PLUGIN_HOSTCC=""
+CONFIG_BASE_SMALL=1
+# CONFIG_MODULES is not set
+CONFIG_BLOCK=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_BSGLIB is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+# CONFIG_BLK_DEV_ZONED is not set
+# CONFIG_BLK_CMDLINE_PARSER is not set
+# CONFIG_BLK_WBT is not set
+# CONFIG_BLK_SED_OPAL is not set
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_MQ_IOSCHED_DEADLINE=y
+CONFIG_MQ_IOSCHED_KYBER=y
+# CONFIG_IOSCHED_BFQ is not set
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+CONFIG_BINFMT_SCRIPT=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_SPLIT_PTLOCK_CPUS=999999
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_NOMMU_INITIAL_TRIM_EXCESS=1
+CONFIG_NEED_PER_CPU_KM=y
+# CONFIG_CLEANCACHE is not set
+# CONFIG_ZPOOL is not set
+# CONFIG_ZBUD is not set
+# CONFIG_PERCPU_STATS is not set
+# CONFIG_GUP_BENCHMARK is not set
+CONFIG_NET=y
+# CONFIG_PACKET is not set
+# CONFIG_UNIX is not set
+# CONFIG_TLS is not set
+# CONFIG_XFRM_USER is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+# CONFIG_IP_FIB_TRIE_STATS is not set
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+# CONFIG_IP_ROUTE_VERBOSE is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+CONFIG_NET_IP_TUNNEL=y
+# CONFIG_IP_MROUTE is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_NET_IPVTI is not set
+# CONFIG_NET_FOU is not set
+# CONFIG_NET_FOU_IP_TUNNELS is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_INET_RAW_DIAG is not set
+# CONFIG_INET_DIAG_DESTROY is not set
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_TCP_CONG_WESTWOOD=y
+CONFIG_TCP_CONG_HTCP=y
+# CONFIG_TCP_CONG_HSTCP is not set
+# CONFIG_TCP_CONG_HYBLA is not set
+# CONFIG_TCP_CONG_VEGAS is not set
+# CONFIG_TCP_CONG_NV is not set
+# CONFIG_TCP_CONG_SCALABLE is not set
+# CONFIG_TCP_CONG_LP is not set
+# CONFIG_TCP_CONG_VENO is not set
+# CONFIG_TCP_CONG_YEAH is not set
+# CONFIG_TCP_CONG_ILLINOIS is not set
+# CONFIG_TCP_CONG_DCTCP is not set
+# CONFIG_TCP_CONG_CDG is not set
+CONFIG_TCP_CONG_BBR=y
+# CONFIG_DEFAULT_BIC is not set
+CONFIG_DEFAULT_CUBIC=y
+# CONFIG_DEFAULT_HTCP is not set
+# CONFIG_DEFAULT_WESTWOOD is not set
+# CONFIG_DEFAULT_BBR is not set
+# CONFIG_DEFAULT_RENO is not set
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
+# CONFIG_IPV6_VTI is not set
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_SIT_6RD is not set
+CONFIG_IPV6_NDISC_NODETYPE=y
+# CONFIG_IPV6_TUNNEL is not set
+CONFIG_IPV6_MULTIPLE_TABLES=y
+# CONFIG_IPV6_SUBTREES is not set
+# CONFIG_IPV6_MROUTE is not set
+# CONFIG_IPV6_SEG6_LWTUNNEL is not set
+# CONFIG_IPV6_SEG6_HMAC is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_BPFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+# CONFIG_BRIDGE is not set
+CONFIG_HAVE_NET_DSA=y
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_PHONET is not set
+# CONFIG_6LOWPAN is not set
+# CONFIG_IEEE802154 is not set
+CONFIG_NET_SCHED=y
+# CONFIG_NET_SCH_CBQ is not set
+# CONFIG_NET_SCH_HTB is not set
+# CONFIG_NET_SCH_HFSC is not set
+# CONFIG_NET_SCH_PRIO is not set
+# CONFIG_NET_SCH_MULTIQ is not set
+# CONFIG_NET_SCH_RED is not set
+# CONFIG_NET_SCH_SFB is not set
+# CONFIG_NET_SCH_SFQ is not set
+# CONFIG_NET_SCH_TEQL is not set
+# CONFIG_NET_SCH_TBF is not set
+# CONFIG_NET_SCH_CBS is not set
+# CONFIG_NET_SCH_ETF is not set
+# CONFIG_NET_SCH_TAPRIO is not set
+# CONFIG_NET_SCH_GRED is not set
+# CONFIG_NET_SCH_DSMARK is not set
+# CONFIG_NET_SCH_NETEM is not set
+# CONFIG_NET_SCH_DRR is not set
+# CONFIG_NET_SCH_MQPRIO is not set
+# CONFIG_NET_SCH_SKBPRIO is not set
+# CONFIG_NET_SCH_CHOKE is not set
+# CONFIG_NET_SCH_QFQ is not set
+# CONFIG_NET_SCH_CODEL is not set
+# CONFIG_NET_SCH_FQ_CODEL is not set
+# CONFIG_NET_SCH_CAKE is not set
+CONFIG_NET_SCH_FQ=y
+# CONFIG_NET_SCH_HHF is not set
+# CONFIG_NET_SCH_PIE is not set
+# CONFIG_NET_SCH_PLUG is not set
+# CONFIG_NET_SCH_DEFAULT is not set
+# CONFIG_NET_CLS_BASIC is not set
+# CONFIG_NET_CLS_TCINDEX is not set
+# CONFIG_NET_CLS_ROUTE4 is not set
+# CONFIG_NET_CLS_FW is not set
+# CONFIG_NET_CLS_U32 is not set
+# CONFIG_NET_CLS_RSVP is not set
+# CONFIG_NET_CLS_RSVP6 is not set
+# CONFIG_NET_CLS_FLOW is not set
+# CONFIG_NET_CLS_BPF is not set
+# CONFIG_NET_CLS_FLOWER is not set
+# CONFIG_NET_CLS_MATCHALL is not set
+# CONFIG_NET_EMATCH is not set
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_SCH_FIFO=y
+# CONFIG_DCB is not set
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETLINK_DIAG is not set
+# CONFIG_MPLS is not set
+# CONFIG_NET_NSH is not set
+# CONFIG_HSR is not set
+# CONFIG_NET_SWITCHDEV is not set
+# CONFIG_NET_L3_MASTER_DEV is not set
+# CONFIG_NET_NCSI is not set
+CONFIG_NET_RX_BUSY_POLL=y
+CONFIG_BQL=y
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_AF_KCM is not set
+CONFIG_FIB_RULES=y
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
+# CONFIG_PSAMPLE is not set
+# CONFIG_NET_IFE is not set
+# CONFIG_LWTUNNEL is not set
+CONFIG_DST_CACHE=y
+CONFIG_GRO_CELLS=y
+CONFIG_FAILOVER=y
+# CONFIG_PCCARD is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+CONFIG_ALLOW_DEV_COREDUMP=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
+CONFIG_GENERIC_CPU_DEVICES=y
+# CONFIG_CONNECTOR is not set
+# CONFIG_GNSS is not set
+# CONFIG_MTD is not set
+# CONFIG_OF is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_NULL_BLK is not set
+# CONFIG_BLK_DEV_UBD_SYNC is not set
+CONFIG_BLK_DEV_COW_COMMON=y
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_DRBD is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_RBD is not set
+# CONFIG_NVME_FC is not set
+# CONFIG_DUMMY_IRQ is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_SRAM is not set
+# CONFIG_XILINX_SDFEC is not set
+# CONFIG_C2PORT is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_VOP_BUS is not set
+# CONFIG_ECHO is not set
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_TARGET_CORE is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+# CONFIG_DUMMY is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_IPVLAN is not set
+# CONFIG_VXLAN is not set
+# CONFIG_GENEVE is not set
+# CONFIG_GTP is not set
+# CONFIG_MACSEC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_TUN is not set
+# CONFIG_TUN_VNET_CROSS_LE is not set
+# CONFIG_VETH is not set
+# CONFIG_NLMON is not set
+# CONFIG_ETHERNET is not set
+# CONFIG_MDIO_DEVICE is not set
+# CONFIG_PHYLIB is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_WLAN is not set
+# CONFIG_WAN is not set
+CONFIG_NET_FAILOVER=y
+# CONFIG_ISDN is not set
+# CONFIG_NVM is not set
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+# CONFIG_INPUT_MATRIXKMAP is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+CONFIG_MOUSE_PS2_ALPS=y
+CONFIG_MOUSE_PS2_BYD=y
+CONFIG_MOUSE_PS2_LOGIPS2PP=y
+CONFIG_MOUSE_PS2_SYNAPTICS=y
+CONFIG_MOUSE_PS2_CYPRESS=y
+CONFIG_MOUSE_PS2_TRACKPOINT=y
+# CONFIG_MOUSE_PS2_ELANTECH is not set
+# CONFIG_MOUSE_PS2_SENTELIC is not set
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+CONFIG_MOUSE_PS2_FOCALTECH=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_APPLETOUCH is not set
+# CONFIG_MOUSE_BCM5974 is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_MOUSE_SYNAPTICS_USB is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+# CONFIG_RMI4_CORE is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_SERPORT=y
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
+# CONFIG_SERIO_PS2MULT is not set
+# CONFIG_SERIO_ARC_PS2 is not set
+# CONFIG_USERIO is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_TTY=y
+# CONFIG_VT is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+# CONFIG_NULL_TTY is not set
+CONFIG_LDISC_AUTOLOAD=y
+CONFIG_DEVMEM=y
+# CONFIG_DEVKMEM is not set
+# CONFIG_SERIAL_8250 is not set
+# CONFIG_SERIAL_UARTLITE is not set
+# CONFIG_SERIAL_SCCNXP is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+# CONFIG_SERIAL_ARC is not set
+# CONFIG_SERIAL_FSL_LPUART is not set
+# CONFIG_SERIAL_FSL_LINFLEXUART is not set
+# CONFIG_SERIAL_DEV_BUS is not set
+# CONFIG_TTY_PRINTK is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
+# CONFIG_I2C is not set
+# CONFIG_I3C is not set
+# CONFIG_SPI is not set
+# CONFIG_SPMI is not set
+# CONFIG_HSI is not set
+# CONFIG_PPS is not set
+# CONFIG_PTP_1588_CLOCK is not set
+# CONFIG_PINCTRL is not set
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_AVS is not set
+# CONFIG_POWER_RESET is not set
+# CONFIG_POWER_SUPPLY is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_SENSORS_AS370 is not set
+# CONFIG_SENSORS_ASPEED is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_MAX197 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_NTC_THERMISTOR is not set
+# CONFIG_SENSORS_NCT6683 is not set
+# CONFIG_SENSORS_NCT6775 is not set
+# CONFIG_SENSORS_NPCM7XX is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+CONFIG_BCMA_POSSIBLE=y
+# CONFIG_BCMA is not set
+# CONFIG_MFD_MADERA is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_KEMPLD is not set
+# CONFIG_MFD_MT6397 is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_ABX500_CORE is not set
+# CONFIG_MFD_SYSCON is not set
+# CONFIG_MFD_TI_AM335X_TSCADC is not set
+# CONFIG_MFD_TQMX86 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_RC_CORE is not set
+# CONFIG_MEDIA_SUPPORT is not set
+# CONFIG_DRM is not set
+# CONFIG_DRM_DP_CEC is not set
+# CONFIG_FB is not set
+# CONFIG_LCD_CLASS_DEVICE is not set
+# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
+CONFIG_HID=y
+# CONFIG_HID_BATTERY_STRENGTH is not set
+# CONFIG_HIDRAW is not set
+# CONFIG_UHID is not set
+CONFIG_HID_GENERIC=y
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_ACRUX is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_AUREAL is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_COUGAR is not set
+# CONFIG_HID_MACALLY is not set
+# CONFIG_HID_CMEDIA is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EMS_FF is not set
+# CONFIG_HID_ELECOM is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_GEMBIRD is not set
+# CONFIG_HID_GFRM is not set
+# CONFIG_HID_KEYTOUCH is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_WALTOP is not set
+# CONFIG_HID_VIEWSONIC is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_ICADE is not set
+# CONFIG_HID_ITE is not set
+# CONFIG_HID_JABRA is not set
+# CONFIG_HID_TWINHAN is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LCPOWER is not set
+# CONFIG_HID_LENOVO is not set
+# CONFIG_HID_MAGICMOUSE is not set
+# CONFIG_HID_MALTRON is not set
+# CONFIG_HID_MAYFLASH is not set
+# CONFIG_HID_REDRAGON is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_MULTITOUCH is not set
+# CONFIG_HID_NTI is not set
+# CONFIG_HID_ORTEK is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_PICOLCD is not set
+# CONFIG_HID_PLANTRONICS is not set
+# CONFIG_HID_PRIMAX is not set
+# CONFIG_HID_SAITEK is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SPEEDLINK is not set
+# CONFIG_HID_STEAM is not set
+# CONFIG_HID_STEELSERIES is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_RMI is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TIVO is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_UDRAW_PS3 is not set
+# CONFIG_HID_XINMO is not set
+# CONFIG_HID_ZEROPLUS is not set
+# CONFIG_HID_ZYDACRON is not set
+# CONFIG_HID_SENSOR_HUB is not set
+# CONFIG_HID_ALPS is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB_SUPPORT=y
+# CONFIG_USB_ULPI_BUS is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+# CONFIG_USB is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_TYPEC is not set
+# CONFIG_USB_ROLE_SWITCH is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_SYNC_FILE is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_VIRT_DRIVERS is not set
+CONFIG_VIRTIO_MENU=y
+# CONFIG_VIRTIO_MMIO is not set
+# CONFIG_GREYBUS is not set
+# CONFIG_STAGING is not set
+# CONFIG_GOLDFISH is not set
+# CONFIG_HWSPINLOCK is not set
+# CONFIG_MAILBOX is not set
+# CONFIG_REMOTEPROC is not set
+# CONFIG_RPMSG_VIRTIO is not set
+# CONFIG_SOC_TI is not set
+# CONFIG_XILINX_VCU is not set
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_PWM is not set
+# CONFIG_IPACK_BUS is not set
+# CONFIG_RESET_CONTROLLER is not set
+# CONFIG_GENERIC_PHY is not set
+# CONFIG_BCM_KONA_USB2_PHY is not set
+# CONFIG_PHY_PXA_28NM_HSIC is not set
+# CONFIG_PHY_PXA_28NM_USB2 is not set
+# CONFIG_POWERCAP is not set
+# CONFIG_MCB is not set
+# CONFIG_RAS is not set
+# CONFIG_ANDROID is not set
+# CONFIG_LIBNVDIMM is not set
+# CONFIG_DAX is not set
+# CONFIG_NVMEM is not set
+# CONFIG_STM is not set
+# CONFIG_INTEL_TH is not set
+# CONFIG_FPGA is not set
+# CONFIG_SIOX is not set
+# CONFIG_SLIMBUS is not set
+# CONFIG_INTERCONNECT is not set
+# CONFIG_COUNTER is not set
+# CONFIG_VALIDATE_FS_PARSER is not set
+CONFIG_FS_IOMAP=y
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT2=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_JBD2=y
+# CONFIG_JBD2_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+CONFIG_BTRFS_FS=y
+# CONFIG_BTRFS_FS_POSIX_ACL is not set
+# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
+# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
+# CONFIG_BTRFS_DEBUG is not set
+# CONFIG_BTRFS_ASSERT is not set
+# CONFIG_BTRFS_FS_REF_VERIFY is not set
+# CONFIG_NILFS2_FS is not set
+# CONFIG_F2FS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+CONFIG_EXPORTFS=y
+# CONFIG_EXPORTFS_BLOCK_OPS is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_FS_ENCRYPTION is not set
+# CONFIG_FS_VERITY is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_FANOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_FUSE_FS is not set
+# CONFIG_OVERLAY_FS is not set
+# CONFIG_FSCACHE is not set
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_FAT_DEFAULT_UTF8 is not set
+# CONFIG_NTFS_FS is not set
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+# CONFIG_PROC_CHILDREN is not set
+CONFIG_KERNFS=y
+CONFIG_SYSFS=y
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ORANGEFS_FS is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX6FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_EROFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
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
+# CONFIG_UNICODE is not set
+CONFIG_IO_WQ=y
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY_DMESG_RESTRICT is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
+# CONFIG_HARDENED_USERCOPY is not set
+# CONFIG_STATIC_USERMODEHELPER is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"
+CONFIG_INIT_STACK_NONE=y
+# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
+# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
+CONFIG_XOR_BLOCKS=y
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_USER is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_RSA is not set
+# CONFIG_CRYPTO_DH is not set
+# CONFIG_CRYPTO_ECDH is not set
+# CONFIG_CRYPTO_ECRDSA is not set
+# CONFIG_CRYPTO_CURVE25519 is not set
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
+# CONFIG_CRYPTO_AEGIS128 is not set
+# CONFIG_CRYPTO_SEQIV is not set
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CFB is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_OFB is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_KEYWRAP is not set
+# CONFIG_CRYPTO_ADIANTUM is not set
+# CONFIG_CRYPTO_ESSIV is not set
+# CONFIG_CRYPTO_CMAC is not set
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_CRC32 is not set
+CONFIG_CRYPTO_XXHASH=y
+CONFIG_CRYPTO_BLAKE2B=y
+# CONFIG_CRYPTO_BLAKE2S is not set
+# CONFIG_CRYPTO_CRCT10DIF is not set
+# CONFIG_CRYPTO_GHASH is not set
+# CONFIG_CRYPTO_POLY1305 is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+CONFIG_CRYPTO_SHA256=y
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_SHA3 is not set
+# CONFIG_CRYPTO_SM3 is not set
+# CONFIG_CRYPTO_STREEBOG is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_AES_TI is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_CHACHA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_SM4 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_LZO is not set
+# CONFIG_CRYPTO_842 is not set
+# CONFIG_CRYPTO_LZ4 is not set
+# CONFIG_CRYPTO_LZ4HC is not set
+# CONFIG_CRYPTO_ZSTD is not set
+CONFIG_CRYPTO_ANSI_CPRNG=y
+# CONFIG_CRYPTO_DRBG_MENU is not set
+# CONFIG_CRYPTO_JITTERENTROPY is not set
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+# CONFIG_CRYPTO_USER_API_RNG is not set
+# CONFIG_CRYPTO_USER_API_AEAD is not set
+CONFIG_CRYPTO_LIB_AES=y
+# CONFIG_CRYPTO_LIB_BLAKE2S is not set
+# CONFIG_CRYPTO_LIB_CHACHA is not set
+# CONFIG_CRYPTO_LIB_CURVE25519 is not set
+CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
+# CONFIG_CRYPTO_LIB_POLY1305 is not set
+# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
+CONFIG_CRYPTO_LIB_SHA256=y
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
+CONFIG_RAID6_PQ=y
+# CONFIG_RAID6_PQ_BENCHMARK is not set
+# CONFIG_PACKING is not set
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_NET_UTILS=y
+# CONFIG_CORDIC is not set
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC16=y
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC32_SELFTEST is not set
+CONFIG_CRC32_SLICEBY8=y
+# CONFIG_CRC32_SLICEBY4 is not set
+# CONFIG_CRC32_SARWATE is not set
+# CONFIG_CRC32_BIT is not set
+# CONFIG_CRC64 is not set
+# CONFIG_CRC4 is not set
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+# CONFIG_CRC8 is not set
+CONFIG_XXHASH=y
+# CONFIG_RANDOM32_SELFTEST is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_ZSTD_COMPRESS=y
+CONFIG_ZSTD_DECOMPRESS=y
+# CONFIG_XZ_DEC is not set
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_DMA=y
+# CONFIG_DMA_API_DEBUG is not set
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+# CONFIG_IRQ_POLL is not set
+CONFIG_SBITMAP=y
+# CONFIG_STRING_SELFTEST is not set
+CONFIG_PRINTK_TIME=y
+# CONFIG_PRINTK_CALLER is not set
+CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
+CONFIG_CONSOLE_LOGLEVEL_QUIET=4
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
+CONFIG_SYMBOLIC_ERRNAME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+# CONFIG_DEBUG_INFO_SPLIT is not set
+# CONFIG_DEBUG_INFO_DWARF4 is not set
+# CONFIG_DEBUG_INFO_BTF is not set
+# CONFIG_GDB_SCRIPTS is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_HEADERS_INSTALL is not set
+CONFIG_OPTIMIZE_INLINING=y
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+CONFIG_SECTION_MISMATCH_WARN_ONLY=y
+CONFIG_ARCH_WANT_FRAME_POINTERS=y
+CONFIG_FRAME_POINTER=y
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_UBSAN is not set
+CONFIG_UBSAN_ALIGNMENT=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_MISC=y
+# CONFIG_PAGE_EXTENSION is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_PAGE_POISONING is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_SCHED_STACK_END_CHECK is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_NOMMU_REGIONS is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+CONFIG_CC_HAS_KASAN_GENERIC=y
+CONFIG_KASAN_STACK=1
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+CONFIG_PANIC_TIMEOUT=0
+# CONFIG_SOFTLOCKUP_DETECTOR is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_WQ_WATCHDOG is not set
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_TIMEKEEPING is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_LOCK_TORTURE_TEST is not set
+# CONFIG_WW_MUTEX_SELFTEST is not set
+# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_PLIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_BUG_ON_DATA_CORRUPTION is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_RCU_PERF_TEST is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_RCU_EQS_DEBUG is not set
+# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_KUNIT is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+CONFIG_CC_HAS_SANCOV_TRACE_PC=y
+CONFIG_RUNTIME_TESTING_MENU=y
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_TEST_SORT is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_REED_SOLOMON_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_TEST_HEXDUMP is not set
+# CONFIG_TEST_STRING_HELPERS is not set
+# CONFIG_TEST_STRSCPY is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_TEST_PRINTF is not set
+# CONFIG_TEST_BITMAP is not set
+# CONFIG_TEST_BITFIELD is not set
+# CONFIG_TEST_UUID is not set
+# CONFIG_TEST_XARRAY is not set
+# CONFIG_TEST_OVERFLOW is not set
+# CONFIG_TEST_RHASHTABLE is not set
+# CONFIG_TEST_HASH is not set
+# CONFIG_TEST_IDA is not set
+# CONFIG_FIND_BIT_BENCHMARK is not set
+# CONFIG_TEST_SYSCTL is not set
+# CONFIG_TEST_UDELAY is not set
+# CONFIG_TEST_MEMCAT_P is not set
+# CONFIG_TEST_STACKINIT is not set
+# CONFIG_TEST_MEMINIT is not set
+# CONFIG_MEMTEST is not set
diff --git a/arch/um/lkl/include/asm/Kbuild b/arch/um/lkl/include/asm/Kbuild
new file mode 100644
index 000000000000..6ae3104fa285
--- /dev/null
+++ b/arch/um/lkl/include/asm/Kbuild
@@ -0,0 +1,79 @@
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
+generic-y += io.h
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
diff --git a/arch/um/lkl/include/asm/atomic.h b/arch/um/lkl/include/asm/atomic.h
new file mode 100644
index 000000000000..0c5f9f8e4b30
--- /dev/null
+++ b/arch/um/lkl/include/asm/atomic.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LKL_ATOMIC_H
+#define __LKL_ATOMIC_H
+
+#include <asm-generic/atomic.h>
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+#include "atomic64.h"
+#endif /* CONFIG_GENERIC_ATOMIC64 */
+
+#endif
diff --git a/arch/um/lkl/include/asm/atomic64.h b/arch/um/lkl/include/asm/atomic64.h
new file mode 100644
index 000000000000..87d7956c29eb
--- /dev/null
+++ b/arch/um/lkl/include/asm/atomic64.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LKL_ATOMIC64_H
+#define __LKL_ATOMIC64_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_SMP
+#error "SMP is not supported on this platform"
+#else
+#define ATOMIC64_OP(op, c_op)						\
+static inline void atomic64_##op(s64 i, atomic64_t *v)			\
+{									\
+	unsigned long flags;						\
+									\
+	raw_local_irq_save(flags);					\
+	v->counter = v->counter c_op i;					\
+	raw_local_irq_restore(flags);					\
+}
+
+#define ATOMIC64_OP_RETURN(op, c_op)					\
+static inline s64 atomic64_##op##_return(s64 i, atomic64_t *v)		\
+{									\
+	unsigned long flags;						\
+	s64 ret;							\
+									\
+	raw_local_irq_save(flags);					\
+	ret = (v->counter = v->counter c_op i);				\
+	raw_local_irq_restore(flags);					\
+									\
+	return ret;							\
+}
+
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static inline s64 atomic64_fetch_##op(s64 i, atomic64_t *v)		\
+{									\
+	unsigned long flags;						\
+	s64 ret;							\
+									\
+	raw_local_irq_save(flags);					\
+	ret = v->counter;						\
+	v->counter = v->counter c_op i;					\
+	raw_local_irq_restore(flags);					\
+									\
+	return ret;							\
+}
+#endif /* CONFIG_SMP */
+
+#ifndef atomic64_add_return
+ATOMIC64_OP_RETURN(add, +)
+#endif
+
+#ifndef atomic64_sub_return
+ATOMIC64_OP_RETURN(sub, -)
+#endif
+
+#ifndef atomic64_fetch_add
+ATOMIC64_FETCH_OP(add, +)
+#endif
+
+#ifndef atomic64_fetch_sub
+ATOMIC64_FETCH_OP(sub, -)
+#endif
+
+#ifndef atomic64_fetch_and
+ATOMIC64_FETCH_OP(and, &)
+#endif
+
+#ifndef atomic64_fetch_or
+ATOMIC64_FETCH_OP(or, |)
+#endif
+
+#ifndef atomic64_fetch_xor
+ATOMIC64_FETCH_OP(xor, ^)
+#endif
+
+#ifndef atomic64_and
+ATOMIC64_OP(and, &)
+#endif
+
+#ifndef atomic64_or
+ATOMIC64_OP(or, |)
+#endif
+
+#ifndef atomic64_xor
+ATOMIC64_OP(xor, ^)
+#endif
+
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP_RETURN
+#undef ATOMIC64_OP
+
+
+#define ATOMIC64_INIT(i)	{ (i) }
+
+static inline void atomic64_add(s64 i, atomic64_t *v)
+{
+	atomic64_add_return(i, v);
+}
+
+static inline void atomic64_sub(s64 i, atomic64_t *v)
+{
+	atomic64_sub_return(i, v);
+}
+
+#ifndef atomic64_read
+#define atomic64_read(v)	READ_ONCE((v)->counter)
+#endif
+
+#define atomic64_set(v, i) WRITE_ONCE(((v)->counter), (i))
+
+#define atomic64_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
+#define atomic64_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
+
+#endif /* __LKL_ATOMIC64_H */
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
diff --git a/arch/um/lkl/include/asm/vmalloc.h b/arch/um/lkl/include/asm/vmalloc.h
new file mode 100644
index 000000000000..46de2e4f03c7
--- /dev/null
+++ b/arch/um/lkl/include/asm/vmalloc.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_VMALLOC_H
+#define _LKL_VMALLOC_H
+
+#endif /* _LKL_VMALLOC_H */
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
index 000000000000..e1f554364a56
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/Kbuild
@@ -0,0 +1,11 @@
+# UAPI Header export list
+
+generic-y += elf.h
+generic-y += kvm_para.h
+generic-y += shmparam.h
+generic-y += siginfo.h
+generic-y += swab.h
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
index 000000000000..f57c563522cb
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
+jiffies = jiffies_64;
+
+SECTIONS
+{
+	__init_begin = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	__init_end = .;
+
+	_stext = .;
+	_text = . ;
+	text = . ;
+	.text      :
+	{
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		CPUIDLE_TEXT
+	}
+	_etext = .;
+
+	_sdata = .;
+	RO_DATA(PAGE_SIZE)
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	_edata = .;
+
+	__start_ro_after_init = .;
+	.data..ro_after_init : { *(.data..ro_after_init)}
+	EXCEPTION_TABLE(16)
+	__end_ro_after_init = .;
+	NOTES
+
+	BSS_SECTION(0, 0, 0)
+	_end = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
-- 
2.21.0 (Apple Git-122.2)

