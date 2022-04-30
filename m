Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7D515CB6
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiD3MVD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiD3MVC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 08:21:02 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9A25E;
        Sat, 30 Apr 2022 05:17:39 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 23UCHEE1011373;
        Sat, 30 Apr 2022 21:17:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 23UCHEE1011373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651321035;
        bh=v4qZpiglT6xrPTQPd4L6/Mie4jcqQ5qrt6RyWo65A7M=;
        h=From:To:Cc:Subject:Date:From;
        b=L2WjNp5nXXERfjMbC+99SvIsQEpIMuw3HRs6TVi81qYC03TPqW4vFfQwzuWJsM0P3
         2X+NjxOXfxazdJ9KfQWVLhCbPEuO452kGzaR8B30h0Ded7ezwI/m683V3LQjmjcoBF
         ufx2wmwMfKWHxGUEqMsUyoEQ+HogoqgB5elBB7if70Og4480uuydKJj5p6g5M959ZB
         uYlFd3Fqb+BLmLIYKIXo1qwNikQCt5iYYQMI+Mu3RXj+6PPJiPd2oKSJ14kx2oNh9r
         pO02RrsRi2DwwG5L1YeOA3aGZNhJdjB0OG/37Cr0ZBDeatL8sVGX0TqcbBEPAvVMYQ
         Qgae7SQgEVNRA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] ia64: make the install target not depend on any build artifact
Date:   Sat, 30 Apr 2022 21:16:38 +0900
Message-Id: <20220430121639.315421-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

The install target should not depend on any build artifact.

The reason is explained in commit 19514fc665ff ("arm, kbuild: make
"make install" not depend on vmlinux").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 3b3ac3e1f272..6c4bfa54b703 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -72,8 +72,8 @@ archheaders:
 
 CLEAN_FILES += vmlinux.gz
 
-install: vmlinux.gz
-	sh $(srctree)/arch/ia64/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
+install:
+	sh $(srctree)/arch/ia64/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
 
 define archhelp
   echo '* compressed	- Build compressed kernel image'
-- 
2.32.0

