Return-Path: <linux-arch+bounces-7038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62096CB05
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B17DB2585E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6A187554;
	Wed,  4 Sep 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOVd3pae"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B61865E8;
	Wed,  4 Sep 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493695; cv=none; b=Bp2H+aKTV3dPMJhwSFx34DTAqQcZK8lbAgP2MaoHkruwehCZmAGK5DvoOqzCqBO6V3ztgGLBRctx0+doNTqXWTweZFe7/psvbUYDZT1XMFo3PNjXEAFkgKwFlMso7hhTsoEql6R/ZObzYJkkykTPwvaanxA+cg8v8Ue88AEID3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493695; c=relaxed/simple;
	bh=7exJ6iWjWavlMXuLRQ9WRoHQOnMw1lBsb8ceOLpZsRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbXnr5+0hGJO7Z0LmMb/5S42WbqUNUw4/wgDPHkejiSQSzX34Im0vFA29h7taXZnbRx/gxdqpfwq3ln4USpxF1vAF53olGtYOPq1FQtWZ49DA78htoCqpM2p+JDh4WXDz+akWa7dKY/WXqwe5DUHKQi+AyyJ/lHXkz7UZtoRH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOVd3pae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9724DC4CEC3;
	Wed,  4 Sep 2024 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493694;
	bh=7exJ6iWjWavlMXuLRQ9WRoHQOnMw1lBsb8ceOLpZsRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOVd3paeevBj5YOl3wu7mYGb5u2Z69iUi5zvqRoh0g1/hFWOllNhmz7IQCl6hqgtc
	 wTEXpGsqQf0tg7qrTHiVk/knj1jQgLAlBC7M71kllOWhWgfrJtnUbU7F8g09nggEO8
	 TGyQiuR1bH4PZ56i8ukJ/qfmZliI/Yt48ScivKtZC1bYq1lcPoyPSX1EtSZ+EwOiye
	 SO+Q1c6/cy9HCONzbRd9N7pjUoRlnc+xkawIVzCMc1RSNx53zw7vKZxygaR+r6ymYO
	 3YkMkB8ZYVCqMkVVGUw2Lhufu7UbgcruHVPfwOhnWicSH8+TpFbt+SMRLs5mmvnWyz
	 QIkjEiswGQNww==
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
Subject: [PATCH 01/15] kbuild: add intermediate targets for Flex/Bison in scripts/Makefile.host
Date: Thu,  5 Sep 2024 08:47:37 +0900
Message-ID: <20240904234803.698424-2-masahiroy@kernel.org>
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

Flex and Bison are used only for host programs. Move their intermediate
target processing from scripts/Makefile.build to scripts/Makefile.host.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 35 ++++++++++++++++-------------------
 scripts/Makefile.host  |  5 +++++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a5ac8ed1936f..4b6942653093 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -41,20 +41,6 @@ include $(srctree)/scripts/Makefile.compiler
 include $(kbuild-file)
 include $(srctree)/scripts/Makefile.lib
 
-# Do not include hostprogs rules unless needed.
-# $(sort ...) is used here to remove duplicated words and excessive spaces.
-hostprogs := $(sort $(hostprogs))
-ifneq ($(hostprogs),)
-include $(srctree)/scripts/Makefile.host
-endif
-
-# Do not include userprogs rules unless needed.
-# $(sort ...) is used here to remove duplicated words and excessive spaces.
-userprogs := $(sort $(userprogs))
-ifneq ($(userprogs),)
-include $(srctree)/scripts/Makefile.userprogs
-endif
-
 ifndef obj
 $(warning kbuild: Makefile.build is included improperly)
 endif
@@ -452,13 +438,24 @@ intermediate_targets = $(foreach sfx, $(2), \
 # %.asn1.o <- %.asn1.[ch] <- %.asn1
 # %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
 # %.dtbo.o <- %.dtbo.S <- %.dtbo <- %.dtso
-# %.lex.o <- %.lex.c <- %.l
-# %.tab.o <- %.tab.[ch] <- %.y
 targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
-	   $(call intermediate_targets, .dtbo.o, .dtbo.S .dtbo) \
-	   $(call intermediate_targets, .lex.o, .lex.c) \
-	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
+	   $(call intermediate_targets, .dtbo.o, .dtbo.S .dtbo)
+
+# Include additional build rules when necessary
+# ---------------------------------------------------------------------------
+
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
+hostprogs := $(sort $(hostprogs))
+ifneq ($(hostprogs),)
+include $(srctree)/scripts/Makefile.host
+endif
+
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
+userprogs := $(sort $(userprogs))
+ifneq ($(userprogs),)
+include $(srctree)/scripts/Makefile.userprogs
+endif
 
 # Build
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index e85be7721a48..e01c13a588dd 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -160,3 +160,8 @@ $(host-rust): $(obj)/%: $(src)/%.rs FORCE
 
 targets += $(host-csingle) $(host-cmulti) $(host-cobjs) \
 	   $(host-cxxmulti) $(host-cxxobjs) $(host-rust)
+
+# %.lex.o <- %.lex.c <- %.l
+# %.tab.o <- %.tab.[ch] <- %.y
+targets += $(call intermediate_targets, .lex.o, .lex.c) \
+           $(call intermediate_targets, .tab.o, .tab.c .tab.h)
-- 
2.43.0


