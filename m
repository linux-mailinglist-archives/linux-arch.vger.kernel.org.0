Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A454B6C56
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiBOMm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 07:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiBOMmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 07:42:08 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599EF14098;
        Tue, 15 Feb 2022 04:41:43 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jyggs1Hf4z9sSM;
        Tue, 15 Feb 2022 13:41:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k82_Xi-BHsDE; Tue, 15 Feb 2022 13:41:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jyggn2w58z9sRw;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 525278B763;
        Tue, 15 Feb 2022 13:41:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4q9AZT4zcRCb; Tue, 15 Feb 2022 13:41:25 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C9AE8B77C;
        Tue, 15 Feb 2022 13:41:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FCfHYB080637
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 13:41:17 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FCfHdL080636;
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
Subject: [PATCH v4 08/13] asm-generic: Define 'func_desc_t' to commonly describe function descriptors
Date:   Tue, 15 Feb 2022 13:41:03 +0100
Message-Id: <f1f91b142b3c1082bdc1586ce71c9bac1e75213c.1644928018.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644928860; l=3528; s=20211009; h=from:subject:message-id; bh=f/Kz0vs7DzOIFvt0GMalWSxwhMlMtC2TwHZGNFAW5xk=; b=pjXGNgU4tJTpHtaKVo8K7qLnoS/WBn+e6Gl++nh7f3v0UMDFbRud25AzSQcY/w+ChnJQMG5svT/C IDhKL0suBodK3xIXENbiPQzeZ/hrkMGbkXNHt+ZhHeD6a9PcAk9l
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

We have three architectures using function descriptors, each with its
own type and name.

Add a common typedef that can be used in generic code.

Also add a stub typedef for architecture without function descriptors,
to avoid a forest of #ifdefs.

It replaces the similar 'func_desc_t' previously defined in
arch/powerpc/kernel/module_64.c

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/ia64/include/asm/sections.h    | 3 +++
 arch/parisc/include/asm/sections.h  | 5 +++++
 arch/powerpc/include/asm/sections.h | 4 ++++
 arch/powerpc/kernel/module_64.c     | 8 --------
 include/asm-generic/sections.h      | 5 +++++
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index 2460d365a057..3abe0562b01a 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -9,6 +9,9 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+typedef struct fdesc func_desc_t;
+
 #include <asm-generic/sections.h>
 
 extern char __phys_per_cpu_start[];
diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
index c8092e4d94de..ace1d4047a0b 100644
--- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -2,6 +2,11 @@
 #ifndef _PARISC_SECTIONS_H
 #define _PARISC_SECTIONS_H
 
+#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
+#include <asm/elf.h>
+typedef Elf64_Fdesc func_desc_t;
+#endif
+
 /* nothing to see, move along */
 #include <asm-generic/sections.h>
 
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 7728a7a146c3..fddfb3937868 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -6,6 +6,10 @@
 #include <linux/elf.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
+typedef struct func_desc func_desc_t;
+#endif
+
 #include <asm-generic/sections.h>
 
 extern char __head_end[];
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index ff93ef4cb5a2..9abc0e783e36 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -32,11 +32,6 @@
 
 #ifdef PPC64_ELF_ABI_v2
 
-/* An address is simply the address of the function. */
-typedef struct {
-	unsigned long addr;
-} func_desc_t;
-
 static func_desc_t func_desc(unsigned long addr)
 {
 	func_desc_t desc = {
@@ -61,9 +56,6 @@ static unsigned int local_entry_offset(const Elf64_Sym *sym)
 }
 #else
 
-/* An address is address of the OPD entry, which contains address of fn. */
-typedef struct func_desc func_desc_t;
-
 static func_desc_t func_desc(unsigned long addr)
 {
 	return *(struct func_desc *)addr;
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 3ef83e1aebee..bbf97502470c 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -63,6 +63,11 @@ extern __visible const void __nosave_begin, __nosave_end;
 #else
 #define dereference_function_descriptor(p) ((void *)(p))
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
+
+/* An address is simply the address of the function. */
+typedef struct {
+	unsigned long addr;
+} func_desc_t;
 #endif
 
 static inline bool have_function_descriptors(void)
-- 
2.34.1

