Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0D2A1127
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 23:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgJ3Wqu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJ3Wqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 18:46:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7ACC0613D7
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2020 15:46:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 2so8506872ljj.13
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2020 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrhxrWCIONXWoPxsDWMRBR+W10EJDGZ7OkgmkAXhFNU=;
        b=NSjEistXDK7QrUisKBKyvvsUCTs8KpdALOTDGFQa3ZlxOrfYPgQ15P5Hp32THt3kZR
         cN7sjbd0KoMQ3npg9DHgup7Q9J8GXdmUQ8lIGjC/f9HFg6XaYw9GqJyObayLgtYOnfyC
         +DPogaxfsLaFCM9OrmD2eUZrIvZD8sMP/wXjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrhxrWCIONXWoPxsDWMRBR+W10EJDGZ7OkgmkAXhFNU=;
        b=ifd8xyx2jnB2I2oHhMyc9fISEda/d+geWARPUDCiU5YGXQ9uSzmshKxjNEQ5JCjwto
         CrPH3ZMZXlcAFeTRN6FW4sH2q2jkD8Ftv5rBO2qCtUKt8zi6EEWDCtEj5XzU4JO3nWIZ
         K8l5LtnZR1bFjjs/dOihRZdDpgwAEQfr9n2Tr8Z1sKFx65964vx8+dvT6efeCkOWoGeL
         7shox/tARpvj6B4dEtWBL/RxFmxVI5wAaXUBic2BM/wluXUDrr+NGFiaUkJAqf8T7+V9
         fkud3BMfjOWv/PG9NDu//ZTo+ADONuXN35ePq8yJYQ+r4g3mTldcPr0BKeNun/J/n3ni
         zzGA==
X-Gm-Message-State: AOAM533NcfYb4RQCoBz3Jv+wqFYbVIJ5CMPXq5DUTmhyA2vksgn947j5
        5+rCO5hQJMIkeWZWdTUB4ByvIK6390tLpw==
X-Google-Smtp-Source: ABdhPJyHR9wYbmUJHBmxnzwAflHScXDdrjl/36uPd0kgPnMPJRrI8UQRH0fwj0ww60FcWPAAhlLDkQ==
X-Received: by 2002:a2e:904e:: with SMTP id n14mr1901287ljg.356.1604098007417;
        Fri, 30 Oct 2020 15:46:47 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r5sm802045ljm.77.2020.10.30.15.46.42
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 15:46:43 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y184so7904746lfa.12
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2020 15:46:42 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1949766lfa.603.1604098002560;
 Fri, 30 Oct 2020 15:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de>
 <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com> <87sg9vl59i.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sg9vl59i.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Oct 2020 15:46:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
Message-ID: <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
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
        linux-xtensa@linux-xtensa.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 3:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> While at it I might have a look at that debug request from Willy in the
> other end of this thread. Any comment on that?
>
>  https://lore.kernel.org/r/87k0v7mrrd.fsf@nanos.tec.linutronix.de

I do think that it would be nice to have a debug mode, particularly
since over the last few years we've really lost a lot of HIGHMEM
coverage (to the point that I've wondered how worthwhile it really is
to support at all any more - I think it's Arnd who argued that it's
mainly some embedded ARM variants that will want it for the forseeable
future).

So I'm honestly somewhat torn. I think HIGHMEM is dying, and yes that
argues for "non-HIGHMEM had better have some debug coverage", but at
the same time I think it doesn't even really matter any more. At some
point those embedded ARM platforms just aren't even interesting - they
might as well use older kernels if they are the only thing really
arguing for HIGHMEM at all.

This is one reason why I'd like the new kmap_local() to be a no-op,
and I'd prefer for it to have no other side effects - because I want
to be ready to remove it entirely some day. And if we end up having
some transition where people start rewriting "kmap_atomic()" to be
"kmap_local() + explicit preemption disable", then I think that would
be a good step on that whole "kmap will eventually go away" path.

But I do *not* believe that we need to add _so_ much debug support
that we'd catch Willy's "more than one page" case. And I absolutely do
not believe for a second that we should start caring about compound
pages. NO. kmap() is almost dead already, we're not making it worse.

To me, your patch series has two big advantages:

 - more common code

 - kmap_local() becomes more of a no-op

and the last thing we want is to expand on kmap.

           Linus
