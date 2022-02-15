Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3A34B6C62
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbiBOMm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:42:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbiBOMmv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:42:51 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E41B792;
        Tue, 15 Feb 2022 04:41:51 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jyggv1C10z9sST;
        Tue, 15 Feb 2022 13:41:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IdKtj2QNUyCc; Tue, 15 Feb 2022 13:41:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn4p5kz9sSh;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D2108B776;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Rp4IPH4rC6t9; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 81C388B77D;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfG60080629
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:16 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfGfh080628;
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
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 06/13] ia64: Rename 'ip' to 'addr' in 'struct fdesc'
Date:   Tue, 15 Feb 2022 13:41:01 +0100
Message-Id: <65b73ac614e4c002c5819d40b42f6f426d2ee52b.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=2104; s=20211009; h=from:subject:message-id; bh=4mv1SiBbp7pTTqFBCvFgWxXkLKYIOhDRwyfgv8fTdHE=; b=rqmpUmT0MgrcuSuGQdvFvaQMGAC23n6tWxLMK4K8qIoig0QzZ2OFo/9wKPcNEhN7MC+goHcNFVNs 3Z9uhiedB8tTGfOd1+xZn9/XwLv9q5AEW1/9kfJtKEiqwcT707Ox
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

There are three architectures with function descriptors, try to
have common names for the address they contain in order to
refactor some functions into generic functions later.

powerpc has 'entry'
ia64 has 'ip'
parisc has 'addr'

Vote for 'addr' and update 'struct fdesc' accordingly.

Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 360f36b0eb3f..8f62cf97f691 100644
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
2.34.1

