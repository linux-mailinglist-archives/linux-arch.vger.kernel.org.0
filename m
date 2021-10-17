Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEF430B29
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbhJQRWV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 13:22:21 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34937 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344366AbhJQRWV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Oct 2021 13:22:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXRbF62kYz9sSf;
        Sun, 17 Oct 2021 19:20:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UU0pFAL3_At5; Sun, 17 Oct 2021 19:20:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXRbF4sf6z9sSH;
        Sun, 17 Oct 2021 19:20:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A7FE8B76C;
        Sun, 17 Oct 2021 19:20:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id d2p_rn7meVln; Sun, 17 Oct 2021 19:20:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3416F8B763;
        Sun, 17 Oct 2021 19:20:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19HHJuwJ2995765
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 19:19:56 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19HHJqeL2995764;
        Sun, 17 Oct 2021 19:19:52 +0200
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
Subject: [RFC PATCH] lkdtm: Replace lkdtm_rodata_do_nothing() by do_nothing()
Date:   Sun, 17 Oct 2021 19:19:47 +0200
Message-Id: <fe36bf23fb14e7eff92a95a1092ed38edb01d5f5.1634491011.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634491186; l=4650; s=20211009; h=from:subject:message-id; bh=Gwq3WsZiMgEzCWeCZvvJz2QFh6/yASMBkt0EwoqhfqU=; b=tNEufT0EvPpoA817u75WWILDHvNRtl8NSHiO7I4zTt1LQhPaOg9RzOWV74NlxFf0C2nuxBLt9G3g 3Yo7SMx+CM6PPLrmoIohglXpAMq3LzxPHBKWOMPxySmIxlVza90N
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All EXEC tests are based on running a copy of do_nothing()
except lkdtm_EXEC_RODATA which uses a different function
called lkdtm_rodata_do_nothing().

On architectures using function descriptors, EXEC tests are
performed using execute_location() which is a function
that most of the time copies do_nothing() at the tested
location then duplicates do_nothing() function descriptor
and updates it with the address of the copy of do_nothing().

But for EXEC_RODATA test, execute_location() uses
lkdtm_rodata_do_nothing() which is already in rodata section
at build time instead of using a copy of do_nothing(). However
it still uses the function descriptor of do_nothing(). There
is a risk that running lkdtm_rodata_do_nothing() with the
function descriptor of do_thing() is wrong.

To remove the above risk, change the approach and do the same
as for other EXEC tests: use a copy of do_nothing(). The copy
cannot be done during the test because RODATA area is write
protected. Do the copy during init, before RODATA becomes
write protected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
This applies on top of series v3 "Fix LKDTM for PPC64/IA64/PARISC"

 drivers/misc/lkdtm/Makefile | 11 -----------
 drivers/misc/lkdtm/lkdtm.h  |  3 ---
 drivers/misc/lkdtm/perms.c  |  9 +++++++--
 drivers/misc/lkdtm/rodata.c | 11 -----------
 4 files changed, 7 insertions(+), 27 deletions(-)
 delete mode 100644 drivers/misc/lkdtm/rodata.c

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index e2984ce51fe4..3d45a2b3007d 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -6,21 +6,10 @@ lkdtm-$(CONFIG_LKDTM)		+= bugs.o
 lkdtm-$(CONFIG_LKDTM)		+= heap.o
 lkdtm-$(CONFIG_LKDTM)		+= perms.o
 lkdtm-$(CONFIG_LKDTM)		+= refcount.o
-lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 lkdtm-$(CONFIG_LKDTM)		+= fortify.o
 lkdtm-$(CONFIG_PPC_BOOK3S_64)	+= powerpc.o
 
-KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
-KCOV_INSTRUMENT_rodata.o	:= n
-CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
-
-OBJCOPYFLAGS :=
-OBJCOPYFLAGS_rodata_objcopy.o	:= \
-			--rename-section .noinstr.text=.rodata,alloc,readonly,load,contents
-targets += rodata.o rodata_objcopy.o
-$(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
-	$(call if_changed,objcopy)
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 188bd0fd6575..905555d4c2cf 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -137,9 +137,6 @@ void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void);
 void lkdtm_REFCOUNT_TIMING(void);
 void lkdtm_ATOMIC_TIMING(void);
 
-/* rodata.c */
-void lkdtm_rodata_do_nothing(void);
-
 /* usercopy.c */
 void __init lkdtm_usercopy_init(void);
 void __exit lkdtm_usercopy_exit(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2c6aba3ff32b..9b951ca48363 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -27,6 +27,7 @@ static const unsigned long rodata = 0xAA55AA55;
 
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
+static u8 rodata_area[EXEC_SIZE] __ro_after_init;
 
 /*
  * This just returns to the caller. It is designed to be copied into
@@ -193,8 +194,7 @@ void lkdtm_EXEC_VMALLOC(void)
 
 void lkdtm_EXEC_RODATA(void)
 {
-	execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing),
-			 CODE_AS_IS);
+	execute_location(rodata_area, CODE_AS_IS);
 }
 
 void lkdtm_EXEC_USERSPACE(void)
@@ -269,4 +269,9 @@ void __init lkdtm_perms_init(void)
 {
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
+
+	memcpy(rodata_area, dereference_function_descriptor(do_nothing),
+	       EXEC_SIZE);
+	flush_icache_range((unsigned long)rodata_area,
+			   (unsigned long)rodata_area + EXEC_SIZE);
 }
diff --git a/drivers/misc/lkdtm/rodata.c b/drivers/misc/lkdtm/rodata.c
deleted file mode 100644
index baacb876d1d9..000000000000
--- a/drivers/misc/lkdtm/rodata.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This includes functions that are meant to live entirely in .rodata
- * (via objcopy tricks), to validate the non-executability of .rodata.
- */
-#include "lkdtm.h"
-
-void noinstr lkdtm_rodata_do_nothing(void)
-{
-	/* Does nothing. We just want an architecture agnostic "return". */
-}
-- 
2.31.1

