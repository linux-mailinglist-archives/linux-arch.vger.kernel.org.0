Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9673D42D27A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJNG1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:27:06 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNG1F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:27:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVK9f1pndz9sSK;
        Thu, 14 Oct 2021 08:24:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PdzNilfnSkhR; Thu, 14 Oct 2021 08:24:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9Y5q60z9sSj;
        Thu, 14 Oct 2021 08:24:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B20DD8B788;
        Thu, 14 Oct 2021 08:24:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oX3viRR6oIHS; Thu, 14 Oct 2021 08:24:01 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6252D8B763;
        Thu, 14 Oct 2021 08:24:01 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oRii2266047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:50:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oRTA2266046;
        Thu, 14 Oct 2021 07:50:27 +0200
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
Subject: [PATCH v2 13/13] lkdtm: Add a test for function descriptors protection
Date:   Thu, 14 Oct 2021 07:50:02 +0200
Message-Id: <08a3dfbc55e1c7a0a1917b22f0ca6cabd9895ab2.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190597; l=2775; s=20211009; h=from:subject:message-id; bh=A+CBrzcmLRyGu0jFcqtTB3JqGSbbWuERKxSH4G7MIj0=; b=UxVBzQzOZLLymUPGBF6LMYkr527qFH46iUPDgZ9Zvvm9H01OxHdkpxCOKAJvxzvYp258cbceiCHw 6Z5O3KoJD+f5DRPRjkJ+TQSmqXJhh4JlfRRv2cZCndbJCejvHWNP
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add WRITE_OPD to check that you can't modify function
descriptors.

Gives the following result when function descriptors are
not protected:

	lkdtm: Performing direct entry WRITE_OPD
	lkdtm: attempting bad 16 bytes write at c00000000269b358
	lkdtm: FAIL: survived bad write
	lkdtm: do_nothing was hijacked!

Looks like a standard compiler barrier(); is not enough to force
GCC to use the modified function descriptor. Add to add a fake empty
inline assembly to force GCC to reload the function descriptor.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/lkdtm.h |  1 +
 drivers/misc/lkdtm/perms.c | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index fe6fd34b8caf..de092aa03b5d 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -148,6 +148,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(WRITE_RO),
 	CRASHTYPE(WRITE_RO_AFTER_INIT),
 	CRASHTYPE(WRITE_KERN),
+	CRASHTYPE(WRITE_OPD),
 	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
 	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
 	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_OVERFLOW),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c212a253edde..188bd0fd6575 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -105,6 +105,7 @@ void __init lkdtm_perms_init(void);
 void lkdtm_WRITE_RO(void);
 void lkdtm_WRITE_RO_AFTER_INIT(void);
 void lkdtm_WRITE_KERN(void);
+void lkdtm_WRITE_OPD(void);
 void lkdtm_EXEC_DATA(void);
 void lkdtm_EXEC_STACK(void);
 void lkdtm_EXEC_KMALLOC(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 96b3ebfcb8ed..3870bc82d40d 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -44,6 +44,11 @@ static noinline void do_overwritten(void)
 	return;
 }
 
+static noinline void do_almost_nothing(void)
+{
+	pr_info("do_nothing was hijacked!\n");
+}
+
 static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
 {
 	memcpy(fdesc, do_nothing, sizeof(*fdesc));
@@ -143,6 +148,23 @@ void lkdtm_WRITE_KERN(void)
 	do_overwritten();
 }
 
+void lkdtm_WRITE_OPD(void)
+{
+	size_t size = sizeof(func_desc_t);
+	void (*func)(void) = do_nothing;
+
+	if (!have_function_descriptors()) {
+		pr_info("Platform doesn't have function descriptors.\n");
+		return;
+	}
+	pr_info("attempting bad %zu bytes write at %px\n", size, do_nothing);
+	memcpy(do_nothing, do_almost_nothing, size);
+	pr_err("FAIL: survived bad write\n");
+
+	asm("" : "=m"(func));
+	func();
+}
+
 void lkdtm_EXEC_DATA(void)
 {
 	execute_location(data_area, CODE_WRITE);
-- 
2.31.1

