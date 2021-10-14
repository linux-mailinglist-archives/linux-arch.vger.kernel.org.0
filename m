Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11E542D285
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhJNG1T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:27:19 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhJNG1N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:27:13 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVK9h5Hh9z9sSb;
        Thu, 14 Oct 2021 08:24:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WkfQKbTlHhED; Thu, 14 Oct 2021 08:24:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9Z4pzWz9sSm;
        Thu, 14 Oct 2021 08:24:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F2E88B788;
        Thu, 14 Oct 2021 08:24:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fQzu50CkfBZv; Thu, 14 Oct 2021 08:24:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3589A8B763;
        Thu, 14 Oct 2021 08:24:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oQgm2266042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:50:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oQd22266041;
        Thu, 14 Oct 2021 07:50:26 +0200
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
Subject: [PATCH v2 12/13] lkdtm: Fix execute_[user]_location()
Date:   Thu, 14 Oct 2021 07:50:01 +0200
Message-Id: <cbee30c66890994e116a8eae8094fa8c5336f90a.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190596; l=3389; s=20211009; h=from:subject:message-id; bh=/NBloWboE7tAULPmP7BOXtz6OWoNUEZRrAB3xKixwdU=; b=4flPamtTkvGPUtcU0sHwSxv0NG8ktt3lwWa8/xTZBJ5IOlZl9vgP0rMEQGn4vB7FTUGMNKDCY1vl jjnZDPU5Bkp23Hqfy/0Db4Tf8vg3xiRSXNuPYEhC+6C4yEdRDVTL
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
 drivers/misc/lkdtm/perms.c     | 25 +++++++++++++++++++++----
 include/asm-generic/sections.h |  5 +++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 5266dc28df6e..96b3ebfcb8ed 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -44,19 +44,32 @@ static noinline void do_overwritten(void)
 	return;
 }
 
+static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
+{
+	memcpy(fdesc, do_nothing, sizeof(*fdesc));
+	fdesc->addr = (unsigned long)dst;
+	barrier();
+
+	return fdesc;
+}
+
 static noinline void execute_location(void *dst, bool write)
 {
 	void (*func)(void) = dst;
+	func_desc_t fdesc;
+	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing_text);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing, EXEC_SIZE);
+		memcpy(dst, do_nothing_text, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
 	pr_info("attempting bad execution at %px\n", func);
+	if (have_function_descriptors())
+		func = setup_function_descriptor(&fdesc, dst);
 	func();
 	pr_err("FAIL: func returned\n");
 }
@@ -67,15 +80,19 @@ static void execute_user_location(void *dst)
 
 	/* Intentionally crossing kernel/user memory boundary. */
 	void (*func)(void) = dst;
+	func_desc_t fdesc;
+	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing_text);
 	do_nothing();
 
-	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
+	copied = access_process_vm(current, (unsigned long)dst, do_nothing_text,
 				   EXEC_SIZE, FOLL_WRITE);
 	if (copied < EXEC_SIZE)
 		return;
 	pr_info("attempting bad execution at %px\n", func);
+	if (have_function_descriptors())
+		func = setup_function_descriptor(&fdesc, dst);
 	func();
 	pr_err("FAIL: func returned\n");
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 76163883c6ff..d225318538bd 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -70,6 +70,11 @@ typedef struct {
 } func_desc_t;
 #endif
 
+static inline bool have_function_descriptors(void)
+{
+	return __is_defined(HAVE_FUNCTION_DESCRIPTORS);
+}
+
 /* random extra sections (if any).  Override
  * in asm/sections.h */
 #ifndef arch_is_kernel_text
-- 
2.31.1

