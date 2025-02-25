Return-Path: <linux-arch+bounces-10370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25F9A45018
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B687171FC5
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8741C21D5A9;
	Tue, 25 Feb 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GmOF2vVu"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830F21D3E2;
	Tue, 25 Feb 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522327; cv=none; b=d5Mte+cQAZY9R8EAki3CjTCrtuoOpa1Yupcxn1Ez0SWFzeaxlTAoh8bWoTDGYKoD4cQJ4vBOXde8ItdAGfN1flnFtPO/UCTl0wdL11C7mOx2tA/8JYE4AjGAlAu72oMVbXEbJEzWh5GRVrUHKfdyFZqCb4vEyJFQLVahftbrZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522327; c=relaxed/simple;
	bh=t5XHU8FuzTxYJsQJ0aplVsiqJvj2QQrZy+BDGGLfJeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYfC3F3K9wMOXY+843JE3lM826/fK5k29FP2oU2FiETg9DhsXFk4z85Bcx5ES/x6OqilSfsBGpak2nfDe2/GNj3OUydrU9WGnEcgWn+xCyQxMaCTUb2lt/h9DxB0Le0boL7cFRHNdB7QDK3axMZMcDmALZcAqKpoxuFcEOeTbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GmOF2vVu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1BF1D203CDFE;
	Tue, 25 Feb 2025 14:25:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BF1D203CDFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740522325;
	bh=4snbY5kKjPs+fqnW4bDVzUWCVcYb+NMujdrOx1UsTIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GmOF2vVuCkJZ1DfUd1ljj8/fusb2yUMbDy2WmYxFrMMfaTTzbAqkWEUBwLUg55zpF
	 Eal2Uv7psJ6AMd7GHQIuT0F5bT24oqPS+VN9NVDy5j/15vSuizsFBxdX1p+w7B0n5d
	 f2jfhVcFODVbMweP0SK+AakuXEGuKdQiYOukQldU=
Message-ID: <a96f9469-a22e-43e7-825d-f67ef550898f@linux.microsoft.com>
Date: Tue, 25 Feb 2025 14:25:24 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
To: Arnd Bergmann <arnd@arndb.de>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
 bhelgaas@google.com, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, krzk+dt@kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Rob Herring <robh@kernel.org>,
 ssengar@linux.microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
 Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
 devicetree@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
 <1b14e3de-4d3e-420c-819c-31ffb2d448bd@app.fastmail.com>
 <593c22ca-6544-423d-84ee-7a06c6b8b5b9@linux.microsoft.com>
 <97887849-faa8-429b-862b-daf6faf89481@app.fastmail.com>
 <6e4685fe-68e9-43bd-96c5-b871edb1b971@linux.microsoft.com>
 <14a199d8-1cf3-49bc-8e0d-92d9c8407b4f@linux.microsoft.com>
 <55b65ba6-4abe-478c-a173-4622c30ddd7b@app.fastmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <55b65ba6-4abe-478c-a173-4622c30ddd7b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/2025 11:24 PM, Arnd Bergmann wrote:
> On Tue, Feb 25, 2025, at 00:22, Roman Kisel wrote:
>> Hi Arnd,

[...]

> If you want to declare a uuid here, I think you should remove the
> ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_{0,1,2,3} macros and just
> have UUID in normal UUID_INIT() notation as we do for
> other UUIDs.

I'd gladly stick to that provided I have your support of touching
KVM's code! As the SMCCC document states, there shall be an UUID,
and in the kernel, there would be

#define ARM_SMCCC_VENDOR_KVM_UID UUID_INIT(.......)
#define ARM_SMCCC_VENDOR_HYP_UID UUID_INIT(.......)

Hence, the ARM_SMCCC_VENDOR_HYP_UID_*_REG_{0,1,2,3} can be removed as
you're suggesting.

That looks enticing enough semantically as though we're building layers
from the SMCCC spec down to the "on-wire format" -- the only part that
needs "deserializing" the UUID from `struct arm_smccc_res` the
hypervisor returns.

To add to that, anyone who wishes to implement a hypervisor for arm64
will have to use some RFC 9562-compliant UUID generating facility. Thus,
the UUID predates these 4 dwords. Using UUIDs in the kernel code will
relieve of the chore of figuring out the 4 dwords from the UUID.

Also, for the Gunyah folks will be pretty easy to use this infra:
define the UUID in the header (1 line), call the new function (1 line),
done.

> 
> If you want to keep the four 32-bit values and pass them into
> arm_smccc_hyp_present() directly, I think that is also fine,
> but in that case, I would try to avoid calling it a UUID.

IMO, that approach provides a simplicity where anyone can see if the
code is wrong from a quick glance: just compare 4 dwords. The fact that
the 4 dwords form an UUID is bypassed though (as it is in the existing
code). Somehow feels not spec-accurate imo. Also when I remove the UID
part from the names, I'm going to have a rather weak justification as
to why this is a benefit.

Likely, there are two levels of improvement here:

1. Just refactor the common parts out and have
    `bool arm_smccc_hyp_present(u32 reg0, u32 reg1, u32 reg2, u32 reg2);`

2. Introduce the UUID usage throughout and have a spec-accurate
    prototype of
    `bool arm_smccc_hyp_present(const uuid_t *hyp_uuid);`

and would be great to go for the second one :)

> 
> How are the kvm and hyperv values specified originally?
>>From the SMCCC document it seems like they are meant to be
> UUIDs, so I would expect them to be in canonical form rather
> than the smccc return values, but I could not find a document
> for them.

For hyperv case, `uuidgen` produced the UUID and that is used.
Likely the same for kvm.

> 
>       Arnd

-- 
Thank you,
Roman


