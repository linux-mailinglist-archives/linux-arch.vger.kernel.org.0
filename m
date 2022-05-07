Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8D51E49D
	for <lists+linux-arch@lfdr.de>; Sat,  7 May 2022 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358018AbiEGGjd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 May 2022 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiEGGjc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2022 02:39:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A31836B;
        Fri,  6 May 2022 23:35:46 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KwHd1099KzXdlN;
        Sat,  7 May 2022 14:31:01 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 14:35:44 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 14:35:43 +0800
Message-ID: <c18a0381-637e-3a2d-7a75-76ecaebc6c2e@huawei.com>
Date:   Sat, 7 May 2022 14:35:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
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
 <51ce37b5-f527-9743-36d3-50247cb0939f@huawei.com>
 <YnTzO3imkSUAuIKx@FVFF77S0Q05N>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YnTzO3imkSUAuIKx@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2022/5/6 18:06, Mark Rutland wrote:
>> However for my build kuser32.o content is in .text 
> 
> We should be able to move that into .rodata; it's never executed in kernel context.
> 
>> and there is only `vdso` symbol in .rodata without `vdso32`.
> 
> That means you're not building with CROSS_COMPILE_COMPAT, and so we can't build
> the 32-bit VDSO.
> 
>> And for defconfig the CONFIG_KUSER_HELPERS=y is on.
> 
> Yes.
> 
>> According to your description, it seems something wrong here?
> 
> Sorry, I was wrong about how we linked the kuser32 code.
> 
> I believe we can move that into .rodata by adding:
> 
> 	.section .rodata
> 
> ... to the start of that.

It works.

Thanks!

> I think that'd be a nice cleanup to do regardless of objtool.
> 
> Thanks,
> Mark.
> .

