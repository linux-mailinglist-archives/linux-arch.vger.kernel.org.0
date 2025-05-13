Return-Path: <linux-arch+bounces-11920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BE9AB59C4
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 18:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20497B07EA
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BCA28F514;
	Tue, 13 May 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PujOiI0d"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117515533F;
	Tue, 13 May 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153485; cv=none; b=KPaTDW9rh1uis5XvlPDPySymkLyv+rKjV9XPUQ+kMkE+9r7wPEPG/fElHUFSvy6KbGDzFgcVcaTCV7TtxuUVJy770/VTbmRrurbh388CmZNuLEMumamS9MM2tpSlCLVx+FWcYVNI1yO+Se/K2FLQQKF4vyxOU2H7a6AbcuDVIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153485; c=relaxed/simple;
	bh=5ExU0elbNPopRtmR4qkqMuHkiy7iFHwMixxy23Z1xnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plX7UVt+lTVhnl2zy2YjYgQ57/iQ/g2ZjH09y3IM2xVr1HKsq6m202jHORx8IsDnNBHoL5BE94tdqihjEo+4U9rcr2P2LajhUCMxBGH3A2LZtQVbiM0K5XXzS3OHPgrOf11l+dyWrod2Gm6UztQkKjvFh4kCa7yn2n/ic9AtAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PujOiI0d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A823201DB12;
	Tue, 13 May 2025 09:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A823201DB12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747153483;
	bh=hPw5Z2uvInKn7g/gZE/EvdCBuTQHsMF4h31bQ1SEDak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PujOiI0dqkEedcDbArZnlNr4qQUkjW6EgaOn59dT9qxC2WYV6oog4dOtjs3YNI8TE
	 iAo+tTqsxqY0YkeqIDjtwXto1i0zsLHljx+IWZtRP3rsFwkrdIs0GdGWeX8X0pmiB1
	 aqecwOK6IVebzWSG+HdIF3zto+Z4WMHhZemZ+tA8=
Message-ID: <dd988a9d-edad-4362-a4c2-a6e6b1667e9b@linux.microsoft.com>
Date: Tue, 13 May 2025 09:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 1/4] Documentation: hyperv: Confidential
 VMBus
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com, arnd@arndb.de, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-2-romank@linux.microsoft.com>
 <5d21de5c-2da2-4a33-8d30-0475bc0edf4b@oracle.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <5d21de5c-2da2-4a33-8d30-0475bc0edf4b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/11/2025 10:22 PM, ALOK TIWARI wrote:
> 
> 
> On 12-05-2025 04:37, Roman Kisel wrote:
>> Define what the confidential VMBus is and describe what advantages
>> it offers on the capable hardware.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   Documentation/virt/hyperv/vmbus.rst | 41 +++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/ 
>> hyperv/vmbus.rst
>> index 1dcef6a7fda3..ca2b948e5070 100644
>> --- a/Documentation/virt/hyperv/vmbus.rst
>> +++ b/Documentation/virt/hyperv/vmbus.rst
>> @@ -324,3 +324,44 @@ rescinded, neither Hyper-V nor Linux retains any 
>> state about
>>   its previous existence. Such a device might be re-added later,
>>   in which case it is treated as an entirely new device. See
>>   vmbus_onoffer_rescind().
>> +
>> +Confidential VMBus
>> +------------------
>> +
> 
> The purpose and benefits of the Confidential VMBus are not clearly stated.
> for example:
> "Confidential VMBus provides a secure communication channel between 
> guest and paravisor, ensuring that sensitive data is protected from 
> hypervisor-level access through memory encryption and register state 
> isolation."
> 
>> +The confidential VMBus provides the control and data planes where
>> +the guest doesn't talk to either the hypervisor or the host. Instead,
>> +it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
>> +the guest memory and the register state also measuring the paravisor
> 
> s/alos/while and s/via using/using
> "register state while measuring the paravisor image using the platform 
> security"
> 
>> +image via using the platform security processor to ensure trusted and
>> +confidential computing.
>> +
>> +To support confidential communication with the paravisor, a VMBus client
>> +will first attempt to use regular, non-isolated mechanisms for 
>> communication.
>> +To do this, it must:
>> +
>> +* Configure the paravisor SIMP with an encrypted page. The paravisor 
>> SIMP is
>> +  configured by setting the relevant MSR directly, without using GHCB 
>> or tdcall.
>> +
>> +* Enable SINT 2 on both the paravisor and hypervisor, without setting 
>> the proxy
>> +  flag on the paravisor SINT. Enable interrupts on the paravisor SynIC.
>> +
>> +* Configure both the paravisor and hypervisor event flags page.
>> +  Both pages will need to be scanned when VMBus receives a channel 
>> interrupt.
>> +
>> +* Send messages to the paravisor by calling HvPostMessage directly, 
>> without using
>> +  GHCB or tdcall.
>> +
>> +* Set the EOM MSR directly in the paravisor, without using GHCB or 
>> tdcall.
>> +
>> +If sending the InitiateContact message using non-isolated 
>> HvPostMessage fails,
>> +the client must fall back to using the hypervisor synic, by using the 
>> GHCB/tdcall
>> +as appropriate.
>> +
>> +To fall back, the client will have to reconfigure the following:
>> +
>> +* Configure the hypervisor SIMP with a host-visible page.
>> +  Since the hypervisor SIMP is not used when in confidential mode,
>> +  this can be done up front, or only when needed, whichever makes 
>> sense for
>> +  the particular implementation.
> 
> "SIMP is not used in confidential mode,
> this can be done either upfront or only when needed, depending on the 
> specific implementation."
> 
>> +
>> +* Set the proxy flag on SINT 2 for the paravisor.
> 

Alok, thanks for you continued interest and support! I'll incorporate
your suggestions in the next version of the patchset, great points!

> 
> Thanks,
> Alok
> 

-- 
Thank you,
Roman


