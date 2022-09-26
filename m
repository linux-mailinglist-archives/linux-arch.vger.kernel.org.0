Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0C5E97B2
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 03:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIZB1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Sep 2022 21:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiIZB1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Sep 2022 21:27:39 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2862870C;
        Sun, 25 Sep 2022 18:27:37 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 28Q1QPJ3025665;
        Mon, 26 Sep 2022 10:26:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 28Q1QPJ3025665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664155585;
        bh=fUzRAJ3xUhcdybtGiaG/LLCfLPKmRi+rkIOIMmXKiNE=;
        h=From:To:Cc:Subject:Date:From;
        b=Lq2RbSwSBw4LKwWHJN5jkgjwVO9JX7TbpynkoWh7ibJve6XlCiokBn9eHqu/JuE8p
         f+fzaqOh79uCSO6O/ClkJkK3TTb0THOJhtjE+6bqs3Y1UubCZKXZEGPUrDw2+54W4j
         KmgIR9hL5e6Nihc3S/WyYYBxIrUAKmy/YKK2QVj5CeazNfnOseAvcOAdffQM77nrVK
         I6HkXocuJuiSQGSpiHCibRSsKS13AOy6JkMDkH1IRp2II98z4DVyTdi/IH6HCAVGgj
         pRA+0Bdakdk3Fj44QiPFynT9+RvZzuO76kqxC/NOCmpQ3hErIJ5H8lDJLvR3jX5nz+
         rRy6WBvASNclw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: suppress warnings for single builds of vmlinux.lds, *.a, etc.
Date:   Mon, 26 Sep 2022 10:26:09 +0900
Message-Id: <20220926012609.3976305-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

vmlinux-deps is unneeded because the dependency can directly list
$(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)

Do not cancel the rule; building an individual vmlinux.lds, built-in.a,
or lib.a is working now, but the warning "overriding recipe for target"
is shown.

Without this patch:

  $ make arch/x86/kernel/vmlinux.lds
  Makefile:1798: warning: overriding recipe for target 'arch/x86/kernel/vmlinux.lds'
  Makefile:1162: warning: ignoring old recipe for target 'arch/x86/kernel/vmlinux.lds'
    [ snip ]
    LDS     arch/x86/kernel/vmlinux.lds

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 244c07f1cc70..3e6974b4ebf2 100644
--- a/Makefile
+++ b/Makefile
@@ -1118,7 +1118,8 @@ endif
 export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 
-vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
+# The actual objects are generated when descending.
+$(sort $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)): .
 
 # Recurse until adjust_autoksyms.sh is satisfied
 PHONY += autoksyms_recursive
@@ -1157,10 +1158,6 @@ vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
 
 targets := vmlinux
 
-# The actual objects are generated when descending,
-# make sure no implicit rule kicks in
-$(sort $(vmlinux-deps)): . ;
-
 filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
 
-- 
2.34.1

