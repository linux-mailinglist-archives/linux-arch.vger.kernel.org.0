Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19E380AD8
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhENN7O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 09:59:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229889AbhENN7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 09:59:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EDYQ3T075561;
        Fri, 14 May 2021 09:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=q4yMY1DYXeiejxph+S2phXKgxHwquwSduzhHDCAvkkM=;
 b=PU14e4U6BdYclCQsj1Ch55ZQp9ACRmL1IY5R7/zBRK1/soLxHYDnaiPAb8ml0hL8ic/4
 gvEi51fTkhcr33UVNdtlJR/PvZAYeEwdC2z1ftxxrj1rEX6aflk6FoTVF2esQe3CAPJJ
 CTDTDqbUy3M1z4qI/5YdM+j9jlwwBPZGaiS88kNWtpr2BT5CFV/qCDjpoKMtsA67JobG
 03clna606Se1qcmjyehet5tvKwrQe+6uevJeSBtuUyIVfLv9d/MJQchD2ZiObAp16bls
 bJ0AY5D6gnFEgzsM2fCbnxvJV3sNKgMhw+lGDwSUvYNAuRu2WX4C0X3S4R+ZxnFetyGs 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38hrp3jtk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 09:55:58 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14EDmOA7125453;
        Fri, 14 May 2021 09:55:57 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38hrp3jtjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 09:55:57 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14EDtUsP003586;
        Fri, 14 May 2021 13:55:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 38hc6rg5rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 13:55:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14EDtQbq18415958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:55:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BC9FA405B;
        Fri, 14 May 2021 13:55:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A686BA4060;
        Fri, 14 May 2021 13:55:52 +0000 (GMT)
Received: from [9.145.59.27] (unknown [9.145.59.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 May 2021 13:55:52 +0000 (GMT)
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
To:     Lambert <lambertdev@qq.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        lambertdev@gmail.com, Jeff Dike <jdike@addtoit.com>,
        richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-um@lists.infradead.org, "Lambert." <lambertdev@foxmail.com>
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
 <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
 <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
 <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <4066a6f1-5c45-e6ee-06ab-72b41c1aa753@linux.ibm.com>
Date:   Fri, 14 May 2021 15:55:54 +0200
In-Reply-To: <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1lmoVixhGvbBXjuQ1h7ZsFAJRFYoEYew
X-Proofpoint-ORIG-GUID: e839mXyKco_Yxwjm11VooA-l8qXzasUV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105140109
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I'm adding UML maintainers for their input.

On 08.05.2021 15:50, Lambert wrote:
>> On Jan 21, 2021, at 1:04 AM, Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
>> On 20.01.2021 17:20, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> On ARCH=um, loading a module doesn't result in its constructors
>>> getting called, which breaks module gcov since the debugfs files
>>> are never registered. On the other hand, in-kernel constructors
>>> have already been called by the dynamic linker, so we can't call
>>> them again.
>>>
>>> Get out of this conundrum by allowing CONFIG_CONSTRUCTORS to be
>>> selected, but avoiding the in-kernel constructor calls.
>>>
>>> Also remove the "if !UML" from GCOV selecting CONSTRUCTORS now,
>>> since we really do want CONSTRUCTORS, just not kernel binary
>>> ones.
>>>
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> Looks good+nicer than v1 to me!
>>
>> I also tested this patch on s390 and can confirm that it doesn't break
>> gcov-kernel there.
>>
>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>>
>> Andrew, do we need additional reviews/sign-offs? Could this go in via
>> your tree?
>>
>>> ---
>>> Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
>>> the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
>>> from the reset file), and with it we get the files and they work.
>>
>> Just to be sure: could you confirm that this test statement for UML also
>> applies to v2, i.e. that it fixes the original problem you were seeing?
>>
> 
> Hi Johannes and Peter, sorry to bother but I have one question 
> on this change. The do_ctors() won’t be executed for UML 
> because  *the constructors have already been called for ELF*. 
> 
> The init_array section for each C file is linked to *vmlinux*  between 
> *__ctors_start*  and  *__ctors_end* symbols. See link:
> https://elixir.bootlin.com/linux/v5.12.2/source/include/asm-generic/vmlinux.lds.h#L676
> 
> In my environment, UML+GCC 10, I can't find __gcov_init executed 
> before kernel starts. So I did some trace and found glibc __libc_csu_init 
> will only execute constructors between *__init_array_start*and *__init_array_end*.  
> Which means if do_ctors() is not executed for UML, no elsewhere will 
> the constructors be executed.
> 
> Shall we remove the *!defined(CONFIG_UML)* for GCC, or I just missed 
> some steps to make the GCOV work for UML?

I'm not an expert for the UML-arch, but based on this report I did some
investigations. I think that this patch might be partially in error.

Before the patch no constructors were called for UML and as a result
gcov-kernel profiling was not available, neither for built-in code nor
for module code.

With the patch CONFIG_CONSTRUCTORS was made available on UML and with it
gcov-kernel profiling. This works well for kernel modules (which I
assume is what Johannes tested), but it fails for built-in code. Note
that since UML does not specify ARCH_HAS_GCOV_PROFILE_ALL you need to
manually add GCOV_PROFILE := y to any kernel Makefile if you want to
enable profiling for that built-in code.

The subject patch is based on the assumption that constructors for
built-in kernel code is called from glibc when the vmlinux executable is
started. This does not work the way it was assumed it would, and would
be broken if it did.

It does not work because, as was already pointed out, glibc is looking
for the __init_array_start symbol to locate the list of constructor
function pointers, but the kernel uses a different symbol name
(__ctors_start). If you add the __init_array_start and _end symbols
glibc will call these functions correctly, but the kernel will crash.

The reason for the crash is that the kernel implementation of
__gcov_init() which is called from the constructors emitted by GCC's
gcov-profiling code assumes that base kernel facilities (such as printk)
have been initialized and are working as expected. Of course this is not
the case when the function is called by glibc before any kernel init
function was run.

I see multiple ways to go forward:

0. Do nothing

This patch doesn't break anything - it's just only partially effective
in that in enables gcov-kernel profiling for modules, but not for
built-in code.


1. Revert this patch

=> gcov-kernel profiling for kernel modules on UML would no longer work


2. Enable do_ctors() on UML

=> gcov-kernel profiling would work on UML for both kernel modules and
built-in code. There's a risk though that other constructors unrelated
to gcov might be called too late (I saw at least one
register_tm_clones() call while looking at the .init_array section of an
on UML executable). This risk is specific to UML code that runs before
start_kernel(). I'm not sure if there is anything there that consciously
relies on constructors.


3. Change gcov_init() to work without relying on kernel facilities and
add init_array_start and _end symbols to KERNEL_CTORS in
include/asm-generic/vmlinux.lds.h so that glibc can find and run
constructors before start_kernel(). Not sure if this is easily possible.
Certainly this is the option that results in the most amount of work.

=> gcov-kernel profiling would work on UML, any other constructors for
code run before start_kernel() would work, but this would also affect
other kernel code that relies on constructors (currently KASAN)... so
might also have further unwanted side-effects.


Any thoughts, comments or ideas for other alternatives?

> 
>>>
>>> v2:
>>> * special-case UML instead of splitting the CONSTRUCTORS config
>>> ---
>>> init/Kconfig        | 1 -
>>> init/main.c         | 8 +++++++-
>>> kernel/gcov/Kconfig | 2 +-
>>> 3 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index b77c60f8b963..29ad68325028 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -76,7 +76,6 @@ config CC_HAS_ASM_INLINE
>>>
>>> config CONSTRUCTORS
>>> 	bool
>>> -	depends on !UML
>>>
>>> config IRQ_WORK
>>> 	bool
>>> diff --git a/init/main.c b/init/main.c
>>> index c68d784376ca..a626e78dbf06 100644
>>> --- a/init/main.c
>>> +++ b/init/main.c
>>> @@ -1066,7 +1066,13 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>>> /* Call all constructor functions linked into the kernel. */
>>> static void __init do_ctors(void)
>>> {
>>> -#ifdef CONFIG_CONSTRUCTORS
>>> +/*
>>> + * For UML, the constructors have already been called by the
>>> + * normal setup code as it's just a normal ELF binary, so we
>>> + * cannot do it again - but we do need CONFIG_CONSTRUCTORS
>>> + * even on UML for modules.
>>> + */
>>> +#if defined(CONFIG_CONSTRUCTORS) && !defined(CONFIG_UML)
>>> 	ctor_fn_t *fn = (ctor_fn_t *) __ctors_start;
>>>
>>> 	for (; fn < (ctor_fn_t *) __ctors_end; fn++)
>>> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
>>> index 3110c77230c7..f62de2dea8a3 100644
>>> --- a/kernel/gcov/Kconfig
>>> +++ b/kernel/gcov/Kconfig
>>> @@ -4,7 +4,7 @@ menu "GCOV-based kernel profiling"
>>> config GCOV_KERNEL
>>> 	bool "Enable gcov-based kernel profiling"
>>> 	depends on DEBUG_FS
>>> -	select CONSTRUCTORS if !UML
>>> +	select CONSTRUCTORS
>>> 	default n
>>> 	help
>>> 	This option enables gcov-based code profiling (e.g. for code coverage
>>>
>>
>>
>> -- 
>> Peter Oberparleiter
>> Linux on Z Development - IBM Germany


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
