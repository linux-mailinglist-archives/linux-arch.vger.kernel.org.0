Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0C41A978
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 09:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhI1HRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 03:17:43 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:57751 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239142AbhI1HRn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 03:17:43 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HJW4x0dhvz9sXy;
        Tue, 28 Sep 2021 09:16:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p_vOXXTAIEPN; Tue, 28 Sep 2021 09:16:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HJW4w0lgmz9sY0;
        Tue, 28 Sep 2021 09:16:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 04CE88B776;
        Tue, 28 Sep 2021 09:16:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YJjZ-nJrHmD4; Tue, 28 Sep 2021 09:15:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.48])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9B538B774;
        Tue, 28 Sep 2021 09:15:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18S7Fnpg1452317
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 09:15:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18S7FnhK1452316;
        Tue, 28 Sep 2021 09:15:49 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 3/4] powerpc: Use generic version of arch_is_kernel_initmem_freed()
Date:   Tue, 28 Sep 2021 09:15:36 +0200
Message-Id: <026c4fcbe018d35917e044de823efd57252c12e4.1632813331.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
References: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Generic version of arch_is_kernel_initmem_freed() now does the same
as powerpc version.

Remove the powerpc version.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: No change
---
 arch/powerpc/include/asm/sections.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 6e4af4492a14..79cb7a25a5fb 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -6,21 +6,8 @@
 #include <linux/elf.h>
 #include <linux/uaccess.h>
 
-#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
-
 #include <asm-generic/sections.h>
 
-extern bool init_mem_is_free;
-
-static inline int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	if (!init_mem_is_free)
-		return 0;
-
-	return addr >= (unsigned long)__init_begin &&
-		addr < (unsigned long)__init_end;
-}
-
 extern char __head_end[];
 
 #ifdef __powerpc64__
-- 
2.31.1

