Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7944114985E
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jan 2020 02:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAZBKI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 20:10:08 -0500
Received: from foss.arm.com ([217.140.110.172]:33808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAZBKI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Jan 2020 20:10:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2644328;
        Sat, 25 Jan 2020 17:10:07 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15573F68E;
        Sat, 25 Jan 2020 17:10:05 -0800 (PST)
Date:   Sun, 26 Jan 2020 01:10:03 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Message-ID: <20200126010959.vhq7mg4esoq5w26j@e107158-lin.cambridge.arm.com>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck>
 <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
 <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
 <20200123190125.GA2683468@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123190125.GA2683468@rani.riverdale.lan>
User-Agent: NeoMutt/20171215
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01/23/20 14:01, Arvind Sankar wrote:
> On Thu, Jan 23, 2020 at 10:45:08AM -0800, Nick Desaulniers wrote:
> > On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Will Deacon
> > > > Sent: 23 January 2020 17:17
> > > >
> > > > I think it depends how much we care about those older compilers. My series
> > > > first moves it to "Good luck mate, you're on your own" and then follows up
> > 
> > I wish the actual warning was worded that way. :P
> > 
> > > > with a "Let me take that off you it's sharp".
> > 
> > > Oh - and I need to find a newer compiler :-(
> > 
> > What distro are you using? Does it have a package for a newer
> > compiler?  I'm honestly curious about what policies if any the kernel
> > has for supporting developer's toolchains from their distributions.
> > (ie. Arnd usually has pretty good stats what distro's use which
> > version of GCC and are still supported; Do we strive to not break
> > them? Is asking kernel devs to compile their own toolchain too much to
> > ask?  Is it still if they're using really old distro's/toolchains that
> > we don't want to support?  Do we survey kernel devs about what they're
> > using?).  Apologies if this is already documented somewhere, but if
> > not I'd eventually like to brainstorm and write it down somewhere in
> > the tree.  Documentation/process/changes.rst doesn't really answer the
> > above questions, I think.
> > 
> > -- 
> > Thanks,
> > ~Nick Desaulniers
> 
> Reposting Arnd's link
> https://www.spinics.net/lists/linux-kbuild/msg23648.html

This list seems to be x86 centric? I remember when the switch to GCC 4.6
happened a couple or more archs had to be dropped because they lacked a newer
compiler.

So popular archs would probably have moved quickly, but 'niche' ones might
still be catching up at a slower pace.

--
Qais Yousef
