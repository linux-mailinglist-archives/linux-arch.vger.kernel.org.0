Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34AEFCEE9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 20:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNTsU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 14:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfKNTsU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Nov 2019 14:48:20 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE2720727;
        Thu, 14 Nov 2019 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573760899;
        bh=5qgPuQRrQZG/43baxIo8qPU03QjMBopEOA3ytCqxVwY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cdfsnpNAh+QT5phy/N77a5SWtd9pj6Wn6oaErwjcBPTpTAejXc/3YOIjfWbZOnI2P
         K3oVbMap+saQiE2XDeQ3H4xQ4zNto99w2qg8zNb5iOeuu2vuyrfh/ySgz5iTXglpQ3
         h2+lAT3OFowktrBrIBLtRGuKQC9Lfw+1nz7KxUho=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C62435227FC; Thu, 14 Nov 2019 11:48:17 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:48:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 0/9] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191114194817.GO2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191104142745.14722-1-elver@google.com>
 <20191104164717.GE20975@paulmck-ThinkPad-P72>
 <CANpmjNOtR6NEsXGo=M1o26d8vUyF7gwj=gew+LAeE_D+qfbEmQ@mail.gmail.com>
 <20191104194658.GK20975@paulmck-ThinkPad-P72>
 <CANpmjNPpVCRhgVgfaApZJCnMKHsGxVUno+o-Fe+7OYKmPvCboQ@mail.gmail.com>
 <20191105142035.GR20975@paulmck-ThinkPad-P72>
 <CANpmjNPEukbQtD5BGpHdxqMvnq7Uyqr9o3QCByjCKxtPboEJtA@mail.gmail.com>
 <CANpmjNPTMjx4TSr+LEwV-xm8jFtATOym=h416j5rLK1V4kOYCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPTMjx4TSr+LEwV-xm8jFtATOym=h416j5rLK1V4kOYCg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 14, 2019 at 07:05:34PM +0100, Marco Elver wrote:
> On Tue, 5 Nov 2019 at 16:25, Marco Elver <elver@google.com> wrote:
> > On Tue, 5 Nov 2019 at 15:20, Paul E. McKenney <paulmck@kernel.org> wrote:

[ . . . ]

> > > It works for me, though you guys have to continue to be the main
> > > developers.  ;-)
> >
> > Great, thanks. We did add an entry to MAINTAINERS, so yes of course. :-)
> >
> > > I will go through the patches more carefully, and please look into the
> > > kbuild test robot complaint.
> >
> > I just responded to that, it seems to be a sparse problem.
> >
> > Thanks,
> > -- Marco
> 
> v4 was sent out:
> http://lkml.kernel.org/r/20191114180303.66955-1-elver@google.com

And I have queued it and pushed it to -rcu.  It is still in the section
of -rcu subject to rebasing, so if you have a later v5, I can replace
this with the newer version.

I am assuming that you do -not- wish to target the upcoming merge window
(v5.5), but rather then next one (v5.6).  Please let me know right away
if I am assuming wrong.

							Thanx, Paul
