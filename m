Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D494F42D255
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhJNG0I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:26:08 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhJNG0G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:26:06 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVK9V2XGPz9sST;
        Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ywvM8ua99sUG; Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9V1df3z9sSK;
        Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2155E8B788;
        Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LEgVpphJSeUz; Thu, 14 Oct 2021 08:23:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D44DA8B763;
        Thu, 14 Oct 2021 08:23:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oQBY2266038
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:50:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oQ4u2266037;
        Thu, 14 Oct 2021 07:50:26 +0200
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
Subject: [PATCH v2 11/13] lkdtm: Fix lkdtm_EXEC_RODATA()
Date:   Thu, 14 Oct 2021 07:50:00 +0200
Message-Id: <44946ed0340013a52f8acdee7d6d0781f145cd6b.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190596; l=1315; s=20211009; h=from:subject:message-id; bh=rb6s8T8RzgppuRF6clvJIPiZDvSiUgRo2Ftj9cKfCbI=; b=IomnMzuLREpm22pqHiUGM7GaxjWQw6U4JqCv8E/AD7rCX5OHbqBvUX0igIGbFZcJnsdwgmpcgCOZ V9VbVBWuCT2ksy6IfSzsaHiA2GEOl5ZkQT1MMB8AK72+hu6d6ibU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Behind its location, lkdtm_EXEC_RODATA() executes
lkdtm_rodata_do_nothing() which is a real function,
not a copy of do_nothing().

So executes it directly instead of using execute_location().

This is necessary because following patch will fix execute_location()
to use a copy of the function descriptor of do_nothing() and
function descriptor of lkdtm_rodata_do_nothing() might be different.

And fix displayed addresses by dereferencing the function descriptors.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/perms.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 035fcca441f0..5266dc28df6e 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -153,7 +153,14 @@ void lkdtm_EXEC_VMALLOC(void)
 
 void lkdtm_EXEC_RODATA(void)
 {
-	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
+	pr_info("attempting ok execution at %px\n",
+		dereference_function_descriptor(do_nothing));
+	do_nothing();
+
+	pr_info("attempting bad execution at %px\n",
+		dereference_function_descriptor(lkdtm_rodata_do_nothing));
+	lkdtm_rodata_do_nothing();
+	pr_err("FAIL: func returned\n");
 }
 
 void lkdtm_EXEC_USERSPACE(void)
-- 
2.31.1

