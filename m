Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3668CED9
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 06:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBGFYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 00:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBGFYc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 00:24:32 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F123C76;
        Mon,  6 Feb 2023 21:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1675747458; bh=iufufAo2L+w2AZs187YrZy2mIt/7pr1wc5OIX9c+eLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nxbm9xAoO0HD639dptyUxWu1Ap3/aG58G3WZ43qz/6MZb47k9IblyPYb2jjOZG/2/
         +q+TaFo+gE0j6gGyXk/JAWPLxMZkgAj2W15TVOFEdzrwyZh4w+4hJ6j+y7PT5EPLWe
         rcKJEk6R4/x4OfFrTjw1+PaGSU9yJakGmYMZYP88=
Received: from [192.168.43.185] (unknown [49.78.239.15])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2C5BF60106;
        Tue,  7 Feb 2023 13:24:17 +0800 (CST)
Message-ID: <379bcb55-f75d-02ce-a51b-467e21ade5a3@xen0n.name>
Date:   Tue, 7 Feb 2023 13:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Firefox/111.0 Thunderbird/111.0a1
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        David Laight <David.Laight@ACULAB.COM>,
        'Huacai Chen' <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
 <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
 <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
 <560d73a8-2f2a-4844-44ff-afffad9c8694@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <560d73a8-2f2a-4844-44ff-afffad9c8694@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/2/6 18:28, Jianmin Lv wrote:
> 
> 
> On 2023/2/3 下午4:46, David Laight wrote:
>> From: Huacai Chen
>>> Sent: 03 February 2023 02:01
>>>
>>> Hi, David,
>>>
>>> On Thu, Feb 2, 2023 at 5:01 PM David Laight <David.Laight@aculab.com> 
>>> wrote:
>>>>
>>>> From: Huacai Chen
>>>>> Sent: 02 February 2023 08:43
>>>>>
>>>>> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
>>>>> configurable.
>>>>>
>>>>> Not all LoongArch cores support h/w unaligned access, we can use the
>>>>> -mstrict-align build parameter to prevent unaligned accesses.
>>>>>
>>>>> This option is disabled by default to optimise for performance, but 
>>>>> you
>>>>> can enabled it manually if you want to run kernel on systems 
>>>>> without h/w
>>>>> unaligned access support.
>>>>
>>>> Should there be an associated run-time check during kernel 
>>>> initialisation
>>>> that a kernel compiled without -mstrict-align isn't being run on 
>>>> hardware
>>>> that doesn't support unaligned accesses.
>>>>
>>>> It can be quite a while before you get a compiler-generated 
>>>> misaligned accesses.
>>>
>>> If we don't use -mstrict-align, the kernel cannot be run on hardware
>>> that doesn't support unaligned accesses, so I think the run-time check
>>> is useless, and it has no chance to run the checking.
>>
>> If you don't add the check and someone boots the wrong type of kernel
>> then they'll probably get a panic well after booting.
>> You really do want a check in the bot code.
>>
> Agree, maybe it's reasonable to check it at the beginning of cpu probe 
> stuff.

Yeah I think just performing a deliberate unaligned access very early 
would be enough to stop "weaker" CPUs from continuing in this case.

> 
>> There is also the question of how userspace is compiled.
>> You pretty much don't want to be taking traps to fixup misaligned 
>> accesses.
>> So the default compiler options better include -mstrict-align.
>>
>> You should look at -mno-strict-align being a performance option when
>> running on known hardware, not a default.
>>
>>     David
>>
> I think the key point of the patch is providing users with a high 
> performance kernel for existed and future unaligned-access-supported 
> Loongson CPUs (mainly for destop and server system, also called *big* 
> CPU), which are dominant compared with unaligned-access-unsupported CPUs 
> (mainly for customized embedded system, also called *small* CPU). By 
> this way, we just want to provide *the vast majority of big CPU users* 
> (desktop and server OS) with convenience to directly use high 
> performance kernel without any extra compile option.

Market share and general availability may matter, but again, if you're 
considering end users that most likely don't compile their own kernels, 
Kconfig default or defconfig may not matter after all: distributions 
invariably maintain their own Kconfig. And I think we should follow the 
general principle of "least surprises" -- just make the default value 
most universal. It's not like those comparatively small number of power 
users / developers are not paying attention to the "Emit unaligned 
accesses in kernel for performance" config option.

(Yes I've partially changed my mind after seeing Arnd's suggestion that 
indeed some optimized codepaths can be enabled if we can know the CPU's 
unaligned capability at config time. Now I'm in support of making this 
codegen aspect tunable, but I still think keeping the default as-is 
would be a better idea. It won't regress or surprise anyone and embedded 
people's convenience wouldn't get sacrificed.)

> Instead, for customized embedded system, we have to support them with an extra 
> compile option. So, it seems that we have to reconcile default compile 
> option between small CPU and big CPU, and sacrifice the convenience of 
> small CPU.
> 
> For some specific diffirences with and without -mstrict-align, see:
> https://lore.kernel.org/all/5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn/

As someone who's dabbled with compilers I definitely agree the codegen 
impact and/or performance benefit could be sizable, after all every 
potentially unaligned access must be split into two guaranteed-aligned 
insns if we can't rely on the hardware. But again microbenchmarks could 
at times translate into real-world gains surprisingly poorly, so I still 
think concrete use cases would make a better argument.

But again, since some other known-good optimizations can only be turned 
on at config time, like in the network stack, arguably you don't have to 
come up with this concrete number any more ;)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

