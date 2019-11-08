Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8408DF3F5E
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKHFEi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:38 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35937 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfKHFEh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:37 -0500
Received: by mail-pg1-f172.google.com with SMTP id k13so3305688pgh.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACZAISagAfe2iW/saInxEcZgIbF4droeT3JQrl85b5A=;
        b=HwF69RKSOrNIIBTWOYqaX/I6JyGp2lw0SzRtNC7HkzZ2GLHZQs1X/1kpTsfCyTRk+U
         ZoDI/E/IEFetTIGOzxNFasgB+9DVvw+51ddZXgbQTpFmc/bXvRtTdOd4T3djB2ra2uxS
         tA6SBekhYqtMUSrnzyZ5yIMNxY3QW5SbWYTia9CXczyzhoeFCYiMZ81SAIW0+pPQBGYg
         xmvcD9QbteMniuPs7nlsd8UqFiyf4HMk2RASS3r0tZtPXdBQkcC2FadlnTxt6RZ/Uu7f
         W3xwBzr5cOaHmObtxlXKdCalV8RkiByQlPN4cCW9T+d0iIF9AVdM6eCPO8cRhuWJtpDr
         p4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACZAISagAfe2iW/saInxEcZgIbF4droeT3JQrl85b5A=;
        b=JzmyOeisb9ftX6/44SKFz+2ZGNH0C3+w8pbfGUFOE2qlYydJygHl9F95oM3TqoyyFx
         admkMVox2u/XAHLxJeOMyipSu8w+iik0O0BBLajlaWngrvSiqTTiUOpqQEw04jAGoTeK
         csI+i79lXz4TyJsWKDSjvRE6yfDxK8R+cawlekMXfBtSxqCW9PPWiREkWeWFBuhm+3JX
         GZEOt/hAuRnSm3cI8FEQ2gEMIoBZFv5/C5ppCF93TQNAff9noxKWrYBrXwm8+9IvjXtp
         U0mzA6CsT8w0hsJZBMmxzpWiwIG6SSDKUhzAWg1XXf//87mmmYdwVjhI6ARPTZvNbmn/
         yFAA==
X-Gm-Message-State: APjAAAUtk75EvSz4XnJj4RmS0TkcRQNpcXG5dIEmQZVXxW8foOXz3AhE
        rrmdSH4rDhzhT+krPMyZiTiNC2f/Hwjvtw==
X-Google-Smtp-Source: APXvYqyeoaGzCkkxAylnZHoTgcXpiKbJUWM2i1rI/cdQ82EUVJDSqfa5xgAFfmcyUpI7jCchTT3tng==
X-Received: by 2002:a62:1953:: with SMTP id 80mr9399812pfz.72.1573189475106;
        Thu, 07 Nov 2019 21:04:35 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id p5sm3708064pgb.14.2019.11.07.21.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:34 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 06501201ACFEFF; Fri,  8 Nov 2019 14:04:33 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 37/37] um: add lkl virtio-blk device
Date:   Fri,  8 Nov 2019 14:02:52 +0900
Message-Id: <61b15bfb52c7f1f066685c90a1cfe8346b3faec9.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now uml can use a virtio-blk device via 'vubd0=<filename>' over
virtio-mmio driver.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml             |  4 ++-
 arch/um/configs/x86_64_defconfig |  1 +
 arch/um/os-Linux/lkl_dev.c       | 56 +++++++++++++++++++++++++++++++-
 tools/lkl/lib/Makefile           |  6 ++--
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/.circleci/config.yml b/.circleci/config.yml
index 9753543e8198..f2fe39fc2bee 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -141,7 +141,9 @@ do_uml_steps: &do_uml_steps
         if [ $CIRCLE_STAGE = "i386_uml" ] || [ $CIRCLE_STAGE = "i386_uml_on_x86_64" ]; then
           exit 0
         fi
-        ./linux rootfstype=hostfs ro mem=1g loglevel=10 veth0=tap,tap0,0xc803 init="/bin/bash -c exit" || export RETVAL=$?
+        dd if=/dev/zero of=disk.img bs=1024 count=20480
+        mkfs.ext4 disk.img
+        ./linux rootfstype=hostfs ro mem=1g loglevel=10 veth0=tap,tap0,0xc803 vubd0=disk.img init='/bin/bash -x -c "mount -t ext4 /dev/vda /mnt ; ls -l /mnt/; ip addr ; exit"' || export RETVAL=$?
         # SIGABRT=6 => 128+6
         if [ $RETVAL != "134" ]; then
           exit 1
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 917982b6cd60..e5b7c048a701 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -75,3 +75,4 @@ CONFIG_VIRTIO_MENU=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
 CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_BLK=y
\ No newline at end of file
diff --git a/arch/um/os-Linux/lkl_dev.c b/arch/um/os-Linux/lkl_dev.c
index 698062917ed5..e08f113dfc0b 100644
--- a/arch/um/os-Linux/lkl_dev.c
+++ b/arch/um/os-Linux/lkl_dev.c
@@ -6,6 +6,7 @@
 #include <os.h>
 #include <kern_util.h>
 #include <errno.h>
+#include <fcntl.h>
 
 #include <lkl.h>
 #include <lkl_host.h>
@@ -14,6 +15,7 @@ extern struct lkl_host_operations lkl_host_ops;
 struct lkl_host_operations *lkl_ops = &lkl_host_ops;
 
 static struct lkl_netdev *nd;
+static struct lkl_disk disk;
 
 int __init uml_netdev_prepare(char *iftype, char *ifparams, char *ifoffload)
 {
@@ -108,13 +110,65 @@ __uml_setup("veth", lkl_eth_setup,
 "    Configure a network device.\n\n"
 );
 
+int __init uml_blkdev_add(void)
+{
+	int disk_id = 0;
+
+	if (disk.fd)
+		disk_id = lkl_disk_add(&disk);
+
+	if (disk_id < 0)
+		return -1;
+
+	return 0;
+}
+__initcall(uml_blkdev_add);
+
+static int __init lkl_ubd_setup(char *str, int *niu)
+{
+	char *end, *fname;
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
+	/* <filename> */
+	fname = str;
+
+	os_info("fname=%s\n", fname);
+	/* create */
+	disk.fd = open(fname, O_RDWR);
+	if (disk.fd < 0)
+		return -1;
+
+	disk.ops = NULL;
+
+	return 1;
+}
+__uml_setup("vubd", lkl_ubd_setup,
+"vubd<n>=<filename>\n"
+"    Configure a block device.\n\n"
+);
+
+
 /* stub functions */
 int lkl_is_running(void)
 {
 	return 1;
 }
 
-
 void lkl_put_irq(int i, const char *user)
 {
 }
diff --git a/tools/lkl/lib/Makefile b/tools/lkl/lib/Makefile
index 3c35d49843cd..be6cb4b8f4ec 100644
--- a/tools/lkl/lib/Makefile
+++ b/tools/lkl/lib/Makefile
@@ -4,9 +4,9 @@ USER_CFLAGS += -I$(srctree)/tools/lkl/include \
 		-Wno-strict-prototypes -Wno-undef \
 		-Wframe-larger-than=20480 -O0 -g
 
-USER_OBJS += fs.o iomem.o net.o jmp_buf.o virtio.o virtio_net.o \
+USER_OBJS += iomem.o jmp_buf.o virtio.o virtio_net.o \
 	 virtio_net_fd.o virtio_net_tap.o utils.o posix-host.o \
-	../../perf/pmu-events/jsmn.o
+	 virtio_blk.o ../../perf/pmu-events/jsmn.o
 
 #obj-y += fs.o
 obj-y += iomem.o
@@ -15,7 +15,7 @@ obj-y += jmp_buf.o
 obj-y += posix-host.o
 #obj-$(LKL_HOST_CONFIG_NT) += nt-host.o
 obj-y += utils.o
-#obj-y += virtio_blk.o
+obj-y += virtio_blk.o
 obj-y += virtio.o
 #obj-y += dbg.o
 #obj-y += dbg_handler.o
-- 
2.20.1 (Apple Git-117)

