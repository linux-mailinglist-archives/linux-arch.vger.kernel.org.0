Return-Path: <linux-arch+bounces-11751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C5AA40FF
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 04:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D29A4DA1
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767C1494D8;
	Wed, 30 Apr 2025 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKbKJ7nI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7F288CC;
	Wed, 30 Apr 2025 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745980732; cv=none; b=eLNiRdbyTfb99q0uqNOyaoT6N/xE0dp5d0EWjYfEQF3sfyUD3w8+fUgW0MAtYHsVIQWd76uJ4m766QgVIHUVsm89ss/3sHNkdUuMgAKJu9Sj9OSqutaR72ferfp1U5odmdM4H9NsvPO3ZoCcFVZ6q6AIybNQliEkT8VMpNzteNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745980732; c=relaxed/simple;
	bh=TxucFTFDsaAfXHIM/UmDu7tlSHNslTip/1/i68IYLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaakxoSm2uxoeV8S5sxJwBjdn4drD2/zctq8L6wyUVPw1yCD2ojdxj7o4zWioL0btHC2lUc9rvFnPlT4ZAVkJLpz56c8b/0KPilMA6TOigX5r446h592kPleAKOahyMN8W2PBoY0GYq9cZR5Zum8ZRZ5q7ffU0NphhsKoeuAT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKbKJ7nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05435C4CEE3;
	Wed, 30 Apr 2025 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745980731;
	bh=TxucFTFDsaAfXHIM/UmDu7tlSHNslTip/1/i68IYLNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKbKJ7nIpStk8OVO+UghSaA/PHyCumrXyBYGMhec+zz6zGnR725ui8YU/d2He5FZH
	 l3ZysS7wQNq2XykORQq3s6X96GzzDVMLzqg6xRB5oJgw8D/zjnr70FZaqFzpxo/ux6
	 slCd0ewtZDB+TImi79ATUnbFJj1sgEXGWWW0acjg+O3tQjOUW+BcbpUUPzocAdj7Wk
	 bf3XVBXfA5+WHNpc7JRkd7HigULuV18BqxGLAsXHYHc0FuMwOxf5OyajzjpK9zNSxR
	 ZbplbfUya7mHSj39ujX+ycEmi0q7WWaUSaSesTjTADwli278a+F9qyBiH7pdqlnuWf
	 klgtVgYRokWjQ==
Date: Tue, 29 Apr 2025 19:38:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v3 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <20250430023849.GA275186@sol.localdomain>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
 <20250429165749.GC1743@sol.localdomain>
 <aBGKg5bq0zLkhy3-@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBGKg5bq0zLkhy3-@gondor.apana.org.au>

On Wed, Apr 30, 2025 at 10:27:15AM +0800, Herbert Xu wrote:
> On Tue, Apr 29, 2025 at 09:57:49AM -0700, Eric Biggers wrote:
> >
> > To be clear, the objections I have on your v2 patchset still hold.  Your
> > unsolicited changes to my patches add unnecessary complexity and redundancy,
> > make the crypto_shash API even harder to use correctly, and also break the build
> > for several architectures.  If you're going to again use your maintainer
> > privileges to push these out anyway over my objections, I'd appreciate it if you
> > at least made your dubious changes as incremental patches using your own
> > authorship so that they can be properly reviewed/blamed.
> 
> Well the main problem is that your patch introduces a regression
> in the shash sha256 code by making its export format differ from
> other shash sha256 implementations (e.g., padlock-sha).
> 
> So your first patch cannot stand as is.  What I could do is split up
> the first patch so that the lib/crypto sha stuff goes in by itself
> followed by a separate patch replacing the crypto/sha256 code.
> 
> > Please also note that I've sent a v4 which fixes the one real issue that my v1
> > patchset had: https://lore.kernel.org/r/20250428170040.423825-1-ebiggers@kernel.org
> 
> Yes I've seen it but it still has the same issue of changing the
> shash sha256 export format.

Nothing requires that the export formats be consistent, but also the fact that
padlock-sha uses a weird format in the first place is an artificial problem that
you introduced just a couple weeks ago.  And even if we *must* use the same
format as padlock-sha, that can be done by using your crypto_sha256_export_lib
and crypto_sha256_import_lib, without all your other changes.

- Eric

