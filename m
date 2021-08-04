Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47D3E088F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbhHDTQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:28 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58764 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240498AbhHDTQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:21 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7D1A540DB7;
        Wed,  4 Aug 2021 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104567; bh=jS7TMpiuBpexomjIgRV6cQUgUQCWpq/qYioDI73B0rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4Iyy/dTZeIspc8X66Z0Q3020n/LdiZPpj96MU+92Bt1cpPCjC/y5JmvUcawUE+cy
         DqJyIevzX+wz0suDDiVBl7TMHLeNVojvbVBfkRQ5zpRYKIyIjAoByOgnw7XrCk+u+t
         sp1DLEJ2DuAbj7mnx0+OtrKQ6g22CtL0LojmA61ceO2D9Usv5K8/HNneWdwlZbqs6m
         DuG02nCZD52aRSroVtxc8h/e8yIpzhoOIQVJSd3K20LeaeGLHaqchYdkMUhGCNSAlG
         yo8pWK6GtFO4NGEbftsPrEwRMKCCrHvRG5REWnbUYcIRKZdXdfjDjBnYKIULw9IfeH
         PUnobod+MNHfg==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 40158A0095;
        Wed,  4 Aug 2021 19:16:06 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 08/11] ARC: xchg: !LLSC: remove UP micro-optimization/hack
Date:   Wed,  4 Aug 2021 12:15:51 -0700
Message-Id: <20210804191554.1252776-9-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It gets in the way of cleaning things up and is a maintenance
pain-in-neck !

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/cmpxchg.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index d42917e803e1..bac9b564a140 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -113,15 +113,9 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
  *  - For !LLSC, cmpxchg() needs to use that lock (see above) and there is lot
  *    of  kernel code which calls xchg()/cmpxchg() on same data (see llist.h)
  *    Hence xchg() needs to follow same locking rules.
- *
- * Technically the lock is also needed for UP (boils down to irq save/restore)
- * but we can cheat a bit since cmpxchg() atomic_ops_lock() would cause irqs to
- * be disabled thus can't possibly be interrupted/preempted/clobbered by xchg()
- * Other way around, xchg is one instruction anyways, so can't be interrupted
- * as such
  */
 
-#if !defined(CONFIG_ARC_HAS_LLSC) && defined(CONFIG_SMP)
+#ifndef CONFIG_ARC_HAS_LLSC
 
 #define arch_xchg(ptr, with)		\
 ({					\
@@ -134,10 +128,6 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 	old_val;			\
 })
 
-#else
-
-#define arch_xchg(ptr, with)  _xchg(ptr, with)
-
 #endif
 
 /*
-- 
2.25.1

