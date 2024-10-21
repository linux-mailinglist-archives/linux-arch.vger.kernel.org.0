Return-Path: <linux-arch+bounces-8334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7449A61EC
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13189B281A2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E661E3DD8;
	Mon, 21 Oct 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ne/IPE08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+yT9YJV"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36171974F4;
	Mon, 21 Oct 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505324; cv=none; b=j2lKbzfhBazpnPxoJgrUIq/b3CzRVm1J1QrVg4fm7eNuTs5XN2K+jrb3NPnOA2TlMQfTAzyGlLP8TeOAJT9g+yWi+9xsFtZpOGTU8pLS9gws3/lxtHpEE1R7QtBGJYYDFrjGGPRqs94oUafOLpsL5F8vb0olf6Ylco73RHRmxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505324; c=relaxed/simple;
	bh=Wmxsy2S2l7rPsX04lUxjnO6Uob6a4ayEHcsoLJ8T0TA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M61bpl9XXg90T+wdGPK0xMTYsQkG+9UMjq7XiVJzdksapHgQsJsOpV4LLZerR43NwXWvzSwjPH+EcUd770KlKhUkZYhw8PauumVPAjaFyfpSHphNDs9K08Diw4j+2ZjFVrNkCWfQI9CEBKtemhmjeAyc3GqsQt92rjxRdL6/A6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ne/IPE08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+yT9YJV; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id BAD6B2001BC;
	Mon, 21 Oct 2024 06:08:41 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 06:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729505321;
	 x=1729512521; bh=ghSlNe0tmFIbW8pbUYudW/CbWTjZ+S6+ujlr6qqnF/E=; b=
	ne/IPE08UonRdshCEbTY4eWggIuJdw7ggRLwVWX6T78qDjRqTQRxe8A6YsUhbWkX
	fIjZUVpDjQEEtkjJlKtRrQ4SzcACH9iXutk4zanQBogR4otxUePp6c6f1IjcMh20
	EHYmUpptTI/quDvu8UjQi8cNIZ1tO11br17DIeQbvohy5u+KEpGpa69ULQPI/WMV
	Ci8IqRqEH5xOzjI16MWAtEJ56raEr0Wi5FT44Hr8BoB4dzFA7DgYJhnIpFXC9r6P
	+yH6cvNHjo3+zsJmhNTDhNzqy9nmPdQ0cC2UY1Be+GpI1+K6KfZQC4IdLuzXGg3s
	lpgYr94GWBUllJMI63hVxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729505321; x=
	1729512521; bh=ghSlNe0tmFIbW8pbUYudW/CbWTjZ+S6+ujlr6qqnF/E=; b=c
	+yT9YJVNdsrrwGaHaBDLiJ9XZ4izTUNteC1asRAHk8AdWfX3WorexOGb71M8j4uC
	zORjv/TdqGZDpylQB0WryzahKC4T3PQnVwuG1fgtzPPCVzBEpdXnGLxATCsmIig/
	H96DDBEWYMOty9sHtCLaZ93EKfqIQ9GQUldQShv6EqsRiJ2YyaiOSfUhYdT4UfU7
	MEZh6q1r48ORtasV2o1IOR+T/D2+qmbYUNoOyJCD12cuIgp1CNyi58VEbLkN3AqD
	3i05ArUpxC7CCQcPNoNHHDKliwuCUHAyCxhbku0HVNvpSCwTHglC6p6cDZaamA4N
	UtpN4HsdEnl6gCT6kEuwQ==
X-ME-Sender: <xms:KSgWZ6S6R2n1f2T0QCQexTgiV-KSMlaMM2gkoOq12JijmTNZ1Da6pA>
    <xme:KSgWZ_zrX9SKSefI_hsukUWNkowAAXFNzJVOU5WQN8cskfd-UktwCKcRh5niCSPF9
    B-wUzhhhk-7zGgwpLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtg
    hhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehl
    uhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehprghtrhhikhdrrh
    drjhgrkhhosghsshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlhes
    hhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhutggrshdruggvmhgrrhgthhhise
    hinhhtvghlrdgtohhmpdhrtghpthhtoheprhhoughrihhgohdrvhhivhhisehinhhtvghl
    rdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KSgWZ306jKZbZyxIuNn24nj8C_gZvqx8j2vZtEOD83IWkVo0nTYHqw>
    <xmx:KSgWZ2ChYHyNQtPFROKXIN2jjht4D_m7Shh_6ifCQapVKZZio003WA>
    <xmx:KSgWZzi65AZ8OiKDEBbUvjM6UWP-jI8InMkFEuc1FbIPK1bIuuD40g>
    <xmx:KSgWZyo2OCvdSDoNogZ2pNuyd_R1Z-2mydlod75TWuAx6fAolN5qiA>
    <xmx:KSgWZ05XjI0ejUOeJbkMdLt1Sg5fEKNECBVD0njAWDAczeUufW1V0bbf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 003F42220071; Mon, 21 Oct 2024 06:08:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 10:08:19 +0000
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
Message-Id: <a25086c4-e2fc-4ffc-bc20-afa50e560d96@app.fastmail.com>
In-Reply-To: <64cc9c8f-fff3-4845-bb32-d7f1046ef619@suse.de>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
 <20241008-b4-has_ioport-v8-3-793e68aeadda@linux.ibm.com>
 <64cc9c8f-fff3-4845-bb32-d7f1046ef619@suse.de>
Subject: Re: [PATCH v8 3/5] drm: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 21, 2024, at 07:52, Thomas Zimmermann wrote:
> Am 08.10.24 um 14:39 schrieb Niklas Schnelle:
d 100644
>> --- a/drivers/gpu/drm/qxl/Kconfig
>> +++ b/drivers/gpu/drm/qxl/Kconfig
>> @@ -2,6 +2,7 @@
>>   config DRM_QXL
>>   	tristate "QXL virtual GPU"
>>   	depends on DRM && PCI && MMU
>> +	depends on HAS_IOPORT
>
> Is there a difference between this style (multiple 'depends on') and the 
> one used for gma500 (&& && &&)?

No, it's the same. Doing it in one line is mainly useful
if you have some '||' as well.

>> @@ -105,7 +106,9 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
>>   
>>   		writeb(val, bochs->mmio + offset);
>>   	} else {
>> +#ifdef CONFIG_HAS_IOPORT
>>   		outb(val, ioport);
>> +#endif
>
> Could you provide empty defines for the out() interfaces at the top of 
> the file?

That no longer works since there are now __compiletime_error()
versions of these funcitons. However we can do it more nicely like:

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 9b337f948434..034af6e32200 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -112,14 +112,12 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
 	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
 		return;
 
-	if (bochs->mmio) {
+	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
 		int offset = ioport - 0x3c0 + 0x400;
 
 		writeb(val, bochs->mmio + offset);
 	} else {
-#ifdef CONFIG_HAS_IOPORT
 		outb(val, ioport);
-#endif
 	}
 }
 
@@ -128,16 +126,12 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
 	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
 		return 0xff;
 
-	if (bochs->mmio) {
+	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
 		int offset = ioport - 0x3c0 + 0x400;
 
 		return readb(bochs->mmio + offset);
 	} else {
-#ifdef CONFIG_HAS_IOPORT
 		return inb(ioport);
-#else
-		return 0xff;
-#endif
 	}
 }
 
@@ -145,32 +139,26 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
 {
 	u16 ret = 0;
 
-	if (bochs->mmio) {
+	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
 		int offset = 0x500 + (reg << 1);
 
 		ret = readw(bochs->mmio + offset);
 	} else {
-#ifdef CONFIG_HAS_IOPORT
 		outw(reg, VBE_DISPI_IOPORT_INDEX);
 		ret = inw(VBE_DISPI_IOPORT_DATA);
-#else
-		ret = 0xffff;
-#endif
 	}
 	return ret;
 }
 
 static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 {
-	if (bochs->mmio) {
+	if (!IS_DEFINED(CONFIG_HAS_IOPORT) || bochs->mmio) {
 		int offset = 0x500 + (reg << 1);
 
 		writew(val, bochs->mmio + offset);
 	} else {
-#ifdef CONFIG_HAS_IOPORT
 		outw(reg, VBE_DISPI_IOPORT_INDEX);
 		outw(val, VBE_DISPI_IOPORT_DATA);
-#endif
 	}
 }
 
> And the in() interfaces could be defined to 0xff[ff].
>
> I assume that you don't want to provide such empty macros in the 
> kernel's io.h header?

That was the original idea many years ago, but Linus rejected
my pull request for it, so Niklas worked through all drivers
individually to add the dependencies instead.

     Arnd

