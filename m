Return-Path: <linux-arch+bounces-7765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8F992FB4
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8671C22C66
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC901D6DB8;
	Mon,  7 Oct 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oXxJmJiR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G97OKwST"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5E5338D;
	Mon,  7 Oct 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312304; cv=none; b=QFnMOPsN1KbBh5k6BBI1VUDPLK+n+ps1q5UEIlcrhdLwWa4C58VV4TR+jmZd/CEiZ8rQ46bDKPdnzSAYbC1Lvd5oRUKhequV89q2I3jkUpaS5EMWJAnTak2a+frbLIW+/AwbyZYz4AiMFMWI3X94jAOpv/vGSqv/ktOu2uBhtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312304; c=relaxed/simple;
	bh=lbnJukntG02dcf7EuR6nWqoAY3hzdHD1hrinEGTqGLY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TKSn9c4qxYgLpJSlyjaRdJRZ6tKAWymOQBC1eCJ98jp1phy2QuAyMqjr138tsTYzy6x3PlmT0n5wpxkbse7R00uFiQwyEbaoSiYpPLOrfAIGYFxIvw9FlCSeyRAMRzwyVPVEHYjChFfRpR09/w1CMqs/S5ANXSvXn5pfgGEShX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oXxJmJiR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G97OKwST; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FCE111401D4;
	Mon,  7 Oct 2024 10:45:00 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 10:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728312300;
	 x=1728398700; bh=l1kyynLwByX6gsVVKHoBp6mrYazE+l1bCV6P0buJGv0=; b=
	oXxJmJiR7i8datKAd3ODSy3DFD9PGRgwMyoGsJe+5rJ1zWHDd2VF1PgVBDx2gpfn
	geE6mAQhw94O5Qv8s7E9W6JTCEV7PpYdKUlc/XsDnQuvK+seotckBcOOEWVu621N
	bb9gcmVsHSWXHD+hGLR59L4tq8Do45MjdxPXKBmjf+vvrBVe0sSLGcZ0kRyT56qf
	PfGFq6ULYgVZBUQbgmCJu7Rj6ED7aGuaVB/QvRXBtbiFqkz72hwbmq1V2WR7IMBo
	Iix3cN4mFPNmjW8LoHrV+sQteztepRGaDaoiH1B4pffLztnb6R63XOWj+ao8A6hN
	LcWWXuvL2bMNUhw0K9i61g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728312300; x=
	1728398700; bh=l1kyynLwByX6gsVVKHoBp6mrYazE+l1bCV6P0buJGv0=; b=G
	97OKwSTjYgRXvlsADh6ojVqJ8x4YOtIZU3TH1ykSo9YMsjDTBTu5VfuVUwzkoYgC
	0LP2endsPsgfKZXK+8yWaRPkwz4xAxmOqOjdHOst7UhCkfl29cfFUB1jK9Dq6i5o
	wSdqmO0j6E/b2iYYbqjAhXh/5M5KSQMUxPIDWlvGr0qMixyuZeY6hQxJgcKLwyVQ
	TGAD8Z/QMFxN1FWlfQJ4PIaIAtC9DgU5jhuvKglqjvoUi3dSz2SV7rnyTwvQBw7z
	TSJGT2gxRBLUO1szxWmHS8GRK0yJ4xj6DU2Dy8CR5/ayxtyfTgLlqAsDIS/NOqr0
	hY5TNzTrWiEPagiDQs2rQ==
X-ME-Sender: <xms:6_MDZ6LZDG4-mJohWk5MaAonCv80iB4qDEFHe_mK3Jrgwky9m_1ZNg>
    <xme:6_MDZyJSTsz2wT72qmgge_QIaAoTsZST6y5X_asDDeM8Mb3Jl8pINHaWd1giPpj2i
    UYgj4I_WzdaqiRlsNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepudevudffkeehueehjefggeeitdeivdffkefhuddv
    veethfefjefflefhvdetfeegnecuffhomhgrihhnpegrkhgrrdhmshenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gurghvihgurdhlrghighhhthesrggtuhhlrggsrdgtohhmpdhrtghpthhtohepmhgrrhhi
    uhhsrdgtrhhishhtvggrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheplhhinh
    hugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6_MDZ6vc24XznZ3vNSFSwLLB5yBN3wSNxL_4X9mGJHPmbqFPeUOgDg>
    <xmx:6_MDZ_YCZoOs6Rvv_Hwm-9_h-ap8u-2DCtqt8NXxLvyqzMY76y1DFQ>
    <xmx:6_MDZxYLJORp4BzzViiEX2k2GVXdzhlVieMIRx_VzDr22gLxSZlxPg>
    <xmx:6_MDZ7AYfVL2BK_WFNWVyEti0rH2vGxtwqnymyVsnKIZA1KGOXT4Iw>
    <xmx:7PMDZ1HkjRvdiNCdKZheNhYJ81HvC1bTgXhEfhhfQx83vmWX5HK9o5Cm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D76472220071; Mon,  7 Oct 2024 10:44:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 14:44:37 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: Marius.Cristea@microchip.com, "David Laight" <David.Laight@aculab.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
In-Reply-To: <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
 <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
 <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
Subject: Re: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024, at 14:40, Marius.Cristea@microchip.com wrote:
> On Sun, 2024-09-29 at 21:16 +0000, David Laight wrote:
>> [You don't often get email from david.laight@aculab.com. Learn why
>> this is important at https://aka.ms/LearnAboutSenderIdentification=C2=
=A0]
>>=20
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>=20
>> From: marius.cristea@microchip.com
>> > Sent: 27 September 2024 09:36
>> >=20
>> > The PAC194X, IIO driver, is using some unaligned 56 bit registers.
>> > Provide some helper accessors in preparation for the new driver.
>>=20
>> Someone please shoot the hardware engineer ;-)
>>=20
>> Do separate unaligned access of the first 4 bytes and last four
>> bytes.
>> It can't matter if the middle byte is accessed twice.
>>=20
>> Or, for reads read 8 bytes from 'p & ~1ul' and then fixup
>> the value.
>>=20
>
> Do you recommend me to drop this patch?
>
> I know that there are some "workarounds", but those didn't "looks"
> nice. I was using that function locally and I got a suggestion from the
> IIO subsystem maintainer to move it into the kernel in order for others
> to used it.

My feeling is that this is too specific to one driver, I don't
expect it to be shared much. I also suspect that most 56-bit
integers in data structures are actually always part of a naturally
aligned 64-bit word. If that is the case here, the driver can
probably better access it as a normal 64-bit number and mask
out the upper 56 bits using the include/linux/bitfield.h helpers.

        Arnd

