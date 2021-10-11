Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346AB42932F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhJKP27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 11:28:59 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52677 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238616AbhJKP2z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 11:28:55 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HSjM60kFTz9sTt;
        Mon, 11 Oct 2021 17:26:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lpc87tCjePsn; Mon, 11 Oct 2021 17:26:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM306xpz9sTv;
        Mon, 11 Oct 2021 17:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0F4B8B781;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FCFafly78UJw; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C3928B775;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQVK61585015
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:26:31 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQVMT1585014;
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
Subject: [PATCH v1 03/10] ia64: Rename 'ip' to 'addr' in 'struct fdesc'
Date:   Mon, 11 Oct 2021 17:25:30 +0200
Message-Id: <a2443adcd006cb8004fe0602e2f8c43c30a7c504.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633964380.git.christophe.leroy@csgroup.eu>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965928; l=2059; s=20211009; h=from:subject:message-id; bh=PGO0Yoa+ISrjfPBIV3GEiwZmxw/DXeNvwbCh6qfsug4=; b=cgrpQ62h24nXp2tUTQrQ6YSTpEYxdZNJoo7BGekONGRAPmLuzaQN1I7icT2eRh0h812tcM0JUaQ7 I5onQa/1C0/A4ktzYQy/kEA/V4tZngnaX8zM71D8s46KjWgtbfWf
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

Vote for 'addr' and update 'struct fdesc' accordingly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/ia64/include/asm/elf.h      | 2 +-
 arch/ia64/include/asm/sections.h | 2 +-
 arch/ia64/kernel/module.c        | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/include/asm/elf.h b/arch/ia64/include/asm/elf.h
index 6629301a2620..2ef5f9966ad1 100644
--- a/arch/ia64/include/asm/elf.h
+++ b/arch/ia64/include/asm/elf.h
@@ -226,7 +226,7 @@ struct got_entry {
  * Layout of the Function Descriptor
  */
 struct fdesc {
-	uint64_t ip;
+	uint64_t addr;
 	uint64_t gp;
 };
 
diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 3a033d2008b3..35f24e52149a 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -35,7 +35,7 @@ static inline void *dereference_function_descriptor(void *ptr)
 	struct fdesc *desc = ptr;
 	void *p;
 
-	if (!get_kernel_nofault(p, (void *)&desc->ip))
+	if (!get_kernel_nofault(p, (void *)&desc->addr))
 		ptr = p;
 	return ptr;
 }
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index 2cba53c1da82..4f6400cbf79e 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -602,15 +602,15 @@ get_fdesc (struct module *mod, uint64_t value, int *okp)
 		return value;
 
 	/* Look for existing function descriptor. */
-	while (fdesc->ip) {
-		if (fdesc->ip == value)
+	while (fdesc->addr) {
+		if (fdesc->addr == value)
 			return (uint64_t)fdesc;
 		if ((uint64_t) ++fdesc >= mod->arch.opd->sh_addr + mod->arch.opd->sh_size)
 			BUG();
 	}
 
 	/* Create new one */
-	fdesc->ip = value;
+	fdesc->addr = value;
 	fdesc->gp = mod->arch.gp;
 	return (uint64_t) fdesc;
 }
-- 
2.31.1

