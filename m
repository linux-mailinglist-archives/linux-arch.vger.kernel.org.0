Return-Path: <linux-arch+bounces-7043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2203796CB23
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02AF283C68
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844418D624;
	Wed,  4 Sep 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4lhfs4t"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DF18C342;
	Wed,  4 Sep 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493709; cv=none; b=oDYDQCOBSdR0f4vCe8hqwdeJ4qdqB9DVpkB4zeDBZfplf7NY/o/PKMnTremk1OEgFFIH+AMDWIc+pN8xYUddIUjNkpZyEWCWQ1SI+8BaPYUw3Sf8K5egy9XgPFFVxrKkKLYkZNWN23zJHN4+x+vZ9pSOQRwD3yzvolcVzJO1htk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493709; c=relaxed/simple;
	bh=noGT1ZHWVvDifWSIT0Eu3Rma90rEgb9C4Og/0AUftIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX/s+YwW9vO3VUoMcxuQlPkjlKFmYK0/wpEFHuNsdSs9zwxSF/jUqzlLwHZvvCTh9vFz1ula5fhwyh0XVctHO3GFYT91my5oOgDhnBmMCg6O49Y49giK+F+0l6kSKJS9YA+rvlaBhKg4ILYyoVycHlFgG4oSLHgnZnswvIBJbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4lhfs4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA160C4CEC8;
	Wed,  4 Sep 2024 23:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493708;
	bh=noGT1ZHWVvDifWSIT0Eu3Rma90rEgb9C4Og/0AUftIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4lhfs4t+UdLx9riX5cE4Q8MyzmjqxpJFDc864wC5f5TcmLpFzAEv6WHpE+kCfpAX
	 WU87cUrvtiPAIhPMsh3V5scl3LoUzjqi/q2+WqFKk5XNPpr79Ka4bhrbFxjCVz2qOE
	 DsBQ/C+NU2n0mkpTuStdf3otDGdANW4zGeGVAlLIchZ1PajkhqrhV7omoSuUt7NXik
	 wDkKHAin1YxoeSnae66K/834K+DwuU1IhhUmnTMmMcUIu0Z6cI8XrqsHqgxtdPLaF/
	 vHn4Ww3U8GMhKc6u13LeaqzoMLGzbbfqN9NFGThT3ewhi91UJxrepqLnE8PTKdyPCA
	 LVnZ3mOt2UktQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 06/15] riscv: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:42 +0900
Message-ID: <20240904234803.698424-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904234803.698424-1-masahiroy@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.

To keep consistency across architectures, this commit also renames
CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Kbuild                              | 1 -
 arch/riscv/Kconfig                             | 3 ++-
 arch/riscv/boot/dts/Makefile                   | 2 --
 arch/riscv/configs/nommu_k210_defconfig        | 2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index 2c585f7a0b6e..126fb738fc44 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-y += kernel/ mm/ net/
-obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
 obj-$(CONFIG_CRYPTO) += crypto/
 obj-y += errata/
 obj-$(CONFIG_KVM) += kvm/
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..019c64ef0826 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1110,13 +1110,14 @@ config RISCV_ISA_FALLBACK
 config BUILTIN_DTB
 	bool "Built-in device tree"
 	depends on OF && NONPORTABLE
+	select GENERIC_BUILTIN_DTB
 	help
 	  Build a device tree into the Linux image.
 	  This option should be selected if no bootloader is being used.
 	  If unsure, say N.
 
 
-config BUILTIN_DTB_SOURCE
+config BUILTIN_DTB_NAME
 	string "Built-in device tree source"
 	depends on BUILTIN_DTB
 	help
diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index fdae05bbf556..b09678f9badc 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -7,5 +7,3 @@ subdir-y += sifive
 subdir-y += sophgo
 subdir-y += starfive
 subdir-y += thead
-
-obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index af9601da4643..41a025f927ba 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -35,7 +35,7 @@ CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_BUILTIN_DTB=y
-CONFIG_BUILTIN_DTB_SOURCE="canaan/k210_generic"
+CONFIG_BUILTIN_DTB_NAME="canaan/k210_generic"
 # CONFIG_SECCOMP is not set
 # CONFIG_STACKPROTECTOR is not set
 # CONFIG_GCC_PLUGINS is not set
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index dd460c649152..ab4b22f1c91a 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -27,7 +27,7 @@ CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0 root=/dev/mmcblk0p1 rootwait ro"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_BUILTIN_DTB=y
-CONFIG_BUILTIN_DTB_SOURCE="canaan/k210_generic"
+CONFIG_BUILTIN_DTB_NAME="canaan/k210_generic"
 # CONFIG_SECCOMP is not set
 # CONFIG_STACKPROTECTOR is not set
 # CONFIG_GCC_PLUGINS is not set
-- 
2.43.0


