Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17764A1C9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRNNG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 09:13:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRNNF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 09:13:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A6AC2B;
        Tue, 18 Jun 2019 06:13:04 -0700 (PDT)
Received: from [10.1.199.35] (e107154-lin.cambridge.arm.com [10.1.199.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0973F718;
        Tue, 18 Jun 2019 06:13:02 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190613155137.47675-1-vincenzo.frascino@arm.com>
 <20190613155137.47675-2-vincenzo.frascino@arm.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <1c55a610-9aa5-4675-f7de-79a1661a660d@arm.com>
Date:   Tue, 18 Jun 2019 14:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613155137.47675-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I'm happy with the ABI overall, but I think we need a few more tweaks.

On 13/06/2019 16:51, Vincenzo Frascino wrote:
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> CC: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   Documentation/arm64/tagged-address-abi.txt | 134 +++++++++++++++++++++
>   1 file changed, 134 insertions(+)
>   create mode 100644 Documentation/arm64/tagged-address-abi.txt
>
> diff --git a/Documentation/arm64/tagged-address-abi.txt b/Documentation/arm64/tagged-address-abi.txt
> new file mode 100644
> index 000000000000..0ae900d4bb2d
> --- /dev/null
> +++ b/Documentation/arm64/tagged-address-abi.txt
> @@ -0,0 +1,134 @@
> +ARM64 TAGGED ADDRESS ABI
> +========================
> +
> +This document describes the usage and semantics of the Tagged Address
> +ABI on arm64.
> +
> +1. Introduction
> +---------------
> +
> +On arm64 the TCR_EL1.TBI0 bit has been always enabled on the kernel, hence
"been always" -> "always been"

> +the userspace (EL0) is entitled to perform a user memory access through a
> +64-bit pointer with a non-zero top byte but the resulting pointers are not
> +allowed at the user-kernel syscall ABI boundary.
> +
> +This document describes a relaxation of the ABI that makes it possible to
> +to pass tagged pointers to the syscalls, when these pointers are in memory
> +ranges obtained as described in section 2.
> +
> +Since it is not desirable to relax the ABI to allow tagged user addresses
> +into the kernel indiscriminately, arm64 provides a new sysctl interface
> +(/proc/sys/abi/tagged_addr) that is used to prevent the applications from
> +enabling the relaxed ABI and a new prctl() interface that can be used to
> +enable or disable the relaxed ABI.
> +A detailed description of the newly introduced mechanisms will be provided
> +in section 2.
> +
> +2. ARM64 Tagged Address ABI
> +---------------------------
> +
> +From the kernel syscall interface perspective, we define, for the purposes
> +of this document, a "valid tagged pointer" as a pointer that either has a
> +zero value set in the top byte or has a non-zero value, it is in memory
> +ranges privately owned by a userspace process and it is obtained in one of

Remove all the remaining "it": "a pointer that either [...], is in memory ranges 
[...] and is obtained..."

> +the following ways:
> +  - mmap() done by the process itself, where either:
> +    * flags have MAP_PRIVATE and MAP_ANONYMOUS
> +    * flags have MAP_PRIVATE and the file descriptor refers to a regular
> +      file or "/dev/zero"
> +  - brk() system call done by the process itself (i.e. the heap area between
> +    the initial location of the program break at process creation and its
> +    current location).
> +  - any memory mapped by the kernel in the process's address space during
> +    creation and following the restrictions presented above (i.e. data, bss,
> +    stack).

As I commented on v2, the "i.e." is not correct: these 3 sections are not the only 
ones that are covered by this ABI (.text also is, for instance). Replacing "i.e." 
with "e.g." would work.

Also, since the rules above say explicitly "done by the process itself", it might be 
clearer to replace "following the restrictions presented above" with "with the same 
restrictions as for mmap()".

> +
> +The ARM64 Tagged Address ABI is an opt-in feature, and an application can
> +control it using the following:
> + - /proc/sys/abi/tagged_addr: a new sysctl interface that can be used to
> +        prevent the applications from enabling the relaxed ABI.
> +        The sysctl is meant also for testing purposes in order to provide a
> +        simple way for the userspace to verify the return error checking of
> +        the prctl() commands without having to reconfigure the kernel.
> +        The sysctl supports the following configuration options:
> +         - 0: Disable ARM64 Tagged Address ABI for all the applications.
> +         - 1 (Default): Enable ARM64 Tagged Address ABI for all the
> +                        applications.

I find this very confusing, because it suggests that the default value of 
PR_GET_TAGGED_ADDR_CTRL for new processes will be set to the value of this sysctl, 
when in fact this sysctl is about restricting the *availability* of the new ABI. 
Instead of disabling the ABI, I would talk about disabling access to the new ABI here.

> +        If the ARM64 Tagged Address ABI is disabled at a certain point in
> +        time, all the applications that were using tagging before this event
> +        occurs, will continue to use tagging.
> +
> + - prctl()s:
> +  - PR_SET_TAGGED_ADDR_CTRL: can be used to enable or disable the Tagged
> +        Address ABI.
> +        The (unsigned int) arg2 argument is a bit mask describing the
> +        control mode used:
> +          - PR_TAGGED_ADDR_ENABLE: Enable ARM64 Tagged Address ABI.
> +        The arguments arg3, arg4, and arg5 are ignored.

Have we definitely decided that arg{3,4,5} are ignored? Catalin?

> +
> +  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
> +        Address ABI.
> +        The arguments arg2, arg3, arg4, and arg5 are ignored.
> +
> +The ABI properties set by the mechanisms described above are inherited by threads
> +of the same application and fork()'ed children but cleared by execve().
> +
> +As a consequence of invoking PR_SET_TAGGED_ADDR_CTRL prctl() by an applications,

I think this is too vague, you can use this prctl() to disable the new ABI, and it 
can also fail. Maybe it's best to simply say that the process has successfully opted 
into the new ABI.

> +the ABI guarantees the following behaviours:
> +
> +  - Every current or newly introduced syscall can accept any valid tagged
> +    pointers.
"pointer". Also, is it really useful to talk about newly introduced syscall? New from 
which point of view?

> +
> +  - If a non valid tagged pointer is passed to a syscall then the behaviour
> +    is undefined.
> +
> +  - Every valid tagged pointer is expected to work as an untagged one.
> +
> +  - The kernel preserves any valid tagged pointers and returns them to the
"pointer", "returns it"

> +    userspace unchanged (i.e. on syscall return) in all the cases except the
> +    ones documented in the "Preserving tags" section of tagged-pointers.txt.
> +
> +A definition of the meaning of tagged pointers on arm64 can be found in:
> +Documentation/arm64/tagged-pointers.txt.
> +
> +3. ARM64 Tagged Address ABI Exceptions
> +--------------------------------------
> +
> +The behaviours described in section 2, with particular reference to the
> +acceptance by the syscalls of any valid tagged pointer are not applicable
> +to the following cases:
> +  - mmap() addr parameter.
> +  - mremap() new_address parameter.
> +  - prctl_set_mm() struct prctl_map fields.
> +  - prctl_set_mm_map() struct prctl_map fields.

prctl_set_mm() and prctl_set_mm_map() are internal kernel functions, not syscall 
names. IIUC, we don't want to allow any address field settable via the PR_SET_MM 
prctl() to be tagged. Catalin, is that correct? I think this needs rephrasing.

Kevin

> +
> +Any attempt to use non-zero tagged pointers will lead to undefined behaviour.
> +
> +4. Example of correct usage
> +---------------------------
> +
> +void main(void)
> +{
> +	static int tbi_enabled = 0;
> +	unsigned long tag = 0;
> +
> +	char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +			 MAP_ANONYMOUS, -1, 0);
> +
> +	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
> +		  0, 0, 0) == 0)
> +		tbi_enabled = 1;
> +
> +	if (ptr == (void *)-1) /* MAP_FAILED */
> +		return -1;
> +
> +	if (tbi_enabled)
> +		tag = rand() & 0xff;
> +
> +	ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
> +
> +	*ptr = 'a';
> +
> +	...
> +}
> +

