Return-Path: <linux-arch+bounces-3727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98268A6DC4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC0EB25D0D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF612D214;
	Tue, 16 Apr 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PhuHidJG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwJzTEWO"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07012D1EF;
	Tue, 16 Apr 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276896; cv=none; b=cMVzEpGD9BUSpx7Q46xQHb/sEfevZwtvtl3+hlfQOxfMs6tlUoWuvaPvI7Ud3aluzkHczy8ZLSGD8LutwyoiRQ4HcpEQk+8oUQW9hCFaTO9PB33P45/3KCr1Od6R90oGlv+3cIyyimU+VaZtHY7PH/RQkXnBXYV7sLvUBAU4tbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276896; c=relaxed/simple;
	bh=ykb7W4k1sAQJ+bAaSvIxWtB7tBpsRi36G1ivw8abnYc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=giJA4Q/6iAn2uKSw7xdI624y4cfvJBeIQZ5lBILy3V+d5fpdVS3vNdh/lbwrhwcz1utKL7CCqgvgQizwgwHYsMUpgOaQpCaOoQmQFi3zCogFQUVpUAjdB7o8v7qYpWTbXAQN4t+lyFA38vNJvarGZ85OMZ4egfhRrY5WgP0GP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PhuHidJG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwJzTEWO; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CF4801800101;
	Tue, 16 Apr 2024 10:14:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Apr 2024 10:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713276890; x=1713363290; bh=KPzLCaHC/p
	j+3rFajrw0i7S4P/VVkta4Rje0fImd0yQ=; b=PhuHidJG8VxEaleWcSvfT8RrHw
	TcYpy++V74uv3QKWGOlpgpgf+SyQ5ZMUDqJLv+ieUMsuc8Pmtiq++dNE663y9Uad
	LvrAN0HOtT2qs+A/f4aq+nVonFlt/VwdOkU2nanJjNa82ewBH8oB5aLebg7I9L9Q
	MQ35Lsqa1E3jBtPSDHEtJJYSzPk0kEH2oNsZ+DH7YzOAgG77pfREDjIKDZK0OlU1
	ykJdeMBcVae2QG9+ALYmi6W5QL9dT2t1oSscxO7e/VEwRsVmEZ0C2f4Zbh9vjVw+
	W7IpXT1f6uaR8m9elp7Eg6QbzlD/0IGMBHFJTDDTj/YgkNWa9g2+6a+UOAVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713276890; x=1713363290; bh=KPzLCaHC/pj+3rFajrw0i7S4P/VV
	kta4Rje0fImd0yQ=; b=DwJzTEWOX2Hls51YomwtsnXC6I5vZWVj1oEjCmZqd/w4
	/BM9dctAypC3VAh4Oz4mY5kcs6zSW8fe8cAZRgBLT55bjA2fqIDMNe6WGNO2KRuZ
	Jjr3ZtAKKxCedEfxYPU1bazquw118noVHXdS6lyH410qPjgoLUJXE2hO07NqjAt5
	8Hcs44ULBFzJak5+kCEL52Xk8RDeQY0GcG2jRLdtWqv3OJ6v8QIdpm0CMDrt/K9C
	lY5NoW7RWgLaOzRd+eqlsZnc4LwI2mzdxNykJ4pUQ57VU7MJEG9gzAjvcCM/7O3x
	+JWWrL+wX7/DQoBETaXJDPd5ndEqTBtJtmv+W+8xsA==
X-ME-Sender: <xms:2YceZu_9FAGe-i--NPJBjTauDg4-xAMAVlOrBJWlSnTxBehLXUMBrw>
    <xme:2YceZuv0XvSwYl4vAievAi7JTw5_AaEV7n6fXPf18ycEShQkYrYU6dPt2DAOsblIh
    ToZh9ydfmQU-UcyyMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjefgfedvgeejvdefudeuhfdtkeekvdeutefhuedthfegheelhefgleegkeeg
    fedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpledqrhgtuddrhhhofienucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:2YceZkDCfeab0TH3Rh4rtEyIiKkxkyFwGMeh0KhkrA8Z-8I_Zrv9Lg>
    <xmx:2YceZmeh9PfcIdkLlyAu37QlSmb6WwmJGzajGP1ht8Sm6W1ISJE9JQ>
    <xmx:2YceZjMHY7VsWd--NWcw8lykhNRgNv1dGhRV0DRqXmRT61crZRn5tw>
    <xmx:2YceZgl_jJEJ48Yw1zTDgQy343q-1jmB_Ot2bgzrRZnmalhMKV2YPQ>
    <xmx:2oceZkHMtcdYQbblFmKJRiK8IHeY1PlJ_So2eHwdnopd4LyDrH0TSmH7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4BA4BB6008D; Tue, 16 Apr 2024 10:14:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53d194db-c7d4-4026-9fbb-3b41de545849@app.fastmail.com>
In-Reply-To: <c82af143-b620-44d9-8647-f52096b851ab@redhat.com>
References: 
 <CANiq72mQh3O9S4umbvrKBgMMorty48UMwS01U22FR0mRyd3cyQ@mail.gmail.com>
 <c82af143-b620-44d9-8647-f52096b851ab@redhat.com>
Date: Tue, 16 Apr 2024 16:14:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Hildenbrand" <david@redhat.com>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
 clang-built-linux <llvm@lists.linux.dev>
Subject: Re: ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set but not
 used
Content-Type: text/plain

On Tue, Apr 16, 2024, at 15:51, David Hildenbrand wrote:
> On 16.04.24 12:26, Miguel Ojeda wrote:
>> Hi David, Arnd, LoongArch,
>> 
>> In a linux-next defconfig LLVM=1 build today I got:
>> 
>>      ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
>> but not used [-Werror,-Wunused-but-set-parameter]
>>        629 |                 pte_t *ptep, unsigned int nr, unsigned long address)
>>            |                        ^
>> 
>> Indeed, in loongarch, `__tlb_remove_tlb_entry` does not do anything.
>> This seems the same that Arnd reported for arm64:
>> 
>>      https://lore.kernel.org/all/20240221154549.2026073-1-arnd@kernel.org/
>> 
>> So perhaps the loongarch's one should also be changed into an static inline?
>
> 4d5bf0b6183f79ea361dd506365d2a471270735c is already part of v6.9-rc1. How come
> we see that only now on linux-next?

Andrew merged my patch to enable -Wextra yesterday, and it appears
that this one fell through the cracks with my testing, either I
missed the combination of loongarch with clang, or I last tested
it before your patches got merged.

> I assume we should see the same on upstream Linux with LLVM=1, correct?

On upstream, it only shows up with 'make W=1'.

> If so, we should likely just drop that completely and rely on the 
> asm-generic one:
>
> diff --git a/arch/loongarch/include/asm/tlb.h 
> b/arch/loongarch/include/asm/tlb.h
> index da7a3b5b9374a..e071f5e9e8580 100644
> --- a/arch/loongarch/include/asm/tlb.h
> +++ b/arch/loongarch/include/asm/tlb.h
> @@ -132,8 +132,6 @@ static __always_inline void invtlb_all(u32 op, u32 
> info, u64 addr)
>                  );
>   }
>  
> -#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
> -
>   static void tlb_flush(struct mmu_gather *tlb);

Yes, this looks like the best solution, and I can confirm that this
addresses the warning on linux-next.

Tested-by: Arnd Bergmann <arnd@arndb.de>

