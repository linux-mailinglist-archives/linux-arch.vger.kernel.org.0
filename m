Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFB51BA4A
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbiEEIaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348045AbiEEI34 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 04:29:56 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:26:16 PDT
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322F2D1F5
        for <linux-arch@vger.kernel.org>; Thu,  5 May 2022 01:26:16 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Kv65g2Lwvzvjfm; Thu,  5 May 2022 10:18:15 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [PATCH] riscv: Wire up memfd_secret in UAPI header
Date:   Thu,  5 May 2022 10:18:15 +0200
Message-Id: <20220505081815.22808-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the __ARCH_WANT_MEMFD_SECRET define added in commit 7bb7f2ac24a0
("arch, mm: wire up memfd_secret system call where relevant") to
<uapi/asm/unistd.h> so __NR_memfd_secret is defined when including
<unistd.h> in userspace.

This allows the memds_secret selftest to pass on riscv.

Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/riscv/include/asm/unistd.h      | 1 -
 arch/riscv/include/uapi/asm/unistd.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 6c316093a1e5..977ee6181dab 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -9,7 +9,6 @@
  */
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_MEMFD_SECRET
 
 #include <uapi/asm/unistd.h>
 
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 8062996c2dfd..d95fbf5846b0 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -21,6 +21,7 @@
 #endif /* __LP64__ */
 
 #define __ARCH_WANT_SYS_CLONE3
+#define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
 
-- 
2.36.0

