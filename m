Return-Path: <linux-arch+bounces-5727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438C9411EA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23BC1F23EF6
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9D19EEDB;
	Tue, 30 Jul 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ew2cx06N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoPzqG9E"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC019E806;
	Tue, 30 Jul 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342612; cv=none; b=L7M4zSX35lMvNunPpIxTMp+UguSBf73zPhjG2oY79OZbiqxShwlJTfMI1hmvV77P7KVwhe/filYrN+ANn7j2eIBohlN3B772iZHT5DjIHkwWE2Z6t3Xj/jJw/12l17NRL3/q9h2m8DNQW95Tg0oTr79TKZ9xyK1SNNJAjX8KnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342612; c=relaxed/simple;
	bh=hqxK3UPv3AG0wmnnvcnxtmPF4bcE21QtxbMnxK6s4UE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nhACIl6gWIgzeJ75wnOrWTS3pwX4ZJvilveGvFgfcI0i+/lHqaLXilspiCRPVZZjM8gu70KBN3n9/wO9lVqTrDzMa1L6jFz0SYgx5tQ1VFrZXy7P98Upvc2IOij1XDgrMg7uCoXdFC/UKretDhqyqqew5pqxPlRfLfjju3sr9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ew2cx06N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VoPzqG9E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 592A011406C6;
	Tue, 30 Jul 2024 08:30:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 08:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722342606;
	 x=1722429006; bh=ax3TXgeI0glaNper8z6NQUCsYmUmZbRtOqbs4F5ZhP8=; b=
	ew2cx06N36TZLnPoA3qP/yJfj8+6WzBmd02olrS4IuTty2o3Gh2iJtbJFahu5Li3
	fmpOIGydjfA9jUfpbcdtgLz6fJgCWjtQHs6TzJ8eYPdFiknh7lA/zQdvP/FHT6a4
	XMFJRc7smZIodEzizNE/0hRSO9cUeDMqFLvsLtAB3ZVJPZ4Nm+eqTfu1QEDn7vPI
	YjPlvl6n3+KHlObtLY6sYV2GIiS9R5NUV7bbPWrW0P/7lqmvMhkkcbFli7XhtOik
	G0tAO2Zz0Q3hQUuTXYiL42jR6bXHf/et8VgoSCGpwKsb0Qk1ZgxahYoYULZYt06J
	QHEErjuaLj5B4jNEiXvyOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722342606; x=
	1722429006; bh=ax3TXgeI0glaNper8z6NQUCsYmUmZbRtOqbs4F5ZhP8=; b=V
	oPzqG9E0aL4ntE/dmnKG42Mz1vIrFM9gbSuhxa9Y61kyGXJ5lX2okqbaSy5Mi6x7
	oM2XncvGQRZdTmtiTYLlRCtfwEcsVIh0QcxWJ13ZFqC+isgG4rftii899+O82ZmF
	QKK0QeCqizPwc5jlLfYf8+Jj8p5E8mW6K1kpNZanJ6+1IzRm02hBMlaY5mYUd1GS
	HeOT+yIpgTjxu1w1s0sJyzxwiuOQaF+L567zSesegWfZ1E+B89mVCi7HWl/gfAsh
	9IFO5AtKRRlkl388/ClPfSLnIXnoQ9YLm16wu1SfFNS+Kb924dlTp/n5ec+d9bsh
	tlPMAhCRicRM1DCyAGPYw==
X-ME-Sender: <xms:zdyoZicusJTH-Cp0DK9RdxpgwYL7VN6Uy_rOgpL3p6bAYu2yrbcj2A>
    <xme:zdyoZsPMZD4SDQwuiyr8cTya5D8OeBWt2Slo3QKxoG01mFQacqF8oWAG4LUmo_3fO
    FL4knPcZhROgfCQIPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:zdyoZji5BvYNxSCMH64c3ZDcar69nmR-SiqdKkC2drelgpa55fQDOw>
    <xmx:zdyoZv-YyF_7kosOpo0SywyRTqbb9VxceSyvcuy9Zt-BznwcaeKN3A>
    <xmx:zdyoZusCNmu0xV_fsa1cTEBd9B3pzCgWTv1CmALm0pvYzPedjuh6UA>
    <xmx:zdyoZmH8KChvWq7wHRyWz_OYIBynQGLjvNn1B0W63x70IgpM2n_rFw>
    <xmx:ztyoZihrMVZYDQpyWHHvS1du2LKBTVnpijIsWUJA43JW1nXqjHc2pgpt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8D720B6008F; Tue, 30 Jul 2024 08:30:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 14:29:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anshuman Khandual" <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Message-Id: <79960e1a-6fa1-4d15-b842-0dc4d6a2bc1b@app.fastmail.com>
In-Reply-To: <08e6c85e-2c82-4c15-bfe7-d42900d1c68f@arm.com>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <08e6c85e-2c82-4c15-bfe7-d42900d1c68f@arm.com>
Subject: Re: [PATCH V2 0/2] uapi: Add support for GENMASK_U128()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 06:29, Anshuman Khandual wrote:
> On 7/25/24 11:18, Anshuman Khandual wrote:
>> 
>> - Wrapped genmask_u128_test() with CONFIG_ARCH_SUPPORTS_INT128
>> - Defined __BITS_PER_U128 unconditionally as 128
>> - Defined __GENMASK_U128() via new _BIT128()
>> - Dropped _U128() and _AC128()
>
> Does the changed series look good ? Please do let me know if something
> further needs to be changed. Thank you.

Yes, these look fine to me, please add

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One detail: You are not actually using __BITS_PER_U128 at
all now, so I think it would be better to not add it at all.

