Return-Path: <linux-arch+bounces-1317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE3828A2F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0D1B20F79
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C339FFC;
	Tue,  9 Jan 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GpMpkBqF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpMQg2JN"
X-Original-To: linux-arch@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7A38DEF;
	Tue,  9 Jan 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A9DFC5C0420;
	Tue,  9 Jan 2024 11:43:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 11:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704818601; x=1704905001; bh=bFVuHUCmJx
	RAxC1zh4/opM0gyA5+TjTOo7qCFS2FRg8=; b=GpMpkBqFdcC9HbridPbMFDXLTY
	7XFWI33bqAc9K/un9q1zUsVraGDDhNXA0/FO4OyeYoEf95URYLF9hyqDQIpYExj9
	lHR/+hF50r8ZJkFqMi+C02/uvBuQK8qAtUhxLSXorq1C6Hu/0Ih2xXDIBiCr9ErR
	SC69eVzAYitvp6Vdjhh0s9mr4RXLMBgbP8MTSbqnIGYMb8lg2UulqDjXNTGDM3R+
	12HidHWsyvrDN1cZgXr1plr4MtbYUhlhM3EMWAR2BbYcLku9nsGvR70yPU8ZebyF
	o34fCqAKMj1GE7ZnZeQqTzUGryOhlLJLcdY7fBUCUFNZCWUCO7lIdMGnNC7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704818601; x=1704905001; bh=bFVuHUCmJxRAxC1zh4/opM0gyA5+
	TjTOo7qCFS2FRg8=; b=lpMQg2JNziYchTiZ3cWpiuSjUOPLZBbwlhV3BbKiBPcj
	jgv4H4B5JBVohETIPT/e9gYmgxpDzHNbenG9e8PyN9rBCsu+g5AbjFHE2ebdaY3v
	oKpv2/L+5a9KaJ0uOa3bRzKwkRZ7tSCcbPsPjSDSSkabcXYPOcq2oIRCZVqRT/L+
	FDm5XcStz2CbMpxdx5+qpDAFgOv5n4kZCxH7UI1HM8nKC+KmT9sbZIgYhDkFxGOe
	BLNh7FuENyzfwifIxX+38CxMEhqi+lYAFIMS9IlNEEfaQzV7clpVh7NR4k6ow+i3
	Sw0H0mDXskGBnkOhy1wPnJ5++LUj+5sV/lc+f2gfOg==
X-ME-Sender: <xms:qHedZeAICDsRFoBlQJ2B8HxgG9uoR1X44kIaf5WnInsWmEPW8rrI9Q>
    <xme:qHedZYgj2xC0PZ47hiIvFS3UJTbXeSM29iEJlYROXlcbP0Ys427yR4s_vOHydGcDm
    O0B7oydPR4H5I6GvWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qHedZRmp-rcWsQjsRbRNJwmxcY_ZggxzZsCxqTQP3HuQ62792NckYg>
    <xmx:qHedZczhlV881HvelgPpUSIMsVU_0Jsvd1Wy71aEL2VlZ8wvPMMKCQ>
    <xmx:qHedZTQwAqg8O5FQO4PClBdLHa5D7CXaagpeECcNdaI2Qn29lgpDew>
    <xmx:qXedZdfY9MLktxjaLi0E9gkQKN7N3PLMqmneG8qWtSB8hTMdoLQVeA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 83C56B6008D; Tue,  9 Jan 2024 11:43:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1633a5e7-213e-4621-bdc5-5cc056da9d99@app.fastmail.com>
In-Reply-To: <tencent_13A0B6B4A3136E46CC448874232A9F956006@qq.com>
References: <tencent_13A0B6B4A3136E46CC448874232A9F956006@qq.com>
Date: Tue, 09 Jan 2024 17:43:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: "Christoph Hellwig" <hch@lst.de>,
 "Alexander Potapenko" <glider@google.com>,
 "Mike Frysinger" <vapier@gentoo.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: flush icache only when vma->vm_flags has VM_EXEC set
Content-Type: text/plain

On Tue, Jan 9, 2024, at 15:45, Yangyu Chen wrote:
> For some ISAs like RISC-V, which may not support bus broadcast-based
> icache flushing instructions, it's necessary to send IPIs to all of the
> CPUs in the system to flush the icache. This process can be expensive for
> these ISAs and introduce disturbances during performance profiling.
> Limiting the icache flush to occur only when the vma->vm_flags has VM_EXEC
> can help minimize the frequency of these operations.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  include/asm-generic/cacheflush.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/cacheflush.h 
> b/include/asm-generic/cacheflush.h
> index 84ec53ccc450..729d51536575 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -102,7 +102,8 @@ static inline void flush_cache_vunmap(unsigned long 
> start, unsigned long end)
>  	do { \
>  		instrument_copy_to_user((void __user *)dst, src, len); \
>  		memcpy(dst, src, len); \
> -		flush_icache_user_page(vma, page, vaddr, len); \
> +		if (vma->vm_flags & VM_EXEC) \
> +			flush_icache_user_page(vma, page, vaddr, len); \
>  	} while (0)
>  #endif

This is not my normal area of expertise, but I wonder if you can't
just do this the same way as alpha and openrisc by having the
condition in architecture specific code.

     Arnd

