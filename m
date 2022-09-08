Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97B5B182A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 11:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIHJMo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 05:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIHJMm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 05:12:42 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5DFF51D;
        Thu,  8 Sep 2022 02:12:40 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MNYLH0xqqz9shd;
        Thu,  8 Sep 2022 11:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bNmDkRzPd5BG; Thu,  8 Sep 2022 11:12:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MNYLH0FX3z9sdv;
        Thu,  8 Sep 2022 11:12:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE50F8B78B;
        Thu,  8 Sep 2022 11:12:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8zvbr9TFHVXO; Thu,  8 Sep 2022 11:12:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.247])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C787B8B763;
        Thu,  8 Sep 2022 11:12:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2889CSZY3385832
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 11:12:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2889CSWr3385831;
        Thu, 8 Sep 2022 11:12:28 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: Remove empty #ifdef SA_RESTORER
Date:   Thu,  8 Sep 2022 11:12:24 +0200
Message-Id: <3bdb5323c465daa81682ebd7f8594962320680e6.1662625281.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662628343; l=784; s=20211009; h=from:subject:message-id; bh=ykXUeGo2/hSVOS0mFaOfBkKZAcFLp/8VgLy16PSY8Ko=; b=x5Nf6tVlNphVIDKk9GeBdoUcHVSYx7SnDh707OQpmlebkowpvrNR+F7v+lqQPTcF4ilh1WbooENO UbBNUCTcAE+uWuiPo6B5PFA0d20YGYzuQksMojvSCSGzkE7bVt1E
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

There was a #ifdef SA_RESTORER to guard the sa_restorer field
in struct sigaction.

Commit 8a1ab3155c2a ("UAPI: (Scripted) Disintegrate
include/asm-generic") moved that struct into
uapi/asm-generic/signal.h but the #ifdef SA_RESTORER remained.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/signal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/signal.h b/include/asm-generic/signal.h
index c53984fa9761..663dd6d0795d 100644
--- a/include/asm-generic/signal.h
+++ b/include/asm-generic/signal.h
@@ -5,8 +5,6 @@
 #include <uapi/asm-generic/signal.h>
 
 #ifndef __ASSEMBLY__
-#ifdef SA_RESTORER
-#endif
 
 #include <asm/sigcontext.h>
 #undef __HAVE_ARCH_SIG_BITOPS
-- 
2.37.1

