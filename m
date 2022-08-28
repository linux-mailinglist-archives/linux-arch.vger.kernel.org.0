Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB75A3B0C
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiH1Cnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH1Cnv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:43:51 -0400
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E1252BD
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:43:50 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-07.nifty.com with ESMTP id 27S2emww032022
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:48 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gu030639;
        Sun, 28 Aug 2022 11:40:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gu030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654413;
        bh=bA4m7Oj/dBBjOfmTbtXEU7Zl9NzP1RzoFwx0p/QmZlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2dRWT6MQavqXDxUN3pVnGLgUD4HO43Wk2TWKy9LF2Vemr+cDDemDALWxndEmT5by
         02DRkaIy9XWLGK6NJ3BIxxBm8AhmMTDqaZP1XpOQDNXoXeryRepwz5obLdTrMlVnr9
         78IfjEJ+fcOyaEpeUfZ8BDpqD5RIAeMgNrUiOURg5xi8JmO8wA30J5XXJuOHxVlnKC
         qUFdBn+CGfujKidnvGE0bhU6gZdNy3YcTQIA7Bnc5wAgxgG6/v/m/EMUjTr2g5cBOS
         npdKPEfulBLS5mtxfhLrEuxO5nRQdCDQ7y9SwQ1r+MnWMI9A3ZZ0LB8HgfSULuPmt6
         lpDwLNC87xBMg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 12/15] kbuild: move vmlinux.o rule to the top Makefile
Date:   Sun, 28 Aug 2022 11:40:00 +0900
Message-Id: <20220828024003.28873-13-masahiroy@kernel.org>
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

Move the build rules of vmlinux.o out of scripts/link-vmlinux.sh to
clearly separate 1) pre-modpost, 2) modpost, 3) post-modpost stages.
This will make furture refactoring possible.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                | 10 ++++++++--
 scripts/link-vmlinux.sh |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 02724bcf8fdc..d81b7a587b43 100644
--- a/Makefile
+++ b/Makefile
@@ -645,6 +645,8 @@ else
 __all: modules
 endif
 
+targets :=
+
 # Decide whether to build built-in, modular, or both.
 # Normally, just do built-in.
 
@@ -1153,6 +1155,10 @@ quiet_cmd_autoksyms_h = GEN     $@
 $(autoksyms_h):
 	$(call cmd,autoksyms_h)
 
+targets += vmlinux.o
+vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
@@ -1160,10 +1166,10 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
 	+$(call if_changed_dep,link-vmlinux)
 
-targets := vmlinux
+targets += vmlinux
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 161bca64e8aa..07486f90d5e2 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -214,9 +214,6 @@ if [ "$1" = "clean" ]; then
 	exit 0
 fi
 
-#link vmlinux.o
-${MAKE} -f "${srctree}/scripts/Makefile.vmlinux_o"
-
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
 
-- 
2.34.1

