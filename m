Return-Path: <linux-arch+bounces-10147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE6A35871
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 09:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A52F161C23
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FF22155B;
	Fri, 14 Feb 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="THxQzU9i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vEKJI7qq"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE27E0ED;
	Fri, 14 Feb 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520377; cv=none; b=MTBfCbyAuMCS6kDmeXGZI5x985Tc9Q6mcB5HxRaiyrCpHio2Z1mOx877T0/iOVmkw57lWzjXMv76WBB7oSwEqyws4D2fXX0OpK0hnawnz7WYCYiGex1gztQ3BsviE0vgyZV62I2aKY06zp+Fs3c8FFLn8NEHGdCuBAo8QazJz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520377; c=relaxed/simple;
	bh=Mbqi3mJFEoiY4aywHqfpuLMNgY72aqCdmb/d2xpFlDI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q6q+Oc+rdhZc5i/vakSVaT0b3S8uGsusKJnSa1AHLQS/Aqsr5NKPR7yXx1lKclSuPpz3ODmCm0ft74KPzzUSTDqAPWEHDCrj3x14heIIs9Yr3w7XtCWkRwOwq28qsQYKet2BGMl2JY7brUMFCYe+KGEDGjY6VMJpkhmLEN2S3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=THxQzU9i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vEKJI7qq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20CBE2540178;
	Fri, 14 Feb 2025 03:06:13 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 14 Feb 2025 03:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739520372;
	 x=1739606772; bh=H6Gp9DB5WCSEcuQCJqQrEsWpuCn5jqk72qwNA/OoRvo=; b=
	THxQzU9iQfDw3CE2kEloob98WRdDJsA4gxfya+6oLzgcMF2JDy87H5cRz9zjwARo
	WY5qC2W+FBP4JVx8rV0XhIDqg6oFweRIiWgPsyPbEQbEByuXyalL8kLP5TBb6/ud
	NrBct4aYr2L1sIIHUdSkYYO1tvEnitpqKvjiHEzKYaqK0F8iupKn2EiV7RPCvxZM
	bsX8gU5MdR+jfgYN2ILFS/W2LFqVM+OBIKojS62zv/4RBuDHcm1QB9NDPWvt7mu/
	j+4kuJP/CPDx3ndOvEJKB/K/7i9WvyFnEQYjkXBBUCF6uJLT4zbJPJR+2hY2PE0a
	2oYi+vsDQFwAbKUSUL05Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739520372; x=
	1739606772; bh=H6Gp9DB5WCSEcuQCJqQrEsWpuCn5jqk72qwNA/OoRvo=; b=v
	EKJI7qqv8tayGGKpzZBvYNDtRiipJJkcNGcKSP+EhQ8wsdY6ty7uUU6Qt1i1bETK
	BcI8jB7a8WASkkqZ6jNqNelEzr41mhxXqpFa8z8yctr7LSEq93T8SuMve8vwZ+Ac
	IDBGUOA2d66MqAAcZugQZGWvl+XhW3spqQUwReM8hqwJ+6Vm4v4Zaet/EAiz9Yiv
	cytTwPN5JubeangvEE7VADU/MGof0L1H2U9GOXytP2/rqaxDOzvjvyLAyWgvZJ1d
	wVnCAH4q3vPy3wFsshMhUCAjItMy2sU60bXTbH4W35t/EQDGQA5HxuAnx/ns+ZxD
	pVfjGssMtwk9K0WoHhNpw==
X-ME-Sender: <xms:c_muZwX48Lh_xZs2IU6bDL1rdB8LT6oqGgZpRonlo5sen0HwCImyrg>
    <xme:c_muZ0k0AICaX-vC6XxNAIoV9pAWxQHAk2o5A5KRC8GL6hhilhZHSDgbk4Wv1nc_h
    WwZzXS2D0O38pPVky0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghonhhorh
    doughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghirdhl
    ihhusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:c_muZ0YxvCcRRznY5PEZ-WHP6YYtLBt-g5JzyS9xw7eTUTGJhFFLZA>
    <xmx:c_muZ_VK0WT4H887Nvd27xHDQFNSj_V4PN6uNmtAA-vcr1KKc8zk5Q>
    <xmx:c_muZ6nMlMLgiBiw9alU1wkGeocCf93h0y1G4R7Re8HKnpAIzgPaxQ>
    <xmx:c_muZ0eW7UPUpepsHE6P-gBngPmgv84dTpielAQWIbSQ-6F_CWdLRg>
    <xmx:dPmuZ6uhMhdzt-6CWdxmXjq8IYXRxbmmHE-3PCv20PutEwrLhkeSiX2S>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C5C902220072; Fri, 14 Feb 2025 03:06:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 09:05:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>, bhelgaas@google.com,
 "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Dexuan Cui" <decui@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, krzk+dt@kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Rob Herring" <robh@kernel.org>,
 ssengar@linux.microsoft.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Wei Liu" <wei.liu@kernel.org>, "Will Deacon" <will@kernel.org>,
 devicetree@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Message-Id: <97887849-faa8-429b-862b-daf6faf89481@app.fastmail.com>
In-Reply-To: <593c22ca-6544-423d-84ee-7a06c6b8b5b9@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
 <1b14e3de-4d3e-420c-819c-31ffb2d448bd@app.fastmail.com>
 <593c22ca-6544-423d-84ee-7a06c6b8b5b9@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect hypervisor
 presence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 14, 2025, at 00:23, Roman Kisel wrote:
> On 2/11/2025 10:54 PM, Arnd Bergmann wrote:

> index a74600d9f2d7..86f75f44895f 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -67,6 +67,30 @@ s32 arm_smccc_get_soc_id_revision(void)
>   }
>   EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>
> +bool arm_smccc_hyp_present(const uuid_t *hyp_uuid)

The interface looks good to me.

> +{
> +	struct arm_smccc_res res = {};
> +	struct {
> +		u32 dwords[4]
> +	} __packed res_uuid;

The structure definition here looks odd because of the
unexplained __packed attribute and the nonstandard byteorder.

The normal uuid_t is defined as an array of 16 bytes,
so if you try to represent it in 32-bit words you need to
decide between __le32 and __be32 representation.

> +	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
> +		return false;
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return false;
> +
> +	res_uuid.dwords[0] = res.a0;
> +	res_uuid.dwords[1] = res.a1;
> +	res_uuid.dwords[2] = res.a2;
> +	res_uuid.dwords[3] = res.a3;
> +
> +	return uuid_equal((uuid_t *)&res_uuid, hyp_uuid);

The SMCCC standard defines the four words to be little-endian,
so in order to compare them against a uuid byte array, you'd
need to declare the array as __le32 and swap the result
members with cpu_to_le32().

Alternatively you could pass the four u32 values into the
function in place of the uuid.

Since the callers have the same endianess confusion, your
implementation ends up working correctly even on big-endian,
but I find it harder to follow when you call uuid_equal() on
something that is not the actual uuid_t value.

> +
> +#define ARM_SMCCC_HYP_PRESENT(HYP) 								\
> +	({															\
> +		const u32 uuid_as_dwords[4] = {							\
> +			ARM_SMCCC_VENDOR_HYP_UID_ ## HYP ## _REG_0,			\
> +			ARM_SMCCC_VENDOR_HYP_UID_ ## HYP ## _REG_1,			\

I don't think using a macro is helpful here, it just makes
it impossible to grep for ARM_SMCCC_VENDOR_HYP_UID_* values when
reading the source.

I would suggest moving the UUID values into a variable next
to the caller like

#define ARM_SMCCC_VENDOR_HYP_UID_KVM \
    UUID_INIT(0x28b46fb6, 0x2ec5, 0x11e9, 0xa9, 0xca, 0x4b, 0x56, 0x4d, 0x00, 0x3a, 0x74)

and then just pass that into arm_smccc_hyp_present(). (please
double-check the endianess of the definition here, I probably
got it wrong myself).

     Arnd

