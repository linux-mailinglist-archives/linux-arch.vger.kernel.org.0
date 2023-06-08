Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D472781A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjFHHEf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 03:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjFHHE3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 03:04:29 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40B8826B9;
        Thu,  8 Jun 2023 00:04:18 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_+twfYFkNXIAAA--.1855S3;
        Thu, 08 Jun 2023 15:04:16 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC8ptfYFk49MGAA--.13616S3;
        Thu, 08 Jun 2023 15:04:14 +0800 (CST)
Subject: Re: [RFC PATCH] asm-generic: Unify uapi bitsperlong.h
To:     Arnd Bergmann <arnd@arndb.de>
References: <1683615903-10862-1-git-send-email-yangtiezhu@loongson.cn>
 <b9624545-2c80-49a1-ac3c-39264a591f7b@app.fastmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <76d3be65-91df-7969-5303-38231a7df926@loongson.cn>
Date:   Thu, 8 Jun 2023 15:04:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <b9624545-2c80-49a1-ac3c-39264a591f7b@app.fastmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxC8ptfYFk49MGAA--.13616S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1UJry5Ww1rXr47ZrW8AFc_yoW5Ww1UpF
        47Jw12gF4qkr1ftrn7Gw47Za45Jwn3Ka1ak39agryxZFW5Wry7trZF9rWagFykXrW8tF4q
        vrZ8tryjkay8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
        wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxV
        AFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
        1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjxUc9mRUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

On 05/09/2023 05:37 PM, Arnd Bergmann wrote:
> On Tue, May 9, 2023, at 09:05, Tiezhu Yang wrote:
>> Now we specify the minimal version of GCC as 5.1 and Clang/LLVM as 11.0.0
>> in Documentation/process/changes.rst, __CHAR_BIT__ and __SIZEOF_LONG__ are
>> usable, just define __BITS_PER_LONG as (__CHAR_BIT__ * __SIZEOF_LONG__) in
>> asm-generic uapi bitsperlong.h, simpler, works everywhere.
>>
>> Remove all the arch specific uapi bitsperlong.h which will be generated as
>> arch/*/include/generated/uapi/asm/bitsperlong.h.
>>
>> Suggested-by: Xi Ruoyao <xry111@xry111.site>
>> Link:
>> https://lore.kernel.org/all/d3e255e4746de44c9903c4433616d44ffcf18d1b.camel@xry111.site/
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> I originally introduced the bitsperlong.h header, and I'd love to
> see it removed if it's no longer needed. Your patch certainly
> seems like it does this well.
>
> There is one minor obstacle to this, which is that the compiler
> requirements for uapi headers are not the same as for kernel
> internal code. In particular, the uapi headers may be included
> by user space code that is built with an older compiler version,
> or with a compiler that is not gcc or clang.
>
> I think we are completely safe on the architectures that were
> added since the linux-3.x days (arm64, riscv, csky, openrisc,
> loongarch, nios2, and hexagon), but for the older ones there
> is a regression risk. Especially on targets that are not that
> actively maintained (sparc, alpha, ia64, sh, ...) there is
> a good chance that users are stuck on ancient toolchains.
>
> It's probably also a safe assumption that anyone with an older
> libc version won't be using the latest kernel headers, so
> I think we can still do this across architectures if both
> glibc and musl already require a compiler that is new enough,
> or alternatively if we know that the kernel headers require
> a new compiler for other reasons and nobody has complained.
>
> For glibc, it looks the minimum compiler version was raised
> from gcc-5 to gcc-8 four years ago, so we should be fine.
>
> In musl, the documentation states that at least gcc-3.4 or
> clang-3.2 are required, which probably predate the
> __SIZEOF_LONG__ macro. On the other hand, musl was only
> released in 2011, and building musl itself explicitly
> does not require kernel uapi headers, so this may not
> be too critical.
>
> There is also uClibc, but I could not find any minimum
> supported compiler version for that. Most commonly, this
> one is used for cross-build environments, so it's also
> less likely to have libc/gcc/headers being wildly out of
> sync. Not sure.
>
>       Arnd
>
> [1] https://sourceware.org/pipermail/libc-alpha/2019-January/101010.html
>

Thanks Arnd for the detailed reply.
Any more comments? What should I do in the next step?

Thanks,
Tiezhu

