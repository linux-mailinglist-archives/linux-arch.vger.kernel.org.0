Return-Path: <linux-arch+bounces-8835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979439BB2A4
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2940A1F22038
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95D1B4F2B;
	Mon,  4 Nov 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EADOQrSt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447E1B4F24;
	Mon,  4 Nov 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717819; cv=none; b=oRBgYkOkFYPZng/LqDIa1f+L5+0QV9wFMfMUiPBu0oR46kfqZxIPOLN6JOr8yOEG8pO3CYL7Rl4+/gXMfV57WDgob+aOtUY/vAsXGztVyYc90wp7xOu9PF76eqXywR8wbOiUvGPd9HjsSx3GZlZVShIWWvuXSVmbb1FfE07BmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717819; c=relaxed/simple;
	bh=6qFxuwoqjmsBXA5afiRPckV6EYzE55EhM//TIyBTrQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RX/u69nqfzdjM28rBltoLSiqtM+WNhwFa1UaRXLk267VbKeAio3z4s/dGLdF+zqX1nmEGx1mMQxOmj3ha2Ofg7v+iLy17B7oVfX3mHEJfbuvg1+aAu0NxC+Hvw/u3OgglnMeiWcfEg615atuQYbCXIJaW+2AVK4X2++UsMzf5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EADOQrSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EEAC4AF0B;
	Mon,  4 Nov 2024 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717818;
	bh=6qFxuwoqjmsBXA5afiRPckV6EYzE55EhM//TIyBTrQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EADOQrSt03YURgotEa0RPC+Q+iLgiLTpyDunuCSyI8JrnJ8j4YEhKIdjW/X9XmfJY
	 sTCnqIY+Z2AkNeyzcvIvr+dGT6FfLBfZvlbrdb8z2SiV9hm+elSOB97O2rE7ro9EXq
	 0i/CQC7v2klAcuIyDxn2pg7/smSOsw0dT4Hhws9swr3/XRUtzPo+CxQGrrBX7df8D/
	 5J0t2oN4EkGyZAZoiEf4JRfD6nAiE3emF0OuGcBGMMWHNR23yXfKnSbJVb11OHm5BV
	 KUm+3gkbO7B14khPoblQ7uBvr3V7hMm9Omm80Fu2OU58gX+loUjMi/2DNHEoGYci8U
	 QgiPNae8TP/uQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso35066781fa.0;
        Mon, 04 Nov 2024 02:56:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7xoBdSw7WBFogoDHrvE/HqzdjwEOMmImfj5rv727+uNW/nWwMxb3aiB7GFtwozVTPQXy86AO1OXkOnA==@vger.kernel.org, AJvYcCVTNBsOqHLkgtJGigBa/isJCHgbsiNKmrI5+kvbgDZcJMeFzwkEWE8ebTXv9KJOhRQuLTjesgqi70UBQw==@vger.kernel.org, AJvYcCWhDBFSu3muOSQSSs5FLIsmxVvCuKCon8MkpgER6rPwM10QDNjNEyRL4fy7UB6uE1jQSxbEmD5xrN1k1Q==@vger.kernel.org, AJvYcCWmhuBs1pzG9bt5+VLjZi5DL2AB1zkrHH/DB9jywzV8yx+aa4/gkdW/FLE+qWNExzJp4VElgRen2cxA3g==@vger.kernel.org, AJvYcCXGlD8wbx/QOszbqxlvihfhb/O3PE1S70sQ7efuGiglxTzoFONrTZEvN3S9PVnXA2m5TMzVC/M/BgrAIgZw@vger.kernel.org, AJvYcCXY3zmKZULtzD2Qr1zBSDOYio63vSwOslNKHj+27/utSV9rOR3qtlx3vUvQunPMQJzsmsyZ+7+XTmLwAw==@vger.kernel.org, AJvYcCXYoWKKilKSRHmfTlQo4SNi/uvKlFp3wszbHnscl+4A/hvKqyecntMb+onVXOjIloFhiiooKJqfzczT@vger.kernel.org
X-Gm-Message-State: AOJu0YxZv9/XWtQTI9Xl/GbxNVl6C/JDclJIDl6e10MIEY986QPphn4W
	42vPreOs/bE68tplLb8Kx6uGt4UNZMTFJFzrF25lhdJXu53MTiejtzRWcsgi/hgiTtoaYuiP0zT
	5igiVkkHpuBqsmNl8GzpBN9pUgZA=
X-Google-Smtp-Source: AGHT+IGbnKnh4aAfaULtSCmiukLUpnKZU5MlHxJghtOAuKX/zIcXfbKXe/xSvudBsLa83HeLXpJgE1iAQVUbiw2PNrM=
X-Received: by 2002:a05:651c:1508:b0:2fa:fc41:cf80 with SMTP id
 38308e7fff4ca-2fedb7ecd4amr43930581fa.43.1730717816511; Mon, 04 Nov 2024
 02:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103223154.136127-1-ebiggers@kernel.org> <20241103223154.136127-5-ebiggers@kernel.org>
In-Reply-To: <20241103223154.136127-5-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Nov 2024 11:56:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3C1xP7865V-mJ+3=FDHTR-df909=7jift_Z6dmp58Gw@mail.gmail.com>
Message-ID: <CAMj1kXH3C1xP7865V-mJ+3=FDHTR-df909=7jift_Z6dmp58Gw@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] crypto: crc32 - don't unnecessarily register
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

On Sun, 3 Nov 2024 at 23:32, Eric Biggers <ebiggers@kernel.org> wrote:
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
> (It would also make sense to change btrfs to test the crc32_optimization
> flags itself, so that it doesn't have to use the weird hack of parsing
> the driver name.  This change still makes sense either way though.)
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  crypto/crc32_generic.c  | 8 ++++++--
>  crypto/crc32c_generic.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/crypto/crc32_generic.c b/crypto/crc32_generic.c
> index cc064ea8240e..783a30b27398 100644
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
> +       num_algs = 1 + ((crc32_optimizations() & CRC32_LE_OPTIMIZATION) != 0);
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
> index 04b03d825cf4..985da981d6e2 100644
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
> +       num_algs = 1 + ((crc32_optimizations() & CRC32C_OPTIMIZATION) != 0);
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

