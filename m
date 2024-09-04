Return-Path: <linux-arch+bounces-7011-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4296C149
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2E41F29265
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500F1DB937;
	Wed,  4 Sep 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OW/LO7mC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRzaQM5+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAF1EB44;
	Wed,  4 Sep 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461565; cv=none; b=hi17NmVB5e3kE+YahPMF6Lsf8HEqXyrRmoh/s0DFfrOLqpkcIaFlD1r7FPSqPnU2u2xzjAwa5NL6uEujHIhW0p/aRZnEudPevcVQ2RehKhHte2zVoVT93Bd9oZ0ctWKMAXbbt7gt286ptPZkVGz1B1UU5fK16jhGjiOuwAe8dDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461565; c=relaxed/simple;
	bh=oDHD6tP/Jwhr53bRg8Qr0nBLa5o5GvZtmAPtrBKF3zQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a4ler+2KPCRpxxL4Q4v2diPO0rQWNKEZihfmz47FZMYP0vOyaeXwTX1dJaxx3lm032ut0VgtzHihyDhiLPf9EI1M/i32H4NBv6ZbMYU6ofwUmYPCnD62w1efa865xsPl1Qne9G3D5sUhgElbfPo9Egq8t//D9F0pkcAZB0WDWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OW/LO7mC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRzaQM5+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBAC3114019A;
	Wed,  4 Sep 2024 10:52:42 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 10:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725461562;
	 x=1725547962; bh=GMX/FHb1NQd5lg5/NpfA0ULYpIijReg7t7hsHu+fouM=; b=
	OW/LO7mC2lppB30DwzXZMH6lCAiLIyJWLwTJ8WLyc+YHWV0oTdfNn4lcUoFVo7UY
	9pAKcQyXorI/p55OmQQ43MuHV4CPFsIRG89uUXD0Fi320wNBlEKLPWB8SaS3j7Ur
	OL2WLCu5iDGAwFVAdwLAAzLhn+eFHkbDTRDvoI66AUoLz6kSZPlgrt+apWZMRtOt
	eZ7Vcdil8475qdV8v1uXKe0S31rfbNaXPSWF+2lBvH8zxX1Sq7j7XqB1X598LD5b
	Q5HP2jiSjVdvM+5CQg7w/5WHBbAFU9ZMc2b1B7FV+GoQ8KiThnSWxYKGDaEqcdUH
	qK807tjfVn8jH1VbOaZx7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725461562; x=
	1725547962; bh=GMX/FHb1NQd5lg5/NpfA0ULYpIijReg7t7hsHu+fouM=; b=P
	RzaQM5+yNXaGypCnpneCASFBgjYrzkXmPGYBFr8AaDnbyojCg6tvt18W5dbb4LJY
	wYTOK6bot/ttO93zl45SBmDQ1k560WZYaKEDMsUktXiaP2G6W2lw8z13PwVXHQGT
	0O+zoVyPzaI1bBWGnAOxqcmaBXKF1yKqsiMvipoXXl/nFCh4/Z6KI0FQbuRFD1kH
	S6o/to8Yzey+Olg6mt28KJ3HqlRKUtjv9U6N94n5Cz5jyX8IMJ4Adb0GHNHqOr43
	+CSW8HfbKG/XhK+M9Mqe2ysZlDPHVWwvYohTnBrXRpyVwPRHsGnoNuIqqovx0tt+
	K+4hVKBMyh8moJTR9QuPw==
X-ME-Sender: <xms:OXTYZq4p12hdvbKMhytFVAkAWVkaZ-3pDuze04UleHAP6U-sPfIaxA>
    <xme:OXTYZj4vbYuz9g7x3ukxtnTvqqwzVuhxSsmZ7lku3BkeCriAW5YZfsuqtDqrJjZ7n
    b9idb6uLQf308k97kY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgkeduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:OXTYZpcpd744LuEDKHGk0abtZSOZK17OJzsvZKCLGcNddTrdq5AFYw>
    <xmx:OnTYZnLLMbam6f8AEIcQNBoDHWuPpL-NXZxWSrdukyVqRGvUK4WHSQ>
    <xmx:OnTYZuLPV_Vu4_l2eLKyoTljsr5RjzWmpH-CJCKYHpzrAVZwBuUW0Q>
    <xmx:OnTYZowrZ3zP8_NQwz6P2slz9eBbSJPRTeMDUG6ZS_GLk1OrFCGiNw>
    <xmx:OnTYZi9oYTCa-t8HSSSwXFRu_qt3ZdCI77aJ8vx8moNPqqLSy6X-B-9L>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA8302220083; Wed,  4 Sep 2024 10:52:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 14:52:21 +0000
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
Message-Id: <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
In-Reply-To: <20240903151437.1002990-4-vincenzo.frascino@arm.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 3, 2024, at 15:14, Vincenzo Frascino wrote:

> diff --git a/arch/x86/include/asm/vdso/page.h b/arch/x86/include/asm/vdso/page.h
> new file mode 100644
> index 000000000000..b0af8fbef27c
> --- /dev/null
> +++ b/arch/x86/include/asm/vdso/page.h
> @@ -0,0 +1,15 @@
> +
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_VDSO_PAGE_H
> +#define __ASM_VDSO_PAGE_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/page_types.h>
> +
> +#define VDSO_PAGE_MASK	PAGE_MASK
> +#define VDSO_PAGE_SIZE	PAGE_SIZE
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __ASM_VDSO_PAGE_H */

I don't get this one: the x86 asm/page_types.h still includes other
headers outside of the vdso namespace, but you seem to only need these
two definitions that are the same across everything.

Why not put PAGE_MASK and PAGE_SIZE into a global vdso/page.h
header? I did spend a lot of time a few months ago ensuring that
we can have a single definition for all architectures based on
CONFIG_PAGE_SHIFT, so all the extra copies should just go away.

       Arnd

