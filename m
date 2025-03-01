Return-Path: <linux-arch+bounces-10477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D7A4A716
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 01:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AA316F9D7
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 00:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838411CBA;
	Sat,  1 Mar 2025 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="duIgKnzi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8DD2FB;
	Sat,  1 Mar 2025 00:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789504; cv=none; b=Tt9HlsbIYDItXnvaD+iozmdgdKbS90JgFMD3qq1mPPD7urweoMEZbC4RBQCdneeX0IHzaCJ7CgEVzBYOPAOVF3tvFpKroIw+n8y9ETuWn32awY0KzUaOmle3APD4BXh0n8Z/4xpnb1vBL84wMCCbpX+59gAAiQA9t/QsX49lL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789504; c=relaxed/simple;
	bh=n6zaxksd6Q1NUg/ohWVJeoMwMSB2pFa01Kpp7ynuDkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVG4WkUaxc93p30oX/JhJ26KJnRlOTBsVTmQVm9bgRWU2bjbe/uN2LKkd77M5kM0eqKNZh3tdBuomOcE/m0zCA9+wpxBH1VzOHKjIcbg3UI6a+vYIOxKskLP7ua2zjQlj6SJ9sCgvEPWf2LKceu82KOuE1ftFqiPIl6U5I/AnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=duIgKnzi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 297612038A22;
	Fri, 28 Feb 2025 16:38:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 297612038A22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740789502;
	bh=KckT26d6nP7QZ+/ykn1bui1INDXn2fKcmCtw1s0XLcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=duIgKnzi0YqTq8nTW9lxdfwU+lhdDZ68Vr54Cm+FjinsQ//tXQ7RD7UbvDDOFpnVx
	 sYy/xwGAy3qPvhtmpRTpd5Dfusaj2uSOkBm0IIB6rTEsHLeoFoJdheCAczw3nq9Pta
	 L5r2XPnSPzFfbwnylYl8fKpNlQQ9xS/sED3vuer0=
Message-ID: <7de9b06d-9a32-48b5-beda-2e19b36ae9c9@linux.microsoft.com>
Date: Fri, 28 Feb 2025 16:38:19 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 mrathor@linux.microsoft.com, ssengar@linux.microsoft.com,
 apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
 stanislav.kinsburskiy@gmail.com, gregkh@linuxfoundation.org,
 vkuznets@redhat.com, prapal@linux.microsoft.com, muislam@microsoft.com,
 anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
 corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
 <Z7-nDUe41XHyZ8RJ@skinsburskii.>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <Z7-nDUe41XHyZ8RJ@skinsburskii.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:43 PM, Stanislav Kinsburskii wrote:
> On Wed, Feb 26, 2025 at 03:08:02PM -0800, Nuno Das Neves wrote:
>> This will handle SYNIC interrupts such as intercepts, doorbells, and
>> scheduling messages intended for the mshv driver.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Wei Liu <wei.liu@kernel.org>
>> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>  arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>>  drivers/hv/hv_common.c         | 5 +++++
>>  include/asm-generic/mshyperv.h | 1 +
>>  3 files changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 0116d0e96ef9..616e9a5d77b4 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -107,6 +107,7 @@ void hv_set_msr(unsigned int reg, u64 value)
>>  }
>>  EXPORT_SYMBOL_GPL(hv_set_msr);
>>  
>> +static void (*mshv_handler)(void);
>>  static void (*vmbus_handler)(void);
>>  static void (*hv_stimer0_handler)(void);
>>  static void (*hv_kexec_handler)(void);
>> @@ -117,6 +118,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>>  
>>  	inc_irq_stat(irq_hv_callback_count);
>> +	if (mshv_handler)
>> +		mshv_handler();
> 
> Can mshv_handler be defined as a weak symbol doing nothing instead
> of defining it a null pointer?
> This should allow to simplify this code and get rid of
> hv_setup_mshv_handler, which looks redundant.
> 
Interesting, I tested this and it does seems to work! It seems like
a good change, thanks.

> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
>> +
>>  	if (vmbus_handler)
>>  		vmbus_handler();
>>  
>> @@ -126,6 +130,11 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>>  	set_irq_regs(old_regs);
>>  }
>>  
>> +void hv_setup_mshv_handler(void (*handler)(void))
>> +{
>> +	mshv_handler = handler;
>> +}
>> +
>>  void hv_setup_vmbus_handler(void (*handler)(void))
>>  {
>>  	vmbus_handler = handler;
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 2763cb6d3678..f5a07fd9a03b 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -677,6 +677,11 @@ void __weak hv_remove_vmbus_handler(void)
>>  }
>>  EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
>>  
>> +void __weak hv_setup_mshv_handler(void (*handler)(void))
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
>> +
>>  void __weak hv_setup_kexec_handler(void (*handler)(void))
>>  {
>>  }
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 1f46d19a16aa..a05f12e63ccd 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -208,6 +208,7 @@ void hv_setup_kexec_handler(void (*handler)(void));
>>  void hv_remove_kexec_handler(void);
>>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
>>  void hv_remove_crash_handler(void);
>> +void hv_setup_mshv_handler(void (*handler)(void));
>>  
>>  extern int vmbus_interrupt;
>>  extern int vmbus_irq;
>> -- 
>> 2.34.1
>>


