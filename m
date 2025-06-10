Return-Path: <linux-arch+bounces-12323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6BCAD40FA
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E597A8E6D
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E456244694;
	Tue, 10 Jun 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TLokPYgU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD5242D96;
	Tue, 10 Jun 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577168; cv=none; b=jL3K2rmhXRVf5nXv6EsLTfKaOYPxLRJAVtLXrQh2dgbeHpvogeZp2qP6TeahTAqz1aKrLHFGfgYOLhEBK8i7b3y2bP/J5yj78Gq53w5j32rYNyoy7ZU3fk0Ud6bEbr2VqZ/EalBeugu/AWNnkJBfHFfJoAmCo+9upyAz4MQpe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577168; c=relaxed/simple;
	bh=3MVevzdmKY2MoaSr9fLPlF7MVVG4u5Yky4WnC3OmSRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0yGvmX2gBy55GCNpLJG7dyhMiGYQydWNF41GAW6h8hM0EIvG3jtKgy6XFw9KYx9YjhbgIOKLMT1FkG2HVQfrckrtjx/r4AaiWhDLcE1r1W+azw6YIJ1ey2Jx1OX3Z23A0RZhTUvdy7cI80cGILnyx2j1mzgXEd44CHOwHlj7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TLokPYgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D748C4CEED;
	Tue, 10 Jun 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TLokPYgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749577164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijj/kgQ1/3fFIkkk9vUFgfYNo0mzKr6rXHhJ9w9nI50=;
	b=TLokPYgU2JOEdQndAvw9+JV28T5jssbviJD7hlMW/fJJWgwg7N1xBB6JMMINtsdD2jc1wR
	9vxPjpyhcdGVqfZKknbrL3tvYcbtlmFpSutoV8Knv518B4pawM2wjrJYa0svP2Pstv+4eW
	hu9USEEBUy1uuH8Mnd+AajCHjJgPyQQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dec6911f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Jun 2025 17:39:24 +0000 (UTC)
Date: Tue, 10 Jun 2025 11:39:22 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <aEhtyvBajGE80_2Z@zx2c4.com>
References: <20250607200454.73587-1-ebiggers@kernel.org>
 <aETPdvg8qXv18MDu@zx2c4.com>
 <20250608234817.GG1259@sol>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250608234817.GG1259@sol>

On Sun, Jun 08, 2025 at 04:48:17PM -0700, Eric Biggers wrote:
> On Sat, Jun 07, 2025 at 05:47:02PM -0600, Jason A. Donenfeld wrote:
> > On Sat, Jun 07, 2025 at 01:04:42PM -0700, Eric Biggers wrote:
> > > Having arch-specific code outside arch/ was somewhat controversial when
> > > Zinc proposed it back in 2018.  But I don't think the concerns are
> > > warranted.  It's better from a technical perspective, as it enables the
> > > improvements mentioned above.  This model is already successfully used
> > > in other places in the kernel such as lib/raid6/.  The community of each
> > > architecture still remains free to work on the code, even if it's not in
> > > arch/.  At the time there was also a desire to put the library code in
> > > the same files as the old-school crypto API, but that was a mistake; now
> > > that the library is separate, that's no longer a constraint either.
> > 
> > I can't express how happy I am to see this revived. It's clearly the
> > right way forward and makes it a lot simpler for us to dispatch to
> > various arch implementations and also is organizationally simpler.
> > 
> > Jason
> 
> Thanks!  Can I turn that into an Acked-by?

Took me a little while longer to fully review it. Sure,

    Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Side note: I wonder about eventually turning some of the static branches
into static calls.

Jason

