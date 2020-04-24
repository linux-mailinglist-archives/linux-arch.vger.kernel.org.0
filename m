Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43A1B7C37
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDXQwM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 12:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgDXQwL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 12:52:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F7620728;
        Fri, 24 Apr 2020 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587747131;
        bh=lQE9T5LzPof7nBKO8GPRqY/ZDhq/5vz9BEA3Xz2iqkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwe6qKlD9HGccAzrGsOmDRlLxNKacRmL5rd1qt5514PO1CKcnllydC8GICKjA88rV
         YrLEuwlJNm/UCVAvHoBWk/GNLWbaET2ahkD7U3XfIJ6OvRM/WwTJZ4usN1lTcKcUIh
         DtEFqVHcfwAufNmZI4o2tnHzwRv8I1VOzVHvJEio=
Date:   Fri, 24 Apr 2020 17:52:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Message-ID: <20200424165204.GG21141@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
 <20200422081838.GA29541@willie-the-truck>
 <20200422113721.GA20730@hirez.programming.kicks-ass.net>
 <20200422122626.GA676@willie-the-truck>
 <20200424134238.GE21141@willie-the-truck>
 <CANpmjNP-r_18QwJcOHFtmPeGrN3gx-E=bj+_GaDYEaQ08DWgnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP-r_18QwJcOHFtmPeGrN3gx-E=bj+_GaDYEaQ08DWgnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 05:54:10PM +0200, Marco Elver wrote:
> On Fri, 24 Apr 2020 at 15:42, Will Deacon <will@kernel.org> wrote:
> > On Wed, Apr 22, 2020 at 01:26:27PM +0100, Will Deacon wrote:
> > > On Wed, Apr 22, 2020 at 01:37:21PM +0200, Peter Zijlstra wrote:
> > > > So I'm obviously all for these patches; do note however that it collides
> > > > most mighty with the KCSAN stuff, which I believe is still pending.
> > >
> > > That stuff has been pending for the last two releases afaict :/
> > >
> > > Anyway, I'm happy to either provide a branch with this series on, or do
> > > the merge myself, or send this again based on something else. What works
> > > best for you? The only thing I'd obviously like to avoid is tightly
> > > coupling this to KCSAN if there's a chance of it missing the merge window
> > > again.
> >
> > FWIW, I had a go at rebasing onto linux-next, just to get an idea for how
> > bad it is. It's fairly bad, and I don't think it's fair to inflict it on
> > sfr. I've included the interesting part of the resulting compiler.h below
> > for you and the KCSAN crowd to take a look at (yes, there's room for
> > subsequent cleanup, but I was focussing on the conflict resolution for now).
> 
> Thanks for the heads up. From what I can tell, your proposed change
> may work fine for KCSAN. However, I've had trouble compiling this:
> 
> 1. kcsan_disable_current() / kcsan_enable_current() do not work as-is,
> because READ_ONCE/WRITE_ONCE seems to be used from compilation units
> where the KCSAN runtime is not available (e.g.
> arch/x86/entry/vdso/Makefile which had to set KCSAN_SANITIZE := n for
> that reason).
> 2. Some new uaccess whitelist entries were needed.
> 
> I think this is what's needed:
> https://lkml.kernel.org/r/20200424154730.190041-1-elver@google.com
> 
> With that you can change the calls to __kcsan_disable_current() /
> __kcsan_enable_current() for READ_ONCE() and WRITE_ONCE(). After that,
> I was able to compile, and my test suite passed.

Brill, thanks Marco! I'll take a look at your other patches, but I'm pretty
stuck until we've figured out the merging plan for all of this.

Will
