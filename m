Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAEA788EA9
	for <lists+linux-arch@lfdr.de>; Fri, 25 Aug 2023 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHYS01 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Aug 2023 14:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHYS0K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Aug 2023 14:26:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7EDF26B8;
        Fri, 25 Aug 2023 11:26:03 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id E99C62127C95;
        Fri, 25 Aug 2023 11:26:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E99C62127C95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692987963;
        bh=i/LcYatUMQg88pTskF3rrDjHam8btTKsOaforNox3cY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p97fGzQv0o9SeAtgAZ2SZ5rRMB7jI5VGEkz9QIN1l31MP5IqV9EJqibSEgwG5bFPj
         UG5QUFFeGy0VD4/NFO2D1opM+z30iFiUImxaWfX2o96tTXxtE60/QSxhI8cmd8k9cA
         miX8qYJhfygj2ws4RHDr3sgzHwPw5HXrSFmDjDpc=
Message-ID: <68344e40-45aa-41d1-9df2-26f12db9e109@linux.microsoft.com>
Date:   Fri, 25 Aug 2023 11:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
 <PUZP153MB063545036E6B547C009F6AECBE1BA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <664aec4c-7ea9-447f-afab-9e31e9e106c1@linux.microsoft.com>
 <PUZP153MB0635A9EBE87C3589612B628CBE19A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <8978223c-c5e8-4235-a0ed-2031583c2751@linux.microsoft.com>
 <PUZP153MB06355D695AC8AAFD2624ED2BBE1CA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <PUZP153MB06355D695AC8AAFD2624ED2BBE1CA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
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

On 8/23/2023 12:40 AM, Saurabh Singh Sengar wrote:
> 
> 
>> -----Original Message-----
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Sent: Wednesday, August 23, 2023 1:49 AM
>> To: Saurabh Singh Sengar <ssengar@microsoft.com>; linux-
>> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org; linux-
>> arm-kernel@lists.infradead.org; linux-arch@vger.kernel.org
>> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
>> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
>> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
>> <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
>> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
>> RATHOR <mukeshrathor@microsoft.com>; stanislav.kinsburskiy@gmail.com;
>> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
>> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
>> catalin.marinas@arm.com
>> Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv
>> to VMMs running on Hyper-V
>>
>> On 8/19/2023 10:19 PM, Saurabh Singh Sengar wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>> Sent: Saturday, August 19, 2023 12:30 AM
>>>> To: Saurabh Singh Sengar <ssengar@microsoft.com>; linux-
>>>> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
>>>> linux- arm-kernel@lists.infradead.org; linux-arch@vger.kernel.org
>>>> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
>>>> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
>>>> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan
>>>> Cui <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
>>>> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
>>>> RATHOR <mukeshrathor@microsoft.com>;
>> stanislav.kinsburskiy@gmail.com;
>>>> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
>>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
>>>> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
>>>> catalin.marinas@arm.com
>>>> Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose
>>>> /dev/mshv to VMMs running on Hyper-V
>>>>
>>>> On 8/18/2023 6:08 AM, Saurabh Singh Sengar wrote:
>>>>>> +
>>>>>> +config MSHV_VTL
>>>>>> +	tristate "Microsoft Hyper-V VTL driver"
>>>>>> +	depends on MSHV
>>>>>> +	select HYPERV_VTL_MODE
>>>>>> +	select TRANSPARENT_HUGEPAGE
>>>>>
>>>>> TRANSPARENT_HUGEPAGE can be avoided for now.
>>>>>
>>>>
>>>> I will remove it in the next version. Thanks.
>>>>>> +
>>>>>> +#define HV_GET_REGISTER_BATCH_SIZE	\
>>>>>> +	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
>>>>>> +#define HV_SET_REGISTER_BATCH_SIZE	\
>>>>>> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
>>>>>> +		/ sizeof(struct hv_register_assoc))
>>>>>> +
>>>>>> +int hv_call_get_vp_registers(
>>>>>> +		u32 vp_index,
>>>>>> +		u64 partition_id,
>>>>>> +		u16 count,
>>>>>> +		union hv_input_vtl input_vtl,
>>>>>> +		struct hv_register_assoc *registers) {
>>>>>> +	struct hv_input_get_vp_registers *input_page;
>>>>>> +	union hv_register_value *output_page;
>>>>>> +	u16 completed = 0;
>>>>>> +	unsigned long remaining = count;
>>>>>> +	int rep_count, i;
>>>>>> +	u64 status;
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	local_irq_save(flags);
>>>>>> +
>>>>>> +	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>>> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>>>>> +
>>>>>> +	input_page->partition_id = partition_id;
>>>>>> +	input_page->vp_index = vp_index;
>>>>>> +	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
>>>>>> +	input_page->rsvd_z8 = 0;
>>>>>> +	input_page->rsvd_z16 = 0;
>>>>>> +
>>>>>> +	while (remaining) {
>>>>>> +		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
>>>>>> +		for (i = 0; i < rep_count; ++i)
>>>>>> +			input_page->names[i] = registers[i].name;
>>>>>> +
>>>>>> +		status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS,
>>>>>> rep_count,
>>>>>> +					     0, input_page, output_page);
>>>>>
>>>>> Is there any possibility that count value is passed 0 by mistake ?
>>>>> In that case status will remain uninitialized.
>>>>>
>>>>
>>>> These lines ensure rep_count is never 0 here:
>>>>
>>>> 	while (remaining) {
>>>> 		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
>>>>
>>>> Remaining can't be 0 or the loop would exit, and
>>>> HV_GET_REGISTER_BATCH_SIZE is not 0, or we would never get any
>> registers.
>>>
>>> There is a parameter in this function "count". I was checking if there
>>> is any possibility that is passed as 0 by mistake ? this will lead to
>>> "remaining" value as 0 and loop will never execute. Which results using
>> "status" uninitialized later in the function.
>>>
>>>
>>
>> Ah ok, thanks! I will change it to return immediately in case count is 0.
> 
> Or you can initialize status with appropriate error value, either way is fine.
> Please consider fixing the same issue in hv_call_set_vp_registers as well.
> 

Thanks again - noted.

