Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E6558CC9
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 03:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiFXBZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiFXBZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 21:25:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297856779;
        Thu, 23 Jun 2022 18:25:03 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTfWp4wkTzkWXL;
        Fri, 24 Jun 2022 09:23:18 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 09:25:01 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 09:25:01 +0800
Message-ID: <9217c85d-e39e-55b1-36c3-603d0c6203fd@huawei.com>
Date:   Fri, 24 Jun 2022 09:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 32/33] arm64: irq-gic: Replace unreachable() with
 -EINVAL
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>,
        <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <madvenka@linux.microsoft.com>,
        <christophe.leroy@csgroup.eu>, <daniel.thompson@linaro.org>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-33-chenzhongjin@huawei.com>
 <7d26e36686495866e0752e12c38f170e@kernel.org>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <7d26e36686495866e0752e12c38f170e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi,

Thanks for your review and patient.

On 2022/6/23 16:13, Marc Zyngier wrote:
> On 2022-06-23 02:49, Chen Zhongjin wrote:
>> Using unreachable() at default of switch generates an extra branch at
>> end of the function, and compiler won't generate a ret to close this
>> branch because it knows it's unreachable.
>>
>> If there's no instruction in this branch, compiler will generate a NOP,
>> And it will confuse objtool to warn this NOP as a fall through branch.
>>
>> In fact these branches are actually unreachable, so we can replace
>> unreachable() with returning a -EINVAL value.
>>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>  arch/arm64/kvm/hyp/vgic-v3-sr.c | 7 +++----
>>  drivers/irqchip/irq-gic-v3.c    | 2 +-
>>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> Basic courtesy would have been to Cc the maintainers of this code.
> 
Sorry for that.

I'll cc everyone next time.

>>
>> diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
>> index 4fb419f7b8b6..f3cee92c3038 100644
>> --- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
>> +++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
>> @@ -6,7 +6,6 @@
>>
>>  #include <hyp/adjust_pc.h>
>>
>> -#include <linux/compiler.h>
>>  #include <linux/irqchip/arm-gic-v3.h>
>>  #include <linux/kvm_host.h>
>>
>> @@ -55,7 +54,7 @@ static u64 __gic_v3_get_lr(unsigned int lr)
>>          return read_gicreg(ICH_LR15_EL2);
>>      }
>>
>> -    unreachable();
>> +    return -EINVAL;
> 
> NAK. That's absolutely *wrong*, and will hide future bugs.
> Nothing checks for -EINVAL, and we *never* expect to
> reach this, hence the perfectly valid annotation.
> 
> If something needs fixing, it probably is your tooling.
> 
>         M.

You are right.

Essentially, this is because objtool does not anticipate that the compiler will
generate additional instructions when marking unreachable instructions.

I'll fix this problem or add a specific check for this state.

Best,
Chen

