Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3754D5EB267
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiIZUkz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiIZUkc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 16:40:32 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC07C755;
        Mon, 26 Sep 2022 13:40:15 -0700 (PDT)
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-05.nifty.com with ESMTP id 28QKbjxE029749;
        Tue, 27 Sep 2022 05:37:45 +0900
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28QKaWu4018737;
        Tue, 27 Sep 2022 05:36:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28QKaWu4018737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664224598;
        bh=OfuGM282m19iNX0i9PBWYpUdIc6yc2RZLrtabmbI8uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A48lnOjslGssnRTkBNZAS/jOg1yyoExtR8J6J98kYhDc/3Hxt3agsC0V2RpL8EOKE
         nK0g02ZftZq4njEU1acRjmpXyUTYzrofbyDc9eOj+A6Br5clcX+idZJhoFei2Gw/TF
         AG/tEzLm61kJSuxUgI9HZrftvcy7m473r7LGgO6phczEG5yV1wRvf70J3rlOIDRCES
         j5R47wRdK7tT7seyr/qX7qM38GymLrZw7ChG8rkexHsBnYNjGDUx7AqJtAVMmyIp6h
         3qAXbSklItGOecxTqfKF+jGLR6EkOTT5OWBUQdRIeoN8tq7dASssxcbRDLIg1lzZb7
         J7eE7tbZtZ9ow==
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
Subject: [PATCH v2 4/7] modpost: use null string instead of NULL pointer for default namespace
Date:   Tue, 27 Sep 2022 05:36:22 +0900
Message-Id: <20220926203625.1117261-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926203625.1117261-1-masahiroy@kernel.org>
References: <20220926203625.1117261-1-masahiroy@kernel.org>
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

The default namespace is the null string, "".

When set, the null string "" is converted to NULL:

  s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;

When printed, the NULL pointer is get back to the null string:

  sym->namespace ?: ""

This saves 1 byte memory allocated for "", but loses the readability.

In kernel-space, we strive to save memory, but modpost is a userspace
tool used to build the kernel. On modern systems, such small piece of
memory is not a big deal.

Handle the namespace string as is.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0bb5bbd176b4..29f30558a398 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -297,6 +297,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
 {
 	struct namespace_list *list;
 
+	/*
+	 * The default namespace is null string "", which is always implicitly
+	 * contained.
+	 */
+	if (!namespace[0])
+		return true;
+
 	list_for_each_entry(list, head, list) {
 		if (!strcmp(list->namespace, namespace))
 			return true;
@@ -366,7 +373,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+	s->namespace = NOFAIL(strdup(namespace));
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -1928,8 +1935,7 @@ static void check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->namespace &&
-		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
+		if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {
 			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
 				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
 				    basename, exp->name, exp->namespace);
@@ -2015,8 +2021,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 	list_for_each_entry(sym, &mod->exported_symbols, list)
 		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
-			   sym->is_gpl_only ? "_gpl" : "",
-			   sym->namespace ?: "");
+			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
 
 	if (!modversions)
 		return;
@@ -2284,7 +2289,7 @@ static void write_dump(const char *fname)
 			buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
 				   sym->crc, sym->name, mod->name,
 				   sym->is_gpl_only ? "_GPL" : "",
-				   sym->namespace ?: "");
+				   sym->namespace);
 		}
 	}
 	write_buf(&buf, fname);
-- 
2.34.1

