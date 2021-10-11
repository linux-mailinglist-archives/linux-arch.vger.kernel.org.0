Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041C42932C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhJKP2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 11:28:53 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52677 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238362AbhJKP2r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 11:28:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HSjM52vF5z9sTs;
        Mon, 11 Oct 2021 17:26:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Rw-otcj9tGfm; Mon, 11 Oct 2021 17:26:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM3024Hz9sTt;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1EB48B783;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BfLFtPywlEMF; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34BAC8B770;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQVZX1585011
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:26:31 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQVCV1585010;
        Mon, 11 Oct 2021 17:26:31 +0200
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
Subject: [PATCH v1 02/10] powerpc: Rename 'funcaddr' to 'addr' in 'struct ppc64_opd_entry'
Date:   Mon, 11 Oct 2021 17:25:29 +0200
Message-Id: <892715d6f05fdf6ca80cf88a51a9e55298b68c4a.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633964380.git.christophe.leroy@csgroup.eu>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965928; l=2423; s=20211009; h=from:subject:message-id; bh=UcrC1vlpvPaezZaHIBKM3b9ewrkDpdFEtlYNrqTDTLg=; b=sR8iFNRcbZxDd66eGD/dN9O9K/+ik1kft5E23FMg8ognNP7/BV69ot654bNfqGeHCkWn0qCr9GYP zdHu+BXfDLuKNAaBHpTjs1VvfxHv9gz6B37Ipyx0bDm/9oyGzhQJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are three architectures with function descriptors, try to
have common names for the address they contain in order to
refactor some functions into generic functions later.

powerpc has 'funcaddr'
ia64 has 'ip'
parisc has 'addr'

Vote for 'addr' and update 'struct ppc64_opd_entry' accordingly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/elf.h      | 2 +-
 arch/powerpc/include/asm/sections.h | 2 +-
 arch/powerpc/kernel/module_64.c     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 64b523848cd7..90c3259a81ab 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -179,7 +179,7 @@ void relocate(unsigned long final_address);
 /* There's actually a third entry here, but it's unused */
 struct ppc64_opd_entry
 {
-	unsigned long funcaddr;
+	unsigned long addr;
 	unsigned long r2;
 };
 
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 6e4af4492a14..32e7035863ac 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -77,7 +77,7 @@ static inline void *dereference_function_descriptor(void *ptr)
 	struct ppc64_opd_entry *desc = ptr;
 	void *p;
 
-	if (!get_kernel_nofault(p, (void *)&desc->funcaddr))
+	if (!get_kernel_nofault(p, (void *)&desc->addr))
 		ptr = p;
 	return ptr;
 }
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6baa676e7cb6..82908c9be627 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -72,11 +72,11 @@ static func_desc_t func_desc(unsigned long addr)
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

