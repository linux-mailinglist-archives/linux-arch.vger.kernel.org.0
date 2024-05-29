Return-Path: <linux-arch+bounces-4606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B08D3B8A
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B221C2372F
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2C181BB3;
	Wed, 29 May 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSkDCEhl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9D180A92;
	Wed, 29 May 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998272; cv=none; b=lb3nT1rB32hvcXskbA30Tea/7ieYoQ5tRqQA2aoO+9s3IaM1GpiVCPz0c4FFp4dXqfkkYC+OrMDZ9OKD+mVX+ImodoGOdjpPtX3YLY98+BiTz5B+V6iitdUArLuXtvha8fTUzNXIyd33AesrqsijLz0j/55m/kNUuAGhpPWGA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998272; c=relaxed/simple;
	bh=OYSSBejeV+h0PVcSSif4AfjAaQ8JCT/Hva0H2R4ia90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrc0FlSU3ULbK8a7Vzm5JdiR8fHN3Qck0ANh95CPypT7uP8vd3c2A7vj1EiMonCBhewQQ/36RUPXPPYP37SGXq8jTsJsI3cQTJVu0/rMD0FmBuVP/dEOkZZqIeEkH08n7/NVuFAIusgH8IPOBRjYMBFMkdGtgIzstCvmeAw6yjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSkDCEhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D28C113CC;
	Wed, 29 May 2024 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716998272;
	bh=OYSSBejeV+h0PVcSSif4AfjAaQ8JCT/Hva0H2R4ia90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSkDCEhlOxLXGm6lJ/xoOCrEOygETBWQSbf75n62dS1s2Znq+1O1leoHDMz2n2aZk
	 agVKmRJJ+TdsUTHtlgUe8urgEhUmDs6OE3FwnBJViKwQOVA6VRXdXqYVBVDd+aoRiR
	 ie2zuSz4gC2mFjUrRRir6eXQlSJlDv1CPcD0yB3FbF8bKgGbc/JrSLzyNwvyYL6al9
	 FGXEPjua7QhBRIwnCkWXHvAfxZs6hnORKrEEk87UtZP+a/Jr90ZSkmsmMrCYIiAJok
	 TxLpSBzzFbrm0nDz6dPk4rj6tG/y7kf+Gr/uEVJHKj37mtRjYpShMY1t02dDLGCcwJ
	 x0v3CQgkSBqjA==
Date: Wed, 29 May 2024 08:57:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240529155749.GA1339768@thelio-3990X>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com>
 <20240528193110.GA2196855@thelio-3990X>
 <CAHVXubjYVjOH8RKaF1h=iogO3xBM6k+xrGwkPnc-md2oRxbxrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVXubjYVjOH8RKaF1h=iogO3xBM6k+xrGwkPnc-md2oRxbxrQ@mail.gmail.com>

On Wed, May 29, 2024 at 02:49:58PM +0200, Alexandre Ghiti wrote:
> Then I missed that, I should have checked the generated code. Is the
> extension version "1p0" in '-march=' only required for experimental
> extensions?

I think so, if my understanding of the message is correct.

> But from Conor comment here [1], we should not enable extensions that
> are only experimental. In that case, we should be good with this.
> 
> [1] https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/T/#mefb283477bce852f3713cbbb4ff002252281c9d5

Yeah, I tend to agree with Conor on that front. I had not noticed that
part of the message when I was looking at other parts of this thread. I
could see an argument for allowing experimental extensions for
qualification purposes but I think it does create a bit of a support
nightmare, especially when there are breaking changes across revisions.

> > config EXPERIMENTAL_EXTENSIONS
> >     bool
> >
> > config TOOLCHAIN_HAS_ZABHA
> >     def_bool y
> >     select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG
> >     ...
> >
> > config TOOLCHAIN_HAS_ZACAS
> >     def_bool_y
> >     # ZACAS was experimental until Clang 19: https://github.com/llvm/llvm-project/commit/95aab69c109adf29e183090c25dc95c773215746
> >     select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG && CLANG_VERSION < 190000
> >     ...
> >
> > Then in the Makefile:
> >
> > ifdef CONFIG_EXPERIMENTAL_EXTENSIONS
> > KBUILD_AFLAGS += -menable-experimental-extensions
> > KBUILD_CFLAGS += -menable-experimental-extensions
> > endif

Perhaps with that in mind, maybe EXPERIMENTAL_EXTENSIONS (or whatever)
should be a user selectable option and the TOOLCHAIN values depend on it
when the user has a clang version that does not support the ratified
version.

> That's a good idea to me, let's see what Conor thinks [2]
> 
> [2] https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/T/#m1d798dfc4c27e5b6d9e14117d81b577ace123322

FWIW, I think your plan of removing support for the experimental version
of the extension and pushing to remove the experimental status in LLVM
(especially since it seems like it is ratified like zacas?
https://jira.riscv.org/browse/RVS-1685) is probably the best thing going
forward. If the LLVM folks are made aware soon, it should be easy to get
that change into clang-19, which is branching at the end of July I
believe.

> Thanks for your thorough review!

Thanks for taking LLVM support into consideration :)

Cheers,
Nathan

