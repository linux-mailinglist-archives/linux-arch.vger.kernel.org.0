Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580B4209B3E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbgFYIY5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgFYIY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 04:24:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C13C061573;
        Thu, 25 Jun 2020 01:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3AMdYg8fQNUtXAfj2fZZ8NPZ9U5EFgepOOFBuun2GQY=; b=ibvgrw/6VgAeXKGL/ZvFOV5Ile
        k/DG2hTUgCNpBFh0SVRZtiOzJ0tqIzRrnNRTZQdCWgPu3f3vKwwqumEO3VAaSPjMg/ls3R3fwVjKM
        Nhs12sSgDR+t8SDyMh/h3ITlxN3ZcgcTvbI7CAd5D8YCcq8qCphd0KnXhjA+ZVPLtaGvU/eak1k++
        6iVJ/9DrfMDdhwuZ5/zvsYALWHu77JxkNZKUQ+1riHrSFoU2dIT3hgk0fU4PGeIKpR0kVxQwAc5hC
        H0eBkD5up1mt7ynRtI/herLh3Yr5SxMM5rpkTFOeHKnOBtnv2OaV3fJ7KHA9qL8uVglbMrLJEM+Gs
        wUku04xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joNBS-0000yr-J3; Thu, 25 Jun 2020 08:24:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EE4E301A7A;
        Thu, 25 Jun 2020 10:24:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 234DB2215AD45; Thu, 25 Jun 2020 10:24:33 +0200 (CEST)
Date:   Thu, 25 Jun 2020 10:24:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200625082433.GC117543@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625080313.GY4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 10:03:13AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 02:31:36PM -0700, Nick Desaulniers wrote:
> > On Wed, Jun 24, 2020 at 2:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jun 24, 2020 at 01:31:38PM -0700, Sami Tolvanen wrote:
> > > > This patch series adds support for building x86_64 and arm64 kernels
> > > > with Clang's Link Time Optimization (LTO).
> > > >
> > > > In addition to performance, the primary motivation for LTO is to allow
> > > > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > > > Pixel devices have shipped with LTO+CFI kernels since 2018.
> > > >
> > > > Most of the patches are build system changes for handling LLVM bitcode,
> > > > which Clang produces with LTO instead of ELF object files, postponing
> > > > ELF processing until a later stage, and ensuring initcall ordering.
> > > >
> > > > Note that first objtool patch in the series is already in linux-next,
> > > > but as it's needed with LTO, I'm including it also here to make testing
> > > > easier.
> > >
> > > I'm very sad that yet again, memory ordering isn't addressed. LTO vastly
> > > increases the range of the optimizer to wreck things.
> > 
> > Hi Peter, could you expand on the issue for the folks on the thread?
> > I'm happy to try to hack something up in LLVM if we check that X does
> > or does not happen; maybe we can even come up with some concrete test
> > cases that can be added to LLVM's codebase?
> 
> I'm sure Will will respond, but the basic issue is the trainwreck C11
> made of dependent loads.
> 
> Anyway, here's a link to the last time this came up:
> 
>   https://lore.kernel.org/linux-arm-kernel/20171116174830.GX3624@linux.vnet.ibm.com/

Another good read:

  https://lore.kernel.org/lkml/20150520005510.GA23559@linux.vnet.ibm.com/

and having (partially) re-read that, I now worry intensily about things
like latch_tree_find(), cyc2ns_read_begin, __ktime_get_fast_ns().

It looks like kernel/time/sched_clock.c uses raw_read_seqcount() which
deviates from the above patterns by, for some reason, using a primitive
that includes an extra smp_rmb().

And this is just the few things I could remember off the top of my head,
who knows what else is out there.
