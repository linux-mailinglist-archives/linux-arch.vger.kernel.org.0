Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A551B69F
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiEEDj5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiEEDj4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:39:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37149934;
        Wed,  4 May 2022 20:36:17 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ktzq36K7SzfbDj;
        Thu,  5 May 2022 11:35:11 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 11:36:16 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 11:36:15 +0800
Message-ID: <a57f7d73-6e01-8f41-9be3-8e90807ec08f@huawei.com>
Date:   Thu, 5 May 2022 11:36:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <jthierry@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <jpoimboe@redhat.com>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <ardb@kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <luc.vanoostenryck@gmail.com>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-23-chenzhongjin@huawei.com>
 <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi Peter,

IIRC now the blacklist mechanisms all run on check stage, which after
decoding, but the problem of kuser32.S happens in decoding stage. Other
than that the assembly symbols in kuser32 is STT_NOTYPE and
STACK_FRAME_NON_STANDARD will throw an error for this.

OBJECT_FILES_NON_STANDARD works for the single file but as you said
after LTO it's invalid. However STACK_FRAME_NON_STANDARD doesn't work
for kuser32 case at all.

Now my strategy for undecodable instructions is: show an error message
and mark insn->ignore = true, but do not stop anything so decoding work
can going on.

To totally solve this my idea is that applying blacklist before decode.
However for this part objtool doesn't have any insn or func info, so we
should add a new blacklist just for this case...

On 2022/4/29 19:05, Peter Zijlstra wrote:
> On Fri, Apr 29, 2022 at 05:43:40PM +0800, Chen Zhongjin wrote:
>> From: Raphael Gault <raphael.gault@arm.com>
>>
>> kuser32 being used for compatibility, it contains a32 instructions
>> which are not recognised by objtool when trying to analyse arm64
>> object files. Thus, we add an exception to skip validation on this
>> particular file.
>>
>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>  arch/arm64/kernel/Makefile | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 986837d7ec82..c4f01bfe79b4 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -41,6 +41,9 @@ obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
>>  					   sys_compat.o
>>  obj-$(CONFIG_COMPAT)			+= sigreturn32.o
>>  obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
>> +
>> +OBJECT_FILES_NON_STANDARD_kuser32.o := y
> 
> File based skipping is depricated in the face of LTO and other link
> target based objtool runs.
> 
> Please use function based blacklisting as per the previous patch.
> 
> .

