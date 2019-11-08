Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5579CF3F5F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfKHFEj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33076 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfKHFEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so3272221plb.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sn2MKGlOlIY35rQn9eNvfsaWuqr0IyP8VS9JoNyH1Lk=;
        b=gd0hY6qjPl9yIlxzTe/J2CTD3iuHcAoTwHREJhT5VeEDm63Zhox8qP6at1y0WwJCfp
         acArMw/Tlhl2l2dOS/jHRMiK640jk3i59EO6gQ98vXwtR5BXlKveiEqrA/vjQ4hAKZQV
         JoQ1ZYW2QI8hCCKxurOGyOjaZzOEtfqh20+01rtDgHDLdmn3tggLROYTRDV5k/giNVoi
         lV2EFzxhRR6O0X2wI7imTKLSxJUeXhyJyS6U1u3lxoMhgWhANJa5yn1DrvdBRfrgxWE4
         sH8rMNVl6jmyEKBS8C6bi7TFtensJihwRx75s3QJG4sPCsW5QhPg0x/iSPh9gXkovXCK
         KMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sn2MKGlOlIY35rQn9eNvfsaWuqr0IyP8VS9JoNyH1Lk=;
        b=mI05l6oIReB2DFjHImWqSZcVRA4uMz+qTRfPB4BfCI3NeCgcF8iR0Xu6KIvDPqHNgg
         FTtis15ZHmf/DzCYWh2GaoZAmbmtsoln+TEmBtyHwaos1hWtNlaVEd76Xg71CasO8p2k
         1JoLiRUuqnF19E7cghJoHCGCfQMgU3+c59nXy6xS0x5f5ulNT2iAzAHmKXVkKnO51b7x
         v5ufXiiSdeHBRen97CJVkdNPc002rYssZoryTVy4CgvPwl52ajOZ87UePa95U4nrP9zJ
         EUffZAjhxpLzMtBFZJgwJa2asEnBKAg3VrXgPuku5wxkkuKJWfxlc2QNJlnsLvMwGjCv
         l6Cg==
X-Gm-Message-State: APjAAAUPx3Mm8MHaRda7IVR787gioKAlQs1qIJgPZo8VnjBIRTxhaMh/
        MOlW39rQEzScS47eQeF1XXU=
X-Google-Smtp-Source: APXvYqwhQ4/Tgc2U5hJ4YH2QyCr3ORYubZNYH+n0pvNrOYNZU6Ot/+OYBKeYTv336WRY/tcOnWkwLw==
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr8374424plb.303.1573189475617;
        Thu, 07 Nov 2019 21:04:35 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id c184sm5668056pfc.159.2019.11.07.21.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:34 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id EE88E201ACFEFD; Fri,  8 Nov 2019 14:04:32 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 36/37] um: use lkl virtio_net_tap device as UML device
Date:   Fri,  8 Nov 2019 14:02:51 +0900
Message-Id: <ca18c78dd61420af74cf5cf49452285e7b551e49.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This also expands supporting virtio-mmio driver, which involves multiple
addition to Kbuild file as well.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml             |   2 +-
 arch/um/Kconfig                  |   6 --
 arch/um/Makefile.um              |   3 +
 arch/um/configs/x86_64_defconfig |   5 ++
 arch/um/include/asm/Kbuild       |   1 +
 arch/um/include/asm/io.h         |   4 +
 arch/um/kernel/syscall.c         |  53 ++++++++++++
 arch/um/lkl/include/asm/irq.h    |   2 +
 arch/um/os-Linux/Makefile        |   5 ++
 arch/um/os-Linux/lkl_dev.c       | 134 +++++++++++++++++++++++++++++++
 tools/lkl/lib/Makefile           |  33 ++++++++
 tools/lkl/lib/posix-host.c       |   4 +
 tools/lkl/lib/virtio.c           |  17 +++-
 tools/lkl/lib/virtio.h           |  22 +++++
 tools/lkl/lib/virtio_net.c       |  25 +++++-
 tools/lkl/lib/virtio_net_fd.c    |  22 -----
 tools/lkl/lib/virtio_net_fd.h    |  22 +++++
 17 files changed, 328 insertions(+), 32 deletions(-)
 create mode 100644 arch/um/os-Linux/lkl_dev.c
 create mode 100644 tools/lkl/lib/Makefile

diff --git a/.circleci/config.yml b/.circleci/config.yml
index 5c7b2fbad703..9753543e8198 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -141,7 +141,7 @@ do_uml_steps: &do_uml_steps
         if [ $CIRCLE_STAGE = "i386_uml" ] || [ $CIRCLE_STAGE = "i386_uml_on_x86_64" ]; then
           exit 0
         fi
-        ./linux rootfstype=hostfs ro mem=1g loglevel=10 init="/bin/bash -c exit" || export RETVAL=$?
+        ./linux rootfstype=hostfs ro mem=1g loglevel=10 veth0=tap,tap0,0xc803 init="/bin/bash -c exit" || export RETVAL=$?
         # SIGABRT=6 => 128+6
         if [ $RETVAL != "134" ]; then
           exit 1
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c46bdb2987ce..325a784da776 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -45,9 +45,6 @@ config MMU
 	bool
 	default y
 
-config NO_IOMEM
-	def_bool y
-
 config ISA
 	bool
 
@@ -182,9 +179,6 @@ config MMAPPER
 	  This driver allows a host file to be used as emulated IO memory inside
 	  UML.
 
-config NO_DMA
-	def_bool y
-
 config PGTABLE_LEVELS
 	int
 	default 3 if 3_LEVEL_PGTABLES
diff --git a/arch/um/Makefile.um b/arch/um/Makefile.um
index d54fd387a16f..fc28305c866a 100644
--- a/arch/um/Makefile.um
+++ b/arch/um/Makefile.um
@@ -147,3 +147,6 @@ archclean:
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+
+core-y		       += $(srctree)/tools/lkl/lib/
+KBUILD_CPPFLAGS += -I$(srctree)/$(ARCH_DIR)/lkl/include -I$(srctree)/$(ARCH_DIR)/
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 3281d7600225..917982b6cd60 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -70,3 +70,8 @@ CONFIG_NLS=y
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_KERNEL=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_MENU=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_VIRTIO_NET=y
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 398006d27e40..f39430ba94d3 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index 96f77b5232aa..f23700d3c071 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -2,11 +2,15 @@
 #ifndef _ASM_UM_IO_H
 #define _ASM_UM_IO_H
 
+#ifndef CONFIG_HAS_IOMEM
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	return (void __iomem *)(unsigned long)offset;
 }
+#else
+#include <lkl/include/asm/io.h>
+#endif
 
 #define iounmap iounmap
 static inline void iounmap(void __iomem *addr)
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index eed54c53fbbb..3ebbeb7bab9c 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -13,6 +13,7 @@
 #include <asm/mman.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/platform_device.h>
 
 long old_mmap(unsigned long addr, unsigned long len,
 	      unsigned long prot, unsigned long flags,
@@ -26,3 +27,55 @@ long old_mmap(unsigned long addr, unsigned long len,
  out:
 	return err;
 }
+
+SYSCALL_DEFINE3(virtio_mmio_device_add, long, base, long, size, unsigned int,
+		irq)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	struct resource res[] = {
+		[0] = {
+		       .start = base,
+		       .end = base + size - 1,
+		       .flags = IORESOURCE_MEM,
+		       },
+		[1] = {
+		       .start = irq,
+		       .end = irq,
+		       .flags = IORESOURCE_IRQ,
+		       },
+	};
+
+	pdev = platform_device_alloc("virtio-mmio", PLATFORM_DEVID_AUTO);
+	if (!pdev) {
+		dev_err(&pdev->dev,
+			"%s: Unable to device alloc for virtio-mmio\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret) {
+		dev_err(&pdev->dev,
+			"%s: Unable to add resources for %s%d\n", __func__,
+			pdev->name, pdev->id);
+		goto exit_device_put;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "%s: Unable to add %s%d\n", __func__,
+			pdev->name, pdev->id);
+		goto exit_release_pdev;
+	}
+
+	return pdev->id;
+
+exit_release_pdev:
+	platform_device_del(pdev);
+exit_device_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
diff --git a/arch/um/lkl/include/asm/irq.h b/arch/um/lkl/include/asm/irq.h
index 948fc54cb76c..7057bcd73727 100644
--- a/arch/um/lkl/include/asm/irq.h
+++ b/arch/um/lkl/include/asm/irq.h
@@ -2,8 +2,10 @@
 #ifndef _ASM_LKL_IRQ_H
 #define _ASM_LKL_IRQ_H
 
+#ifndef CONFIG_UML
 #define IRQ_STATUS_BITS		(sizeof(long) * 8)
 #define NR_IRQS			((int)(IRQ_STATUS_BITS * IRQ_STATUS_BITS))
+#endif
 
 void run_irqs(void);
 void set_irq_pending(int irq);
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..d90d88a2f34e 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -11,9 +11,14 @@ obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	umid.o user_syms.o util.o drivers/ skas/
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
+obj-y += lkl_dev.o
+
+CFLAGS_lkl_dev.o:=-I$(srctree)/tools/lkl/include -Wno-undef
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
+USER_OBJS += lkl_dev.o
+
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/lkl_dev.c b/arch/um/os-Linux/lkl_dev.c
new file mode 100644
index 000000000000..698062917ed5
--- /dev/null
+++ b/arch/um/os-Linux/lkl_dev.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdlib.h>
+#include <string.h>
+#include <init.h>
+#include <os.h>
+#include <kern_util.h>
+#include <errno.h>
+
+#include <lkl.h>
+#include <lkl_host.h>
+
+extern struct lkl_host_operations lkl_host_ops;
+struct lkl_host_operations *lkl_ops = &lkl_host_ops;
+
+static struct lkl_netdev *nd;
+
+int __init uml_netdev_prepare(char *iftype, char *ifparams, char *ifoffload)
+{
+	int offload = 0;
+
+	if (ifoffload)
+		offload = strtol(ifoffload, NULL, 0);
+
+	if ((strcmp(iftype, "tap") == 0)) {
+		nd = lkl_netdev_tap_create(ifparams, offload);
+#ifdef notyet
+	} else if ((strcmp(iftype, "macvtap") == 0)) {
+		nd = lkl_netdev_macvtap_create(ifparams, offload);
+#endif
+	} else {
+		if (offload) {
+			lkl_printf("WARN: %s isn't supported on %s\n",
+				   "LKL_HIJACK_OFFLOAD",
+				   iftype);
+			lkl_printf(
+				"WARN: Disabling offload features.\n");
+		}
+		offload = 0;
+	}
+#ifdef notyet
+	if (strcmp(iftype, "raw") == 0)
+		nd = lkl_netdev_raw_create(ifparams);
+#endif
+
+	return 0;
+}
+
+
+int __init uml_netdev_add(void)
+{
+	if (nd)
+		lkl_netdev_add(nd, NULL);
+
+	return 0;
+}
+__initcall(uml_netdev_add);
+
+static int __init lkl_eth_setup(char *str, int *niu)
+{
+	char *end, *iftype, *ifparams, *ifoffload;
+	int devid, err = -EINVAL;
+
+	/* veth */
+	devid = strtoul(str, &end, 0);
+	if (end == str) {
+		os_warn("Bad device number\n");
+		return err;
+	}
+
+	/* = */
+	str = end;
+	if (*str != '=') {
+		os_warn("Expected '=' after device number\n");
+		return err;
+	}
+	str++;
+
+	/* <iftype> */
+	iftype = str;
+
+	/* <ifparams> */
+	ifparams = strchr(str, ',');
+	if (ifparams == NULL) {
+		os_warn("failed to parse ifparams\n");
+		return -1;
+	}
+	*ifparams = '\0';
+	ifparams++;
+
+	str = ifparams;
+	/* <offload> */
+	ifoffload = strchr(str, ',');
+	*ifoffload = '\0';
+	ifoffload++;
+
+	os_info("str=%s, iftype=%s, ifparams=%s, offload=%s\n",
+		str, iftype, ifparams, ifoffload);
+
+	/* preparation */
+	uml_netdev_prepare(iftype, ifparams, ifoffload);
+
+	return 1;
+}
+
+__uml_setup("veth", lkl_eth_setup,
+"veth[0-9]+=<iftype>,<ifparams>,<offload>\n"
+"    Configure a network device.\n\n"
+);
+
+/* stub functions */
+int lkl_is_running(void)
+{
+	return 1;
+}
+
+
+void lkl_put_irq(int i, const char *user)
+{
+}
+
+/* XXX */
+static int free_irqs[2] = {5, 13};
+int lkl_get_free_irq(const char *user)
+{
+	static int irq_idx;
+	return free_irqs[irq_idx++];
+}
+
+int lkl_trigger_irq(int irq)
+{
+	do_IRQ(irq, NULL);
+	return 0;
+}
diff --git a/tools/lkl/lib/Makefile b/tools/lkl/lib/Makefile
new file mode 100644
index 000000000000..3c35d49843cd
--- /dev/null
+++ b/tools/lkl/lib/Makefile
@@ -0,0 +1,33 @@
+CFLAGS_posix-host.o += -D_FILE_OFFSET_BITS=64 -Wno-error=incompatible-pointer-types
+
+USER_CFLAGS += -I$(srctree)/tools/lkl/include \
+		-Wno-strict-prototypes -Wno-undef \
+		-Wframe-larger-than=20480 -O0 -g
+
+USER_OBJS += fs.o iomem.o net.o jmp_buf.o virtio.o virtio_net.o \
+	 virtio_net_fd.o virtio_net_tap.o utils.o posix-host.o \
+	../../perf/pmu-events/jsmn.o
+
+#obj-y += fs.o
+obj-y += iomem.o
+#obj-y += net.o
+obj-y += jmp_buf.o
+obj-y += posix-host.o
+#obj-$(LKL_HOST_CONFIG_NT) += nt-host.o
+obj-y += utils.o
+#obj-y += virtio_blk.o
+obj-y += virtio.o
+#obj-y += dbg.o
+#obj-y += dbg_handler.o
+obj-y += virtio_net.o
+obj-y += virtio_net_fd.o
+obj-y += virtio_net_tap.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_raw.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET_MACVTAP) += virtio_net_macvtap.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET_DPDK) += virtio_net_dpdk.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET_VDE) += virtio_net_vde.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_pipe.o
+obj-y += ../../perf/pmu-events/jsmn.o
+#obj-y += config.o
+
+include arch/um/scripts/Makefile.rules
diff --git a/tools/lkl/lib/posix-host.c b/tools/lkl/lib/posix-host.c
index c2b579433b12..4d52b06c9944 100644
--- a/tools/lkl/lib/posix-host.c
+++ b/tools/lkl/lib/posix-host.c
@@ -306,10 +306,12 @@ static void timer_free(void *_timer)
 	timer_delete(timer);
 }
 
+#ifndef __arch_um__
 static void panic(void)
 {
 	assert(0);
 }
+#endif
 
 static long _gettid(void)
 {
@@ -321,7 +323,9 @@ static long _gettid(void)
 }
 
 struct lkl_host_operations lkl_host_ops = {
+#ifndef __arch_um__
 	.panic = panic,
+#endif
 	.thread_create = thread_create,
 	.thread_detach = thread_detach,
 	.thread_exit = thread_exit,
diff --git a/tools/lkl/lib/virtio.c b/tools/lkl/lib/virtio.c
index c5247665482d..a19943c87d95 100644
--- a/tools/lkl/lib/virtio.c
+++ b/tools/lkl/lib/virtio.c
@@ -46,6 +46,12 @@
 		lkl_host_ops.panic();					\
 	} while (0)
 
+#ifdef __arch_um__
+extern unsigned long uml_physmem;
+#else
+static unsigned long uml_physmem;
+#endif
+
 struct virtio_queue {
 	uint32_t num_max;
 	uint32_t num;
@@ -216,7 +222,8 @@ static void add_dev_buf_from_vring_desc(struct virtio_req *req,
 {
 	struct iovec *buf = &req->buf[req->buf_count++];
 
-	buf->iov_base = (void *)(uintptr_t)le64toh(vring_desc->addr);
+	buf->iov_base = (void *)(uintptr_t)le64toh(vring_desc->addr)
+		+ uml_physmem;
 	buf->iov_len = le32toh(vring_desc->len);
 
 	if (!(buf->iov_base && buf->iov_len))
@@ -304,8 +311,10 @@ void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx)
 	if (!q->ready)
 		return;
 
+#ifndef __arch_um__
 	if (dev->ops->acquire_queue)
 		dev->ops->acquire_queue(dev, qidx);
+#endif
 
 	while (q->last_avail_idx != le16toh(q->avail->idx)) {
 		/*
@@ -319,8 +328,10 @@ void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx)
 			virtio_set_avail_event(q, q->avail->idx);
 	}
 
+#ifndef __arch_um__
 	if (dev->ops->release_queue)
 		dev->ops->release_queue(dev, qidx);
+#endif
 }
 
 static inline uint32_t virtio_read_device_features(struct virtio_dev *dev)
@@ -406,7 +417,7 @@ static inline void set_ptr_low(void **ptr, uint32_t val)
 	uint64_t tmp = (uintptr_t)*ptr;
 
 	tmp = (tmp & 0xFFFFFFFF00000000) | val;
-	*ptr = (void *)(long)tmp;
+	*ptr = (void *)(long)tmp + uml_physmem;
 }
 
 static inline void set_ptr_high(void **ptr, uint32_t val)
@@ -579,6 +590,7 @@ int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max)
 
 int virtio_dev_cleanup(struct virtio_dev *dev)
 {
+#ifndef __arch_um__
 	char devname[100];
 	long fd, ret;
 	long mount_ret;
@@ -622,6 +634,7 @@ int virtio_dev_cleanup(struct virtio_dev *dev)
 	lkl_put_irq(dev->irq, "virtio");
 	unregister_iomem(dev->base);
 	lkl_host_ops.mem_free(dev->queue);
+#endif
 	return 0;
 }
 
diff --git a/tools/lkl/lib/virtio.h b/tools/lkl/lib/virtio.h
index 7427aa8fad79..be06ef09f8b0 100644
--- a/tools/lkl/lib/virtio.h
+++ b/tools/lkl/lib/virtio.h
@@ -87,6 +87,28 @@ void virtio_req_complete(struct virtio_req *req, uint32_t len);
 void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx);
 void virtio_set_queue_max_merge_len(struct virtio_dev *dev, int q, int len);
 
+#ifdef __arch_um__
+//#include <irq_kern.h>
+#include <irq_user.h>
+enum irqreturn {
+	IRQ_HANDLED		= (1 << 0),
+	IRQ_WAKE_THREAD		= (1 << 1),
+};
+
+typedef enum irqreturn irqreturn_t;
+typedef irqreturn_t (*irq_handler_t)(int, void *);
+
+#define IRQF_SHARED		0x00000080
+
+extern int um_request_irq(unsigned int irq, int fd, int type,
+			  irq_handler_t handler,
+			  unsigned long irqflags,  const char *devname,
+			  void *dev_id);
+
+long sys_virtio_mmio_device_add(long base, long size, unsigned int irq);
+#define lkl_sys_virtio_mmio_device_add sys_virtio_mmio_device_add
+#endif /* __arch_um__ */
+
 #define container_of(ptr, type, member) \
 	(type *)((char *)(ptr) - __builtin_offsetof(type, member))
 
diff --git a/tools/lkl/lib/virtio_net.c b/tools/lkl/lib/virtio_net.c
index cd720b363f18..18b69f98087f 100644
--- a/tools/lkl/lib/virtio_net.c
+++ b/tools/lkl/lib/virtio_net.c
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <lkl_host.h>
 #include "virtio.h"
+#include "virtio_net_fd.h"
 #include "endian.h"
 
 #include <lkl/linux/virtio_net.h>
@@ -212,9 +213,23 @@ static struct lkl_mutex **init_queue_locks(int num_queues)
 	return ret;
 }
 
+#ifdef __arch_um__
+static irqreturn_t um_virtio_intr(int irq, void *dev_id)
+{
+	struct virtio_dev *dev = dev_id;
+
+	virtio_process_queue(dev, 0);
+	return 0;
+}
+#endif
+
 int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
 {
 	struct virtio_net_dev *dev;
+#ifdef __arch_um__
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
+#endif
 	int ret = -LKL_ENOMEM;
 
 	dev = lkl_host_ops.mem_alloc(sizeof(*dev));
@@ -252,16 +267,22 @@ int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
 	if (ret)
 		goto out_free;
 
+#ifdef __arch_um__
+	um_request_irq(dev->dev.irq, nd_fd->fd_rx, IRQ_READ, um_virtio_intr,
+		       IRQF_SHARED, "virtio", dev);
+#endif
+
 	/*
 	 * We may receive upto 64KB TSO packet so collect as many descriptors as
 	 * there are available up to 64KB in total len.
 	 */
 	if (dev->dev.device_features & BIT(LKL_VIRTIO_NET_F_MRG_RXBUF))
 		virtio_set_queue_max_merge_len(&dev->dev, RX_QUEUE_IDX, 65536);
-
+#ifndef __arch_um__
 	dev->poll_tid = lkl_host_ops.thread_create(poll_thread, dev);
 	if (dev->poll_tid == 0)
 		goto out_cleanup_dev;
+#endif
 
 	ret = dev_register(dev);
 	if (ret < 0)
@@ -280,6 +301,7 @@ int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
 	return ret;
 }
 
+#ifndef __arch_um__
 /* Return 0 for success, -1 for failure. */
 void lkl_netdev_remove(int id)
 {
@@ -315,6 +337,7 @@ void lkl_netdev_remove(int id)
 	free_queue_locks(dev->queue_locks, NUM_QUEUES);
 	lkl_host_ops.mem_free(dev);
 }
+#endif
 
 void lkl_netdev_free(struct lkl_netdev *nd)
 {
diff --git a/tools/lkl/lib/virtio_net_fd.c b/tools/lkl/lib/virtio_net_fd.c
index f8664455e696..a19193cfeca9 100644
--- a/tools/lkl/lib/virtio_net_fd.c
+++ b/tools/lkl/lib/virtio_net_fd.c
@@ -25,28 +25,6 @@
 #include "virtio.h"
 #include "virtio_net_fd.h"
 
-struct lkl_netdev_fd {
-	struct lkl_netdev dev;
-	/* file-descriptor based device */
-	int fd_rx;
-	int fd_tx;
-	/*
-	 * Controlls the poll mask for fd. Can be acccessed concurrently from
-	 * poll, tx, or rx routines but there is no need for syncronization
-	 * because:
-	 *
-	 * (a) TX and RX routines set different variables so even if they update
-	 * at the same time there is no race condition
-	 *
-	 * (b) Even if poll and TX / RX update at the same time poll cannot
-	 * stall: when poll resets the poll variable we know that TX / RX will
-	 * run which means that eventually the poll variable will be set.
-	 */
-	int poll_tx, poll_rx;
-	/* controle pipe */
-	int pipe[2];
-};
-
 static int fd_net_tx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
 {
 	int ret;
diff --git a/tools/lkl/lib/virtio_net_fd.h b/tools/lkl/lib/virtio_net_fd.h
index 713ba13cca7c..fe6d6d8e3ab4 100644
--- a/tools/lkl/lib/virtio_net_fd.h
+++ b/tools/lkl/lib/virtio_net_fd.h
@@ -4,6 +4,28 @@
 
 struct ifreq;
 
+struct lkl_netdev_fd {
+	struct lkl_netdev dev;
+	/* file-descriptor based device */
+	int fd_rx;
+	int fd_tx;
+	/*
+	 * Controlls the poll mask for fd. Can be acccessed concurrently from
+	 * poll, tx, or rx routines but there is no need for syncronization
+	 * because:
+	 *
+	 * (a) TX and RX routines set different variables so even if they update
+	 * at the same time there is no race condition
+	 *
+	 * (b) Even if poll and TX / RX update at the same time poll cannot
+	 * stall: when poll resets the poll variable we know that TX / RX will
+	 * run which means that eventually the poll variable will be set.
+	 */
+	int poll_tx, poll_rx;
+	/* controle pipe */
+	int pipe[2];
+};
+
 /**
  * lkl_register_netdev_linux_fdnet - register a file descriptor-based network
  * device as a NIC
-- 
2.20.1 (Apple Git-117)

