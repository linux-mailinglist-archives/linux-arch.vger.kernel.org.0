Return-Path: <linux-arch+bounces-9587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD72A01569
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E01883E51
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D961865E9;
	Sat,  4 Jan 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BcUU2d7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ximQM/xf"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E46F06A;
	Sat,  4 Jan 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736003259; cv=none; b=FqmWoiFNltZFLNHoP6Xppy/f5+Y/sBkeeTl+NV4uk5i5yim+H84NXp2/Chtjkx5mhbBvuubmMMY/5CY0G5lGaRQLHK0rJlIyivDeOxDRSIeIqEO6cM2W6zGTAkWFpRyucKEEqz83+vg9OlLqp3+jl5FOYvKm2IdO+HLHqhE1b6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736003259; c=relaxed/simple;
	bh=+BZz7FviI3TBCalV1e60uUEnMvA7e5Wi2s9BCNli7yU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e80A4TUnK0agJTC3VHv1iX3A55UVfv7VFRqDnBGTLYZPuzrFwThQRKlXSYbBauBjdCzSeFihMwj0rKGVIpqkSYXIjRzfBI21pVV1NQQtc3bfRjLNLYulZtCytDnVIBdDPJrZXOyOJli3R+1vBdvORJS/Bq2n2RcfVeX0iT7BwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BcUU2d7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ximQM/xf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA0262540182;
	Sat,  4 Jan 2025 10:07:36 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 04 Jan 2025 10:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736003256;
	 x=1736089656; bh=M0nmtuIJkWJPYDPQ/bqvPv6lAARcLTEvDSY0fgCKPW0=; b=
	BcUU2d7M9akas/1GwJb3EGS8jdTpq/75SiTY7oopfHQSSnwbWWgLkfTT4TuFgxUJ
	PDoSzZsd+uldv4iqvzbX8qkpHzjcSjfBpbTLkvwCtHP4RFtZOfYS3jbkocrjb4k1
	t2sF0xmn50N+kiG3DWhbhsvyxdfqvccI6tYka+klpDFDZ84ptlVq0XXvlcb6nWV/
	opEyxdkH+DzrE8QPTH9Qw8VQGR0UOj97WbK8nQ20ftIJbc/CnVpzzFSL1u6kMFFe
	ssmucdGgQ/SDB/EvqhGv15F+eBYlJWGfCgbxQJZMOYPGS3cYgLnvs06Ff5k201/9
	s7r0lnL1jInxOPC7aA3qZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736003256; x=
	1736089656; bh=M0nmtuIJkWJPYDPQ/bqvPv6lAARcLTEvDSY0fgCKPW0=; b=x
	imQM/xfvLE4cCIaFymxIH+v40rhgTp7Cny8YpkgPyzwhxSdcw6ic7QtEAn4yrRVf
	JEU+bOpQh8b4prHAsL/RYQEk/dlgeDzTik6v/LrH3Cyoxn6D30rWwf9De2qe+AbK
	aAkp9kwMobSSMiac+Cz2TNLsjXAkcM5v7WJLJvZTLZIDi9fow6gDTIO1dCPOHE7e
	Uy6ErA5ISa4FhUpZdTfOZF258va1YdXQKwJPUj6uDBu0bQyQMjJFQNySfQZzlqRZ
	0KKX94z7HEuTDBrVGkx80QdVCnJZdUHLUd1rOqfMEbq/YgBMM31iJAs1oRIHjZaf
	NSsCcSKd1DUtAhvXX/FzQ==
X-ME-Sender: <xms:uE55Z2GMf1SP0satJQ93wS15VbEeVG79xv0y7ZjChe07nC0QSJMOWQ>
    <xme:uE55Z3UH0GFXuEdxCVRWEm0gPFKy8y6InkQIRu7-Rx6hED5PV5ewsJAYareowi4oL
    cfi66qa7Q167-rONq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehshhgvnhhjihhnhigrnhhgsehlohhonhhgshhonhdrtghnpdhrtghp
    thhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgvrhhnvghlseigvghntdhnrdhnrghmvg
X-ME-Proxy: <xmx:uE55ZwKjgtklv8ZgpwyUC1stA7HtBLC9HTEbRTAGmxFcGAFsYNzTJA>
    <xmx:uE55ZwGgzkEXnyp_BXQXiHVzukGDHRlAmKXZcNY5LphEMakJLle-rg>
    <xmx:uE55Z8XK6kN9HmdBiNSPi6j6U87BbM0NlRX5t7mzt9nFsg0foEEKMA>
    <xmx:uE55ZzPwpyHg3AL5IYP4MVv6yF0fy-JFuY5NMXpJgx2N0GrNxefloA>
    <xmx:uE55Z-LL3BrutndePtwcJD6o8G4of8HcUIaxha8-KIz14L1cXA1p7NhO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0BB632220072; Sat,  4 Jan 2025 10:07:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 16:07:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jinyang Shen" <shenjinyang@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <fbde518f-ffea-40dc-ab11-f37b7bd1615e@app.fastmail.com>
In-Reply-To: <c47a9589-bc19-4e0a-866c-08e022e89539@loongson.cn>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
 <c47a9589-bc19-4e0a-866c-08e022e89539@loongson.cn>
Subject: Re: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache syscall
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jan 4, 2025, at 10:04, Jinyang Shen wrote:
> On 2025/1/3 02:34, Jiaxun Yang wrote:
>> +/*
>> + * On LoongArch CPUs with ICACHET, writes automatically sync to both local and
>> + * remote instruction caches. CPUs without this feature lack userspace cache
>> + * flush instructions, requiring a syscall to maintain I/D cache coherence and
>> + * propagate to remote caches.
>> + *
>> + * sys_loongarch_flush_icache() is defined to flush the instruction cache
>> + * over an address range, with the flush applying to either all threads or
>> + * just the caller.
>> + */
>> +SYSCALL_DEFINE3(loongarch_flush_icache, uintptr_t, start, uintptr_t, end,
>> +	uintptr_t, flags)


I think for consistency with other architectures, we want start/length/flags
instead of start/end/flags.

The meaning of the third argument is rather inconsistent between
architectures already, but at least the second argument is always
length so far.


>> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
>> index ebbdb3c42e9f74613b003014c0baf44c842bb756..723fe859956809f26d6ec50ad7812933531ef687 100644
>> --- a/scripts/syscall.tbl
>> +++ b/scripts/syscall.tbl
>> @@ -298,6 +298,8 @@
>>   244	csky	set_thread_area			sys_set_thread_area
>>   245	csky	cacheflush			sys_cacheflush
>>   
>> +259	loongarch       loongarch_flush_icache	sys_loongarch_flush_icache
>
> Can we use cacheflush as arc, csky and nios2?

Agreed. I would also use the number 244 instead of 259 here.

     Arnd

