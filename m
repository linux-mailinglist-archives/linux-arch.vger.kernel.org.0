Return-Path: <linux-arch+bounces-10919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A5A65A31
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 18:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D149171F5F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F71E51EF;
	Mon, 17 Mar 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iB5HkHF/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8F1E1DF2;
	Mon, 17 Mar 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231495; cv=none; b=MD4K0mbUV/Gj7qAgrFY5s/Q+Q14UoEM8akPiWcC4Fa5wVpFBdRnsaVy2pkxiQgG00T+P4dwNTy5Fssl8i/X3GX0utiyRfbk/oKTAks5HUZkQhr/vZDIlN+Vhzh/jHFg45wJNCo7rKVMAUs3HJBI8PPQdXlWbyFgNIbDhh3iM1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231495; c=relaxed/simple;
	bh=Dvsb1FOldA8QHsgHDjSp2x/08D4d3Ma/GM9n1NmyGRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJAqnZeNtEB+AYUjcd88qiizzcUIbVHkNYxNKNP1IK0OdI142z2GODYl2p1ZLEFCCjAOx8iEdgY3aN94Lf8A25GGphjFwdbGCTZ++qeFdk6TuAkYQ6Qz7d6rVqNPLeUM37uu9dBUgx3RKnnhF0QO3XwBGyEpMlvb4sC12DYDCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iB5HkHF/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 829452033441;
	Mon, 17 Mar 2025 10:11:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 829452033441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742231492;
	bh=qgR7z0T2ShM1jjkPMrelwXUQsvor6qx9o5NQCWLdIwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iB5HkHF/A/Slm14vX+aYEAmVR42WWsEoeBkLbzvaiREpnLDzWzHQvyPfIpAMI5vNP
	 cGxzvVsNVvS63EDK4o/DOK/hA+9ejTYQXhejalajxyoCA3OS8peBoo9E3lm9FqtPpe
	 dXqlCaDHhHvIVonIlr8haVF0Jk1ZYa4yKt/doL6g=
Message-ID: <d168a483-b425-4c18-ad71-eb39a0aba06c@linux.microsoft.com>
Date: Mon, 17 Mar 2025 10:11:32 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 01/11] arm64: kvm, smccc: Introduce and use
 API for detecting hypervisor presence
To: Mark Rutland <mark.rutland@arm.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
 kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-2-romank@linux.microsoft.com>
 <Z9gHmkNOsd29viHj@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z9gHmkNOsd29viHj@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/17/2025 4:29 AM, Mark Rutland wrote:
> On Fri, Mar 14, 2025 at 05:19:21PM -0700, Roman Kisel wrote:

[...]

>> +}
> 
> This use of a statement expression is bizarre, and the function would be
> clearer without it, e.g.

I'll change that to what you're suggesting, thanks for your help!

> 
> | bool arm_smccc_hyp_present(const uuid_t *hyp_uuid)
> | {
> | 	struct arm_smccc_res res = {};
> | 	uuid_t uuid;
> |
> | 	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
> | 		return false;
> |
> | 	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> | 	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> | 		return false;
> | 	
> | 	uuid_t = SMCCC_RES_TO_UUID(res.a0, res.a1, res.a2, res.a3);
> | 	return uuid_equal(&uuid, hyp_uuid);
> | }
> 
> As noted below, I'd prefer if this were renamed to something like
> arm_smccc_hypervisor_has_uuid(), to more clearly indicate what is being
> checked.
> 
> [...]

Will update, thanks for your help!

> 
>> +/**
>> + * arm_smccc_hyp_present(const uuid_t *hyp_uuid)
>> + *
>> + * Returns `true` if the hypervisor advertises its presence via SMCCC.
>> + *
>> + * When the function returns `false`, the caller shall not assume that
>> + * there is no hypervisor running. Instead, the caller must fall back to
>> + * other approaches if any are available.
>> + */
>> +bool arm_smccc_hyp_present(const uuid_t *hyp_uuid);
> 
> I'd prefer if this were:
> 
> | /*
> |  * Returns whether a specific hypervisor UUID is advertised for the
> |  * Vendor Specific Hypervisor Service range.
> |  */
> | bool arm_smccc_hypervisor_has_uuid(const uuid_t *uuid);
> 
[...]



> 
> I think this'd be clearer if we did something similar to what we did for
> the SMCCC SOC_ID name:
> 
>    https://lore.kernel.org/linux-arm-kernel/20250219005932.3466-1-paul@os.amperecomputing.com/
> 
> ... and pack/unpack the bytes explicitly, e.g.

That looks great, thanks for the suggestion!

> 
> | static inline uuid smccc_res_to_uuid(u32 r0, u32, r1, u32 r2, u32 r3)
> | {
> | 	uuid_t uuid = {
> | 		.b = {
> | 			[0]  = (r0 >> 0)  & 0xff,
> | 			[1]  = (r0 >> 8)  & 0xff,
> | 			[2]  = (r0 >> 16) & 0xff,
> | 			[3]  = (r0 >> 24) & 0xff,
> |
> | 			[4]  = (r1 >> 0)  & 0xff,
> | 			[5]  = (r1 >> 8)  & 0xff,
> | 			[6]  = (r1 >> 16) & 0xff,
> | 			[7]  = (r1 >> 24) & 0xff,
> |
> | 			[8]  = (r2 >> 0)  & 0xff,
> | 			[9]  = (r2 >> 8)  & 0xff,
> | 			[10] = (r2 >> 16) & 0xff,
> | 			[11] = (r2 >> 24) & 0xff,
> |
> | 			[12] = (r3 >> 0)  & 0xff,
> | 			[13] = (r3 >> 8)  & 0xff,
> | 			[14] = (r3 >> 16) & 0xff,
> | 			[15] = (r3 >> 24) & 0xff,
> | 		},
> | 	};
> |
> | 	return uuid;
> | }
> 
> ... which is a bit more verbose, but clearly aligns with what the SMCCC
> spec says w.r.t. packing/unpacking, and should avoid warnings about
> endianness conversions.
> 

I believe what you're proposing hits a better trade-off, thanks again!

>> +
>> +#define UUID_TO_SMCCC_RES(uuid_init, regs) do { \
>> +		const uuid_t uuid = uuid_init; \
>> +		(regs)[0] = le32_to_cpu((u32)uuid.b[0] | (uuid.b[1] << 8) | \
>> +						((uuid.b[2]) << 16) | ((uuid.b[3]) << 24)); \
>> +		(regs)[1] = le32_to_cpu((u32)uuid.b[4] | (uuid.b[5] << 8) | \
>> +						((uuid.b[6]) << 16) | ((uuid.b[7]) << 24)); \
>> +		(regs)[2] = le32_to_cpu((u32)uuid.b[8] | (uuid.b[9] << 8) | \
>> +						((uuid.b[10]) << 16) | ((uuid.b[11]) << 24)); \
>> +		(regs)[3] = le32_to_cpu((u32)uuid.b[12] | (uuid.b[13] << 8) | \
>> +						((uuid.b[14]) << 16) | ((uuid.b[15]) << 24)); \
>> +	} while (0)
>> +
>> +#endif /* !__ASSEMBLER__ */
> 
> IMO it'd be clearer to initialise a uuid_t beforehand, and then allow
> the helper to unpack the bytes, e.g.
> 
> static inline u32 smccc_uuid_to_reg(const uuid_t uuid, int reg)
> {
> 	u32 val = 0;
> 
> 	val |= (u32)(uuid.b[4 * reg + 0] << 0)
> 	val |= (u32)(uuid.b[4 * reg + 1] << 8)
> 	val |= (u32)(uuid.b[4 * reg + 2] << 16)
> 	val |= (u32)(uuid.b[4 * reg + 3] << 24)
> 
> 	return val:
> }
> 
> #define UUID_TO_SMCCC_RES(uuid, regs)		\
> do {						\
> 	(regs)[0] = smccc_uuid_to_reg(uuid, 0); \
> 	(regs)[1] = smccc_uuid_to_reg(uuid, 1); \
> 	(regs)[2] = smccc_uuid_to_reg(uuid, 2); \
> 	(regs)[3] = smccc_uuid_to_reg(uuid, 3); \
> } while (0)
> 
> ... though arguably at that point you can get rid of the
> UUID_TO_SMCCC_RES() macro and just expand that directly at the callsite.
> 

I'll work on that, thanks!!

> Mark.

-- 
Thank you,
Roman


