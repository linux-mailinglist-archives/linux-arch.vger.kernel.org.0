Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896856515D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiGDJw6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiGDJw5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 05:52:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C06DE87;
        Mon,  4 Jul 2022 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6JCXp2CTA6tebVlYfKnSGvd72D8VGQ9/1QrNl2Uu06U=; b=owjF/0SC014EElX4qJEISeY+Hi
        NodSfpeuBnMDq+sFywN7UKljESOC/Tdrwmm5AbourGfPMiiQsiSr7vClvYXc06+EdE774duqyKDPo
        9Qbk5h4+V1Q12i7wgiF/UCyzyyw39STd53R8F+fEF/J7arhksByymed85iWF8ZxwJJXVnmv+6zaig
        pYWESxC5vf+x2K5dYTSovW9eYvj2iqjkgHRfXarjl3nPFm6AwsQ73tIJ6XkXA1xiKtvjIdxMrx/tR
        EXkOBa0Sde2ZAUUbWnJ0G+RkqUDKrUl6qvTGq3YD3scUfdpMKGDSOTQXKu7kbuQD62hEi3UskrPV9
        BcvTGSsQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Ikz-00H9mA-A4; Mon, 04 Jul 2022 09:52:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9126930027E;
        Mon,  4 Jul 2022 11:52:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 594B320295B20; Mon,  4 Jul 2022 11:52:39 +0200 (CEST)
Date:   Mon, 4 Jul 2022 11:52:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, arnd@arndb.de, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary
 atomic_read
Message-ID: <YsK4Z9w0tFtgkni8@hirez.programming.kicks-ass.net>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628081707.1997728-2-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 28, 2022 at 04:17:03AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
> because the value has been in lock. This patch could prevent
> arch_spin_value_unlocked contend spin_lock data again.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  include/asm-generic/spinlock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..f1e4fa100f5a 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -84,7 +84,9 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
> -	return !arch_spin_is_locked(&lock);
> +	u32 val = lock.counter;
> +
> +	return ((val >> 16) == (val & 0xffff));
>  }

Wouldn't the right thing be to flip arch_spin_is_locked() and
arch_spin_value_is_unlocked() ?


diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index fdfebcb050f4..63ab4da262f2 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -68,23 +68,25 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 	smp_store_release(ptr, (u16)val + 1);
 }
 
-static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
+static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
 	u32 val = atomic_read(lock);
 
-	return ((val >> 16) != (val & 0xffff));
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
 
-static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
-	u32 val = atomic_read(lock);
+	u32 val = lock.counter;
 
-	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+	return ((val >> 16) == (val & 0xffff));
 }
 
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	return !arch_spin_is_locked(&lock);
+	arch_spinlock_t val = READ_ONCE(*lock);
+
+	return !arch_spin_value_unlocked(val);
 }
 
 #include <asm/qrwlock.h>

