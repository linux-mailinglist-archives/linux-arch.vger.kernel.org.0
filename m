Return-Path: <linux-arch+bounces-14875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF7C69A9C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D719F349E73
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF2301499;
	Tue, 18 Nov 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y7HDAFYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YK6/gjm5"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCE1E1E12;
	Tue, 18 Nov 2025 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473562; cv=none; b=SDZO41oLfS8l6WpooRWvRoosfHIQ3oEDaO436XsxckEBT90YMmxH5M7CCSZVYUEFBVQzRF6GcDAbP99I+WBvYCuu9LjRl0AvXXzt2tjJxbrU24q5HOvYf7ab+saug5JfDxjsGmOpmoHClP33TeWK8l0qw2NYgAkRLZEKPIkaWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473562; c=relaxed/simple;
	bh=DhlZDLY5atSDdN06eIWeprLsxmU+qUTu5+HY2ecDX7U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mXLMnUy0INWB09uMCWyl5+iV7vAwr0QFZY4NhV7rA9E51QXDZk3LLiMgw9kKorX2f/RGTjxlQB5QsJwO9Fu27zRo9n9DFBCKLsp+wueni/1sDHpajRxcgekYCMzEQdNBYAO2QwAOgjl13aaBYckIFp0yn/WHICcIAtdwhYym6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y7HDAFYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YK6/gjm5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C43E8140032C;
	Tue, 18 Nov 2025 08:45:59 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 08:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763473559;
	 x=1763559959; bh=MouoHeHyqkziUgs7lUWEFSEV/beZK5e/u7TgNwuhxsA=; b=
	Y7HDAFYIc2wSK66hV9DugS7X4wZHFyUs1FFtaq0oVsnTQzG3TAlwNpgQdVIccO4Y
	RRE/2uGir5QB9i6lnn+Aw6GgjDLJ2gXGMCTEwbM5+9R8nwZ5sXRvAI2xCmr9jYrU
	WhgET48Erg9uvc/kkFWbYJaORmONOCiIkKb5Ml5Tr6/6Zt1bmgblPc86kP8x4R2+
	wz378muzACWLo+VO8v9KPKozKKteFFpD+TGArSBQPmHR1oehCxTtk1r9wOwqnHgx
	6C/GEtw+MhnM43FhAMqww8qd4Xznt0iIuLt3HUuqu2g6vcftdd+67ui6Tb16bGXa
	ypRxkkv0RHWZne0xdExk6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763473559; x=
	1763559959; bh=MouoHeHyqkziUgs7lUWEFSEV/beZK5e/u7TgNwuhxsA=; b=Y
	K6/gjm5CzRT+rVCBMHRPFe06YNRou5eE3+uoQv6H//WgyLaCS8OOYXVmZYlKvZqi
	oyEawovw9i5DhKBUrw8kD5WaY/UqrN4Ei5I1uF+fFFCKPYkX7qiQgox6et5Xb/to
	bGMIv74skFj2A8gXuoEUpYehZIyuUV1Z4cgYletDTwfgga29DG44i57Ob+7JqiIS
	SyyAv3LVwW8f5E2dDyeKWGH2vP8ngv3gR7/b+st1MLLo6fIUjVIEjN2cJP/i3BlT
	nC+MwOuNlnY+z9phzliorNK80gNsUo6yN9rOqDWJO1pa9FSKVS5y/L1lyasJKxgp
	/s9ZZPBlRCW1LxUxLA9oQ==
X-ME-Sender: <xms:l3gcaWkiUOdzNgxSBST6eDvn278yi3JjXXfv-wK-UR_jOIOOJTsO-g>
    <xme:l3gcaYrQYx7FI4Dm8nHPfqKHjc7_KYEqB8UB59RBP9nnZKsnfYWWK4nM1prFTT5XH
    IP46S1ZCPy3UzVCnqot934hUWHpRXWPMJQPCOiXR2_3Wozl_5ONTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtph
    htthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhu
    ohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhvghnhhhurggtrghisehlohho
    nhhgshhonhdrtghnpdhrtghpthhtoheplhhigihuvghfvghngheslhhoohhnghhsohhnrd
    gtnhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:l3gcaXmYnu_xxRgcrq_9i6Wx-sbeMHQxWc0SU0TqmzOoPEQF-8bbig>
    <xmx:l3gcaXaI23jC4fGqb_-TzDNhR3WyuJX4wAnWJJbk-PnuEoqOrY7faQ>
    <xmx:l3gcaSFXgUZ0EcQO89ZXKhSN_W3eauUGHFaRl58ulgxzT9H4Ceqb8g>
    <xmx:l3gcaWbAOlonYG-h75cYvwvcIbx2OsPy56WWhC-Y3q22T-_0KsloQw>
    <xmx:l3gcaYEXdXYooXeIm0v9W0Gok9b_0we4TJUJtpBw-poREL_6HLlwq8W8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A637700054; Tue, 18 Nov 2025 08:45:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYdjRdHGnams
Date: Tue, 18 Nov 2025 14:45:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org
Message-Id: <debb8b35-8253-4422-a197-6d92e8d0c701@app.fastmail.com>
In-Reply-To: <20251118112728.571869-14-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn>
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> loongson64_defconfig (for 64BIT).
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++++++
>  ...ongson3_defconfig => loongson64_defconfig} |    0

I would suggest using .config fragment here and only listing
the differences in the defconfig files in there, rather than
duplicating everything.

> +CONFIG_DMI=y
> +CONFIG_EFI=y
> +CONFIG_SUSPEND=y
> +CONFIG_HIBERNATION=y
> +CONFIG_ACPI=y
> +CONFIG_ACPI_SPCR_TABLE=y
> +CONFIG_ACPI_TAD=y
> +CONFIG_ACPI_DOCK=y
> +CONFIG_ACPI_IPMI=m
> +CONFIG_ACPI_HOTPLUG_CPU=y
> +CONFIG_ACPI_PCI_SLOT=y
> +CONFIG_ACPI_HOTPLUG_MEMORY=y
> +CONFIG_ACPI_BGRT=y

You mention that loongarch32 uses ftb based boot,
so ACPI should probably be disabled here.

> +CONFIG_DRM=y
> +CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> +CONFIG_DRM_RADEON=m
> +CONFIG_DRM_RADEON_USERPTR=y
> +CONFIG_DRM_AMDGPU=m
> +CONFIG_DRM_AMDGPU_SI=y
> +CONFIG_DRM_AMDGPU_CIK=y
> +CONFIG_DRM_AMDGPU_USERPTR=y
> +CONFIG_DRM_AST=y
> +CONFIG_DRM_QXL=m
> +CONFIG_DRM_VIRTIO_GPU=m
> +CONFIG_DRM_LOONGSON=y
> +CONFIG_DRM_SIMPLEDRM=y
> +CONFIG_FB=y
> +CONFIG_FB_EFI=y
> +CONFIG_FB_RADEON=y
> +CONFIG_FIRMWARE_EDID=y

Is AMDGPU actually working? This driver is rather tricky to get
reliable on new architectures.

I would suggest turning off CONFIG_FB here (also on loongarch64).
There is a replacement driver for FB_EFI in DRM now.

       Arnd

