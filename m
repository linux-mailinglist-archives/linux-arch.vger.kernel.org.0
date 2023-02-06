Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30568BA1C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjBFK2l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 05:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBFK2d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 05:28:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A2532004F;
        Mon,  6 Feb 2023 02:28:30 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.155])
        by gateway (Coremail) with SMTP id _____8CxvOpN1uBj4CEPAA--.30092S3;
        Mon, 06 Feb 2023 18:28:29 +0800 (CST)
Received: from [10.20.42.155] (unknown [10.20.42.155])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxY+VM1uBjZNMqAA--.47566S3;
        Mon, 06 Feb 2023 18:28:28 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     David Laight <David.Laight@ACULAB.COM>,
        'Huacai Chen' <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
 <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
 <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <560d73a8-2f2a-4844-44ff-afffad9c8694@loongson.cn>
Date:   Mon, 6 Feb 2023 18:28:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxY+VM1uBjZNMqAA--.47566S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFWxAr4xGF47Xr18Wr4xtFb_yoW5WFW5pa
        y0ya48KrWqyr1Fgwsrta48JFWYvayfG345Cw18try3Cr909Fyjq3yavF1UCF98Kws7W34j
        qryjvFy293WDAFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/2/3 下午4:46, David Laight wrote:
> From: Huacai Chen
>> Sent: 03 February 2023 02:01
>>
>> Hi, David,
>>
>> On Thu, Feb 2, 2023 at 5:01 PM David Laight <David.Laight@aculab.com> wrote:
>>>
>>> From: Huacai Chen
>>>> Sent: 02 February 2023 08:43
>>>>
>>>> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
>>>> configurable.
>>>>
>>>> Not all LoongArch cores support h/w unaligned access, we can use the
>>>> -mstrict-align build parameter to prevent unaligned accesses.
>>>>
>>>> This option is disabled by default to optimise for performance, but you
>>>> can enabled it manually if you want to run kernel on systems without h/w
>>>> unaligned access support.
>>>
>>> Should there be an associated run-time check during kernel initialisation
>>> that a kernel compiled without -mstrict-align isn't being run on hardware
>>> that doesn't support unaligned accesses.
>>>
>>> It can be quite a while before you get a compiler-generated misaligned accesses.
>>
>> If we don't use -mstrict-align, the kernel cannot be run on hardware
>> that doesn't support unaligned accesses, so I think the run-time check
>> is useless, and it has no chance to run the checking.
> 
> If you don't add the check and someone boots the wrong type of kernel
> then they'll probably get a panic well after booting.
> You really do want a check in the bot code.
> 
Agree, maybe it's reasonable to check it at the beginning of cpu probe 
stuff.

> There is also the question of how userspace is compiled.
> You pretty much don't want to be taking traps to fixup misaligned accesses.
> So the default compiler options better include -mstrict-align.
> 
> You should look at -mno-strict-align being a performance option when
> running on known hardware, not a default.
> 
> 	David
> 
I think the key point of the patch is providing users with a high 
performance kernel for existed and future unaligned-access-supported 
Loongson CPUs (mainly for destop and server system, also called *big* 
CPU), which are dominant compared with unaligned-access-unsupported CPUs 
(mainly for customized embedded system, also called *small* CPU). By 
this way, we just want to provide *the vast majority of big CPU users* 
(desktop and server OS) with convenience to directly use high 
performance kernel without any extra compile option. Instead, for 
customized embedded system, we have to support them with an extra 
compile option. So, it seems that we have to reconcile default compile 
option between small CPU and big CPU, and sacrifice the convenience of 
small CPU.

For some specific diffirences with and without -mstrict-align, see:
https://lore.kernel.org/all/5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn/

Thanks!
Jianmin


> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

