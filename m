Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57865629179
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 06:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKOF1U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 00:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKOF1T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 00:27:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84FA51DF37;
        Mon, 14 Nov 2022 21:27:18 -0800 (PST)
Received: from [10.156.157.53] (unknown [167.220.238.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id BDECE20B717A;
        Mon, 14 Nov 2022 21:27:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDECE20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668490038;
        bh=+cD0xwakksYuGFYnjaGTXsWLqjlKc/gSsyajMJVJq68=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CC7S1VTTnSV0b/tGzgw87jqze6+YsJgijjRELVwsLAwDOlBVrJu0DdOmDYDokTHDu
         mhzkz0+uaKOYxb66+UCxpxbNGYu/UbhmhTKWqzfpigUvhidVKxBbBmC/AYweoYjaBy
         fNwyREm9NqDF7+qdFQpA8CbEjvbY3kVH021keeRY=
Subject: Re: [PATCH v3 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, peterz@infradead.org, jpoimboe@kernel.org,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com
References: <cover.1667480257.git.jinankjain@linux.microsoft.com>
 <d8e549f443468f98ea701b27ffe47e4073d6d65d.1667480257.git.jinankjain@linux.microsoft.com>
 <Y2TsXjYaYEYTgQ/E@anrayabh-desk>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Message-ID: <788a5dd5-1c37-9ceb-88d7-7f5fc583f02c@linux.microsoft.com>
Date:   Tue, 15 Nov 2022 10:57:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y2TsXjYaYEYTgQ/E@anrayabh-desk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 11/4/2022 4:11 PM, Anirudh Rayabharam wrote:
> On Thu, Nov 03, 2022 at 01:04:04PM +0000, Jinank Jain wrote:
>> Child partitions are free to allocate SynIC message and event page but in
>> case of root partition it must use the pages allocated by Microsoft
>> Hypervisor (MSHV). Base address for these pages can be found using
>> synthetic MSRs exposed by MSHV. There is a slight difference in those MSRs
>> for nested vs non-nested root partition.
>>
>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>> ---
>>   arch/x86/include/asm/hyperv-tlfs.h | 11 +++++++++++
>>   arch/x86/include/asm/mshyperv.h    | 24 ++++++++++++++++++++++++
>>   drivers/hv/hv.c                    | 18 +++++++++++++-----
>>   3 files changed, 48 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index d9a611565859..0319091e2019 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>>   #define HV_REGISTER_SINT14			0x4000009E
>>   #define HV_REGISTER_SINT15			0x4000009F
>>   
>> +/*
>> + * Define synthetic interrupt controller model specific registers for
>> + * nested hypervisor.
>> + */
>> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
>> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
>> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
>> +#define HV_REGISTER_NESTED_SIMP                0x40001083
>> +#define HV_REGISTER_NESTED_EOM                 0x40001084
>> +#define HV_REGISTER_NESTED_SINT0               0x40001090
>> +
>>   /*
>>    * Synthetic Timer MSRs. Four timers per vcpu.
>>    */
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 3c39923e5969..b0f16d06a0c5 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -200,10 +200,31 @@ static inline bool hv_is_synic_reg(unsigned int reg)
>>   	return false;
>>   }
>>   
>> +static inline unsigned int hv_get_nested_reg(unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case HV_REGISTER_SIMP:
>> +		return HV_REGISTER_NESTED_SIMP;
>> +	case HV_REGISTER_NESTED_SIEFP:
>> +		return HV_REGISTER_SIEFP;
>> +	case HV_REGISTER_SCONTROL:
>> +		return HV_REGISTER_NESTED_SCONTROL;
>> +	case HV_REGISTER_SINT0:
>> +		return HV_REGISTER_NESTED_SINT0;
>> +	case HV_REGISTER_EOM:
>> +		return HV_REGISTER_NESTED_EOM;
>> +	default:
>> +		return reg;
>> +	}
>> +}
>> +
>>   static inline u64 hv_get_register(unsigned int reg)
>>   {
>>   	u64 value;
>>   
>> +	if (hv_nested)
>> +		reg = hv_get_nested_reg(reg);
> With this change the nested root cannot read it's own SynIC MSRs using
> this method. It will always read the SynIC MSRs corresponding to the
> nesting hypervisor. Similar is the case with hv_set_register.
>
> Will there never be a need for nested root to read/write it's own SynIC
> MSRs? For e.g. to set up inter partition communication at the L2 level.
>
> Anirudh.

As far as the current use case goes I doubt there would be a use case 
like that. In future if such a scneario arises, I think we can add an 
additional parameter to hv_(get|set)_register, called nested and 
depending on the value of that parameter we can return the value of 
nested or non-nested registers. This would be very similar to the design 
I posted in revision 1 of this patch series.

Jinank.

>
>> +
>>   	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
>>   		hv_ghcb_msr_read(reg, &value);
>>   	else
>> @@ -213,6 +234,9 @@ static inline u64 hv_get_register(unsigned int reg)
>>   
>>   static inline void hv_set_register(unsigned int reg, u64 value)
>>   {
>> +	if (hv_nested)
>> +		reg = hv_get_nested_reg(reg);
>> +
>>   	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
>>   		hv_ghcb_msr_write(reg, value);
>>   
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 4d6480d57546..9e1eb50cc76f 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -147,7 +147,7 @@ int hv_synic_alloc(void)
>>   		 * Synic message and event pages are allocated by paravisor.
>>   		 * Skip these pages allocation here.
>>   		 */
>> -		if (!hv_isolation_type_snp()) {
>> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
>>   			hv_cpu->synic_message_page =
>>   				(void *)get_zeroed_page(GFP_ATOMIC);
>>   			if (hv_cpu->synic_message_page == NULL) {
>> @@ -188,8 +188,16 @@ void hv_synic_free(void)
>>   		struct hv_per_cpu_context *hv_cpu
>>   			= per_cpu_ptr(hv_context.cpu_context, cpu);
>>   
>> -		free_page((unsigned long)hv_cpu->synic_event_page);
>> -		free_page((unsigned long)hv_cpu->synic_message_page);
>> +		if (hv_root_partition) {
>> +			if (hv_cpu->synic_event_page != NULL)
>> +				memunmap(hv_cpu->synic_event_page);
>> +
>> +			if (hv_cpu->synic_message_page != NULL)
>> +				memunmap(hv_cpu->synic_message_page);
>> +		} else {
>> +			free_page((unsigned long)hv_cpu->synic_event_page);
>> +			free_page((unsigned long)hv_cpu->synic_message_page);
>> +		}
>>   		free_page((unsigned long)hv_cpu->post_msg_page);
>>   	}
>>   
>> @@ -216,7 +224,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>   	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>>   	simp.simp_enabled = 1;
>>   
>> -	if (hv_isolation_type_snp()) {
>> +	if (hv_isolation_type_snp() || hv_root_partition) {
>>   		hv_cpu->synic_message_page
>>   			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>>   				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>> @@ -233,7 +241,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>   	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>>   	siefp.siefp_enabled = 1;
>>   
>> -	if (hv_isolation_type_snp()) {
>> +	if (hv_isolation_type_snp() || hv_root_partition) {
>>   		hv_cpu->synic_event_page =
>>   			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>>   				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>> -- 
>> 2.25.1
