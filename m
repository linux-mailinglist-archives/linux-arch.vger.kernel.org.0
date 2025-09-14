Return-Path: <linux-arch+bounces-13592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCBBB56629
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 06:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F91A21A6D
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFF0275845;
	Sun, 14 Sep 2025 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgSnj9yP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24092272811
	for <linux-arch@vger.kernel.org>; Sun, 14 Sep 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822522; cv=none; b=dSD2S3eOOpcGTgsFW6eFO004eMZj14wECbgEoaga+n8G75/DXJzzw9cnAYcWxveW4dESZujuT2ffoZiXVo4KxHdiSPnGp6E0ZFTwuNf6F16uVZ+OUL/FrI0apK5Ijjk5MPJiaclz4/uAfb3G4TinhqsoVpRo3MuXBnz5vRqaBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822522; c=relaxed/simple;
	bh=Mr4TsGc1GUlbHoN089IbfCGW58eyBBGvk6oB79C9p1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bChTrDlbHK+jAX1wMJDjUsSEi6LiscHOjv0HoNbOQotIdBOEkXk6rGA87NRzQdwXPyS8gUZXB+aJ/9vHTO515TGsC68oV9H0v6RlRyQEW2dK5JMrQBoVkTHLLm62+K1GeK3Y42GIfHXp/PoX283pZd1kaJwQnvQ5ryM0Iw0OluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgSnj9yP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso4542239a12.1
        for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 21:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822517; x=1758427317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGq2rj18j5nvFWvHRh616vM6JteMHLrszS02ds4tBLs=;
        b=WgSnj9yPKX19VE5Ifm9hNxHT/Da0+H7qEbtwuc5t7DcwnibvGTLTkoYeqdlH7FEZhi
         XDeRVYQQ7QTDHE1GnG3NHhIEdQH1j9L24eMZpZpH1SNKLoL67BZ/we/KWScM3kjtKTOv
         2n24Gh100tqOzRVz4jFhya0OSKrJpJ816opYBb+DSxHHNeDLDsB6EDMcjSpjeYo0V8NR
         2s4RfbwqApYbDFAEMbJu/uJt+hJd9JJc0jr5jZa6KKgapUQEkAdf99pweH/y2pd9jK5o
         FZ16DblUXpz0nJ5lkuo7j4/CXMdnGtYXzIrVWul3bf84yOqvVxaqjh2QpbGWAVYI2uig
         JbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822517; x=1758427317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGq2rj18j5nvFWvHRh616vM6JteMHLrszS02ds4tBLs=;
        b=j8HcdFRDHjHj0L4dhOwLs8TYIBU5R+ajaduvLI8DV44a9xdQjjSr1P+ZFWMD8IsOXb
         VU7YJMjPq9+XmR9hUJMZvNSlZct1aOWANg41sD7buwe+cYdwsiC5xJjwo5fnwX/sr48x
         04cR0U3R09rzvS+Sk8cClTWNa2aTiX5ilJuKLHDeGbjNbJ00Bg6GGl3wPlBYN9uDt5p0
         hktl6B0FpkD5eM+4bYXLAxocMrLJTf8Jd+qWLhlektZ0bD0hP374byRo3e5zIewYkCIY
         YvVCCjcDXqN/zGJhC5YPrIKPrpSFKCSYU8KQhPRP6BZ5Hlej7DNjKZ7lh6GLqpsq23F1
         NdDg==
X-Forwarded-Encrypted: i=1; AJvYcCWersRjwlv7Y/rdkt83j5B0GCcFWdUZutDh6BWGdjeCVmOXQkbhuEVe0krb+fM7We3DsICmhTmsH1IH@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYeupo3/hJyf6F2q8IYNNEvgrBhMbAfqcokLPSAmVrBmrHnvs
	o53D7nezUUjtnp/0I0GuMZCDeRNjsOOGNpRzQKQTdEsHeXRaDEVh0k7Q
X-Gm-Gg: ASbGncsEsoCindjfyeScikbCHLBzD39kWkYt3cfdy59ImMX19YmBl1Eh4uxC1kYq8Nm
	GK64nTjDs8cuw0+iCVheEwtD85nUv4Y8fKyvgOs0CDKtjbWzxPGv1mQaZA7Gdg3T7Kef3A03UKp
	jve0EsIkXXggUZ92+QTLnrHz0Wh2SMto7vxzqNW996+UIoIIfKyFRQJ4wp54fMw/xoZ7p6gNa4g
	Pmzb+mgXs7XjgEIRWyGduU97yoLGDxGgOxmcPsg02d+UVfTgqfdLjWVI69QlEOebpcgejSrqv21
	4Idvjb449tWjMChaggq2/Gy6qC5az5EUbc9IP2KVQ8ikYhZeqZXBc2nBQaHDVLkT5fWzgnCKQip
	hZ219KQFODn0zUA7swFg=
X-Google-Smtp-Source: AGHT+IHGppk9Eg00mRFWKY3oyWZDORImAaUMiStm5q/vVvxsBauDUIDKfxmQ2agdiwYo6nbnpX+hpA==
X-Received: by 2002:a05:6402:3587:b0:62f:2ac2:af41 with SMTP id 4fb4d7f45d1cf-62f2ac2b11amr1102107a12.38.1757822517371;
        Sat, 13 Sep 2025 21:01:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec2e661a5sm6322050a12.0.2025.09.13.21.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:01:56 -0700 (PDT)
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
Subject: [PATCH RESEND 57/62] init: rename CONFIG_RD_BZIP2 to CONFIG_INITRAMFS_DECOMPRESS_BZIP2
Date: Sun, 14 Sep 2025 07:01:51 +0300
Message-ID: <20250914040151.3805905-1-safinaskar@gmail.com>
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

Initrd support was removed,
and CONFIG_RD_BZIP2 has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/configs/aspeed_g4_defconfig       | 2 +-
 arch/arm/configs/aspeed_g5_defconfig       | 2 +-
 arch/arm/configs/lpc18xx_defconfig         | 2 +-
 arch/arm/configs/sp7021_defconfig          | 2 +-
 arch/arm/configs/vf610m4_defconfig         | 2 +-
 arch/mips/configs/ath25_defconfig          | 2 +-
 arch/mips/configs/bmips_stb_defconfig      | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 arch/powerpc/configs/skiroot_defconfig     | 2 +-
 arch/riscv/configs/nommu_k210_defconfig    | 2 +-
 arch/riscv/configs/nommu_virt_defconfig    | 2 +-
 arch/sh/configs/sdk7786_defconfig          | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig  | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 +-
 usr/Kconfig                                | 4 ++--
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index f2abada5036a..af891a2b2d6c 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 7098a09fefb8..a16aed0abcaa 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index c8f7fa140225..abde171f1742 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -1,7 +1,7 @@
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_INITRAMFS=y
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index 30cfafc49ec9..4f5cd0d0511d 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -6,7 +6,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index b253d76e0d40..9e6175467998 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -1,6 +1,6 @@
 CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index 58ae5f9726a0..7c1ec18b0eeb 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 2217a3ca5b72..6ccb53279345 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -15,7 +15,7 @@ CONFIG_NR_CPUS=4
 # CONFIG_SECCOMP is not set
 CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 CONFIG_RD_XZ=y
 # CONFIG_RD_LZO is not set
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index e4aaaeaec7a8..ba6f06c29fed 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -3,7 +3,7 @@ CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 9a6ef1d8ca44..a5b30aba9ac1 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -11,7 +11,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=20
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index a1fa77563bb8..bc0df803ecaa 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -2,7 +2,7 @@
 CONFIG_LOG_BUF_SHIFT=13
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index d777e4a774bd..1291e21b7ce5 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -1,7 +1,7 @@
 # CONFIG_CPU_ISOLATION is not set
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_INITRAMFS=y
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index dd0ef63a0064..2c339b2111fe 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -27,7 +27,7 @@ CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_INITRAMFS=y
-CONFIG_RD_BZIP2=y
+CONFIG_INITRAMFS_DECOMPRESS_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_RD_LZO=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 788274247b03..06d82e725e64 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -14,7 +14,7 @@ CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
 CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 5050b3e5e1be..cde2ae3ca4b1 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -15,7 +15,7 @@ CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
 CONFIG_INITRAMFS=y
-# CONFIG_RD_BZIP2 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index cf3c7539e3dc..325c2d95eb74 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -60,7 +60,7 @@ config INITRAMFS_DECOMPRESS_GZIP
 	  Support loading of a gzip encoded initial ramfs.
 	  If unsure, say Y.
 
-config RD_BZIP2
+config INITRAMFS_DECOMPRESS_BZIP2
 	bool "Support initial ramfs compressed using bzip2"
 	default y
 	select DECOMPRESS_BZIP2
@@ -144,7 +144,7 @@ config INITRAMFS_COMPRESSION_GZIP
 
 config INITRAMFS_COMPRESSION_BZIP2
 	bool "Bzip2"
-	depends on RD_BZIP2
+	depends on INITRAMFS_DECOMPRESS_BZIP2
 	help
 	  It's compression ratio and speed is intermediate. Decompression speed
 	  is slowest among the choices. The initramfs size is about 10% smaller
-- 
2.47.2


