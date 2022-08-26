Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75F5A285A
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiHZNRR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiHZNRQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 09:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496DDBC82A
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661519832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVQSEywYfbFhro2HJSwS/ZHWAfsWN1QK4brX598U6YQ=;
        b=iD88izsln22pNkM53IFBOKY02DIw8H54gU04co1j+Ej2cuoONbmDJfYDldO3Y7js0yfXUD
        GDR9fnasoXV4VWddQfjhQWASpft2WSdM2R996kePSAxtP4UTX48f5oXDgE1cHpphBMQEON
        hD3Ji61UajtU1Q301DxTtlVWuX05JyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-TLwwHE7CMiG_ouAnSBpWdQ-1; Fri, 26 Aug 2022 09:17:09 -0400
X-MC-Unique: TLwwHE7CMiG_ouAnSBpWdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C70F385A589;
        Fri, 26 Aug 2022 13:17:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B394C816;
        Fri, 26 Aug 2022 13:17:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27QDH8Sb025173;
        Fri, 26 Aug 2022 09:17:08 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27QDH8ZI025169;
        Fri, 26 Aug 2022 09:17:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Aug 2022 09:17:08 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3] wait_on_bit: add an acquire memory barrier
In-Reply-To: <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Thu, 25 Aug 2022, Linus Torvalds wrote:

> On Thu, Aug 25, 2022 at 2:03 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Here I reworked your patch, so that test_bit_acquire is defined just like
> > test_bit. There's some code duplication (in
> > include/asm-generic/bitops/generic-non-atomic.h and in
> > arch/x86/include/asm/bitops.h), but that duplication exists in the
> > test_bit function too.
> 
> This looks fine to me, and I like how you fixed up buffer_uptodate()
> while at it.
> 
> > I tested it on x86-64 and arm64. On x86-64 it generates the "bt"
> > instruction for variable-bit test and "shr; and $1" for constant bit test.
> 
> That shr/and is almost certainly pessimal for small constant values at
> least, and it's better done as "movq %rax" followed by "test %rax".
> But I guess it depends on the bit value (and thus the constant size).
> 
> Doing a "testb $imm8" would likely be optimal, but you'll never get
> that with smp_load_acquire() on x86 unless you use inline asm, because
> of how we're doing it with a volatile pointer.
> 
> Anyway, you could try something like this:
> 
>   static __always_inline bool constant_test_bit(long nr, const
> volatile unsigned long *addr)
>   {
>         bool oldbit;
> 
>         asm volatile("testb %2,%1"
>                      CC_SET(nz)
>                      : CC_OUT(nz) (oldbit)
>                      : "m" (((unsigned char *)addr)[nr >> 3]),
>                        "Ir" (1 << (nr & 7))
>                       :"memory");
>         return oldbit;
>   }
> 
> for both the regular test_bit() and for the acquire (since all loads
> are acquires on x86, and using an asm basically forces a memory load
> so it just does that "volatile" part.

I wouldn't do this for regular test_bit because if you read memory with 
different size/alignment from what you wrote, various CPUs suffer from 
store->load forwarding penalties.

But for test_bit_acqure this optimization is likely harmless because the 
bit will not be tested a few instructions after writing it.

> But that's a separate optimization and independent of the acquire thing.
> 
> > For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all
> > (with or without this patch), so I only compile-tested it on arm64. I have
> > to bisect it.
> 
> Hmm. I'm running it on real arm64 hardware (rc2+ - not your patch), so
> I wonder what's up..
> 
>                Linus
> 

This is version 3 of the patch. Changes:
* use assembler "testb" in constant_test_bit_acquire
* fix some comments as suggeste by Alan Stern
* fix Documentation/atomic_bitops.txt (note that since the commit 
  415d832497098030241605c52ea83d4e2cfa7879, test_and_set/clear_bit is 
  always ordered, so fix this claim as well)

Mikulas




From: Mikulas Patocka <mpatocka@redhat.com>

There are several places in the kernel where wait_on_bit is not followed
by a memory barrier (for example, in drivers/md/dm-bufio.c:new_read). On
architectures with weak memory ordering, it may happen that memory
accesses that follow wait_on_bit are reordered before wait_on_bit and they
may return invalid data.

Fix this class of bugs by introducing a new function "test_bit_acquire"
that works like test_bit, but has acquire memory ordering semantics.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

 Documentation/atomic_bitops.txt                          |   10 ++-----
 arch/x86/include/asm/bitops.h                            |   21 +++++++++++++++
 include/asm-generic/bitops/generic-non-atomic.h          |   14 ++++++++++
 include/asm-generic/bitops/instrumented-non-atomic.h     |   12 ++++++++
 include/asm-generic/bitops/non-atomic.h                  |    1 
 include/asm-generic/bitops/non-instrumented-non-atomic.h |    1 
 include/linux/bitops.h                                   |    1 
 include/linux/buffer_head.h                              |    2 -
 include/linux/wait_bit.h                                 |    8 ++---
 kernel/sched/wait_bit.c                                  |    2 -
 10 files changed, 60 insertions(+), 12 deletions(-)

Index: linux-2.6/include/asm-generic/bitops/generic-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/generic-non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/generic-non-atomic.h
@@ -4,6 +4,7 @@
 #define __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
 
 #include <linux/bits.h>
+#include <asm/barrier.h>
 
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
@@ -127,6 +128,18 @@ generic_test_bit(unsigned long nr, const
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+/**
+ * generic_test_bit_acquire - Determine, with acquire semantics, whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __always_inline bool
+generic_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 /*
  * const_*() definitions provide good compile-time optimizations when
  * the passed arguments can be resolved at compile time.
@@ -137,6 +150,7 @@ generic_test_bit(unsigned long nr, const
 #define const___test_and_set_bit	generic___test_and_set_bit
 #define const___test_and_clear_bit	generic___test_and_clear_bit
 #define const___test_and_change_bit	generic___test_and_change_bit
+#define const_test_bit_acquire		generic_test_bit_acquire
 
 /**
  * const_test_bit - Determine whether a bit is set
Index: linux-2.6/include/asm-generic/bitops/non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/non-atomic.h
@@ -13,6 +13,7 @@
 #define arch___test_and_change_bit generic___test_and_change_bit
 
 #define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 #include <asm-generic/bitops/non-instrumented-non-atomic.h>
 
Index: linux-2.6/include/linux/bitops.h
===================================================================
--- linux-2.6.orig/include/linux/bitops.h
+++ linux-2.6/include/linux/bitops.h
@@ -59,6 +59,7 @@ extern unsigned long __sw_hweight64(__u6
 #define __test_and_clear_bit(nr, addr)	bitop(___test_and_clear_bit, nr, addr)
 #define __test_and_change_bit(nr, addr)	bitop(___test_and_change_bit, nr, addr)
 #define test_bit(nr, addr)		bitop(_test_bit, nr, addr)
+#define test_bit_acquire(nr, addr)	bitop(_test_bit_acquire, nr, addr)
 
 /*
  * Include this here because some architectures need generic_ffs/fls in
Index: linux-2.6/include/linux/wait_bit.h
===================================================================
--- linux-2.6.orig/include/linux/wait_bit.h
+++ linux-2.6/include/linux/wait_bit.h
@@ -71,7 +71,7 @@ static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait,
@@ -96,7 +96,7 @@ static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait_io,
@@ -123,7 +123,7 @@ wait_on_bit_timeout(unsigned long *word,
 		    unsigned long timeout)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit_timeout(word, bit,
 					       bit_wait_timeout,
@@ -151,7 +151,7 @@ wait_on_bit_action(unsigned long *word,
 		   unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit, action, mode);
 }
Index: linux-2.6/kernel/sched/wait_bit.c
===================================================================
--- linux-2.6.orig/kernel/sched/wait_bit.c
+++ linux-2.6/kernel/sched/wait_bit.c
@@ -47,7 +47,7 @@ __wait_on_bit(struct wait_queue_head *wq
 		prepare_to_wait(wq_head, &wbq_entry->wq_entry, mode);
 		if (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags))
 			ret = (*action)(&wbq_entry->key, mode);
-	} while (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
+	} while (test_bit_acquire(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
 
 	finish_wait(wq_head, &wbq_entry->wq_entry);
 
Index: linux-2.6/include/asm-generic/bitops/non-instrumented-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/non-instrumented-non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/non-instrumented-non-atomic.h
@@ -12,5 +12,6 @@
 #define ___test_and_change_bit	arch___test_and_change_bit
 
 #define _test_bit		arch_test_bit
+#define _test_bit_acquire	arch_test_bit_acquire
 
 #endif /* __ASM_GENERIC_BITOPS_NON_INSTRUMENTED_NON_ATOMIC_H */
Index: linux-2.6/arch/x86/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/bitops.h
+++ linux-2.6/arch/x86/include/asm/bitops.h
@@ -207,6 +207,20 @@ static __always_inline bool constant_tes
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
 
+static __always_inline bool constant_test_bit_acquire(long nr, const volatile unsigned long *addr)
+{
+	bool oldbit;
+
+	asm volatile("testb %2,%1"
+		     CC_SET(nz)
+		     : CC_OUT(nz) (oldbit)
+		     : "m" (((unsigned char *)addr)[nr >> 3]),
+		       "i" (1 << (nr & 7))
+		     :"memory");
+
+	return oldbit;
+}
+
 static __always_inline bool variable_test_bit(long nr, volatile const unsigned long *addr)
 {
 	bool oldbit;
@@ -226,6 +240,13 @@ arch_test_bit(unsigned long nr, const vo
 					  variable_test_bit(nr, addr);
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	return __builtin_constant_p(nr) ? constant_test_bit_acquire(nr, addr) :
+					  variable_test_bit(nr, addr);
+}
+
 /**
  * __ffs - find first set bit in word
  * @word: The word to search
Index: linux-2.6/include/asm-generic/bitops/instrumented-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/instrumented-non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -142,4 +142,16 @@ _test_bit(unsigned long nr, const volati
 	return arch_test_bit(nr, addr);
 }
 
+/**
+ * _test_bit_acquire - Determine, with acquire semantics, whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __always_inline bool
+_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_bit_acquire(nr, addr);
+}
+
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -156,7 +156,7 @@ static __always_inline int buffer_uptoda
 	 * make it consistent with folio_test_uptodate
 	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
 	 */
-	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
+	return test_bit_acquire(BH_Uptodate, &bh->b_state);
 }
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
Index: linux-2.6/Documentation/atomic_bitops.txt
===================================================================
--- linux-2.6.orig/Documentation/atomic_bitops.txt
+++ linux-2.6/Documentation/atomic_bitops.txt
@@ -58,13 +58,11 @@ Like with atomic_t, the rule of thumb is
 
  - RMW operations that have a return value are fully ordered.
 
- - RMW operations that are conditional are unordered on FAILURE,
-   otherwise the above rules apply. In the case of test_and_set_bit_lock(),
-   if the bit in memory is unchanged by the operation then it is deemed to have
-   failed.
+ - RMW operations that are conditional are fully ordered.
 
-Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics and
-clear_bit_unlock() which has RELEASE semantics.
+Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics,
+clear_bit_unlock() which has RELEASE semantics and test_bit_acquire which has
+ACQUIRE semantics.
 
 Since a platform only has a single means of achieving atomic operations
 the same barriers as for atomic_t are used, see atomic_t.txt.

