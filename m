Return-Path: <linux-arch+bounces-7052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A996CB57
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD601C20E95
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD93194139;
	Wed,  4 Sep 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2gZoLH9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A419412F;
	Wed,  4 Sep 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493733; cv=none; b=BUSuvf+SoElVCgSytSS1oJG5xzQ3/si9cn2as/v2fzxbimaWLJ+i8eSDR9Wu0JIvtI37gjawnL0btBOJua/kLUwJBCt9QneGKsgDr3MA+G8Z7yFFrVtdcyEMtsrFxQAo0seG8Hv3d+Gq3G6wsSPa+CN3qJH8Uie0wcrNzj3EoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493733; c=relaxed/simple;
	bh=X36d1ZLy2VkgrLWOHRLYke7ZNl3jahnWeNpcJovYays=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYKx7QnvLlF1In9bPMG9+6y6/mLAe3HOUHHAcrzjpC8owURFnUsb2PQkNKaAO0UAADK5wqA183HYiuEkTrEv3Asd0Pf3q7phifhChFMzlYAUPt3pp7Da69wPNTQWP2pGRZOd6V/RgvkHmi1KJaOyirF/y+DK9JZK4ABdj0VMoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2gZoLH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF2BC4CECA;
	Wed,  4 Sep 2024 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493733;
	bh=X36d1ZLy2VkgrLWOHRLYke7ZNl3jahnWeNpcJovYays=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2gZoLH9QReVU2beUb37eQb86PpeBHhfuYh04yM6PcStHc5a1MJwX5bzTQip8QgIN
	 ThrZWo14eLlz72zPRNBf3CdFCnWWPvsoj7JrcDEd8MKK+uxKs1Gw7qXJMOWhXSwltr
	 9kEyPolldAhCurBcGOMorBnW0BLlhb2kEEAjjoDuSIJJ5ZfEIbYts6DnDX6nw31jA1
	 oezNgGSlDQtJdZCd0txWWcWX5wKt0e1/2xwyTczUJV2NA0hKXcts35xX4SFK6oi0iw
	 fONr6eZWZE7gL3WL+5tAWFKpZbcHjqNPH+JzGOWALncjhVORNz+4mxqqXlDqVoKZHU
	 mnHKIm6R+pFZA==
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
Subject: [PATCH 15/15] kbuild: use .init.rodata section unconditionally for cmd_wrap_S_dtb
Date: Thu,  5 Sep 2024 08:47:51 +0900
Message-ID: <20240904234803.698424-16-masahiroy@kernel.org>
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

Boot DTBs are now wrapped and compiled in scripts/Makefile.vmlinux.

The cmd_wrap_S_dtb rule in scripts/Makefile.dtbs is now only used
for generic purposes, so the .init.rodata section should be used
unconditionally.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.dtbs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Makefile.dtbs b/scripts/Makefile.dtbs
index 55998b878e54..436bfea85bb9 100644
--- a/scripts/Makefile.dtbs
+++ b/scripts/Makefile.dtbs
@@ -34,14 +34,12 @@ $(obj)/dtbs-list: $(dtb-y) FORCE
 # Assembly file to wrap dtb(o)
 # ---------------------------------------------------------------------------
 
-builtin-dtb-section = $(if $(filter arch/%, $(obj)),.dtb.init.rodata,.init.rodata)
-
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_wrap_S_dtb = WRAP    $@
       cmd_wrap_S_dtb = {								\
 		symbase=__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));	\
 		echo '\#include <asm-generic/vmlinux.lds.h>';				\
-		echo '.section $(builtin-dtb-section),"a"';				\
+		echo '.section .init.rodata,"a"';					\
 		echo '.balign STRUCT_ALIGNMENT';					\
 		echo ".global $${symbase}_begin";					\
 		echo "$${symbase}_begin:";						\
-- 
2.43.0


