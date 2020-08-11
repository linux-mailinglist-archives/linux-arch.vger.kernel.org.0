Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36BF241F12
	for <lists+linux-arch@lfdr.de>; Tue, 11 Aug 2020 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgHKRUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Aug 2020 13:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgHKRUo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 13:20:44 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9FA20756;
        Tue, 11 Aug 2020 17:20:40 +0000 (UTC)
Date:   Tue, 11 Aug 2020 18:20:38 +0100
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
Message-ID: <20200811172038.GB1429@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810141309.GK14398@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 10, 2020 at 03:13:09PM +0100, Szabolcs Nagy wrote:
> The 08/07/2020 16:19, Catalin Marinas wrote:
> > On Mon, Aug 03, 2020 at 01:43:10PM +0100, Szabolcs Nagy wrote:
> > > if we can always turn sync tag checks on early whenever mte is
> > > available then i think there is no issue.
> > > 
> > > but if we have to make the decision later for compatibility or
> > > performance reasons then per thread setting is problematic.
> > 
> > At least for libc, I'm not sure how you could even turn MTE on at
> > run-time. The heap allocations would have to be mapped with PROT_MTE as
> > we can't easily change them (well, you could mprotect(), assuming the
> > user doesn't use tagged pointers on them).
> 
> e.g. dlopen of library with stack tagging. (libc can mark stacks with
> PROT_MTE at that time)

If we allow such mixed object support with stack tagging enabled at
dlopen, PROT_MTE would need to be turned on for each thread stack. This
wouldn't require synchronisation, only knowing where the thread stacks
are, but you'd need to make sure threads don't call into the new library
until the stacks have been mprotect'ed. Doing this midway through a
function execution may corrupt the tags.

So I'm not sure how safe any of this is without explicit user
synchronisation (i.e. don't call into the library until all threads have
been updated). Even changing options like GCR_EL1.Excl across multiple
threads may have unwanted effects. See this comment from Peter, the
difference being that instead of an explicit prctl() call on the current
stack, another thread would do it:

https://lore.kernel.org/linux-arch/CAMn1gO5rhOG1W+nVe103v=smvARcFFp_Ct9XqH2Ca4BUMfpDdg@mail.gmail.com/

> or just turn on sync tag checks later when using heap tagging.

I wonder whether setting the synchronous tag check mode by default would
improve this aspect. This would not have any effect until PROT_MTE is
used. If software wants some better performance they can explicitly opt
in to asynchronous mode or disable tag checking after some SIGSEGV +
reporting (this shouldn't exclude the environment variables you
currently use for controlling the tag check mode).

Also, if there are saner defaults for the user GCR_EL1.Excl (currently
all masked), we should decide them now.

If stack tagging will come with some ELF information, we could make the
default tag checking and GCR_EL1.Excl choices based on that, otherwise
maybe we should revisit the default configuration the kernel sets for
the user in the absence of any other information.

> > There is a case to switch tag checking from asynchronous to synchronous
> > at run-time based on a signal but that's rather specific to Android
> > where zygote controls the signal handler. I don't think you can do this
> > with libc. Even on Android, since the async fault signal is delivered
> > per thread, it probably does this lazily (alternatively, it could issue
> > a SIGUSRx to the other threads for synchronisation).
> 
> i think what that zygote is doing is a valid use-case but
> in a normal linux setup the application owns the signal
> handlers so the tag check switch has to be done by the
> application. the libc can expose some api for it, so in
> principle it's enough if the libc can do the runtime
> switch, but we dont plan to add new libc apis for mte.

Due to the synchronisation aspect especially regarding the stack
tagging, I'm not sure the kernel alone can safely do this.

Changing the tagged address syscall ABI across multiple threads should
be safer (well, at least the relaxing part). But if we don't solve the
other aspects I mentioned above, I don't think there is much point in
only doing it for this.

> > > - library code normally initializes per thread state on the first call
> > >   into the library from a given thread, but with mte, as soon as
> > >   memory / pointers are tagged in one thread, all threads are
> > >   affected: not performing checks in other threads is less secure (may
> > >   be ok) and it means incompatible syscall abi (not ok). so at least
> > >   PR_TAGGED_ADDR_ENABLE should have process wide setting for this
> > >   usage.
> > 
> > My assumption with MTE is that the libc will initialise it when the
> > library is loaded (something __attribute__((constructor))) and it's
> > still in single-threaded mode. Does it wait until the first malloc()
> > call? Also, is there such thing as a per-thread initialiser for a
> > dynamic library (not sure it can be implemented in practice though)?
> 
> there is no per thread initializer in an elf module.
> (tls state is usually initialized lazily in threads
> when necessary.)
> 
> malloc calls can happen before the ctors of an LD_PRELOAD
> library and threads can be created before both.
> glibc runs ldpreload ctors after other library ctors.

In the presence of stack tagging, I think any subsequent MTE config
change across all threads is unsafe, irrespective of whether it's done
by the kernel or user via SIGUSRx. I think the best we can do here is
start with more appropriate defaults or enable them based on an ELF note
before the application is started. The dynamic loader would not have to
do anything extra here.

If we ignore stack tagging, the global configuration change may be
achievable. I think for the MTE bits, this could be done lazily by the
libc (e.g. on malloc()/free() call). The tag checking won't happen
before such calls unless we change the kernel defaults. There is still
the tagged address ABI enabling, could this be done lazily on syscall by
the libc? If not, the kernel could synchronise (force) this on syscall
entry from each thread based on some global prctl() bit.

-- 
Catalin
