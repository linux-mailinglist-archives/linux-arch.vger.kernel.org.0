Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4448F477145
	for <lists+linux-arch@lfdr.de>; Thu, 16 Dec 2021 13:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhLPMDw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Dec 2021 07:03:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28323 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhLPMDv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Dec 2021 07:03:51 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JF9kB1hZdzbj7K;
        Thu, 16 Dec 2021 20:03:30 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 20:03:49 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 16 Dec
 2021 20:03:47 +0800
Subject: Re: [Question] About SECCOMP issue for ILP32
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Chris Metcalf" <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        <bobo.shaobowang@huawei.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <30b491ad-a7e1-f7b5-26b8-2cfffc81a080@huawei.com>
 <CAAH8bW_p3LJPgOoJgUHt6O0run+LB2RbjnAVpeLn_KCAZKNR+A@mail.gmail.com>
 <695fc573-25ce-b2e5-e61c-140d9ee241e2@huawei.com>
Message-ID: <a4688336-f6ab-a662-f1b0-d6e95d4aebd5@huawei.com>
Date:   Thu, 16 Dec 2021 20:03:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <695fc573-25ce-b2e5-e61c-140d9ee241e2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yury,

On 2020/9/1 19:40, Xiongfeng Wang wrote:
> 
> 
> On 2020/9/1 2:15, Yury Norov wrote:
>> On Mon, Aug 31, 2020 at 5:48 AM Xiongfeng Wang
>> <wangxiongfeng2@huawei.com> wrote:
>>>
>>> Hi Yury,
>>>
>>
>> Hi Xiongfeng,
>>
>> [restore CC list]
>>
>> Haven't seen this before. What kernel / glibc / ltp do you use?
> 
> The kernel version is 4.19. I applied the ILP32 patches from
> https://github.com/norov/linux.git. The glibc version is 2.28 and I applyed the
> ILP32 patches.
> The ltp testsuite is from https://github.com/linux-test-project/ltp. I build it
> with '-mabi=ilp32'.
> 
>>
>>> We were testing the ILP32 feature and came accross a problem. Very apperaciate
>>> it if you could give us some help !
>>>
>>> We compile the LTP testsuite with '-mabi=ilp32' and run it on a machine with
>>> kernel and glibc applied with ILP32 patches. But we failed on one testcase,
>>> prctl04. It print the following error info.
>>> 'prctl04.c:199: FAIL: SECCOMP_MODE_STRICT doesn't permit read(2) write(2) and
>>> _exit(2)'
>>>
>>> The testcase is like below, syscall 'prctl' followed by a syscall 'write'.
>>> prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT);
>>> SAFE_WRITE(1, fd, "a", 1);
>>>
>>> When we execute syscall 'write', we receive a SIGKILL. It's not as expected.
>>> We track the kernel and found out it is because we failed the syscall_whitelist
>>> check in '__secure_computing_strict'. Because flag 'TIF_32BIT_AARCH64' is set,
>>> we falls into the 'in_compat_syscall()' branch. We compare the parameter
>>> 'this_syscall' with return value of 'get_compat_model_syscalls()'
>>> The syscall number of '__NR_write' for ilp32 application is 64, but it is 4 for
>>> 'model_syscalls_32' returned from 'get_compat_model_syscalls()'
>>> So '__secure_computing_strict' retuned with 'do_exit(SIGKILL)'. We have a
>>> modification like below, but I am not sure if it correct or not.
>>>
>>> --- a/kernel/seccomp.c
>>> +++ b/kernel/seccomp.c
>>> @@ -618,7 +618,7 @@ static void __secure_computing_strict(int this_syscall)
>>>  {
>>>         const int *syscall_whitelist = mode1_syscalls;
>>>  #ifdef CONFIG_COMPAT
>>> -       if (in_compat_syscall())
>>> +       if (is_a32_compat_task())
>>>                 syscall_whitelist = get_compat_mode1_syscalls();
>>
>> It calls the arch function from generic code. It may break build for
>> other arches.
>> This also looks dangerous because it treats ILP32 execution as non-compat.
>>
>> The right approach would be implementing arch-specific
>> get_compat_mode1_syscalls()
>> in arch/arm64/include/asm/seccomp.h that returns an appropriate table.
>> Refer MIPS
>> code for this: arch/mips/include/asm/seccomp.h
> 
> Thanks for your advice. Thanks a lot.
> I have written another version according to your advice.
> 
> --- a/arch/arm64/include/asm/seccomp.h
> +++ b/arch/arm64/include/asm/seccomp.h
> @@ -20,6 +20,36 @@
>  #define __NR_seccomp_sigreturn_32      __NR_compat_rt_sigreturn
>  #endif /* CONFIG_COMPAT */
> 
> +#ifdef CONFIG_COMPAT
> +#ifndef __COMPAT_SYSCALL_NR
> +
> +static inline const int *get_compat_mode1_syscalls(void)
> +{
> +#ifdef CONFIG_AARCH32_EL0
> +       static const int mode1_syscalls_a32[] = {
> +               __NR_compat_read, __NR_compat_write,
> +               __NR_compat_read, __NR_compat_sigreturn,

A little fix here. It should be
  __NR_compat_exit, __NR_compat_sigreturn,
Sorry, my fault.

Thanks,
Xiongfeng

> +               0, /* null terminated */
> +       };
> +#endif
> +       static const int mode1_syscalls_ilp32[] = {
> +               __NR_read, __NR_write,
> +               __NR_exit, __NR_rt_sigreturn,
> +               0, /* null terminated */
> +       };
> +
> +       if (is_ilp32_compat_task())
> +               return mode1_syscalls_ilp32;
> +#ifdef CONFIG_AARCH32_EL0
> +       return mode1_syscalls_a32;
> +#endif
> +}
> +
> +#define get_compat_mode1_syscalls get_compat_mode1_syscalls
> +
> +#endif
> +#endif
> +
>  #include <asm-generic/seccomp.h>
> 
>  #endif /* _ASM_SECCOMP_H */
> 
> 
> Thanks,
> Xiongfeng
> 
>>
>> Thanks,
>> Yury
>>
>>>  #endif
>>>         do {
>>>
>>>
>>> Thanks,
>>> Xiongfeng
>>>
>>
>> .
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 
