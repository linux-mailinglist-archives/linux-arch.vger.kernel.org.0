Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6399410F74A
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2019 06:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLCFa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Dec 2019 00:30:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCFa0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Dec 2019 00:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fasHx2KRVQANkAag/rtzNmdYDi10qgh4xlJuuHfsM7I=; b=Eo2Tw1qpTglRUBzzKh4KHekHS
        MG9I0TAHFIY17B2RpTzLKPVWZ+X/jaHOGUDa/fVa+4pZWAKehkeqd+uAhmdrUBZw2tS9W8B4+6SUv
        02RYQRnO+xCCCRh5IKgL1pHFiwxUL4oIDt8noq9UyQDLvP6O/qk+aX5y3C6VqWdB+XxUb6BN+XtdV
        RNZLAHC5Wc+HIFCV5oAsJcyWdij865PYUk8WAPtIEJIDOrMCYQnt/ZIbUlx4aY9KVo5BWP97n95gw
        wileGc5m4doam4/bw72H3DJOqddWzASrdMpJ60C5d2fH6IFtD3/5PPQthd/TkMOsmhRyW67sZwBX/
        uF3q3pCCg==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic0lU-0007lO-O8; Tue, 03 Dec 2019 05:30:24 +0000
Subject: Re: [PATCH v3 3/3] kcsan: Prefer __always_inline for fast-path
To:     Marco Elver <elver@google.com>
Cc:     mark.rutland@arm.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de,
        dvyukov@google.com, linux-arch@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <20191126140406.164870-1-elver@google.com>
 <20191126140406.164870-3-elver@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <00ee3b40-0e37-c9ac-3209-d07b233a0c1d@infradead.org>
Date:   Mon, 2 Dec 2019 21:30:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126140406.164870-3-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/26/19 6:04 AM, Marco Elver wrote:
> Prefer __always_inline for fast-path functions that are called outside
> of user_access_save, to avoid generating UACCESS warnings when
> optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
> surprises with compiler versions that change the inlining heuristic even
> when optimizing for performance.
> 
> Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Rebased on: locking/kcsan branch of tip tree.
> ---
>  kernel/kcsan/atomic.h   |  2 +-
>  kernel/kcsan/core.c     | 16 +++++++---------
>  kernel/kcsan/encoding.h | 14 +++++++-------
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> index 576e03ddd6a3..a9c193053491 100644
> --- a/kernel/kcsan/atomic.h
> +++ b/kernel/kcsan/atomic.h
> @@ -18,7 +18,7 @@
>   * than cast to volatile. Eventually, we hope to be able to remove this
>   * function.
>   */
> -static inline bool kcsan_is_atomic(const volatile void *ptr)
> +static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
>  {
>  	/* only jiffies for now */
>  	return ptr == &jiffies;
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 3314fc29e236..c616fec639cd 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
>   */
>  static DEFINE_PER_CPU(long, kcsan_skip);
>  
> -static inline atomic_long_t *find_watchpoint(unsigned long addr,
> -					     size_t size,
> -					     bool expect_write,
> -					     long *encoded_watchpoint)
> +static __always_inline atomic_long_t *
> +find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
>  {
>  	const int slot = watchpoint_slot(addr);
>  	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> @@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
>   *	2. the thread that set up the watchpoint already removed it;
>   *	3. the watchpoint was removed and then re-used.
>   */
> -static inline bool
> +static __always_inline bool
>  try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
>  {
>  	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
> @@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
>  	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
>  }
>  
> -static inline struct kcsan_ctx *get_ctx(void)
> +static __always_inline struct kcsan_ctx *get_ctx(void)
>  {
>  	/*
>  	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
> @@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
>  	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
>  }
>  
> -static inline bool is_atomic(const volatile void *ptr)
> +static __always_inline bool is_atomic(const volatile void *ptr)
>  {
>  	struct kcsan_ctx *ctx = get_ctx();
>  
> @@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
>  	return kcsan_is_atomic(ptr);
>  }
>  
> -static inline bool should_watch(const volatile void *ptr, int type)
> +static __always_inline bool should_watch(const volatile void *ptr, int type)
>  {
>  	/*
>  	 * Never set up watchpoints when memory operations are atomic.
> @@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
>  	this_cpu_write(kcsan_skip, skip_count);
>  }
>  
> -static inline bool kcsan_is_enabled(void)
> +static __always_inline bool kcsan_is_enabled(void)
>  {
>  	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
>  }
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index b63890e86449..f03562aaf2eb 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
>  		      (addr & WATCHPOINT_ADDR_MASK));
>  }
>  
> -static inline bool decode_watchpoint(long watchpoint,
> -				     unsigned long *addr_masked,
> -				     size_t *size,
> -				     bool *is_write)
> +static __always_inline bool decode_watchpoint(long watchpoint,
> +					      unsigned long *addr_masked,
> +					      size_t *size,
> +					      bool *is_write)
>  {
>  	if (watchpoint == INVALID_WATCHPOINT ||
>  	    watchpoint == CONSUMED_WATCHPOINT)
> @@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
>  /*
>   * Return watchpoint slot for an address.
>   */
> -static inline int watchpoint_slot(unsigned long addr)
> +static __always_inline int watchpoint_slot(unsigned long addr)
>  {
>  	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
>  }
>  
> -static inline bool matching_access(unsigned long addr1, size_t size1,
> -				   unsigned long addr2, size_t size2)
> +static __always_inline bool matching_access(unsigned long addr1, size_t size1,
> +					    unsigned long addr2, size_t size2)
>  {
>  	unsigned long end_range1 = addr1 + size1 - 1;
>  	unsigned long end_range2 = addr2 + size2 - 1;
> 


-- 
~Randy

