Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D384308D4
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbhJQMlg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 08:41:36 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49285 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245744AbhJQMlc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Oct 2021 08:41:32 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXKM31ywGz9sSh;
        Sun, 17 Oct 2021 14:39:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v8OuPocdFoYJ; Sun, 17 Oct 2021 14:39:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXKM00NMNz9sSj;
        Sun, 17 Oct 2021 14:39:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD2268B773;
        Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WuIjW5Q_6MW1; Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4D858B763;
        Sun, 17 Oct 2021 14:39:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19HCcseW2946737
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 14:38:54 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19HCcsgK2946736;
        Sun, 17 Oct 2021 14:38:54 +0200
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
        Daniel Axtens <dja@axtens.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 02/12] powerpc: Use 'struct func_desc' instead of 'struct ppc64_opd_entry'
Date:   Sun, 17 Oct 2021 14:38:15 +0200
Message-Id: <4a912da3c89569bf5bff897d2588538e74198f35.1634457599.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634457599.git.christophe.leroy@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634474303; l=2500; s=20211009; h=from:subject:message-id; bh=Iq40Rens/Xlw+IOo3EjhmDf6EixeHqq4/73sqQ/rn00=; b=bFTTEPFTyPUbLUNDWYUikgpTMofF9s8jmOcHYA5FpiENJIGyyPWx3D0Jb2x4aB4FkKNAmxnk23tm OhnGUhzgAaj2KUJ9d4nwSYNAY7ffBnu3famcwWf2auDGpqwCWKRC
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'struct ppc64_opd_entry' is somehow redundant with 'struct func_desc',
the later is more correct/complete as it includes the third
field which is unused.

So use 'struct func_desc' instead of 'struct ppc64_opd_entry'

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/sections.h |  4 ++--
 arch/powerpc/kernel/module_64.c     | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 6e4af4492a14..abd2e5213197 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -74,10 +74,10 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
 #undef dereference_function_descriptor
 static inline void *dereference_function_descriptor(void *ptr)
 {
-	struct ppc64_opd_entry *desc = ptr;
+	struct func_desc *desc = ptr;
 	void *p;
 
-	if (!get_kernel_nofault(p, (void *)&desc->funcaddr))
+	if (!get_kernel_nofault(p, (void *)&desc->addr))
 		ptr = p;
 	return ptr;
 }
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6baa676e7cb6..a89da0ee25e2 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -64,19 +64,19 @@ static unsigned int local_entry_offset(const Elf64_Sym *sym)
 #else
 
 /* An address is address of the OPD entry, which contains address of fn. */
-typedef struct ppc64_opd_entry func_desc_t;
+typedef struct func_desc func_desc_t;
 
 static func_desc_t func_desc(unsigned long addr)
 {
-	return *(struct ppc64_opd_entry *)addr;
+	return *(struct func_desc *)addr;
 }
 static unsigned long func_addr(unsigned long addr)
 {
-	return func_desc(addr).funcaddr;
+	return func_desc(addr).addr;
 }
 static unsigned long stub_func_addr(func_desc_t func)
 {
-	return func.funcaddr;
+	return func.addr;
 }
 static unsigned int local_entry_offset(const Elf64_Sym *sym)
 {
@@ -187,7 +187,7 @@ static int relacmp(const void *_x, const void *_y)
 static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 				    const Elf64_Shdr *sechdrs)
 {
-	/* One extra reloc so it's always 0-funcaddr terminated */
+	/* One extra reloc so it's always 0-addr terminated */
 	unsigned long relocs = 1;
 	unsigned i;
 
-- 
2.31.1

