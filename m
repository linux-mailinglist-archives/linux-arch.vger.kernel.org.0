Return-Path: <linux-arch+bounces-13574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1489B564B7
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 05:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B86D1A20748
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233AC267AF6;
	Sun, 14 Sep 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8exd0Or"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EE263F32
	for <linux-arch@vger.kernel.org>; Sun, 14 Sep 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821872; cv=none; b=hsuqnQpJWFJsyxQ4Axi+qZdhrSCDFAcBP2wPbqKCKi+nohQ/b0lWh/Gqt9txLbQH29LfwH211puQDA2lZN23sbctAbOZfDJWAbdQfLO6SiIIQvDeivbOcNwGQ3q4h+vwkwx+Nhy4Jxyrc4rTNM3Dvnr9EuBE8SD1HkhNTg7lvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821872; c=relaxed/simple;
	bh=0pa06GJsqjKCCDz/UM3o5nwPqkgP4CqvzP324rR3v40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYnzDTY31RE/ooRWvFnMlhiFt6I4LcpMeE6ScsZPwHEN13d4yvuSl6JE5tDhS4c3ANsmcvnn6Lwfo2NJxo6Ea9d87hj2suCe7GQEwk/tlDh+jz46YwSRYA61OhtgE0Mc0CsS3cFHFRIeAvMQYh2RnE9rYUpXLKlu9byOEOT4pkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8exd0Or; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0473327e70so529209366b.3
        for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 20:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821868; x=1758426668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=;
        b=Q8exd0Or+KP3IfpJ/F6cr04Z8ZzprXAK/vvOy0fDtx94X4VdoDeaLl53x+Re5XVu87
         nMyvaYDn8vFmTcEvvBxemBcs/KQak0F949JM4uH33s339OQt5URkPKDSAY3+ZGKOdjL5
         pUJ94likUMs0rBMqjlpvJwgZdJbK3S9flcLQ8zD5bq7g6BoxDcTYuO+f8U85RhZRiEFd
         NWgbXH/2vbui42YTjC9kWIfsAixItMc1GfQiwH5d3DjDt9wpiScun1VkZoezAqvc6RKI
         73MhrVf1ZHdX6nrAEPt0Dk6q5BbIrsUiJClkzy8cJCjt926MOo3foy+tV7x7JwQDnt3k
         Kq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821868; x=1758426668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=;
        b=YqfxZyQsSozgGEIMe01C+k3eCq2/M8HPojc+DMeMnpdbpwTu60VBhk75bBchXa7iz5
         pFXhS8h7NlDJKbIJNwth4mWyUAku1h8HkZif0sRM+VLVdT//YcDCi8zY6j+jE2byFGZ4
         Ub79VybdBTNqg+76BAjquUCLf+LVkUCGI4fUXvYbZBvfcD+m+NQDW/66TfW+oOc/uhJW
         dSdij0+HaN1uUJuYnS2XKgD+F5eh0X99I73U8JeY7cV0e3wh/ZNmiIEUFozQu4bfRH7U
         87abxr58IU1nS5xVD9TezkODufkU31VrS/ofSrZZkI7BgO50M8fyPpkTdAtTQUA7Q+k2
         adwg==
X-Forwarded-Encrypted: i=1; AJvYcCWrf1imZn/3YE5IxTszysnx394BX66ZX5dykHcynrwNy0iaXQG6D9/NjdmscQEPUXDC6C+F5fSlDWAz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xRauS/5dfm3W/oZhiKTAyAI2UoyRA2QiyJ4rEx126FXGcZoI
	LfvAGHIFzoztA/nWqplkUPwmEa7PI5fUohyGgnEyvGajIhOFRMMYYD4J
X-Gm-Gg: ASbGncvaEcEW46/NMsje6Z//GnYZrtbz7txXpFG4TqwNv4EyM+3zy+JNPa9k24Op/8l
	Mda4+gVoe0CJf8EH0i5USFg44/Ajvq/d5fHtCbYhtjUULSmGXX/TyzmiVcbPH4CL22VV+Hyg2gt
	DEQwtwLW5GNVFdIF22odNif19GOxGuGhz4Dv25dsnVubaACPc08XvN2PIzQwYGwM1pPNtuEfVaa
	XyNSBuEJSmIw8vC2JHLwjqX5o4EPReaxdLsS9rmjRgP9wI2qSFPAnDplT26yd9Gkq04KNBHBf4K
	ThD+A7xkO4feDjQbA+KccwbyBtyeAPCnTN8y0S1q2F7LJsyL8VKl93wEF+FgiWBjawqjDrYm4Ur
	AbVBedTyd12yDhRMo3fc=
X-Google-Smtp-Source: AGHT+IGYiK6likOM/TjE1BLl/jI3UX22nGT0EQIxF87CUWohx3tkGnMcAa8PzC4lwu+rbC2577QTfw==
X-Received: by 2002:a17:906:46c7:b0:b07:da17:79fd with SMTP id a640c23a62f3a-b07da178367mr507229866b.17.1757821868321;
        Sat, 13 Sep 2025 20:51:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347b6fsm679031866b.111.2025.09.13.20.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:51:07 -0700 (PDT)
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
Subject: [PATCH RESEND 39/62] init: make console_on_rootfs static
Date: Sun, 14 Sep 2025 06:51:03 +0300
Message-ID: <20250914035103.3619203-1-safinaskar@gmail.com>
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
 include/linux/initrd.h | 2 --
 init/main.c            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 364b603215ac..55239701c4e0 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -23,6 +23,4 @@ extern unsigned long phys_external_initramfs_size;
 extern char __builtin_initramfs_start[];
 extern unsigned long __builtin_initramfs_size;
 
-void console_on_rootfs(void);
-
 #endif /* __LINUX_INITRD_H */
diff --git a/init/main.c b/init/main.c
index 58a7199c81f7..f119460bf8e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1533,7 +1533,7 @@ static int __ref kernel_init(void *unused)
 }
 
 /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
-void __init console_on_rootfs(void)
+static void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
-- 
2.47.2


