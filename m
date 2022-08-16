Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9F595E07
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiHPOFd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiHPOEp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 10:04:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C974E17;
        Tue, 16 Aug 2022 07:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61B30B81A6D;
        Tue, 16 Aug 2022 14:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004EBC433C1;
        Tue, 16 Aug 2022 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660658673;
        bh=Wh+jI+PqTsQH8YzE0QsazGkkHZidRC6uVcJ+kYQYMlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjXJagJFCVZKSV3tJrcQnLFtFysSDQKz/D7YuLPy1S9mlkH3GtZ4qwYpfs+/U/2Zz
         G9PhhC/7502IjDqw834ILwsFz+caU10Nr08nZttjgzuA21C3Gu6tuOU71Xr42m2wZI
         DO2ddjVtB1xapBh5YXxMNEdVkvZ1WDtHUpKJjX32loqxEAProcjn0wCHMdCqqVmTmf
         GotA9kj3JjsdqgQMnp8NrN6BGlw271uwgYq0EuXclMq85mnVdJqE+0RNLTwaSHDiep
         CokoyPFXqYhiiwMwX3wGuqtXPZkL/3NsQ7AXGoYtOb7jWYalNpdpsMdei02Fd3Ysf6
         Z1ZOsXxdPhcPw==
Date:   Tue, 16 Aug 2022 15:04:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
        jirislaby@kernel.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oliver Neukum <oneukum@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Asahi Linux <asahi@lists.linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: Make test_and_*_bit() ordered on failure
Message-ID: <20220816140423.GC11202@willie-the-truck>
References: <20220816070311.89186-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816070311.89186-1-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 16, 2022 at 04:03:11PM +0900, Hector Martin wrote:
> These operations are documented as always ordered in
> include/asm-generic/bitops/instrumented-atomic.h, and producer-consumer
> type use cases where one side needs to ensure a flag is left pending
> after some shared data was updated rely on this ordering, even in the
> failure case.
> 
> This is the case with the workqueue code, which currently suffers from a
> reproducible ordering violation on Apple M1 platforms (which are
> notoriously out-of-order) that ends up causing the TTY layer to fail to
> deliver data to userspace properly under the right conditions. This
> change fixes that bug.
> 
> Change the documentation to restrict the "no order on failure" story to
> the _lock() variant (for which it makes sense), and remove the
> early-exit from the generic implementation, which is what causes the
> missing barrier semantics in that case. Without this, the remaining
> atomic op is fully ordered (including on ARM64 LSE, as of recent
> versions of the architecture spec).
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Fixes: e986a0d6cb36 ("locking/atomics, asm-generic/bitops/atomic.h: Rewrite using atomic_*() APIs")
> Fixes: 61e02392d3c7 ("locking/atomic/bitops: Document and clarify ordering semantics for failed test_and_{}_bit()")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/atomic_bitops.txt     | 2 +-
>  include/asm-generic/bitops/atomic.h | 6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
> index 093cdaefdb37..d8b101c97031 100644
> --- a/Documentation/atomic_bitops.txt
> +++ b/Documentation/atomic_bitops.txt
> @@ -59,7 +59,7 @@ Like with atomic_t, the rule of thumb is:
>   - RMW operations that have a return value are fully ordered.
>  
>   - RMW operations that are conditional are unordered on FAILURE,
> -   otherwise the above rules apply. In the case of test_and_{}_bit() operations,
> +   otherwise the above rules apply. In the case of test_and_set_bit_lock(),
>     if the bit in memory is unchanged by the operation then it is deemed to have
>     failed.

The next sentence is:

  | Except for a successful test_and_set_bit_lock() which has ACQUIRE
  | semantics and clear_bit_unlock() which has RELEASE semantics.

so I think it reads a bit strangely now. How about something like:


diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
index 093cdaefdb37..3b516729ec81 100644
--- a/Documentation/atomic_bitops.txt
+++ b/Documentation/atomic_bitops.txt
@@ -59,12 +59,15 @@ Like with atomic_t, the rule of thumb is:
  - RMW operations that have a return value are fully ordered.
 
  - RMW operations that are conditional are unordered on FAILURE,
-   otherwise the above rules apply. In the case of test_and_{}_bit() operations,
-   if the bit in memory is unchanged by the operation then it is deemed to have
-   failed.
+   otherwise the above rules apply. For the purposes of ordering, the
+   test_and_{}_bit() operations are treated as unconditional.
 
-Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics and
-clear_bit_unlock() which has RELEASE semantics.
+Except for:
+
+ - test_and_set_bit_lock() which has ACQUIRE semantics on success and is
+   unordered on failure;
+
+ - clear_bit_unlock() which has RELEASE semantics.
 
 Since a platform only has a single means of achieving atomic operations
 the same barriers as for atomic_t are used, see atomic_t.txt.


?

> diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
> index 3096f086b5a3..71ab4ba9c25d 100644
> --- a/include/asm-generic/bitops/atomic.h
> +++ b/include/asm-generic/bitops/atomic.h
> @@ -39,9 +39,6 @@ arch_test_and_set_bit(unsigned int nr, volatile unsigned long *p)
>  	unsigned long mask = BIT_MASK(nr);
>  
>  	p += BIT_WORD(nr);
> -	if (READ_ONCE(*p) & mask)
> -		return 1;
> -
>  	old = arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);
>  	return !!(old & mask);
>  }
> @@ -53,9 +50,6 @@ arch_test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
>  	unsigned long mask = BIT_MASK(nr);
>  
>  	p += BIT_WORD(nr);
> -	if (!(READ_ONCE(*p) & mask))
> -		return 0;
> -
>  	old = arch_atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
>  	return !!(old & mask);

I suppose one sad thing about this is that, on arm64, we could reasonably
keep the READ_ONCE() path with a DMB LD (R->RW) barrier before the return
but I don't think we can express that in the Linux memory model so we
end up in RmW territory every time. Perhaps we should roll our own
implementation in the arch code?

In any case, this should fix the problem so:

Acked-by: Will Deacon <will@kernel.org>

Will
