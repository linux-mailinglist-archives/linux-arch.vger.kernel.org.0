Return-Path: <linux-arch+bounces-14173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A7BE5A5F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55DF44E6F39
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C102E5B1B;
	Thu, 16 Oct 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLS+OHG2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC2199385;
	Thu, 16 Oct 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652854; cv=none; b=cS+fCxmwopFF4xa28z4TFIpYtdEkKcLZVWyaXRRAd/2dGasuy7o7ttYPzsk48SYIouKLVFXOI0Yqi2H+azF9jBPmTzZSUyH/sDqUDIi4+W7lKn7I/03+dvG3r0xoeMnOmRLzLuKJfpI9xGb/aTwYvMcAjO8epUAxDPftN6saCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652854; c=relaxed/simple;
	bh=ouAFygVCIM4XXtcmRJ2maxdMcDTfSelmWNvBntx9JPA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mlFxj/l//oyLjcQYCWqthZK7HRGQpQzCBgr0YYkzMTx6suVa6lUiSwtJ/gMPWetp7lMyT3dXUcE4GtfN34wE3QRUyOgskF0TImlRs/FK8mqvmL1bYc105xTxw6og/R+VOTkd7IxXAhwSqAwhRwYd448ML0QS71B1LdwPk+SawN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLS+OHG2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13CF01400131;
	Thu, 16 Oct 2025 18:14:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Oct 2025 18:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760652851; x=1760739251; bh=y6tbFg6I5X37u9n3geJjz7h9HCre07tUvWj
	3JcU4nDU=; b=WLS+OHG2cZZ2eaAM0oQCkagJF8T+furTvGOUue5SsdBkVx9Nj93
	UZ/tiTmvNNq+WEmdeQ1oS7mWfmj9t0Y/y+VzLJ6LGBpN4t4raUbizss6EkselbMs
	cuc1sySEDISOnOhl4bL3/V7o1rFy6DCC4AbmWS/SYd5eW249YQ8dsJF7B0rzzg76
	hMz6F3C2yHgMipDHe3Mhh2xOWIcN3tUNClrcQRsGY6UCejDgtB8luBC1CvUw5VKk
	hoWpxaizYAcLOET0ZibH3HOZe7i+Qfvdhp0L5SH3INqndNuIICEDoQV0gtTcjWb+
	r5NJm9A9VWSU4FzU1MZ5/7bt/aQfyFgy9Tw==
X-ME-Sender: <xms:MW7xaBrclnajsvsLJ9Ta5a17f7a-ztDFmwAXgD6nRf-S_8Tmo21YOQ>
    <xme:MW7xaKCRXc7biGyIJNbIAGt2o46Bv2tD72aArPHP0SGNFz_EvorffEruBDupCmNmf
    iq9zGY8ldrXVHi68kSR_uq_YWo3RFvzWPIYF-o5FslMuLGGONSClvg>
X-ME-Received: <xmr:MW7xaKfiHGuoeGemX-D7QCELvT7kRbrgKJPirxv9vVY_yBzJFvC372nsJfFe3245gy3a5sCMFURy_ThcTDB0gdDVgCqpMniDrqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhl
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehmrg
    hrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrh
    gthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MW7xaKsqULgORCHxFG9sV7dXX-53TfnFx-t1hkfJLR46-dg6j75iVg>
    <xmx:MW7xaJjXBbkXHwybUw77RwyMkcYlXXpwiod-TSRjZfZuWXs8wboj2g>
    <xmx:MW7xaKun-aQLxruWKr5tViYS29Dx0ao2YuKxGZ33HTTU3WMpLDgOGw>
    <xmx:MW7xaM_ogeAdHNrU4uLjhpGFQ19bCojqizpQOt8ikTw7keCT1ZC6jQ>
    <xmx:M27xaOuFAyrDQTUs2FgG6VaLFsAnTdJJOtMREg_1KIkdeDB4E0sjVzOX>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 18:14:06 -0400 (EDT)
Date: Fri, 17 Oct 2025 09:14:09 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
In-Reply-To: <b80e06b8-e568-408b-8132-99565c50a0ff@app.fastmail.com>
Message-ID: <f562193c-c4fe-334e-8d70-9fe949c9da2f@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org> <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org> <b80e06b8-e568-408b-8132-99565c50a0ff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Thu, 16 Oct 2025, Arnd Bergmann wrote:

>  On Wed, Oct 8, 2025, at 00:19, Finn Thain wrote:
> > Discourage assumptions that simply don't hold for all Linux ABIs.
> > Exceptions to the natural alignment rule for scalar types include
> > long long on i386 and sh.
> > ---
> 
> I think both of the paragraphs you remove are still correct and I
> would not remove them:
> 

Yes -- correct in some obscure sense, but misleading at face value.
Hence this patch.

> >  Documentation/core-api/unaligned-memory-access.rst | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/Documentation/core-api/unaligned-memory-access.rst 
> > b/Documentation/core-api/unaligned-memory-access.rst
> > index 5ceeb80eb539..1390ce2b7291 100644
> > --- a/Documentation/core-api/unaligned-memory-access.rst
> > +++ b/Documentation/core-api/unaligned-memory-access.rst
> > 
> > -When writing code, assume the target architecture has natural alignment
> > -requirements.
> > -
> 
> It is clearly important to not intentionally misalign variables
> because that breaks on hardware that requires aligned data.
> 
> Assuming natural alignment is the safe choice here, but you
> could change 'architecture' to 'hardware' here if you
> think that is otherwise ambiguous.
> 

Do you know of any hardware that has "natural alignment requirements" in 
the completely unqualified sense in which that the claim is made? i.e. 
considering all of its native vector and scalar types.

That's a rhetorical question. I'm not trying to provide an exhaustive and 
up-to-date list of platform quirks. With this patch, I'm merely trying to 
discourage faulty assumptions.

> > -Similarly, you can also rely on the compiler to align variables and function
> > -parameters to a naturally aligned scheme, based on the size of the type of
> > -the variable.
> 
> This also seems to refer to something else: even on m68k and i386, 
> scalar stack and .data variables have natural alignment even though the 
> ABI does not require that.
> 

Then it is doubly misleading.

There is value in explaining what the compiler can and cannot be relied 
upon to deliver, but I think the myfunc() example already serves that 
purpose. Don't you agree?

> It's probably a good idea to list the specific exceptions to
> the struct layout rules in the previous paragraph, e.g.
> 
> [
>  Fortunately, the compiler understands the alignment constraints, so in the
>  above case it would insert 2 bytes of padding in between field1 and field2.
>  Therefore, for standard structure types you can always rely on the compiler
> -to pad structures so that accesses to fields are suitably aligned (assuming
> -you do not cast the field to a type of different length).
> +to pad structures so that accesses to fields are suitably aligned for
> +the CPU hardware.
> +On all 64-bit architectures, 

The poor reader: "I wonder what '64-bit architecture' means in this 
context..."

> this means that all scalar struct members
> +are naturally aligned. However, some 32-bit ABIs including i386
> +only align 64-bit members on 32-bit offsets, and m68k uses at most
> +16-bit alignment. ]

"... oh, okay, so anything that naturally aligns a 64-bit word is a 
"64-bit architecture". I get it. Oh, hang-on, that doesn't make sense... 
Why would any 32-bit architecture be expected to naturally align 64-bit 
members? What is he talking about? CONFIG_64BIT maybe??"

Moreover, you have digressed into a discussion of the ABI. The aim of this 
document is to avoid the performance penalty for unaligned accesses. 

Whereas, ABI traits would seem to be relevant to a discussion about memory 
efficiency, like I said to David.

