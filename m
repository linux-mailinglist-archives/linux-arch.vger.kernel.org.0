Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D42A560F44
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 04:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiF3Clt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF3Cls (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 22:41:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D18CE3D;
        Wed, 29 Jun 2022 19:41:47 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYMww0jZXzhYcx;
        Thu, 30 Jun 2022 10:39:28 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 10:41:45 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 10:41:45 +0800
Message-ID: <99883975-4fb7-b073-ac16-7a5474f5ac79@huawei.com>
Date:   Thu, 30 Jun 2022 10:41:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 18/33] arm64: Change symbol type annotations
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>,
        <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>,
        <daniel.thompson@linaro.org>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-19-chenzhongjin@huawei.com>
 <YryQQlQga2wtWqv9@sirena.org.uk>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YryQQlQga2wtWqv9@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

Thanks for review!

On 2022/6/30 1:47, Mark Brown wrote:
> On Thu, Jun 23, 2022 at 09:49:02AM +0800, Chen Zhongjin wrote:
>> Code symbols not following the aarch64 procedure call convention should
>> be annotated with SYM_CODE_* instead of SYM_FUNC_*
>>
>> Mark relevant symbols as generic code symbols.
> 
>> -SYM_CODE_START(tramp_exit_native)
>> +SYM_CODE_START_LOCAL(tramp_exit_native)
>>  	tramp_exit
>>  SYM_CODE_END(tramp_exit_native)
>>  
>> -SYM_CODE_START(tramp_exit_compat)
>> +SYM_CODE_START_LOCAL(tramp_exit_compat)
> 
> The commit log says this is fixing things mistakenly lablelld SYM_FUNC
> but this bit of the actual change is making some symbols local.
> 

It makes sense. I'll remove this because whether this symbol is global makes few
difference here.

>> -SYM_FUNC_START_LOCAL(__create_page_tables)
>> +SYM_CODE_START_LOCAL(__create_page_tables)
>>  	mov	x28, lr
>>  
>>  	/*
>> @@ -389,7 +389,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>>  	bl	dcache_inval_poc
>>  
>>  	ret	x28
>> -SYM_FUNC_END(__create_page_tables)
>> +SYM_CODE_END(__create_page_tables)
> 
> This is removed by Ard's recent refactoring, the others that are still
> present look valid enough (for things that don't use the stack IIRC they
> could be seen as conforming but equally this is all running in non
> standard environments).

You are right, for SYM_CODE_, objtool won't generate ORC automatically as other
normal functions, unless UNWIND_HINT is explicitly specified for non-standard
stack frames.

