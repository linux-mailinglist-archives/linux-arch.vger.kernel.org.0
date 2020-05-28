Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4849B1E677E
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405023AbgE1QeT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 12:34:19 -0400
Received: from foss.arm.com ([217.140.110.172]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405004AbgE1QeS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 May 2020 12:34:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A7D30E;
        Thu, 28 May 2020 09:34:17 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 165B93F305;
        Thu, 28 May 2020 09:34:15 -0700 (PDT)
Date:   Thu, 28 May 2020 17:34:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Evgenii Stepanov <eugenis@google.com>, nd@arm.com
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and
 mprotect()
Message-ID: <20200528163412.GC2961@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-12-catalin.marinas@arm.com>
 <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
 <20200528091445.GA2961@gaia>
 <20200528110509.GA18623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110509.GA18623@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 12:05:09PM +0100, Szabolcs Nagy wrote:
> The 05/28/2020 10:14, Catalin Marinas wrote:
> > On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wrote:
> > > On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > To enable tagging on a memory range, the user must explicitly opt in via
> > > > a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
> > > > memory type in the AttrIndx field of a pte, simplify the or'ing of these
> > > > bits over the protection_map[] attributes by making MT_NORMAL index 0.
> > > 
> > > Should the userspace stack always be mapped as if with PROT_MTE if the
> > > hardware supports it? Such a change would be invisible to non-MTE
> > > aware userspace since it would already need to opt in to tag checking
> > > via prctl. This would let userspace avoid a complex stack
> > > initialization sequence when running with stack tagging enabled on the
> > > main thread.
> > 
> > I don't think the stack initialisation is that difficult. On program
> > startup (can be the dynamic loader). Something like (untested):
> > 
> > 	register unsigned long stack asm ("sp");
> > 	unsigned long page_sz = sysconf(_SC_PAGESIZE);
> > 
> > 	mprotect((void *)(stack & ~(page_sz - 1)), page_sz,
> > 		 PROT_READ | PROT_WRITE | PROT_MTE | PROT_GROWSDOWN);
> > 
> > (the essential part it PROT_GROWSDOWN so that you don't have to specify
> > a stack lower limit)
> 
> does this work even if the currently mapped stack is more than page_sz?
> determining the mapped main stack area is i think non-trivial to do in
> userspace (requires parsing /proc/self/maps or similar).

Because of PROT_GROWSDOWN, the kernel adjusts the start of the range
down automatically. It is potentially problematic if the top of the
stack is more than a page away and you want the whole stack coloured. I
haven't run a test but my reading of the kernel code is that the stack
vma would be split in this scenario, so the range beyond sp+page_sz
won't have PROT_MTE set.

My assumption is that if you do this during program start, the stack is
smaller than a page. Alternatively, could we use argv or envp to
determine the top of the user stack (the bottom is taken care of by the
kernel)?

> > I'm fine, however, with enabling PROT_MTE on the main stack based on
> > some ELF note.
> 
> note that would likely mean an elf note on the dynamic linker
> (because a dynamic linked executable may not be loaded by the
> kernel and ctors in loaded libs run before the executable entry
> code anyway, so the executable alone cannot be in charge of this
> decision) i.e. one global switch for all dynamic linked binaries.

I guess parsing such note in the kernel is only useful for static
binaries.

> i think a dynamic linker can map a new stack and switch to it
> if it needs to control the properties of the stack at runtime
> (it's wasteful though).

There is already user code to check for HWCAP2_MTE and the prctl(), so
adding an mprotect() doesn't look like a significant overhead.

> and i think there should be a runtime mechanism for the brk area:
> it should be possible to request that future brk expansions are
> mapped as PROT_MTE so an mte aware malloc implementation can use
> brk. i think this is not important in the initial design, but if
> a prctl flag can do it that may be useful to add (may be at a
> later time).

Looking at the kernel code briefly, I think this would work. We do end
up with two vmas for the brk, only the expansion having PROT_MTE, and
I'd to find a way to store the extra flag.

From a coding perspective, it's easier to just set PROT_MTE by default
on both brk and initial stack ;) (VM_DATA_DEFAULT_FLAGS).

> (and eventually there should be a way to use PROT_MTE on
> writable global data and appropriate code generation that
> takes colors into account when globals are accessed, but
> that requires significant ELF, ld.so and compiler changes,
> that need not be part of the initial mte design).

The .data section needs to be driven by the ELF information. It's also a
file mapping and we don't support PROT_MTE on them even if MAP_PRIVATE.
There are complications like DAX where the file you mmap for CoW may be
hosted on memory that does not support MTE (copied to RAM on write).

Is there a use-case for global data to be tagged?

-- 
Catalin
