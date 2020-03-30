Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587D2197EEE
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgC3Ot2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:49:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55613 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3Ot1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:49:27 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so2569400pjb.5
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8n8lvKR4QQt0TRszS55Rv0tamP2PJ4VtgSKPMdoabQ=;
        b=TxNVbqw8EOtH02z8PLY+6z4mq09IA7owgxehbLk3eSE6YTfj8H3ytNZzl8qGoZBYWV
         cSQ6JGiC4CxPDKbb/bEMMPgI+f4R0awnbBC1mSEE2B9DfdFtqzHDQHmVlLQE0bfj2qaj
         iP6xycVUj2sI4vrXX6IiLepAmuEocKUP25aK3nq/hvqgRIJefdZduIcOqMG6eKINYOl0
         7qG+uazYTqEVrRaMmYx3M+21Ndr7iEqxlUdaBAAFOs3P//WawkacX80n28ESTbCS8iuC
         VoQ6YEM48opNqUlx+U/jJI1OWs2gvZSsCGJ0C4u8sWms/bQbOLv+piDH9k7fT8579wM7
         s/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8n8lvKR4QQt0TRszS55Rv0tamP2PJ4VtgSKPMdoabQ=;
        b=aCHTG+LsPjzYz2jLEKRUFiLzeEQ7+xu601cTnoRH+yqHEhMzgGXsxpC2tIqw824DeW
         afs2zh3hQYdcRzyop2xtHssTRJFOAqpQ93z6Xyv3jVck1IrRyxCp0XVE/bIndO4yEG0p
         l7B1CYQdNV5J454FANnbmnn9RyjSy13SjWyjwFq9/CixwggpwDGaB/JgKYi0IIRMjKxw
         /eMpOXRGTGiEMlFkhKSFVo0WuJKbKRBC8yjKqtW1dMR4bOJ8UNvbUjjJH90VHAHDKgig
         ecGTsP8rO910O/qVYEzW7/mrIOYw2GZ6MYNJdHjckurwIJhmq2izlnUgiTB5yNyp9Id5
         rmIw==
X-Gm-Message-State: ANhLgQ2fv7W6ohCvPRO6EPL1sqeBmhVtFbHsqFie8hik9pevI7H5NUmt
        jDttyCP7m1jeKmJTUBcSWSI=
X-Google-Smtp-Source: ADFU+vvTQuxJ6f0nV5vQ8as3bge5BcZJPL6aMc/jDZjmfJbl2Ysin74wdonRExLEwoWIqw1oenz94g==
X-Received: by 2002:a17:90b:8c4:: with SMTP id ds4mr16706377pjb.44.1585579763687;
        Mon, 30 Mar 2020 07:49:23 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id j17sm10414951pfd.175.2020.03.30.07.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:49:23 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 5C81E202804EF9; Mon, 30 Mar 2020 23:49:21 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 23/25] um lkl: add UML network driver for lkl
Date:   Mon, 30 Mar 2020 23:45:55 +0900
Message-Id: <0f087b36ad579eeb8062b12e9e61566d9b5b18ac.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds the use of the UML drivers of network interfaces which
should be able to use any backend configured by boot command line
parameters.  Currently vector tap backend and (obsolte) slirp and tuntap
backends are tested.

Since the UML drivers use LKL irq infrastructure, the build system only
picks required object files of UML, and LKL adds trivial glue code and
ifdefs into UML code so that existing driver codes can be used for LKL
as-is.

Here is a benchmark number with netperf (TCP_STREAM/TCP_MAERTS in Mbps)
over 10Gbps ethernet.

                      |TCP_STREAM  | TCP_MAERTS
 -------------------- --------------------------
 UMMODE_LIB (um-tap)  | 1932.71    |    8.58
 UMMODE_LIB (vec-tap) | 7565.97    | 9216.49
 UMMODE_LIB (virtio)  | 8743.91    | 9310.35
 UMMODE_KERN (um-tap) | 1819.09    |    0.84
 UMMODE_KERN (vec-tap)| 5418.51    | 9412.07

- setup

We varied client side (netperf) with different net drivers/devices.
tso,tx/rx csum are enabled if possible.

               +--docker0--+
               |           |     10GbEth
 netperf +---tap0        eth0 +==========+ eth0 +---+ netserver
 (client)                (ixgbe)          (ixgbe)

<-- Linux box (4.18.5) -->              <-- Linux box (4.17.19) -->

- summary
With vector driver over tap backend, UMMODE_LIB can reach similar results
with the one of virtio.  And outperforming to UMMODE_KERN is the result of
simplified user/kernel-space transision (just function calls rather than
interposision by ptrace&co).

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml                    |  2 +
 arch/um/drivers/Makefile                |  2 +
 arch/um/include/asm/irq.h               |  2 +
 arch/um/kernel/Makefile                 |  4 ++
 arch/um/kernel/irq.c                    |  4 ++
 arch/um/lkl/Kconfig                     |  2 +
 arch/um/lkl/configs/lkl_defconfig       |  2 +-
 arch/um/lkl/include/asm/irq.h           |  3 ++
 arch/um/lkl/include/uapi/asm/host_ops.h |  6 +++
 arch/um/lkl/kernel/asm-offsets.c        |  1 +
 arch/um/lkl/kernel/irq.c                | 33 +++++++++++++
 arch/um/lkl/kernel/setup.c              |  4 ++
 arch/um/lkl/mm/bootmem.c                | 33 +++++++++++++
 arch/um/os-Linux/Makefile               |  5 ++
 tools/lkl/Makefile.autoconf             |  2 +
 tools/lkl/include/lkl.h                 |  9 ++++
 tools/lkl/include/lkl_host.h            |  1 +
 tools/lkl/lib/Build                     |  1 +
 tools/lkl/lib/config.c                  |  6 +++
 tools/lkl/lib/net.c                     |  8 ++++
 tools/lkl/lib/posix-host.c              |  3 ++
 tools/lkl/lib/um/Build                  |  2 +
 tools/lkl/lib/um/um_glue.c              | 39 +++++++++++++++
 tools/lkl/lib/um/um_net.c               | 30 ++++++++++++
 tools/lkl/tests/net-setup.sh            | 63 +++++++++++++++++++++++++
 tools/lkl/tests/net-test.c              | 18 +++++--
 tools/lkl/tests/net.sh                  | 45 ++++++++++++++++++
 tools/lkl/tests/run.py                  |  2 +
 28 files changed, 326 insertions(+), 6 deletions(-)
 create mode 100644 tools/lkl/lib/um/Build
 create mode 100644 tools/lkl/lib/um/um_glue.c
 create mode 100644 tools/lkl/lib/um/um_net.c

diff --git a/.circleci/config.yml b/.circleci/config.yml
index 5bdf059014c0..df1554078a4b 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -43,6 +43,8 @@ do_steps: &do_steps
   - run:
       name: run tests
       command: |
+        sudo apt-get update
+        sudo apt-get install -y slirp
         mkdir -p ~/junit
         make -C tools/lkl run-tests tests="--junit-dir ~/junit"
       no_output_timeout: "90m"
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a290821e355c..3cce6c81079e 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -37,7 +37,9 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # When the above is fixed, don't forget to add this too!
 #targets += $(obj)/pcap.o
 
+ifeq ($(UMMODE),kernel)
 obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
+endif
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 42c6205e2dc4..839b86f29b8a 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -32,6 +32,8 @@
 
 #endif
 
+#ifdef CONFIG_UMMODE_KERN
 #define NR_IRQS (LAST_IRQ + 1)
+#endif /* CONFIG_UMMODE_KERN */
 
 #endif
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..78b49eb9bf81 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -12,12 +12,16 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_ARCH=$(LDS_ELF_ARCH)	\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
 			$(LDS_EXTRA)
+ifeq ($(UMMODE),kernel)
 extra-y := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
 	um_arch.o umid.o maccess.o kmsg_dump.o skas/
+else ifeq ($(UMMODE),library)
+obj-y = irq.o
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 3577118bb4a5..26e6bd804f99 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -406,6 +406,7 @@ int deactivate_all_fds(void)
 	return 0;
 }
 
+#ifdef CONFIG_UMMODE_KERN
 /*
  * do_IRQ handles all normal device IRQs (the special
  * SMP cross-CPU interrupts have their own specific
@@ -420,6 +421,7 @@ unsigned int do_IRQ(int irq, struct uml_pt_regs *regs)
 	set_irq_regs(old_regs);
 	return 1;
 }
+#endif /* CONFIG_UMMODE_KERN */
 
 void um_free_irq(unsigned int irq, void *dev)
 {
@@ -446,6 +448,7 @@ int um_request_irq(unsigned int irq, int fd, int type,
 
 EXPORT_SYMBOL(um_request_irq);
 
+#ifdef CONFIG_UMMODE_KERN
 /*
  * irq_chip must define at least enable/disable and ack when
  * the edge handler is used.
@@ -597,3 +600,4 @@ unsigned long from_irq_stack(int nested)
 	return mask & ~1;
 }
 
+#endif /* CONFIG_UMMODE_KERN */
diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
index c72c40226509..2b6b4063045c 100644
--- a/arch/um/lkl/Kconfig
+++ b/arch/um/lkl/Kconfig
@@ -81,3 +81,5 @@ config HZ
         default 100
 
 endmenu
+
+source "arch/um/drivers/Kconfig"
diff --git a/arch/um/lkl/configs/lkl_defconfig b/arch/um/lkl/configs/lkl_defconfig
index 7050c233a17e..f2f218a17185 100644
--- a/arch/um/lkl/configs/lkl_defconfig
+++ b/arch/um/lkl/configs/lkl_defconfig
@@ -113,7 +113,7 @@ CONFIG_UML_NET=y
 CONFIG_UML_NET_TUNTAP=y
 # CONFIG_UML_NET_SLIP is not set
 # CONFIG_UML_NET_DAEMON is not set
-# CONFIG_UML_NET_VECTOR is not set
+CONFIG_UML_NET_VECTOR=y
 # CONFIG_UML_NET_VDE is not set
 # CONFIG_UML_NET_MCAST is not set
 # CONFIG_UML_NET_PCAP is not set
diff --git a/arch/um/lkl/include/asm/irq.h b/arch/um/lkl/include/asm/irq.h
index 948fc54cb76c..2ee00ffde21c 100644
--- a/arch/um/lkl/include/asm/irq.h
+++ b/arch/um/lkl/include/asm/irq.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_LKL_IRQ_H
 #define _ASM_LKL_IRQ_H
 
+/* pull UML's definitions */
+#include "../../../include/asm/irq.h"
+
 #define IRQ_STATUS_BITS		(sizeof(long) * 8)
 #define NR_IRQS			((int)(IRQ_STATUS_BITS * IRQ_STATUS_BITS))
 
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index fe4382c3050a..0230885f4f64 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -17,6 +17,10 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  *
+ * @um_devices - string containg the list of UML devices in command line
+ * format. This string is appended to the kernel command line and
+ * is provided here for convenience to be implemented by the host library.
+ *
  * @print - optional operation that receives console messages
  *
  * @panic - called during a kernel panic
@@ -74,6 +78,8 @@ struct lkl_jmp_buf {
  * @jmp_buf_longjmp - perform a jump back to the saved jump buffer
  */
 struct lkl_host_operations {
+	const char *um_devices;
+
 	void (*print)(const char *str, int len);
 	void (*panic)(void);
 
diff --git a/arch/um/lkl/kernel/asm-offsets.c b/arch/um/lkl/kernel/asm-offsets.c
index 6be0763698dc..6fdca6df21a2 100644
--- a/arch/um/lkl/kernel/asm-offsets.c
+++ b/arch/um/lkl/kernel/asm-offsets.c
@@ -1,2 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
+#include <sysdep/kernel-offsets.h>
diff --git a/arch/um/lkl/kernel/irq.c b/arch/um/lkl/kernel/irq.c
index c794412f85d9..59e8572862a2 100644
--- a/arch/um/lkl/kernel/irq.c
+++ b/arch/um/lkl/kernel/irq.c
@@ -11,6 +11,11 @@
 #include <asm/host_ops.h>
 #include <asm/cpu.h>
 
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+#include <os.h>
+#endif
+void *um_os_signal(int signum, void *handler);
+
 /*
  * To avoid much overhead we use an indirect approach: the irqs are marked using
  * a bitmap (array of longs) and a summary of the modified bits is kept in a
@@ -174,6 +179,16 @@ void arch_local_irq_restore(unsigned long flags)
 	irqs_enabled = flags;
 }
 
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+static void sig_handler(int sig)
+{
+	if (sig != SIGIO)
+		return;
+
+	sigio_handler(sig, NULL, NULL);
+}
+#endif
+
 void init_IRQ(void)
 {
 	int i;
@@ -181,6 +196,11 @@ void init_IRQ(void)
 	for (i = 0; i < NR_IRQS; i++)
 		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
 
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+	/* Initialize EPOLL Loop */
+	os_setup_epoll();
+	um_os_signal(SIGIO, sig_handler);
+#endif
 	pr_info("lkl: irqs initialized\n");
 }
 
@@ -188,3 +208,16 @@ void cpu_yield_to_irqs(void)
 {
 	cpu_relax();
 }
+
+#if defined(__linux) && (defined(__i386) || defined(__x86_64))
+unsigned int do_IRQ(int irq, struct uml_pt_regs *regs)
+{
+	/*
+	 * this might be called in signal handler, so dispatch to different
+	 * thread to avoid race
+	 */
+	set_irq_pending(irq);
+
+	return 1;
+}
+#endif
diff --git a/arch/um/lkl/kernel/setup.c b/arch/um/lkl/kernel/setup.c
index 36c199d3aa22..39b7b7c79581 100644
--- a/arch/um/lkl/kernel/setup.c
+++ b/arch/um/lkl/kernel/setup.c
@@ -61,6 +61,10 @@ int __init lkl_start_kernel(struct lkl_host_operations *ops, const char *fmt,
 	ret = vsnprintf(boot_command_line, COMMAND_LINE_SIZE, fmt, ap);
 	va_end(ap);
 
+	if (ops->um_devices)
+		strscpy(boot_command_line + ret, ops->um_devices,
+			COMMAND_LINE_SIZE - ret);
+
 	memcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	init_sem = lkl_ops->sem_alloc(0);
diff --git a/arch/um/lkl/mm/bootmem.c b/arch/um/lkl/mm/bootmem.c
index 39dd0d22b44e..3175dadee13f 100644
--- a/arch/um/lkl/mm/bootmem.c
+++ b/arch/um/lkl/mm/bootmem.c
@@ -64,3 +64,36 @@ void free_mem(void)
 {
 	lkl_ops->mem_free((void *)_memory_start);
 }
+
+void *uml_kmalloc(int size, int flags)
+{
+	return kmalloc(size, flags);
+}
+
+char *uml_strdup(const char *string)
+{
+	return kstrdup(string, GFP_KERNEL);
+}
+
+void free_stack(unsigned long stack, int order)
+{
+	free_pages(stack, order);
+}
+
+unsigned long alloc_stack(int order, int atomic)
+{
+	unsigned long page;
+	gfp_t flags = GFP_KERNEL;
+
+	if (atomic)
+		flags = GFP_ATOMIC;
+	page = __get_free_pages(flags, order);
+
+	return page;
+}
+
+int __cant_sleep(void)
+{
+	return in_atomic() || irqs_disabled() || in_interrupt();
+	/* Is in_interrupt() really needed? */
+}
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..a74a2486e178 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -6,9 +6,14 @@
 # Don't instrument UML-specific code
 KCOV_INSTRUMENT                := n
 
+ifeq ($(UMMODE),kernel)
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
+else
+obj-y = execvp.o file.o helper.o irq.o drivers/
+endif
+
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
diff --git a/tools/lkl/Makefile.autoconf b/tools/lkl/Makefile.autoconf
index 268c367d9962..d2dcaa3b85f2 100644
--- a/tools/lkl/Makefile.autoconf
+++ b/tools/lkl/Makefile.autoconf
@@ -41,6 +41,8 @@ define posix_host
   $(if $(strip $(call find_include,archive.h)),$(call set_autoconf_var,ARCHIVE,y))
   $(if $(filter $(1),elf64-x86-64-freebsd),$(call set_autoconf_var,NEEDS_LARGP,y))
   $(if $(filter $(1),elf32-i386),$(call set_autoconf_var,I386,y))
+  $(if $(filter $(1),elf64-x86-64),$(call set_autoconf_var,UML_DEV,y))
+  $(if $(filter $(1),elf32-i386),$(call set_autoconf_var,UML_DEV,y))
 endef
 
 define do_autoconf
diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 1f4291ad9455..952d11e30868 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -731,6 +731,15 @@ struct lkl_netdev_args {
 	unsigned int offload;
 };
 
+#ifdef LKL_HOST_CONFIG_UML_DEV
+struct lkl_netdev *lkl_um_netdev_create(const char *ifparams);
+#else
+static inline struct lkl_netdev *lkl_um_netdev_create(const char *ifparams)
+{
+	return NULL;
+}
+#endif
+
 /*
  * lkl_register_dbg_handler- register a signal handler that loads a debug lib.
  *
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 4e6d6e031498..7ac30bdcaf0a 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -10,6 +10,7 @@ extern "C" {
 #include <lkl.h>
 
 extern struct lkl_host_operations lkl_host_ops;
+extern char lkl_um_devs[4096];
 
 /**
  * lkl_printf - print a message via the host print operation
diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index 0e711e260a3a..ad8a4b806375 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -10,3 +10,4 @@ liblkl-y += dbg.o
 liblkl-y += dbg_handler.o
 liblkl-y += ../../perf/pmu-events/jsmn.o
 liblkl-y += config.o
+liblkl-$(LKL_HOST_CONFIG_UML_DEV) += um/
diff --git a/tools/lkl/lib/config.c b/tools/lkl/lib/config.c
index 37f8ac4d942a..db3af68446d3 100644
--- a/tools/lkl/lib/config.c
+++ b/tools/lkl/lib/config.c
@@ -470,6 +470,12 @@ static int lkl_config_netdev_create(struct lkl_config *cfg,
 	memset(&nd_args, 0, sizeof(struct lkl_netdev_args));
 
 	if (!nd && iface->iftype && iface->ifparams) {
+		if ((strcmp(iface->iftype, "um") == 0)) {
+			nd = lkl_um_netdev_create(iface->ifparams);
+			iface->nd = nd;
+			/* um_netdev doesn't use virtio device */
+			return 0;
+		}
 	}
 
 	if (nd) {
diff --git a/tools/lkl/lib/net.c b/tools/lkl/lib/net.c
index cf6894c35e46..4d4cd2382b2a 100644
--- a/tools/lkl/lib/net.c
+++ b/tools/lkl/lib/net.c
@@ -179,6 +179,14 @@ int lkl_netdev_get_ifindex(int id)
 
 	snprintf(ifr.lkl_ifr_name, sizeof(ifr.lkl_ifr_name), "eth%d", id);
 	ret = lkl_sys_ioctl(sock, LKL_SIOCGIFINDEX, (long)&ifr);
+
+	/* retry with vector device */
+	if (ret < 0) {
+		snprintf(ifr.lkl_ifr_name, sizeof(ifr.lkl_ifr_name),
+			 "vec%d",id);
+		ret = lkl_sys_ioctl(sock, LKL_SIOCGIFINDEX, (long)&ifr);
+	}
+
 	lkl_sys_close(sock);
 
 	return ret < 0 ? ret : ifr.lkl_ifr_ifindex;
diff --git a/tools/lkl/lib/posix-host.c b/tools/lkl/lib/posix-host.c
index 4be1611a8942..d6394d41e125 100644
--- a/tools/lkl/lib/posix-host.c
+++ b/tools/lkl/lib/posix-host.c
@@ -346,6 +346,9 @@ struct lkl_host_operations lkl_host_ops = {
 	.print = print,
 	.mem_alloc = (void *)malloc,
 	.mem_free = free,
+#ifdef LKL_HOST_CONFIG_UML_DEV
+	.um_devices = lkl_um_devs,
+#endif
 	.gettid = _gettid,
 	.jmp_buf_set = jmp_buf_set,
 	.jmp_buf_longjmp = jmp_buf_longjmp,
diff --git a/tools/lkl/lib/um/Build b/tools/lkl/lib/um/Build
new file mode 100644
index 000000000000..09a60975ecd6
--- /dev/null
+++ b/tools/lkl/lib/um/Build
@@ -0,0 +1,2 @@
+liblkl-y += um_glue.o
+liblkl-y += um_net.o
diff --git a/tools/lkl/lib/um/um_glue.c b/tools/lkl/lib/um/um_glue.c
new file mode 100644
index 000000000000..f59e31a706de
--- /dev/null
+++ b/tools/lkl/lib/um/um_glue.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+
+
+char lkl_um_devs[4096];
+
+/* from sigio.c */
+void maybe_sigio_broken(int fd, int read)
+{
+}
+
+/* from process.c */
+int os_getpid(void)
+{
+	return getpid();
+}
+
+
+/* from chan_kern.c */
+void free_irqs(void)
+{
+}
+
+/* from sigio.c */
+int ignore_sigio_fd(int fd)
+{
+	return 0;
+}
+
+/* new functions */
+void *um_os_signal(int signum, void *handler)
+{
+	return signal(signum, handler);
+}
diff --git a/tools/lkl/lib/um/um_net.c b/tools/lkl/lib/um/um_net.c
new file mode 100644
index 000000000000..eed2dcd9a91c
--- /dev/null
+++ b/tools/lkl/lib/um/um_net.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <lkl_host.h>
+
+static int registered_net_dev_idx;
+
+struct lkl_netdev *lkl_um_netdev_create(const char *ifparams)
+{
+	struct lkl_netdev *nd;
+
+	nd = lkl_host_ops.mem_alloc(sizeof(struct lkl_netdev));
+	if (!nd)
+		return NULL;
+
+	memset(nd, 0, sizeof(struct lkl_netdev));
+
+	nd->id = registered_net_dev_idx++;
+	/* concat strings */
+	/* XXX: better vector device detection ? */
+	if (strncmp(ifparams, "trans", 5) == 0)
+		snprintf(lkl_um_devs + strlen(lkl_um_devs), sizeof(lkl_um_devs),
+			 " vec%d:%s", nd->id, ifparams);
+	else
+		snprintf(lkl_um_devs + strlen(lkl_um_devs), sizeof(lkl_um_devs),
+			 " eth%d=%s", nd->id, ifparams);
+
+	return nd;
+}
diff --git a/tools/lkl/tests/net-setup.sh b/tools/lkl/tests/net-setup.sh
index 0cfc42a30a54..7aef0afc2df9 100644
--- a/tools/lkl/tests/net-setup.sh
+++ b/tools/lkl/tests/net-setup.sh
@@ -1,6 +1,11 @@
 #!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 
+if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+TEST_TAP_IFNAME=tap
+else
+TEST_TAP_IFNAME=lkl_test_tap
+fi
 TEST_IP_NETWORK=192.168.113.0
 TEST_IP_NETMASK=24
 TEST_IP6_NETWORK=fc03::0
@@ -8,6 +13,8 @@ TEST_IP6_NETMASK=64
 TEST_MAC0="aa:bb:cc:dd:ee:ff"
 TEST_MAC1="aa:bb:cc:dd:ee:aa"
 TEST_NETSERVER_PORT=11223
+TEST_UM_SLIRP_PARMS="slirp,,`which slirp`"
+TEST_UM_VECTOR_TAP_PARMS="transport=tap,ifname=${TEST_TAP_IFNAME}0"
 
 # $1 - count
 # $2 - netcount
@@ -71,3 +78,59 @@ ip6_net_mask()
 {
     echo "$(ip6_add 0 $1)/$TEST_IP6_NETMASK"
 }
+
+tap_ifname()
+{
+    echo -n "$TEST_TAP_IFNAME${1:-0}"
+}
+
+tap_prepare()
+{
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        if ! lkl_test_cmd test -d /dev/net &>/dev/null; then
+            lkl_test_cmd sudo mkdir /dev/net
+            lkl_test_cmd sudo ln -s /dev/tun /dev/net/tun
+        fi
+        TAP_USER="vpn"
+        ANDROID_USER="vpn,vpn,net_admin,inet"
+        export_vars ANDROID_USER
+    else
+        TAP_USER=$USER
+    fi
+}
+
+tap_setup()
+{
+    if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+        lkl_test_cmd sudo ifconfig tap create
+        lkl_test_cmd sudo sysctl net.link.tap.up_on_open=1
+        lkl_test_cmd sudo sysctl net.link.tap.user_open=1
+        lkl_test_cmd sudo ifconfig $(tap_ifname) $(ip_host)
+        lkl_test_cmd sudo ifconfig $(tap_ifname) inet6 $(ip6_host)
+        return
+    fi
+
+    lkl_test_cmd sudo ip tuntap add dev $(tap_ifname $1) mode tap user $TAP_USER
+    lkl_test_cmd sudo ip link set dev $(tap_ifname $1) up
+    lkl_test_cmd sudo ip addr add dev $(tap_ifname $1) $(ip_host_mask $1)
+    lkl_test_cmd sudo ip -6 addr add dev $(tap_ifname $1) $(ip6_host_mask $1)
+
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        lkl_test_cmd sudo ip route add $(ip_net_mask $1) \
+                     dev $(tap_ifname $1) proto kernel scope link \
+                     src $(ip_host $1) table local
+        lkl_test_cmd sudo ip -6 route add $(ip6_net_mask $1) \
+                     dev $(tap_ifname $1) table local
+    fi
+}
+
+tap_cleanup()
+{
+    if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+        lkl_test_cmd sudo ifconfig $(tap_ifname) destroy
+        return
+    fi
+
+    lkl_test_cmd sudo ip link set dev $(tap_ifname $1) down
+    lkl_test_cmd sudo ip tuntap del dev $(tap_ifname $1) mode tap
+}
diff --git a/tools/lkl/tests/net-test.c b/tools/lkl/tests/net-test.c
index 5a8e39a52417..1050b0df3134 100644
--- a/tools/lkl/tests/net-test.c
+++ b/tools/lkl/tests/net-test.c
@@ -22,9 +22,11 @@
 
 enum {
 	BACKEND_NONE,
+	BACKEND_UM,
+	BACKEND_UM_VECTOR_TAP,
 };
 
-const char *backends[] = { "loopback", NULL };
+const char *backends[] = { "loopback", "um", "um-vector-tap", NULL };
 static struct {
 	int backend;
 	const char *ifname;
@@ -176,12 +178,18 @@ static int lkl_test_icmp(void)
 }
 
 static struct lkl_netdev *nd;
+static int nd_id;
 
 static int lkl_test_nd_create(void)
 {
 	switch (cla.backend) {
 	case BACKEND_NONE:
 		return TEST_SKIP;
+	case BACKEND_UM:
+	case BACKEND_UM_VECTOR_TAP:
+		nd = lkl_um_netdev_create(cla.ifname);
+		nd_id = nd->id;
+		break;
 	}
 
 	if (!nd) {
@@ -192,11 +200,10 @@ static int lkl_test_nd_create(void)
 	return TEST_SUCCESS;
 }
 
-static int nd_id;
-
 static int lkl_test_nd_add(void)
 {
-	if (cla.backend == BACKEND_NONE)
+	if (cla.backend == BACKEND_NONE || cla.backend == BACKEND_UM
+	    || cla.backend == BACKEND_UM_VECTOR_TAP)
 		return TEST_SKIP;
 
 	return TEST_SUCCESS;
@@ -204,7 +211,8 @@ static int lkl_test_nd_add(void)
 
 static int lkl_test_nd_remove(void)
 {
-	if (cla.backend == BACKEND_NONE)
+	if (cla.backend == BACKEND_NONE || cla.backend == BACKEND_UM
+	    || cla.backend == BACKEND_UM_VECTOR_TAP)
 		return TEST_SKIP;
 
 	return TEST_SUCCESS;
diff --git a/tools/lkl/tests/net.sh b/tools/lkl/tests/net.sh
index 32e8452b0406..d964c6a2321d 100755
--- a/tools/lkl/tests/net.sh
+++ b/tools/lkl/tests/net.sh
@@ -11,8 +11,17 @@ cleanup_backend()
     set -e
 
     case "$1" in
+    "um-vector-tap")
+	# only intel arch is capable with um-net backent
+	if [ -z "$LKL_HOST_CONFIG_UML_DEV" ]; then
+            return $TEST_SKIP
+	fi
+        tap_cleanup
+        ;;
     "loopback")
         ;;
+    "um")
+        ;;
     esac
 }
 
@@ -47,6 +56,30 @@ setup_backend()
     case "$1" in
     "loopback")
         ;;
+    "um")
+	# only intel arch is capable with um-net backent
+	if [ -z "$LKL_HOST_CONFIG_UML_DEV" ]; then
+            return $TEST_SKIP
+	fi
+	# slirp's helper process doesn't work with valgrind
+	if [ -n "$VALGRIND" ]; then
+            return $TEST_SKIP
+	fi
+        ;;
+    "um-vector-tap")
+	# only intel arch is capable with um-net backent
+	if [ -z "$LKL_HOST_CONFIG_UML_DEV" ]; then
+            return $TEST_SKIP
+	fi
+        tap_prepare
+        if ! lkl_test_cmd test -c /dev/net/tun; then
+            if [ -z "$LKL_HOST_CONFIG_BSD" ]; then
+                echo "missing /dev/net/tun"
+                return $TEST_SKIP
+            fi
+        fi
+        tap_setup
+        ;;
     *)
         echo "don't know how to setup backend $1"
         return $TEST_FAILED
@@ -60,6 +93,18 @@ run_tests()
     "loopback")
         lkl_test_exec $script_dir/net-test --dst 127.0.0.1
         ;;
+    "um")
+        lkl_test_exec $script_dir/net-test --backend um \
+                      --ifname $TEST_UM_SLIRP_PARMS \
+                      --ip 10.0.2.15 --netmask-len 8 \
+                      --dst 10.0.2.2
+        ;;
+    "um-vector-tap")
+        lkl_test_exec $script_dir/net-test --backend um-vector-tap \
+                      --ifname $TEST_UM_VECTOR_TAP_PARMS \
+                      --ip $(ip_lkl) --netmask-len $TEST_IP_NETMASK \
+                      --dst $(ip_host)
+        ;;
     esac
 }
 
diff --git a/tools/lkl/tests/run.py b/tools/lkl/tests/run.py
index b72299aaabee..2cc918a6e11a 100755
--- a/tools/lkl/tests/run.py
+++ b/tools/lkl/tests/run.py
@@ -54,6 +54,8 @@ tests = [
     'disk.sh -t vfat',
     'disk.sh -t btrfs',
     'net.sh -b loopback',
+    'net.sh -b um',
+    'net.sh -b um-vector-tap',
     'lklfuse.sh -t ext4',
     'lklfuse.sh -t vfat',
     'lklfuse.sh -t btrfs',
-- 
2.21.0 (Apple Git-122.2)

