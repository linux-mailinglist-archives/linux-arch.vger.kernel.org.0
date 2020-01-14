Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA913B46E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgANVeH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVeH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 16:34:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F3924656;
        Tue, 14 Jan 2020 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579037645;
        bh=N2S7y+O790zET1Gmtmsm8tuXTXxczW82v07Ij9f4etg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E19ztN87s0hx9TSeFhbYpD4KDYFnyV2gto/gqjaKAfYjz7c5aXHcsklLFATfRh40W
         Krlsmw3JOJcH2iti5LhYFL3x8wnsI4XrND8lAwIc7zpyl15esGA5KHG4rQs7yW5iyD
         XuiqPr1+p+/FgPX/3BzIPVbdApiWI0BuJYOa6yYg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 597AF3522755; Tue, 14 Jan 2020 13:34:05 -0800 (PST)
Date:   Tue, 14 Jan 2020 13:34:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
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
        Mark Rutland <Mark.Rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20200114213405.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200114192220.GS2935@paulmck-ThinkPad-P72>
 <F185919B-2D86-43B6-9BEC-D14D72871A58@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F185919B-2D86-43B6-9BEC-D14D72871A58@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 03:30:53PM -0500, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 2:22 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > Just so I understand...  Does this problem happen even in CONFIG_KCSAN=n
> > kernels?
> 
> No.

Whew!!!  ;-)

> > I have been running extensive CONFIG_KSCAN=y rcutorture tests for quite
> > awhile now, so even if this only happens for CONFIG_KSCAN=y, it is not
> > like it affects everyone.
> > 
> > Yes, it should be fixed, and Marco does have a patch on the way.
> 
> The concern is really about setting KSCAN=y in a distro debug kernel where it has other debug options. I’ll try to dig into more of those issues in the next few days.

Understood.  But there are likely to be other issues with KCSAN, given how
new it is.  Yes, yes, I certainly would like to believe that the patches
we currently know about will make KCSAN perfect for distros, I have way
too much grey hair (and too little hair as well!) to really beleive that.

As an alternative, once the patches needed for your tests to pass
reach mainline, you could announce that KCSAN was ready to be enabled
in distros.

Though I confess that I don't know how that works.  Is there a separate
testing kernel binary provided by the distros in question?

							Thanx, Paul
