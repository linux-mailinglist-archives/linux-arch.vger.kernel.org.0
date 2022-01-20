Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9794946F9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jan 2022 06:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiATFcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jan 2022 00:32:00 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31328 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiATFcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jan 2022 00:32:00 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 20K5V6QW029756;
        Thu, 20 Jan 2022 14:31:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 20K5V6QW029756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642656667;
        bh=d9AQ7p0brEyjb3LFIQfatzkfmepyjBhtJOzn2i9Uff4=;
        h=From:To:Cc:Subject:Date:From;
        b=248if+r239MzF9Dh+IPJUHaWtcOg0BH9566uLFXCCleZOhGHp9qm9Mz+s0bHd0o2s
         alYyK7wUU+TTT75ivwDzGmAR+TiisibrbW2uJ45r2ZzcQSN8uuU6vFEl7Bpaz8I87F
         3Yxmx9I1KpQIwB8EYHTzEVkycVG8WbVwDa5tS1OV3Ey9i+iuvDmgVYHR3JrWmgRS/h
         hX7As8eEiWdNMC8D3IegWZ7E/VG7kPXwRDU1WbF1slT1WojKuBd9iPOzxJljgHunTv
         EsaY8YYsCatWpMsghcg148jsVxLF23HZ0aQFyrc7GlrATbFBLIiEgpWxu8ML4AzyWv
         AEJQw8ZVR3loQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] Revert "Makefile: Do not quote value for CONFIG_CC_IMPLICIT_FALLTHROUGH"
Date:   Thu, 20 Jan 2022 14:31:00 +0900
Message-Id: <20220120053100.408816-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This reverts commit cd8c917a56f20f48748dd43d9ae3caff51d5b987.

Commit 129ab0d2d9f3 ("kbuild: do not quote string values in
include/config/auto.conf") provided the final solution.

Now reverting the temporary workaround.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3f07f0f04475..c94559a97dca 100644
--- a/Makefile
+++ b/Makefile
@@ -778,7 +778,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 KBUILD_CFLAGS += $(stackp-flags-y)
 
 KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
-KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
+KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
-- 
2.32.0

