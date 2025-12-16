Return-Path: <linux-arch+bounces-15456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10BDCC147B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 08:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC1D302218F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A133DEED;
	Tue, 16 Dec 2025 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="InvCeDmK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s80vRG8y"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6033EB1A;
	Tue, 16 Dec 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869543; cv=none; b=i6w/eELPpIzsAXQak/VeQpJn3PJMPf758CN7IlTo3gPI1Q2qmPDXdfNpT9sHf41bHsWYqEgpCWXYQagiKrhsXyQ4X/WYQMQEMaZukgyWmG+IqIw3NpmzQcCcfcXidR8csc0F9OUgG+ZAOritZO+tneyYCH4Af7xDwG8ZOdFwNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869543; c=relaxed/simple;
	bh=F4yobythtz7ToBFmU+mjhpOLXrgiyX0okc6HOVBUDyM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bgYfBUbm5OMJ5XFjEEZ28uTalX7mAxIWW71lRFnUpcNTEAqFg8cwZe0kuSKLH44OVfdN+z063dVQYlfpvlHvBH4SO3cHB/o1/5t7HJ8L3v+ijX6DP8G5SZCPcelfZed/p7mg7IPqcOG6ErTFGenRmDihX77OKydjorx8r6kEWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=InvCeDmK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s80vRG8y; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D6BB31D0014C;
	Tue, 16 Dec 2025 02:18:58 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Tue, 16 Dec 2025 02:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765869538;
	 x=1765955938; bh=F4yobythtz7ToBFmU+mjhpOLXrgiyX0okc6HOVBUDyM=; b=
	InvCeDmKkwJsdAmX2tWF0HsYuePMVhSVFPFWb4bn5RYPaCnz0sRJmI34CAvXJvoE
	Yx+dYw27f6+He0J5B1wzR+POxgP7rqANJm2yo1iCRVWKD0Qu7GMwbmFaH+YC4eXA
	Te7aRFzhNSDbhE9vF7URceodFUlyYIGEEsrKcJfqlT2qqbUUqYXz0z8wEJDezXTU
	ViTcw4VpHzCVGPW50HEnrqb0CNSIydTIxIVuVK7bJLGmQBtqMvJRb84vwi03oXw9
	tXy7z5O93v4NPyoxFIBsO4uK2kNgXo25a1xvUzm58HeG07pEyhh1YWz2x4DDd/qK
	U9u6VN8e12H7O2ISbiJYQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765869538; x=
	1765955938; bh=F4yobythtz7ToBFmU+mjhpOLXrgiyX0okc6HOVBUDyM=; b=s
	80vRG8yHDortR/0X/8pkChaBmMPNMMFHQUd6ltsNmHfxDHJwUxRxPatjndqoxvRd
	O2qdIJ88tmNGYnrcFzHsRWhXAZ4ulZwHXtRiqkMvIxcMrfnXeULthwGCZBcVVdfy
	0NEKGHCAOCIy/lwlU0dzlA3u3YWvOxZm8WHthH4O/STQc5D6jnZrwjECMI8A3+/R
	wY3gzBKDJWVinG/Myi4RmwP1JIk6+lL+HN2+BNhzY9Hvi4VqQm1j3NJCxI4AiZ8U
	9ftbI/n2UGSlGwKIIeEaVr/sAZ4QmgkpNdSn6ZlhCNYx6rU4SEXrqXp4BbkaUuPv
	S+QN/aAJotoTHICLNLDbQ==
X-ME-Sender: <xms:4gdBaY8wt7yJ3XGv8HQxatNNBn652D3A_cUvPqf-QgtIClF5YZGYLQ>
    <xme:4gdBabj6ApHQ3fPNjJDuVSbZLFWLAyvJBp0FYsZXJZvAqr0IKXgAxPQLGy4tnd7jq
    ppy1kpoxDnGoXrN_PWw1wWTrfjvKw1SjgzgNH9tPPmg9mXIq8x7YSkF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhohhrnhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    ughinhhguhihvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhorhgvnheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghlihgrsheslhhisggtrdhorhhg
X-ME-Proxy: <xmx:4gdBack4zTxQXMqriz59N2EWVO9SQ1ajgxZ-7WZCPg2TiGn0BJbUvQ>
    <xmx:4gdBaXiTVPjCUuZhpE35yaMleCY-eyHto4n9bQdM5rldhlxMMGhO3Q>
    <xmx:4gdBaVXzaFce0FrfNFgdXL072Gt_aoKjzKPby23fmEVZUH4iWtww-Q>
    <xmx:4gdBaZhA1Fj7ttVDwvOEg0Gn_DGodF8aPKC_i4ouhf3EkuzHX2VxUQ>
    <xmx:4gdBabzysQzAmZ5Y070fL-oF5TpR7SBNn4Leb_6-Rdm_01y9QKKKIFXH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A256C40072; Tue, 16 Dec 2025 02:18:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMXpWEdXSA2B
Date: Tue, 16 Dec 2025 08:18:37 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "Mark Rutland" <mark.rutland@arm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dinh Nguyen" <dinguyen@kernel.org>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org
Message-Id: <3001d6a6-77b7-4ff4-8c8d-58dff8e6bdb6@app.fastmail.com>
In-Reply-To: 
 <d6cd17b387fa4b4cf9f419ec586ac4756bc7aaeb.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
 <d6cd17b387fa4b4cf9f419ec586ac4756bc7aaeb.1765866665.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v5 2/4] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 16, 2025, at 07:31, Finn Thain wrote:
> Some recent commits incorrectly assumed 4-byte alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have
> failed on Linux/cris also). The jump label implementation makes a
> similar alignment assumption.
>
> The expectation that atomic_t and atomic64_t variables will be naturally
> aligned seems reasonable, as indeed they are on 64-bit architectures.
> But atomic64_t isn't naturally aligned on csky, m68k, microblaze, nios2,
> openrisc and sh. Neither atomic_t nor atomic64_t are naturally aligned
> on m68k.
>
> This patch brings a little uniformity by specifying natural alignment
> for atomic types. One benefit is that atomic64_t variables do not get
> split across a page boundary. The cost is that some structs grow which
> leads to cache misses and wasted memory.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

