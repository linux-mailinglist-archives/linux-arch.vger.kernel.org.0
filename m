Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F53D8E73
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 15:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhG1NCu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbhG1NCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 09:02:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB1CC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lJw7/JA0dLkOk/cCqm2teOhRSGThYzz2JP8qw+s+zd8=; b=h8RFifyEedIVr5JRd3gc4tfYBF
        WTy2kBYIqVuKw9kfJIhr7ZFwzHXNVp6KoEN7tZT2M+IPtyizGYBjamZHtJUZ+D+hPrV3J3U/jZ2ty
        WnmgjqmUpnEv/OD0glUfnt9COlMMqLrH7D0uQVG/uiVNqXq5kFM99QcLOh7CWUFPFsLFdnizL9Rtt
        IVTZvRzImBv43urhRSxnIpXvAU/NOSQERy/dm0Jv7Q/+Vo33beUEgJGBPK98Q33D/WqrM331VUDry
        Z8kC/QEGx551dy3ABkavLRreAir7VlI2sreXO7quCXnbyI+ZX5ydwJtMgbjV0omk6fwwvwi0S8zbf
        HHoWkFag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8jAu-00G49l-SR; Wed, 28 Jul 2021 13:00:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0FDB30022A;
        Wed, 28 Jul 2021 15:00:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7F4E2028E9B0; Wed, 28 Jul 2021 15:00:39 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:00:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <YQFU9xRenVjhO4Ec@hirez.programming.kicks-ass.net>
References: <20210728114822.1243-1-wangrui@loongson.cn>
 <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 02:58:35PM +0200, Peter Zijlstra wrote:
> Urgh.. please start from something like the below and then run:
> 
>   scripts/atomic/gen-atomics.sh
> 
> The below isn't quite right, because it'll use try_cmpxchg() for
> atomic_andnot_or(), which by being a void atomic should be _relaxed. I'm
> not entirely sure how to make that happen in a hurry.
> 

Of note, the below is on top of tip/locking/core, which includes a bunch
of atomic work from Mark.

> ---
> 
> diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
> index fbee2f6190d9..3aaa0caa6b2d 100755
> --- a/scripts/atomic/atomics.tbl
> +++ b/scripts/atomic/atomics.tbl
> @@ -39,3 +39,4 @@ inc_not_zero		b	v
>  inc_unless_negative	b	v
>  dec_unless_positive	b	v
>  dec_if_positive		i	v
> +andnot_or		vF	v	i:m	i:o
> diff --git a/scripts/atomic/fallbacks/andnot_or b/scripts/atomic/fallbacks/andnot_or
> new file mode 100644
> index 000000000000..f50e78d6c53a
> --- /dev/null
> +++ b/scripts/atomic/fallbacks/andnot_or
> @@ -0,0 +1,15 @@
> +cat <<EOF
> +static __always_inline ${ret}
> +arch_${atomic}_${pfx}andnot_or${sfx}${order}(${atomic}_t *v, ${int} m, ${int} o)
> +{
> +	${retstmt}({
> +		${int} N, O = atomic_read(v);
> +		do {
> +			N = O;
> +			N &= ~m;
> +			N |= o;
> +		} while (!arch_${atomic}_try_cmpxchg${order}(v, &O, N));
> +		O;
> +	});
> +}
> +EOF
> diff --git a/scripts/atomic/fallbacks/fetch_andnot_or b/scripts/atomic/fallbacks/fetch_andnot_or
> deleted file mode 100644
> index e69de29bb2d1..000000000000
> 
