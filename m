Return-Path: <linux-arch+bounces-8775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181969B9E7B
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD2B1C21C2F
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659D16DED5;
	Sat,  2 Nov 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTAZ258u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C416DC3C;
	Sat,  2 Nov 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730541554; cv=none; b=ntH0ZvaEulSfPynB2B/fC7XgwnQyHNGMEKa432p6tB0tfvwBK1jAkU1/LdqQXVAZqo8WlYMWPh5S7S0LmN9llRkFjGljRNvN+pkXo0wqIwafAqM9xTUCg0LgkSDmL/v1DaqHKSEy9ZOdBtv1JW5noy3npWup8ge0om3JISEcMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730541554; c=relaxed/simple;
	bh=jzcc2qtlo3q2yjXZFmDXUgFRfJJPX4XAPzkwICumNQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHsCuvXgo8mdg93T3COf7sPg62Zm/AxNTK4Da0DrIORa6W/NXqwymTXtEfpE3mcLpQItlN17MFrH2bA+hII5I6IFfpmfdZO0S6n3waDu6jgePT4QeT5y4emTahOJaXWh5zFLMbK5Zrn8ktCAsMi9nCAnYcl+i3ueue9Qrayz1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTAZ258u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA9DC4CED4;
	Sat,  2 Nov 2024 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730541554;
	bh=jzcc2qtlo3q2yjXZFmDXUgFRfJJPX4XAPzkwICumNQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pTAZ258u/Bm55mgKfduPxcJ4+l7utIbI96FN3uHiYroZBZHAbnvfCZty3m5Rr2XH+
	 F9H9kpY23mllFcm03reDqSDwYlj6z0PqW6iPcayBoJoKDOej6utxzDbE1LxiDgLJej
	 urb0cE+UNWmcsBfRHpQmITbawEzxNGoWVLCC3Y8Sm8pFGBsK9d4GCjck+Inw9773Iv
	 K9VihTfRaPahcmoyEauQixFxZyTUMGJWDTOfYvXPoPOgSsyaIxQpyV/cg9HQXOUiLk
	 wu2j/IQnCytheMbmA1fvWXZkbzI7ui/5dw0pO/X8IJ8Hh4LoxB9jvG2GJ0onELclPL
	 6WJfZCxg2RXng==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so41706991fa.0;
        Sat, 02 Nov 2024 02:59:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVqVLq3C92j0ImcNcEo7/p5I5QrZAZCy4T8VXOKlNLzwOeJHX4t0LgUhi8wi17PwTZjCjoHQayrYkJ7Q==@vger.kernel.org, AJvYcCUe84y8Os0AqqBKbIAHkulfhf8czZls/3LFpiiEI0vmiHRKIku084nlslM9/yaWDPk3h7dwbNmwUjaIyA==@vger.kernel.org, AJvYcCUj8nBNssW57UIuj7d/5GrwwJSJeVioI0YkFiQuh5etRS1ub9PAHuNbrdYY1ZdphCb4H2F6Un99sgLOsQ==@vger.kernel.org, AJvYcCVnwPMK6s+gkZbLb/Ho7EIW/ZvDvJt5uZ6sERdIUO9qaLRBXyOB3E/K9162d32GAlvTjuUa4vWq4j5PnQ==@vger.kernel.org, AJvYcCWJKiLeWPvLukzfAecjbz8ftwyw//koLoqvEVFOW75V1OsTJXNs3pVOs39kGWWLi2y5/GEPBmx5jind@vger.kernel.org, AJvYcCWO0yXvBACrVjSBM6Bg9LizhEz+QaoQC9ju6KBbvy6ux6HtsQicyHk9qL8Nt+QMl2A23vWYxURlEuvjqA==@vger.kernel.org, AJvYcCXKeztO4dADeabG4pFgsuLgISBmMq5cNbs05nSFGHrz2xU+mYjNSjhN+3DUBBBEAtKKrgK3E7NCEBSK6Si3@vger.kernel.org, AJvYcCXvU6fZf89O6tgiBKrGIEPZmJMVaxf5ra79C1XfI5gD2R0driseHn6QkEJW3jc7nYc+Iprnr0RGj9PKgwQH@vger.kernel.org
X-Gm-Message-State: AOJu0YzNg+x8MoQYQQjRgKMaAQvW7XnvuMy/ymkzNy9HQkxyxdmugPI/
	l/bcTwegI5BP0+Qy8TLyJVF+vxRgngyedil0WzeRNdLjfTpITExYaSdH3/PWy6sIfhMD0CX63Ig
	ARvIehqq+MRTmSosCVtdfEoQa6Rs=
X-Google-Smtp-Source: AGHT+IEqeG8VCff0uhjP4V5ORLaNGD6KRrpJIJXC1kxDqwtW+gAEc3mfRLYGB8V+37TlYDdzVpYd4mw53pqQuHqGPG8=
X-Received: by 2002:a05:651c:19a5:b0:2fa:de13:5c34 with SMTP id
 38308e7fff4ca-2fedb7c7ad4mr47293611fa.19.1730541552417; Sat, 02 Nov 2024
 02:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026040958.GA34351@sol.localdomain> <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
In-Reply-To: <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Nov 2024 10:58:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
Message-ID: <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Nov 2024 at 10:45, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > While testing this patchset I notice that none of the crypto API drivers for
> > crc32 or crc32c even need to be loaded on my system anymore, as everything on my
> > system that uses those algorithms (such as ext4) just uses the library APIs now.
> > That makes the "check /proc/crypto" trick stop working anyway.
>
> What's stopping us from removing them altogether?
>

At least btrfs supports a variety of checksums/hashes (crc32c, xxhash,
sha) via the shash API.

There are some other remaining uses of crc32c using shash or sync
ahash where the algo is hardcoded (NVMe, infiniband) so I imagine
those might be candidates for conversion as well.

