Return-Path: <linux-arch+bounces-13526-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3BB55B00
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 02:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C883AE7CB
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 00:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3927081C;
	Sat, 13 Sep 2025 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyeGCvQG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95B70824
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724138; cv=none; b=E8OqX+sQljcg3kT4al6m6w8gQZeBB7xi2jG/7KUZ9z4MjZTu2DyzP3BQ+qHIaE2AxBdcmIXvZf16z/YH7l6NGzIhVMSFLxQWOCHhJF9epizBkJlXCsk4s4yN53aDMtatixh3FA4W3Gseu8Lpt0iEM6Kh0lg2GeS03CXAEJBV3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724138; c=relaxed/simple;
	bh=e1WCcnLcnFd6vSa9GXhjG8apiPFNDP8cBSBGKhm1A0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVRLc6IjcC0vOnGYixQyOxiAO6VnXvQHUgLFwkQ7Gh9lu6mAfNO8XQ5zsR+Etwvpg5Rup8AxfatMv9dQafmZSoqsPQTZwR3XErVn3vom9odrbnxeHY023Yqtnux1jVyShmiK+5Rlrysc13kf3Wac7Ab1cViMLPe991KvEscpZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyeGCvQG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so4832128a12.2
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 17:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724133; x=1758328933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq4EBZrV1lfKd4Zb7NXCMDMChiW0nY1yh2iMeYqfP7Y=;
        b=GyeGCvQGXPHBE41J82uu+Cjbau22HxWpjhgX2wShnOnO4nzZNPtLm1DRkl0+F/f0ca
         rzTX4IdzFdI9MG903XTJiOZcK5xECFwTp7RGpXsacOpGSgDlUfHyfZnyrIb0PYq/WIAN
         rDX+MYuGDBcb+iUGcR6M5gc4VKjsz8psWUCkGGc/btj9eHPCaKx6ZV5sPuMli9kMuw9b
         06Fgv281fvFrk0DBdieOCo+ieWCGggnxq7xulicoHGHbeILgKLmHPVtkyPrDlx6PYrxZ
         V0TXTUp8w9m/9N3a9Fuy5mhVTEj1Rc7h9WUHnTB8yzGtVTwDvxGd9R0AnOsDNxCdz+MB
         Idsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724133; x=1758328933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq4EBZrV1lfKd4Zb7NXCMDMChiW0nY1yh2iMeYqfP7Y=;
        b=JobIUiFHCgyMJJsumm/HUeG+jc3GNlpt7PWOVyknbVYCRMSlsDJ1lDNYDrieRWEkJP
         3jVxiRQjO14WD9sjpBk0kT7eDggslwIOwTPmhz2NSAZx2PfY1lND+U7fUU0IrMusWH40
         kfe67T2rds0093DEBvrwyTAztEVMB0X7yjbPcNoQvuNLYhMa7u7ZR9p1QPy0YgX7t+O/
         EvoYdRYRwK93m0cmPFwEm6g+tu/F2FG96jdbSdQPzlXmqyRkMcBEH8Z/B5ACgQpd2Qkg
         d+XzPuY1p/5iXHPyEiopTy7rl89NQHUKQabcJ8Xd/zApH9ubHYbh/O6gY/P+d5+I5aay
         RUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ErN2mZWJMRKpVG1y2nGDOI60G0rNXur6uRbYs4sbLgaDXMKGvMUhgWvJUgQd55BolfZDQ166bBlU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PwtzSROpAMLeZMPnHSKhYqvsBmjTynwFAI7x//KS+S9Vf8qB
	uL9yT4Nsk7bvk5U5B1fdCtMU6JmtrC5U17SepcAOwjxvQA0kUjhASoRH
X-Gm-Gg: ASbGnctuMPtkkj2zze8o/1s0WJcA8HB1Nt87OhZBlWEEaknOwkAo7WPNpUugMbwL4tY
	9GxDN1LNfs2Q3uaKOUS3QSzl/b2mm1AzTmtrfk/JJZ1Y/mo6EMdZH13JOVYv3ufEnENrqtD7rsM
	KIPYiaMOz0O/tmJ/3zgO+FCc4S6vRXF4jcfRLq3A6mPiNK7qcoKnnI4hlZFqCNlB81jqW8u9REB
	t07Cnrw6DHHzhQawd/JsoJHGBGDxYTffjsWHrJZFFDHz+I4mzUm2Bkud1aOIlrk8EHGhOAGSo85
	ohCa3vaPvHyv5Kz8p54y0xVxggTDS37ZGE2jUINqEAL4cA/DPFpRP1hDnr1NcQXhbWHaK3yYC14
	k5OA1xYLpBEWDg3YY+fo=
X-Google-Smtp-Source: AGHT+IF0YGOwgI/SiDLzLobCRbGCMEuk6UiMOqwXQtTxtsbaeH+eIG/iAAo9vQw+zhuCea49+yp7bA==
X-Received: by 2002:a17:907:2d2b:b0:afe:8761:e77a with SMTP id a640c23a62f3a-b07c35833dfmr474345066b.19.1757724132448;
        Fri, 12 Sep 2025 17:42:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3128a5csm466901366b.37.2025.09.12.17.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:42:12 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 02/62] init: remove deprecated "prompt_ramdisk" command line parameter, which does nothing
Date: Sat, 13 Sep 2025 00:37:41 +0000
Message-ID: <20250913003842.41944-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is preparation for initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts_rd.c                             | 7 -------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d3b05ce249ff..f940c1184912 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5229,8 +5229,6 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] [Deprecated]
-
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
 			that). If enabled, the default kernel base address
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 16f7300239da..4d720001c12e 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..f7d53bc21e41 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -17,13 +17,6 @@
 static struct file *in_file, *out_file;
 static loff_t in_pos, out_pos;
 
-static int __init prompt_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated prompt_ramdisk= option\n");
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
-
 int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
-- 
2.47.2


