Return-Path: <linux-arch+bounces-7044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9596CB27
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD128166F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE018E059;
	Wed,  4 Sep 2024 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0LzAvyd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE918E02B;
	Wed,  4 Sep 2024 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493711; cv=none; b=ikANXRlxIEVtdhCHgpoIA7GQax3lyspj/0NbowaYs6gkbZrX73AewGpwxyVhN2JwCE+YHln3MdSRetVK94pkJxMxa+n78DrS5nozrkrWkvkH4SczwAfFi4Yjv846+Cc7gifzL5QojlHoBtfNe871WOauayj1BXZ3tjJUnSDku8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493711; c=relaxed/simple;
	bh=0Cc2oNyNXJMYffrGUjSrxejvm3spX+Pr6+GYatSbayY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqu4upfYgPPRNF5WYo6b52kFzHVlDaEr5JhU2ARYJD05sXkRZJLwx7gSXvgPa1nALRg2HzfxPnCMyhtGevutz4HpiJZY1lZZT6BOlFso18qXLsJZmfkh15QFQNwFOehym0OZdO6qFzz1ROO/U+95gWkKlo7vhqoGuI2XW8RQt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0LzAvyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12166C4CEC3;
	Wed,  4 Sep 2024 23:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493711;
	bh=0Cc2oNyNXJMYffrGUjSrxejvm3spX+Pr6+GYatSbayY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0LzAvydGQzpSJjmNzSDLP3BIZFDXFf9RBmKd+rrW+Ri/pE8v2Je/CXoWRDgK5CIA
	 ZVX8UlTMpaUFjWSFfuvj6anH2/qJI7UyLMLLTYBkSJWRzaikGVRTej9BX0I2EVdefa
	 YTcU7Q6jqYEn1dwZDaSZWzXWDR1Q1UFxRJHalXeIRPycMCnHcf02dkj1egeg0oqXB0
	 xHI2gBGVyJHqV04UUrWEhQxA3f7eKY64W8jSoWx8XlOWLlxwV/p3UQjSxIVdrkUtDz
	 GZ+f3AW6gFl/jUur3f28fo8NZecBIG2JGJcWbuBQqM1Nn9UOP8UwUwuCMlURYKwcb1
	 XDA/Tmpxapf5Q==
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
Subject: [PATCH 07/15] LoongArch:  migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:43 +0900
Message-ID: <20240904234803.698424-8-masahiroy@kernel.org>
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

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/loongarch/Kbuild            | 1 -
 arch/loongarch/Kconfig           | 1 +
 arch/loongarch/boot/dts/Makefile | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
index bfa21465d83a..beb8499dd8ed 100644
--- a/arch/loongarch/Kbuild
+++ b/arch/loongarch/Kbuild
@@ -4,7 +4,6 @@ obj-y += net/
 obj-y += vdso/
 
 obj-$(CONFIG_KVM) += kvm/
-obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..e1d3e5fb6fd2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -388,6 +388,7 @@ endchoice
 config BUILTIN_DTB
 	bool "Enable built-in dtb in kernel"
 	depends on OF
+	select GENERIC_BUILTIN_DTB
 	help
 	  Some existing systems do not provide a canonical device tree to
 	  the kernel at boot time. Let's provide a device tree table in the
diff --git a/arch/loongarch/boot/dts/Makefile b/arch/loongarch/boot/dts/Makefile
index 747d0c3f6389..15d5e14fe418 100644
--- a/arch/loongarch/boot/dts/Makefile
+++ b/arch/loongarch/boot/dts/Makefile
@@ -1,5 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 dtb-y = loongson-2k0500-ref.dtb loongson-2k1000-ref.dtb loongson-2k2000-ref.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_NAME))
-- 
2.43.0


