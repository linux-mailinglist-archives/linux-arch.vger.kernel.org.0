Return-Path: <linux-arch+bounces-7694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14149990409
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342391C21F45
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E321B423;
	Fri,  4 Oct 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Flt8R6ar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlD66ogT"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8F21F408;
	Fri,  4 Oct 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048094; cv=none; b=L7b8b5O1Ca6N2uo/1dHl+uSu8g/bUCGWsimgNjKA1bWZ/vA09Wbuu8N0S1p5DWVt0olRN5NLu7kfpfl3+lsqGHSr3EvCGfzk2gyjOnOyVaQckJoGVSrlyW5KYp8yORVUHz9UuWT+h7wQuCeF2iTF1x4PVpieAaQvdYG2/YM0Wb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048094; c=relaxed/simple;
	bh=XIfrIgEF0e1nIJ/TtD9GyH4cdb/w2+mydGjzBdhrBdc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RbVcF48so4u/v8NiGWpGJMZ1dWZ4amFHyEOR0vNgoU7KVqhOORYlogXfFSsJRntp8rNwBF7I3mPNSJLVHkG7CAmm5G7O0QVogWQ4lytPCMvhIQJYiAKDFQ1hAbeBrdc7cgEozhJgrkNrA3vmg1sfd/n5Xr4co0gjnGHmWzwrHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Flt8R6ar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlD66ogT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B8091140140;
	Fri,  4 Oct 2024 09:21:30 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 04 Oct 2024 09:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728048090;
	 x=1728134490; bh=9tkmmkT8aZFveB/04AxHCDNSFo41C5XPtA7E428DTNI=; b=
	Flt8R6ar41GP/CfssqrT+rga5rdhA8uT28QBZQ6KZa2VIogV/TJ3B+BktNcgjAlg
	r1rOI/bSkK/nOP/bXvGLMNDG6UG4qKSip/SfWedmZNFcQRr5a3kPDnunt7ucSFfF
	gflRikVjBdsS5gw20Kxv5V2Qrs+jlAPW8yUkaiaD84lSI4hXIhRj13pVLSQAJlQh
	NsTHESw4Yh1x+YxPfuQAEt3uAylmaHEBaxMPTeCqRySguhjHY8lFY/W05IyJGOAl
	1wnjQfPU5I0kd28nRqWbAyWcbLZ431d4vZpMDUZIvhv+LI9BrIZgHaARgVh+UO16
	To5IOUQWHDPVLQMrptozwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728048090; x=
	1728134490; bh=9tkmmkT8aZFveB/04AxHCDNSFo41C5XPtA7E428DTNI=; b=I
	lD66ogTIB22KofW2jjY2mTLAwVKLSoYCruu76C6CMz1S9Qj/3gzXUL0tX1IZ3VLT
	ubKLuYGaS5H+jBh0efieq9UJvbJK2lSXjDrlCZtyrf1qRGqSzYfASlekhKQkClhK
	jdHzzS3kOjdxQSyWguErKY6aJOb8uNvFzlh8WHLyPuOhuXxxFJ3Pov/4E05MIvpF
	ceyG4pMPt1sWW75fHPjjKSRgTZAt5I/jdwhYGZDVKwVJz7XXMz/0c21ZYX5Xx7Ng
	yHtSyFe3u2037nEu6XnWqVFuDzwJHgBPx7eU8aGBh+ahBwW0EN3y/sv4Fm8+zq9I
	fAhaK3v35GfUmLv5Z1pew==
X-ME-Sender: <xms:2ev_Zt8fur0HYm3qFKOKA7-OGHjVYmtGFPYVL-Hihbbzf5gfE-_xTw>
    <xme:2ev_ZhsIbAy7ApLYVkyHDdaGXFs35qrLWAafpD9ZBYywl-jI76pnrfEAbfslrmt5N
    2ptLQ77lLdcJ6k75ks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnph
    highhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2ev_ZrANjDNLHa2XpDwba87kaB89f9iB04IBQv6OdPGqLtW94MEsQA>
    <xmx:2ev_ZhdgEUpU1Xygv4FMKTqBKagAbaanYG6YrLJB5r6LBQvlW9Xrfg>
    <xmx:2ev_ZiNYMul7redosbHax5Oly__LzRN2znKLG6ykV6wvjGd6BlXhYw>
    <xmx:2ev_ZjmVyaB4vn9BUVoIcHq3FnsgRpy04qGMivf2ili8wtknmf6lDA>
    <xmx:2uv_Zryngd8MFsNWyhjVoRY-wbQqTRm1YcPrNtPgDm1P9QnHSUcheGer>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 155E42220071; Fri,  4 Oct 2024 09:21:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 13:21:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <5b52dfcf-7b4c-4715-b1b2-6e41062302bd@app.fastmail.com>
In-Reply-To: <20241003152910.3287259-2-vincenzo.frascino@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-2-vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 1/2] drm: Fix fault format
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c 
> b/drivers/gpu/drm/i915/gt/intel_gt.c
> index a6c69a706fd7..352ef5e1c615 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> @@ -308,7 +308,7 @@ static void gen6_check_faults(struct intel_gt *gt)
>  		fault = GEN6_RING_FAULT_REG_READ(engine);
>  		if (fault & RING_FAULT_VALID) {
>  			gt_dbg(gt, "Unexpected fault\n"
> -			       "\tAddr: 0x%08lx\n"
> +			       "\tAddr: 0x%08x\n"
>  			       "\tAddress space: %s\n"
>  			       "\tSource ID: %d\n"
>  			       "\tType: %d\n",

Isn't the type of PAGE_MASK still architecture dependent?
I think you need a cast to either 'int' or 'long' here to
make the corresponding format string work across all
architectures. With the current version of your patch 2/2,
it looks like it has to be %x for architectures with 
64-bit phys_addr_t, but %lx for the other ones.

Changing the 'u32 fault' variable to 'unsigned long'
would also work here.

      Arnd

