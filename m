Return-Path: <linux-arch+bounces-13651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656CB58E23
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 07:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07C1487DD7
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E31B2C15BC;
	Tue, 16 Sep 2025 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unitedcomputing.tech header.i=@unitedcomputing.tech header.b="f3SGBDlR"
X-Original-To: linux-arch@vger.kernel.org
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D5AD2C;
	Tue, 16 Sep 2025 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002065; cv=pass; b=ROa0bWIEmkEhTtJyfA3W5KUa3P4kk5tO9GgxZcaE5DJCt0M98seqjQaA0CUIbm1vRvejlwexZ7khF6cdABBbRu+rMJe7a133S4SktEM9xp1kYF9AvYSgqBfsK5Xy0aD5KyEOSsmOEtGUW/psfRX/cU9C8Sc/iizr2IJPe0ycnUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002065; c=relaxed/simple;
	bh=S+/mHISu1pOWcV1Pv7DxDjhsyVy84JWKgHUZUbawgzQ=;
	h=MIME-Version:From:To:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Date; b=N1XH3FRZ9jYZa97AXxIJ3d92ft5Xm9gQAt/MSrm2bFk4epgv4ioUMwNhFmxuNLpqj0TG4t4ENV/5ivcejz8CIrH4REzd+MnL8f7o35/dOw8yjO3/R5lEdU/0xi3frXF5Alcp23l588o2DlbkC6VMp5wUImhFofttP5Q3R3v9ZcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unitedcomputing.tech; spf=pass smtp.mailfrom=unitedcomputing.tech; dkim=pass (2048-bit key) header.d=unitedcomputing.tech header.i=@unitedcomputing.tech header.b=f3SGBDlR; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unitedcomputing.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unitedcomputing.tech
X-Sender-Id: hostingeremailsmtpin|x-authuser|info@unitedcomputing.tech
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CF2ED1012E4;
	Tue, 16 Sep 2025 05:15:27 +0000 (UTC)
Received: from fr-int-smtpout30.hostinger.io (100-109-34-141.trex-nlb.outbound.svc.cluster.local [100.109.34.141])
	(Authenticated sender: hostingeremailsmtpin)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6A52210085C;
	Tue, 16 Sep 2025 05:15:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757999726; a=rsa-sha256;
	cv=none;
	b=Vb3TdYsjN58/jA+dWkkXJomBUI/6tfbT8hfG+diEFIjPMyyTGbN7Qno4DW6rawBmrStDNH
	0t6FU/B5058jaAnVHrhJK4GVH0sim8G7pXXZUy4VpL0sajlV2+JwNFI9v49nLq5tW2U/oY
	IYh5wyLXcX6ycI4q+2TgsV+6GGpu5mTM7CyRxKSgKUlmKFUGYjK7jal8PfLwxd1lQRTgYN
	iYeKTYAx2uUq54e+RXGOO0VUULaC6OgFjjaqYkYqFh5/6ElIVaf9uYu2/vjxKKFhE/Zd9x
	SnxcYHQh4GOqjplx+GSKCg/A9jMZuc21vM5l2vlEeywy7/NNxZYTYePyGPXpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757999726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qvD9wXA63pKiMKoJOAFFKMbijhWcrK9PmVFaGylHtEs=;
	b=NzLlV4PbAInWrotNCLqWnYn6y68MtdmiWjhHcpTj3Rzok53DEvVOcM5pnkQd05GrFsW/GF
	a2dDxYdyrmCHhFZ2J9vS0Chx6RPNMbfWRg4qE2cseaQlGcLhAEkdtOhM5Ypp6lChsWNhgk
	bHyGJMG2xycofLBu9uvEjH1w61spdiSuGo+UuedKuVZ3NlgGz+aCaoq7fpYj+p4BBTCwyN
	Er4o6VHl93hYh4iyqklrdAyOa8KSHBjmYZuOtwzB3L3kcpkHdHjaCSc+TiBLFKIe/+XdyH
	pX8fhXMzdKsjEDOIm3qjmGIHX3WzowtayF0FKejWt8wMwuXrZwyEYcsAOjT9jw==
ARC-Authentication-Results: i=1;
	rspamd-76d5d85dd7-gchpr;
	auth=pass smtp.auth=hostingeremailsmtpin
 smtp.mailfrom=info@unitedcomputing.tech
X-Sender-Id: hostingeremailsmtpin|x-authuser|info@unitedcomputing.tech
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremailsmtpin|x-authuser|info@unitedcomputing.tech
X-MailChannels-Auth-Id: hostingeremailsmtpin
X-White-Society: 7f9b92df2b11f86c_1757999726424_3000046865
X-MC-Loop-Signature: 1757999726424:2956769062
X-MC-Ingress-Time: 1757999726424
Received: from fr-int-smtpout30.hostinger.io ([UNAVAILABLE]. [148.222.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.34.141 (trex/7.1.3);
	Tue, 16 Sep 2025 05:15:26 +0000
Received: from mail.hostinger.com (17.131.242.35.bc.googleusercontent.com [12.238.52.246])
	(Authenticated sender: info@unitedcomputing.tech)
	by smtp.hostinger.com (smtp.hostinger.com) with SMTP id 4cQqpz4c6Nz2xB3;
	Tue, 16 Sep 2025 05:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unitedcomputing.tech;
	s=hostingermail-a; t=1757999723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvD9wXA63pKiMKoJOAFFKMbijhWcrK9PmVFaGylHtEs=;
	b=f3SGBDlRJbNumaCLlwGvS2cX46JzBkF8ztuGa6MHLLXF30NRVTzmoP6Sh77D00la+NQ1Es
	ZRQD36dhLqHkmlUbVJL9yJlnecWnrX2SwHNb1z2yYAcl1jkiv3fBoAe8Ma6XHV8LkRshun
	MoKlIGwoSISuNxBFJCHDDFzoRbqC9HOCPI7RtUV/QyFmmzPorxU2gcofrDZioCNHSE/uPm
	aCH6K7NhMkiWprIt7Ggk8mzEWOaVxjYlY7SyS3QZb8L7+ROPbN67qZmCpDieKVyWtcOli1
	r7SMSYPBbwwhur/+DYPsE3jhuHBvOko1huRVAprUSqUeEgme2RMdhP8m33EaEQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: info@unitedcomputing.tech
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org
Subject: Hiring Linux Gurus for Next Microsoft/Apple Now!
In-Reply-To: <ec28ecc24919963b2e5f9edd77e55262@unitedcomputing.tech>
References: <ec28ecc24919963b2e5f9edd77e55262@unitedcomputing.tech>
Message-ID: <bccc84833ac7eb06243a0e388603ceeb@unitedcomputing.tech>
X-Sender: info@unitedcomputing.tech
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2025 05:15:23 +0000 (UTC)
X-CM-Envelope: MS4xfOHgPdWcvJ1xWUS6IZyKZ6Thk7l+4+QpzcELymOEN1D4GEqkYrXcb0Pz7EkAgnQBi+adizfObtFZZxix/yKfl516qdxjYDh9B02cmKIbmFVAkEvhjvDU 2jOEwB0kXM3qaV+hxUuzjz68MO0Q61RjdjEH83DSZsJX1eR6xDQD9nz6rvhEcYIkQQJNBCfHB1yU21/Bm5v/gIS2x7FKKB9jrePb5jqIQPyxQFzgNbtW1Fma uaLzb8Bq6GbxQ/R4GAxxp9QF5kKqt2qcqw7XjhNJsBXIkPJw/USF4PoRXWApViZcDoCXADfyG0uRlUO+YYh3GBhoSh3GNg45kXPC0iYmAU0=
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=68c8f26b a=5DGB/U2t+3lQspTewFC4tA==:117 a=5DGB/U2t+3lQspTewFC4tA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=u2SczSXuAAAA:8 a=3j4BkbkPAAAA:8 a=B4Kxj6afAAAA:8 a=l8dv_oVvmM6u8NXH5EsA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10 a=LSWMWZc9k2mpw2hSllJK:22 a=Od7JGMy6ZR1BIU0N1PMV:22 a=_lWAYq_yoc5DiIG9FTxF:22
X-AuthUser: info@unitedcomputing.tech

Dear Linux experts/developers,

We are AGGRESSIVELY HIRING a team of Linux gurus for our business United 
Computing Inc., most promising like next Microsoft/Apple, to own and 
build our Linux platforms like ZorinOS & Ubuntu and dominate 
mobile/desktop/embedded/workstation/server/cloud or all computing 
domains with Linux existing domination over all domains except for 
shrinking Windows desktop computing, and our LinuxAll innovations for 
work & play in any pose/time/place and replacing today's 
phones/tablets/PCs/gaming/AR/VR devices. LinuxAll includes XR glasses 
for multiple virtual screens/windows, physical or virtual 
keyboards/multi-touch/3D inputs, Linux gaming computer tablet phones, 
and optional power banks, etc. These addictive products will hit the 
market like iPhone 1+ for sure. We own this top tech innovation since 
mid 2008 out of our AR/VR research and the disrupted PC industry by the 
release of iPhone with small screen and limited OS/inputs. Tech giants 
built their XR products but all failed, and can't steal them from us due 
to cross competitions, let alone others. LinuxAll Gen 1/2 products, 
especially many Birdbath and Waveguide AR glasses, are on sale at 
https://www.unitedcomputing.org/shop.

Below is a list of our LinuxAll components and products:
1) Birdbath XR Glasses: Legion Glasses 2, Rayneo Air 3s Pro, Viture Luma 
XR, Xreal One Pro/Air 2 Ultra/Pro, Rokid AR Lite, StarV View, InAir 2 
Pro
2) Waveguide XR Glasses: Inmo Air 3, Rayneo X3 Pro, Oppo Air Glass 3, 
Rokid Glasses, Orion AR, Myvu Discovery, Lumus Optical, Cellid, PVG, 
JioGlass, Mirza AR, StarV Air2
3) Mini Gaming PCs: Legion Go, Ling Long Foldable Keyboard PC, Khadas 
Mind 2, Rog Ally, Steam Deck, OneXPlayer 2 Pro, GPD WIN4, Ayaneo, Mini 
PCs, etc.
4) Computer Phones: 5.5'/6'/6.5'/7'/8' rugged gaming phone tablet PCs 
from Sincoole, rugged-pda, njynwei, and MactronGroup
5) Physical/virtual Inputs: Foldable/mini/projection keyboards, TapXR 
wearable keyboard, and Leap Motion or XR cameras based virtual inputs
6) Laptop Power Banks: Psooo 65w 5/80k power bank, Zkpilse 65w 50k power 
bank, offgrid power products, etc.

It's critical and necessary for our business to own and build our OS 
platforms, otherwise there will be endless US/world crisis and huge 
fights over this matter that must be settled ASAP. As the WinAll deal 
with Microsoft and $1 billion for ZorinOS & Ubuntu acquisition aren't 
there, we are contacting Linux developer communities to own and build 
our Linux platforms together instead. Our Linux developers will match 
employees building Ubuntu & ZorinOS with various job functions. They 
will add the HCI and system components/features for 
phone/tablet/PC/gaming/AR/VR convergence, new XR/AI features matching 
new hardware/devices, and our Linux platforms to dominate all computing 
domains. They will build core apps, tools, frameworks, etc. for our 
Linux platforms too. OS businesses are quite mature and crowded so we 
shall be able to absorb abundant Linux resources soon. By leveraging 
abundant PC/mobile hardware/chip vendor resources, we don't need to 
invest a lot in our Linux & LinuxAll ownership and development as well.

Interested candidates please email us their resumes and roles at 
info@unitedcomputing.tech ASAP or contact us for any question. This is 
really a great opportunity for Linux to defeat Windows/MacOS/Android/iOS 
and dominate/shine for ever. The sooner you join us, the sooner we go 
big together!

More information:
https://www.facebook.com/marketplace/profile/100095444238325/
https://www.unitedcomputing.org/linuxall > UCPitchDeck.pdf
https://b23.tv/9h73RDV

Thanks & Regards,
Shirley Zhou
Founder & CEO
United Computing Inc.
https://www.unitedcomputing.org
Phone/WhatsApp: +1 9096309408
Email: info@unitedcomputing.tech
Address: 6203 San Ignacio Ave Ste 110, San Jose, CA, USA, 95119

