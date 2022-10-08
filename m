Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8515F82A5
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 05:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJHDKo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 23:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHDKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 23:10:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16160A2222;
        Fri,  7 Oct 2022 20:10:38 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MkqnW5LF8zlXhx;
        Sat,  8 Oct 2022 11:06:07 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 11:10:36 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 8 Oct
 2022 11:10:36 +0800
Message-ID: <6b4ccb6b-c6c2-e0cc-1670-1776877ecf46@huawei.com>
Date:   Sat, 8 Oct 2022 11:10:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3] ARM: kprobes: move __kretprobe_trampoline to out of
 line assembler
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <llvm@lists.linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>,
        <regressions@lists.linux.dev>, <lkft-triage@lists.linaro.org>,
        "Linux Kernel Functional Testing" <lkft@linaro.org>,
        Logan Chien <loganchien@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
References: <202209291607.0MlscIht-lkp@intel.com>
 <20220930211505.209939-1-ndesaulniers@google.com>
 <CAKwvOd=0p31f-Yya6S-9xKEv6CtUWpOCRxHO=jG2uk-hZgZ1bQ@mail.gmail.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CAKwvOd=0p31f-Yya6S-9xKEv6CtUWpOCRxHO=jG2uk-hZgZ1bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Sorry for late reply because I just found this thread before the long 
vacation so I didn't have much time to deal with it.

On 2022/10/7 4:35, Nick Desaulniers wrote:
> On Fri, Sep 30, 2022 at 2:15 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> commit 1069c1dd20a3 ("ARM: 9231/1: Recover kretprobes return address for
>> EABI stack unwinder")
>> tickled a bug in clang's integrated assembler where the .save and .pad
>> directives must have corresponding .fnstart directives. The integrated
>> assembler is unaware that the compiler will be generating the .fnstart
>> directive.
>>
>>    arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
>>    .save or .vsave directives
>>    <inline asm>:3:2: note: instantiated into assembly here
>>    .save   {sp, lr, pc}
>>    ^
>>    arch/arm/probes/kprobes/core.c:412:29: error: .fnstart must precede
>>    .pad directive
>>    <inline asm>:6:2: note: instantiated into assembly here
>>    .pad    #52
>>    ^
>>
> Chen, I noticed that your patch was discarded; it's not in linux-next today.
> https://lore.kernel.org/linux-arm-kernel/YzHPGvhLkdQcDYzx@shell.armlinux.org.uk/
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9231/1
> How would you like to proceed here?

Since 6.1 is closing now. Let's reorganize everything and queue it up 
for -next for 6.2

> I think moving this out of line, incorporating Ard's feedback, then
> putting the UNWIND directives on top might be the way to go. What do
> you think?

This way looks good to me.

How about making a set for this,  to make everything more clear:

1. Move this out of line

2. Apply the feature, test with gcc & clang

3. Other cleaning, or merge with 2 if the cleaning is tiny.

I'll send another version for this, rebased to 6.1-rc1

Thanks for your time!


Best,

Chen


