Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8642933D
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhJKP3R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 11:29:17 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59181 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237945AbhJKP3L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 11:29:11 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HSjM83Hfkz9sTw;
        Mon, 11 Oct 2021 17:26:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uMPUKFcnNJjQ; Mon, 11 Oct 2021 17:26:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM30m43z9sTx;
        Mon, 11 Oct 2021 17:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB23D8B76E;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 01YkwSLBWh9m; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41DBC8B776;
        Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQWvA1585031
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 17:26:32 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQWQL1585030;
        Mon, 11 Oct 2021 17:26:32 +0200
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
Subject: [PATCH v1 07/10] lkdtm: Force do_nothing() out of line
Date:   Mon, 11 Oct 2021 17:25:34 +0200
Message-Id: <b353a85e50ac336c385b46459a5fc43f4a6171ac.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633964380.git.christophe.leroy@csgroup.eu>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965929; l=1224; s=20211009; h=from:subject:message-id; bh=YABQf4MQINYt/A+tymthNj9l3luYQ09oplriUkTdDMg=; b=DNM+Azt5sQUZwgxx7puNJZNULh5fbD6IuU01fcXUUBcSph5Yk9dErNVSQZxXS145XDXqvc23M//K 7rkcgwtnCuoZUerQEJnrf0F8Xx6pOCh2MN386e/gOVIuw/zLF+Fc
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

