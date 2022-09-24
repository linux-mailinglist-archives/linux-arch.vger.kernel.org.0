Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF745E8F30
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 20:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiIXSU2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIXSU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 14:20:27 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36C2E9FA;
        Sat, 24 Sep 2022 11:20:24 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 28OIJItU005682;
        Sun, 25 Sep 2022 03:19:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 28OIJItU005682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664043561;
        bh=uiG7rI5DI3x1bTZk8cALn27xRy6QbKgQoq+BLvGkH2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pvy6y1BulYgKIDuZM3hDfrrBZe8phtpI+YIfhSAjjGscVPpC9/p2FR+UCzfus/hkS
         9qBsxudXZ4yw3QCe69bysx+uor2Xq8oWxE1qwo0B7bs9UoqFiEileS5glNBFnxSd8I
         mUjIbwmrwvJRi5w0VbePnXpBJxjQjCcu/mprxeWVcRMwxN30c25+PdTbA6SJ/1MOQT
         PLsEqROlM03icMC0umbuwKq2eY1PVnS6AFcjpb3L/TC0Ob7VG1uHXC3Hfcb4hlDnFE
         emcnNaYxJJrvsrREVB5snjrcBDrIB5nJuumwBWCg21gZT4qIT061Xgbgrv47c4mUlE
         odBqlqxTUvMwA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 4/7] kbuild: move vmlinux.o rule to the top Makefile
Date:   Sun, 25 Sep 2022 03:19:12 +0900
Message-Id: <20220924181915.3251186-5-masahiroy@kernel.org>
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

Move the build rules of vmlinux.o out of scripts/link-vmlinux.sh to
clearly separate 1) pre-modpost, 2) modpost, 3) post-modpost stages.
This will make furture refactoring possible.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile                | 5 ++++-
 scripts/link-vmlinux.sh | 3 ---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 92413b6de451..b5dfb54b1993 100644
--- a/Makefile
+++ b/Makefile
@@ -1142,6 +1142,9 @@ quiet_cmd_autoksyms_h = GEN     $@
 $(autoksyms_h):
 	$(call cmd,autoksyms_h)
 
+vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
@@ -1149,7 +1152,7 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
 	+$(call if_changed_dep,link-vmlinux)
 
 targets := vmlinux
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

