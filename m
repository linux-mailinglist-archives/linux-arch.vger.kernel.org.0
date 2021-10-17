Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6894A4308E6
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbhJQMmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 08:42:17 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49285 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343520AbhJQMmM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Oct 2021 08:42:12 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXKM81tvjz9sSk;
        Sun, 17 Oct 2021 14:39:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ep1nBrdLyEL; Sun, 17 Oct 2021 14:39:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXKM01C2Rz9sSp;
        Sun, 17 Oct 2021 14:39:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 060B18B776;
        Sun, 17 Oct 2021 14:39:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uOZoUsjCvn3j; Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D5DC58B778;
        Sun, 17 Oct 2021 14:39:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19HCctLC2946745
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 14:38:55 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19HCcthS2946744;
        Sun, 17 Oct 2021 14:38:55 +0200
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
Subject: [PATCH v3 04/12] powerpc: Prepare func_desc_t for refactorisation
Date:   Sun, 17 Oct 2021 14:38:17 +0200
Message-Id: <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634457599.git.christophe.leroy@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634474303; l=1910; s=20211009; h=from:subject:message-id; bh=nHgQgFrfZgHAs28pN2VtYBt7B1ZdOmikgTPEmDQGwUs=; b=eocMCBbEV1TFGbprF03T3Lb2TPcMEi9cOyFVpZztt93wi8rjs6VDNXRzngC9WbhWR2LwBs4FgeuF zvKc5KypBu54ML31yMoXIImf7TbaNzFjgtwJD1EzLqwK46LGcK+0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation of making func_desc_t generic, change the ELFv2
version to a struct containing 'addr' element.

This allows using single helpers common to ELFv1 and ELFv2.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/module_64.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index a89da0ee25e2..b687ef88c4c4 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -33,19 +33,13 @@
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
+	return (func_desc_t){addr};
 }
 
 /* PowerPC64 specific values for the Elf64_Sym st_other field.  */
@@ -70,14 +64,6 @@ static func_desc_t func_desc(unsigned long addr)
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
@@ -93,6 +79,16 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
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
2.31.1

