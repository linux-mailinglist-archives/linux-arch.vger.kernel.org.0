Return-Path: <linux-arch+bounces-13584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A7B56582
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 05:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6184E10DF
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 03:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D126CE2D;
	Sun, 14 Sep 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRPnFhfi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F479CF
	for <linux-arch@vger.kernel.org>; Sun, 14 Sep 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822233; cv=none; b=gJ+ZVAn45W2mjIT66BcEEWeuJFGwbJN/MTcO1qAxEqfkadKsncZzZrd1eXqZFHxPxC6I2HrlEM+RfddPDySRSx8gxUoQbiSdjKeBBJKkZCvwTvEaCCpkAINDp0EyD55dYY7uk2xQZTjWRsWVqYGnH39FCP82NaBB7Db/DelqKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822233; c=relaxed/simple;
	bh=6pXJgBOVmgKyryw3LURicaeyD0WS1HvzY8WG0GWatOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE+nDsnkON6jMLHfyQjn/rpBERVhRWW+tih9ujiOvUBuoG0CTKSz+i8x4cFZdNaXPsGUJJ8XzQ0HtxJUY2F9w2+Okn+/TyRq3R35T/sKrcHC+XmxATzCCK5h+4cjSFtBtIs2Kp5nWUAjWL2nK1Hifw6RWg1zROqxkGQ5MgYbQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRPnFhfi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07e081d852so184009866b.2
        for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822228; x=1758427028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=kRPnFhfit7+R6UzkS4cF3DKL1S7JHip+IAyQf6T2UGYDd+vYI9IC8v9G51KVb5WDAk
         RN/gPz1lGKSMFe9Oe7MIowDwv3N0e4/KFS91xhYm0G+VoSkSei8WkHktPa2wEMB4pNUj
         WzAE/ebYcnJlcUWXpTXxg7oBxbqGV3WM9sIv1WyWWMlOmd/DBHQ0UO8HJ8wtmu7F5pSQ
         pAM88kkn9raeM/jhalMJUOdMS5VqW/+AUemoRwnUmW0/oDdl4OSBi4zM++ZdXBaXmYLj
         VGYSY1r8rSsi6oTo3enO0OXT4w2WPUK9VtsKTo5k8z5kW918njUd5UMO2sKFBB8AaeWA
         2SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822228; x=1758427028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=ZD5jGIXKx347C3Am0tX4PP68OPU7ARUihDWHn1G4IEuUw5KQacRu4Q4JTWyCuefzIs
         xCkMZk2flNGSK0+pZiJ9kb1O1FB+Kvse0QbeM1ughkWnBu2CB+NnSJNHIW2Qvj/IeKGz
         kPhmlM+HJyQxaGQKOpYQnILYvLK60xunlPbVwNe+xfFupcFYnOj1zTA6+kWpZS5lP4X4
         7np5kQXyGlcOKpxc5NQhUzsWRtMs1LOjuOXngV1jeDHjPVdeIZN2ciS2hdiU6accM5Db
         reJlItvWNwkcROdGPogRCrF9vJ/VxDwrEWGnPFjVzoKH0OSaASokMBLXeMo/pjSR23gX
         lmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHHACAaxo7Ro/7FrJINIgUsrkBbhvA7Fdazxz2fXQkAv0GorL9CtzW5JS1b+JPDEzLbNE6Bjz3C7NO@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxY138biLMcjoFwibHWJnYeI+vykjcu67ceBD+vfeFdKNK2ek
	vxMoyLPBSZ/oJA9yViO/ZMO5OfkfcGxvY/FrBkM6UR7tq+xTiIW58rGC
X-Gm-Gg: ASbGncs1nHdAc0r8XUAf/yaRpeAhVAK/3pYPmGJL4arlnmaAxv2FgGenvXatfJpl7Di
	8sH+BWHcQUZpcyEz1EixQPrYeA2IOQSGolZrV6FiGQlqa1JXLpDwLxS/n7izkkjt/T599bSap/w
	9efWpZSeCPbDA6JGYszgD3nf3q4CbGQdQXm0RoHJ2ySz32R+PAmUDm+Le2tcvmvK53uw2XrfIsq
	13zXwnDud/ihb/pJlUTTvgBLrYZ703NytSkSNvOpnngHOyQ6mLV+poeM1NBquMQLvcWqHhu4HyF
	twbJXHk+5SPd9JxIO5iTlVl6YD8f9uExy0uO1t+mIcCNdk1ryXjr24FwMK6ktTasvR4ePeRdvcr
	RXtAx0B9ENoO1BxH6kj2Z49EysonqSw==
X-Google-Smtp-Source: AGHT+IHHnPU+sOVT053l7deT3P8z3LJVFAOiksWjmZKd0Ub2gBIDgZK1/4gCPHfUrNaBqPQVOEAIKA==
X-Received: by 2002:a17:907:d16:b0:b04:6338:c936 with SMTP id a640c23a62f3a-b07c35b8e53mr876582466b.17.1757822228258;
        Sat, 13 Sep 2025 20:57:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f1e54sm673986866b.75.2025.09.13.20.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:57:07 -0700 (PDT)
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
Subject: [PATCH RESEND 49/62] init: rename ramdisk_execute_command to initramfs_execute_command
Date: Sun, 14 Sep 2025 06:57:03 +0300
Message-ID: <20250914035703.3729713-1-safinaskar@gmail.com>
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
 init/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/init/main.c b/init/main.c
index 5186233c64fd..cbebd64f523c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -160,7 +160,7 @@ static size_t initargs_offs;
 #endif
 
 static char *execute_command;
-static char *ramdisk_execute_command = "/init";
+static char *initramfs_execute_command = "/init";
 
 /*
  * Used to generate warnings if static_key manipulation functions are used
@@ -609,7 +609,7 @@ static int __init rdinit_setup(char *str)
 {
 	unsigned int i;
 
-	ramdisk_execute_command = str;
+	initramfs_execute_command = str;
 	/* See "auto" comment in init_setup */
 	for (i = 1; i < MAX_INIT_ARGS; i++)
 		argv_init[i] = NULL;
@@ -1491,12 +1491,12 @@ static int __ref kernel_init(void *unused)
 
 	do_sysctl_args();
 
-	if (ramdisk_execute_command) {
-		ret = run_init_process(ramdisk_execute_command);
+	if (initramfs_execute_command) {
+		ret = run_init_process(initramfs_execute_command);
 		if (!ret)
 			return 0;
 		pr_err("Failed to execute %s (error %d)\n",
-		       ramdisk_execute_command, ret);
+		       initramfs_execute_command, ret);
 	}
 
 	/*
@@ -1588,11 +1588,11 @@ static noinline void __init kernel_init_freeable(void)
 	 * the work
 	 */
 	int ramdisk_command_access;
-	ramdisk_command_access = init_eaccess(ramdisk_execute_command);
+	ramdisk_command_access = init_eaccess(initramfs_execute_command);
 	if (ramdisk_command_access != 0) {
 		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
-			ramdisk_execute_command, ramdisk_command_access);
-		ramdisk_execute_command = NULL;
+			initramfs_execute_command, ramdisk_command_access);
+		initramfs_execute_command = NULL;
 		prepare_namespace();
 	}
 
-- 
2.47.2


