Return-Path: <linux-arch+bounces-11600-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD8A9D9A1
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBAB7B083F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210852367A1;
	Sat, 26 Apr 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bpo8Q55o"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB31C36;
	Sat, 26 Apr 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745658664; cv=none; b=Hx0ZfeRzySsl5PQMhC46eED9/qQTY6CPt429zFLpvESW4kwQ1JKCLqxgWeMSaSzTeKrhT7L5GTcOErAWSvVqeizic2EOKXCPLSYHqcGEwGkrLE4ro/ILg2Byw+uv2d9CCeUI1n18CPYcLnnPRfk2vXlfXsnu05LV+BPmpFqKBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745658664; c=relaxed/simple;
	bh=FtQjZM5OpR8eTj/Tk+/peoGkalxU+ZbYVlDYxiH1EPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGCwaDzMuM4OhJRae3ePQ10AssO6K13f7CVBDjX+6NAy83WZ7pcXLFLa5APuauNl4QRjPGBd/DkHQhgjF2kx/vjT1eKtXtrxYETD2CtEx3xdarsdH4C6L3rXoO8LGw6prIz1eJOryeo5fK8rs8BDkY6NbQVB0JQHlkehkoB354U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bpo8Q55o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F766C4CEE2;
	Sat, 26 Apr 2025 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745658663;
	bh=FtQjZM5OpR8eTj/Tk+/peoGkalxU+ZbYVlDYxiH1EPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bpo8Q55o67h7IwV7XIqnLMwJzS5hk0JlwLkWShp8X/AuNAuzFZIGLbhEhwmORDQll
	 utyYeCKtBH02BDpXzFi5Q1FKvNhyPsZBt461UT/aAjxLE4OiGapNZriDHHI8l+7QXr
	 n9eotkJikcjBuB5HJJspSA4xt66VwS5Fo+237shW5zLiSgUeEOqQVBAqBD1KGKoxqD
	 moj7nfOPSMrCmLKbKDLYqEowYy+npb3+2hA2IE87vcQa2omMyyLmyXIFr7iaKWGtR4
	 336OAdWEBAX7Zrbd0jqsolxYv5QUou7cyANxX79PsDPK/IGBihIfL/m1APtOMPUOki
	 +UAtUVW0IVm+A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-310447fe59aso34978481fa.0;
        Sat, 26 Apr 2025 02:11:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVXcg2H3aO/JsKChBj/Ciz6dzj9fF3JbFbTQlyMZbWFw1zGtH4bZ3vI7uSRs6JtKRlNNcIFumKacwFlAbL@vger.kernel.org, AJvYcCUbIOkyGUNUbYDccaYtZSPFbIyLZD07ays472zI6L71K+79I5sgQzwvk4hv0Z++DIksv/zqmoxmzsp4Lg==@vger.kernel.org, AJvYcCV8MbfkuudArvIMO77e0xet8FcPNmXJH+AuNf6+tzbVN8IFYl4a52Nys7eD12d6NlMQ9iwE0COQv9GTvQ==@vger.kernel.org, AJvYcCVze77QoYm8t5ch0Gj6ppTcN2NY9jUUCEjBJzSGVHON6hDEE+D5W1x5WsUPI+FVooPn0kdSxqjcgh/bMA==@vger.kernel.org, AJvYcCX9ki7npoaarmMGKorsoXM6y3z/DbvPYzm8YWotznm+y0iVijzd8WqtX2EEoSlyNXg6MSviQHwQN/jg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DTEqIl66ty9q/W21YiArKAb4X3mCBVtmoBk2yNz9NXvUfXQT
	jvLnORbXPKZwMAzrklqPbzBoMrRW0AN6DKVcdYFKy7hKYlWJIQleL2xFqLr2riCxwbdQv0nZkJC
	iLt16FazptJXWNNg5ib+ViH54Q4A=
X-Google-Smtp-Source: AGHT+IHLH5VeWV0U4iLUEk8k7RFRILjWBSdawBeD90fjLlL8DQGJ5x0W8iCulQNonT8aL01WrKimT1BHnCLrasm95sk=
X-Received: by 2002:a2e:a5c9:0:b0:30b:bba5:ac18 with SMTP id
 38308e7fff4ca-31905b6a5f0mr15804561fa.3.1745658661713; Sat, 26 Apr 2025
 02:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426065041.1551914-1-ebiggers@kernel.org> <20250426065041.1551914-3-ebiggers@kernel.org>
In-Reply-To: <20250426065041.1551914-3-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 26 Apr 2025 11:10:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+stJai+pQqAL7QwZHXV2a-hP4jjQKH7O2cBm1GK2aOA@mail.gmail.com>
X-Gm-Features: ATxdqUFDuzRMzSvvkZhhFNt-cqI-JOG2ysnGNbi6gxycTT7GyUoo4km_JN24bFc
Message-ID: <CAMj1kXG+stJai+pQqAL7QwZHXV2a-hP4jjQKH7O2cBm1GK2aOA@mail.gmail.com>
Subject: Re: [PATCH 02/13] crypto: arm/sha256 - implement library instead of shash
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
> To merge the scalar, NEON, and CE code all into one module cleanly, add
> !CPU_V7M as a direct dependency of the CE code.  Previously, !CPU_V7M
> was only a direct dependency of the scalar and NEON code.  The result is
> still the same because CPU_V7M implies !KERNEL_MODE_NEON, so !CPU_V7M
> was already an indirect dependency of the CE code.
>
> To match sha256_blocks_arch(), change the type of the nblocks parameter
> of the assembly functions from int to size_t.  The assembly functions
> actually already treated it as size_t.
>
> While renaming the assembly files, also fix the naming quirk where
> "sha2" meant sha256.  (SHA-512 is also part of SHA-2.)
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/arm/configs/exynos_defconfig             |   1 -
>  arch/arm/configs/milbeaut_m10v_defconfig      |   1 -
>  arch/arm/configs/multi_v7_defconfig           |   1 -
>  arch/arm/configs/omap2plus_defconfig          |   1 -
>  arch/arm/configs/pxa_defconfig                |   1 -
>  arch/arm/crypto/Kconfig                       |  21 ----
>  arch/arm/crypto/Makefile                      |   8 +-
>  arch/arm/crypto/sha2-ce-glue.c                |  87 --------------
>  arch/arm/crypto/sha256_glue.c                 | 107 ------------------
>  arch/arm/crypto/sha256_glue.h                 |   9 --
>  arch/arm/crypto/sha256_neon_glue.c            |  75 ------------
>  arch/arm/lib/crypto/.gitignore                |   1 +
>  arch/arm/lib/crypto/Kconfig                   |   6 +
>  arch/arm/lib/crypto/Makefile                  |   8 +-
>  arch/arm/{ => lib}/crypto/sha256-armv4.pl     |   0
>  .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  10 +-
>  arch/arm/lib/crypto/sha256.c                  |  64 +++++++++++
>  17 files changed, 84 insertions(+), 317 deletions(-)
>  delete mode 100644 arch/arm/crypto/sha2-ce-glue.c
>  delete mode 100644 arch/arm/crypto/sha256_glue.c
>  delete mode 100644 arch/arm/crypto/sha256_glue.h
>  delete mode 100644 arch/arm/crypto/sha256_neon_glue.c
>  rename arch/arm/{ => lib}/crypto/sha256-armv4.pl (100%)
>  rename arch/arm/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (91%)
>  create mode 100644 arch/arm/lib/crypto/sha256.c
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

