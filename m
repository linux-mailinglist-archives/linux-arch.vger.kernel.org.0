Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5642499B0
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHSJzE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 05:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgHSJzD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Aug 2020 05:55:03 -0400
Received: from DESKTOP-O1885NU.localdomain (host31-51-102-47.range31-51.btcentralplus.com [31.51.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8BE20786;
        Wed, 19 Aug 2020 09:55:00 +0000 (UTC)
Date:   Wed, 19 Aug 2020 10:54:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200819095453.GA86@DESKTOP-O1885NU.localdomain>
References: <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com>
 <20200811172038.GB1429@gaia>
 <20200812124520.GP14398@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812124520.GP14398@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 12, 2020 at 01:45:21PM +0100, Szabolcs Nagy wrote:
> On 08/11/2020 18:20, Catalin Marinas wrote:
> > If we allow such mixed object support with stack tagging enabled at
> > dlopen, PROT_MTE would need to be turned on for each thread stack. This
> > wouldn't require synchronisation, only knowing where the thread stacks
> > are, but you'd need to make sure threads don't call into the new library
> > until the stacks have been mprotect'ed. Doing this midway through a
> > function execution may corrupt the tags.
> > 
> > So I'm not sure how safe any of this is without explicit user
> > synchronisation (i.e. don't call into the library until all threads have
> > been updated). Even changing options like GCR_EL1.Excl across multiple
> > threads may have unwanted effects. See this comment from Peter, the
> > difference being that instead of an explicit prctl() call on the current
> > stack, another thread would do it:
> > 
> > https://lore.kernel.org/linux-arch/CAMn1gO5rhOG1W+nVe103v=smvARcFFp_Ct9XqH2Ca4BUMfpDdg@mail.gmail.com/
> 
> there is no midway problem: the libc (ld.so) would do the PROT_MTE at
> dlopen time based on some elf marking (which can be handled before
> relocation processing, so before library code can run, the midway
> problem happens when a library, e.g libc, wants to turn on stack
> tagging on itself).

OK, that makes sense, you can't call into the new object until the
relocations have been resolved.

> the libc already does this when a library is loaded that requires
> executable stack (it marks stacks as PROT_EXEC at dlopen time or fails
> the dlopen if that is not possible, this does not require running code
> in other threads, only synchronization with thread creation and exit.
> but changing the check mode for mte needs per thread code execution.).
> 
> i'm not entirely sure if this is a good idea, but i expect stack
> tagging not to be used in the libc (because libc needs to run on all
> hw and we don't yet have a backward compatible stack tagging
> solution),

In theory, you could have two libc deployed in your distro and ldd gets
smarter to pick the right one. I still hope we'd find a compromise with
stack tagging and single binary.

> so stack tagging should work when only some elf modules in a process
> are built with it, which implies that enabling it at dlopen time
> should work otherwise it will not be very useful.

There is still the small risk of an old object using tagged pointers to
the stack. Since the stack would be shared between such objects, turning
PROT_MTE on would cause issues. Hopefully such problems are minor and
not really a concern for the kernel.

> do tag checks have overhead if PROT_MTE is not used? i'd expect some
> checks are still done at memory access. (and the tagged address
> syscall abi has to be in use.)

My understanding from talking to hardware engineers is that there won't
be an overhead if PROT_MTE is not used, no tags being fetched or
checked. But I can't guarantee until we get real silicon.

> turning sync tag checks on early would enable the most of the
> interesting usecases (only PROT_MTE has to be handled at runtime not
> the prctls. however i don't yet know how userspace will deal with
> compat issues, i.e. it may not be valid to unconditionally turn tag
> checks on early).

If we change the defaults so that no prctl() is required for the
standard use-case, it would solve most of the common deployment issues:

1. Tagged address ABI default on when HWCAP2_MTE is present
2. Synchronous TCF by default
3. GCR_EL1.Excl allows all tags except 0 by default

Any other configuration diverging from the above is considered
specialist deployment and will have to issue the prctl() on a per-thread
basis.

Compat issues in user-space will be dealt with via environment
variables but pretty much on/off rather than fine-grained tag checking
mode. So for glibc, you'd have only _MTAG=0 or 1 and the only effect is
using PROT_MTE + tagged pointers or no-PROT_MTE + tag 0.

> > In the presence of stack tagging, I think any subsequent MTE config
> > change across all threads is unsafe, irrespective of whether it's done
> > by the kernel or user via SIGUSRx. I think the best we can do here is
> > start with more appropriate defaults or enable them based on an ELF note
> > before the application is started. The dynamic loader would not have to
> > do anything extra here.
> > 
> > If we ignore stack tagging, the global configuration change may be
> > achievable. I think for the MTE bits, this could be done lazily by the
> > libc (e.g. on malloc()/free() call). The tag checking won't happen
> > before such calls unless we change the kernel defaults. There is still
> > the tagged address ABI enabling, could this be done lazily on syscall by
> > the libc? If not, the kernel could synchronise (force) this on syscall
> > entry from each thread based on some global prctl() bit.
> 
> i think the interesting use-cases are all about changing mte settings
> before mte is in use in any way but after there are multiple threads.
> (the async -> sync mode change on tag faults is i think less
> interesting to the gnu linux world.)

So let's consider async/sync/no-check specialist uses and glibc would
not have to handle them. I don't think async mode is useful on its own
unless you have a way to turn on sync mode at run-time for more precise
error identification (well, hoping that it will happen again).

> i guess lazy syscall abi switch works, but it is ugly: raw syscall
> usage will be problematic and doing checks before calling into the
> vdso might have unwanted overhead.

This lazy ABI switch could be handled by the kernel, though I wonder
whether we should just relax it permanently when HWCAP2_MTE is present.

-- 
Catalin
