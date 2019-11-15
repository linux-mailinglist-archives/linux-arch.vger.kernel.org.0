Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD876FDCE4
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2019 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKOMCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Nov 2019 07:02:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36413 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKOMCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Nov 2019 07:02:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so8408635oib.3
        for <linux-arch@vger.kernel.org>; Fri, 15 Nov 2019 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRytg93FU7f6sfBrcqBa/NI8/4Q9Vec4eDf1e8YsiLA=;
        b=nVJwYDJCtXWgpUbdQGvyEnuFLUcgdoMeKxiPthFRXCdtZdTeFIDBqKZ6+bNhKMXARK
         FiuRwf09ZIePoP7o/Ki7Hfnl+pJjquU+FvzRQG4URKaKiWDYzrj+CImuhHJEJ2NcFIIn
         mpboR/iTkoBaC8CDx8OxDvhdd72HtlFQl9ugHgGSp3pFy8Jdcdj3EjJAV3NcXjs4jBGG
         HcWRqotcj1x+8mz1un8uwKWvI1p5uNiUwHjldbs8fjcRCwN5wBTM7BvtzXYUp0JF//Dd
         7I+pJyMn6PlWTucSGO3aGtxcpZVvuzFq6Q9pu+lqZ+6Jy9GBjB21YirKDhsibmAdtSdW
         QtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRytg93FU7f6sfBrcqBa/NI8/4Q9Vec4eDf1e8YsiLA=;
        b=e/0tFDH2ooe5uBpOBfGAD6U0rcsQRe6jh+rf/i4j9viOgdGN+iM94wVCtB6VXu3uKR
         zCAXjdTWkXvts+tD3Cz+0QCKjSKRowP8iwYRPapDHzgHbPTXxYa7b9a5HO8ijFyFoyDG
         qsWcg+zLa2BvFuV/2hPBNcj4XpWyQOJ5TOzwpLtNgup2dECXNv5E9lFapFxBdeIjLLEa
         hQoV/9+XF/+kcijX8w0GYsPwoMn8IJKmQSMheuEpcWEtlFkBc3jxnyw31Ym2B/qOO1rO
         NoxHDrUK8P6rbFAfg1gG5TYeGKZVr4phSQjwdmO/b9yMrSfTN67jrYlH9p428F7o6FUn
         leHA==
X-Gm-Message-State: APjAAAVoEH0qU8WMtqlUPzLpxHEeSBNSxZpayWkHqkcwfnz5y2uWkZMz
        uDCcoLl2DFzBHd9LAxGZdOCddsubYmP9YSzwKIV/Mw==
X-Google-Smtp-Source: APXvYqx6zqcXYMp7eFJA/krQ5decJuNJdJO30uNxuNlyEY/pcLWFYr8pgT33say7KL4tYPQxYL+H1c4MsqJbhx+1xvc=
X-Received: by 2002:aca:5413:: with SMTP id i19mr7842386oib.121.1573819340279;
 Fri, 15 Nov 2019 04:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191114180303.66955-1-elver@google.com> <20191114195046.GP2865@paulmck-ThinkPad-P72>
 <20191114213303.GA237245@google.com> <20191114221559.GS2865@paulmck-ThinkPad-P72>
In-Reply-To: <20191114221559.GS2865@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Fri, 15 Nov 2019 13:02:08 +0100
Message-ID: <CANpmjNPxAOUAxXHd9tka5gCjR_rNKmBk+k5UzRsXT0a0CtNorw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Nov 2019 at 23:16, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Nov 14, 2019 at 10:33:03PM +0100, Marco Elver wrote:
> > On Thu, 14 Nov 2019, Paul E. McKenney wrote:
> >
> > > On Thu, Nov 14, 2019 at 07:02:53PM +0100, Marco Elver wrote:
> > > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > > only enables KCSAN for x86, but we expect adding support for other
> > > > architectures is relatively straightforward (we are aware of
> > > > experimental ARM64 and POWER support).
> > > >
> > > > To gather early feedback, we announced KCSAN back in September, and have
> > > > integrated the feedback where possible:
> > > > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > > >
> > > > The current list of known upstream fixes for data races found by KCSAN
> > > > can be found here:
> > > > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > > >
> > > > We want to point out and acknowledge the work surrounding the LKMM,
> > > > including several articles that motivate why data races are dangerous
> > > > [1, 2], justifying a data race detector such as KCSAN.
> > > >
> > > > [1] https://lwn.net/Articles/793253/
> > > > [2] https://lwn.net/Articles/799218/
> > >
> > > I queued this and ran a quick rcutorture on it, which completed
> > > successfully with quite a few reports.
> >
> > Great. Many thanks for queuing this in -rcu. And regarding merge window
> > you mentioned, we're fine with your assumption to targeting the next
> > (v5.6) merge window.
> >
> > I've just had a look at linux-next to check what a future rebase
> > requires:
> >
> > - There is a change in lib/Kconfig.debug and moving KCSAN to the
> >   "Generic Kernel Debugging Instruments" section seems appropriate.
> > - bitops-instrumented.h was removed and split into 3 files, and needs
> >   re-inserting the instrumentation into the right places.
> >
> > Otherwise there are no issues. Let me know what you recommend.
>
> Sounds good!
>
> I will be rebasing onto v5.5-rc1 shortly after it comes out.  My usual
> approach is to fix any conflicts during that rebasing operation.
> Does that make sense, or would you prefer to send me a rebased stack at
> that point?  Either way is fine for me.

That's fine with me, thanks!  To avoid too much additional churn on
your end, I just replied to the bitops patch with a version that will
apply with the change to bitops-instrumented infrastructure.

Also considering the merge window, we had a discussion and there are
some arguments for targeting the v5.5 merge window:
- we'd unblock ARM and POWER ports;
- we'd unblock people wanting to use the data_race macro;
- we'd unblock syzbot just tracking upstream;
Unless there are strong reasons to not target v5.5, I leave it to you
if you think it's appropriate.

Thanks,
-- Marco
