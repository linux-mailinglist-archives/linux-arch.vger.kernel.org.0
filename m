Return-Path: <linux-arch+bounces-13557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B72B55D58
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 03:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B13A17B694
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD4193077;
	Sat, 13 Sep 2025 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvSr4bQV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2376C2FB
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726177; cv=none; b=uB2azyoJ/e0Mw/yPiBptCQasuYey/VwyCt6cszjE3c27B1751cthO9tNPNC1D/x+WEUacTf0Zfv3GvlBnBblzJwQMweafUoutbyZHls6uYDiiy/ts+D3e3+7Ydad76oETE488GLdTGDmEvd5xusa4k9Yx0KcfJswLR+t8y1+rv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726177; c=relaxed/simple;
	bh=EiIsazq+8AAIxPXReMMvw7uV4x0thFYUO8UTXtaH2NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlVHEvO5SFTJP/M/OVkCb2VQMTydmdoWBsLzKoKJuGvXjCpYzz35YqhYFvW9EIz0ePOFmotPzhxUp+fM9m0hRxxB+6wYVmiXhhOHGr/ohYiT+NbxjqdYqeyZU+CMSQSCQA2USJmaG/6UWokzOpznB8WajQVuTuLiVtmVzBrNKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvSr4bQV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so3763363a12.3
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726172; x=1758330972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjswgxWrFNOKRwzjkiuQ0bl5mmgWmo9Cqzfehf6N75I=;
        b=jvSr4bQV0NBkepgypf1ITx9wJFDPd8goYHDE3v7WHi72yPVyDxhnXpAqyMnSOr/KsN
         3OgNR1FpfEl7UVZvRliYvyPjFnA5aAz/oO6imykP8IPDQ7RsyvkOKBCfzkpcc37up4nN
         9XeN3SQrdwycGfKTtnZKbAnvp2wgZdcKuGGCoFtklFGvAYOUQobhPy6gswMgIlW3bH/A
         7W/CpoWHMNGfwNWxRdtCvLdIyBrRMG25Y0XMznqgy1VNw5ORUZb+Pgvn5Z8DqRRIFWG/
         kT29/ji3yQpFmGkd/nm/AGAqO5UV4tVOrKirHilAqIvHDHcpknTzHFO8zFVlVShmeFSy
         VEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726172; x=1758330972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjswgxWrFNOKRwzjkiuQ0bl5mmgWmo9Cqzfehf6N75I=;
        b=ITkdP0qEVveA53fZCAYOky1YM8KPwZO+JAt2ltdurGTyCEPgCrccsCRvAPpfViBTo7
         jJV9du5cZCHaYaoCGlS6Y/knvO7NpgZYtSYqP2SLlx1AYy/vJsJCYjioH6Z/HKZHd4GH
         ApfizQbAqZ7M8kt9z4HkZ6xg9ZqEgzuwyLQOpXqZhbBbOI6IN9YTy8S6IdsIfLUyrD+i
         aQvHqIiOh4XTGxWo0rwv89rgh23B74CRlaWwM4ba9nVfneLnHySmIetNZts+97PQ1xF5
         rUAloImSrI19MTGZ3ZUw2EJ07v3W4odsSVp/AxTq1ujKvULmybXsYTzw/tpcpXyzRGaU
         +K9A==
X-Forwarded-Encrypted: i=1; AJvYcCUgvG2mdTsFLIdZ8W5GlAJjRGQRNoueJBVB6oG/88vY58aEJKhbYQ6jaq7R7eEE0ewm0hZBDbevqOCZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeNCRZpkOMSGSXHjKtukp77UIwu3muVIjeved6jRqDhoOzTei
	7Iyr28tH6riIE81R1yzcBxz8hnCtuLXxUA7gbbORTbO0oPua9L74URtr
X-Gm-Gg: ASbGncubPC+oL3ZJVymEYEIsfuGOupN04gDbyfpz0BNu7MEz83VXkAtMxZcNxzkMf8e
	8FPSRNTDnKRnK3F4gXScQ+e5YMLnsN/M44PXNa2cH+yRgPPw4ODqgJVU4SeXtGMiIu1IhIn4qTC
	EfopjpmETaXz7rqteCultyeWYQlx0ehPIlJH7CBXeUG/RXz435gCekCVNeIWu6dO7+yQCcC2aLR
	rVuJNmG95n5HQBaM/eDM3nqfChiEikgXmhs/lfqeVUeOrOIevCZjvvL+UHSQQpfT6B0pDexYvsl
	N8jncILEx9B2w6bn53TMUHa7pVHmtNUBE2S1ORK6r7AcfAoXM9ATqYhG9/jfFdJlFKeRJUNdzbX
	Dwv9yKU149oPxu05NsF/Eq7ZZ4fjFIA==
X-Google-Smtp-Source: AGHT+IE1vl5AoL08hnxvihV4MKDaztrK6JygVC9P3kqlNeKyWBvnhpYqmVFYWjhHgbqbRt0/sx/2Sg==
X-Received: by 2002:a05:6402:40d3:b0:61e:ae59:5f07 with SMTP id 4fb4d7f45d1cf-62ed82718ddmr4360854a12.20.1757726172015;
        Fri, 12 Sep 2025 18:16:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ac2efsm4135647a12.12.2025.09.12.18.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:16:10 -0700 (PDT)
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
Subject: [PATCH RESEND 33/62] init: remove init/do_mounts_initrd.c
Date: Sat, 13 Sep 2025 00:38:12 +0000
Message-ID: <20250913003842.41944-34-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/Makefile           |  1 -
 init/do_mounts_initrd.c | 36 ------------------------------------
 init/initramfs.c        | 23 +++++++++++++++++++++++
 3 files changed, 23 insertions(+), 37 deletions(-)
 delete mode 100644 init/do_mounts_initrd.c

diff --git a/init/Makefile b/init/Makefile
index b020154b3d2a..09657c0274eb 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
 obj-y                          += init_task.o
 
 mounts-y			:= do_mounts.o
-mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 
 #
 # UTS_VERSION
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
deleted file mode 100644
index 509f912c0fce..000000000000
--- a/init/do_mounts_initrd.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/unistd.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/minix_fs.h>
-#include <linux/romfs_fs.h>
-#include <linux/initrd.h>
-#include <linux/sched.h>
-#include <linux/freezer.h>
-#include <linux/kmod.h>
-#include <uapi/linux/mount.h>
-
-#include "do_mounts.h"
-
-static int __init early_initrdmem(char *p)
-{
-	phys_addr_t start;
-	unsigned long size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_external_initramfs_start = start;
-		phys_external_initramfs_size = size;
-	}
-	return 0;
-}
-early_param("initrdmem", early_initrdmem);
-
-static int __init early_initrd(char *p)
-{
-	return early_initrdmem(p);
-}
-early_param("initrd", early_initrd);
diff --git a/init/initramfs.c b/init/initramfs.c
index 90096177a867..8ed352721a79 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -606,6 +606,29 @@ int initramfs_below_start_ok;
 phys_addr_t phys_external_initramfs_start __initdata;
 unsigned long phys_external_initramfs_size __initdata;
 
+static int __init early_initrdmem(char *p)
+{
+	phys_addr_t start;
+	unsigned long size;
+	char *endp;
+
+	start = memparse(p, &endp);
+	if (*endp == ',') {
+		size = memparse(endp + 1, NULL);
+
+		phys_external_initramfs_start = start;
+		phys_external_initramfs_size = size;
+	}
+	return 0;
+}
+early_param("initrdmem", early_initrdmem);
+
+static int __init early_initrd(char *p)
+{
+	return early_initrdmem(p);
+}
+early_param("initrd", early_initrd);
+
 static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
 void __init reserve_initrd_mem(void)
-- 
2.47.2


