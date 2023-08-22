Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD9784BB7
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHVVAF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHVVAF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 17:00:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4669C1B0;
        Tue, 22 Aug 2023 14:00:02 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6E15F2126CD1;
        Tue, 22 Aug 2023 14:00:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E15F2126CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692738001;
        bh=Wik2nYlgFy2h1vwJvpE3BbkkhoxbzmyA5NHLHlPVd2g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z/J45Xowxo29xY/xCJi1OztlNqr4L62uk0uJjhJWK4PJzqvW/0uXbhZf+d5fywsGH
         nOWnLmddSQJ3gTJiBRWuTuimYwrk/fjCu9d3kFnz1ucTJUSNR0ztdQW7W6I6mAUb3R
         4TRYyaYL/egYfQNi9SS8ROI9g6UVFOxwWsObhWFA=
Message-ID: <c53fa288-a16d-4f23-83de-84d6ff20823c@linux.microsoft.com>
Date:   Tue, 22 Aug 2023 14:00:10 -0700
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
 <PUZP153MB063571CB1D30770996948726BE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <PUZP153MB063571CB1D30770996948726BE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/21/2023 11:18 AM, Saurabh Singh Sengar wrote:
> 
> 
>> -----Original Message-----
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Sent: Friday, August 18, 2023 3:32 AM
>> To: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org;
>> x86@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> arch@vger.kernel.org
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
>> Subject: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
>> VMMs running on Hyper-V
>>
>> Add mshv, mshv_root, and mshv_vtl modules:
>>
> 
> <snip>
> 
>> +	ret = mshv_set_vp_registers(vp->index, vp->partition->id,
>> +				    1, &dispatch_suspend);
>> +	if (ret)
>> +		pr_err("%s: failed to suspend partition %llu vp %u\n",
>> +			__func__, vp->partition->id, vp->index);
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +get_vp_signaled_count(struct mshv_vp *vp, u64 *count)
>> +{
>> +	int ret;
>> +	struct hv_register_assoc root_signal_count = {
>> +		.name = HV_REGISTER_VP_ROOT_SIGNAL_COUNT,
>> +	};
>> +
>> +	ret = mshv_get_vp_registers(vp->index, vp->partition->id,
>> +				    1, &root_signal_count);
>> +
>> +	if (ret) {
>> +		pr_err("%s: failed to get root signal count for partition %llu vp
>> %u",
>> +			__func__, vp->partition->id, vp->index);
>> +		*count = 0;
> 
> Have we missed a return here ?
> Moreover, the return type of this function is never checked consider
> checking it or change it to void.
> 

Thanks, we do need to return here.

This function is called on a cleanup path (deleting the guest VM), so if it fails
something is wrong. Instead of returning void, I think we should check the return
value with WARN_ON(), and abort the cleanup if it failed.

>> +
>> +/* Retrieve and stash the supported scheduler type */
>> +static int __init mshv_retrieve_scheduler_type(void)
>> +{
>> +	struct hv_input_get_system_property *input;
>> +	struct hv_output_get_system_property *output;
>> +	unsigned long flags;
>> +	u64 status;
>> +
>> +	local_irq_save(flags);
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +	memset(input, 0, sizeof(*input));
>> +	memset(output, 0, sizeof(*output));
>> +	input->property_id = HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
>> +
>> +	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input,
>> output);
>> +	if (!hv_result_success(status)) {
>> +		local_irq_restore(flags);
>> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
>> +		return hv_status_to_errno(status);
>> +	}
>> +
>> +	hv_scheduler_type = output->scheduler_type;
>> +	local_irq_restore(flags);
>> +
>> +	pr_info("mshv: hypervisor using %s\n",
>> scheduler_type_to_string(hv_scheduler_type));
> 
> Nit: In this file we are using two styles of prints, few are appended with
> "mshv:" and few with "__func__".  It's better to have a single style
> for one module.

Thanks, I'll switch them all to __func__
