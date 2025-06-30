Return-Path: <linux-arch+bounces-12501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9677FAED457
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91481715B1
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 06:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF321D516F;
	Mon, 30 Jun 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NhPvakrK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T7dbN3V5"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F522339;
	Mon, 30 Jun 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264227; cv=none; b=SApwF03abhZGO0ZOkU6ZClX0eTjhE2nAm3zXAlMZZvx8r3Res67ialNJvK27nOWGEFtC0JBPOKIcDMI4KNVn0zkt/ezO2X5Caz21Xib7LFTGCBk9y0JttaPQPTEv/NcsTeWb8mOj6Jipi8IUJj/KoCDwQvC+nWjqM5RAoUinIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264227; c=relaxed/simple;
	bh=lI9JS1gMGaYeV8rykN9upjkXqvv+KcVhPNHtn1XXOBU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H2OKcooYhAe9YY72v8sClzIofmW8aQZ9UJL2eghFgTNovLKTOgzsP/1JlklrmdsUxfWSJ0viubbDSDBaOFwr38UyZ8PAPMQQj6kb3kixfe9Z7Z0QH1BQ5IPqmQVlLoo5ZBFlpVOTIbUxkmO11/J0XualiT33lI86mCk6HEP4HFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NhPvakrK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T7dbN3V5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAAE47A0077;
	Mon, 30 Jun 2025 02:17:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 30 Jun 2025 02:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751264223;
	 x=1751350623; bh=m/dWKz6R2q5LBHWZz6c4+WXnk+qQgVD9l1+vH4Khp5M=; b=
	NhPvakrK+wlR1TDob+AprINwNyDs9Q4TUUHF4IqhQVcj56b/89RHdsS3ModuoQnR
	Sfwd0ZaJiQQzGEVgwrMsMetZ/kFb9J6yBOtvfKyf+vUp9E76X+Zalg52NCE35pE3
	7rdWis2u+DYwZPu7a+ln5SgueTI4lQyvvqwgSNUR/3GGqTp6ymVuetgUbv1InCz0
	+P0q2s/x0Lslz7fZ4TV+Ec92N2+WuvIRLAI0vnZCWhLubuz/NYWAUIifeCnZ9Vii
	nRxaQur9Whpt+iViedPUYxwHlfseiVKAykEQwHqltAka0/T8mW0FoRbDc4Fwp5MZ
	wPpMCHBBzioDOy8rHF/RRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751264223; x=
	1751350623; bh=m/dWKz6R2q5LBHWZz6c4+WXnk+qQgVD9l1+vH4Khp5M=; b=T
	7dbN3V5k+0QpOsPbHvr8XUBKUKwoSQDDQwDVakEXhdCPYcz6O3NM0c02zqPe8vQ8
	qVoQ4jb583PGUmo2GohsAefXu25wWdfBH+pXNn5tLI4llakDQGxIy7GpZJ8nnorO
	YbZG2okNGb5BKg4znCUtMGxQAsc7OWSBtzLXH+f9TjJoj/4WTP1JYZeKmJzdnpw3
	fcwETnw4xAGGrf8X/DiAGzXvJ3Cu3xL8xNhioiW3thDANgtyGw8uRSxJzWYixTCa
	S/TfTyFgnAd/swfPcNf+hIEuYbZrSxxmARmFV4XvbhPSdjbYfFN7FrrpB0TjnW03
	JY5e4JnuQrBijcPkPjMzg==
X-ME-Sender: <xms:3ytiaN810t-GGqP0vJWrQHi7kj4OJkk4sMV1rFfm_h1F0Hv4KTtEwg>
    <xme:3ytiaBtmcXzxeNssk37Ukjy4U81IqJE6uwnVr_F6AkaEQsLxxLPfgMIAwnEuugFYR
    ghthl3MsxILGLGtAqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeehhedtgfefffevvdevkedttddtvdetjeefffduheevieefvedvffeitdffffffjeen
    ucffohhmrghinheptddurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ughinhhguhihvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshgthhhushhtvghrrdhsihhmoh
    hnodgsihhnuhhtihhlshesshhivghmvghnshdqvghnvghrghihrdgtohhmpdhrtghpthht
    oheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3ytiaLATSWByEb9pmvJ3N1OEyY3hyKXAZGEUjufVnfu5zdivIa-5GQ>
    <xmx:3ytiaBfu8LHVX1MikKoTRlTp8KmufSaB07iNP7thq51plUx-8F_1Kg>
    <xmx:3ytiaCPO9eRS_Tx4FmkHcDeqvypebKmeKA6VBLSIpV302S3RTVBuVw>
    <xmx:3ytiaDnTBjdAn4L57hWevSjKHjsEkyB66WZhERhg4YG0WnL6fBTKkw>
    <xmx:3ytiaLsCD79bWbxav7fHF975-ZFpMKr9FGKXt9yD8HtLKKcz7jR-QNj0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B964700063; Mon, 30 Jun 2025 02:17:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9274589f850a4c5d
Date: Mon, 30 Jun 2025 08:14:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Simon Schuster" <schuster.simon+binutils@siemens-energy.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Message-Id: <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
In-Reply-To: <202506282120.6vRwodm3-lkp@intel.com>
References: <202506282120.6vRwodm3-lkp@intel.com>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing, please fix
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jun 28, 2025, at 21:59, kernel test robot wrote:
> Hi Arnd,
>
> FYI, the error/warning still remains.
>
> date:   12 months ago
> config: hexagon-randconfig-2002-20250626 
> (https://download.01.org/0day-ci/archive/20250628/202506282120.6vRwodm3-lkp@intel.com/config)
> commit: 505d66d1abfb90853e24ab6cbdf83b611473d6fc clone3: drop __ARCH_WANT_SYS_CLONE3 macro
>> kernel/fork.c:3088:2: warning: clone3() entry point is missing, please fix [-W#warnings]

My patch only moved the warning about the four broken architectures
(hexagon, sparc, sh, nios2) that have never implemented the clone3
syscall from commit 7f192e3cd316 ("fork: add clone3"), over six years
ago.

I usually try to fix warnings when I get them, but the entire point
why these still exist is that they require someone to add the
syscall with the correct calling conventions for the respective
architecture and make sure this actually works correctly.

I don't think any of those architecture maintainers are paying
attention to the build warnings or the lkp reports, and they are
clearly not trying to fix them any more, so maybe it's better to
just stop testing them in lkp.

    Arnd

