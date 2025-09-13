Return-Path: <linux-arch+bounces-13553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFC2B55D0D
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 03:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8274FB61ECE
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ECE1C2334;
	Sat, 13 Sep 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUORZv5M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3442745C
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725910; cv=none; b=GhlmlvmNUkGaxk+Te4RqTtuzlAWNPgeMTMd2zPDhfDljaBJzJeNooHE4GwL4wR2goTs+7W0aFo4QZ8ynybPmtplcYKq1UAL5caFHWSMd5MwTqxE+6V5Edy8kHtwWGpWw0gsgFMZds43UPhs1I8SAxoiaFCW2aHUTiAsKHhEsObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725910; c=relaxed/simple;
	bh=KpML4fn90471dg944P+9+9FByq3Xjb/jBBYn5xTeENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai2rm1aYNvP8HhmBF/ImmYG+2eW2JD65vyYMO2Ggagu9vqzbOCJ2jTMefwE8Veg4w9sHpjNuNelpEFdzc7yHqdBKqWI3siN7GUPV0OysEPyvCB+FLXZQPEs0D5RGf8PyivnODTAz09ElD3hlpzxqTKybwhMIdlCQwMCJ3wP9ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUORZv5M; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso3680350a12.2
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725904; x=1758330704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=;
        b=aUORZv5MCUdwsV0MU7oCzj3ZTm7w3ESOPYBigQlqMxPsAavMDyHGJgEYQWATfs3+b/
         biPBcBrCE9URVMoH0rqHehw0T1BRhiZjlA9durZSP0yEkzERpopJvyeRh9qFGG5oSCsQ
         OuIa430sEthMDEkIZDIQQAO65i2svbWCQtUDobiF+pJzf/eh+f2Qg9BVDr0XDXs5AJy7
         S+eE8Bk/nYgSsoMihCGJb0SQb6wVy+gefAADkk7B44V5PV1ioyXUHisNSxZuDoeNZtpw
         pk7wtMp9HCPO+M4hoY912LuHIIjWkZVXjLrL7AKM6klm1vtlLotKzYFANlld9p+SFPzp
         US6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725904; x=1758330704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=;
        b=BnyLLqCLvgdFZQltWv5ixhH6EJ6+6MPnHyOXIigF9ArMcX/ol/IOhta/szHagyhfkC
         dKUG3I6TTpnF/XpC20DcrKs3dQ05MHnaw6ow2hzFN1OG7XC7RieNmIygLts/8Yn0p//h
         LXDrYaH+BfSdFwSwfdRYMIHiY5i2rNEoxU2/eaVr/QodMDZOwIw5pO0rbRdASJT6siZZ
         e8OWoO7cSr2kSYj8hOneNq4VQUrvh0OoeFtOVp1X5tG9wPGWxAuNF2T0AVE8RePixUeI
         FPZxFEyvDVJ/u4izGuJCgHWJWp+Vw7c4DEt1/XAmzfhil5cVsfD+Az5cMrl2F+b8zSkA
         0iCw==
X-Forwarded-Encrypted: i=1; AJvYcCX18aB+04bAOZPtQjqxHkr7kMyqYFz4heCULIYp8Bu3aqTafkPOsia83PXSxyCQLZWNsLn0nKBq43O6@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7kvnv/tQCkdv+TWvMBqsgniu2rjCw+BFR3rCO90LErdetKfV
	kSwUDStz0YvHWdgm/Lpi3ze+QrLd3m8bETdiSPu6BnTZ5krmRRFAT8k5
X-Gm-Gg: ASbGnctdLnJWSkvUc8MIOe6yNHDDsOyQyzz8FXDWvq5s3246ge7W/wRcYKNbljo0kRf
	Z0veao6UVNM/vp5c7qMSQaVVa8PkmgR5ic6UOunW3x+Rz0RhjVT2XB+t68AcwwiUT5pGxFiuKEj
	4q7PCYvaBMXsIYOSODOwWauq9fHSGx+n53rdn+ANL3BiJY/7+vsgajQL44UR0oM2Rr/DuUtCGkP
	1i9jgyuN+8JIO1b70nhxJ0HzJIpcIh+1pxlJ5ayCwgtJlKK3QKL7eg53BoN8OjdL3itLtQU6A2u
	hB0i8qt9p5ubmmXm80qHypcRzowwEZ6+ogUKGfzeYO961QBKDiYgqdy7NRWyKiMD6l8uXUuKXg1
	TkyydbVbojZ6D/eL4dMM=
X-Google-Smtp-Source: AGHT+IEEs4w0VYWOrTZ2mf5mPdRdgIBBMsi5zMJEle+Jt2EK6Q+4TbCNWtdbvmdxcJfUUMXxxDwLfQ==
X-Received: by 2002:a05:6402:5242:b0:628:a4fb:3b44 with SMTP id 4fb4d7f45d1cf-62ed825998fmr4990182a12.1.1757725904210;
        Fri, 12 Sep 2025 18:11:44 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62efb5b8b0asm913566a12.20.2025.09.12.18.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:11:43 -0700 (PDT)
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
Subject: [PATCH RESEND 29/62] init: move virt_external_initramfs_{start,end} to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:08 +0000
Message-ID: <20250913003842.41944-30-safinaskar@gmail.com>
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

Move definitions of virt_external_initramfs_start and
virt_external_initramfs_end to init/initramfs.c

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 1 -
 init/initramfs.c        | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 8bdeb205a0cd..535ce459ab94 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -12,7 +12,6 @@
 
 #include "do_mounts.h"
 
-unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 int initrd_below_start_ok;
 
 static int __init early_initrdmem(char *p)
diff --git a/init/initramfs.c b/init/initramfs.c
index 9a221c713c60..d2301cc6c470 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -600,6 +600,8 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
+
 phys_addr_t phys_external_initramfs_start __initdata;
 unsigned long phys_external_initramfs_size __initdata;
 
-- 
2.47.2


