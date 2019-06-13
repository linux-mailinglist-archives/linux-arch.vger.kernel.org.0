Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAE43B94
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfFMPaI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:30:08 -0400
Received: from foss.arm.com ([217.140.110.172]:38258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbfFMLQ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 07:16:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9840367;
        Thu, 13 Jun 2019 04:16:27 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152F93F694;
        Thu, 13 Jun 2019 04:18:08 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Cc:     nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <a90da586-8ff6-4bed-d940-9306d517a18c@arm.com>
 <20190613092054.GO28951@C02TF0J2HF1T.local>
 <dee7f192-d0f0-558e-3007-eba805c6f2da@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6ebbda37-5dd9-d0d5-d9cb-286c7a5b7f8e@arm.com>
Date:   Thu, 13 Jun 2019 12:16:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dee7f192-d0f0-558e-3007-eba805c6f2da@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Szabolcs,

thank you for your review.

On 13/06/2019 11:14, Szabolcs Nagy wrote:
> On 13/06/2019 10:20, Catalin Marinas wrote:
>> Hi Szabolcs,
>>
>> On Wed, Jun 12, 2019 at 05:30:34PM +0100, Szabolcs Nagy wrote:
>>> On 12/06/2019 15:21, Vincenzo Frascino wrote:
>>>> +2. ARM64 Tagged Address ABI
>>>> +---------------------------
>>>> +
>>>> +From the kernel syscall interface prospective, we define, for the purposes
>>>                                      ^^^^^^^^^^^
>>> perspective
>>>
>>>> +of this document, a "valid tagged pointer" as a pointer that either it has
>>>> +a zero value set in the top byte or it has a non-zero value, it is in memory
>>>> +ranges privately owned by a userspace process and it is obtained in one of
>>>> +the following ways:
>>>> +  - mmap() done by the process itself, where either:
>>>> +    * flags = MAP_PRIVATE | MAP_ANONYMOUS
>>>> +    * flags = MAP_PRIVATE and the file descriptor refers to a regular
>>>> +      file or "/dev/zero"
>>>
>>> this does not make it clear if MAP_FIXED or other flags are valid
>>> (there are many map flags i don't know, but at least fixed should work
>>> and stack/growsdown. i'd expect anything that's not incompatible with
>>> private|anon to work).
>>
>> Just to clarify, this document tries to define the memory ranges from
>> where tagged addresses can be passed into the kernel in the context
>> of TBI only (not MTE); that is for hwasan support. FIXED or GROWSDOWN
>> should not affect this.
> 
> yes, so either the text should list MAP_* flags that don't affect
> the pointer tagging semantics or specify private|anon mapping
> with different wording.
> 

Good point. Could you please propose a wording that would be suitable for this case?

>>>> +  - a mapping below sbrk(0) done by the process itself
>>>
>>> doesn't the mmap rule cover this?
>>
>> IIUC it doesn't cover it as that's memory mapped by the kernel
>> automatically on access vs a pointer returned by mmap(). The statement
>> above talks about how the address is obtained by the user.
> 
> ok i read 'mapping below sbrk' as an mmap (possibly MAP_FIXED)
> that happens to be below the heap area.
> 
> i think "below sbrk(0)" is not the best term to use: there
> may be address range below the heap area that can be mmapped
> and thus below sbrk(0) and sbrk is a posix api not a linux
> syscall, the libc can implement it with mmap or whatever.
> 
> i'm not sure what the right term for 'heap area' is
> (the address range between syscall(__NR_brk,0) at
> program startup and its current value?)
> 

I used sbrk(0) with the meaning of "end of the process's data segment" not
implying that this is a syscall, but just as a useful way to identify the mapping.
I agree that it is a posix function implemented by libc but when it is used with
0 finds the current location of the program break, which can be changed by brk()
and depending on the new address passed to this syscall can have the effect of
allocating or deallocating memory.

Will changing sbrk(0) with "end of the process's data segment" make it more clear?

I will add what you are suggesting about the heap area.

>>>> +  - any memory mapped by the kernel in the process's address space during
>>>> +    creation and following the restrictions presented above (i.e. data, bss,
>>>> +    stack).
>>>
>>> OK.
>>>
>>> Can a null pointer have a tag?
>>> (in case NULL is valid to pass to a syscall)
>>
>> Good point. I don't think it can. We may change this for MTE where we
>> give a hint tag but no hint address, however, this document only covers
>> TBI for now.
> 
> OK.
> 
>>>> +The ARM64 Tagged Address ABI is an opt-in feature, and an application can
>>>> +control it using the following prctl()s:
>>>> +  - PR_SET_TAGGED_ADDR_CTRL: can be used to enable the Tagged Address ABI.
>>>> +  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
>>>> +                             Address ABI.
>>>> +
>>>> +As a consequence of invoking PR_SET_TAGGED_ADDR_CTRL prctl() by an applications,
>>>> +the ABI guarantees the following behaviours:
>>>> +
>>>> +  - Every current or newly introduced syscall can accept any valid tagged
>>>> +    pointers.
>>>> +
>>>> +  - If a non valid tagged pointer is passed to a syscall then the behaviour
>>>> +    is undefined.
>>>> +
>>>> +  - Every valid tagged pointer is expected to work as an untagged one.
>>>> +
>>>> +  - The kernel preserves any valid tagged pointers and returns them to the
>>>> +    userspace unchanged in all the cases except the ones documented in the
>>>> +    "Preserving tags" paragraph of tagged-pointers.txt.
>>>
>>> OK.
>>>
>>> i guess pointers of another process are not "valid tagged pointers"
>>> for the current one, so e.g. in ptrace the ptracer has to clear the
>>> tags before PEEK etc.
>>
>> Another good point. Are there any pros/cons here or use-cases? When we
>> add MTE support, should we handle this differently?
> 
> i'm not sure what gdb does currently, but it has
> an 'address_significant' hook used at a few places
> that drops the tag on aarch64, so it probably
> avoids passing tagged pointer to ptrace.
> 
> i was worried about strace which tries to print
> structs passed to syscalls and follow pointers in
> them which currently would work, but if we allow
> tags in syscalls then it needs some update.
> (i haven't checked the strace code though)
>>>>> +A definition of the meaning of tagged pointers on arm64 can be found in:
>>>> +Documentation/arm64/tagged-pointers.txt.
>>>> +
>>>> +3. ARM64 Tagged Address ABI Exceptions
>>>> +--------------------------------------
>>>> +
>>>> +The behaviours described in paragraph 2, with particular reference to the
>>>> +acceptance by the syscalls of any valid tagged pointer are not applicable
>>>> +to the following cases:
>>>> +  - mmap() addr parameter.
>>>> +  - mremap() new_address parameter.
>>>> +  - prctl_set_mm() struct prctl_map fields.
>>>> +  - prctl_set_mm_map() struct prctl_map fields.
>>>
>>> i don't understand the exception: does it mean that passing a tagged
>>> address to these syscalls is undefined?
>>
>> I'd say it's as undefined as it is right now without these patches. We
>> may be able to explain this better in the document.
>>
> 

-- 
Regards,
Vincenzo
