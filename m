Return-Path: <linux-arch+bounces-13753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC4B9A3BF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B31888C11
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7423A99E;
	Wed, 24 Sep 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ABnLaHLH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ptr86+sn"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7F35957;
	Wed, 24 Sep 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723960; cv=none; b=qdR6hUQCS8uD8Ucp0769v7AJDD9yu3ymhbxy00PZ1H3lC29xRH2oUw62jaieN9bmHGTRY9cuGxPPl2NjSJWz14YWAN4QGu8nyIDugZJn7s0bCKg897IUoPYLWUrBPmDpEvtSgz0NV2w15eHxQ0Ul6fIJtPWR4g2hEx5dsO59i4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723960; c=relaxed/simple;
	bh=QFWBONOv+JjrIBPL48JQ4QvYiAYnI30gWv6I+2hMBYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fDwuKQhGHVT42JYA/ukJn9vgF09eyAlt4VyJKWTY2v6Yd1U0kEOfARQbdVZCCkbgnEYzmbkhd6z0MuebBsZaCm7gzeNCM+KR9TZv1golR7mgOiV8fIiNTnHtVMMWtpYnGgOXL5rAMBsMI2nK2cNlqFsOZTh4zQUEgzTy9E26psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ABnLaHLH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ptr86+sn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EA9D7A018F;
	Wed, 24 Sep 2025 10:25:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 10:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758723957;
	 x=1758810357; bh=CYj2gFEOZtbt1Ar9rV1vSIxgaPpdpGpGnomr5hhS6bE=; b=
	ABnLaHLHY6enFOkbtaLiqCcrwdzIiq3TTIzDh4p5OMwJ33sMXBWUAFC8X6jO1Lpg
	k5Da0CFapUeuvOvKEAQl974Wr8C8upmB4lP7MLCATZgyLrUeiXdlR/HvxnyCJHLq
	MWp2LL/pwc5YgcWEAKBIwBSVC39tC86d5GgSwa4Myo4zSkcTlqJEkeoEkzy70qNd
	WQuEXUcZZTsF2vm+A0RczsuLg98K1hYEYvGI+HjGjmbmFYQ2RQSvgHUrmwMI6iUh
	jjQsyIebKQG8GTWA3bZvOjtFnhY3fHaO8X5I9X0IsxhQVnWxMrexresK+RVnJM3h
	dS+JfE9jFFbHbwa5c+OFNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758723957; x=
	1758810357; bh=CYj2gFEOZtbt1Ar9rV1vSIxgaPpdpGpGnomr5hhS6bE=; b=P
	tr86+snoRceiJQuaUAGTFRHMDsQmzS4ySzEIXGPkyEMj1IeNJp1CRiTz7Q0zC8o7
	u5UIS7bzujtobAhxsZLXLZ0bx/aJY8hHJNM12GVb4cSwyWI4u1cUkHTUC7TebtMg
	YLSpwTVEM2+FrzS8ERCbCsTmgbh0oYj8I1ufyV7aIfZaK9EgDgVrvx1ohcrQ4GSh
	ozT1ebCKju1uD/3UWj4MBeqcTTToMvGeO8n004/WGi9yvVBLfDrz+1+J8kta8fub
	vUP2Hs5EunbqO7uoSEkP0pb9xHqfna5bUTWXdNkeur6Mt7M/djot9Rt7N8IdF5Hf
	xt2V030iv575AZrX7t4uQ==
X-ME-Sender: <xms:df_TaCUR04N1XCgJpzLKDnMiTdUSJpMNyXc1Uvac-DqHaX2JeAwLmA>
    <xme:df_TaJZe8IFNoWxUxun544VspA_oXSghx_Yw4CNnJ25CwwXvaa-BXIwdjCUUvkyPQ
    F0_weuxabAozQ8Zd5fq6JOCt0mio3iE5By8HrCwb25HA2o8quJSx1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvrghrrggughgruhhtrghmsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehquhhitggpshgrihhprhgrkhgrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:df_TaJrtsKgi6wwcmSrLw3m9v-Y3tFGFkraLNzQx8E4AlooA8QGfIA>
    <xmx:df_TaPXHNlaDOQdLZ2Hdiq1BtV6WSbJcFwtRagz6eSvUxB9sg0J7Ug>
    <xmx:df_TaACcmAFZetQ1reCSQnUfeqDoGWZOPRszCYaR-2JKQ8aPVnx7vw>
    <xmx:df_TaL3bD34ZItnRIpGZE8ZtYihtEkjA1dVf0JhKHjDgJZHjOiuuZQ>
    <xmx:df_TaKQCmepOXgBZIIFYd8J_j73SpHJwfaE5kWUgSMHZCtJa4YGyGShs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1087F700069; Wed, 24 Sep 2025 10:25:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgLkk2v4HBWZ
Date: Wed, 24 Sep 2025 16:25:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Varad Gautam" <varadgautam@google.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <d2514e7b-be87-4c77-9096-7285f2b715a0@app.fastmail.com>
In-Reply-To: 
 <CAOLDJO+8JApK5_qjtn+DhCnQoF+Lp-x1KP_QQvJUqecp744T1w@mail.gmail.com>
References: <20250330164229.2174672-1-varadgautam@google.com>
 <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
 <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
 <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
 <CAOLDJOJ98EccMJ4O3FyX4mSFtHnbQ4iwwXsHT2EbLL+KrXfvtw@mail.gmail.com>
 <f74d9899-6aba-4c8e-87b1-cd6ecc7772e6@app.fastmail.com>
 <CAOLDJO+8JApK5_qjtn+DhCnQoF+Lp-x1KP_QQvJUqecp744T1w@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 13:07, Varad Gautam wrote:
>
> Can I follow this along somewhere? (I don't see it on arnd/asm-generic.git atm.)
>
> The unnecessary log_*_mmio() calls are showing up on enough Pixel devices
> as a CPU cycles wastage, and I'm sure other Androids see it too.

Pushed out now. I still had it in my local branch, but did not
have any other asm-generic changes, so I ended up missing it again...

     Arnd

