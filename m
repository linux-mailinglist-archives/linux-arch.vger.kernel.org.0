Return-Path: <linux-arch+bounces-13403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BCFB49754
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B033B4ADE
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79061313281;
	Mon,  8 Sep 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DwSvuPvy"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187F22173F;
	Mon,  8 Sep 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353119; cv=none; b=AOKEg7YpUpKprA41b23G2f7XB+yX5jm0hYMrL7RTuAFPxvMWmrsUjYOSOxxA7IrwqhQ3qo/bkLQJ00E2jdJbQS2LSSuK76koPYlvXPESF3jrf4KUnTQwDeZgjpARFtqVyYp7+Qk8j8hVK+qdkVchADDxP1sJyl5km+5obDWlYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353119; c=relaxed/simple;
	bh=WlfiSYaSVoVxa8Ptzyy1VHkIpxOEz76sEwatt5F6bwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhNaZPD56dyUbsXe+Rt47frZVrwgJI91bAytcnp/1vpDuwkw5btEUrNY0FxwJziZ57BxZFeaV2G2YsHs6y8FOpoyjnDX6xquRE3Ayau4kDl2BN06600pgHbQdzfxfeo1WT8BdeeINw1Qe4pIRf1suDiLeYod4KifyeGeAfmxQsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DwSvuPvy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C8B320171BA;
	Mon,  8 Sep 2025 10:38:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C8B320171BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757353117;
	bh=FXWIWaZroTZV0Yf4Lr1IBpE25EZNI56oMYhQSEb5rTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DwSvuPvyWNm+qKQcZWeVZ4wEA8rqkBbobIvPVqfptyzYyuYdhGoRxX969Ug2kcoqG
	 o7aRAHTT1qwRuVeqTdpezhE09UacU6e/2lveEirSJSeAKLua8vyC2vq3TOVpWAVpVZ
	 z8zaTnjjD4cnWFOGYPSvU/NBRdSRqJp4VRQdIRtc=
Message-ID: <d8b8f47d-8e17-95bd-a637-ea42d0eaa709@linux.microsoft.com>
Date: Mon, 8 Sep 2025 10:38:36 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
 <20250904021017.1628993-6-mrathor@linux.microsoft.com>
 <aL8Cfsl3Vaeuw-QI@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aL8Cfsl3Vaeuw-QI@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 09:21, Stanislav Kinsburskii wrote:
> On Wed, Sep 03, 2025 at 07:10:16PM -0700, Mukesh Rathor wrote:
>> This commit introduces a new file to enable collection of hypervisor ram
>> into the vmcore collected by linux. By default, the hypervisor ram is locked,
>> ie, protected via hw page table. Hyper-V implements a disable hypercall which
>> essentially devirtualizes the system on the fly. This mechanism makes the
>> hypervisor ram accessible to linux without any extra work because it is
>> already mapped into linux address space. Details of the implementation
>> are available in the file prologue.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_crash.c | 618 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 618 insertions(+)
>>  create mode 100644 arch/x86/hyperv/hv_crash.c
>>
>> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
>> new file mode 100644
>> index 000000000000..50c54d39f0e2
>> --- /dev/null
>> +++ b/arch/x86/hyperv/hv_crash.c
>> +
> 
> <snip>
> 
>> +/*
>> + * generic nmi callback handler: could be called without any crash also.
>> + *  hv crash: hypervisor injects nmi's into all cpus
>> + *  lx crash: panicing cpu sends nmi to all but self via crash_stop_other_cpus
>> + */
>> +static int hv_crash_nmi_local(unsigned int cmd, struct pt_regs *regs)
>> +{
>> +	int ccpu = smp_processor_id();
>> +
>> +	if (!hv_has_crashed && hv_cda && hv_cda->cda_valid)
>> +		hv_has_crashed = 1;
>> +
>> +	if (!hv_has_crashed && !lx_has_crashed)
>> +		return NMI_DONE;	/* ignore the nmi */
>> +
>> +	if (hv_has_crashed && !hv_crash_enabled) {
>> +		if (ccpu == 0) {
>> +			pr_emerg("Hyper-V: core collect not setup. Reboot\n");
>> +			native_wrmsrq(HV_X64_MSR_RESET, 1);	/* reboot */
>> +		} else
>> +			for (;;)
>> +				cpu_relax();
>> +	}
>> +
>> +	crash_nmi_callback(regs);
>> +	return NMI_DONE;
>> +}
> 
> One more thing.
> It looks like the function above goes through the new logic even when
> hypervisor is intact and there is no crash kernel loaded.
> This is redundant and it should rather return back to the existent
> generic kernel panic logic.

Yeah, that is already addressed in V1 coming up.


