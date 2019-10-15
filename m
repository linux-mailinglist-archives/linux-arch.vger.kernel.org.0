Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A795D83B0
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 00:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfJOWcK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 15 Oct 2019 18:32:10 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46416 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731944AbfJOWcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 18:32:10 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1iKVMB-0007JX-62; Wed, 16 Oct 2019 00:31:55 +0200
Date:   Wed, 16 Oct 2019 00:31:55 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: [PATCH 1/6 v2] sh: Move cmpxchg-xchg.h to asm-generic
Message-ID: <20191015223154.7wcsc7x5edrpasfc@flow>
References: <20191013221310.30748-1-sebastian@breakpoint.cc>
 <20191013221310.30748-2-sebastian@breakpoint.cc>
 <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The header file is very generic and could be reused by other
architectures as long as they provide __cmpxchg_u32().

Move sh's cmpxchg-xchg.h to asm-generic.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
v1…v2: s@__ASM_SH_CMPXCHG_XCHG_H@__ASM_GENERIC_CMPXCHG_XCHG_H@

 arch/sh/include/asm/Kbuild                                  | 1 +
 {arch/sh/include/asm => include/asm-generic}/cmpxchg-xchg.h | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)
 rename {arch/sh/include/asm => include/asm-generic}/cmpxchg-xchg.h (91%)

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 51a54df22c110..08c1d96286d9d 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
+generic-y += cmpxchg-xchg.h
 generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/include/asm-generic/cmpxchg-xchg.h
similarity index 91%
rename from arch/sh/include/asm/cmpxchg-xchg.h
rename to include/asm-generic/cmpxchg-xchg.h
index c373f21efe4d9..c9acd6ff8741d 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/include/asm-generic/cmpxchg-xchg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_CMPXCHG_XCHG_H
-#define __ASM_SH_CMPXCHG_XCHG_H
+#ifndef __ASM_GENERIC_CMPXCHG_XCHG_H
+#define __ASM_GENERIC_CMPXCHG_XCHG_H
 
 /*
  * Copyright (C) 2016 Red Hat, Inc.
@@ -47,4 +47,4 @@ static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 	return __xchg_cmpxchg(m, val, sizeof *m);
 }
 
-#endif /* __ASM_SH_CMPXCHG_XCHG_H */
+#endif /* __ASM_GENERIC_CMPXCHG_XCHG_H */
-- 
2.23.0

