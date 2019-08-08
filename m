Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB08679E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404145AbfHHREb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 13:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404181AbfHHREb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 13:04:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1622173C;
        Thu,  8 Aug 2019 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565283869;
        bh=GfVG+WcBk3hitpjwfTPOeIgwN+whEY5uyl+jUnJ3MCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj3u/rkbtzt11xLrtRJ42bmQ8/ASaaOlqFxRKG0v+vbZtnGPi0D7dEJ8F5IT76dB1
         E+rGEX1trH/3e/AAyPq4Y7M9Ru4fF5LDEmrKW983r4N4Ohd8WDOccTz1fu8tYlYt6P
         MpKvSYos+b6xEhlPNCPv4NozsRK2fGuB8jfgduNA=
Date:   Thu, 8 Aug 2019 18:04:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190808170424.6td34cpdngkcxxpu@willie-the-truck>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807155321.9648-2-catalin.marinas@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 07, 2019 at 04:53:20PM +0100, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
> the userspace (EL0) is allowed to set a non-zero value in the
> top byte but the resulting pointers are not allowed at the
> user-kernel syscall ABI boundary.
> 
> With the relaxed ABI proposed through this document, it is now possible
> to pass tagged pointers to the syscalls, when these pointers are in
> memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().
> 
> This change in the ABI requires a mechanism to requires the userspace
> to opt-in to such an option.
> 
> Specify and document the way in which sysctl and prctl() can be used
> in combination to allow the userspace to opt-in this feature.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [catalin.marinas@arm.com: some rewording, dropped MAP_PRIVATE]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/arm64/tagged-address-abi.rst | 151 +++++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/arm64/tagged-address-abi.rst
> 
> diff --git a/Documentation/arm64/tagged-address-abi.rst b/Documentation/arm64/tagged-address-abi.rst
> new file mode 100644
> index 000000000000..f91a5d2ac865
> --- /dev/null
> +++ b/Documentation/arm64/tagged-address-abi.rst
> @@ -0,0 +1,151 @@
> +==========================
> +AArch64 TAGGED ADDRESS ABI
> +==========================
> +
> +Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
> +
> +Date: 25 July 2019
> +
> +This document describes the usage and semantics of the Tagged Address
> +ABI on AArch64 Linux.
> +
> +1. Introduction
> +---------------
> +
> +On AArch64 the TCR_EL1.TBI0 bit has always been enabled, allowing userspace
> +(EL0) to perform memory accesses through 64-bit pointers with a non-zero
> +top byte. Such tagged pointers, however, were not allowed at the
> +user-kernel syscall ABI boundary.

I think we should drop the temporal language, so:

  "has always been enabled" => "is set by the kernel"
  "were not allowed" => "are not allowed by default"

> +
> +This document describes the relaxation of the syscall ABI that allows
> +userspace to pass certain tagged pointers to kernel syscalls, as described
> +in section 2.
> +
> +2. AArch64 Tagged Address ABI
> +-----------------------------
> +
> +From the kernel syscall interface perspective and for the purposes of this
> +document, a "valid tagged pointer" is a pointer with a potentially non-zero
> +top-byte that references an address in the user process address space
> +obtained in one of the following ways:
> +
> +- mmap() done by the process itself (or its parent), where either:
> +
> +  - flags have the **MAP_ANONYMOUS** bit set
> +  - the file descriptor refers to a regular file (including those returned
> +    by memfd_create()) or **/dev/zero**
> +
> +- brk() system call done by the process itself (i.e. the heap area between
> +  the initial location of the program break at process creation and its
> +  current location).
> +
> +- any memory mapped by the kernel in the address space of the process
> +  during creation and with the same restrictions as for mmap() above (e.g.
> +  data, bss, stack).
> +
> +The AArch64 Tagged Address ABI is an opt-in feature and an application can
> +control it via **prctl()** as follows:
> +
> +- **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged Address
> +  ABI for the calling process.
> +
> +  The (unsigned int) arg2 argument is a bit mask describing the control mode
> +  used:
> +
> +  - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI. Default
> +    status is disabled.
> +
> +  The arguments arg3, arg4, and arg5 are ignored.
> +
> +- **PR_GET_TAGGED_ADDR_CTRL**: get the status of the AArch64 Tagged Address
> +  ABI for the calling process.
> +
> +  The arguments arg2, arg3, arg4, and arg5 are ignored.

I agree with Dave (H) that we should require these to be zero. We may be
able to use arg2 to namespace things for PR_SET_TAGGED_ADDR_CTRL, but for
PR_GET_TAGGED_ADDR_CTRL we'd have to add a new prctl if we wanted to extend
it otherwise.

> +The prctl(PR_SET_TAGGED_ADDR_CTRL, ...) will return -EINVAL if the

*The* prctl? Maybe "Calling prctl(..." is better?

> +AArch64 Tagged Address ABI is not available
> +(CONFIG_ARM64_TAGGED_ADDR_ABI disabled or sysctl abi.tagged_addr=0).

drop the brackets and say "because CONFIG_... is disabled or ..".

> +
> +The ABI properties set by the mechanism described above are inherited by
> +threads of the same application and fork()'ed children but cleared by
> +execve().

Maybe just exec() here, since there are other flavours we shouldn't need to
enumerate.

> +Opting in (the prctl() option described above only) to or out of the
> +AArch64 Tagged Address ABI can be disabled globally at runtime using the
> +sysctl interface:

This sentence reads really badly thanks to the random bracketed part.

> +
> +- **abi.tagged_addr**: a new sysctl interface that can be used to prevent
> +  applications from enabling or disabling the relaxed ABI. The sysctl
> +  supports the following configuration options:
> +
> +  - **0**: disable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
> +    enable/disable the AArch64 Tagged Address ABI globally

This is clunky because it sounds like we're enabling the ABI for everybody,
where in actual fact we're enabling the controls for the ABI instead. It
also applies equally to PR_GET_TAGGED_ADDR_CTRL (but see below). Given that
we've already defined the prctl() above, I think we can just say:

  **0**: AArch64 Tagged Address ABI prctl() calls will return -EINVAL
  **1**: AArch64 Tagged Address ABI prctl() calls will behave as documented above.

> +  - **1** (Default): enable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
> +    enable/disable the AArch64 Tagged Address ABI globally
> +
> +  Note that this sysctl does not affect the status of the AArch64 Tagged
> +  Address ABI of the running processes.

Hmm, but it does mean that you can no longer ask if a previously running
process is using tags. Is that intentional?

> +When a process has successfully enabled the new ABI by invoking
> +prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
> +behaviours are guaranteed:

nit: this also applies to processes that have inherited the new ABI
bevaiour via fork() and haven't invoked the prctl() themselves.

> +- Every currently available syscall, except the cases mentioned in section

"currently available" is meaningless and should be removed

> +  3, can accept any valid tagged pointer. The same rule is applicable to
> +  any syscall introduced in the future.

Delete this last sentence.

> +- The syscall behaviour is undefined for non valid tagged pointers.

non valid => invalid

although this needs to be better defined, I think.

> +
> +- Every valid tagged pointer is expected to work as an untagged one.

What does that mean? Expected by who? What does "work" mean?

> +A definition of the meaning of tagged pointers on AArch64 can be found in:
> +Documentation/arm64/tagged-pointers.txt.

.txt => .rst

> +
> +3. AArch64 Tagged Address ABI Exceptions
> +-----------------------------------------
> +
> +The behaviour described in section 2, with particular reference to the
> +acceptance by the syscalls of any valid tagged pointer, is not applicable
> +to the following cases:

Jeez louise...

How about: "The following system call parameters must be untagged, regardless
of the ABI relaxation:"

> +
> +- mmap() addr parameter.
> +
> +- mremap() new_address parameter.
> +
> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> +  PR_SET_MM_MAP_SIZE.
> +
> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.

How did you generate this list and who will keep it up to date? How do you
know you haven't missed anything?

> +Any attempt to use non-zero tagged pointers will lead to undefined
> +behaviour.

In the tagged pointer document we're slightly more specific and say that
using non-zero address tags "may result in an error code being returned, a
(fatal) signal being rasied, or other modes of failure". Maybe reuse that?

> +4. Example of correct usage
> +---------------------------
> +.. code-block:: c
> +
> +   void main(void)
> +   {
> +           static int tbi_enabled = 0;
> +           unsigned long tag = 0;
> +

Some comments won't go amiss here.

> +           char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +                            MAP_ANONYMOUS, -1, 0);
> +
> +           if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
> +                     0, 0, 0) == 0)
> +                   tbi_enabled = 1;
> +
> +           if (ptr == (void *)-1) /* MAP_FAILED */
> +                   return -1;
> +
> +           if (tbi_enabled)
> +                   tag = rand() & 0xff;
> +
> +           ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
> +
> +           *ptr = 'a';
> +
> +           ...
> +   }

Hmm, doesn't this snippet work today? You're not actually passing the
tagged pointer back to the kernel...

Will
