Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0594B6C30
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiBOMli (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:41:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiBOMli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:41:38 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0BAE09C;
        Tue, 15 Feb 2022 04:41:26 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jyggn2R2Fz9sSQ;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id epMSd0M7Bhjy; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn1MCsz9sRw;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C8E78B788;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pr8hYevnppY4; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 650108B763;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfHY7080649
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:17 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfHP2080648;
        Tue, 15 Feb 2022 13:41:17 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 11/13] lkdtm: Really write into kernel text in WRITE_KERN
Date:   Tue, 15 Feb 2022 13:41:06 +0100
Message-Id: <31e58eaffb5bc51c07d8d4891d1982100ade8cfc.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=2328; s=20211009; h=from:subject:message-id; bh=ZctxL58TJetAA5+oFKdI1os7Sbl8JEWFwgZaaluEYa0=; b=Oke9y25FxwuppYh4MV7OOEQT4od24HIRzqfetvFnWGD1qdbWebu8c/DVazZEcPTRunJLJguZ1WeA r1YD2DOPBI4nGglA/4rBN2H3BkL7DAxrZQFFo6UVN27kQMumJh7K
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

WRITE_KERN is supposed to overwrite some kernel text, namely
do_overwritten() function.

But at the time being it overwrites do_overwritten() function
descriptor, not function text.

Fix it by dereferencing the function descriptor to obtain
function text pointer. Export dereference_function_descriptor()
for when LKDTM is built as a module.

And make do_overwritten() noinline so that it is really
do_overwritten() which is called by lkdtm_WRITE_KERN().

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/perms.c | 8 +++++---
 kernel/extable.c           | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 60b3b2fe929d..035fcca441f0 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -10,6 +10,7 @@
 #include <linux/mman.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/sections.h>
 
 /* Whether or not to fill the target memory area with do_nothing(). */
 #define CODE_WRITE	true
@@ -37,7 +38,7 @@ static noinline void do_nothing(void)
 }
 
 /* Must immediately follow do_nothing for size calculuations to work out. */
-static void do_overwritten(void)
+static noinline void do_overwritten(void)
 {
 	pr_info("do_overwritten wasn't overwritten!\n");
 	return;
@@ -113,8 +114,9 @@ void lkdtm_WRITE_KERN(void)
 	size_t size;
 	volatile unsigned char *ptr;
 
-	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
-	ptr = (unsigned char *)do_overwritten;
+	size = (unsigned long)dereference_function_descriptor(do_overwritten) -
+	       (unsigned long)dereference_function_descriptor(do_nothing);
+	ptr = dereference_function_descriptor(do_overwritten);
 
 	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
 	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
diff --git a/kernel/extable.c b/kernel/extable.c
index 394c39b86e38..bda5e9761541 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -149,6 +149,7 @@ void *dereference_function_descriptor(void *ptr)
 		ptr = p;
 	return ptr;
 }
+EXPORT_SYMBOL_GPL(dereference_function_descriptor);
 
 void *dereference_kernel_function_descriptor(void *ptr)
 {
-- 
2.34.1

