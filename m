Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1291F23EC15
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHGLNU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 07:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgHGLLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2020 07:11:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE36C061574;
        Fri,  7 Aug 2020 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H9pFCH3Moi70e7rPhQDsmelFkTpyLNVCigPJMZhbh4M=; b=unE27pINXTEXPyCzsiuOqFGJ3T
        btSDm/aYdoK9MTat9yPFqQPYM78+m2/AsFj+yr3YRQ7nLXlarKa+n2oS+9kspkv07ANWDg8VFAGsD
        BEgWU3pMKrNpE01GHlBqlEtOBjRL5kBuuinu1VHsNK70/EAhQxnjBLfuWmWwv5MvjRHhcPi/STG67
        4mxM0E/0Np9If37fkQWdHzrSl4vroNEZQn4+vfsEE1pmc2t5K04Mf/dKijKgjSScesaI7766NbMKL
        K73JIP2ASefw7evgpqCbNr/3B+U2WQNPCahBXUE2lJr211M1yPpKkTmTZPTjLgLopiPwCfz2oJzAb
        kwFckUwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k40HY-0005Qq-4Q; Fri, 07 Aug 2020 11:11:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9F8D304BAE;
        Fri,  7 Aug 2020 13:11:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C01C4236DA3E1; Fri,  7 Aug 2020 13:11:26 +0200 (CEST)
Date:   Fri, 7 Aug 2020 13:11:26 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200807111126.GI2674@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


What's wrong with something like this?

AFAICT there's no reason to actually try and add IRQ tracing here, it's
just a hand full of instructions at the most.

---

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b0b46e..6be22c1838e2 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -196,33 +196,6 @@ static inline bool arch_irqs_disabled(void)
 		arch_local_irq_restore(flags);				\
 	} while(0)
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-#define powerpc_local_irq_pmu_save(flags)			\
-	 do {							\
-		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
-	} while(0)
-#define powerpc_local_irq_pmu_restore(flags)			\
-	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
-			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
-	} while(0)
-#else
-#define powerpc_local_irq_pmu_save(flags)			\
-	do {							\
-		raw_local_irq_pmu_save(flags);			\
-	} while(0)
-#define powerpc_local_irq_pmu_restore(flags)			\
-	do {							\
-		raw_local_irq_pmu_restore(flags);		\
-	} while (0)
-#endif  /* CONFIG_TRACE_IRQFLAGS */
-
 #endif /* CONFIG_PPC_BOOK3S */
 
 #ifdef CONFIG_PPC_BOOK3E
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index bc4bd19b7fc2..b357a35672b1 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -32,9 +32,9 @@ static __inline__ void local_##op(long i, local_t *l)			\
 {									\
 	unsigned long flags;						\
 									\
-	powerpc_local_irq_pmu_save(flags);				\
+	raw_powerpc_local_irq_pmu_save(flags);				\
 	l->v c_op i;						\
-	powerpc_local_irq_pmu_restore(flags);				\
+	raw_powerpc_local_irq_pmu_restore(flags);				\
 }
 
 #define LOCAL_OP_RETURN(op, c_op)					\
@@ -43,9 +43,9 @@ static __inline__ long local_##op##_return(long a, local_t *l)		\
 	long t;								\
 	unsigned long flags;						\
 									\
-	powerpc_local_irq_pmu_save(flags);				\
+	raw_powerpc_local_irq_pmu_save(flags);				\
 	t = (l->v c_op a);						\
-	powerpc_local_irq_pmu_restore(flags);				\
+	raw_powerpc_local_irq_pmu_restore(flags);				\
 									\
 	return t;							\
 }
@@ -81,11 +81,11 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
 	long t;
 	unsigned long flags;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_powerpc_local_irq_pmu_save(flags);
 	t = l->v;
 	if (t == o)
 		l->v = n;
-	powerpc_local_irq_pmu_restore(flags);
+	raw_powerpc_local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -95,10 +95,10 @@ static __inline__ long local_xchg(local_t *l, long n)
 	long t;
 	unsigned long flags;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_powerpc_local_irq_pmu_save(flags);
 	t = l->v;
 	l->v = n;
-	powerpc_local_irq_pmu_restore(flags);
+	raw_powerpc_local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -117,12 +117,12 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
 	unsigned long flags;
 	int ret = 0;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_powerpc_local_irq_pmu_save(flags);
 	if (l->v != u) {
 		l->v += a;
 		ret = 1;
 	}
-	powerpc_local_irq_pmu_restore(flags);
+	raw_powerpc_local_irq_pmu_restore(flags);
 
 	return ret;
 }
