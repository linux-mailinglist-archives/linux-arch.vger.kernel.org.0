Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39A15A3B0B
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiH1Cny (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiH1Cnr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:43:47 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EBA2656E
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:43:46 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-05.nifty.com with ESMTP id 27S2eggs018101
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:42 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gl030639;
        Sun, 28 Aug 2022 11:40:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gl030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654408;
        bh=hTZUP847fbfef2g9ezPupjBY2vTehYAAacc76rjXEUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h319PIKxEJK4MmGGaPn1m3V4uTzXrMiFG9A/+f/7U31jg2yX7r3rrIQa1hTGfYU3I
         MsO3VXgZTD6yN0xFYMOjmrnTbvzsFULe6KYawVrNpV+F0tuLjp0Rizk5kpncwtoz44
         5uSDnYxHG4VvPE69hy8AQiriS+q7G+KKmeq8/8R9YPvQTT/P3SE+vM783waQ4WoUy1
         sazHtjbEAQHd/thm/IC8rRfFXgz+Ztc2Ryy5Oac7/Xwuh4mUY3x00ll+6yVV68P+N2
         eiEELw9wMEJWWdLhNbpyTbzajXd6ApryypiMmAvJgj1QqXBMumV7xQrIWfej4/na07
         n+pmczSJdju8Q==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 03/15] kbuild: move 'PHONY += modules_prepare' to the common part
Date:   Sun, 28 Aug 2022 11:39:51 +0900
Message-Id: <20220828024003.28873-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Unify the code between in-tree builds and external module builds.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index badd318c5524..54e481162608 100644
--- a/Makefile
+++ b/Makefile
@@ -1446,7 +1446,6 @@ modules.order: $(subdir-modorder) FORCE
 targets += modules.order
 
 # Target to prepare building external modules
-PHONY += modules_prepare
 modules_prepare: prepare
 	$(Q)$(MAKE) $(build)=scripts scripts/module.lds
 
@@ -1747,15 +1746,12 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
-# no-op for external module builds
-PHONY += modules_prepare
-
 endif # KBUILD_EXTMOD
 
 # ---------------------------------------------------------------------------
 # Modules
 
-PHONY += modules modules_install
+PHONY += modules modules_install modules_prepare
 
 ifdef CONFIG_MODULES
 
-- 
2.34.1

