Return-Path: <linux-arch+bounces-7046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3684F96CB33
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E745328498C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30F1922CB;
	Wed,  4 Sep 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXanL2S1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783E1917F9;
	Wed,  4 Sep 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493717; cv=none; b=H4mHx1O+sCrkscBypUJxB458a0gzjpzQnVP9zsPw4Wvmftw4a0gCjZ8csCaiHuJ6wPclZ3lB3muI0Q69oKeSQ8foPOgkJlMEWl9d7xqyx+CTL4FYQpVliup0fjpTgGryhdY/+fzUGlSxgbp3is1m4vRGsndW0RqMuFC+Q+ma64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493717; c=relaxed/simple;
	bh=dk04zi59AciF5LL6akuqjWabef8tuzvQHnluBCG6Dq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Huvl8eXOtiO3Z8BiNhExZZ27Q78POJpMoO+Yrk+r8yeQz1f9ZXWzSsJaJeuDUI8ya49HJMYrWxsTE0EOzCZ+j6dfXwz3HN9xpYYjzjjkQljxYL0RxFrtVAr3DB6XvYCc1flPCxAKiwuErvVlid+dP5Ru7yl6BnqKnHZqDPXOqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXanL2S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44EFC4CEC9;
	Wed,  4 Sep 2024 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493716;
	bh=dk04zi59AciF5LL6akuqjWabef8tuzvQHnluBCG6Dq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXanL2S1ncP9VL15QlXjB215wU1hNbN2vKvw3EYtXVZFbUBVEeZHly5axKhoCCqTu
	 oUB3D/bJEjWxqQ0rm18DKkHgVADRiZpRKAIM69av4S7HT4mCZ354pk2zPEJqwsO+YP
	 MgKw4KPnBKLnddm7a+GxJPtumoGmTve3flq+PEAZJVXniDdiVRWK2FyTQjzXpjuqsO
	 lEX2H/XdvkhCwK23r7h8Gboj4cEE+GUUI7BnsmLxjion7OPZSlveblpMAT6nvodfQw
	 K6LAnw/GRi2YAPwiQw08MxjH/D+2oPQP+xVF0oE2dBysiOLMmSPZdcUd6Jn56F4G+o
	 5L8kSbjfqxaEA==
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
Subject: [PATCH 09/15] openrisc: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:45 +0900
Message-ID: <20240904234803.698424-10-masahiroy@kernel.org>
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

Select GENERIC_BUILTIN_DTB to use the generic rule to support built-in
DTB.

To keep consistency across architectures, this commit also renames
CONFIG_OPENRISC_BUILTIN_DTB_NAME to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/openrisc/Kbuild                       | 1 -
 arch/openrisc/Kconfig                      | 3 ++-
 arch/openrisc/boot/dts/Makefile            | 2 +-
 arch/openrisc/configs/or1klitex_defconfig  | 2 +-
 arch/openrisc/configs/or1ksim_defconfig    | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
index b0b0f2b03f87..70bdb24ff204 100644
--- a/arch/openrisc/Kbuild
+++ b/arch/openrisc/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += lib/ kernel/ mm/
-obj-y += boot/dts/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 69c0258700b2..11ffcf33652c 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,6 +10,7 @@ config OPENRISC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select GENERIC_BUILTIN_DTB
 	select COMMON_CLK
 	select OF
 	select OF_EARLY_FLATTREE
@@ -89,7 +90,7 @@ config DCACHE_WRITETHROUGH
 
 	  If unsure say N here
 
-config OPENRISC_BUILTIN_DTB
+config BUILTIN_DTB_NAME
 	string "Builtin DTB"
 	default ""
 
diff --git a/arch/openrisc/boot/dts/Makefile b/arch/openrisc/boot/dts/Makefile
index 13db5a2aab52..3a66e0ef3985 100644
--- a/arch/openrisc/boot/dts/Makefile
+++ b/arch/openrisc/boot/dts/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += $(addsuffix .dtb.o, $(CONFIG_OPENRISC_BUILTIN_DTB))
+dtb-y += $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
 
 #DTC_FLAGS ?= -p 1024
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index 466f31a091be..3e849d25838a 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -7,7 +7,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SGETMASK_SYSCALL=y
 CONFIG_EXPERT=y
-CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
+CONFIG_BUILTIN_DTB_NAME="or1klitex"
 CONFIG_HZ_100=y
 CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
 CONFIG_NET=y
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 0116e465238f..59fe33cefba2 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -14,7 +14,7 @@ CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
-CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
+CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index b990cb6c9309..6008e824d31c 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -20,7 +20,7 @@ CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
-CONFIG_OPENRISC_BUILTIN_DTB="simple_smp"
+CONFIG_BUILTIN_DTB_NAME="simple_smp"
 CONFIG_SMP=y
 CONFIG_HZ_100=y
 CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
-- 
2.43.0


