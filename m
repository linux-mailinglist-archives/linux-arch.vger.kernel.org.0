Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7669D68CBC4
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 02:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBGBNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 20:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGBNl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 20:13:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B2C79752;
        Mon,  6 Feb 2023 17:13:39 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.155])
        by gateway (Coremail) with SMTP id _____8DxTuvCpeFjuF0PAA--.30309S3;
        Tue, 07 Feb 2023 09:13:38 +0800 (CST)
Received: from [10.20.42.155] (unknown [10.20.42.155])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxaL3CpeFjTCsrAA--.17069S3;
        Tue, 07 Feb 2023 09:13:38 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
        WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
 <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
 <b1809500e4d55564a1084a3014fb9603ba3d1438.camel@xry111.site>
 <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
 <b9f274ad-591b-40b5-9441-a45fe67b5b8d@app.fastmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <85c36350-34d2-d333-8e47-255914d3fdaa@loongson.cn>
Date:   Tue, 7 Feb 2023 09:13:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b9f274ad-591b-40b5-9441-a45fe67b5b8d@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxaL3CpeFjTCsrAA--.17069S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw1UGF15uw45tr1kCF13XFb_yoW8tFykpa
        yYkF9FkF1DJr18Aay0y34rWFWYvw18Kw15W3W0g3s8Wr1qgF92qFW2qw1ruFWrKw1xCw12
        vFy0q3W7ur4jyaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/2/6 下午9:22, Arnd Bergmann wrote:
> On Mon, Feb 6, 2023, at 14:13, Jianmin Lv wrote:
>> On 2023/2/6 下午7:18, Xi Ruoyao wrote:
>>> On Mon, 2023-02-06 at 18:24 +0800, Jianmin Lv wrote:
>>>> Hi, Xuerui
>>>>
>>>> I think the kernels produced with and without -mstrict-align have mainly
>>>> following differences:
>>>> - Diffirent size. I build two kernls (vmlinux), size of kernel with
>>>> -mstrict-align is 26533376 bytes and size of kernel without
>>>> -mstrict-align is 26123280 bytes.
>>>> - Diffirent performance. For example, in kernel function jhash(), the
>>>> assemble code slices with and without -mstrict-align are following:
>>>
>>> But there are still questions remaining:
>>>
>>> (1) Is the difference contributed by a bad code generation of GCC?  If
>>> true, it's better to improve GCC before someone starts to build a distro
>>> for LA264 as it would benefit the user space as well.
>>>
>> AFAIK, GCC builds to produce unaligned-access-enabled target binary by
>> default (without -mstrict-align) for improving user space performance
>> (small size and runtime high performance), which is also based the fact
>> that the vast majority of LoongArch CPUs support unaligned-access.
>>
>>> (2) Is there some "big bad unaligned access loop" on a hot spot in the
>>> kernel code?  If true, it may be better to just refactor the C code
>>> because doing so will benefit all ports, not only LoongArch.  Otherwise,
>>> it may be unworthy to optimize for some cold paths.
>>>
>> Frankly, I'm not sure if there is this kind of hot code in kernel, I
>> just see the difference from different kernel size and different
>> assemble code slice. And I'm afraid that it may be difficult to judge
>> whether it is reasonable hot code or not if exists.
> 
> Just look for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, this will
> show you code locations that use different implementations based on
> whether the kernel should run on CPUs without unaligned access or
> not.
> 
>        Arnd
> 

Got it, thank you very much, I greped 
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and found many matched cases 
including driver, lib, net and so on, it seems that it's reasonable to 
use high performance way for CPUs with HAVE_EFFICIENT_UNALIGNED_ACCESS 
configured.


