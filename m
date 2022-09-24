Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE115E8F36
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIXSUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIXSU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 14:20:27 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438B2ED4A;
        Sat, 24 Sep 2022 11:20:24 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 28OIJItR005682;
        Sun, 25 Sep 2022 03:19:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 28OIJItR005682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664043559;
        bh=AHNswuJHUPX2FMhUYMyi5pOOf1P/SvFBM5veflJK/Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvWECC//isvqaxq2AUBaXfeSphNVauRrnBSOKQCl5CZarEs6QiwnlCnkl4zQSnmxK
         xvC8vnldS3lXuSJ2A+r/CHGDwJqOR2A+JYoDwonBG6dw/dVhiVyZG80J8dL2Mb6pVx
         L8tMNzfpy0QthB90OcferRIcNkM00PBdFrBdX0o9lUklBqu9aJsFR0VsxYgBl/R53O
         nONZq6sjlJA1qYpHj/B4MIkxVqx4M5qfxIWux6y8wrJY+Al0GgvOSOmIOyJ+yQd9Pu
         k00DIGgrpPAhGh6OmYY3kquI2gIXu+7Qx/umszOOidsRsrkkkn3YmgBg6Y2Kr2N0Dv
         TddNgIJDWeFBA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 1/7] kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
Date:   Sun, 25 Sep 2022 03:19:09 +0900
Message-Id: <20220924181915.3251186-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924181915.3251186-1-masahiroy@kernel.org>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

My plan is to list subdirectories in ./Kbuild. Once it occurs,
$(vmlinux-alldirs) will not contain all subdirectories.

Let's hard-code the directory list until I get around to implementing
a more sophisticated way for generating a source tarball.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - New patch

 Makefile                 | 2 --
 scripts/Makefile.package | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 57cf4a5bea6d..eb4bbbc898d0 100644
--- a/Makefile
+++ b/Makefile
@@ -1129,8 +1129,6 @@ KBUILD_VMLINUX_OBJS += $(patsubst %/,%/built-in.a, $(drivers-y))
 
 export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
-# used by scripts/Makefile.package
-export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) LICENSES arch include scripts tools)
 
 vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
 
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 5017f6b2da80..8bbcced67c22 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -29,7 +29,10 @@ KDEB_SOURCENAME ?= linux-upstream
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
 export KDEB_SOURCENAME
 # Include only those top-level files that are needed by make, plus the GPL copy
-TAR_CONTENT := $(KBUILD_ALLDIRS) .config .scmversion Makefile \
+TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
+               include init io_uring ipc kernel lib mm net samples scripts \
+               security sound tools usr virt \
+               .config .scmversion Makefile \
                Kbuild Kconfig COPYING $(wildcard localversion*)
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
-- 
2.34.1

