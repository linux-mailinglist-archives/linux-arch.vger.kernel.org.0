Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1677EC4F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbjHPV4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346691AbjHPV4N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:56:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7763A1FC3;
        Wed, 16 Aug 2023 14:56:12 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id B7663211F617;
        Wed, 16 Aug 2023 14:56:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7663211F617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692222972;
        bh=TcBeYn9mQXOHIb67yyVRR1Bs9s8VL8uFOeaa9wR+MIM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ausrTEkYhRFOv5htMYsJcYgAHDG+cbBqoggTvPnlE+avIcWkaDB4hAl3RULni0HW7
         3OllRJ+GEAZ7xDtmTqolLZUBmvAbPgT46YFdVXzGsVeZn9+0lLm7PNSGGrazQEQuV5
         6Rz4JdSrw6Yy4LyoQBV/nlRxB7XilKf7n6BQLsds=
Message-ID: <92ed100d-b17d-4779-a10f-ca513f9b30ea@linux.microsoft.com>
Date:   Wed, 16 Aug 2023 14:56:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] Drivers: hv: Introduce hv_output_arg_exists in
 hv_common
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-10-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMrx5m2Tg7bfX9Ce@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZMrx5m2Tg7bfX9Ce@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/2023 5:16 PM, Wei Liu wrote:
> On Thu, Jul 27, 2023 at 12:54:44PM -0700, Nuno Das Neves wrote:
>> This is a more flexible approach for determining whether to allocate the
>> output page.
> 
>> This will be used in both mshv_vtl and root partition.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/hv_common.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 99d9b262b8a7..16f069beda78 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -57,6 +57,18 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>>  void * __percpu *hyperv_pcpu_output_arg;
>>  EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>>  
>> +/*
>> + * Determine whether output arg is in use, for allocation/deallocation
>> + */
>> +static bool hv_output_arg_exists(void)
>> +{
>> +	bool ret = hv_root_partition ? true : false;
>> +#ifdef CONFIG_MSHV_VTL
>> +	ret = true;
>> +#endif
> 
> This should not be here. As far as I can tell, CONFIG_MSHV_VTL is
> introduced in a later patch.
> 

Ok, I will introduce this #ifdef with the mshv_vtl module.

> The rest looks okay.
> 
> Thanks,
> Wei.

