Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207B77EC03
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346597AbjHPVkf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbjHPVkY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:40:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D603EDC;
        Wed, 16 Aug 2023 14:40:22 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2773D211F61E;
        Wed, 16 Aug 2023 14:40:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2773D211F61E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692222022;
        bh=9J/siSd3e/xutkmYyU6ZjncKl7A8brtIRyLjlPr7NQk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EAIUIfVe8yo9voVpcR0wcfbQTBkAzHT2MfPwE3SnkJKRFvWlgm2iXpJiY436zg/T0
         84aFRGn23krhc6Yp6eC9K9SDlvdJbykQqFcY2YovRqUqyizMC4uSugh+joiqkH5hFy
         E555jsvZHXGPoXi8qqynNsun/x/NO7ozodn6MbYc=
Message-ID: <e7f35b68-b1c1-4c9a-885f-57440fce8397@linux.microsoft.com>
Date:   Wed, 16 Aug 2023 14:40:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] Drivers: hv: Introduce per-cpu event ring tail
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
 <1690487690-2428-9-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMrwW1m65V1flOpi@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZMrwW1m65V1flOpi@liuwe-devbox-debian-v2>
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

>> +/*
>> + * Per-cpu array holding the tail pointer for the SynIC event ring buffer
>> + * for each SINT.
>> + *
>> + * We cannot maintain this in mshv driver because the tail pointer should
>> + * persist even if the mshv driver is unloaded.
>> + */
>> +u8 __percpu **hv_synic_eventring_tail;
>> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>> +
>>  /*
>>   * Hyper-V specific initialization and shutdown code that is
>>   * common across all architectures.  Called from architecture
>> @@ -332,6 +342,8 @@ int __init hv_common_init(void)
>>  	if (hv_root_partition) {
>>  		hyperv_pcpu_output_arg = alloc_percpu(void *);
>>  		BUG_ON(!hyperv_pcpu_output_arg);
>> +		hv_synic_eventring_tail = alloc_percpu(u8 *);
>> +		BUG_ON(hv_synic_eventring_tail == NULL);
>>  	}
>>  
>>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>> @@ -356,6 +368,7 @@ int __init hv_common_init(void)
>>  int hv_common_cpu_init(unsigned int cpu)
>>  {
>>  	void **inputarg, **outputarg;
>> +	u8 **synic_eventring_tail;
>>  	u64 msr_vp_index;
>>  	gfp_t flags;
>>  	int pgcount = hv_root_partition ? 2 : 1;
>> @@ -371,6 +384,14 @@ int hv_common_cpu_init(unsigned int cpu)
>>  	if (hv_root_partition) {
>>  		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>  		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>> +		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>> +		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
>> +						flags);
>> +
>> +		if (unlikely(!*synic_eventring_tail)) {
>> +			kfree(*inputarg);
>> +			return -ENOMEM;
>> +		}
>>  	}
>>  
>>  	msr_vp_index = hv_get_register(HV_MSR_VP_INDEX);
>> @@ -387,6 +408,7 @@ int hv_common_cpu_die(unsigned int cpu)
>>  {
>>  	unsigned long flags;
>>  	void **inputarg, **outputarg;
>> +	u8 **synic_eventring_tail;
>>  	void *mem;
>>  
>>  	local_irq_save(flags);
>> @@ -398,6 +420,9 @@ int hv_common_cpu_die(unsigned int cpu)
>>  	if (hv_root_partition) {
>>  		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>  		*outputarg = NULL;
>> +		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>> +		kfree(*synic_eventring_tail);
>> +		*synic_eventring_tail = NULL;
> 
> The upstream code looks different now. See 9636be85cc.
> 
Thanks, I have rebased for v2, and fixed this.

>>  	}
>>  
>>  	local_irq_restore(flags);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 0c94d20b4d44..9118d678b27a 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -73,6 +73,8 @@ extern bool hv_nested;
>>  extern void * __percpu *hyperv_pcpu_input_arg;
>>  extern void * __percpu *hyperv_pcpu_output_arg;
>>  
>> +extern u8 __percpu **hv_synic_eventring_tail;
>> +
>>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>>  extern bool hv_isolation_type_snp(void);
>> -- 
>> 2.25.1
>>

