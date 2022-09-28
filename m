Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850185ED52E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiI1Gmu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiI1Gl4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 02:41:56 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51973718E;
        Tue, 27 Sep 2022 23:41:42 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28S6e0G8004120;
        Wed, 28 Sep 2022 15:40:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28S6e0G8004120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664347208;
        bh=5aYc69QpW6nhNbvRlVUs8p1oo1ZG3mtyqAcjgjlEHS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMYrLrCp7B/y6UWo8uz7r4Jb7xL5og70/qXMKphIAXU6tWYk0ngVD2u3PlA8QKneB
         ZOz+s+HjEjOc3e4UAq9E0XmmH9VclUQubtykYl4FUpjj5kiM0/fIy5glik8QNephsv
         Gbttsi+Bf309s+l7En+wJAB0AhlrO0GNiBwOOdea9F/1Ar2UkGA95Vq8gfkO7CHbyb
         a+ULeoLdO7WADaGuImI13pKp/Fhp2lJxoLILAq9mZNsp2V5PtWkF/hzwSicRgo1lOf
         bzTS73c6Jt5st2ZY2DKZZ4Hts9vIYweWULkwJZOT/f1gRDPAQtNln+EjgPO2o6jGlS
         9sgfm274mO6Jg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 7/8] modpost: squash report_sec_mismatch() and remove enum mismatch
Date:   Wed, 28 Sep 2022 15:39:46 +0900
Message-Id: <20220928063947.299333-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928063947.299333-1-masahiroy@kernel.org>
References: <20220928063947.299333-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now report_sec_mismatch() prints the same warning message for all
possible cases. (fatal() is just a sanity check for unreachable code.)

Squash it into default_mismatch_handler().

enum mismatch is no longer used. Remove it as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/mod/modpost.c | 61 +++----------------------------------------
 1 file changed, 4 insertions(+), 57 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29f30558a398..90733664a602 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -847,18 +847,6 @@ static const char *const linker_symbols[] =
 	{ "__init_begin", "_sinittext", "_einittext", NULL };
 static const char *const optim_symbols[] = { "*.constprop.*", NULL };
 
-enum mismatch {
-	TEXT_TO_ANY_INIT,
-	DATA_TO_ANY_INIT,
-	TEXT_TO_ANY_EXIT,
-	DATA_TO_ANY_EXIT,
-	XXXINIT_TO_SOME_INIT,
-	XXXEXIT_TO_SOME_EXIT,
-	ANY_INIT_TO_ANY_EXIT,
-	ANY_EXIT_TO_ANY_INIT,
-	EXTABLE_TO_NON_TEXT,
-};
-
 /**
  * Describe how to match sections on different criteria:
  *
@@ -880,7 +868,6 @@ struct sectioncheck {
 	const char *fromsec[20];
 	const char *bad_tosec[20];
 	const char *good_tosec[20];
-	enum mismatch mismatch;
 	void (*handler)(const char *modname, struct elf_info *elf,
 			const struct sectioncheck* const mismatch,
 			Elf_Rela *r, Elf_Sym *sym, const char *fromsec);
@@ -899,56 +886,46 @@ static const struct sectioncheck sectioncheck[] = {
 {
 	.fromsec = { TEXT_SECTIONS, NULL },
 	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
-	.mismatch = TEXT_TO_ANY_INIT,
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
 	.bad_tosec = { ALL_XXXINIT_SECTIONS, NULL },
-	.mismatch = DATA_TO_ANY_INIT,
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
 	.bad_tosec = { INIT_SECTIONS, NULL },
-	.mismatch = DATA_TO_ANY_INIT,
 },
 {
 	.fromsec = { TEXT_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
-	.mismatch = TEXT_TO_ANY_EXIT,
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
-	.mismatch = DATA_TO_ANY_EXIT,
 },
 /* Do not reference init code/data from meminit code/data */
 {
 	.fromsec = { ALL_XXXINIT_SECTIONS, NULL },
 	.bad_tosec = { INIT_SECTIONS, NULL },
-	.mismatch = XXXINIT_TO_SOME_INIT,
 },
 /* Do not reference exit code/data from memexit code/data */
 {
 	.fromsec = { ALL_XXXEXIT_SECTIONS, NULL },
 	.bad_tosec = { EXIT_SECTIONS, NULL },
-	.mismatch = XXXEXIT_TO_SOME_EXIT,
 },
 /* Do not use exit code/data from init code */
 {
 	.fromsec = { ALL_INIT_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
-	.mismatch = ANY_INIT_TO_ANY_EXIT,
 },
 /* Do not use init code/data from exit code */
 {
 	.fromsec = { ALL_EXIT_SECTIONS, NULL },
 	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
-	.mismatch = ANY_EXIT_TO_ANY_INIT,
 },
 {
 	.fromsec = { ALL_PCI_INIT_SECTIONS, NULL },
 	.bad_tosec = { INIT_SECTIONS, NULL },
-	.mismatch = ANY_INIT_TO_ANY_EXIT,
 },
 {
 	.fromsec = { "__ex_table", NULL },
@@ -957,7 +934,6 @@ static const struct sectioncheck sectioncheck[] = {
 	 */
 	.bad_tosec = { ".altinstr_replacement", NULL },
 	.good_tosec = {ALL_TEXT_SECTIONS , NULL},
-	.mismatch = EXTABLE_TO_NON_TEXT,
 	.handler = extable_mismatch_handler,
 }
 };
@@ -1215,37 +1191,6 @@ static inline void get_pretty_name(int is_func, const char** name, const char**
 	}
 }
 
-/*
- * Print a warning about a section mismatch.
- * Try to find symbols near it so user can find it.
- * Check whitelist before warning - it may be a false positive.
- */
-static void report_sec_mismatch(const char *modname,
-				const struct sectioncheck *mismatch,
-				const char *fromsec,
-				const char *fromsym,
-				const char *tosec, const char *tosym)
-{
-	sec_mismatch_count++;
-
-	switch (mismatch->mismatch) {
-	case TEXT_TO_ANY_INIT:
-	case DATA_TO_ANY_INIT:
-	case TEXT_TO_ANY_EXIT:
-	case DATA_TO_ANY_EXIT:
-	case XXXINIT_TO_SOME_INIT:
-	case XXXEXIT_TO_SOME_EXIT:
-	case ANY_INIT_TO_ANY_EXIT:
-	case ANY_EXIT_TO_ANY_INIT:
-		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-		     modname, fromsym, fromsec, tosym, tosec);
-		break;
-	case EXTABLE_TO_NON_TEXT:
-		fatal("There's a special handler for this mismatch type, we should never get here.\n");
-		break;
-	}
-}
-
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
 				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
@@ -1266,8 +1211,10 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	/* check whitelist - we may ignore it */
 	if (secref_whitelist(mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
-		report_sec_mismatch(modname, mismatch,
-				    fromsec, fromsym, tosec, tosym);
+		sec_mismatch_count++;
+
+		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
+		     modname, fromsym, fromsec, tosym, tosec);
 	}
 }
 
-- 
2.34.1

