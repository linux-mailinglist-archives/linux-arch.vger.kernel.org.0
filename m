Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727C539E4B9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFGRHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 13:07:10 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39784 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGRHJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 13:07:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso114678wmh.4
        for <linux-arch@vger.kernel.org>; Mon, 07 Jun 2021 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OMN53l5kgmJODOqHMs4OIt4N0K7fGpwPftPnoN3Bz5s=;
        b=ZNM4gYUViZanj9/vAZduPYUXzYtUUR9b86JylUfgSNPzOL9DCNzReHk6Cj3AoQQE0W
         cxKi298ibi3N+qxRhPVcej0+dn7POuWTWjcze4lDG9iDmifAP45btUNhGmV2NdZn3u63
         JN8NWG1c3pFkxMIQ/6QlD4wLN4S7dPAzUdiFU3LrxhAsMl3R35s6sLCpG1fW+qJxXOem
         Gidq9ARTuiQp7V2+IzS1A+jHcXpurImIpMiIUqR3yFOTLNDJmyhORTDS8uNBUHevz2+F
         taibtSSlxD3v0kH6V6gewsmk24X6UDyy4yflm5UPO/5G8+Rj0DxGH1qBJQrJiGSREZek
         TvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OMN53l5kgmJODOqHMs4OIt4N0K7fGpwPftPnoN3Bz5s=;
        b=nOeVrvN3QXaX8JPHOrEWsqY0LhYwq53jBBJfM2A/4x060OVkuyGJeVbY2fzN0JOoY1
         WUWMtTF2RgqJH/fcQ6KX9y1AHD5YdkVxrA9yGQz7lZUUBHH2LgfsxY2v0NbPA9Tq49RJ
         teC6LibRZoGH9JKXGtti7NJgKm6CTnbCcdwdRa195zK9mZsahlnGIavk0t4kqCdlSw28
         UTmMSWR9lnPN1uKdvDgjEY9g9Hd6BRs5e8vkyiDXghjo1iFmjUi8IZI9Yjf+vGZadO3d
         XRwGDWMe1E6dG1iorG8/QImw13sNIJAPwaxfLyZ6oa0NM7WuO/SdTHqncSUrkYFyTJ/g
         s2pA==
X-Gm-Message-State: AOAM530ZjYS2FtsgNpIJ25WhcOxFg07yS7fEINEpdrhNurwWDuwEV1xJ
        WmBifRHL6OeJeOEfWVuk9QKwCw==
X-Google-Smtp-Source: ABdhPJwhWLXmUu+DzAU028r37DJhwCFO6+ropbXNZ4fH0vKHNfRaTXn0Y9djsCFEWN8UMRWk0N5m0g==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr17858306wmi.106.1623085456693;
        Mon, 07 Jun 2021 10:04:16 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:a68c:2469:3bfe:52b4])
        by smtp.gmail.com with ESMTPSA id n8sm14697495wmi.16.2021.06.07.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:04:15 -0700 (PDT)
Date:   Mon, 7 Jun 2021 19:04:10 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YL5Risa6sFgnvvnG@elver.google.com>
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak>
 <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 08:28AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 07, 2021 at 10:27:10AM +0200, Marco Elver wrote:
> > On Mon, 7 Jun 2021 at 10:02, Alexander Monakov <amonakov@ispras.ru> wrote:
> > > On Sun, 6 Jun 2021, Linus Torvalds wrote:
> > [...]
> > > > On Sun, Jun 6, 2021 at 2:19 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> > [...]
> > > > Btw, since we have compiler people on line, the suggested 'barrier()'
> > > > isn't actually perfect for this particular use:
> > > >
> > > >    #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> > > >
> > > > in the general barrier case, we very much want to have that "memory"
> > > > clobber, because the whole point of the general barrier case is that
> > > > we want to make sure that the compiler doesn't cache memory state
> > > > across it (ie the traditional use was basically what we now use
> > > > "cpu_relax()" for, and you would use it for busy-looping on some
> > > > condition).
> > > >
> > > > In the case of "volatile_if()", we actually would like to have not a
> > > > memory clobber, but a "memory read". IOW, it would be a barrier for
> > > > any writes taking place, but reads can move around it.
> > > >
> > > > I don't know of any way to express that to the compiler. We've used
> > > > hacks for it before (in gcc, BLKmode reads turn into that kind of
> > > > barrier in practice, so you can do something like make the memory
> > > > input to the asm be a big array). But that turned out to be fairly
> > > > unreliable, so now we use memory clobbers even if we just mean "reads
> > > > random memory".
> > >
> > > So the barrier which is a compiler barrier but not a machine barrier is
> > > __atomic_signal_fence(model), but internally GCC will not treat it smarter
> > > than an asm-with-memory-clobber today.
> > 
> > FWIW, Clang seems to be cleverer about it, and seems to do the optimal
> > thing if I use a __atomic_signal_fence(__ATOMIC_RELEASE):
> > https://godbolt.org/z/4v5xojqaY
> 
> Indeed it does!  But I don't know of a guarantee for that helpful
> behavior.

Is there a way we can interpret the standard in such a way that it
should be guaranteed?

If yes, it should be easy to add tests to the compiler repos for
snippets that the Linux kernel relies on (if we decide to use
__atomic_signal_fence() for this).

If no, we can still try to add tests to the compiler repos, but may
receive some push-back at the very latest when some optimization pass
decides to break it. Because the argument then is that it's well within
the language standard.

Adding language extensions will likely be met with resistance, because
some compiler folks are afraid of creating language forks (the reason
why we have '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang').
That could be solved if we declare Linux-C a "standard", and finally get
-std=linux or such, at which point asking for "volatile if" directly
would probably be easier without jumping through hoops.

The jumping-through-hoops variant would probably be asking for a
__builtin primitive that allows constructing volatile_if() (if we can't
bend existing primitives to do what we want).

Thanks,
-- Marco
