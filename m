Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0813B51C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 23:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANWJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 17:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANWJH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 17:09:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E4324656;
        Tue, 14 Jan 2020 22:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579039746;
        bh=ECleuj4dTD+b2BCowdnKaPUSRFlF08Qh0VJWKgnNCmk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eHTtZBZKOoGJ5TnBdVzafZ9IqoFNKO1oyUzy7DkBMs5u7spsmQX66h41FXlba/RCj
         fFKn8Z+WQsZgNBLOf31Xev+rUXAqnIZjrdygfiGaNerFjb2nayD5CpA9N2FqLiWSlt
         4xKRdwLbAL8ghkcGFgHLf5OyEGHIfOqC//FDPdds=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6CBEA3522755; Tue, 14 Jan 2020 14:09:06 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:09:06 -0800
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
Message-ID: <20200114220906.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200114213405.GX2935@paulmck-ThinkPad-P72>
 <9970E373-DF70-4FE4-A839-AAE641612EC5@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9970E373-DF70-4FE4-A839-AAE641612EC5@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 04:48:22PM -0500, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 4:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > As an alternative, once the patches needed for your tests to pass
> > reach mainline, you could announce that KCSAN was ready to be enabled
> > in distros.
> > 
> > Though I confess that I don't know how that works.  Is there a separate
> > testing kernel binary provided by the distros in question?
> 
> I don’t think I have powers to announce that. Once the feature hit the mainline, distro people could start to use in the debug kernel variant, and it is a shame to only find out it is broken. Anyway, I’ll try to edge out those corner cases. Stay tuned.

Very good, thank you!

And you do have the power to announce.  But just like most of the rest
of use, myself included, you won't always have the power to make people
actually pay attention to what you say.  ;-)

							Thanx, Paul
