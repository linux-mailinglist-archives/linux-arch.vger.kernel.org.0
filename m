Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC74308CC
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbhJQMl0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 08:41:26 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49285 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245707AbhJQMlZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Oct 2021 08:41:25 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXKM11gWJz9sSt;
        Sun, 17 Oct 2021 14:39:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SMYjPKjGtC6s; Sun, 17 Oct 2021 14:39:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXKLz6ZWqz9sSf;
        Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C9E668B76C;
        Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4TN_i876SSxm; Sun, 17 Oct 2021 14:39:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C62568B773;
        Sun, 17 Oct 2021 14:39:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19HCcugL2946765
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 14:38:56 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19HCcunV2946764;
        Sun, 17 Oct 2021 14:38:56 +0200
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
Subject: [PATCH v3 09/12] lkdtm: Force do_nothing() out of line
Date:   Sun, 17 Oct 2021 14:38:22 +0200
Message-Id: <a7072b9e628b01cf30dd16d508f138c7c229b992.1634457599.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634457599.git.christophe.leroy@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634474303; l=1269; s=20211009; h=from:subject:message-id; bh=nSN/ioO339qfxQaSJCJwz7QKogrcJ3f1Q+xuI0OSdUc=; b=sCrxbtxbBdfHhd/haIYDYBas/MSiSTksFFeVvm9lJzxKhfTqzoZ/VjxacZGgBbQrQZvazP2UCOfF S4UNCePRCervGfGfrQA52l5dOI3WJAh2pGnG4EIl6xfjZ3HDXx15
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LKDTM tests display that the run do_nothing() at a given
address, but in reality do_nothing() is inlined into the
caller.

Force it out of line so that it really runs text at the
displayed address.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/perms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..60b3b2fe929d 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -21,7 +21,7 @@
 /* This is non-const, so it will end up in the .data section. */
 static u8 data_area[EXEC_SIZE];
 
-/* This is cost, so it will end up in the .rodata section. */
+/* This is const, so it will end up in the .rodata section. */
 static const unsigned long rodata = 0xAA55AA55;
 
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
@@ -31,7 +31,7 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
  */
-static void do_nothing(void)
+static noinline void do_nothing(void)
 {
 	return;
 }
-- 
2.31.1

