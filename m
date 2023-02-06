Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24F68BD8F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBFNN1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 08:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBFNN0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 08:13:26 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9715DDBEC;
        Mon,  6 Feb 2023 05:13:24 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.155])
        by gateway (Coremail) with SMTP id _____8CxOury_OBjyCsPAA--.29586S3;
        Mon, 06 Feb 2023 21:13:22 +0800 (CST)
Received: from [10.20.42.155] (unknown [10.20.42.155])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxyr3y_OBjieMqAA--.17090S3;
        Mon, 06 Feb 2023 21:13:22 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
 <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
 <b1809500e4d55564a1084a3014fb9603ba3d1438.camel@xry111.site>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
Date:   Mon, 6 Feb 2023 21:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b1809500e4d55564a1084a3014fb9603ba3d1438.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxyr3y_OBjieMqAA--.17090S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw18Cw4DJry3Xw45AFyfXrb_yoW8Wr4xpa
        ya9rnFkF1DAr18Cay8t348XFWavw1UKw15Ca40q3s5uFyjqF92qFWaq3yruFW3Kw1Ik3Wj
        vFy0q34xuw4qyaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8CksDUUUUU==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/2/6 下午7:18, Xi Ruoyao wrote:
> On Mon, 2023-02-06 at 18:24 +0800, Jianmin Lv wrote:
>> Hi, Xuerui
>>
>> I think the kernels produced with and without -mstrict-align have mainly
>> following differences:
>> - Diffirent size. I build two kernls (vmlinux), size of kernel with
>> -mstrict-align is 26533376 bytes and size of kernel without
>> -mstrict-align is 26123280 bytes.
>> - Diffirent performance. For example, in kernel function jhash(), the
>> assemble code slices with and without -mstrict-align are following:
> 
> But there are still questions remaining:
> 
> (1) Is the difference contributed by a bad code generation of GCC?  If
> true, it's better to improve GCC before someone starts to build a distro
> for LA264 as it would benefit the user space as well.
> 
AFAIK, GCC builds to produce unaligned-access-enabled target binary by 
default (without -mstrict-align) for improving user space performance 
(small size and runtime high performance), which is also based the fact 
that the vast majority of LoongArch CPUs support unaligned-access.

> (2) Is there some "big bad unaligned access loop" on a hot spot in the
> kernel code?  If true, it may be better to just refactor the C code
> because doing so will benefit all ports, not only LoongArch.  Otherwise,
> it may be unworthy to optimize for some cold paths.
> 
Frankly, I'm not sure if there is this kind of hot code in kernel, I 
just see the difference from different kernel size and different 
assemble code slice. And I'm afraid that it may be difficult to judge 
whether it is reasonable hot code or not if exists.

