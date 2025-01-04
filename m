Return-Path: <linux-arch+bounces-9586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A02A01567
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACADC1883A19
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FE1CC8A7;
	Sat,  4 Jan 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="E40127An";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ySso9l+V"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184F1CB51B;
	Sat,  4 Jan 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736002851; cv=none; b=TErB4K4ouOo48uwgJzYhmORcmYhBVli7BcFfgxzwIQ17fLLs0HCfX0jgpH+RTeEBUIdT/vADVCPRKCdfxAloIO7F8k3yb1VDpnDQpvIlnFqBlZNiRfhDQs2RScYmeRTMw3UF3H3kDBxhtwhp5OlBhcytUlNS2y4qIrUFbUPSV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736002851; c=relaxed/simple;
	bh=nDFKV6GOGYJ+WdethPN5KmpehxyL1b+Y2HmrEE55Im4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aoThHSpKC1tnKc2ivKXNtG4be/a7JZnTUXg+TPT67BNQObpMcMAYnbWU3VLUTynmIgYbK/18zmdob0fz0f8n6iKMFexfvM5z7M7BQFLcbVodSocRGwc1OMi52ih0ZKiW4x2PISFnlVWstM4YTyRY7KDKbTSDvZm/SQPSbIiHqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=E40127An; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ySso9l+V; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3496E25400F6;
	Sat,  4 Jan 2025 10:00:47 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 04 Jan 2025 10:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736002846;
	 x=1736089246; bh=QGjX73YFHMdjpQpQ0EBBf33GuP7pZVJBoTAIXuaEEhk=; b=
	E40127AnDDS6kAj7zmPIXtD5Ex0r3Y96ce7KV37PcUrw+2MTw8CVhnD6kyadk+fU
	bmhvrJaGtCvM7okcAVNHUSF+RZ6F/xoYI+tvojCX4TQWbr2byJcOaJiggLnF+A5j
	8lqA572/DxZbrVsqTru+8rQJGvF+Uyh2t2Cn6WhSjpfuERhP1gm+A+kuYknOvQSr
	P5bsjn+yTOSQaJXkz7L1Qpqw+pk2tvmpkEFIUSbcEBvSZve2JIydlgWDccC7sTOe
	4tTFpEdiLBuTYXUCM47OicRD7AIUYwxG6YpCf3JpzuI1firtB301i7NDc93hjfVt
	IAklZEyWhcEMK15inn8Uqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736002846; x=
	1736089246; bh=QGjX73YFHMdjpQpQ0EBBf33GuP7pZVJBoTAIXuaEEhk=; b=y
	Sso9l+V33SgnnJRSodIn7pwyHy8kbRj9TY+aBjEMoX4pZuU4x5gxalx6axhfo/Bv
	uQ+zgypxqexZRl4QqUWU+MRcYVKUszIC46DJ2ce2z+wlF5mk2ipM/ycHcbqh6Yog
	g8A4Zg8TS+JahVADpcxtKXAWJ8CUgFJzfwrtvsI8JVYLPI1Gmz6QdoRuI9fs0xF0
	EaVZHly7CdHWrJMv7bhKqiEzvgApWd5kGvU1lJpfsRVTuOA+eQW8VKo6nV8za+Z2
	TSHCQ53uXiGTgnT8MH8mY92BudU/4p/t4kUicHVR9/xcRAQuPx6X1uen1u2m+7la
	q18JCBAT2gpMPKir4GDRA==
X-ME-Sender: <xms:HU15Zym3nmhUl9Cy6OG1f5No9rHEDVPGnPpqVWTO48mXrbHNDRFeew>
    <xme:HU15Z53u5NPQMgO5HAGLqCaN8dH4VrJ0Vsoh9eDERztC_i-TQ-c8M1Dw1EaZQb-zg
    AHTK6w4eHStUKi6uo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:HU15Zwr_9vzgKU4IV3SfH_cRsAW6L4FBcweWSbUu7DJovbPBM3Tjpw>
    <xmx:HU15Z2n_aKw5d5fbNt4E74uIewlcH4HKHr47YhP6dAsGBMLo8Gwcfg>
    <xmx:HU15Zw3aPH1zg9Kjyv-DWM5DOMlOEwJsWxHwcMZVT8vW6i6j2gWNlQ>
    <xmx:HU15Z9shs8nTMu1dmOSaPpkcgzdM5vuiT5VTtHuyY3-ycqS8qaxTJA>
    <xmx:Hk15Z0-kLSDh_fHCNcjFCDsBGj51RVsV33tWKaVhwjnj1GznJPnm8pek>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78F0A2220073; Sat,  4 Jan 2025 10:00:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 16:00:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
In-Reply-To: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 2, 2025, at 19:34, Jiaxun Yang wrote:

> Why am I upstreaming LoongArch32?
> ================================
> Although 32-bit systems are experiencing declining adoption in general
> computing, LoongArch32 remains highly relevant within specific niches.
> Beyond embedded applications, several vendors are actively developing
> application-level LoongArch32 processors. Loongson, for example, has
> released two open-source reference hardware implementations: openLA500
> and openLA1000 [6].
>
> The architecture also holds considerable educational value, having been
> integrated into China's national computer architecture curricula and
> embedded systems courses. Additionally, the National Student Computer
> System Capability Challenge (NSCSCC) [1] features LoongArch32 CPUs, where
> hundreds of students design Linux-capable hardware implementations and
> compete on performance. This initiative has resulted in several exciting
> high-performance LoongArch32 cores, including LainCore[2], Wired[3],
> NOP-Core[4], NagiCore[5]....

I'm surprised that so many resources get put into 32-bit hardware
implementations on loongarch, when this has mostly stopped on riscv
and arm, where new hardware is practically all either 64-bit Linux
or 32-bit NOMMU microcontrollers.

> From an upstream perspective, we will largely reuse the infrastructure
> already established for LoongArch64, ensuring that the maintenance burden
> remains minimal.
>
> Porting Status
> ==============
> The LoongArch32 port has been available downstream for some time, with
> various system components hosted on Loongson's Gitee[6]. However, these
> components utilise an older downstream ABI and fall short of upstream
> quality.
>
> On the upstream front, LLVM-19 now includes experimental support for
> LoongArch32 (ILP32 ABI) under the loongarch32* triple, and efforts are
> underway to enable GNU toolchain support. My upstream-ready kernel port
> and musl libc port can successfully boot into a minimal Buildroot
> environment and execute test cases on QEMU virt machine with clang
> toolchain.

I assume the MIPS legacy means that a 64-bit kernel is going to be
able to run the same ILP32 binaries as a 32-bit kernel running on
pure 32-bit hardware, similar to powerpc/s390/x86, but unlike
riscv/arm?

We need to be careful in defining the ABI to ensure that this covers
all the corner cases, such as defining a signal stack layout with
room to save 64-bit user register contents if there is a chance that
a 32-bit userspace will end up using the wide registers when
running on a 64-bit kernel, but also avoid any dependency on 64-bit
registers in the ABI itself.

    Arnd

