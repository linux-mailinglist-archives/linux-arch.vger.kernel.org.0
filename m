Return-Path: <linux-arch+bounces-13997-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E534BCC65F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 11:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0309B3551CD
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926E2C325C;
	Fri, 10 Oct 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnAOXH22"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29F2C2356
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089342; cv=none; b=dGxUTtBHuPMndd5EHI7+/vM5QN3UWNxYMvbl+1QLMJffVSom0LWx9eesCWzcsxUQxWFQoFCCbdVU3lMngn48IEukZQJL/qe52p6cUI7xfbqdt+SriNuksgITwjUESLipKyTdy2HOeBnMuESX1YTOD9j17SpqHtRW6TSH3libDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089342; c=relaxed/simple;
	bh=vpQ+LSLHouZBwGQBSVAWIUVgEf6yUW/Fn0AY8RH0AoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XezJDeqGh4tLqqc0gnyk5fwBbNx7k7PFoVDVtcJ+iZOqJjpWbFoIVNQnWZfGkmBZAnmfswXhei6ymZeFIL8FIJ9BWDIqdvvH4gdZjpG3aNjWMIRaxyt7KLSKW4vq2eN8V3/iL44aPhnkOD39sh4gTVL17xEGRfl37PUB+bFExUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnAOXH22; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e52279279so12851515e9.3
        for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089336; x=1760694136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB+XQb9dVBYMVnL4S8fyMdF/923o0cYSVo05HxH73v4=;
        b=TnAOXH22joUBWeDFi3SJV91CLC4+/N0+FB/jANT4nnEvRw297wobaPMZhQcosUqoVn
         MfeMc68XOFLZ5wTi1GSj/sXxDUtSyRG8/1wEK/iqjAnPOeC35dmCFdhWA+zZjQ4kCmUK
         85plJ6WJV/Rd5RPq9L4Pi/eyWc43r9imFtFeObShrzKVKMEoQV3cERBfIwP10xUb0Ol9
         pBwf71B24jw7pRoP39HFculG6cDtNGvJzwuy5n8zZ5B1GXs7JrbQbLifqjPo6wKHBhpx
         XoHm1TISiXBZMj949r7qFjJzG7uPyPo+xQM4Mw/amx+r2cN1M5PfkaokgmGX4ykmGOmW
         Jcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089336; x=1760694136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB+XQb9dVBYMVnL4S8fyMdF/923o0cYSVo05HxH73v4=;
        b=uM2cudWG9h7y0OAHRYn7Cw1v/TijQ3Bn4XrHek+kf0OgjzPhn+bqdcBtD7Fntrk/UI
         tBsJk6mx48pWzf4Z5GsF9cUI+MSxEuWORadw0iTWbn2WaQMetl9kSQf+qh+1VRmG7AIn
         x/M23o+zpgx+SIfxqc8c4pRaiJ4VRTL4iEsDUnRkuKvjXhGQ6gKRIjruZGigWl6FS9P1
         SBKl7j2PT5YH1GnQGQIIGNuGtzZXW+z6fgoak83PbJsP7XIpZsAuW5Oyf2kkPbYMUkau
         Jrn+Ff4dHY3PDKl95rvCgSm6yeZQV9lTlkzJnCH2+aHuG+R0KKDPii/boohOH834uLVL
         bxUw==
X-Forwarded-Encrypted: i=1; AJvYcCUAOzR0J0JrbeR7vGQYpHQly4iyTR8qjqvoI3Mv42l5fBSyYyt8VqQmh0zW9wkjBA9zQfaUDs0/e5BV@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHvl+mrnawgl9UgOVGPWWgHjL51KkkwSc0c3luXkhUs1Tx+Rw
	N3+m7r9zhGSPoUklDAfTxnM7gdVkRuTMJQ6JjQ68eJB6bQwasKtyCtAa
X-Gm-Gg: ASbGncu9E71tXmRtZiQiwbe1amphENDkwdWzB1qmHBOUkJz5IL1kk1h6dYIrIln/i09
	43M2b0fON0WWsdOITPs7RRfwfzCex/xX1F3gvy/5w3JYI9wo2KFg2Dxg3mmqbJcG3VOhHxcocW0
	r55f04yERzQ8oVRDpviUJRV21GtLYPG7zeY/4H++JcZqhPmNo0oa0moN8L2ApqG4dPm5+3GETiJ
	u8OebSpWc4XvSp57SB/lLnn0tcFnKkQb0awQ0AA+V5YW7kHHdQluoJ9x/YG4BELPgRsLn+ZqpNF
	CSb/igiK1tmuQuxLFH4+/394IiAgtxHUZ0Xf/IvSLGJzNcEF2YrMqx5whkwnpIIDOz3UB/s0o3Q
	caJYg3acZ4uokssHtxbbcgB4eHBowOPVPwt42Ug==
X-Google-Smtp-Source: AGHT+IGhj1/Xta/HDezSCHmYKGPM6KRR6NesF+F9b2XmUayFL7V4iH3QP/fT9tINiA4R8cJX5aHPpA==
X-Received: by 2002:a05:600c:6383:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-46fa9a8c425mr74390025e9.1.1760089336065;
        Fri, 10 Oct 2025 02:42:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab3d7df4sm59813525e9.1.2025.10.10.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:42:15 -0700 (PDT)
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
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Fri, 10 Oct 2025 09:40:45 +0000
Message-ID: <20251010094047.3111495-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010094047.3111495-1-safinaskar@gmail.com>
References: <20251010094047.3111495-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

...which do nothing. They were deprecated (in documentation) in
6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
"rdev"") and in kernel messages in c8376994c86c ("initrd: remove support
for multiple floppies")

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts.c                                | 7 -------
 init/do_mounts_rd.c                             | 7 -------
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e019db1633fd..521ab3425504 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3280,8 +3280,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	load_ramdisk=	[RAM] [Deprecated]
-
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
@@ -5245,8 +5243,6 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] [Deprecated]
-
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
 			that). If enabled, the default kernel base address
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 2227f86100ad..4d720001c12e 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 6af29da8889e..0f2f44e6250c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -34,13 +34,6 @@ static int root_wait;
 
 dev_t ROOT_DEV;
 
-static int __init load_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated load_ramdisk= option\n");
-	return 1;
-}
-__setup("load_ramdisk=", load_ramdisk);
-
 static int __init readonly(char *str)
 {
 	if (*str)
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 19d9f33dcacf..5311f2d7edc8 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -18,13 +18,6 @@
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
2.47.3


