Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4D6308E4
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 02:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKSByC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 20:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiKSBxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 20:53:10 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A451EC6D02;
        Fri, 18 Nov 2022 17:39:49 -0800 (PST)
Received: from [192.168.0.5] (71-212-113-106.tukw.qwest.net [71.212.113.106])
        by linux.microsoft.com (Postfix) with ESMTPSA id 15C3A20B83C2;
        Fri, 18 Nov 2022 17:39:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15C3A20B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668821989;
        bh=tpBioxUJdr+zIDBZjxvEcm/NSQO7L5i+paa1kbCpVYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N8EpbWcF0GynpIQSHEuzgFQ9Pw6NxTBgt4hE0R7HgaqUr03Kx9vVwdfFZb57P/X7w
         tr8doQjtb+dlpK8E4td6w2nRCCkkCrET0HB9w1EU/Wd6czfZMbxM6WTZ/CEVhsHOTB
         DqKgP4XZ1weqzfNkiaxXxj5OT4RS3KkZC36tooOk=
Message-ID: <a42b1927-b4ec-bee6-ef11-344a6c2c3c23@linux.microsoft.com>
Date:   Fri, 18 Nov 2022 17:39:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Content-Language: en-US
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
References: <cover.1668618583.git.jinankjain@linux.microsoft.com>
 <11dda2c697781c5d12bbffd11052e6d6bb2ca705.1668618583.git.jinankjain@linux.microsoft.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <11dda2c697781c5d12bbffd11052e6d6bb2ca705.1668618583.git.jinankjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/16/2022 7:27 PM, Jinank Jain wrote:
> Child partitions are free to allocate SynIC message and event page but in
> case of root partition it must use the pages allocated by Microsoft
> Hypervisor (MSHV). Base address for these pages can be found using
> synthetic MSRs exposed by MSHV. There is a slight difference in those MSRs
> for nested vs non-nested root partition.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 +++++++
>  arch/x86/include/asm/mshyperv.h    | 26 ++--------------
>  arch/x86/kernel/cpu/mshyperv.c     | 49 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    | 18 ++++++++---
>  4 files changed, 75 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 58c03d18c235..b5019becb618 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>  #define HV_REGISTER_SINT14			0x4000009E
>  #define HV_REGISTER_SINT15			0x4000009F
>  
> +/*
> + * Define synthetic interrupt controller model specific registers for
> + * nested hypervisor.
> + */
> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
> +#define HV_REGISTER_NESTED_SIMP                0x40001083
> +#define HV_REGISTER_NESTED_EOM                 0x40001084
> +#define HV_REGISTER_NESTED_SINT0               0x40001090
> +
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 61f0c206bff0..326d699b30d5 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -198,30 +198,8 @@ static inline bool hv_is_synic_reg(unsigned int reg)
>  	return false;
>  }
>  
> -static inline u64 hv_get_register(unsigned int reg)
> -{
> -	u64 value;
> -
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> -		hv_ghcb_msr_read(reg, &value);
> -	else
> -		rdmsrl(reg, value);
> -	return value;
> -}
> -
> -static inline void hv_set_register(unsigned int reg, u64 value)
> -{
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> -		hv_ghcb_msr_write(reg, value);
> -
> -		/* Write proxy bit via wrmsl instruction */
> -		if (reg >= HV_REGISTER_SINT0 &&
> -		    reg <= HV_REGISTER_SINT15)
> -			wrmsrl(reg, value | 1 << 20);
> -	} else {
> -		wrmsrl(reg, value);
> -	}
> -}
> +u64 hv_get_register(unsigned int reg);
> +void hv_set_register(unsigned int reg, u64 value);
>  
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 9a4204139490..3e6711a6af6b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,6 +41,55 @@ bool hv_root_partition;
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>  
> +static inline unsigned int hv_get_nested_reg(unsigned int reg)
> +{
> +	switch (reg) {
> +	case HV_REGISTER_SIMP:
> +		return HV_REGISTER_NESTED_SIMP;
> +	case HV_REGISTER_NESTED_SIEFP:
> +		return HV_REGISTER_SIEFP;
> +	case HV_REGISTER_SCONTROL:
> +		return HV_REGISTER_NESTED_SCONTROL;
> +	case HV_REGISTER_SINT0:
> +		return HV_REGISTER_NESTED_SINT0;
> +	case HV_REGISTER_EOM:
> +		return HV_REGISTER_NESTED_EOM;
> +	default:
> +		return reg;
> +	}
> +}
> +
> +inline u64 hv_get_register(unsigned int reg)
> +{
> +	u64 value;
> +
> +	if (hv_nested)
> +		reg = hv_get_nested_reg(reg);
> +
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> +		hv_ghcb_msr_read(reg, &value);
> +	else
> +		rdmsrl(reg, value);
> +	return value;
> +}
> +
> +inline void hv_set_register(unsigned int reg, u64 value)
> +{
> +	if (hv_nested)
> +		reg = hv_get_nested_reg(reg);
> +
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> +		hv_ghcb_msr_write(reg, value);
> +
> +		/* Write proxy bit via wrmsl instruction */
> +		if (reg >= HV_REGISTER_SINT0 &&
> +		    reg <= HV_REGISTER_SINT15)
> +			wrmsrl(reg, value | 1 << 20);
> +	} else {
> +		wrmsrl(reg, value);
> +	}
> +}

This approach has a problem, in that it removes the interface for getting and
setting the non-nested SIMP etc...
We will need to use the non-nested SIMP for getting intercepts in the root
partition from the L1 hypervisor.

Nuno
