Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BCF5ADF81
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiIFGOQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 02:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiIFGOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 02:14:09 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30316F55B;
        Mon,  5 Sep 2022 23:14:06 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2866DVIB023845;
        Tue, 6 Sep 2022 15:13:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2866DVIB023845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662444814;
        bh=X4KzG7A2tIDpii0nEszPxOJ4iuViPn1BTHlscZsjm4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfBZ3s+05dWgPNDme5EX23w8FlGcYRpUdlV5/37FnmsTeDwI+TG0u060nwusgwtOk
         Y2+4o9C9AWsaj9H8VzgMa/C8dXk1hPSlOLEjSBr1ROf6OR5sAN9I1b7hconmHQ4ZeP
         NXQQdib6gZ7nquRUnMghpuyIANobZBqdJZ9XVppLiiIr9WhMA97RrXikmtFr2L24oA
         dChy92TEj3SpPvyrJBj3k2hOM4WXMNhPBF6DKwcBPf5DIl6VsuI7zt+hPzv64UG2f2
         Ik8gTEn2wCH7AsHBsdsXZ/gbRjNc0z4QXX3GeHG++HRRlgv1mt6YfwJhcfLOr9yV2w
         kLVZgKSj5qP5w==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 5/8] kbuild: move vmlinux.o rule to the top Makefile
Date:   Tue,  6 Sep 2022 15:13:10 +0900
Message-Id: <20220906061313.1445810-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906061313.1445810-1-masahiroy@kernel.org>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
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

(no changes since v1)

 Makefile                | 10 ++++++++--
 scripts/link-vmlinux.sh |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index cf06ace9da3a..e4c270256849 100644
--- a/Makefile
+++ b/Makefile
@@ -645,6 +645,8 @@ else
 __all: modules
 endif
 
+targets :=
+
 # Decide whether to build built-in, modular, or both.
 # Normally, just do built-in.
 
@@ -1149,6 +1151,10 @@ quiet_cmd_autoksyms_h = GEN     $@
 $(autoksyms_h):
 	$(call cmd,autoksyms_h)
 
+targets += vmlinux.o
+vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
@@ -1156,10 +1162,10 @@ cmd_link-vmlinux =                                                 \
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

