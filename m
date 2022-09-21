Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E55BFD5F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIUL4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIUL43 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 07:56:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F656895F8;
        Wed, 21 Sep 2022 04:56:27 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXcGV1RtnzlVwt;
        Wed, 21 Sep 2022 19:52:18 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 19:56:25 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 19:56:25 +0800
Message-ID: <df9590bc-1a61-28c0-55eb-9f9539d03144@huawei.com>
Date:   Wed, 21 Sep 2022 19:56:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
CC:     <arnd@arndb.de>, <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>,
        <conor.dooley@microchip.com>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mark.rutland@arm.com>,
        <zouyipeng@huawei.com>, <bigeasy@linutronix.de>,
        <David.Laight@aculab.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-9-guoren@kernel.org>
 <afa17bdd-2d11-4015-6e2a-7a39db931d09@huawei.com>
 <CAJF2gTRMt4zDQcvBOxge-4+6o1mqhWds_AiFKamdCzKJZfoKPw@mail.gmail.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CAJF2gTRMt4zDQcvBOxge-4+6o1mqhWds_AiFKamdCzKJZfoKPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Sorry to bother again, I just finished the test with your patches on 
mine patch set.

On 2022/9/21 17:53, Guo Ren wrote:
> On Wed, Sep 21, 2022 at 4:34 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>> Hi,
>>
>> On 2022/9/18 23:52, guoren@kernel.org wrote:
>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>> index 5f49517cd3a2..426529b84db0 100644
>>> --- a/arch/riscv/kernel/entry.S
>>> +++ b/arch/riscv/kernel/entry.S
>>> @@ -332,6 +332,33 @@ ENTRY(ret_from_kernel_thread)
>>>        tail syscall_exit_to_user_mode
>>>    ENDPROC(ret_from_kernel_thread)
>>>
>>> +#ifdef CONFIG_IRQ_STACKS
>>> +ENTRY(call_on_stack)
>>> +     /* Create a frame record to save our ra and fp */
>>> +     addi    sp, sp, -RISCV_SZPTR
>>> +     REG_S   ra, (sp)
>>> +     addi    sp, sp, -RISCV_SZPTR
>>> +     REG_S   fp, (sp)
>>> +
>>> +     /* Save sp in fp */
>>> +     move    fp, sp
>>> +

Considering that s0 points to previous sp normally, I think here we 
should have 'addi fp, sp, 2*RISCV_SZPTR'.

An example below:

     addi    sp, sp, -16
     sd  ra, 8(sp)
     sd  s0, 0(sp)
     addi    s0, sp, 16    <- s0 is set to previous sp
     ...

     ld  ra,8(sp)
     ld  s0,0(sp)
     addi    sp,sp,16

So maybe it's better to save the stack frame as below:

     addi    sp, sp, -2*RISCV_SZPTR
     REG_S   ra, RISCV_SZPTR(sp)
     REG_S   s0, (sp)

     /* Save sp in fp */
     addi    s0, sp, 2*RISCV_SZPTR

     ...

     /*
      * Restore sp from prev fp, and fp, ra from the frame
      */
     addi    sp, s0, -2*RISCV_SZPTR
     REG_L   ra, RISCV_SZPTR(sp)
     REG_L   s0, (sp)
     addi    sp, sp, 2*RISCV_SZPTR


Anyway, lets set fp as sp + 2 * RISCV_SZPTR, so that unwinder can 
connect two stacks same as normal function.

I tested this with my patch and the unwinder works properly.


Thanks for your time!

Best,

Chen

>>> +     /* Move to the new stack and call the function there */
>>> +     li      a3, IRQ_STACK_SIZE
>>> +     add     sp, a1, a3
>>> +     jalr    a2
>>> +
>>> +     /*
>>> +      * Restore sp from prev fp, and fp, ra from the frame
>>> +      */
>>> +     move    sp, fp
>>> +     REG_L   fp, (sp)
>>> +     addi    sp, sp, RISCV_SZPTR
>>> +     REG_L   ra, (sp)
>>> +     addi    sp, sp, RISCV_SZPTR
>>> +     ret
>>> +ENDPROC(call_on_stack)
>>> +#endif
>> Seems my compiler (riscv64-linux-gnu-gcc 8.4.0, cross compiling from
>> x86) cannot recognize the register `fp`.
> The whole entry.S uses s0 instead of fp, so I approve of your advice. Thx.
>
>> After I changed it to `s0` this can pass compiling.
>>
>>
>> Seems there is nowhere else using `fp`, can this just using `s0` instead?
>>
>> Best,
>>
>> Chen
>>
>>
