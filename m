Return-Path: <linux-arch+bounces-13542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0386B55C2E
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 03:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD41B25E99
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAF193077;
	Sat, 13 Sep 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci0pMqa8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36D1339A4
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725185; cv=none; b=Qg+TiYlAEJvBocwlDn6psbGeCC2bELF2rOQGm8cM9JG21le36Rn46nfDGIc65QPBXJuZwyUtHVbW/3gb6CbjGCmePWFvA+moh8gXqpU09rqC62a715ypFIzRy07CCExpU/boMjvLqecRJ/uChiwUJQ/OQ9gXlexev1Z69MHUWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725185; c=relaxed/simple;
	bh=96PHKpKkduNWBMWlLUmXlhnRkmSl0kWQr4vXMbTyP8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9A7bwCCK9207h4IRO8sfo8X1bqepkldQcoAzM/ZXslTmMYbjs540HtZnzoNQbWc/FvgUpBFRmS9+cuhYyuzL9P1p4tmIBEwkLZ2eTMrlC8+zrQ/8GBkNbVZNr6OGlIqLCYx/X74pb0WZ5cMWGowVXdwkiah1ndX5cON3xR5ifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci0pMqa8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07e081d852so68051266b.2
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725180; x=1758329980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWPoN959WwxjoYegCw0rDaXLTHmPmQJSliJ+OqkRJY=;
        b=ci0pMqa8PcrROKjXJdT069LT+w8CTpISWITlbfW/qtYcYwN/E9/DcLWNr/TpFiq3Ad
         QGOTKU53qwruWOiJs5/ZIzTaYZOVhAin6txhF3hPH2+OOlejQh98VgHulezohlcdDX2m
         cVt2AZhT8uGbv4Nec92z8dbeQO4pbNjpEB22pjBywRVyKIrHmXfsYMflIYY46yePUVU6
         zdaw3mLA+fJrXUrEodmWoWb+jz/WCuthgKwyfcLoSI4ydp/v7D+ibgsafGt0CUUX2ZqN
         rS12SoggmKIRUIi+KHUDdtLvHiabq8s8eQgov8mHArCKjQL5NIxrYkQXHjJscrZKeMwI
         odwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725180; x=1758329980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fWPoN959WwxjoYegCw0rDaXLTHmPmQJSliJ+OqkRJY=;
        b=xB359tF3sRhmuBzNFreKIdDSlcpYJRJOpw1uKHaVL97vGUEgDLu4Wy3u7Uge85iv8e
         OCwOAeCsOlKR7qrq/YqNa7xUdM5Bb94sEa+JW0S/yPPkRP8STpBJeNBtSle73L8APhYH
         qet1QXPcm0sDaPTiF0/TmOmX2/WOPIzU5OUu4v16Wbbe6Nkm6CcrGVnx5Hte0iffvXqm
         uX+KveMdAA9I9yTOEM2KgHeyqv2F4cT1sAj0aG4TsiWDNyIeRi5ktDq7LzvBtJwSWbJp
         PX6OiQysmUN0HGFgRsGgz2jsnbZa5qxl/opCHVyznPSJ2jV5nNabUjEBPP23LDejD3Oy
         0mgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV02LOmql4X+F4kqP3vn62nUqSkRg4FKu5MsK2yX1GlvS0UxP/33bAt79zEZsco96DM5vHuOFrLL0Mx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FU+mRsEm/IJ6rQjgo9jDF+ttvNI9A4Q5pJ7i9EHRhqzdJchP
	Ubfgp8BJuoJPpddSPcD1GaRvHHYuVD/VfYCJIahwixcLNUAWTC3VOiw1
X-Gm-Gg: ASbGncsN1CVJ66Okcs8235BWCCKK+a3Xahcf+nyiaNfzYisLKtFNZJPy8TMtY9SVQmg
	4s/RXN8a6djbJRVVvN2OLlZrVVVmfM9FCpuY65XLAQk6Zdcv43gIPsr3mGYAwx891o1rhYpupA+
	OemiBS7gdxoKdFzB81UG/ZZREiYUUOTUot6gi0qyWZlp7ZGn5YyBXwfRBOPFVgf1VTrqUltxRxj
	8aG9xIEyLcGJA7GkQqaqpH+z8YUx/3J2tSDjmo5RXgIOBgjxFrmolxApUUcIQPfo6NssXz+eDTo
	dWGFeZ87pbSd/DpMjYGq3fWcaTuRP21M62lySUc7M1I7itnn01RdcuWXgjQ5u6y8vjX1VYTSyo5
	on4Vuso5ZTYUffmkw48s=
X-Google-Smtp-Source: AGHT+IGLvsatTRrbnodGqisgzpCsfnT+5kjCyZkQGsCYdRKthq/XXLBOPdic+fyhUVGMnj7YztyCUg==
X-Received: by 2002:a17:907:3f1a:b0:b04:ae7c:703e with SMTP id a640c23a62f3a-b07c35bca5fmr458205966b.24.1757725180390;
        Fri, 12 Sep 2025 17:59:40 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347a2dsm471368266b.98.2025.09.12.17.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:59:39 -0700 (PDT)
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
Subject: [PATCH RESEND 18/62] doc: modernize Documentation/driver-api/early-userspace/early_userspace_support.rst
Date: Sat, 13 Sep 2025 00:37:57 +0000
Message-ID: <20250913003842.41944-19-safinaskar@gmail.com>
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

Update it to reflect initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../early_userspace_support.rst                | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
index 61bdeac1bae5..0ca923c1007b 100644
--- a/Documentation/driver-api/early-userspace/early_userspace_support.rst
+++ b/Documentation/driver-api/early-userspace/early_userspace_support.rst
@@ -127,28 +127,22 @@ mailing list at https://www.zytor.com/mailman/listinfo/klibc
 How does it work?
 =================
 
-The kernel has currently 3 ways to mount the root filesystem:
+The kernel has currently 2 ways to mount the root filesystem:
 
 a) all required device and filesystem drivers compiled into the kernel, no
-   initrd.  init/main.c:init() will call prepare_namespace() to mount the
+   initramfs.  init/main.c:kernel_init_freeable() will call prepare_namespace() to mount the
    final root filesystem, based on the root= option and optional init= to run
-   some other init binary than listed at the end of init/main.c:init().
+   some other init binary than listed at the end of init/main.c:kernel_init().
 
-b) some device and filesystem drivers built as modules and stored in an
-   initrd.  The initrd must contain a binary '/linuxrc' which is supposed to
-   load these driver modules.  It is also possible to mount the final root
-   filesystem via linuxrc and use the pivot_root syscall.  The initrd is
-   mounted and executed via prepare_namespace().
-
-c) using initramfs.  The call to prepare_namespace() must be skipped.
+b) using initramfs.  The call to prepare_namespace() must be skipped.
    This means that a binary must do all the work.  Said binary can be stored
    into initramfs either via modifying usr/gen_init_cpio.c or via the new
-   initrd format, an cpio archive.  It must be called "/init".  This binary
+   initramfs format, an cpio archive.  It must be called "/init".  This binary
    is responsible to do all the things prepare_namespace() would do.
 
    To maintain backwards compatibility, the /init binary will only run if it
    comes via an initramfs cpio archive.  If this is not the case,
-   init/main.c:init() will run prepare_namespace() to mount the final root
+   init/main.c:kernel_init_freeable() will run prepare_namespace() to mount the final root
    and exec one of the predefined init binaries.
 
 Bryan O'Sullivan <bos@serpentine.com>
-- 
2.47.2


