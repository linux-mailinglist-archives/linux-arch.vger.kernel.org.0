Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC068CBED
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 02:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBGB1a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 20:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBGB13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 20:27:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B92062BF0A;
        Mon,  6 Feb 2023 17:27:27 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.155])
        by gateway (Coremail) with SMTP id _____8Cxe+r+qOFjhV4PAA--.29870S3;
        Tue, 07 Feb 2023 09:27:26 +0800 (CST)
Received: from [10.20.42.155] (unknown [10.20.42.155])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF739qOFjhiwrAA--.17524S3;
        Tue, 07 Feb 2023 09:27:25 +0800 (CST)
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
 <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
 <74ffc2c05475c6af391b87a06df477ae390cc45c.camel@xry111.site>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <85fb9d71-b956-3d3e-f279-1310eec8e5c9@loongson.cn>
Date:   Tue, 7 Feb 2023 09:27:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <74ffc2c05475c6af391b87a06df477ae390cc45c.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF739qOFjhiwrAA--.17524S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFyftFWDGFWktFW8Gr17Jrb_yoW8Cry5pa
        y2kasIkFnrXr10kayIk3yUXFZ0v3WkCr15Cr1rGryYgr1Y9a4IgFWIq3Z8WasrCw1Ikw12
        qr1Iq3W7uwsrAFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/2/6 下午9:30, Xi Ruoyao wrote:
> On Mon, 2023-02-06 at 21:13 +0800, Jianmin Lv wrote:
>>> (1) Is the difference contributed by a bad code generation of GCC?  If
>>> true, it's better to improve GCC before someone starts to build a distro
>>> for LA264 as it would benefit the user space as well.
>>>
>> AFAIK, GCC builds to produce unaligned-access-enabled target binary by
>> default (without -mstrict-align) for improving user space performance
>> (small size and runtime high performance), which is also based the fact
>> that the vast majority of LoongArch CPUs support unaligned-access.
> 
> I mean: if someone starts to build a distro for a less-capable LoongArch
> processor, (s)he will need an entire user space compiled with -mstrict-
> align.  So it would be better to start preparation now.
> 
> And it's likely (s)he will either submit a GCC patch to make GCC
> enable/disable -mstrict-align based on the -march= (--with-arch at
> configure time) value, or hack GCC to enable -mstrict-align by default
> for the distro.  So I think we'll also need:
> 
>> +ifdef CONFIG_ARCH_STRICT_ALIGN may enable strict align by default.
>>   # Don't emit unaligned accesses.
>>   # Not all LoongArch cores support unaligned access, and as kernel we can't
>>   # rely on others to provide emulation for these accesses.
>>   KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>    +else
>    +# Distros designed for running on both kind of processors may disable
>    +# strict align by default, but the user may want a no-strict-align
>    +# kernel for his/her specific hardware.
>     KBUILD_CFLAGS += $(call cc-option,-mno-strict-align)
>> +endif
> 

Thanks, Ruoyao, I think it's good suggestion. After talking about it 
with GCC colleague, it's very likely make GCC enable/disable 
-mstrict-align based on the -march= in future, just as you said.

