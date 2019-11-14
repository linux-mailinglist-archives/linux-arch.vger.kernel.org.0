Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865F3FD0D4
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 23:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNWQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 17:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKNWQD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Nov 2019 17:16:03 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B271420709;
        Thu, 14 Nov 2019 22:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573769762;
        bh=LDvzI/ip5iI4UIoBSOL32SYOqpndu86kZkkikom9zAQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=evw1x+V8DbAMm1Q56y0Dl8nBXH4RuSVwxeqMsDfteUCdnCAMqUInQ8/2NhtcogIZ+
         xon7nkORRkUbI4++x7nww4haJsBSqgHMLJ4ZzVmMjc54kDTtedT8QMdT/6hOh7Oex2
         5vtVN19MYBPsP0sLIPE24mpdYfNsH0MiSEQ8OF60=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 87E8835227FC; Thu, 14 Nov 2019 14:15:59 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:15:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, edumazet@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191114221559.GS2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191114180303.66955-1-elver@google.com>
 <20191114195046.GP2865@paulmck-ThinkPad-P72>
 <20191114213303.GA237245@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114213303.GA237245@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 14, 2019 at 10:33:03PM +0100, Marco Elver wrote:
> On Thu, 14 Nov 2019, Paul E. McKenney wrote:
> 
> > On Thu, Nov 14, 2019 at 07:02:53PM +0100, Marco Elver wrote:
> > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > only enables KCSAN for x86, but we expect adding support for other
> > > architectures is relatively straightforward (we are aware of
> > > experimental ARM64 and POWER support).
> > > 
> > > To gather early feedback, we announced KCSAN back in September, and have
> > > integrated the feedback where possible:
> > > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > > 
> > > The current list of known upstream fixes for data races found by KCSAN
> > > can be found here:
> > > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > > 
> > > We want to point out and acknowledge the work surrounding the LKMM,
> > > including several articles that motivate why data races are dangerous
> > > [1, 2], justifying a data race detector such as KCSAN.
> > > 
> > > [1] https://lwn.net/Articles/793253/
> > > [2] https://lwn.net/Articles/799218/
> > 
> > I queued this and ran a quick rcutorture on it, which completed
> > successfully with quite a few reports.
> 
> Great. Many thanks for queuing this in -rcu. And regarding merge window
> you mentioned, we're fine with your assumption to targeting the next
> (v5.6) merge window.
> 
> I've just had a look at linux-next to check what a future rebase
> requires:
> 
> - There is a change in lib/Kconfig.debug and moving KCSAN to the
>   "Generic Kernel Debugging Instruments" section seems appropriate.
> - bitops-instrumented.h was removed and split into 3 files, and needs
>   re-inserting the instrumentation into the right places.
> 
> Otherwise there are no issues. Let me know what you recommend.

Sounds good!

I will be rebasing onto v5.5-rc1 shortly after it comes out.  My usual
approach is to fix any conflicts during that rebasing operation.
Does that make sense, or would you prefer to send me a rebased stack at
that point?  Either way is fine for me.

							Thanx, Paul
