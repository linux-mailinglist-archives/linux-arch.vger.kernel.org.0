Return-Path: <linux-arch+bounces-10821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B82A6109C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 13:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9616B690
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B41FC7D2;
	Fri, 14 Mar 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U1usQ47y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFCf37Lc"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A51C8623;
	Fri, 14 Mar 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953949; cv=none; b=kqMSKvaCwKalN1FP+zTFBzv49I0hSq0Eu/jkftII8i1dA4mgnGZrO9EsWx83/hXEoWEdG3PGHC0Zm7i803Yi1NqGkPcC/euk7S2iiMmspJVaNxZ2/QnZbo0H8DHC4+EzbN6HMS1YuCAw65UHVmw3mwMjdaJSVdqUJitYWL13KsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953949; c=relaxed/simple;
	bh=oDvcCqTNPmr960TVhAPx7ki91/X/IM30EuXnWEwEHmw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CdbRKjB4OgVRic9yywBKgQGR2c6RUmhOzUoLtZzxNMJX1z6zhJKBsI/vakxuuUVer8fjX0JYIdQgFGrcB/4QqOYxctyC/ixRuTteplhuu/0GPSlBt0y08hSMGRlMWlDI4KZx7mY9HZZFJ93mR4gtGroc/7gjn4Tnz5Lw3Yce2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U1usQ47y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFCf37Lc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id DB6121382D51;
	Fri, 14 Mar 2025 08:05:45 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 08:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741953945;
	 x=1742040345; bh=2vOhmJSQwki0yk55AruyUCr5jm9yS9UmHlRqG9oZypI=; b=
	U1usQ47ySSlx9y4TuLmc1toq6rZ7ZjtIhkR5HJ8wvDZd+NfY1IZcjeokncNxvzs6
	qwBo7KJ1462wWD3t0YhJDPDjEq6Osh/sRcRU+/lzVCM09bnXME8LTMMTggIjw4G2
	h8Vdx7iz9nRtf0dTaUsv1Ms3yKaJ/l1mR3c2HudLRTyl/8WFA2q6OdXu7ELwwPbw
	G72Oi6dESAgTifzYLT8OE2A7lgR2v1q2R/nokvIJur1DCmUfAVa4Ws7GoX89ZR8K
	h6tiIOSJclkkK9SXZNg4HimIoqmxLQy5K3fgqVhORC/XQb64tINUZBXXTRAFtALM
	pf2+bhVa5V4DEdfDves34w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741953945; x=
	1742040345; bh=2vOhmJSQwki0yk55AruyUCr5jm9yS9UmHlRqG9oZypI=; b=e
	FCf37Lc5A/CUWHeCkzatnquhB/+DBfQPWq0DQO+HNsWyHbYCPO+849o5TiPEbUDP
	5kukSCZps7gRPBedxr7zBJOBYmC4BfwjJoD0bPGshm8tCx/V8jAEajteLM9qBnHI
	Bn7ze++kfoIbN8vU1HMB+aqYiYAXX+r1gARAx7Xtid3X7XdyMqdk3+XwF0cuDVgf
	1OICThfDvwcsPGpRN4FcKZMkQPZlWMIO4nVqp203D1iNDwuFv7fKiG/mqNzkaaHs
	hzDaGczL8ur0mfshnBBvKg+a22Qy8b8xH5Nd+QSZ/wgpxS8tyTNX1TQQoqX9266p
	KTYOB2qGtZ+Ul+8A38ugg==
X-ME-Sender: <xms:mRvUZ68vNiGMQT0QkZSA4c0OjAb4e9M87kENGxS50xn9s1A-wynYtQ>
    <xme:mRvUZ6ujM9Ka_H6BPJlySphav0RKtsNBCIY2lMvC02ZWPBcz6The2Q3SKeE6uvKMT
    8rkTPoMjlVTqWPrnPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinh
    grshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mRvUZwCqDAg562USMOyCv2KtmR_WXPGBZLQd_Xj3_oGAVvsxFxHGqQ>
    <xmx:mRvUZyfOA8tzccGcvmDh7qfllQg65rHBdL09cZ9wDgnmH9yNRR39Qw>
    <xmx:mRvUZ_OUDfYLjpMF6OLwH5DjQ589-vcqJb4ZdqWEB8nsqL_JvWXg_w>
    <xmx:mRvUZ8lZhYKys4zvkuyzCgJHe5oxRUoHiv1VyKQnWdVpOcSSnOyHXw>
    <xmx:mRvUZ0r5jtxIl35QxlCy4sYqyDva_6miJBth9AjK_yLusp0aIHbN4ayD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8310C2220072; Fri, 14 Mar 2025 08:05:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 13:05:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Will Deacon" <will@kernel.org>, "Thomas Huth" <thuth@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>
Message-Id: <df30d093-c173-495a-8ed9-874857df7dee@app.fastmail.com>
In-Reply-To: <20250314115554.GA8986@willie-the-truck>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-9-thuth@redhat.com>
 <20250314115554.GA8986@willie-the-truck>
Subject: Re: [PATCH 08/41] arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi
 headers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 14, 2025, at 12:55, Will Deacon wrote:
> On Fri, Mar 14, 2025 at 08:09:39AM +0100, Thomas Huth wrote:
>> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
>> this is not really useful for uapi headers (unless the userspace
>> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
>> gets set automatically by the compiler when compiling assembly
>> code.
>> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  arch/arm64/include/uapi/asm/kvm.h        | 2 +-
>>  arch/arm64/include/uapi/asm/ptrace.h     | 4 ++--
>>  arch/arm64/include/uapi/asm/sigcontext.h | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> Is there a risk of breaking userspace with this? I wonder if it would
> be more conservative to do something like:
>
> #if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)
>
> so that if somebody is doing '#define __ASSEMBLY__' then they get the
> same behaviour as today.
>
> Or maybe we don't care?

I think the main risk we would have is user applications relying
on the __ASSEMBLER__ checks in new kernel headers and not defining
__ASSEMBLY__. This would result in the application not building
against old kernel headers that only check against __ASSEMBLY__.

Checking for both in the kernel headers does not solve this
problem, and I think we can still decide that we don't care:
in the worst case, an application using the headers from assembly
will have to get fixed later when it needs to be built against
old headers.

I checked that old gcc versions pass __ASSEMBLY__ at least as
far back as gcc-2.95, and it should be completely safe to
assume that no older gcc versions would be used on kernel
headers, and they probably would choke on c99 features like
'long long'. I would also assume that any other compiler that
may be used to include kernel headers has to have enough
gcc compatibility to define all the common macros.

      Arnd

