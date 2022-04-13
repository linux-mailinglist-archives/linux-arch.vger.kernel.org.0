Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804364FECC5
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiDMCQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 22:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiDMCQi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 22:16:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42EA6338;
        Tue, 12 Apr 2022 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Mbjne51g7b5MpYBPVjJDEY6VmWxgJ06clSfxVNg4kpo=; b=IfcP3NODCILCw0Va76HRV+XeAP
        UaCzcdUvvd/McEHoHoA3eIOmcLg5AW+oZpj4jDqXJCLEC3txlO5fwLJqcMrQOqP3ahG3JshzFOV1J
        QL9Nuvk7vihM5SgkjeJz1cCK3LP9KgkbzTd39qjd9FnBHYGH+nPDEQaKiWUvm05X7IppQ5Sa0Kqz6
        uYpu2lzaTD0JP+gdgjMtuw1EK9q6A//7F2MRDBnPvSrL/AyAM5zkTzivBLN9IlP2uYHCBcicyWsqn
        nY2xGqFqHlyGI4dppFSiJMoJzbTzjwGuYU86maVx5ycUOFabAYcJV0EkO9dixpXQ8yk3/7FxrLT3s
        fCgH0sYg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neSWB-00Ds0A-65; Wed, 13 Apr 2022 02:14:03 +0000
Message-ID: <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org>
Date:   Tue, 12 Apr 2022 19:13:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Content-Language: en-US
To:     Libo Chen <libo.chen@oracle.com>, gregkh@linuxfoundation.org,
        masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20220412231508.32629-1-libo.chen@oracle.com>
 <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
 <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 4/12/22 18:35, Libo Chen wrote:
> Hi Randy,
> 
> On 4/12/22 17:18, Randy Dunlap wrote:
>> Hi--
>>
>> On 4/12/22 16:15, Libo Chen wrote:
>>> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
>>> make a lot of sense nowaday. Even the original patch dating back to 2008,
>>> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
>>> rationale for such dependency.
>>>
>>> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
>>> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
>>> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
>>> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
>>> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
>>> There is no reason other architectures cannot given the fact that they
>>> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
>>> x86.
>>>
>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>> ---
>>>   lib/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index 087e06b4cdfd..7209039dfb59 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>>>       bool
>>>     config CPUMASK_OFFSTACK
>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>> This "if" dependency only controls whether the Kconfig symbol's prompt is
>> displayed (presented) in kconfig tools. Removing it makes the prompt always
>> be displayed.
>>
>> Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
>> of DEBUG_PER_CPU_MAPS.
> Do you mean changing arch/xxxx/Kconfig to select CPUMASK_OFFSTACK under some config xxx? That will work but it requires code changes for each architecture.
> But if you are talking about setting CONFIG_CPUMASK_OFFSTACK=y without CONFIG_DEBUG_PER_CPU_MAPS directly in config file, I have tried, it doesn't work.

I'm just talking about the Kconfig change below.  Not talking about whatever else
it might require per architecture.

But you say you have tried that and it doesn't work. What part of it doesn't work?
The Kconfig part or some code execution?

I'll test the Kconfig part of it later (in a few hours).

> Libo
>> Is there another problem here?
>>
>>> +    bool "Force CPU masks off stack"
>>>       help
>>>         Use dynamic allocation for cpumask_var_t, instead of putting
>>>         them on the stack.  This is a bit more expensive, but avoids
> 

-- 
~Randy
