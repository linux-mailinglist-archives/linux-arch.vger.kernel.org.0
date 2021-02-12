Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5631A13C
	for <lists+linux-arch@lfdr.de>; Fri, 12 Feb 2021 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBLPNk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 10:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhBLPNi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2021 10:13:38 -0500
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4F6C061756
        for <linux-arch@vger.kernel.org>; Fri, 12 Feb 2021 07:12:53 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DccSK1666zMpp7p;
        Fri, 12 Feb 2021 16:12:49 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DccSH5gQMzlh8TS;
        Fri, 12 Feb 2021 16:12:47 +0100 (CET)
Subject: Re: [PATCH 02/27] x86/syscalls: fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-3-masahiroy@kernel.org>
 <41f7ad59-6ee7-db95-0e56-861c61e8318f@digikod.net>
Message-ID: <b47407f4-6c4c-1db3-f1ad-c569de315790@digikod.net>
Date:   Fri, 12 Feb 2021 16:13:24 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <41f7ad59-6ee7-db95-0e56-861c61e8318f@digikod.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Could you please push this patch to Linus? Thanks.

On 04/02/2021 15:16, Mickaël Salaün wrote:
> 
> On 28/01/2021 01:50, Masahiro Yamada wrote:
>> Building kernel/sys_ni.c with W=1 omits tons of -Wmissing-prototypes
>> warnings.
>>
>> $ make W=1 kernel/sys_ni.o
>>   [ snip ]
>>   CC      kernel/sys_ni.o
>> In file included from kernel/sys_ni.c:10:
>> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
>>    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>>       |              ^~
>> ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
>>   100 |  __COND_SYSCALL(x64, sys_##name)
>>       |  ^~~~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
>>   256 |  __X64_COND_SYSCALL(name)     \
>>       |  ^~~~~~~~~~~~~~~~~~
>> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>>    39 | COND_SYSCALL(io_setup);
>>       | ^~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
>>    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>>       |              ^~
>> ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
>>   120 |  __COND_SYSCALL(ia32, sys_##name)
>>       |  ^~~~~~~~~~~~~~
>> ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
>>   257 |  __IA32_COND_SYSCALL(name)
>>       |  ^~~~~~~~~~~~~~~~~~~
>> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>>    39 | COND_SYSCALL(io_setup);
>>       | ^~~~~~~~~~~~
>>   ...
>>
>> __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
>> declarations. Let's do likewise for __COND_SYSCALL() to fix the
>> warnings.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Tested-by: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Thanks to this patch we avoid multiple emails from Intel's bot when
> adding new syscalls. :)
> 
> 
>> ---
>>
>>  arch/x86/include/asm/syscall_wrapper.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
>> index a84333adeef2..80c08c7d5e72 100644
>> --- a/arch/x86/include/asm/syscall_wrapper.h
>> +++ b/arch/x86/include/asm/syscall_wrapper.h
>> @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>>  	}
>>  
>>  #define __COND_SYSCALL(abi, name)					\
>> +	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
>>  	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
>>  	{								\
>>  		return sys_ni_syscall();				\
>>
