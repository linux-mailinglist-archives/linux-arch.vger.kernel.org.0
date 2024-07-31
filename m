Return-Path: <linux-arch+bounces-5787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C89434DB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C97B21218
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94041799F;
	Wed, 31 Jul 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PP9t2c3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H679FsUr"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D51396;
	Wed, 31 Jul 2024 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446233; cv=none; b=q9BTr2K9ZmdL6rna+B5/xv47RplcNYCPU3gYKoTKLuLCzWc6SwTcZy6Y0kuawtH6QujMFmLrWp4ZJvvkzkEIvi+a/rSX1NhcTUS0OJA3wI8+id31wRB8q1rPAxBkmNUB02m891IKB8AazXyInInHgu576EK8VSoYiVBMuJTQ/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446233; c=relaxed/simple;
	bh=/ptNCRa8BuFsInH6VMyF0zSzEPmkxWE1KAQ8UMgYdpk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fSUteZUgC14pGeebUOlzZarQgMQ7w2getzFTUwRwWSDWARJKt9l0zcoQl8cFPY/qvw92FN2HQVoVGYEwgXjrW49vD+z7Qy2tOm2zjDKc18eHR6eEmM9oNMUXl5N2eRXBJ2i4QqfsaFMwUeJpBNLS2+o9ZN9gZe8oTZ0t5jhdUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PP9t2c3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H679FsUr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 75CD313832BF;
	Wed, 31 Jul 2024 13:17:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 13:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722446230;
	 x=1722532630; bh=qqLGv/Rrjo/QdG2fPOcEcMg2UTgPErujpTL4/GBY9Sc=; b=
	PP9t2c3+Z6iCxXXrYyz9oCR9E43ZG0wRPBncMpfqEzFbm6CRg+b99FtDRyRlinYr
	XoF/v+4P6xhDnrw7VAI2mknndHgI9zMUEbnmo0B36ODFHu1nYXoqSPdOU2uO7HAJ
	TZ+vk3bexwM4gFtikS/Atw3X1yQf7ZwCjjl+UlpMQ7dyAi1fOcRKVJvl/AzAeeYo
	t4/0Gzh2W+rWIEqtijKdsTlZXo6Uiw8xfdmSyXGTOZJE9/L8SR+086lNNb/XzDSl
	PKxSa792oJlmRG7PxQHGTMRhDtERjIHLtosYHdVjm61rZXQu2GxvvvnDyrMQEnNM
	RSexXBb4UIesEcIoWyJmrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722446230; x=
	1722532630; bh=qqLGv/Rrjo/QdG2fPOcEcMg2UTgPErujpTL4/GBY9Sc=; b=H
	679FsUrBlfj+kk49OlW7cZG3wbt5jFGaONqC5Gs/fGp/Xvd1HHbWnocAldqnzR5K
	lET3iQf0YRhrzUMgyrbOFlVXoanQSMe19Cx0fjuAac/jh/OM6tgbsOnVEUVA3aCQ
	KoyCWfL17ecD9whEBK2Gby6B5tr68FPBhuIwBLDLNflbvmi0XXMl/ZzUlVHPns2b
	E/E5XfZd983D23PxTbOwqZMVFq9txIqL/GaUwGS7BK2XJmIyhiUumKlQULHWqaTw
	XBGJYxMAbg2SVFhEEYB3sN9jn8Up1pP7wI8TukwHZCiGo+AS6CL9Ttw4P1+4iElA
	PcSTZHrAHP3w/40APLpPQ==
X-ME-Sender: <xms:lnGqZg_cEcg5hKayVx_EM3MDocic-pJQqH0ahJwA9R5nik_gSH9vMw>
    <xme:lnGqZotIGmNfKJoih6GqlvHJVXw5qZNJ340v7LnrVWxrL1vASJhnDGdm1gYzpCjVH
    dr5cRsfj1QI9kzwrFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:lnGqZmAd4jA1c0RQIdnRMHMGFV5GTZSqwmEjJND5BRh1BR_kv7NtoQ>
    <xmx:lnGqZgcuDpC1-dokiPTxvXowbqhHdrcMF8_yzOXugorzqhPOLO8gRg>
    <xmx:lnGqZlOnG9C5TwfhUWzfBu0bgsoNiZ5MGaItHdD0AFpPInJIZ6hz3w>
    <xmx:lnGqZqlshS-puMMw02UN8PXw8qUFjNA8YrD4UWwM-cryoOuhySFj0A>
    <xmx:lnGqZo3wO6s9IhaUiLu6GtEZvMVd3id7IN6mh-_QGYxlsKkH5TbCjQIg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1B80FB6008D; Wed, 31 Jul 2024 13:17:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 Jul 2024 19:16:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yury Norov" <yury.norov@gmail.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <14f622a9-599a-4b63-8830-0bc825f7c468@app.fastmail.com>
In-Reply-To: <ZqpokVWg75iROgKH@yury-ThinkPad>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725054808.286708-2-anshuman.khandual@arm.com>
 <Zqkt3byHNZQvCZiB@yury-ThinkPad>
 <b1dd907d-d45b-4602-964e-70654094a315@arm.com>
 <ZqpokVWg75iROgKH@yury-ThinkPad>
Subject: Re: [PATCH V2 1/2] uapi: Define GENMASK_U128
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 31, 2024, at 18:38, Yury Norov wrote:

> OK then, I see. So, is that a GCC bug or intentional behavior? 

I just double-checked to see what is in C23 and found that
it indeed defines a 'wb' and 'wbu' suffix for arbitrarily
sized integers. This is supported by gcc-14 and clang-15
or higher on 64-bit architectures.

It's too early to rely on those versions though, as gcc-14
was only just released.

     Arnd

