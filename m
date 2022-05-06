Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75E51CEFA
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 04:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355450AbiEFCWE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 22:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388305AbiEFCV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 22:21:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC44160045;
        Thu,  5 May 2022 19:18:16 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KvZ2Z0Vtsz1JBmW;
        Fri,  6 May 2022 10:17:10 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 10:18:15 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:18:14 +0800
Message-ID: <51ce37b5-f527-9743-36d3-50247cb0939f@huawei.com>
Date:   Fri, 6 May 2022 10:18:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <jthierry@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <jpoimboe@redhat.com>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ardb@kernel.org>, <maz@kernel.org>, <tglx@linutronix.de>,
        <luc.vanoostenryck@gmail.com>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-23-chenzhongjin@huawei.com>
 <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
 <a57f7d73-6e01-8f41-9be3-8e90807ec08f@huawei.com>
 <20220505092448.GE2501@worktop.programming.kicks-ass.net>
 <YnOtbYOIT5OP7F0g@FVFF77S0Q05N.cambridge.arm.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YnOtbYOIT5OP7F0g@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/5/5 18:56, Mark Rutland wrote:
> On Thu, May 05, 2022 at 11:24:48AM +0200, Peter Zijlstra wrote:
>> On Thu, May 05, 2022 at 11:36:12AM +0800, Chen Zhongjin wrote:
>>> Hi Peter,
>>>
>>> IIRC now the blacklist mechanisms all run on check stage, which after
>>> decoding, but the problem of kuser32.S happens in decoding stage. Other
>>> than that the assembly symbols in kuser32 is STT_NOTYPE and
>>> STACK_FRAME_NON_STANDARD will throw an error for this.
>>>
>>> OBJECT_FILES_NON_STANDARD works for the single file but as you said
>>> after LTO it's invalid. However STACK_FRAME_NON_STANDARD doesn't work
>>> for kuser32 case at all.
>>>
>>> Now my strategy for undecodable instructions is: show an error message
>>> and mark insn->ignore = true, but do not stop anything so decoding work
>>> can going on.
>>>
>>> To totally solve this my idea is that applying blacklist before decode.
>>> However for this part objtool doesn't have any insn or func info, so we
>>> should add a new blacklist just for this case...
>>
>> OK, so Mark explained that this is 32bit userspace (VDSO) code.
>>
>> And as such there's really no point in running objtool on it. Does all
>> that live in it's own section? Should it?
> 
> It's placed in .rodata by a linker script:
> 
> * The 32-bit vdso + kuser code is placed in .rodata, between the `vdso32_start`
>   and `vdso32_end` symbols, as raw bytes (via .incbin).
>   See arch/arm64/kernel/vdso32-wrap.S.
> 
> * The 64-bit vdso code is placed in .rodata, between the `vdso_start`
>   and `vdso32` symbols, as raw bytes (via .incbin).
>   See arch/arm64/kernel/vdso-wrap.S.
> 
> The objects under arch/arm64/kernel/{vdso,vdso32}/ are all userspace objects,
> and from userspace's PoV the existing secrtions within those objects are
> correct, so I don't think those should change.
> 
> How does x86 deal with its vdso objects?
> 
> Thanks,
> Mark.
> .

However for my build kuser32.o content is in .text and there is only
`vdso` symbol in .rodata without `vdso32`. And for defconfig the
CONFIG_KUSER_HELPERS=y is on.

According to your description, it seems something wrong here?

If all 32-bit asm is placed in .rodata it won't cause problem for
objtool check.

Thanks!

