Return-Path: <linux-arch+bounces-9140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF29D2CE5
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87493283917
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75D1D1E69;
	Tue, 19 Nov 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2UCjFOf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA901CF7B7;
	Tue, 19 Nov 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038407; cv=none; b=E1MJWFDtKi2VzQXZOA0OaO1l4wWHgWJW+feLxtF24FJMMaalU+beVJIGCG4hop6FQx9p5ruKHd1AU8OV3rYeaMHlxyc97hxVBghuPF+PVNjms5lct8xD2WEnYGHTmNJ1cnGy6SLnHlMgi6QzZfS87y5jFmCUNISpAmdiJmjpNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038407; c=relaxed/simple;
	bh=cGtCgxtTHF3Jbl8CduYT2IKTHC6lkZmDimREyxkO6Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8foyHb4z3jxnnrAUKc+HtEAQ4w456UxPQn3ivMd+Qt3zMSqb9eUIySAPViDvAgkEIriPuc+baBVPEoris4oPC+jlDNUdg5CFWGnQ7H9LF8ft4pQh/ucpLRM7xYXmT8awnBU9diNjxPxaqPY3juP/p4WqsvvHUICdkqfzzHiDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2UCjFOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF441C4CECF;
	Tue, 19 Nov 2024 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038407;
	bh=cGtCgxtTHF3Jbl8CduYT2IKTHC6lkZmDimREyxkO6Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2UCjFOf9RDujcsGXFkSgILPdDp2C8acwBMEtyau482WWnyiXTsgmeQk5nVGwjo1i
	 610w9HbKzBJMpKfxwrf/myk3hq5iWjkdG2poBltU2rXucE7Xkk3rR59lH3G60wwYVt
	 DoeV5kC3wKpi1dEUEWjZcuPKznWSEVjOlOyuVVQ43WKHAEaB8Qn4idItnNDyvR38YN
	 XUlL2+henqEhFtNCJSmOZuhsMzCztdQLbZyaHXZFYBVc2I3L2Y/19wCfOFzdzAxiKD
	 4kr/eGdcGRTVfAdDdOFDy7Fk89GN7FgH35PyStCaqETmgVhl0qGiTnX5ZP8h4g1uTi
	 x2rH1JZld25Qw==
Date: Tue, 19 Nov 2024 17:46:45 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>
Subject: Re: [PATCH 00/11] Wire up CRC-T10DIF library functions to
 arch-optimized code
Message-ID: <20241119174645.GA3833976@google.com>
References: <20241117002244.105200-1-ebiggers@kernel.org>
 <CAMj1kXFA15AuT5wd0vMJ3X94uysvnGLy42FAQt8fxJsW31UdAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFA15AuT5wd0vMJ3X94uysvnGLy42FAQt8fxJsW31UdAg@mail.gmail.com>

On Tue, Nov 19, 2024 at 09:59:53AM +0100, Ard Biesheuvel wrote:
> > Eric Biggers (11):
> >   lib/crc-t10dif: stop wrapping the crypto API
> >   lib/crc-t10dif: add support for arch overrides
> >   crypto: crct10dif - expose arch-optimized lib function
> >   x86/crc-t10dif: expose CRC-T10DIF function through lib
> >   arm/crc-t10dif: expose CRC-T10DIF function through lib
> >   arm64/crc-t10dif: expose CRC-T10DIF function through lib
> >   powerpc/crc-t10dif: expose CRC-T10DIF function through lib
> >   lib/crc_kunit.c: add KUnit test suite for CRC library functions
> >   lib/crc32test: delete obsolete crc32test.c
> >   powerpc/crc: delete obsolete crc-vpmsum_test.c
> >   MAINTAINERS: add entry for CRC library
> >
> 
> Nice work. The shash API glue was particularly nasty, so good riddance.
> 
> For the series,
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Happy to take a R: or M: as well, if you need the help.

Thanks Ard.  I will add an R: entry for you in MAINTAINERS.

- Eric

