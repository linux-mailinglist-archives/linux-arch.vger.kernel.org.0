Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91858209B99
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbgFYI6U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390330AbgFYI6T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 04:58:19 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FAC061573;
        Thu, 25 Jun 2020 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oaHjYuJa/3zuClzIH+/g+fhPoe4mw4jvJXlUfLpBRwo=; b=dhVJmH7iCebSecH6ztLVh/a9AX
        q/FRl+8k3rSxsroM7W9JVbb4ruGWGY7b3ylToiN3VKMgxN8q00TRkiBpCp8haU8MShPGRK/s8jkgg
        w3YBszL7uKIGNLBTLhESs/x80y6d0palNb62gZGEGSMiegKRbb9GXJ9f1wHqqmzeO1jX7JiN9/HsX
        aTa1JqeZNh93t14b58sd/SSqgpOlSZ8pEHH5Qo6ELxJU7Vf2AGwoPRrjAW1izwzD6GTzOsKkAJ0LL
        Ve/bAcUlLidRSKJGMMkj+0+VwBHrbE7cgi6LsUKtOByycYPJrSQmUl57IXr4MTgW/JLH3ka/h2HLc
        xcYWPkgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joNhc-0003bQ-FK; Thu, 25 Jun 2020 08:57:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE9DA3003E5;
        Thu, 25 Jun 2020 10:57:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA33E2010773D; Thu, 25 Jun 2020 10:57:45 +0200 (CEST)
Date:   Thu, 25 Jun 2020 10:57:45 +0200
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
Message-ID: <20200625085745.GD117543@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625082433.GC117543@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 10:24:33AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 10:03:13AM +0200, Peter Zijlstra wrote:

> > I'm sure Will will respond, but the basic issue is the trainwreck C11
> > made of dependent loads.
> > 
> > Anyway, here's a link to the last time this came up:
> > 
> >   https://lore.kernel.org/linux-arm-kernel/20171116174830.GX3624@linux.vnet.ibm.com/
> 
> Another good read:
> 
>   https://lore.kernel.org/lkml/20150520005510.GA23559@linux.vnet.ibm.com/
> 
> and having (partially) re-read that, I now worry intensily about things
> like latch_tree_find(), cyc2ns_read_begin, __ktime_get_fast_ns().
> 
> It looks like kernel/time/sched_clock.c uses raw_read_seqcount() which
> deviates from the above patterns by, for some reason, using a primitive
> that includes an extra smp_rmb().
> 
> And this is just the few things I could remember off the top of my head,
> who knows what else is out there.

As an example, let us consider __ktime_get_fast_ns(), the critical bit
is:

		seq = raw_read_seqcount_latch(&tkf->seq);
		tkr = tkf->base + (seq & 0x01);
		now = tkr->base;

And we hard rely on that being a dependent load, so:

  LOAD	seq, (tkf->seq)
  LOAD  tkr, tkf->base
  AND   seq, 1
  MUL   seq, sizeof(tk_read_base)
  ADD	tkr, seq
  LOAD  now, (tkr->base)

Such that we obtain 'now' as a direct dependency on 'seq'. This ensures
the loads are ordered.

A compiler can wreck this by translating it into something like:

  LOAD	seq, (tkf->seq)
  LOAD  tkr, tkf->base
  AND   seq, 1
  CMP	seq, 0
  JE	1f
  ADD	tkr, sizeof(tk_read_base)
1:
  LOAD  now, (tkr->base)

Because now the machine can speculate and load now before seq, breaking
the ordering.
