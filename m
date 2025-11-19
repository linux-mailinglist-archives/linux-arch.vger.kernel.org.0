Return-Path: <linux-arch+bounces-14966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E93C71429
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 23:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9183034B7B7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58ED306B3F;
	Wed, 19 Nov 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgdRSOo3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786C2ED159
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591176; cv=none; b=uVnSCraGmyDLDGpU7Dav3cfSfUjyrr/JBbS6Ryc1a+HKgJtsk7iM4nZlZXSXENSJ8Ft//wa5R1clIwXCko5wC51bYIK7V8Q0ZRDNLQb2nWbL5CKdm7QSseTsF+052oIhSeoVQqw+q5Hc9pBhXs+FSb1yFxycv6dNJcKcwgFVxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591176; c=relaxed/simple;
	bh=xFurCGxlKeC/tk9lJqwt+qhC4G1oERsMk1YgSqg0z4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAJgTrFRW4j1GLjLS9mTE1l5dDsRUjLujqlnh+vaF5o7IWbQ2YZOtbqfwP7B8zYrLoEyZHLY4MAG2zeUjlKpgkm8fOrKf+xR+GGyGGNeLnZ9b0IkHIJY9c/WWkTOKcN2OYBSaTC3kaGwskizbWmkHB/GXV91MhL5DG+E3vc6eQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgdRSOo3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5958931c9c7so147992e87.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763591173; x=1764195973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fApFH3gxVydnn6o27DJgEciM38Nk8T7NkdtS/0xgRng=;
        b=XgdRSOo3KGbkyKXW9NTfMPwrCoF+ME9Ff6Z95Hd2DDXm3yiKYsFdMFumhlzXFYu4yY
         qk4nR8ML+0w/VlVGuChigYUs9Pm7CmN5zHIMxV9Bi8jlxxcEwDbYDir8b+u4b8seDJq+
         /eZ/H2DR0N5X+blcO9tOEl7kUxjFS+rrGo4adWFAmkFMyHgzg/4eoUxGczDtev46zvaT
         RfVCn979PgY3uvo8YscvIvoq4RS8BYtHmhoH3ns9979QHm2jMpvBqF+5rYIz6jdRPeWX
         GiM+UuYcWK7isoqJIOOhubfl15n0vtcyS+k50EqQ7rzKneZ2OH0D1PTw0HWQpE5KOXwh
         q1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591173; x=1764195973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fApFH3gxVydnn6o27DJgEciM38Nk8T7NkdtS/0xgRng=;
        b=egwaEpgek3GHbukwphOC+03gbaJpcAiEoYkdnbbr6MCzv7N1IZdTxiolE9wFLUCfj6
         gf7sP8sKhPpia1KhSlkjvjODb/AEvc348zc7neWWg2RtxNJYb0NYm0Lcu3DZVbaE/dae
         xOLpVfBuJngtrG/Nl3o4xP02lnwLYng5xbf9oLPVX/j3/YgVqLOaFB/xMYMJIl4ukO2d
         iDL+IuJ5VhxY6kx5Bs/NJ2dC5uZFh1Wqg/JSEgAt6tQU3ZDYgl6ehngKvFydgOa3FMBu
         EruTR9DD4XG7T1o9jrUE/cyKtaVcftNbBpzp1bibVENXHh1DeAbU4/G1yvnZtu2owvX/
         4PvA==
X-Forwarded-Encrypted: i=1; AJvYcCX0bg/49vVlNPfZ6h7IrnWmi+Zh9IbcslnHKhMLN8ZqMmQE6N0NaULzSys7q2ugJn580oIy7xuorHME@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcFkWcjOHORW8bZ/J+m2SXSp4Lr3D8vPn1ZL9a4pB06ZfeCbk
	hpaoX5Q8BklQbojCk53Plv7fmRGsBBpfvFLKrnMCoQQ/UEvLg1Za/hxO
X-Gm-Gg: ASbGncth3rpM7B218sTuXLI4rCqf4fZx8UPYS98KUKGj78pVwebeE68ptNq9P941u+E
	I+4qcvhC6b6XYNyD8/n9MLQNTzU+BbZVSI8UmE0mzjY4Ofkm/mk4OnCtKycbjxhLCuy1fVRQq0O
	GH+It3TNE+/EVqj7qo3kz8gg3FRgiACNN8FqZSw07G4CmUF91FGISUuBF3O1/GXwCyTvauaYqe2
	qpI+TMrqWiB+TTctSccN3lp2VE9DbRH5G/uWWP+zcCH6Ce/TiyQOPHRmhNsbhem1kWDFMxIkEkA
	wkJW3QXTnBXbKL+fgwQjCrjaC4lMWotiN7v6g0t/aZAs0poDxBTe6Q33tFVmloviov95nwsl9R9
	pj4AGL0SmL3uv6wgePBwY2m/NzVTbV1q6DlpuverPsiocoj4dDs6/uWWjbCaIWU4c4YCp4vyPCQ
	2ZSjGMhxZpzeOHHeb0/+Q=
X-Google-Smtp-Source: AGHT+IFENZJ7RcpXWRmhUGxSKU8/+JjRXLl6S7aQ+5lvgaxElbnkwmTEZ8S5HDDyVaHfayjnh2Ye3A==
X-Received: by 2002:a05:6512:acc:b0:595:81c1:c55 with SMTP id 2adb3069b0e04-5969e2ae965mr219191e87.8.1763591172383;
        Wed, 19 Nov 2025 14:26:12 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969dbbedd7sm159505e87.63.2025.11.19.14.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:26:10 -0800 (PST)
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
Subject: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Wed, 19 Nov 2025 22:24:05 +0000
Message-ID: <20251119222407.3333257-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119222407.3333257-1-safinaskar@gmail.com>
References: <20251119222407.3333257-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

...which do nothing. They were deprecated (in documentation) in
6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
"rdev"") in 2020 and in kernel messages in c8376994c86c ("initrd: remove
support for multiple floppies") in 2020.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts.c                                | 7 -------
 init/do_mounts_rd.c                             | 7 -------
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..15af6933eab4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3319,8 +3319,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	load_ramdisk=	[RAM] [Deprecated]
-
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
@@ -5284,8 +5282,6 @@
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


