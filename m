Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F23D8DC5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhG1M17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhG1M16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 08:27:58 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257BEC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 05:27:56 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k3so2474698ilu.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DdAoQ1BJsjp8Z69r7AMG206plKcJCF8ys76XGqcZa8k=;
        b=MVOl8qkKMZ7EzN2QfIB4eNYlCEkhoQ4zjeofbwPBP9lQktQs0lBuaj2hw/OnfdU/Wd
         fWUVqaQ7a7o+wjkyC1sC3aAc1Ic2kqcILbixyLuplCYa9XEtzHkzwQqs9ZGgGXKvoras
         m8HjrT5A27AcPC3ylCLYxDHrndW1nWsUjRYs+4ISN1+ANHay1sijM1BeedW6ls+VRJda
         5M/o6lgV53ItkTM28nUadSra90IM5uFGJYPOTZ8wtQveEHdv1z1dHETNK5Xr1Jc8GHx7
         V3SRVqOiWSQSXfa49XWdEbSlVyRH60nOvSKtTiNpOu4pVG2dLPbq7qneoJ5qIFFfR3m+
         k0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdAoQ1BJsjp8Z69r7AMG206plKcJCF8ys76XGqcZa8k=;
        b=Ut8j9tDmcNqijKeLJKpbFTn/WN3gEzIxB+KoH6ZLarr9HKmJ7if4sH+AsxxIXdC+r2
         1nCcS2z56Dz8zgXrOxbbg2TN1S589Ts9KlwROoqL/H4g0uLrAxbQos6wXhEb+TFb/WJs
         /x/mxVzTIZ4Tq3Dbg8UGUSdI/uRqAqDIxUlyaDvZhfUv3nyM2r6/xbz+sRygTHRcF6Mp
         3N+CKfY1LM9FfQO/Kqc+Qs1/Sg5Doih8jMebCVgtXU5M7DaoGE20k9mhnGX/aAbuvMIN
         vFuLpY8vSTjb4C7x1rfzfdP9UUROiO+kJ06smnP2JaCMdxW/VI1OLTBa3VRbXuvI+zLx
         G/lA==
X-Gm-Message-State: AOAM530fcK7NIq6FWRJqzLUyYsr1vP8ey5sMgHu7frzsDOSKT2Ru3Q2s
        zcHZXZXrfFRgSNeswdZDuXQ=
X-Google-Smtp-Source: ABdhPJxuGyHb70OKJ/TEtpjvW6z2k+5LAmJLA8pW4ZF/2vx8I4tyVV8XJ5VMvW9FCCfLc51KxhY9Iw==
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr19296278ila.50.1627475275606;
        Wed, 28 Jul 2021 05:27:55 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l12sm3790317ilg.2.2021.07.28.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:27:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 586D627C0054;
        Wed, 28 Jul 2021 08:27:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 28 Jul 2021 08:27:54 -0400
X-ME-Sender: <xms:SE0BYamAc0cZuknwd_iNFwnxkN1SffV-peYC-TOJBWu78f3SCAMxYQ>
    <xme:SE0BYR26h6OqTW40KfutKl9VpNSYDz8ULIyH73E1sjAqFcATzuoyZRRvTv-_S1wua
    oGZ9FHU0RYifNBqNA>
X-ME-Received: <xmr:SE0BYYqkHEJAH_scwKwAUo63RPbqb2hL94mrgPaTHVFLjS5QqHFtpsrWMPOlmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeelgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:SE0BYel2IYJVWW1ocHWb3-IS7VpD_exIGG-1GcT1UrFVbbXrnSM4RQ>
    <xmx:SE0BYY27JGIXEX1GCfV_rsJSsSCST4Oms6SitFDYfb_0MDhUQi20RA>
    <xmx:SE0BYVslB3d2NDqGGuKFXl54Scez3giG5bZdZZ2flPsZV9i5a1p0ig>
    <xmx:Sk0BYeOWkQdC2QwW1V_6rxziknJfG6cSVQ6DXRWBnv1O1aRfELHt9V-8ySA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jul 2021 08:27:52 -0400 (EDT)
Date:   Wed, 28 Jul 2021 20:27:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [RFC PATCH v1 2/5] locking/qspinlock: Refactor xchg_tail to use
 atomic_fetch_and_or
Message-ID: <YQFNNN9Fee9PaPUi@boqun-archlinux>
References: <20210728114923.1294-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728114923.1294-1-wangrui@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 07:49:23PM +0800, Rui Wang wrote:
> From: wangrui <wangrui@loongson.cn>
> 

Please add the explanation of why the change here, ditto for rest of the
patchset.

> Signed-by-off: Rui Wang <wangrui@loongson.cn>
> Signed-by-off: hev <r@hev.cc>
> ---
>  kernel/locking/qspinlock.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cbff6ba53d56..350363e14e38 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -219,22 +219,8 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>   */
>  static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  {
> -	u32 old, new, val = atomic_read(&lock->val);
> -
> -	for (;;) {
> -		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> -		/*
> -		 * We can use relaxed semantics since the caller ensures that
> -		 * the MCS node is properly initialized before updating the
> -		 * tail.
> -		 */
> -		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
> -		if (old == val)
> -			break;
> -
> -		val = old;
> -	}
> -	return old;
> +	const u32 mask = _Q_LOCKED_PENDING_MASK;

There should be a blank line between definition and code, also please
keep the comments for why we use _relaxed() here.

Regards,
Boqun

> +	return atomic_fetch_and_or_relaxed(mask, tail, &lock->val);
>  }
>  #endif /* _Q_PENDING_BITS == 8 */
>  
> -- 
> 2.32.0
> 
