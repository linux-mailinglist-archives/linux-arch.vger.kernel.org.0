Return-Path: <linux-arch+bounces-8339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DC9A6683
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122CC1F22D1C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10C1E5731;
	Mon, 21 Oct 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ulqzTF6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxpTRpOJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60D1E3DD8;
	Mon, 21 Oct 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509685; cv=none; b=Whf2MuuPQXxhN/Xb3O6KnmBj4yDmMKiqoferT1dhWZszytnZFM0crv6ZoinZxswJ4D0Q7FREkvHE6qcJihB+YjSg9eAI48jSbbbbVNO7ZPjysUaG27nBmIJ/0vVvMLHY/ylYCsKp1znhA+WVFEyxa7DRwI8w0I1+g49pw5Vd5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509685; c=relaxed/simple;
	bh=mHxtqJKALMM2JzQ4QjvJxiwzCfXdEBolIhZyDxg/CEU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UEVZrAsozR9YFiA+NbmP9YT+mhCzPBc+KzMdzvBcSfUeCjlDCIdEDzaZhjLlKH/L7iO0S2gjV041M2h8WRVLhZv3IBw0Gzj61OLpFnX1IAUDJNnGE4u3kANfmi+yzPXC5hhleQPNo7blxlDclJtFcowwP/+ySXfK3iAXcT07gmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ulqzTF6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxpTRpOJ; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 1134D200206;
	Mon, 21 Oct 2024 07:21:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 07:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729509682;
	 x=1729516882; bh=fvD3ctpqrCWAfhRvwnz/vMYY3oWGeyeXaHqmlBQJW9U=; b=
	ulqzTF6dqm9TDZQpemlAVPsLUXyYkvNAzrfcULOOPesTtIz+Z4Ai0z12HABf1ctb
	23jnEQISppKaZtN6R9jusvv7XqVCi0GMq66sPA8O1L7cdwWtoeVCMtKVTY2w3haz
	rR27LXnZBNV800rflp1teAMig+lDUvZYxCWza+PX2DR439QxbF0PkDODEoGNUrfW
	uGbdoE84+5R3BJtwqf3G5Velav1VcdQq1cU6M6bhPD4PYg0M+daEBboU4PXXFuFP
	6Yl3lx39pHOGWiPPfJt+bY029hBO3KTVN6+6fzhbPZfDaS3w3qYPY+gJMUHqeNuK
	jUSdbxK0JB8OePnbvxPktA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729509682; x=
	1729516882; bh=fvD3ctpqrCWAfhRvwnz/vMYY3oWGeyeXaHqmlBQJW9U=; b=J
	xpTRpOJ4uJFwt33ULhA4kXA4a69HtyOOzm7oX2UNenK3N/lPf3Zz1ZBrrZnSJNYZ
	wQAzuMzfS4Ki7UDhYhHkMeh/yNkBJufymBB/OQTgsngdWT9YJl7jWeFKgOK5Y88Y
	spFb7baVoJP9/V7CXc0MIMDhLF13YbMlhL3dYiqR6EfIMoWXO1tdm8GFNOyH5WKM
	vJPia/cKnpVJ3vVqUzwCxhP3JUsM9zzdcgzWBH879ZQBBxJf+/Zf5BLdrJyDeDpm
	bjQoUwGM+18gRD90QgYWxo0Hx2AiPhq0U+bV5AfGcFGBppQPrm5TCZ+HKwBRszPT
	Z42mn8unbo1AXgbzzs5cQ==
X-ME-Sender: <xms:MTkWZ22VTNkVIywiKLmtz380cPoWc7iOcVWQx0cbwZL_zea-JlVLLw>
    <xme:MTkWZ5GpTeL7YzfMr3FRdWC5EOA-Ex1W4Xq2UVEGQF2VCJyx3kpnP8L8tMW9sVCAS
    puxE_DA0EG9LBRlhZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtg
    hhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehl
    uhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehprghtrhhikhdrrh
    drjhgrkhhosghsshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlhes
    hhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhutggrshdruggvmhgrrhgthhhise
    hinhhtvghlrdgtohhmpdhrtghpthhtoheprhhoughrihhgohdrvhhivhhisehinhhtvghl
    rdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MTkWZ-7QdSiiIGy0vrhYQCsmMwygcvB-Q-0Wm6NmjI3Y8Q1M0bbqnw>
    <xmx:MTkWZ301K1iwMIhsTcnFUngtniJVM2fWmbJjNAvDI5KAN7BEu1xNvw>
    <xmx:MTkWZ5HY801U3mzpDI6Nkai1KBdpOODBwoYuAdLiNoXCOdAjHV96fA>
    <xmx:MTkWZw8Y-CkdqEhfxR3RiTbMpKUABg-0CW3NZxU18UUaJHLwCQjamQ>
    <xmx:MjkWZ-s9DCM7I8in58DNLWEmCFENsnEANFLsBcYnqsHEooUFVPU72N_x>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 268142220071; Mon, 21 Oct 2024 07:21:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 11:21:00 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Brian Cain" <bcain@quicinc.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Patrik Jakobsson" <patrik.r.jakobsson@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Dave Airlie" <airlied@redhat.com>,
 "Gerd Hoffmann" <kraxel@redhat.com>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <c7592bd4-a9f9-43b0-a243-0fb2ef6bb83d@app.fastmail.com>
In-Reply-To: <aa679655-290e-4d19-9195-1a581431b9e6@suse.de>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
 <20241008-b4-has_ioport-v8-3-793e68aeadda@linux.ibm.com>
 <64cc9c8f-fff3-4845-bb32-d7f1046ef619@suse.de>
 <a25086c4-e2fc-4ffc-bc20-afa50e560d96@app.fastmail.com>
 <aa679655-290e-4d19-9195-1a581431b9e6@suse.de>
Subject: Re: [PATCH v8 3/5] drm: handle HAS_IOPORT dependencies
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 10:58, Thomas Zimmermann wrote:
> Am 21.10.24 um 12:08 schrieb Arnd Bergmann:
>> On Mon, Oct 21, 2024, at 07:52, Thomas Zimmermann wrote:
>> --- a/drivers/gpu/drm/tiny/bochs.c
>> +++ b/drivers/gpu/drm/tiny/bochs.c
>> @@ -112,14 +112,12 @@ static void bochs_vga_writeb(struct bochs_devic=
e *bochs, u16 ioport, u8 val)
>>   	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
>>   		return;
>>  =20
>> -	if (bochs->mmio) {
>> +	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {

I meant IS_ENABLED() of course.

> For all functions with such a pattern, could we use:
>
> bool bochs_uses_mmio(bochs)
> {
>  =C2=A0=C2=A0=C2=A0 return !IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mm=
io
> }
>
> void writeb_func()
> {
>  =C2=A0=C2=A0=C2=A0 if (bochs_uses_mmio()) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writeb()
> #if CONFIG_HAS_IOPORT
>  =C2=A0=C2=A0=C2=A0 } else {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outb()
> #endif
>  =C2=A0=C2=A0=C2=A0 }

Yes, that helper function look fine, but it should then
be either __always_inline or a macro. With that, the
#ifdef is not needed since gcc only warns if there is
a path that leads to outb() actually getting called.

      Arnd

