Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749E1274705
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVQzf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Sep 2020 12:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVQzf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Sep 2020 12:55:35 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332952071A;
        Tue, 22 Sep 2020 16:55:32 +0000 (UTC)
Date:   Tue, 22 Sep 2020 17:55:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200922165529.GH15643@gaia>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
 <20200922155248.GA16385@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922155248.GA16385@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Szabolcs,

On Tue, Sep 22, 2020 at 04:52:49PM +0100, Szabolcs Nagy wrote:
> The 09/17/2020 10:02, Catalin Marinas wrote:
> > On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> > > On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> > > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ...
> > > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > 
> > > I'm taking this to mean that Szabolcs is happy with the proposed ABI --
> > > please shout if that's not the case!
> > 
> > I think Szabolcs is still on holiday. To summarise the past threads,
> > AFAICT he's happy with this per-thread control ABI but the discussion
> > went on whether to expand it in the future (with a new bit) to
> > synchronise the tag checking mode across all threads of a process. This
> > adds some complications for the kernel as it needs an IPI to the other
> > CPUs to set SCTLR_EL1 and it's also racy with multiple threads
> > requesting different modes.
> > 
> > Now, in the glibc land, if the tag check mode is controlled via
> > environment variables, the dynamic loader can set this at process start
> > while still in single-threaded mode and not touch it at run-time. The
> > MTE checking can still be enabled at run-time, per mapped memory range
> > via the PROT_MTE flag. This approach doesn't require any additional
> > changes to the current patches. But it's for Szabolcs to confirm once
> > he's back.
> 
> my thinking now is that for PROT_MTE use outside of libc we will need
> a way to enable tag checks early so user code does not have to worry
> about tag check settings across threads (coordinating the setting at
> runtime seems problematic, same for the irg exclusion set).

Yeah, such settings are better set at process start time.

We can explore synchronising across threads with an additional PR_* flag
but given the interaction with stack tagging and other potential races,
it will need better coordination with user space and agree on which
settings can be changed (e.g. exclusion mask may not be allowed).
However, at this point, I don't see a strong case for such ABI addition
as long as the application starts with some sane defaults, potentially
driven by the user.

> if we add a kernel level opt-in mechanism for tag checks later (e.g.
> elf marking) or if the settings are exclusively owned by early libc
> code then i think the proposed abi is ok (this is our current
> agreement and works as long as no late runtime change is needed to the
> settings).

In the Android case, run-time changes to the tag checking mode I think
are expected (usually via signal handlers), though per-thread.

> i'm now wondering about the default tag check mode: it may be better
> to enable sync tag checks in the kernel. it's not clear to me what
> would break with that. this is probably late to discuss now and libc
> would need ways to override the default no matter what, but i'd like
> to know if somebody sees problems or risks with unconditional sync tag
> checks turned on (sorry i don't remember if we went through this
> before). i assume it would have no effect on a process that never uses
> PROT_MTE.

I don't think it helps much. We already have a requirement that to be
able to pass tagged pointers to kernel syscalls, the user needs a
prctl(PR_TAGGED_ADDR_ENABLE) call (code already in mainline). Using
PROT_MTE without tagged pointers won't be of much use. So if we are to
set different tag check defaults, we should also enable the tagged addr
ABI automatically.

That said, I still have a preference for MTE and tagged addr ABI to be
explicitly requested by the (human) user either via environment
variables or marked in an ELF note as "safe with/using tags". Given the
recent mremap() issue we caused in glibc, I'm worried that other things
may break with enabling the tagged addr ABI everywhere.

Another aspect is that sync mode by default in a distro where glibc is
MTE-aware will lead to performance regressions. That's another case in
favour of the user explicitly asking for tag checking.

Anyway, I'm open to having a debate on changing the defaults.

-- 
Catalin
