Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1735EB23F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIZUhu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIZUht (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 16:37:49 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1838F96B;
        Mon, 26 Sep 2022 13:37:46 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28QKaWu3018737;
        Tue, 27 Sep 2022 05:36:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28QKaWu3018737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664224597;
        bh=YuiSaa5TunTalSUSMGyvPMuKWQEyEfJw4GcU2AlJPTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nplNeLG6r/TpbfWLXiMv77IUCbyTNDsDqyirwRmTRUCHR7Glfkfy2jbS96tJNbFrz
         ncZbBEK73Svvmeb0S5afAvUgE4SSLoMbroA7o8t3LjfIrWWk3iRxBLpeuZ09ab2I0D
         udqVkrXtyIbPQgb9rIFELmOleazKYRE8+oNB4MlyYJD+/J2rhC2qy0dFn8kAuwaS6A
         nR4GW0LmJIVb/wVPcFRJ9dtQb/RPxAaucfLfEo6YJLrLrtWBibP09Er0eqPcjqX3g1
         4pLjqj3bgECyOo7RDK9vfStjDSzOK22hQvetXBO+g/CI+fT/NZer07cfubsvhlDZWr
         VjkbNkxELX+3g==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 3/7] modpost: merge sym_update_namespace() into sym_add_exported()
Date:   Tue, 27 Sep 2022 05:36:21 +0900
Message-Id: <20220926203625.1117261-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926203625.1117261-1-masahiroy@kernel.org>
References: <20220926203625.1117261-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pass a set of the name, license, and namespace to sym_add_exported().

sym_update_namespace() is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 13fff6e92aef..0bb5bbd176b4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -352,26 +352,8 @@ static const char *sec_name(const struct elf_info *info, unsigned int secindex)
 
 #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
 
-static void sym_update_namespace(const char *symname, const char *namespace)
-{
-	struct symbol *s = find_symbol(symname);
-
-	/*
-	 * That symbol should have been created earlier and thus this is
-	 * actually an assertion.
-	 */
-	if (!s) {
-		error("Could not update namespace(%s) for symbol %s\n",
-		      namespace, symname);
-		return;
-	}
-
-	free(s->namespace);
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
-}
-
 static struct symbol *sym_add_exported(const char *name, struct module *mod,
-				       bool gpl_only)
+				       bool gpl_only, const char *namespace)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -384,6 +366,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
+	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -657,17 +640,12 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 		break;
 	default:
 		if (sym->st_shndx == info->export_symbol_sec) {
-			const char *name;
-
-			if (strstarts(symname, "__export_symbol_gpl.")) {
-				name = symname + strlen("__export_symbol_gpl.");
-				sym_add_exported(name, mod, true);
-				sym_update_namespace(name, sym_get_data(info, sym));
-			} else if (strstarts(symname, "__export_symbol.")) {
-				name = symname + strlen("__export_symbol.");
-				sym_add_exported(name, mod, false);
-				sym_update_namespace(name, sym_get_data(info, sym));
-			}
+			if (strstarts(symname, "__export_symbol_gpl."))
+				sym_add_exported(symname + strlen("__export_symbol_gpl."),
+						 mod, true, sym_get_data(info, sym));
+			else if (strstarts(symname, "__export_symbol."))
+				sym_add_exported(symname + strlen("__export_symbol."),
+						 mod, false, sym_get_data(info, sym));
 
 			break;
 		}
@@ -2283,9 +2261,8 @@ static void read_dump(const char *fname)
 			mod = new_module(modname, strlen(modname));
 			mod->from_dump = true;
 		}
-		s = sym_add_exported(symname, mod, gpl_only);
+		s = sym_add_exported(symname, mod, gpl_only, namespace);
 		sym_set_crc(s, crc);
-		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
 	return;
-- 
2.34.1

