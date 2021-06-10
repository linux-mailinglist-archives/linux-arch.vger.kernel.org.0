Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCE3A32E5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJSTG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 14:19:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:60641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFJSTF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 14:19:05 -0400
IronPort-SDR: ZcbcqeSGPfyQIAd+okr/QyfG3JQ9/MFwk6Mj3ttFuJTkMWReI+L0O2EO51HRTpV8I0jvlv/h09
 TAPo/nEs6qrg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192476047"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="192476047"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:17:08 -0700
IronPort-SDR: bzxZKBu+iuyDQIVXTTpDDymxZqOLtfT/zL9wNgqKXdUI9wY1Q7YLaapAuzUGCstPeX+TEBh2K5
 2QRP1ak+IlLA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="552447883"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.32.188]) ([10.212.32.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:17:07 -0700
Subject: Re: [PATCH v2 3/3] elf: Remove has_interp property from
 arch_adjust_elf_prot()
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-4-broonie@kernel.org> <20210609151724.GM4187@arm.com>
 <6e0b1dbd-688c-aba6-e376-91ce9440d741@intel.com>
 <20210610095853.GN4187@arm.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <aa43ec0d-e02b-8d0e-f97f-7e61b0639a5f@intel.com>
Date:   Thu, 10 Jun 2021 11:17:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610095853.GN4187@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/10/2021 2:58 AM, Dave Martin wrote:
> On Wed, Jun 09, 2021 at 09:55:36AM -0700, Yu, Yu-cheng wrote:
>> On 6/9/2021 8:17 AM, Dave Martin wrote:
>>> On Fri, Jun 04, 2021 at 12:24:50PM +0100, Mark Brown wrote:
>>>> Since we have added an is_interp flag to arch_parse_elf_property() we can
>>>> drop the has_interp flag from arch_elf_adjust_prot(), the only user was
>>>> the arm64 code which no longer needs it and any future users will be able
>>>> to use arch_parse_elf_properties() to determine if an interpreter is in
>>>> use.
>>>
>>> So far so good, but can we also drop the has_interp argument from
>>> arch_parse_elf_properties()?
>>>
>>> Cross-check with Yu-Cheng Yu's series, but I don't see this being used
>>> any more (except for passthrough in binfmt_elf.c).
>>>
>>> Since we are treating the interpreter and main executable orthogonally
>>> to each other now, I don't think we should need a has_interp argument to
>>> pass knowledge between the interpreter and executable handling phases
>>> here.
>>>
>>
>> For CET, arch_parse_elf_property() needs to know has_interp and is_interp.
>> Like the following, on top of your patches:
>>
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index 607b782afe2c..9e6f142b5cef 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -837,8 +837,15 @@ unsigned long KSTK_ESP(struct task_struct *task)
>>   }
>>
>>   int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
>> -			    bool compat, struct arch_elf_state *state)
>> +			    bool compat, bool has_interp, bool is_interp,
>> +			    struct arch_elf_state *state)
>>   {
>> +	/*
>> +	 * Parse static-linked executable or the loader.
>> +	 */
>> +	if (has_interp != is_interp)
>> +		return 0;
>> +
> 
> [...]
> 
> Ah, sorry, I did attempt to check this with your series, but I didn't
> attempt to build it.  I must have missed this somehow.
> 
> But: does x86 actually need to do this?
> 
> For arm64, we've discovered that it is better to treat the ELF
> interpreter and main executable independently when applying the ELF
> properties.
> 
> So, can x86 actually port away from this?  arch_parse_elf_properties()
> and arch_adjust_elf_prot() would still know whether the interpreter is
> being considered or not, via the is_interp argument to both functions.
> This allows interpreter and main executable info to be stashed
> independently in the arch_elf_state.
> 
> If x86 really needs to carry on following the existing model then that's
> fine, but we should try to keep x86 and arm64 aligned if at all possible.
>

Yes, for CET's purpose, that should be fine.

Thanks,
Yu-cheng
