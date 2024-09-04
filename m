Return-Path: <linux-arch+bounces-7007-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B252696BF23
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53CC1C22531
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914F1DC056;
	Wed,  4 Sep 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pXg94LuH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9CA1DC052;
	Wed,  4 Sep 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458033; cv=none; b=Kz1RG2qwWskWAUTvMQG8VJDiWbXPHI+xeAsN6scQ0BPEpuo58qHtE6SdtA7hNMmlzG9zdsXElRQCat7hLD7UGlhKP3pYaoOcNFIBgZDilUUh+6TOaPflzulJq74DGeh7LwVt+yHhydQZ/vwIR/vo+o4iHvfyqHFLZRkCOhChx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458033; c=relaxed/simple;
	bh=dyPCknaNtr9K/4CdNIaOuZmUXzMQ1Jjm4p5OUqdTfSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niXhheXJt0QFZ6a+neqvkCr4wg5OqYnxcfWU1MlsUX4iW9jYJzcFg+pZeX+H22mp/k8koNnvprToNFBXwiX2tu8OtFGDTJ3J8zteAbQ2r/x9B+m0wfYkeuTckYLrM6X/7hd3piYkX0gitY5ghMvf/eox3R4PeWV27bQMt8HCZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pXg94LuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DB5C4CEC6;
	Wed,  4 Sep 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pXg94LuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725458029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5x0UKLWG3mQwf8YLUvj26zE9xHzNpchA8xYk6MK8wP4=;
	b=pXg94LuHYq8ZHaXZK7zbwWIACMj0JpWA6BiU61t6KtRs/wKYHsUoO9dDiOz9u3n+iI2pUr
	m71YBYQysrFgloGw2YwWP5i9/gM32GOdu7OTC9FzUW9Uv07s2ZPUd4oXTURKckLXcFa0x8
	c1SwrrQ2wDKXkXMFeOYIiFrQznhyM3Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa100a45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 13:53:47 +0000 (UTC)
Date: Wed, 4 Sep 2024 15:53:42 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5 0/2] arm64: Implement getrandom() in vDSO
Message-ID: <ZthmZrDUcau5Ebc6@zx2c4.com>
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
 <20240904120504.GB13550@willie-the-truck>
 <CAMj1kXHsfmaydb+RCxA1rJPs9K8o4y8LSMTO8sMH-pmAwrZ6PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHsfmaydb+RCxA1rJPs9K8o4y8LSMTO8sMH-pmAwrZ6PA@mail.gmail.com>

On Wed, Sep 04, 2024 at 02:28:32PM +0200, Ard Biesheuvel wrote:
> On Wed, 4 Sept 2024 at 14:05, Will Deacon <will@kernel.org> wrote:
> >
> > +Ard as he had helpful comments on the previous version.
> >
> 
> Thanks for the cc
> 
> > On Tue, Sep 03, 2024 at 12:09:15PM +0000, Adhemerval Zanella wrote:
> > > Implement stack-less ChaCha20 and wire it with the generic vDSO
> > > getrandom code.  The first patch is Mark's fix to the alternatives
> > > system in the vDSO, while the the second is the actual vDSO work.
> > >
> > > Changes from v4:
> > > - Improve BE handling.
> > >
> > > Changes from v3:
> > > - Use alternative_has_cap_likely instead of ALTERNATIVE.
> > > - Header/include and comment fixups.
> > >
> > > Changes from v2:
> > > - Refactor Makefile to use same flags for vgettimeofday and
> > >   vgetrandom.
> > > - Removed rodata usage and fixed BE on vgetrandom-chacha.S.
> > >
> > > Changes from v1:
> > > - Fixed style issues and typos.
> > > - Added fallback for systems without NEON support.
> > > - Avoid use of non-volatile vector registers in neon chacha20.
> > > - Use c-getrandom-y for vgetrandom.c.
> > > - Fixed TIMENS vdso_rnd_data access.
> > >
> > > Adhemerval Zanella (1):
> > >   arm64: vdso: wire up getrandom() vDSO implementation
> > >
> > > Mark Rutland (1):
> > >   arm64: alternative: make alternative_has_cap_likely() VDSO compatible
> > >
> 
> This looks ok to me now
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Great. Thanks a bunch for your reviews, Ard.

Will, if you want to Ack this, I'll queue it up with the other getrandom
vDSO patches for 6.12.

Jason

