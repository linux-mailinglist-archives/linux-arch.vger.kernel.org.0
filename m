Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7405ADF8B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 08:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiIFGOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiIFGOG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 02:14:06 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79446F27D;
        Mon,  5 Sep 2022 23:14:04 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2866DVI7023845;
        Tue, 6 Sep 2022 15:13:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2866DVI7023845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662444812;
        bh=A0TAOcTfi2uZJQ5sEtMq2Cvx5AMNE3xo9Mwd6ECs1v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmuELPOQ7fU0Eq/1FVlgnLdP2I3YnxWc5Bcn6Y9X2IE4dbDb/y9sGcZyLedhkMGPo
         NNFeAZ8Hv5/VzJ1FpTucJsGDH8Ju3AeER9wGY9jekyhPlGVPK5TtK4xf5Y8R8YiLYj
         NuPW8iACEusufTJO0fn37dJsZU4yNT97XTnfMAJl5cM6C8BrYQCTS249YsEA+vNTqA
         75vHX3WanVytNMNLpwGa+TBJtHlN3nJyUsTnNH/xn4Syg1JD7NK5AJaE8iOUYnzgFu
         0QbosTsog6sYOMgzluk3Z55+pf4vvvhqsODkZyrV/CHjVGTQA9guHAiodtdu+tzCem
         NKh6ZrhyQJYpA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/8] kbuild: fix and refactor single target build
Date:   Tue,  6 Sep 2022 15:13:06 +0900
Message-Id: <20220906061313.1445810-2-masahiroy@kernel.org>
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

The single target build has a subtle bug for the combination for
an individual file and a subdirectory.

[1] 'make kernel/fork.i' builds only kernel/fork.i

  $ make kernel/fork.i
    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    CPP     kernel/fork.i

[2] 'make kernel/' builds only under the kernel/ directory.

  $ make kernel/
    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    CC      kernel/fork.o
    CC      kernel/exec_domain.o
       [snip]
    CC      kernel/rseq.o
    AR      kernel/built-in.a

But, if you try to do [1] and [2] in a single command, you will get
only [1] with a weird log:

  $ make kernel/fork.i kernel/
    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    CPP     kernel/fork.i
  make[2]: Nothing to be done for 'kernel/'.

With 'make kernel/fork.i kernel/', you should get both [1] and [2].

Rewrite the single target build.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - New

 Makefile               |  9 ++++---
 scripts/Makefile.build | 54 +++++++++++++-----------------------------
 2 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/Makefile b/Makefile
index 0af9dd405fb1..373cd2f0f49e 100644
--- a/Makefile
+++ b/Makefile
@@ -1824,11 +1824,11 @@ single_modpost: $(single-no-ko) modules_prepare
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 	$(Q)rm -f $(MODORDER)
 
-export KBUILD_SINGLE_TARGETS := $(addprefix $(extmod_prefix), $(single-no-ko))
+single-goals := $(addprefix $(extmod_prefix), $(single-no-ko))
 
 # trim unrelated directories
 build-dirs := $(foreach d, $(build-dirs), \
-			$(if $(filter $(d)/%, $(KBUILD_SINGLE_TARGETS)), $(d)))
+			$(if $(filter $d/%, $(single-goals)), $d))
 
 endif
 
@@ -1840,9 +1840,8 @@ endif
 PHONY += descend $(build-dirs)
 descend: $(build-dirs)
 $(build-dirs): prepare
-	$(Q)$(MAKE) $(build)=$@ \
-	single-build=$(if $(filter-out $@/, $(filter $@/%, $(KBUILD_SINGLE_TARGETS))),1) \
-	need-builtin=1 need-modorder=1
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1 need-modorder=1 \
+	$(filter $@/%, $(single-goals))
 
 clean-dirs := $(addprefix _clean_, $(clean-dirs))
 PHONY += $(clean-dirs) clean
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0df488d0bbb0..91d2e5461a3e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -5,8 +5,8 @@
 
 src := $(obj)
 
-PHONY := __build
-__build:
+PHONY := $(obj)/
+$(obj)/:
 
 # Init all relevant variables used in kbuild files so
 # 1) they have correct type
@@ -323,7 +323,7 @@ $(obj)/%.o: $(src)/%.S FORCE
 
 targets += $(filter-out $(subdir-builtin), $(real-obj-y))
 targets += $(filter-out $(subdir-modorder), $(real-obj-m))
-targets += $(real-dtb-y) $(lib-y) $(always-y) $(MAKECMDGOALS)
+targets += $(real-dtb-y) $(lib-y) $(always-y)
 
 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
@@ -400,8 +400,6 @@ $(multi-obj-m): %.o: %.mod FORCE
 	$(call if_changed_rule,ld_multi_m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 
-targets := $(filter-out $(PHONY), $(targets))
-
 # Add intermediate targets:
 # When building objects with specific suffix patterns, add intermediate
 # targets that the final targets are derived from.
@@ -420,52 +418,29 @@ targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 # Build
 # ---------------------------------------------------------------------------
 
-ifdef single-build
-
-KBUILD_SINGLE_TARGETS := $(filter $(obj)/%, $(KBUILD_SINGLE_TARGETS))
-
-curdir-single := $(sort $(foreach x, $(KBUILD_SINGLE_TARGETS), \
-			$(if $(filter $(x) $(basename $(x)).o, $(targets)), $(x))))
-
-# Handle single targets without any rule: show "Nothing to be done for ..." or
-# "No rule to make target ..." depending on whether the target exists.
-unknown-single := $(filter-out $(addsuffix /%, $(subdir-ym)), \
-			$(filter-out $(curdir-single), $(KBUILD_SINGLE_TARGETS)))
-
-single-subdirs := $(foreach d, $(subdir-ym), \
-			$(if $(filter $(d)/%, $(KBUILD_SINGLE_TARGETS)), $(d)))
-
-__build: $(curdir-single) $(single-subdirs)
-ifneq ($(unknown-single),)
-	$(Q)$(MAKE) -f /dev/null $(unknown-single)
-endif
+$(obj)/: $(if $(KBUILD_BUILTIN), $(targets-for-builtin)) \
+	 $(if $(KBUILD_MODULES), $(targets-for-modules)) \
+	 $(subdir-ym) $(always-y)
 	@:
 
-ifeq ($(curdir-single),)
-# Nothing to do in this directory. Do not include any .*.cmd file for speed-up
-targets :=
-else
-targets += $(curdir-single)
-endif
+# Single targets
+# ---------------------------------------------------------------------------
 
-else
+single-subdirs := $(foreach d, $(subdir-ym), $(if $(filter $d/%, $(MAKECMDGOALS)), $d))
+single-subdir-goals := $(filter $(addsuffix /%, $(single-subdirs)), $(MAKECMDGOALS))
 
-__build: $(if $(KBUILD_BUILTIN), $(targets-for-builtin)) \
-	 $(if $(KBUILD_MODULES), $(targets-for-modules)) \
-	 $(subdir-ym) $(always-y)
+$(single-subdir-goals): $(single-subdirs)
 	@:
 
-endif
-
 # Descending
 # ---------------------------------------------------------------------------
 
 PHONY += $(subdir-ym)
 $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@ \
-	$(if $(filter $@/, $(KBUILD_SINGLE_TARGETS)),single-build=) \
 	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
-	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1)
+	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1) \
+	$(filter $@/%, $(single-subdir-goals))
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
@@ -474,6 +449,9 @@ PHONY += FORCE
 
 FORCE:
 
+targets += $(filter-out $(single-subdir-goals), $(MAKECMDGOALS))
+targets := $(filter-out $(PHONY), $(targets))
+
 # Read all saved command lines and dependencies for the $(targets) we
 # may be building above, using $(if_changed{,_dep}). As an
 # optimization, we don't need to read them if the target does not
-- 
2.34.1

