Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AE48A4C0
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 19:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfHLRgQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 13:36:16 -0400
Received: from foss.arm.com ([217.140.110.172]:53478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLRgQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 13:36:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99B4A15AB;
        Mon, 12 Aug 2019 10:36:15 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459F33F706;
        Mon, 12 Aug 2019 10:36:14 -0700 (PDT)
Date:   Mon, 12 Aug 2019 18:36:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190812173611.GD62772@arrakis.emea.arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
 <20190808172730.GC37129@arrakis.emea.arm.com>
 <68354acd-e205-71cb-11c6-74a150178ae0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68354acd-e205-71cb-11c6-74a150178ae0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 09, 2019 at 07:10:18AM -0700, Dave Hansen wrote:
> On 8/8/19 10:27 AM, Catalin Marinas wrote:
> > On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:
> >> Also, shouldn't this be converted over to an arch_prctl()?
> > 
> > What do you mean by arch_prctl()? We don't have such thing, apart from
> > maybe arch_prctl_spec_ctrl_*(). We achieve the same thing with the
> > {SET,GET}_TAGGED_ADDR_CTRL macros. They could be renamed to
> > arch_prctl_tagged_addr_{set,get} or something but I don't see much
> > point.
> 
> Silly me.  We have an x86-specific:
> 
> 	SYSCALL_DEFINE2(arch_prctl, int , option, unsigned long , arg2)
> 
> I guess there's no ARM equivalent so you're stuck with the generic one.
> 
> > What would be better (for a separate patch series) is to clean up
> > sys_prctl() and move the arch-specific options into separate
> > arch_prctl() under arch/*/kernel/. But it's not really for this series.
> 
> I think it does make sense for truly arch-specific features to stay out
> of the arch-generic prctl().  Yes, I know I've personally violated this
> in the past. :)

Maybe Dave M could revive his prctl() clean-up patches which moves the
arch specific cases to the corresponding arch/*/ code

> >> What is the scope of these prctl()'s?  Are they thread-scoped or
> >> process-scoped?  Can two threads in the same process run with different
> >> tagging ABI modes?
> > 
> > Good point. They are thread-scoped and this should be made clear in the
> > doc. Two threads can have different modes.
> > 
> > The expectation is that this is invoked early during process start (by
> > the dynamic loader or libc init) while in single-thread mode and
> > subsequent threads will inherit the same mode. However, other uses are
> > possible.
> 
> If that's the expectation, it would be really nice to codify it.
> Basically, you can't enable the feature if another thread is already
> been forked off.

Well, that's my expectation but I'm not a userspace developer. I don't
think there is any good reason to prevent it. It doesn't cost us
anything to support in the kernel, other than making the documentation
clearer.

> >>> +When a process has successfully enabled the new ABI by invoking
> >>> +prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
> >>> +behaviours are guaranteed:
> >>> +
> >>> +- Every currently available syscall, except the cases mentioned in section
> >>> +  3, can accept any valid tagged pointer. The same rule is applicable to
> >>> +  any syscall introduced in the future.
> >>> +
> >>> +- The syscall behaviour is undefined for non valid tagged pointers.
> >>
> >> Do you really mean "undefined"?  I mean, a bad pointer is a bad pointer.
> >>  Why should it matter if it's a tagged bad pointer or an untagged bad
> >> pointer?
> > 
> > Szabolcs already replied here. We may have tagged pointers that can be
> > dereferenced just fine but being passed to the kernel may not be well
> > defined (e.g. some driver doing a find_vma() that fails unless it
> > explicitly untags the address). It's as undefined as the current
> > behaviour (without these patches) guarantees.
> 
> It might just be nicer to point out what this features *changes* about
> invalid pointer handling, which is nothing. :)  Maybe:
> 
> 	The syscall behaviour for invalid pointers is the same for both
> 	tagged and untagged pointers.

Good point.

> >>> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> >>> +  PR_SET_MM_MAP_SIZE.
> >>> +
> >>> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
> >>> +
> >>> +Any attempt to use non-zero tagged pointers will lead to undefined
> >>> +behaviour.
> >>
> >> I wonder if you want to generalize this a bit.  I think you're saying
> >> that parts of the ABI that modify the *layout* of the address space
> >> never accept tagged pointers.
> > 
> > I guess our difficulty in specifying this may have been caused by
> > over-generalising. For example, madvise/mprotect came under the same
> > category but there is a use-case for malloc'ed pointers (and tagged) to
> > the kernel (e.g. MADV_DONTNEED). If we can restrict the meaning to
> > address space *layout* manipulation, we'd have mmap/mremap/munmap,
> > brk/sbrk, prctl(PR_SET_MM). Did I miss anything?. Other related syscalls
> > like mprotect/madvise preserve the layout while only changing permissions,
> > backing store, so the would be allowed to accept tags.
> 
> shmat() comes to mind.  I also did a quick grep for mmap_sem taken for
> write and didn't see anything else obvious jump out at me.

I'll document shmat() as not supported, together with the prctl().

As I submitted a fixup already, I propose that we allow tagged pointers
on mmap/munmap/mremap/brk. It makes the documentation simpler ;) (and
the user understanding of what is and is not allowed).

> >> It looks like the TAG_SHIFT and tag size are pretty baked into the
> >> aarch64 architecture.  But, are you confident that no future
> >> implementations will want different positions or sizes?  (obviously
> >> controlled by other TCR_EL1 bits)
> > 
> > For the top-byte-ignore (TBI), that's been baked in the architecture
> > since ARMv8.0 and we'll have to keep the backwards compatible mode. As
> > the name implies, it's the top byte of the address and that's what the
> > document above refers to.
> > 
> > With MTE, I can't exclude other configurations in the future but I'd
> > expect the kernel to present the option as a new HWCAP and the user to
> > explicitly opt in via a new prctl() flag. I seriously doubt we'd break
> > existing binaries. So, yes TAG_SHIFT may be different but so would the
> > prctl() above.
> 
> Basically, what you have is a "turn tagging on" and "turn tagging off"
> call which are binary: all on or all off.  How about exposing a mask:
> 
> 	/* Replace hard-coded mask size/position: */
> 	unsigned long mask = prctl(GET_POSSIBLE_TAGGED_ADDR_BITS);
> 
> 	if (mask == 0)
> 		// no tagging is supported obviously
> 
> 	prctl(SET_TAGGED_ADDR_BITS, mask);
> 
> 	// now userspace knows via 'mask' where the tag bits are

For the actual hardware memory tagging, maybe we could get the possible
bits but for TBI, as I said above, that's baked into the architecture. I
don't think it's worth the effort of getting a mask as I don't see ARM
changing this without breaking existing software. Even compiler support
like hwasan relies on the 8-bit TBI.

-- 
Catalin
