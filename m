Return-Path: <linux-arch+bounces-7017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1E96C333
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F091F28314
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA41DEFC0;
	Wed,  4 Sep 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f4LITkDV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E62EB1D;
	Wed,  4 Sep 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465435; cv=none; b=Kg1PS+UviQjFQz5nUmzqgEk3uGiVepzuLMawOGfy7gEkf3LIkvyEc1Ma0yHHoWDxIBYhk+Wg01X/89vdFNIEdsqw5WwWF47YQY3JPglhSQodtna5O0d+2BEF0ggieprJ4v6Zwi/IndGCd0IU3Ak+liKFroQmcQvIFMTMIAqF+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465435; c=relaxed/simple;
	bh=OuJstXmmhPQb2jZgZwksVcJzh7A8LpSt4Q4ruXuVzhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuexRHI8APy33JW+jYZihqmJZX9x0P4UvWYPUkcQmt298+7LY0JzJ/3jGc3FQLtiGjOv4BI621rb3Befu6wVSX/7aKKNou+vr0qS8gJsn/rQlMXcUghQ/1/J7XVftxTdRzxYHqdyVpeELVDHXtnUENcnrMNyoABymhTQdxV5Hxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=f4LITkDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD66C4CEC5;
	Wed,  4 Sep 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f4LITkDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725465431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBwdR2a7BAhzFFVB/74X++jOLq9bBIog1Ujmiqru9oE=;
	b=f4LITkDViNIgDGuB/NkhAzVGWgioLpa5cL3cUq8a/rvlUfuVtfaloQeCo2sfD1Bsx8qGuK
	VHXXlXUhaLx9IeQY3C7UaY1jDLxXOuJHCGiPTho3GI2Qyue16UiWum058l/FURkmYCUV9X
	FwbtYCDAjht99h8yCZfbUTZP2SYYwH0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0bfd230d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 15:57:10 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277fa3de06fso1756873fac.0;
        Wed, 04 Sep 2024 08:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlmVe1m2lZF5e2wEqhF8PsrCZfy3GKcClSq1kgRim5c/1Lj3mVUISJQhnWTenzljeeFFdrC3OZ6wbx@vger.kernel.org, AJvYcCVqSIqvo0KN1rRbi1vZI00x1fPzAWrnYgW4pC8fCf885+BOxwB3ZDBvRejihjQXBYn3DbEEeteJXQDGEvXn@vger.kernel.org, AJvYcCW3trYDZBsKV+Mmbqvw1p5wh5yOrkyFE5hb0VpaG3rVQdsnHuHoeWo8mBGoyllNNPBQxfDBTxdJctjcpUHF@vger.kernel.org
X-Gm-Message-State: AOJu0YztvfJ9yl5baFG+Jgqk0mi4vZcohPPKsPqm0VvsJPW/Zg1krhBI
	Fmw+MpEn7DIWuPR2re/qOZ8uQ0YDGe67yFHzUcaQVp8Zq9nlgohxO8fAZT0Va5sFtdJmMwv5DGs
	X/8a5zLZuhZK180DGGKoK80bYNAQ=
X-Google-Smtp-Source: AGHT+IHBhiVcNWAm8Y1NrMFmyKfCw/qLNF6EtqPuxz6eKXBErHDbg+7JyIv4/u2h6ldPmVyqXn1UEbswzjWtDV5IZZM=
X-Received: by 2002:a05:6870:a98d:b0:261:164e:d12a with SMTP id
 586e51a60fabf-27810c10e2cmr7992814fac.22.1725465428859; Wed, 04 Sep 2024
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
 <20240904120504.GB13550@willie-the-truck> <CAMj1kXHsfmaydb+RCxA1rJPs9K8o4y8LSMTO8sMH-pmAwrZ6PA@mail.gmail.com>
 <ZthmZrDUcau5Ebc6@zx2c4.com> <20240904150254.GA13919@willie-the-truck>
In-Reply-To: <20240904150254.GA13919@willie-the-truck>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 4 Sep 2024 17:56:57 +0200
X-Gmail-Original-Message-ID: <CAHmME9p5hLPcW1Us8+wHToGafHqaCbRJVYFV0nCjidk1SZX-TQ@mail.gmail.com>
Message-ID: <CAHmME9p5hLPcW1Us8+wHToGafHqaCbRJVYFV0nCjidk1SZX-TQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm64: Implement getrandom() in vDSO
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Eric Biggers <ebiggers@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:03=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 04, 2024 at 03:53:42PM +0200, Jason A. Donenfeld wrote:
> > On Wed, Sep 04, 2024 at 02:28:32PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 4 Sept 2024 at 14:05, Will Deacon <will@kernel.org> wrote:
> > > >
> > > > +Ard as he had helpful comments on the previous version.
> > > >
> > >
> > > Thanks for the cc
> > >
> > > > On Tue, Sep 03, 2024 at 12:09:15PM +0000, Adhemerval Zanella wrote:
> > > > > Implement stack-less ChaCha20 and wire it with the generic vDSO
> > > > > getrandom code.  The first patch is Mark's fix to the alternative=
s
> > > > > system in the vDSO, while the the second is the actual vDSO work.
> > > > >
> > > > > Changes from v4:
> > > > > - Improve BE handling.
> > > > >
> > > > > Changes from v3:
> > > > > - Use alternative_has_cap_likely instead of ALTERNATIVE.
> > > > > - Header/include and comment fixups.
> > > > >
> > > > > Changes from v2:
> > > > > - Refactor Makefile to use same flags for vgettimeofday and
> > > > >   vgetrandom.
> > > > > - Removed rodata usage and fixed BE on vgetrandom-chacha.S.
> > > > >
> > > > > Changes from v1:
> > > > > - Fixed style issues and typos.
> > > > > - Added fallback for systems without NEON support.
> > > > > - Avoid use of non-volatile vector registers in neon chacha20.
> > > > > - Use c-getrandom-y for vgetrandom.c.
> > > > > - Fixed TIMENS vdso_rnd_data access.
> > > > >
> > > > > Adhemerval Zanella (1):
> > > > >   arm64: vdso: wire up getrandom() vDSO implementation
> > > > >
> > > > > Mark Rutland (1):
> > > > >   arm64: alternative: make alternative_has_cap_likely() VDSO comp=
atible
> > > > >
> > >
> > > This looks ok to me now
> > >
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Great. Thanks a bunch for your reviews, Ard.
> >
> > Will, if you want to Ack this, I'll queue it up with the other getrando=
m
> > vDSO patches for 6.12.
>
> I won't pretend to have reviewed the chacha asm, but the rest of it looks
> good to me. Thanks!
>
> Acked-by: Will Deacon <will@kernel.org>

All applied. Thanks for the patches, Adhemerval.

Jason

