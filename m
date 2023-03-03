Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173156A903E
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 05:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCCEap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 23:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCCEao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 23:30:44 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88822DEF;
        Thu,  2 Mar 2023 20:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677817838; bh=ACQD43d0AOgkJQffrIDqolBmi9goAho/+WKSzK28JHw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A3u/I/aMYzg9Gpt2xqwDquEnREVnd7wJ7DjrO8gl/hCULrx7vJNrhhqf0yXC8OUI5
         alWcN/sIq62gRLOb+3laHDDGrnRRYsKDI7IGy7tJU36D5yc7OjloJqr2RBS9t16OyN
         y4lP6YaDFr2EogAWE955R+cHNMNetK72M8YZU1w8=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E0C4560087;
        Fri,  3 Mar 2023 12:30:37 +0800 (CST)
Message-ID: <8b82786b-d810-a3c0-7919-e602e9e53de5@xen0n.name>
Date:   Fri, 3 Mar 2023 12:30:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Fix the CRC32 feature probing
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230303002508.2891681-1-chenhuacai@loongson.cn>
 <480ab341-6437-e409-8779-c4938924fd64@xen0n.name>
 <CAAhV-H7NYCdqXGwvmVqR8Njw=kDpBdCq+QRzPFGxR5zjHcdZ9g@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H7NYCdqXGwvmVqR8Njw=kDpBdCq+QRzPFGxR5zjHcdZ9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/3/3 11:55, Huacai Chen wrote:
> Hi, Xuerui,
> 
> On Fri, Mar 3, 2023 at 11:15 AM WANG Xuerui <kernel@xen0n.name> wrote:
>>
>> On 2023/3/3 08:25, Huacai Chen wrote:
>>> Not all LoongArch processors support CRC32 instructions, and this feature
>>> is indicated by CPUCFG1.CRC32 (Bit25). This bit is wrongly defined in loongarch.h
>>
>> The ISA manual suggests it's IOCSR_BRD (likely "IOCSR Branding"). You
>> have to somehow reconcile the two, either by fixing the manuals, or
>> mention here explicitly that the manual is wrong. (Actually thinking
>> about it harder now, you may be in fact re-purposing the IOCSR_BRD field
>> for CRC32 capability, because all LoongArch cores in existence are
>> designed by Loongson, and you may very well know that all cores
>> supporting CRC32 have this bit set, and those not having CRC32 haven't.
>> If that's the case, please explicitly document this reasoning too.)
> The ISA manual has been modified and will be released soon.

I'm wary of Loongson official statements like this but let's see... 
meanwhile the commit message and/or comments could be improved 
nevertheless, to provide more background.

Also I've just noticed the patch title sounds unnatural too. "Fix 
probing of the CRC32 feature" or dropping "the" from the current wording 
sounds better IMO.

>>> and CRC32 is set unconditionally now, so fix it.
>>>
>>> BTW, expose the CRC32 feature in /proc/cpuinfo.
>>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>    arch/loongarch/include/asm/cpu-features.h |  1 +
>>>    arch/loongarch/include/asm/cpu.h          | 40 ++++++++++++-----------
>>>    arch/loongarch/include/asm/loongarch.h    |  2 +-
>>>    arch/loongarch/kernel/cpu-probe.c         |  7 +++-
>>>    arch/loongarch/kernel/proc.c              |  1 +
>>>    5 files changed, 30 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
>>> index b07974218393..f6177f133477 100644
>>> --- a/arch/loongarch/include/asm/cpu-features.h
>>> +++ b/arch/loongarch/include/asm/cpu-features.h
>>> @@ -42,6 +42,7 @@
>>>    #define cpu_has_fpu         cpu_opt(LOONGARCH_CPU_FPU)
>>>    #define cpu_has_lsx         cpu_opt(LOONGARCH_CPU_LSX)
>>>    #define cpu_has_lasx                cpu_opt(LOONGARCH_CPU_LASX)
>>> +#define cpu_has_crc32                cpu_opt(LOONGARCH_CPU_CRC32)
>>>    #define cpu_has_complex             cpu_opt(LOONGARCH_CPU_COMPLEX)
>>>    #define cpu_has_crypto              cpu_opt(LOONGARCH_CPU_CRYPTO)
>>>    #define cpu_has_lvz         cpu_opt(LOONGARCH_CPU_LVZ)
>>> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
>>> index c3da91759472..ca9e2be571ec 100644
>>> --- a/arch/loongarch/include/asm/cpu.h
>>> +++ b/arch/loongarch/include/asm/cpu.h
>>> @@ -78,25 +78,26 @@ enum cpu_type_enum {
>>>    #define CPU_FEATURE_FPU                     3       /* CPU has FPU */
>>>    #define CPU_FEATURE_LSX                     4       /* CPU has LSX (128-bit SIMD) */
>>>    #define CPU_FEATURE_LASX            5       /* CPU has LASX (256-bit SIMD) */
>>> -#define CPU_FEATURE_COMPLEX          6       /* CPU has Complex instructions */
>>> -#define CPU_FEATURE_CRYPTO           7       /* CPU has Crypto instructions */
>>> -#define CPU_FEATURE_LVZ                      8       /* CPU has Virtualization extension */
>>> -#define CPU_FEATURE_LBT_X86          9       /* CPU has X86 Binary Translation */
>>> -#define CPU_FEATURE_LBT_ARM          10      /* CPU has ARM Binary Translation */
>>> -#define CPU_FEATURE_LBT_MIPS         11      /* CPU has MIPS Binary Translation */
>>> -#define CPU_FEATURE_TLB                      12      /* CPU has TLB */
>>> -#define CPU_FEATURE_CSR                      13      /* CPU has CSR */
>>> -#define CPU_FEATURE_WATCH            14      /* CPU has watchpoint registers */
>>> -#define CPU_FEATURE_VINT             15      /* CPU has vectored interrupts */
>>> -#define CPU_FEATURE_CSRIPI           16      /* CPU has CSR-IPI */
>>> -#define CPU_FEATURE_EXTIOI           17      /* CPU has EXT-IOI */
>>> -#define CPU_FEATURE_PREFETCH         18      /* CPU has prefetch instructions */
>>> -#define CPU_FEATURE_PMP                      19      /* CPU has perfermance counter */
>>> -#define CPU_FEATURE_SCALEFREQ                20      /* CPU supports cpufreq scaling */
>>> -#define CPU_FEATURE_FLATMODE         21      /* CPU has flat mode */
>>> -#define CPU_FEATURE_EIODECODE                22      /* CPU has EXTIOI interrupt pin decode mode */
>>> -#define CPU_FEATURE_GUESTID          23      /* CPU has GuestID feature */
>>> -#define CPU_FEATURE_HYPERVISOR               24      /* CPU has hypervisor (running in VM) */
>>> +#define CPU_FEATURE_CRC32            6       /* CPU has Complex instructions */
>>
>> "CPU has CRC32 instructions".
>>
>> Also, the diff damage is real, is there any reason this must come here
>> and not last? To me "aesthetics" is not enough to justify such a diff
>> damage.
> To keep CPU_FEATURE and elf_hwcap in the same order.

IMO they don't have to. You could split into two commits so the mass 
reordering could happen separately, making each change nicely focused.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

