Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7702DC4D
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE2MBe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 08:01:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2MBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 08:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YPtPUNuDX71Si0dZ9/GsA4yGWJlCJusvLAiyqICMNXY=; b=Nzz9NhjF8qG2NqUpURT9rN5I8
        GitsRNBIKtwiTOhTDSPZGCjNfpraqKc9ITf6ZzGPoNENCmd72vVOzeolX69T8ltrz/laD4QSfK/Sm
        SrDJ0Ebsss5km5xqOMyCWbUtrJOvVLv0blhjI6uB8rkzbUC6AFnWJmc8R0eNi1PanZ9WrsJFl6wIW
        M7DpaAaRIYsdynADtd2wKisFTn4pvvDjYEna0VzWY+AVxDSjUjyMSRuqv+rx24E1f482BrTqeP2yb
        PKvkcpDaldigqqxfmU2+iFQunen/H62839PwiNEo0nBqX9o6nbtPUDUx0ULQt+gm1e790tkTTLHo3
        Q60lmYXZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVxGi-0003lQ-Tc; Wed, 29 May 2019 12:01:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45DDD201DA657; Wed, 29 May 2019 14:01:18 +0200 (CEST)
Date:   Wed, 29 May 2019 14:01:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Dmitry Vyukov' <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529120118.GQ2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
 <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
 <a0157a8d778a48b7ba3935f3e6840d30@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0157a8d778a48b7ba3935f3e6840d30@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 11:20:56AM +0000, David Laight wrote:
> From: Dmitry Vyukov
> > Sent: 29 May 2019 11:57

> > Interesting. Does an address passed to bitops also should be aligned,
> > or alignment is supposed to be handled by bitops themselves?
> 
> The bitops are defined on 'long []' and it is expected to be aligned.
> Any code that casts the argument is likely to be broken on big-endian.
> I did a quick grep a few weeks ago and found some very dubious code.
> Not all the casts seemed to be on code that was LE only (although
> I didn't try to find out what the casts were from).
> 
> The alignment trap on x86 could be avoided by only ever requesting 32bit
> cycles - and assuming the buffer is always 32bit aligned (eg int []).
> But on BE passing an 'int []' is just so wrong ....

Right, but as argued elsewhere, I feel we should clean up the dubious
code instead of enabling it.
