Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5743CA4
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfFMPg4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:36:56 -0400
Received: from foss.arm.com ([217.140.110.172]:37576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfFMKPi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:15:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D58E367;
        Thu, 13 Jun 2019 03:15:37 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29693F694;
        Thu, 13 Jun 2019 03:17:18 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <20190612153538.GL28951@C02TF0J2HF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <141c740a-94c2-2243-b6d1-b44ffee43791@arm.com>
Date:   Thu, 13 Jun 2019 11:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612153538.GL28951@C02TF0J2HF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 12/06/2019 16:35, Catalin Marinas wrote:
> Hi Vincenzo,
> 
> Some minor comments below but it looks fine to me overall. Cc'ing
> Szabolcs as well since I'd like a view from the libc people.
> 

Thanks for this, I saw Szabolcs comments.

> On Wed, Jun 12, 2019 at 03:21:10PM +0100, Vincenzo Frascino wrote:
>> diff --git a/Documentation/arm64/tagged-address-abi.txt b/Documentation/arm64/tagged-address-abi.txt
>> new file mode 100644
>> index 000000000000..96e149e2c55c
>> --- /dev/null
>> +++ b/Documentation/arm64/tagged-address-abi.txt
>> @@ -0,0 +1,111 @@
>> +ARM64 TAGGED ADDRESS ABI
>> +========================
>> +
>> +This document describes the usage and semantics of the Tagged Address
>> +ABI on arm64.
>> +
>> +1. Introduction
>> +---------------
>> +
>> +On arm64 the TCR_EL1.TBI0 bit has been always enabled on the arm64 kernel,
>> +hence the userspace (EL0) is allowed to set a non-zero value in the top
> 
> I'd be clearer here: "userspace (EL0) is allowed to perform a user
> memory access through a 64-bit pointer with a non-zero top byte" (or
> something along the lines). Otherwise setting a non-zero top byte is
> allowed on any architecture, dereferencing it is a problem.
> 

Ok.

>> +byte but the resulting pointers are not allowed at the user-kernel syscall
>> +ABI boundary.
>> +
>> +This document describes a relaxation of the ABI with which it is possible
> 
> "relaxation of the ABI that makes it possible to..."
> 
>> +to pass tagged tagged pointers to the syscalls, when these pointers are in
>> +memory ranges obtained as described in paragraph 2.
> 
> "section 2" is better. There are a lot more paragraphs.
> 

Agree.

>> +
>> +Since it is not desirable to relax the ABI to allow tagged user addresses
>> +into the kernel indiscriminately, arm64 provides a new sysctl interface
>> +(/proc/sys/abi/tagged_addr) that is used to prevent the applications from
>> +enabling the relaxed ABI and a new prctl() interface that can be used to
>> +enable or disable the relaxed ABI.
>> +
>> +The sysctl is meant also for testing purposes in order to provide a simple
>> +way for the userspace to verify the return error checking of the prctl()
>> +command without having to reconfigure the kernel.
>> +
>> +The ABI properties are inherited by threads of the same application and
>> +fork()'ed children but cleared when a new process is spawn (execve()).
> 
> "spawned".
> 
> I guess you could drop these three paragraphs here and mention the
> inheritance properties when introducing the prctl() below. You can also
> mention the global sysctl switch after the prctl() was introduced.
> 

I will move the last two (rewording them) to the _section_ 2, but I would still
prefer the Introduction to give an overview of the solution as well.

>> +
>> +2. ARM64 Tagged Address ABI
>> +---------------------------
>> +
>> +From the kernel syscall interface prospective, we define, for the purposes
>> +of this document, a "valid tagged pointer" as a pointer that either it has
> 
> "either has" (no 'it') sounds slightly better but I'm not a native
> English speaker either.
> 
>> +a zero value set in the top byte or it has a non-zero value, it is in memory
>> +ranges privately owned by a userspace process and it is obtained in one of
>> +the following ways:
>> +  - mmap() done by the process itself, where either:
>> +    * flags = MAP_PRIVATE | MAP_ANONYMOUS
>> +    * flags = MAP_PRIVATE and the file descriptor refers to a regular
>> +      file or "/dev/zero"
>> +  - a mapping below sbrk(0) done by the process itself
>> +  - any memory mapped by the kernel in the process's address space during
>> +    creation and following the restrictions presented above (i.e. data, bss,
>> +    stack).
>> +
>> +The ARM64 Tagged Address ABI is an opt-in feature, and an application can
>> +control it using the following prctl()s:
>> +  - PR_SET_TAGGED_ADDR_CTRL: can be used to enable the Tagged Address ABI.
> 
> enable or disable (not sure we need the latter but it doesn't heart).
> 
> I'd add the arg2 description here as well.
> 

Good point I missed this.

>> +  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
>> +                             Address ABI.
>> +
>> +As a consequence of invoking PR_SET_TAGGED_ADDR_CTRL prctl() by an applications,
>> +the ABI guarantees the following behaviours:
>> +
>> +  - Every current or newly introduced syscall can accept any valid tagged
>> +    pointers.
>> +
>> +  - If a non valid tagged pointer is passed to a syscall then the behaviour
>> +    is undefined.
>> +
>> +  - Every valid tagged pointer is expected to work as an untagged one.
>> +
>> +  - The kernel preserves any valid tagged pointers and returns them to the
>> +    userspace unchanged in all the cases except the ones documented in the
>> +    "Preserving tags" paragraph of tagged-pointers.txt.
> 
> I'd think we need to qualify the context here in which the kernel
> preserves the tagged pointers. Did you mean on the syscall return?
> 

What this means is that on syscall return the tags are preserved, but if for
example you have tagged pointers inside siginfo_t, they will not because
according to tagged-pointers.txt non-zero tags are not preserved when delivering
signals.

>> +
>> +A definition of the meaning of tagged pointers on arm64 can be found in:
>> +Documentation/arm64/tagged-pointers.txt.
>> +
>> +3. ARM64 Tagged Address ABI Exceptions
>> +--------------------------------------
>> +
>> +The behaviours described in paragraph 2, with particular reference to the
> 
> "section 2"
> 
>> +acceptance by the syscalls of any valid tagged pointer are not applicable
>> +to the following cases:
>> +  - mmap() addr parameter.
>> +  - mremap() new_address parameter.
>> +  - prctl_set_mm() struct prctl_map fields.
>> +  - prctl_set_mm_map() struct prctl_map fields.
>> +
>> +4. Example of correct usage
>> +---------------------------
>> +
>> +void main(void)
>> +{
>> +	static int tbi_enabled = 0;
>> +	unsigned long tag = 0;
>> +
>> +	char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
>> +			 MAP_ANONYMOUS, -1, 0);
>> +
>> +	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
>> +		  0, 0, 0) == 0)
>> +		tbi_enabled = 1;
>> +
>> +	if (!ptr)
>> +		return -1;
>> +
>> +	if (tbi_enabled)
>> +		tag = rand() & 0xff;
>> +
>> +	ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
>> +
>> +	*ptr = 'a';
>> +
>> +	...
>> +}
>> +
>> -- 
>> 2.21.0
> 

-- 
Regards,
Vincenzo
