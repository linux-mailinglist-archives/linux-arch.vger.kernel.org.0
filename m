Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66F4B6C69
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiBOMnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:43:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiBOMnZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:43:25 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B7310F221;
        Tue, 15 Feb 2022 04:42:37 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jygh14TCXz9sT9;
        Tue, 15 Feb 2022 13:41:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VRNGzQt5ARFU; Tue, 15 Feb 2022 13:41:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn5Wrhz9sSs;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2F2C8B776;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BdNYLY9V5Ia4; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E2B88B783;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfGlx080625
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:16 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfGE5080624;
        Tue, 15 Feb 2022 13:41:16 +0100
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
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 05/13] powerpc: Prepare func_desc_t for refactorisation
Date:   Tue, 15 Feb 2022 13:41:00 +0100
Message-Id: <5c36105e08b27b98450535bff48d71b690c19739.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=2077; s=20211009; h=from:subject:message-id; bh=eWkkuij94sQttgAjC+jIa2BG2RuNWEw1XF6aQWvveWc=; b=6KWY1N85qhp/0sxCJnv1UoBK4k+ZGhhchobwArncRfu9c3+b6FiSTKuPJJgkJlD50nKWY4e4QBwD 1i8VefRzCpgfpvyKvqM9tBXVnMmuxERO8jkMlrcK10bne8QpRDyL
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

In preparation of making func_desc_t generic, change the ELFv2
version to a struct containing 'addr' element.

This allows using single helpers common to ELFv1 and ELFv2 and
reduces the amount of #ifdef's

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/module_64.c | 36 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 46e8eeb7c432..ff93ef4cb5a2 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -33,19 +33,17 @@
 #ifdef PPC64_ELF_ABI_v2
 
 /* An address is simply the address of the function. */
-typedef unsigned long func_desc_t;
+typedef struct {
+	unsigned long addr;
+} func_desc_t;
 
 static func_desc_t func_desc(unsigned long addr)
 {
-	return addr;
-}
-static unsigned long func_addr(unsigned long addr)
-{
-	return addr;
-}
-static unsigned long stub_func_addr(func_desc_t func)
-{
-	return func;
+	func_desc_t desc = {
+		.addr = addr,
+	};
+
+	return desc;
 }
 
 /* PowerPC64 specific values for the Elf64_Sym st_other field.  */
@@ -70,14 +68,6 @@ static func_desc_t func_desc(unsigned long addr)
 {
 	return *(struct func_desc *)addr;
 }
-static unsigned long func_addr(unsigned long addr)
-{
-	return func_desc(addr).addr;
-}
-static unsigned long stub_func_addr(func_desc_t func)
-{
-	return func.addr;
-}
 static unsigned int local_entry_offset(const Elf64_Sym *sym)
 {
 	return 0;
@@ -93,6 +83,16 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 }
 #endif
 
+static unsigned long func_addr(unsigned long addr)
+{
+	return func_desc(addr).addr;
+}
+
+static unsigned long stub_func_addr(func_desc_t func)
+{
+	return func.addr;
+}
+
 #define STUB_MAGIC 0x73747562 /* stub */
 
 /* Like PPC32, we need little trampolines to do > 24-bit jumps (into
-- 
2.34.1

