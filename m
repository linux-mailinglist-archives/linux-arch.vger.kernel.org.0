Return-Path: <linux-arch+bounces-13558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B2B55D62
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 03:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2C01CC83CB
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B46327470;
	Sat, 13 Sep 2025 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv5lVuwm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9E19258E
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726243; cv=none; b=B5YQU/buxYktPBJJ7pS7AFRJjOwY37pbs3x4+ostjuqZUWjZf3qTMcBxowgA5XNAxGyfvBZn0F4IkKkEQAG4DPJ9++vSbSsk5X1ien6dXEQ9r7a+CFbFPEa0j9Rmc0BPfgFPN5UaEZv6RQ3u0MHqFPJkZ78XU5pLVWxO37Qho6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726243; c=relaxed/simple;
	bh=oyncyjaLrzPFmjkp22Lh+fbFcypfHWy3Ry54UY3bgvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM+165t/HDi97veVi+gKsCjpQcfhWZfLghwNDRmDI47AEdJvGbKiQNjflx9wRHsevwCm+wIhKzKbUScsLTSYVBBpiC8NiT2fv3Eiw2DaGdXUkHDtrQcYK43Mjx9dpu17RvuzIY/yv9lGtuz6Q0xGI3X46dT76LbxMkWfN6VNliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv5lVuwm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso4461444a12.0
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726239; x=1758331039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=;
        b=Pv5lVuwmVb5A8vNQP8+HTcG/JgQvDNSyP9WS6Bca1yZ7KNsWhFziOeULa55atldY8v
         xj7Ai8Wmr/W6iL+W+mDt0GJS58nDidso1Mc38FmXi35Hf9jI+c0BL/Rd5EpegbsT2FdL
         55imZcS1IHqYhRK8jy8fZXpkI1mp6pAi1A+6/sV3NjUm7xiFGPNuneK/9yErFJuxrGMJ
         NBxBg+gDyDJBszFRnyIWgZwc41qHM5oIWs5Qi1iOybheqkYijpll13+0q/V36vZC06Ef
         hWwsXstOJNXnY9cLrmXFxjFFhB/kqi+EAKFk+lKJWvxdct1z5kmzB2Q1dWF8nVWydKjL
         K9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726239; x=1758331039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=;
        b=IO4/4A9g0k3HMiD8TmxchlY27csbwUVKq2yFoZceBw+ThhtJFiY3RWTfO4mboPiMQG
         Ge3YC+W1l4sv8F3OECoObxkN4Z3RTjjkHYpD4yg2VebxD6elKmQyB0ftltgJ3/meKEqO
         PoBzSzm5CFDQeW9pwBzyFzymhsLP7+lVjMffQ5c4TYCHRGH4urlIbNsrWCDDMtj6X93s
         U8Gz5TO0zFRTQZ/Vf4Tabjqg6T0B28Plxk9z98ho6pQLSAIX0WYNv8J8zt3uuYUah1E6
         MQQ0PWL6Jh1G8NwYQyd8+nxXvdVIzih7oAyk0cqNZ153uQ+dxhs49BpDkq+DcdLv0QWd
         qiRg==
X-Forwarded-Encrypted: i=1; AJvYcCXK6UzpqGd5fmYZlKdw1uAKqYA3HoG+wC9dvdxShXyBSYpfiNbYI4dP5b9g6Grpv9x4l9JaH74+Tbxs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw909e4UwiUfaUjcPGECjK2A4VNhrUokh+px99c96gcljB7rxcj
	nPw7XISV3+rpcyUxq3K9KqvRzmZDL9c4ibHXheTienxvhw3ua1tSA0wD
X-Gm-Gg: ASbGnctrCpvU/ao9Fg40U8Gbc5VcESkOBLyEsiQWUBSvBaFZSAzB3UYz56SGGuaGs17
	ycyJmax7ffKBQ9vDR999jCuLSpJuEFrOJXO1bknzvQXzyMZxO+PawvmiOzkYEBUIQkLA+zOUfCa
	aYd+q0atI6xMnrV5Fpv4S15+T8Ek+ZRlRfbZTrdtxIUkzGXlvncV3N5gaimiPvXeqwobR9c21RL
	L/hsO6KJgtRsPPmpx20pswLgckOY3rv73wYve3ES5b6Q+YHpBWPf19CBO/aWp5wWMBKq1cqVHhW
	j/qTrsnGArfrexiI9ICcsWZymd/NSClwmV0pwStYFXvWaE05/6R+6S8K/MkIvzmh/3PXcBUY4YG
	vie0l91U46qRSsBB30iU=
X-Google-Smtp-Source: AGHT+IGWcEC7VhNjJKZzReFkWP7F1gkqH4tvvChKQBMnzdm+44287e9kqOEvM9aYYFOmJE4OYY5/Qw==
X-Received: by 2002:a17:906:4788:b0:b04:b435:fc6b with SMTP id a640c23a62f3a-b07c3a79fefmr497358466b.60.1757726238469;
        Fri, 12 Sep 2025 18:17:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ae181sm4478774a12.22.2025.09.12.18.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:17:17 -0700 (PDT)
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
Subject: [PATCH RESEND 34/62] init: inline create_dev into the only caller
Date: Sat, 13 Sep 2025 00:38:13 +0000
Message-ID: <20250913003842.41944-35-safinaskar@gmail.com>
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
 init/do_mounts.c | 5 ++++-
 init/do_mounts.h | 6 ------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5c407ca54063..60ba8a633d32 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -366,7 +366,10 @@ static int __init mount_nodev_root(char *root_device_name)
 #ifdef CONFIG_BLOCK
 static void __init mount_block_root(char *root_device_name)
 {
-	int err = create_dev("/dev/root", ROOT_DEV);
+	int err;
+
+	init_unlink("/dev/root");
+	err = init_mknod("/dev/root", S_IFBLK | 0600, new_encode_dev(ROOT_DEV));
 
 	if (err < 0)
 		pr_emerg("Failed to create /dev/root: %d\n", err);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6c7a535e71ce..f3df9d697304 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,12 +16,6 @@ void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
-static inline __init int create_dev(char *name, dev_t dev)
-{
-	init_unlink(name);
-	return init_mknod(name, S_IFBLK | 0600, new_encode_dev(dev));
-}
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
-- 
2.47.2


