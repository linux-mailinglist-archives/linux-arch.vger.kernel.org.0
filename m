Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067094BF5E2
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiBVKdY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 05:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiBVKdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 05:33:22 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885015B3CD;
        Tue, 22 Feb 2022 02:32:57 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wVC1v0cz9sSN;
        Tue, 22 Feb 2022 11:32:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kStqDpzh4zT8; Tue, 22 Feb 2022 11:32:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wV93ZtLz9sSK;
        Tue, 22 Feb 2022 11:32:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 670548B77C;
        Tue, 22 Feb 2022 11:32:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iHGhXRzpFIdw; Tue, 22 Feb 2022 11:32:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C7558B776;
        Tue, 22 Feb 2022 11:32:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MAWfBa1075961
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:32:41 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MAWeA91075960;
        Tue, 22 Feb 2022 11:32:40 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH v4 1/6] module: Always have struct mod_tree_root
Date:   Tue, 22 Feb 2022 11:32:15 +0100
Message-Id: <5aa01e3616b21e0852339f16977c4748d753a877.1645525635.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645525635.git.christophe.leroy@csgroup.eu>
References: <cover.1645525635.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645525927; l=1894; s=20211009; h=from:subject:message-id; bh=HWxnRsPR+jGc6DcvDzhY2sNrJsSzgtD1s5A9mBE2MuU=; b=1LPhH+ll8zXayfOliP9suIjyXx4+BIvF7Eh/jPDpNs/b5k/+/TrGFGFJJuraedfaGVXAhueqSAGO d0Hy8heTDffToQ+9n1+chwWdH3I5Z6xEO0Dk0B5qIwb9i/Y0c2lF
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to separate text and data, we need to setup
two rb trees.

This means that struct mod_tree_root is required even without
MODULES_TREE_LOOKUP.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h | 4 +++-
 kernel/module/main.c     | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index fecfa590c149..07561753158d 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -143,15 +143,17 @@ static inline void module_decompress_cleanup(struct load_info *info)
 }
 #endif
 
-#ifdef CONFIG_MODULES_TREE_LOOKUP
 struct mod_tree_root {
+#ifdef CONFIG_MODULES_TREE_LOOKUP
 	struct latch_tree_root root;
+#endif
 	unsigned long addr_min;
 	unsigned long addr_max;
 };
 
 extern struct mod_tree_root mod_tree;
 
+#ifdef CONFIG_MODULES_TREE_LOOKUP
 void mod_tree_insert(struct module *mod);
 void mod_tree_remove_init(struct module *mod);
 void mod_tree_remove(struct module *mod);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0749afdc34b5..3b75cb97f8c2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -74,7 +74,6 @@ static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
 static LLIST_HEAD(init_free_list);
 
-#ifdef CONFIG_MODULES_TREE_LOOKUP
 struct mod_tree_root mod_tree __cacheline_aligned = {
 	.addr_min = -1UL,
 };
@@ -82,10 +81,6 @@ struct mod_tree_root mod_tree __cacheline_aligned = {
 #define module_addr_min mod_tree.addr_min
 #define module_addr_max mod_tree.addr_max
 
-#else /* !CONFIG_MODULES_TREE_LOOKUP */
-static unsigned long module_addr_min = -1UL, module_addr_max;
-#endif /* CONFIG_MODULES_TREE_LOOKUP */
-
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
 	const s32 *crcs;
-- 
2.34.1

