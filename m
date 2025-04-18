Return-Path: <linux-arch+bounces-11450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2521CA9388B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D41A7AAC3B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CC194137;
	Fri, 18 Apr 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRV/mjio"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26951487ED;
	Fri, 18 Apr 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985972; cv=none; b=hhpB68ucaIcfQRJOEdZYY5qM0rUEQHxZYy/IYQQuQdlXm+WKz9hrsHIKLwlB7NkKgAczWYPjRrp6/BODxUxf+Cf2TAY+TsNLDcYjT82CsJKLXQDskVoLviEsUYbWar8OE8D8yRBRRW6lHrACwmwH6ubE57Dg7/XuGoe0ILpUgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985972; c=relaxed/simple;
	bh=om+Vna/2GFvSm09tdyvQMrH5gELgac15SstCZnvcK14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQv6Fge8LkDTIUffMw6dYfoNbG9yr19cTM0Gta89booGMwvCbfLAOfaqC9hgsPllUYw+d9HYCFR/1wTffkFSqbxdJPrABtNDwLWeKBmqNdiuDKliV/w6hfbkUvh+sMKwvESzJo7Zm/1Vias2bPzaIIlOSeYWuJ9XbpUjnpQWW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRV/mjio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414BEC4CEEA;
	Fri, 18 Apr 2025 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744985972;
	bh=om+Vna/2GFvSm09tdyvQMrH5gELgac15SstCZnvcK14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RRV/mjioS01PV47nXvZ0TWue3NIWYz4g3TvMtcGSc9SzDjv5ENiZxjjzbX9r29B3r
	 9/rQJy4n6bGeoy4ykbB+W4/4F7W0D3C9D3cINHvpgD0y02oiSDkrEm5G7Vf1UOSJNB
	 RQpnb5utZNxuqYFRuG86JaRbyR2LQdUMJyr2qEc11qUB69jHurGTthMhKqWn9Y9PcS
	 Nzl/cYyfucM8in2jji8Q98Ls2NeNC3pWDwx+RpeSSgWLOWSWmRB1nmRVItasiBs5Oy
	 j4ge2AaFjDu59Ljk0ccoDDlfXsh5ZyrSwgoTZOaXCcDebHhf0VadkqEJMQ5k7pZQjU
	 NX/2hSLrgVIsw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3105ef2a071so21961491fa.1;
        Fri, 18 Apr 2025 07:19:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVp4UC+YuEDsiLkc5QGM0Xq7Q35UhIJN1wbHHTK57rDyph7TaE4m6sLulS0j+jiQDocGXU4gFQjLvZuQ==@vger.kernel.org, AJvYcCUXV9sKSd7ol6ae6L5M+0pPz/LzrlI7VXRkZWis66TL5jUru3VbAcZLoBjAMoA/mVwZO1o0q74EOhfF6Q==@vger.kernel.org, AJvYcCUppSRACChUj6dwUIc2gwyerFR3zxt7hCX1F2a4W857V+lldOhg+qVqHLEr2cWLSrwDykuEv0O37/uU@vger.kernel.org, AJvYcCVbAiWIMJtr7I8rwJbwogEgXIzCKeSAYLzObkMdosjwEhQF1y+zHSpqs/H+tXc6nS9Wd6TW10es1JvbuQ==@vger.kernel.org, AJvYcCWmJ3HSGQVELiXK8XdsjPHRM2Fnf9eb+Q6cGGPL9fvCBOGDKiBwQaDRTGy8IiYMw3ynJ4i42qb+MmOiAxPg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FU1CrVeqm/wh6U+osyS2q1L45ugmt7Cxq9BjEo+88RlMCi5D
	lBmna4Kjew54EN0ABwLQtQBC1W6VcjrsasXEX6npqLfozWa7qL8aIRHsqSDJDwfHpT71MIHsuaA
	ynonMhDCei8V8wsFDHRYzu/w+4NQ=
X-Google-Smtp-Source: AGHT+IFnh+q+URrFYgeso0knkjqFFZnTfGmXzWjvKWHdUWW3YHckdLRG/cd76/RqwZUrPe+JG12yfp7YED1LQQgVI5I=
X-Received: by 2002:a05:651c:241:b0:310:779b:9ef1 with SMTP id
 38308e7fff4ca-310904d4972mr9346751fa.13.1744985970634; Fri, 18 Apr 2025
 07:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417182623.67808-1-ebiggers@kernel.org>
In-Reply-To: <20250417182623.67808-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Apr 2025 16:19:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4T4p7iCkfo=4RoMeU4sHh47EZyBUSdWv7HTqdAY2oCA@mail.gmail.com>
X-Gm-Features: ATxdqUG3NGrAHvWSlyQ9Wx2CgTU0VxdHzlcc8yhyIdwCb_viAAYGMbAHFukqzA8
Message-ID: <CAMj1kXE4T4p7iCkfo=4RoMeU4sHh47EZyBUSdWv7HTqdAY2oCA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Finish disentangling ChaCha, Poly1305, and BLAKE2s
 from CRYPTO
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 20:27, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series removes the unnecessary dependency of the ChaCha, Poly1305,
> and BLAKE2s library functions on the generic crypto infrastructure, i.e.
> CONFIG_CRYPTO.  To do this, it moves arch/*/crypto/Kconfig from a
> submenu of crypto/Kconfig to a submenu of arch/*/Kconfig, then re-adds
> the CRYPTO dependency to the symbols that actually need it.
>
> Patches 14-15 then simplify the ChaCha and Poly1305 symbols by removing
> the unneeded "internal" symbols.
>
> Note that Curve25519 is still entangled.  Later patches will fix that.
>
> Eric Biggers (15):
>   crypto: arm - remove CRYPTO dependency of library functions
>   crypto: arm64 - drop redundant dependencies on ARM64
>   crypto: arm64 - remove CRYPTO dependency of library functions
>   crypto: loongarch - source arch/loongarch/crypto/Kconfig without
>     CRYPTO
>   crypto: mips - remove CRYPTO dependency of library functions
>   crypto: powerpc - drop redundant dependencies on PPC
>   crypto: powerpc - remove CRYPTO dependency of library functions
>   crypto: riscv - remove CRYPTO dependency of library functions
>   crypto: s390 - drop redundant dependencies on S390
>   crypto: s390 - remove CRYPTO dependency of library functions
>   crypto: sparc - source arch/sparc/crypto/Kconfig without CRYPTO
>   crypto: x86 - drop redundant dependencies on X86
>   crypto: x86 - remove CRYPTO dependency of library functions
>   crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
>   crypto: lib/poly1305 - remove INTERNAL symbol and selection of CRYPTO
>

This seems like a good idea.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

