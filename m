Return-Path: <linux-arch+bounces-11598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E7A9D98B
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D444A832C
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0724E00F;
	Sat, 26 Apr 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYe4NFoq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF6224226;
	Sat, 26 Apr 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745658452; cv=none; b=khw+kr4wZc6h3esOO0whKDHDOy/t0Eifj+evLt/cNdT9GbuUhwDiccmPgvL8Q4p9nafsnp58qJc5DCZpM4bSR23Npy/cYbuziXdVl7W5rP571bptFfsIlOjz077QG+FQu+iG7Sgmli1J2E6xH68bVDeo+nJ2Is8D899noOrzMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745658452; c=relaxed/simple;
	bh=buxmpgDAU4rRbUrUPrakdwPyAA4SBheAoAn/RaFjaNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8ssCKRmnSTQDBNQ1EsvMR1n1VmdzHHFpFAWTtq8wPCP61n1Bg244F00o70OT98P83Fg3OO/67rLH+pHgZaJK+pBztLh/LlqfdITPc0le1Tmf7yXas6xjR8CHGuJm0+bq5Za5TTdbk/3kS0OZrvypzdNsRTx6JUtkHX+1QjVjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYe4NFoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52ABC4CEE8;
	Sat, 26 Apr 2025 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745658451;
	bh=buxmpgDAU4rRbUrUPrakdwPyAA4SBheAoAn/RaFjaNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iYe4NFoqbzJakUpL2a1Z/LN3jzqaUq3m6wX0mgOsNE5ArZ4gofJSd8kuzzJT3onf0
	 AMZpNsMuzVXzozYox/DJP43JL4hqOFx+ePjSNd3izsSNh1nZM2FRWCce5N6SJ6mB8q
	 g7jWvIAsVsfdLVGGw3mtHpy2kkervKAITav/mDRs9sjA/BD31/hfiINg1qSF3yPh8H
	 ggkYKUwDEZR/B3U6IXkxzVGkg5keeio1nepI5b33Wx12arJP1JxFTE8Ji+/Mw+Ixih
	 YYPIbYNHWO2BtHIzeqkjvEn6Pn3QzfwLsMOL0L1MvDR7qPjgaPEak/fMXmQ8o+hqds
	 ckFe2FpwoO/gQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54e816aeca6so2617606e87.2;
        Sat, 26 Apr 2025 02:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUe8m9L8XIQwllSaRrtKSoGj0fhLEyvT/g3ZR/wXwHqxvoqB+EeLrM5Z46YH/zIQ7UNqO3IF1qFBybiWA==@vger.kernel.org, AJvYcCWbUwCSUyR5rDP8pxn2C8S+iDO9AlkyV0FSU6znwJQE9guXUjBHwBy99o0i63OyKdgxxjdzB9hih712+A==@vger.kernel.org, AJvYcCWiNpNJJPUmS5b+28jAoTyCRyQdNpUqGU/Av44vBVJNJFXsRESyr48qB+D1V6RpEB2CDfmGtIesM6o9Gw==@vger.kernel.org, AJvYcCXD3CNZ+Xb4C5b6wWPPB8JOep9eib+2H+xofrZQ1SQPfP4adT7UigAELNIZwVyGBaiQMSriv7rIg/KqKNsc@vger.kernel.org, AJvYcCXHgfuaTW2BhD4CH6rXh4EnYrwz3oriVygcL73PJAWxwCB0duwmimrmlL+KYYvSAtZkhtjdwivx0x1S@vger.kernel.org
X-Gm-Message-State: AOJu0YxyojykAfYixZtKBOo8YqevBWjIebuNKxyx2Rog9Mkt0zcxr3kW
	VlaTgJXv/hA2dyGMulnyP6PP88w9HCsjqc6vppThnOxyeI6LG49jaKAfO8lhESnl70ptRAp7EfO
	c4Ny/g4llN7VaS8awEjPWtsOyAk8=
X-Google-Smtp-Source: AGHT+IGJ8kVblFjzzc4iKrNwvB8Li0uKGxlh3w81ehqTxUdVSkCQSygCbDPyUqy8FGBbbYlDPRasDsnkAI7N2GRBzdk=
X-Received: by 2002:a05:6512:308c:b0:54e:81ec:2c83 with SMTP id
 2adb3069b0e04-54e8cbd5977mr1469007e87.18.1745658450215; Sat, 26 Apr 2025
 02:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426065041.1551914-1-ebiggers@kernel.org> <20250426065041.1551914-5-ebiggers@kernel.org>
In-Reply-To: <20250426065041.1551914-5-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 26 Apr 2025 11:07:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE1BKGspnSmqFJkqLCMMT+j=ZHEngKqcdOJsQ-LkyQdMg@mail.gmail.com>
X-Gm-Features: ATxdqUGaw6rq_tP-WceTvDry4j7gdc2ygQ9IvUcCsDooEKyi9c3QpD_gnY-Uz9Q
Message-ID: <CAMj1kXE1BKGspnSmqFJkqLCMMT+j=ZHEngKqcdOJsQ-LkyQdMg@mail.gmail.com>
Subject: Re: [PATCH 04/13] crypto: arm64/sha256 - implement library instead of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Apr 2025 at 08:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Instead of providing crypto_shash algorithms for the arch-optimized
> SHA-256 code, instead implement the SHA-256 library.  This is much
> simpler, it makes the SHA-256 library functions be arch-optimized, and
> it fixes the longstanding issue where the arch-optimized SHA-256 was
> disabled by default.  SHA-256 still remains available through
> crypto_shash, but individual architectures no longer need to handle it.
>
> Remove support for SHA-256 finalization from the ARMv8 CE assembly code,
> since the library does not yet support architecture-specific overrides
> of the finalization.  (Support for that has been omitted for now, for
> simplicity and because usually it isn't performance-critical.)
>

This is fine - when I added this, kernel mode neon on arm64 would
eagerly preserve and restore the FP/SIMD state every time, but this is
no longer the case.


> To match sha256_blocks_arch(), change the type of the nblocks parameter
> of the assembly functions from int or 'unsigned int' to size_t.  Update
> the ARMv8 CE assembly function accordingly.  The scalar and NEON
> assembly functions actually already treated it as size_t.
>
> While renaming the assembly files, also fix the naming quirks where
> "sha2" meant sha256, and "sha512" meant both sha256 and sha512.
>

Good idea. Note that the ARM architecture's SHA2 extension only
supports SHA256 not SHA512 (which is a separate extension), so this is
where the confusion came from.


> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/arm64/configs/defconfig                  |   1 -
>  arch/arm64/crypto/Kconfig                     |  19 ---
>  arch/arm64/crypto/Makefile                    |  13 +-
>  arch/arm64/crypto/sha2-ce-glue.c              | 138 ----------------
>  arch/arm64/crypto/sha256-glue.c               | 156 ------------------
>  arch/arm64/lib/crypto/.gitignore              |   1 +
>  arch/arm64/lib/crypto/Kconfig                 |   5 +
>  arch/arm64/lib/crypto/Makefile                |   9 +-
>  .../crypto/sha2-armv8.pl}                     |   0
>  .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  36 +---
>  arch/arm64/lib/crypto/sha256.c                |  75 +++++++++
>  11 files changed, 98 insertions(+), 355 deletions(-)
>  delete mode 100644 arch/arm64/crypto/sha2-ce-glue.c
>  delete mode 100644 arch/arm64/crypto/sha256-glue.c
>  rename arch/arm64/{crypto/sha512-armv8.pl => lib/crypto/sha2-armv8.pl} (100%)
>  rename arch/arm64/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (80%)
>  create mode 100644 arch/arm64/lib/crypto/sha256.c
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

