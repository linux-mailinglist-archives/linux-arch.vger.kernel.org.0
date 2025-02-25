Return-Path: <linux-arch+bounces-10352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB45A4360F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B804517389D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 07:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAD256C6C;
	Tue, 25 Feb 2025 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Crrc19jd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whzV6Y3h"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3C18A6BA;
	Tue, 25 Feb 2025 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468328; cv=none; b=O5JCTTjWdKWNbjjb/LY89quHyuUCs6EfCqhCo+9ykpUvUahoPjuU9OaLml3DlDwffiWt51CHPNHHCQG8Ekxo+QMr+cLJ8CrfdbnY2Owjg5q8rH5zMUEThaDCreNzGHpZm51jqFdzBgNtDhpjOgy3vYFVMEld2vAG2PxIqLYQHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468328; c=relaxed/simple;
	bh=jBWBE67xp0aA/g9uYHMJWanv7CTWes7h1prFsPBs1Oo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h3eEbhQnKgXHBITh5Oa5zSQYSwyPH9K1fFGF7mpTwwJCxwP3vJLAe71+7o1rCCq6xJRVhCkBwfWkI3YLBXHM86+4kJIL3K5rUBZqCi2zl/7HG7WMr5BluxuDdXSs4AyNV7XSmqTsUrjFp9fu61rqgMqGCWO9LId7vi8uHZGvXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Crrc19jd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=whzV6Y3h; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 72696114016E;
	Tue, 25 Feb 2025 02:25:23 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 02:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740468323;
	 x=1740554723; bh=iNyMNq0Sztwv4vKDhGfFbMXIy/g1nHUCGUIykQmuxWc=; b=
	Crrc19jdVh7/XBZAtR/NMXS4XDxP15gWTLHCfBDvQS676Lg8rynDp3eHsGxkQzOL
	NA6+6MAjUiLoPQmu2RiInQC2bPTzaEHZhxFhtAxG2nKrgD7yJhCiJ8Mt9IiufWsV
	fPYYYk3p5Lcd5wsAIlI2JQk1MLZqu4oPDJasJheax161IJ46K91fFfPtJDj5SbM9
	T0hntAh8i6J0zAFYKwdj1gkrvLFe4deGMjOv2P5WVvP4N4BSrELOBLc708mfUPHI
	43UjhAa34yyhwVHf7ypmWXQX7TAxCgyOweBC5H7/+C7Gg2vuf7hs7iJekp2//I2n
	Jvica6vniO0L8eUGctctwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740468323; x=
	1740554723; bh=iNyMNq0Sztwv4vKDhGfFbMXIy/g1nHUCGUIykQmuxWc=; b=w
	hzV6Y3hj5gWp/iDMqIx98JPoZOcwRLI9d1i8zlOU/RAUy+7IN5uPMPBjab2NCQyd
	LMkj8W6q1/gHgLHDo98I6REoWQ/IUlycP4gdzmxqrs5rcWd4rE0QTrqe/Qq7ipcR
	1TukjGbHToX6OBLGcTfynSUtg3pNqUrMJsH86ZMon4tgVd+2U1H1kYo2UhyvUMtK
	CQVql3lLJY9IZSvDdmpfF/B6UYL6tVYb1VwSb36/JmunHby+rrqYNWFvnfPklsV9
	W3GQb+SCgqfTcQp6qF5/y02gx4enLl5etsFLUDfQEOKg7vDo/I3wk5qWMiRSnz2E
	A1qzcH81WGbVu17pqlUyw==
X-ME-Sender: <xms:YnC9Z5OsvGdCkLa8wabjaJTLcmVWPy5Wdd2Ke6lK7Dgz_iTRXyrtyw>
    <xme:YnC9Z7-o24c8cmpv9z2zXbEtBtMS6U1bIeklSCOAeb2rH1Aw6X5r2okyM9s4a7b1D
    i42G82D6MsV7ZDpwpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghonhhorh
    doughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghirdhl
    ihhusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:YnC9Z4TLllvXzTwlowYa5Jl6FRZHwh6ru6z9sep9rQhEYu4E3BZ9YQ>
    <xmx:YnC9Z1uroNTLiTE5A1YAFBUh0k6-cPSW_lmVz7j_174A7gOMX1F-pA>
    <xmx:YnC9Zxd8hAA5ROl-8MVUO9kMTxx065-aCcG2Kcv_6QaygErRfoifPA>
    <xmx:YnC9Zx0cABgPWS_vwgD1TtiRl_Bgj3jIOVHMSFv_zLyLLtjt_krAXw>
    <xmx:Y3C9Z3G9Q7Jowr_Z_hgrXH8Sz7iSue9CIWALq-YXJHQQDGYgj76VkLzo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16C1B2220072; Tue, 25 Feb 2025 02:25:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 08:24:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
 bhelgaas@google.com, "Borislav Petkov" <bp@alien8.de>,
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
Message-Id: <55b65ba6-4abe-478c-a173-4622c30ddd7b@app.fastmail.com>
In-Reply-To: <14a199d8-1cf3-49bc-8e0d-92d9c8407b4f@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
 <1b14e3de-4d3e-420c-819c-31ffb2d448bd@app.fastmail.com>
 <593c22ca-6544-423d-84ee-7a06c6b8b5b9@linux.microsoft.com>
 <97887849-faa8-429b-862b-daf6faf89481@app.fastmail.com>
 <6e4685fe-68e9-43bd-96c5-b871edb1b971@linux.microsoft.com>
 <14a199d8-1cf3-49bc-8e0d-92d9c8407b4f@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect hypervisor
 presence
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025, at 00:22, Roman Kisel wrote:
> Hi Arnd,
>
> [...]
>
>>> I would suggest moving the UUID values into a variable next
>>> to the caller like
>>>
>>> #define ARM_SMCCC_VENDOR_HYP_UID_KVM \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 UUID_INIT(0x28b46fb6, 0x2ec5, 0x11e9, 0xa9,=
 0xca, 0x4b, 0x56,=20
>>> 0x4d, 0x00, 0x3a, 0x74)
>>>
>>> and then just pass that into arm_smccc_hyp_present(). (please
>>> double-check the endianess of the definition here, I probably
>>> got it wrong myself).
>
> I worked out a variation [1] of the change that you said looked good.
>
> Here, there is a helper macro for creating uuid_t's when checking
> for the hypervisor running via SMCCC to avoid using the bare UUID_INIT=
.=20
> Valiadted with KVM/arm64 and Hyper-V/arm64. Do you think this is a
> better approach than converting by hand?
>
> If that looks too heavy, maybe could leave out converting the expected
> register values to UUID, and pass the expected register values to
> arm_smccc_hyp_present directly. That way, instead of
>
> bool arm_smccc_hyp_present(const uuid_t *hyp_uuid);
>
> we'd have
>
> bool arm_smccc_hyp_present(u32 reg0, u32 reg1, u32 reg2, u32 reg2);
>
>
> Please let me know what you think!

The patch looks correct to me, but I agree it's a little silly
to convert register values into uuid format on both sides.

>   static bool hyperv_detect_via_smccc(void)
>   {
> -	struct arm_smccc_res res =3D {};
> +	uuid_t hyperv_uuid =3D HYP_UUID_INIT(ARM_SMCCC_VENDOR_HYP_UID_HYPERV=
_REG_0,
> +		ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1,
> +		ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2,
> +		ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3);

If you want to declare a uuid here, I think you should remove the
ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_{0,1,2,3} macros and just
have UUID in normal UUID_INIT() notation as we do for
other UUIDs.

If you want to keep the four 32-bit values and pass them into
arm_smccc_hyp_present() directly, I think that is also fine,
but in that case, I would try to avoid calling it a UUID.

How are the kvm and hyperv values specified originally?
From the SMCCC document it seems like they are meant to be
UUIDs, so I would expect them to be in canonical form rather
than the smccc return values, but I could not find a document
for them.

     Arnd

