Return-Path: <linux-arch+bounces-8576-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795839B1100
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 22:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08ABE1F21C5D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC1216212;
	Fri, 25 Oct 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gekfskCv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3236216208;
	Fri, 25 Oct 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889249; cv=none; b=BSmgGm6S4qZiuO8CmWRRcvt1HNpHQHmvwSfxvtXFurHEDqRBMdhzM51FoMhvxqImJAih+MFdkHYw0dHuvp93jQwlBwBM3OQ3NDizhESjXcirDXq2ntmalkYskjLysIE7GtiRxbajfNkiB41E9OL4GmdK8dJPFug2YO8p11Vse+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889249; c=relaxed/simple;
	bh=Tfo5X6uc3w/hrU+iP8PZcK2t41JlU/D+FAY3HHNYJHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uz0idFK0+FDYC1vKPUppdQdbUMKry4c59RLJq18PXK/28fNrA5SF2kJEN90R8i5ksZe6+4Av3NQ3p4qubcLzI8Bf1OOlZD9ghuCAoda05W0qX2akM2Ot+78jP9MydsxK1FrMpkuJgEDT8ZmYOSwiB1QS48LObS2nb+gRZGIV+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gekfskCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F185C4CECC;
	Fri, 25 Oct 2024 20:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729889248;
	bh=Tfo5X6uc3w/hrU+iP8PZcK2t41JlU/D+FAY3HHNYJHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gekfskCvWOfIqlAZ/aSuuXFxlPUBLAq/1J8u7BRk+K9IG78a6VWhRP79Fdow15YPf
	 44uCMphVFXEm62CFfo0bnfd3n1CW10JYtALJafsVUKuPU3z4maXZ5sT1Bb2UV9pycN
	 TGG3d8+d3WVZMhgB/k7H5BucarzeptU7ro6s0+7jd2rjHTv2j/nmLH6oV/WpNORUDA
	 xnh/zY6v5NxPpq11QA6EDyZllc/Y/OnW+6atxbqNYXt6wo/B0emCq9krojm4qbnglg
	 hOSv/XbGNEBeJM/x1STwgIFbH8+hKzyAcfr+T2d5ym7TYHf4gr/dfs1497Uiengm5Q
	 UWHjgLfRLSMlw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb58980711so23975541fa.0;
        Fri, 25 Oct 2024 13:47:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6+l7GF7hItrAUm2cgRn4knvPHZQvmh/rkMP8oCJkMNuO9xTm7Jq6XWqyrMubbiQ8FA+tdAgpS2dXfcQ==@vger.kernel.org, AJvYcCVSDjca1u8kA7A9ToqBJnM0IW8t/OKYuS7gcWTuLSI0BYiv6Mu7tgpdVBW/0xsNqn+1YJG7qaxKFezcCA==@vger.kernel.org, AJvYcCVwTglbP3ldzWMbP0E80XR1MGUwM22ER4isD3QSy5kdYAuUtVXKG8aixmRw0XMEDH2xgozPFWwzFggvNoq1@vger.kernel.org, AJvYcCW7dBrsHeYXNRIYN2pE39fmGoQea/3SAsnclBoJ0IfWGcLxV4rrO7ICMlhnqY2POecFPGFziLVMfdiO+w==@vger.kernel.org, AJvYcCWYC6gy3RhqMNUb08o8lE8/WJYdYfksaAadR+uincIvHtcE4worwqo55EGhhJi/br1DYcZI/qZUBnyiqw==@vger.kernel.org, AJvYcCWs776YWy7xtL4/Pidoo+1r5PLZ4Jq793bYNrEQO4tYeO4MZoQaNaLti166phnMRbLWTRi6c24mzQivTw==@vger.kernel.org, AJvYcCWy3D5vgZWWZSQ9KnQ59NFi94gpOPDGvaNBUKO4aRyHG95oWfjCwIazrxas/0RI/BEeUhpXcbh/C0ME@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6KcwbOQBrEPpAn9gf1pzTS00wkFrAnhnJRJfY/lE9C3lN3em
	F5lPK1c1O5/VeqSuOn7YvhazBPinNbs0GDnQwd13Ovk5ZijqffxFSLV3tcS2PulMBKbD+FKFekh
	KZSXd94sGyf2Wo8vYjPIKmlyaVZA=
X-Google-Smtp-Source: AGHT+IEp6Dx2HlT+U0iGzL8ulgjfv3Yq0fFTV7/qQsnbI5MKZCd6PlYP7CAgGzk4GX/wuTuxR8r9WXnoQ2sPlcjTw1A=
X-Received: by 2002:a05:651c:2123:b0:2fb:45cf:5eef with SMTP id
 38308e7fff4ca-2fcbe04dc90mr3314601fa.30.1729889246941; Fri, 25 Oct 2024
 13:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025191454.72616-1-ebiggers@kernel.org> <20241025191454.72616-5-ebiggers@kernel.org>
In-Reply-To: <20241025191454.72616-5-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 25 Oct 2024 22:47:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEsq7iJThqZ7WA00ei4m59vpC23wPM+Mrj9W+HXfk-aSg@mail.gmail.com>
Message-ID: <CAMj1kXEsq7iJThqZ7WA00ei4m59vpC23wPM+Mrj9W+HXfk-aSg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 21:15, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Instead of registering the crc32-$arch and crc32c-$arch algorithms if
> the arch-specific code was built, only register them when that code was
> built *and* is not falling back to the base implementation at runtime.
>
> This avoids confusing users like btrfs which checks the shash driver
> name to determine whether it is crc32c-generic.
>

I think we agree that 'generic' specifically means a C implementation
that is identical across all architectures, which is why I updated my
patch to export -arch instead of wrapping the C code in yet another
driver just for the fuzzing tests.

So why is this a problem? If no optimizations are available at
runtime, crc32-arch and crc32-generic are interchangeable, and so it
shouldn't matter whether you use one or the other.

You can infer from the driver name whether the C code is being used,
not whether or not the implementation is 'fast', and the btrfs hack is
already broken on arm64.

> (It would also make sense to change btrfs to test the crc32_optimization
> flags itself, so that it doesn't have to use the weird hack of parsing
> the driver name.  This change still makes sense either way though.)
>

Indeed. That hack is very dubious and I'd be inclined just to ignore
this. On x86 and arm64, it shouldn't make a difference, given that
crc32-arch will be 'fast' in the vast majority of cases. On other
architectures, btrfs may use the C implementation while assuming it is
something faster, and if anyone actually notices the difference, we
can work with the btrfs devs to do something more sensible here.


> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/crc32_generic.c  | 8 ++++++--
>  crypto/crc32c_generic.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/crypto/crc32_generic.c b/crypto/crc32_generic.c
> index cc064ea8240e..cecd01e4d6e6 100644
> --- a/crypto/crc32_generic.c
> +++ b/crypto/crc32_generic.c
> @@ -155,19 +155,23 @@ static struct shash_alg algs[] = {{
>         .base.cra_ctxsize       = sizeof(u32),
>         .base.cra_module        = THIS_MODULE,
>         .base.cra_init          = crc32_cra_init,
>  }};
>
> +static int num_algs;
> +
>  static int __init crc32_mod_init(void)
>  {
>         /* register the arch flavor only if it differs from the generic one */
> -       return crypto_register_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
> +       num_algs = 1 + ((crc32_optimizations & CRC32_LE_OPTIMIZATION) != 0);
> +
> +       return crypto_register_shashes(algs, num_algs);
>  }
>
>  static void __exit crc32_mod_fini(void)
>  {
> -       crypto_unregister_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
> +       crypto_unregister_shashes(algs, num_algs);
>  }
>
>  subsys_initcall(crc32_mod_init);
>  module_exit(crc32_mod_fini);
>
> diff --git a/crypto/crc32c_generic.c b/crypto/crc32c_generic.c
> index 04b03d825cf4..47d694da9d4a 100644
> --- a/crypto/crc32c_generic.c
> +++ b/crypto/crc32c_generic.c
> @@ -195,19 +195,23 @@ static struct shash_alg algs[] = {{
>         .base.cra_ctxsize       = sizeof(struct chksum_ctx),
>         .base.cra_module        = THIS_MODULE,
>         .base.cra_init          = crc32c_cra_init,
>  }};
>
> +static int num_algs;
> +
>  static int __init crc32c_mod_init(void)
>  {
>         /* register the arch flavor only if it differs from the generic one */
> -       return crypto_register_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
> +       num_algs = 1 + ((crc32_optimizations & CRC32C_OPTIMIZATION) != 0);
> +
> +       return crypto_register_shashes(algs, num_algs);
>  }
>
>  static void __exit crc32c_mod_fini(void)
>  {
> -       crypto_unregister_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
> +       crypto_unregister_shashes(algs, num_algs);
>  }
>
>  subsys_initcall(crc32c_mod_init);
>  module_exit(crc32c_mod_fini);
>
> --
> 2.47.0
>
>

