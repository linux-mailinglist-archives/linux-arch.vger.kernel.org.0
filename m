Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB21B87C59
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2019 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfHIOKV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Aug 2019 10:10:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:7130 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIOKU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Aug 2019 10:10:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 07:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="182917945"
Received: from devajeet-mobl2.amr.corp.intel.com (HELO [10.251.27.22]) ([10.251.27.22])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2019 07:10:19 -0700
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
 <20190808172730.GC37129@arrakis.emea.arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <68354acd-e205-71cb-11c6-74a150178ae0@intel.com>
Date:   Fri, 9 Aug 2019 07:10:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808172730.GC37129@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/8/19 10:27 AM, Catalin Marinas wrote:
> On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:
> Extending the interface is still possible even with the current
> proposal, by changing arg2 etc. We also don't seem to be consistent in
> sys_prctl().

We are not consistent because it took a long time to learn this lesson,
but I think this is a best-practice that we follow for new ones.

>> Also, shouldn't this be converted over to an arch_prctl()?
> 
> What do you mean by arch_prctl()? We don't have such thing, apart from
> maybe arch_prctl_spec_ctrl_*(). We achieve the same thing with the
> {SET,GET}_TAGGED_ADDR_CTRL macros. They could be renamed to
> arch_prctl_tagged_addr_{set,get} or something but I don't see much
> point.

Silly me.  We have an x86-specific:

	SYSCALL_DEFINE2(arch_prctl, int , option, unsigned long , arg2)

I guess there's no ARM equivalent so you're stuck with the generic one.

> What would be better (for a separate patch series) is to clean up
> sys_prctl() and move the arch-specific options into separate
> arch_prctl() under arch/*/kernel/. But it's not really for this series.

I think it does make sense for truly arch-specific features to stay out
of the arch-generic prctl().  Yes, I know I've personally violated this
in the past. :)

>> What is the scope of these prctl()'s?  Are they thread-scoped or
>> process-scoped?  Can two threads in the same process run with different
>> tagging ABI modes?
> 
> Good point. They are thread-scoped and this should be made clear in the
> doc. Two threads can have different modes.
> 
> The expectation is that this is invoked early during process start (by
> the dynamic loader or libc init) while in single-thread mode and
> subsequent threads will inherit the same mode. However, other uses are
> possible.

If that's the expectation, it would be really nice to codify it.
Basically, you can't enable the feature if another thread is already
been forked off.

> That said, do we have a precedent for changing user ABI from the kernel
> cmd line? 'noexec32', 'vsyscall' I think come close. With the prctl()
> for opt-in, controlling this from the cmd line is not too bad (though my
> preference is still for the sysctl).

There are certainly user-visible things like being able to select
various CPU features.

>>> +When a process has successfully enabled the new ABI by invoking
>>> +prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
>>> +behaviours are guaranteed:
>>> +
>>> +- Every currently available syscall, except the cases mentioned in section
>>> +  3, can accept any valid tagged pointer. The same rule is applicable to
>>> +  any syscall introduced in the future.
>>> +
>>> +- The syscall behaviour is undefined for non valid tagged pointers.
>>
>> Do you really mean "undefined"?  I mean, a bad pointer is a bad pointer.
>>  Why should it matter if it's a tagged bad pointer or an untagged bad
>> pointer?
> 
> Szabolcs already replied here. We may have tagged pointers that can be
> dereferenced just fine but being passed to the kernel may not be well
> defined (e.g. some driver doing a find_vma() that fails unless it
> explicitly untags the address). It's as undefined as the current
> behaviour (without these patches) guarantees.

It might just be nicer to point out what this features *changes* about
invalid pointer handling, which is nothing. :)  Maybe:

	The syscall behaviour for invalid pointers is the same for both
	tagged and untagged pointers.

>>> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
>>> +  PR_SET_MM_MAP_SIZE.
>>> +
>>> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
>>> +
>>> +Any attempt to use non-zero tagged pointers will lead to undefined
>>> +behaviour.
>>
>> I wonder if you want to generalize this a bit.  I think you're saying
>> that parts of the ABI that modify the *layout* of the address space
>> never accept tagged pointers.
> 
> I guess our difficulty in specifying this may have been caused by
> over-generalising. For example, madvise/mprotect came under the same
> category but there is a use-case for malloc'ed pointers (and tagged) to
> the kernel (e.g. MADV_DONTNEED). If we can restrict the meaning to
> address space *layout* manipulation, we'd have mmap/mremap/munmap,
> brk/sbrk, prctl(PR_SET_MM). Did I miss anything?. Other related syscalls
> like mprotect/madvise preserve the layout while only changing permissions,
> backing store, so the would be allowed to accept tags.

shmat() comes to mind.  I also did a quick grep for mmap_sem taken for
write and didn't see anything else obvious jump out at me.

>> It looks like the TAG_SHIFT and tag size are pretty baked into the
>> aarch64 architecture.  But, are you confident that no future
>> implementations will want different positions or sizes?  (obviously
>> controlled by other TCR_EL1 bits)
> 
> For the top-byte-ignore (TBI), that's been baked in the architecture
> since ARMv8.0 and we'll have to keep the backwards compatible mode. As
> the name implies, it's the top byte of the address and that's what the
> document above refers to.
> 
> With MTE, I can't exclude other configurations in the future but I'd
> expect the kernel to present the option as a new HWCAP and the user to
> explicitly opt in via a new prctl() flag. I seriously doubt we'd break
> existing binaries. So, yes TAG_SHIFT may be different but so would the
> prctl() above.

Basically, what you have is a "turn tagging on" and "turn tagging off"
call which are binary: all on or all off.  How about exposing a mask:

	/* Replace hard-coded mask size/position: */
	unsigned long mask = prctl(GET_POSSIBLE_TAGGED_ADDR_BITS);

	if (mask == 0)
		// no tagging is supported obviously

	prctl(SET_TAGGED_ADDR_BITS, mask);

	// now userspace knows via 'mask' where the tag bits are


