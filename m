Return-Path: <linux-arch+bounces-13525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC7B55ADC
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 02:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003305C36FF
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAC38FB9;
	Sat, 13 Sep 2025 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeLgkTBj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086EF3596D
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724072; cv=none; b=jKMhBkMfWZyraIzPQglNBRIEn8lFYuiICptcyJQOsgDBmwamme5Epj1QafqQ4O4zJX5cDLn101ng5DHLITDtSjxkFMGSDIdwVXoPOYR+lusKXFV5+RCrcKgGE0i+ZL60op2Z3iYAbwRJd7zF1CFafxVHoHRVvPq9NmINViOdLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724072; c=relaxed/simple;
	bh=yhXDovoFaZRmENn1P/7nJEAYKmeDJf//ZQgmQHs9gQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey8FTpHsquBGWb5tu9mzNTnKDyZNUD4JQ+0NGWUo4hLXXRsTgn2YBSK78TK8JZVpIuX/YskMtO9v/jSHnVBrKOK5J2uxZ8gt8e/QTltbH/lcjOce8WWwX9iziAjEGEsIDSr2GDa6FyL2Oiw7qvOri3ps78D8e8M6gxo3FhfpD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeLgkTBj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f0bf564e4so144752a12.3
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724067; x=1758328867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF39SoyvPO4HSizOmVkN9E4c/OCzbmGR6ZiNtCSz3R4=;
        b=LeLgkTBjsbam/V5tjmeu8XIRmYholHa/MziO3vhNLx5+7IbFpOtKfvXI6IrpHYIUf/
         w0rub1UynMtAbnqZl0+0PEKjR7sjO1hDuG9eElIdzeyC0wh6NG1DuL8tEcIgm7WZYVAE
         bRBWL/udapdFPjuWEKO++d8TuIQS91RBSpbwR7sXn474MD/kcz0hDjdCJXH/lQ7yNoZi
         KXKJ1sA8T4zBNUMHbJQ4WOYJyT6o8usyOrgUfIFqdFV+U+h5h0W8y20o30fXs6WP800r
         jXpUaYNhR5jQRBjTvKWUuFsdqBpRR+uQchb1e5zzEGRcMjEDpLUlPDG0wtBXsi6qN3qd
         +2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724067; x=1758328867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF39SoyvPO4HSizOmVkN9E4c/OCzbmGR6ZiNtCSz3R4=;
        b=qIzOXN3M2uHKsfx+lZXEBS0HajxzTrIEfOrbSKqYYbmn2VHwI/JRrPjRhNVF7qXf5V
         wuXa8Wp3ag+8y4nM8/IevjWP7hQVQxrBVji0XjH9JTYchf5Gwx87/GTdmyAk5QUl629l
         8o1nWTzcK/fcWYAbt56AbpnB1cqjIE4v1oseTR1o/7zppuQr21Ps3SYDZljtT1X9Q3fS
         Q4/cjlU3QjgW3Rg/1dM3XEHMkzc4As1SAEbwu8i4OZYfY0AEHfj/ri6XuQXeHwrWfvKJ
         iTMVW72AqZ9GRz7ws1Pfly/H5f0sZm+p7q0jQwYLV6oOukuEHSZPK6Ff8nFAa2RfX4+J
         zKQw==
X-Forwarded-Encrypted: i=1; AJvYcCXvPjGx2CMH7Iww/GlFKYJxKfkYW/CE1MtuGIrQ4mBdMNysFLe9d4f3Ne2rIMONAvut9H8TjXSyvote@vger.kernel.org
X-Gm-Message-State: AOJu0YywfSt79DCwt/bQ9/kQ/g8u2m2lVEwgXX7A/i0rNGUOY7sKPcxs
	0vNFLauO1SIxOO2K0UxEhGJ/OmAw3unARQhAutAHynrm/vWVMf9e1A1j
X-Gm-Gg: ASbGncvKmugLtv6K8WTgr7ku/up4HNBZTrMXpnmuGAKZr2mHOfV7QhwzkHoh2VACTZU
	QR+2C+WchwI5slJ8ztk0fpQs9czh2Ps/NTJUp+DOSSt2GlqHRuPhlB7cXMSkUejaMj8VZkRWBaM
	n8X2+5l4gkQ8mScuZf6Ai5Ccy5k5NChSnIia47ifXPWl8FDjG9MDnfEpaJT/b5wo8NBM8kxVXS1
	ba94KZB3gHHx1C7WgA7f3TOlpfWR6ebDAUQmoKZfi3ilGc2Hxclt4x0hE/Ih6oV/dGLpLXPhxKV
	4GQHsM+xXMPu5+DQEZLD59eiqTzoECpF51ndmkHt8mhC10a9UQzM+DDoJct1gWZbPYhpbIFlEtb
	iv8pMk/Hjqis5SZibi28MDhwbCamaPuGsZbsmFfj6
X-Google-Smtp-Source: AGHT+IEtE+sLJ/l9Jfm7JaiF1fYpyMVV9PhBGBMQ2H0UV0Mi6JbllI7aH7Kqq18B0Ua9aQ0IxOB0Jg==
X-Received: by 2002:a05:6402:3552:b0:62e:ed2f:a660 with SMTP id 4fb4d7f45d1cf-62eed2fa993mr2339876a12.11.1757724067127;
        Fri, 12 Sep 2025 17:41:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f0c7a5546sm189920a12.43.2025.09.12.17.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:41:06 -0700 (PDT)
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
Subject: [PATCH RESEND 01/62] init: remove deprecated "load_ramdisk" command line parameter, which does nothing
Date: Sat, 13 Sep 2025 00:37:40 +0000
Message-ID: <20250913003842.41944-2-safinaskar@gmail.com>
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
 init/do_mounts.c                                | 7 -------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..d3b05ce249ff 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3275,8 +3275,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	load_ramdisk=	[RAM] [Deprecated]
-
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 2227f86100ad..16f7300239da 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
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
-- 
2.47.2


