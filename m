Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9842429328
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhJKP2p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 11:28:45 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52677 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238231AbhJKP2n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 11:28:43 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HSjM41DLlz9sV4;
        Mon, 11 Oct 2021 17:26:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fpQr6HfP7u29; Mon, 11 Oct 2021 17:26:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM271n6z9sTs;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC8AA8B773;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jI_UH71UA1dc; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A8238B77A;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQWd31585043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:26:32 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQWRh1585042;
        Mon, 11 Oct 2021 17:26:32 +0200
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
Subject: [PATCH v1 10/10] lkdtm: Fix execute_[user]_location()
Date:   Mon, 11 Oct 2021 17:25:37 +0200
Message-Id: <c551f3f4b803d1a4a184b0fa94475d405ba436d8.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633964380.git.christophe.leroy@csgroup.eu>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965929; l=3205; s=20211009; h=from:subject:message-id; bh=l9VMW9X0cJdJ5G39QvOQSX7TaMvTqTcPjFZvPR3zBnY=; b=jicnpEgsrfjH5zYpDhYjzje61oqpOOuq/IuppB5jOn2Ba0Gd0x1VsCW6/z7XdMGhv8A23JZri38f B8zYR3a+B6WB1RVyyaaI9RtV86aWs3LS+2H/2P5Ya4RB7CP/W3A1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

execute_location() and execute_user_location() intent
to copy do_nothing() text and execute it at a new location.
However, at the time being it doesn't copy do_nothing() function
but do_nothing() function descriptor which still points to the
original text. So at the end it still executes do_nothing() at
its original location allthough using a copied function descriptor.

So, fix that by really copying do_nothing() text and build a new
function descriptor by copying do_nothing() function descriptor and
updating the target address with the new location.

Also fix the displayed addresses by dereferencing do_nothing()
function descriptor.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/perms.c | 45 +++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index da16564e1ecd..1d03cd44c21d 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -44,19 +44,42 @@ static noinline void do_overwritten(void)
 	return;
 }
 
+static void *setup_function_descriptor(funct_descr_t *fdesc, void *dst)
+{
+	int err;
+
+	if (!__is_defined(HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR))
+		return dst;
+
+	err = copy_from_kernel_nofault(fdesc, do_nothing, sizeof(*fdesc));
+	if (err < 0)
+		return ERR_PTR(err);
+
+	fdesc->addr = (unsigned long)dst;
+	barrier();
+
+	return fdesc;
+}
+
 static noinline void execute_location(void *dst, bool write)
 {
-	void (*func)(void) = dst;
+	void (*func)(void);
+	funct_descr_t fdesc;
+	void *do_nothing_text = dereference_symbol_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing_text);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing, EXEC_SIZE);
+		memcpy(dst, do_nothing_text, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
-	pr_info("attempting bad execution at %px\n", func);
+	func = setup_function_descriptor(&fdesc, dst);
+	if (IS_ERR(func))
+		return;
+
+	pr_info("attempting bad execution at %px\n", dst);
 	func();
 	pr_err("FAIL: func returned\n");
 }
@@ -66,16 +89,22 @@ static void execute_user_location(void *dst)
 	int copied;
 
 	/* Intentionally crossing kernel/user memory boundary. */
-	void (*func)(void) = dst;
+	void (*func)(void);
+	funct_descr_t fdesc;
+	void *do_nothing_text = dereference_symbol_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing_text);
 	do_nothing();
 
-	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
+	copied = access_process_vm(current, (unsigned long)dst, do_nothing_text,
 				   EXEC_SIZE, FOLL_WRITE);
 	if (copied < EXEC_SIZE)
 		return;
-	pr_info("attempting bad execution at %px\n", func);
+	func = setup_function_descriptor(&fdesc, dst);
+	if (IS_ERR(func))
+		return;
+
+	pr_info("attempting bad execution at %px\n", dst);
 	func();
 	pr_err("FAIL: func returned\n");
 }
-- 
2.31.1

