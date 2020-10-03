Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC028254D
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 18:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgJCQMC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgJCQMB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 12:12:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75264C0613D0
        for <linux-arch@vger.kernel.org>; Sat,  3 Oct 2020 09:12:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o5so6794037qke.12
        for <linux-arch@vger.kernel.org>; Sat, 03 Oct 2020 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlekjJIS5w6LOeRz6EJlfj8ygIyCZG03pej0OmsvzhU=;
        b=nMJVqEVfcavjaZitmb1E8dy2yIv6nXRis5PU2+sJ8AQDKHeEV4Z/Q52f8LrbpU6sG8
         Hc8THdOwETxpNTyGxYgHG4luJHqPlLzTRWpD/YIznvkZ+YoBvPs+VzEkacOZ+2FZBbUq
         jsM28alYesEJmMd6ZrlUCLanHDwX3QhL5ZmTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlekjJIS5w6LOeRz6EJlfj8ygIyCZG03pej0OmsvzhU=;
        b=buxbopzb0Fs192rCRqFJnOHhuWGxGdo3+kYUKoaY9jwtWXMYz5rGxSxz7Cm+BRmEP0
         e7hnPBR9c4J4FkgYqQST2l+xTzUNohowFIDozjVjRl85nPVbXtr3SfKLq+FyZUMPvHD7
         ouGJj0/5fJtK1bZt5jPNbLiF1I1XTYKK9Mfy3vZ/6rfnam6T4QN1fuFAZkwCG5JXi8iW
         VaJ1H0IEujekTzjO4MaJ755LP75Qq2TQCxd5dLve32GYkVcDTq8GR/ZcUmrPEaenO3x7
         DtGfxiA7HTTNUaqGc1u1kp32n5kKNJYBMTfeQLo5SLAV0gUqA9hqyWctzXdwQwePA9a2
         ZBbQ==
X-Gm-Message-State: AOAM531d7Jz7p/1r7GV6qIY1niY5kGxuDllxqskszcH2PRar85oDNzsx
        dhGyA0x+bnxYNpjPRlCHYgPOVqvk0PJbfA==
X-Google-Smtp-Source: ABdhPJx/Vn4gZb2FVvaKZ4hc7v1kHqjY3wM9KDysoMHuheq8dpwUFs/mdGyXUoWR6xI16dtYsoSXCA==
X-Received: by 2002:a37:62c4:: with SMTP id w187mr2178542qkb.102.1601741520280;
        Sat, 03 Oct 2020 09:12:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id o35sm3576581qte.23.2020.10.03.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 09:11:59 -0700 (PDT)
Date:   Sat, 3 Oct 2020 12:11:59 -0400
From:   joel@joelfernandes.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201003161159.GA3601096@google.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003160846.GA3598977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003160846.GA3598977@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 03, 2020 at 12:08:46PM -0400, joel@joelfernandes.org wrote:
[...] 
> static void code0(struct v_struct* v,spinlock_t* l,int* out_0_r1) {
> 
>         struct v_struct *r1; /* to_free */
> 
>         r1 = NULL;
>         spin_lock(l);
>         if (!smp_load_acquire(&v->b))
>                 r1 = v;
>         v->a = 0;
>         spin_unlock(l);
> 
>   *out_0_r1 = !!r1;
> }
> 
> static void code1(struct v_struct* v,spinlock_t* l,int* out_1_r1) {
> 
>         struct v_struct *r1; /* to_free */
> 
>         r1 = v;
>         if (READ_ONCE(v->a)) {
>                 spin_lock(l);
>                 if (v->a)
>                         r1 = NULL;
>                 smp_store_release(&v->b, 0);
>                 spin_unlock(l);
>         }
> 
>   *out_1_r1 = !!r1;
> }
> 
> Results on both arm64 and x86:
> 
>     Histogram (2 states)
>     19080852:>0:r1=1; 1:r1=0;
>     20919148:>0:r1=0; 1:r1=1;
>     No
>     
>     Witnesses
>     Positive: 0, Negative: 40000000
>     Condition exists (0:r1=1 /\ 1:r1=1) is NOT validated
>     Hash=4a8c15603ffb5ab464195ea39ccd6382
>     Observation AL+test Never 0 40000000
>     Time AL+test 6.24
> 
> I guess I could do an alloc and free of v_struct. However, I just checked for
> whether the to_free in Al's example could ever be NULL for both threads.

Sorry, here I meant "ever be non-NULL".

So basically I was trying to experimentally confirm that to_free could never
be non-NULL in both code0 and code1 threads.
