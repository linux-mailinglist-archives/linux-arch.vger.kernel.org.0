Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3911E245
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 11:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMKrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 05:47:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKrL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 05:47:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so1047731wmc.3;
        Fri, 13 Dec 2019 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaItiTBk+e/R7wwZriBm1tDINaCLpM0u6e3njFKqqz8=;
        b=k2toVqK3xMpoQjPSunK5wQX2k/4FJdeWG6RMkZAOfcidd8oWAypdSfZVmj7VqJPARt
         D9jsVNfdnktzLM9kafptKzLf/MBDUHACylS71VvxJt7joO/PueWSlwl2tfrDfs/OB3A5
         9nCBlOpxsQ7z9OaxavDF50HpmkILhzxJAg+/RavBVin1voVF96sfcYcSpKx9j8YSDsMK
         wtD9Q3zk7/sQHPjUfcqEUXsoym55yhSOs0arrNE7BUzb5IeSai+o9nINSC8MklBR2Xeo
         ArjWDcuB4XqhR8P1+e5GcvXGXXYJj2Xlvr5AGErgkBbdrVFbwWjMdHUGWWmahvHJnBx1
         5wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaItiTBk+e/R7wwZriBm1tDINaCLpM0u6e3njFKqqz8=;
        b=lEutt7d66XMEm0FwfLzfHsMToMup5/6p3AtfL58ns9R4q6vWV+uJpLYPE5p+BnTMpC
         QyeKSxm57ORtafaGkoJVPaprm8JFtnKmYFufhIR6zgTgeuE9qVx8NeDAB8SvBjmX5mAk
         ZwESjPzHU5yo89neTyh4/AtTQtv2jO8qQM0RK2ejKxaaLQmzcmAcNfyhmzifWvPnXUiR
         ihn2c2A09vpstDgZT25xH5sXogcuL3vqtYGV4lo58rfHXt+NMpiN4tbwH6Tmo2KQV9/R
         foXpE0t7itNotMlR1Yw8ABF13mlCk/RQaD0XNlvkUfTUtQWxcnHu713wdzqEtKm6N1Z/
         JQ+g==
X-Gm-Message-State: APjAAAW514bEMvFLC4H+CsJugVESz0aIFxBCTi3JY+VkhxgW0LuYMMXG
        5XRQM+jmERgFMBFBgRSr281ulbKI
X-Google-Smtp-Source: APXvYqyfTI8+XVU3RlrvIfXGdBG0oWSlgTPqBGikvSD/heK932h0ralSPKkMiJh26I6zh+Fs+wYfXg==
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr12593233wmc.108.1576234029069;
        Fri, 13 Dec 2019 02:47:09 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40f6:4600:c498:c79c:5e:9634])
        by smtp.gmail.com with ESMTPSA id x17sm8764911wrt.74.2019.12.13.02.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:47:08 -0800 (PST)
Date:   Fri, 13 Dec 2019 11:47:06 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191213104706.xnpqaehmtean3mkd@ltop.local>
References: <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
 <20191212205338.GB11802@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212205338.GB11802@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 09:53:38PM +0100, Peter Zijlstra wrote:
> Now, looking at the current GCC source:
> 
>   https://github.com/gcc-mirror/gcc/blob/97d7270f894395e513667a031a0c309d1819d05e/gcc/c/c-parser.c#L3707
> 
> it seems that __typeof__() is supposed to strip all qualifiers from
> _Atomic types. That lead me to try:
> 
> 	typeof(_Atomic typeof(p)) __p = (p);
> 
> But alas, I still get the same junk you got for ool_store_release() :/

I was checking this to see if Sparse was ready to support this.
I was a bit surprised because at first sigth GCC was doing as
it claims (typeof striping const & volatile on _Atomic types)
but your exampe wasn't working. But it's working if an
intermediate var is used:
	_Atomic typeof(p) tmp;
	typeof(tmp) __p = (p);
or, uglier but probably more practical:
	typeof(({_Atomic typeof(p) tmp; })) __p = (p);

Go figure!

OTOH, at least on GCC 8.3, it seems to always do the same with
volatiles than it does with consts.

-- Luc Van Oostenryck
