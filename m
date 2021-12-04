Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1624681BA
	for <lists+linux-arch@lfdr.de>; Sat,  4 Dec 2021 02:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354451AbhLDBRd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 20:17:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40288 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhLDBRc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 20:17:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD7D962C49;
        Sat,  4 Dec 2021 01:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5BBC341C0;
        Sat,  4 Dec 2021 01:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638580447;
        bh=kRPrcbb3nkeObkhB2Ul95O5vYzXbYXpVb4wpEsKiNVc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=asnsLpkfGW5B54GACNHa2REYpExvXo3jNQ4EzyiqY9fIDmXOokZp/AMwEF7YcYXGW
         J8rcFwR136OkR1mDFfI5tK1iF2VnKrRg67c7Fkhhhq+PAAWrDRuDzePKnaqzeJaFwx
         D31IIJZsGAwGModqVdPAu/5OeU/FQhees9dpw+cd+mqaAkEToGBzas+PeGXavv55Es
         gdkbRgbN7w7ofg7j2MrXsphLHSFuXHSbGuVaFiOylZMEbKYKnwpA11NiAdRE4ks55Q
         lGMpvyoV0WhI0w44MpU1Up2oDzSSzN8F34t5VEqJCarJ/wJ+AbIeOMyGOGhk1vFQDx
         +mgF/49mE0sgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F26E45C0F91; Fri,  3 Dec 2021 17:14:06 -0800 (PST)
Date:   Fri, 3 Dec 2021 17:14:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 04/25] kcsan: Add core support for a subset of weak
 memory modeling
Message-ID: <20211204011406.GU641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-5-elver@google.com>
 <YanbzWyhR0LwdinE@elver.google.com>
 <20211203165020.GR641268@paulmck-ThinkPad-P17-Gen-1>
 <20211203210856.GA712591@paulmck-ThinkPad-P17-Gen-1>
 <20211203234218.GA3308268@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNNUinNdBBOVbAgQQYCJVftgUfQQZyPSchWhyVRyjWpedA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNUinNdBBOVbAgQQYCJVftgUfQQZyPSchWhyVRyjWpedA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 04, 2021 at 12:45:30AM +0100, Marco Elver wrote:
> On Sat, 4 Dec 2021 at 00:42, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > And to further extend this bug report, the following patch suppresses
> > the error.
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit d157b802f05bd12cf40bef7a73ca6914b85c865e
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Dec 3 15:35:29 2021 -0800
> >
> >     kcsan: selftest: Move test spinlock to static global
> 
> Indeed, that will fix the selftest. The kcsan_test has the same
> problem (+1 extra problem).
> 
> We raced sending the fix. :-)
> I hope this patch works for you:
> https://lkml.kernel.org/r/20211203233817.2815340-1-elver@google.com

I replaced my patch with yours and am starting up testing, thank you!

							Thanx, Paul
