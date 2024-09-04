Return-Path: <linux-arch+bounces-7048-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485A96CB41
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B52B20FAD
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2A192B98;
	Wed,  4 Sep 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9kBmrJR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B3188588;
	Wed,  4 Sep 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493722; cv=none; b=JI+UHnF93jhmUC1bxlA77kYo8ftB4u0YYV7+4vh5L8PJkNd7jO9VJ4YG398CvWbsG7FqwHIi+2VSkZ4kVs/1aPpwT1xe1QT8ulP282lpch2B83b2LAsXOH1cQTwmgbLmm3UQBIa9he2jd3mCm/iYQfQyCjmqZpgb+EF5Gbd0pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493722; c=relaxed/simple;
	bh=ceXpRnavdorzGFbVYUr8aA6c+sVnRF84hopfhHaV0dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkgnnXwLPlRh6WYriI+z0Wc6K1Rc/ZZVZMGEfDO3Ls9HPFDZy5mlTlLOevzPlB9M6QZgZesp93oND1PKpuPSaZMS8GlrywogQmT2S4VPONPjkb/afp6shsyGDTUJnJqgm1uIavDDT+bznqDcg4+X+Ua5v5rPh5o8Ho1hxQMyOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9kBmrJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5596CC4CEC9;
	Wed,  4 Sep 2024 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493722;
	bh=ceXpRnavdorzGFbVYUr8aA6c+sVnRF84hopfhHaV0dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9kBmrJRmdISyfx3jQ19J1DpNiq+n9PVgL8tnqgAE5eHB9qEcAWVNIA24BtpLn6zo
	 J2qft+UQ5z9suplkazNanVvrDKX0uNYEMsy858T8dIJvCWBoTmKznVjpL2STXcfd3N
	 sT5cHyO4nW8tgbXbotQGpJJnUiBxfXLw53xIS3O6tAqP92Hezz9nQtcrHye6fNyrrT
	 C9Bd206zR9cXvGP/W4t5i16oi2V+YUku6N3eMDk9xF/34dmZTvIldslwrhvs6aCnZo
	 wAo6MrOzvaP5v+ZAqNa3E4eR/CRQfeAnZ6f7/XL/mxk1Ler62qkXD8NWxMWRLWI0Pr
	 /DDmAhuLfGJhQ==
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
Subject: [PATCH 11/15] nios2: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:47 +0900
Message-ID: <20240904234803.698424-12-masahiroy@kernel.org>
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
CONFIG_NIOS2_DTB_SOURCE_BOOL to CONFIG_BUILTIN_DTB, and
CONFIG_NIOS2_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nios2/Kbuild                    |  2 +-
 arch/nios2/boot/dts/Makefile         |  4 ++--
 arch/nios2/kernel/prom.c             |  2 +-
 arch/nios2/platform/Kconfig.platform | 11 ++++++-----
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/nios2/Kbuild b/arch/nios2/Kbuild
index fc2952edd2de..fa64c5954b20 100644
--- a/arch/nios2/Kbuild
+++ b/arch/nios2/Kbuild
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y += kernel/ mm/ platform/ boot/dts/
+obj-y += kernel/ mm/ platform/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
index 1a2e8996bec7..1b8f41c4154f 100644
--- a/arch/nios2/boot/dts/Makefile
+++ b/arch/nios2/boot/dts/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := $(patsubst %.dts,%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
+dtb-y := $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
 
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
+dtb-$(CONFIG_OF_ALL_DTBS) += $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index 9a8393e6b4a8..f703056885c9 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -32,7 +32,7 @@ void __init early_init_devtree(void *params)
 	}
 #endif
 
-#ifdef CONFIG_NIOS2_DTB_SOURCE_BOOL
+#ifdef CONFIG_BUILTIN_DTB
 	if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
 		params = (void *)__dtb_start;
 #endif
diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
index e849daff6fd1..c75cadd92388 100644
--- a/arch/nios2/platform/Kconfig.platform
+++ b/arch/nios2/platform/Kconfig.platform
@@ -35,19 +35,20 @@ config NIOS2_DTB_PHYS_ADDR
 	help
 	  Physical address of a dtb blob.
 
-config NIOS2_DTB_SOURCE_BOOL
+config BUILTIN_DTB
 	bool "Compile and link device tree into kernel image"
 	depends on !COMPILE_TEST
+	select GENERIC_BUILTIN_DTB
 	help
 	  This allows you to specify a dts (device tree source) file
 	  which will be compiled and linked into the kernel image.
 
-config NIOS2_DTB_SOURCE
-	string "Device tree source file"
-	depends on NIOS2_DTB_SOURCE_BOOL
+config BUILTIN_DTB_NAME
+	string "Built-in device tree name"
+	depends on BUILTIN_DTB
 	default ""
 	help
-	  Absolute path to the device tree source (dts) file describing your
+	  Relative path to the device tree without suffix describing your
 	  system.
 
 comment "Nios II instructions"
-- 
2.43.0


