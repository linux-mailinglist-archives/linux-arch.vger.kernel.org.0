Return-Path: <linux-arch+bounces-6920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C7968AAF
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8991C224D9
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6D61CB520;
	Mon,  2 Sep 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyJy0x4e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812C1CB500;
	Mon,  2 Sep 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289850; cv=none; b=BSWpaSx53D9rgJN8ohbjl/PbwRm2WVcVe+ZoBLF2F93J29PPpUPxzLjegVil3ihuw3m5zVT3NRb2hh3/xHwUmJSm2avmq4tDj5VbQqdEoz9fj9Uj/v6cnbrbw5XnOGwbKOKXzV++blNMvTRgfccKqsekqciVaY+rbTqQz4kSFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289850; c=relaxed/simple;
	bh=FQuANokbMQm105/4lohTPcLAsEqau+/sgT5xtCR4W10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9NY03gAfls2ZMUJOBNfb617R8fYD8CxPDPI8oBW0/KpAiOM6n459YQoUqTI3E7TGnLeaVYqzotE2W1UDV9tuIXvDX1r1kKvlJRxRaAgbJXvzIsN3WTVu9iscx7Juif2EEeQyX5tt25DFNJ/vIQQxZmpyslUU7kreW1pKJsWTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyJy0x4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53153C4CEC2;
	Mon,  2 Sep 2024 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725289849;
	bh=FQuANokbMQm105/4lohTPcLAsEqau+/sgT5xtCR4W10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyJy0x4e8uhcM92vKcIKUTLdXnUztDPtyneqqKw6R7uxh+G6qWjeNynUsMgv6Ky/4
	 +BBQbafcCfoG/DxheVCOV17d3ZlWtNhMRHiANpgzC98i76rg4PlLsFWjBLzNXaK0q1
	 LIq1sCBTbPOVhCsCzc78671Rs/lupSMXjJc5c/TOvm/QpoSFNmLMjfV5GwUSmoPwL8
	 v+4kkRPYdQmCD6CAbiv5gC10IWoFL5NlQs58N9qyCeV/ss9CwjJoFhbzPBoQKaeWDD
	 CcSLRDiJ6IDPyE1F1BNQ9Vri76nIFwls1Pl4y+VBdIdIa8LUi1DCJq5pjfZS8cBOtj
	 HLkcPv/3V+04Q==
Date: Mon, 2 Sep 2024 16:10:44 +0100
From: Will Deacon <will@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>, ardb@kernel.org
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <20240902151043.GB11571@willie-the-truck>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
 <963afe11-fd48-4fe9-be70-2e202f836e34@linaro.org>
 <ZtW5meR5iLrkKErJ@zx2c4.com>
 <8390ac81-7774-4e67-9739-c2b98813d6da@csgroup.eu>
 <ZtW8zh8ED-oePxnw@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtW8zh8ED-oePxnw@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 02, 2024 at 03:25:34PM +0200, Jason A. Donenfeld wrote:
> On Mon, Sep 02, 2024 at 03:19:56PM +0200, Christophe Leroy wrote:
> > diff --git a/arch/powerpc/include/asm/mman.h 
> > b/arch/powerpc/include/asm/mman.h
> > index 17a77d47ed6d..42a51a993d94 100644
> > --- a/arch/powerpc/include/asm/mman.h
> > +++ b/arch/powerpc/include/asm/mman.h
> > @@ -6,7 +6,7 @@
> > 
> >   #include <uapi/asm/mman.h>
> > 
> > -#ifdef CONFIG_PPC64
> > +#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)
> > 
> >   #include <asm/cputable.h>
> >   #include <linux/mm.h>
> > 
> > So that the only thing that remains in arch/powerpc/include/asm/mman.h 
> > when building a VDSO is #include <uapi/asm/mman.h>
> > 
> > I got the idea from ARM64, they use something similar in their 
> > arch/arm64/include/asm/rwonce.h
> 
> That seems reasonable enough. Adhemerval - do you want to incorporate
> this solution for your v+1? And Will, is it okay to keep that as one
> patch, as Christophe has done, rather than splitting it, so the whole
> change is hermetic?

Yup, that makes sense to me (and the lib/vdso/getrandom.c change would go
away entirely).

Will

