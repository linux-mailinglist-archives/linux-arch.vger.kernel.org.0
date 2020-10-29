Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2829F935
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 00:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJ2Xmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 19:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Xmf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 19:42:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4AC0613CF;
        Thu, 29 Oct 2020 16:41:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604014900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWuiBG8a+NnkPGmw23LTYR8bRuWLPOcTs2J9m+57N30=;
        b=SXAxpB4OrSZM8KanRhq0SHKbbqNdcUZGBDuuY0dpE3HzYsV6X3WGBvormMPwGgBe13WqGS
        zl+c6uDF44lRL3XYTntNDOXhWi1enb8HJyzyEjQMqxw3GSIbeAvode6e1x0/HUh1LOV13D
        iGoRdWEQcslmNVQBlZot50CD5jCjvafIrM9wdZgJj+TIzPSwNqWmbdAFeVqjadC2jU11Tb
        rGfBMY/MMEh+koaNaMVZhxHbfDry4hkHFhwfoBCQ7ddPNZj4c2CDLBpYqBLzdFm2N74+mY
        zh6t2OfFuG8Sz0WmlH9mRTGpAIOiGIUlj2fJM+MCYBQBz4iunYGWpWFAsyGP3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604014900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWuiBG8a+NnkPGmw23LTYR8bRuWLPOcTs2J9m+57N30=;
        b=bPrOV2Mu8WrqdxWFrt3BZte7XxWkrcHXKqjiK4x7RufHzyISYL2psldkYUi2DujbGIhU51
        +7ZFtIMezAsqNiCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list\:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
In-Reply-To: <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
Date:   Fri, 30 Oct 2020 00:41:39 +0100
Message-ID: <87pn50ob0s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 29 2020 at 16:11, Linus Torvalds wrote:
> On Thu, Oct 29, 2020 at 3:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Though I wanted to share the current state of affairs before investigating
>> that further. If there is consensus in going forward with this, I'll have a
>> deeper look into this issue.
>
> Me likee. I think this looks like the right thing to do.
>
> I didn't actually apply the patches, but just from reading them it
> _looks_ to me like you do the migrate_disable() unconditionally, even
> if it's not a highmem page..
>
> That sounds like it might be a good thing for debugging, but not
> necessarily great in general.
>
> Or am I misreading things?

No, you're not misreading it, but doing it conditionally would be a
complete semantical disaster. kmap_atomic*() also disables preemption
and pagefaults unconditionaly.  If that wouldn't be the case then every
caller would have to have conditionals like 'if (CONFIG_HIGHMEM)' or
worse 'if (PageHighMem(page)'.

Let's not go there.

Migrate disable is a less horrible plague than preempt and pagefault
disable even if the scheduler people disagree due to the lack of theory
backing that up :)

The charm of the new interface is that users still can rely on per
cpuness independent of being on a highmem plagued system. For non
highmem systems the extra migrate disable/enable is really a minor
nuissance.

Thanks,

        tglx
