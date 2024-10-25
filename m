Return-Path: <linux-arch+bounces-8579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC59B11BA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CA61C21A13
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C31D8E07;
	Fri, 25 Oct 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9TEdB8N"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9541C07FD;
	Fri, 25 Oct 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892279; cv=none; b=L7gizU9jL/J2G9/iOUbs9S+oAu4px967+LiCBVEwzDDEWJ5KTWThYMrfm/qvFEM/lQJZNCc/CEaVUJQoh+vQKquGz9t9vJw/Px8N0bumtD6EpPMdJRUVaKliXpghaqbvdj8AbWio8xFmeFquQrm5ybzk9N1nemu9B0TGEcyk/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892279; c=relaxed/simple;
	bh=Q8vC22irZ2uA8WYYvmBwW1+2Pm2qVwYkLgdZ6/sItmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEtLEwbMa7yi3jQQt9+OkeHh0ACmNhkoFRyYqzomtyUibx9hdR+6DRU/jK3KRSGsRwca+Kjk3xS+iUkk8KJd2rqEvy5H18ide7LZEnC9mYmhH32SeUmi6iZev7v6/J92/+m4UdRQ8jaVUiGyTrI7ud9q+HlmW9KB0yPu6XMxWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9TEdB8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB84C4CEE4;
	Fri, 25 Oct 2024 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729892278;
	bh=Q8vC22irZ2uA8WYYvmBwW1+2Pm2qVwYkLgdZ6/sItmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X9TEdB8NtoLsaY6w4tD051jPTNAuoCaCbQQHkiIzKo7oiJT9AWcwt+FyzmJhovWAp
	 2pb0msYmVONirDKwQIfh5V3wPV0dcbDz2pSpVcpHIdMk9tXuPDZ5e6Az8xORI991cm
	 xqLA6sL3m9DoZGlSNnVohRg6luGL7923xAU3nr5tH7OjWBmXsAW7KgEF+MDVfsK2ne
	 duqlO61GagzVxkZD2Axh5Nb172IRQrUPy3AWEhn1+6vZ+0EOpP8QflDhFwNd3ZyyP/
	 h1jEpYwivxBADQX2gGh2Yha+akgPxJ0n7Q8ruu2ds379qCqEjs553wHkorArIKfS4N
	 Vw2SZPUxwQngA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso39466531fa.3;
        Fri, 25 Oct 2024 14:37:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNjKMlQgmP4BV+V3hXGWCojMJHZWXCzx/WDQ6Av06XsPkHdIy3YKmFSz9LkpYk0qo9GUDCeM/PEv3Xiw==@vger.kernel.org, AJvYcCVQW8pN2aHUJDffRuvtweZfYqFCcOmkPLGagkbyBruuUEWVM42QgMBpSK08z6unAJFNKxqKYboT3JliaA==@vger.kernel.org, AJvYcCVUKJ5el0SYjYCxtkJej8QD3wXAgWMoyQcPyvtNdU6hhmhfT+pAtP08IjAbHFt1ne94s6728GiTrgStbQ==@vger.kernel.org, AJvYcCWv5T9ChvwhklECYlAzxky+smW4WHhpCJk9y4UwFX3VoMQDClDiSCGa8FZeaNT/y2yClGoJIhbr9Pntbw==@vger.kernel.org, AJvYcCXHCEB5nggl8hOtUnZPYDDrvV9lNmMOOonIHGaLrd+tA0qLvqNOPlnKTbzaercx1MwCE1+n0uHF9dqKAyW3@vger.kernel.org, AJvYcCXNA52hl+L3JToiT8IP4JdeG7FAprX8GLLvz+P33El8mGgj5XSCkJwlcy85Sn6sg2ozhHbsAkBo4O2T@vger.kernel.org, AJvYcCXwx1RqcH3WfLMoLQIlAcq5kkHA4UAbk+9/yEEjNpluccJRmf/wFEtLbTyuJBugMQV9vqRXzVrSCNitFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXY4eq5RIx/1lMyjRA0as3JM/zhr6JXE36rdXOhErnk/VE9CJq
	KG1qOARRTiWtXsiFNfyR4k0/F6uNazqF47NjlDKedRlXdQF9KxM2RhVjU0vKsg9mQOzXPmT019Z
	rtCsUv5/3xho+Daz2e1JnnaOombk=
X-Google-Smtp-Source: AGHT+IEQWINSviRss911g3zsmM49RILDHJN+Ssrcrwx15J0k6BAeeRwcNFxqZbNLbvjIoCqISV0e2QKpM5PEk7ZnG3k=
X-Received: by 2002:a05:651c:b0d:b0:2fa:d604:e519 with SMTP id
 38308e7fff4ca-2fcbdf7db48mr5607491fa.11.1729892277115; Fri, 25 Oct 2024
 14:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025191454.72616-1-ebiggers@kernel.org> <20241025191454.72616-4-ebiggers@kernel.org>
 <CAMj1kXFoer+_yZJWtqBVYfYnzqL9X9bbBRomCL3LDqRcYJ6njQ@mail.gmail.com> <20241025213243.GA2637569@google.com>
In-Reply-To: <20241025213243.GA2637569@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 25 Oct 2024 23:37:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHZy3yPvonS5ZVof0qa0V_Lxhv5Q7i1UVf5P6D3d+=KRw@mail.gmail.com>
Message-ID: <CAMj1kXHZy3yPvonS5ZVof0qa0V_Lxhv5Q7i1UVf5P6D3d+=KRw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] lib/crc32: expose whether the lib is really
 optimized at runtime
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 23:32, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Oct 25, 2024 at 10:32:14PM +0200, Ard Biesheuvel wrote:
> > On Fri, 25 Oct 2024 at 21:15, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > Make the CRC32 library export some flags that indicate which CRC32
> > > functions are actually executing optimized code at runtime.  Set these
> > > correctly from the architectures that implement the CRC32 functions.
> > >
> > > This will be used to determine whether the crc32[c]-$arch shash
> > > algorithms should be registered in the crypto API.  btrfs could also
> > > start using these flags instead of the hack that it currently uses where
> > > it parses the crypto_shash_driver_name.
> > >
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  arch/arm64/lib/crc32-glue.c  | 15 +++++++++++++++
> > >  arch/riscv/lib/crc32-riscv.c | 15 +++++++++++++++
> > >  include/linux/crc32.h        | 15 +++++++++++++++
> > >  lib/crc32.c                  |  5 +++++
> > >  4 files changed, 50 insertions(+)
> > >
> > ...
> > > diff --git a/include/linux/crc32.h b/include/linux/crc32.h
> > > index 58c632533b08..bf26d454b60d 100644
> > > --- a/include/linux/crc32.h
> > > +++ b/include/linux/crc32.h
> > > @@ -35,10 +35,25 @@ static inline u32 __pure __crc32c_le(u32 crc, const u8 *p, size_t len)
> > >         if (IS_ENABLED(CONFIG_CRC32_ARCH))
> > >                 return crc32c_le_arch(crc, p, len);
> > >         return crc32c_le_base(crc, p, len);
> > >  }
> > >
> > > +/*
> > > + * crc32_optimizations contains flags that indicate which CRC32 library
> > > + * functions are using architecture-specific optimizations.  Unlike
> > > + * IS_ENABLED(CONFIG_CRC32_ARCH) it takes into account the different CRC32
> > > + * variants and also whether any needed CPU features are available at runtime.
> > > + */
> > > +#define CRC32_LE_OPTIMIZATION  BIT(0) /* crc32_le() is optimized */
> > > +#define CRC32_BE_OPTIMIZATION  BIT(1) /* crc32_be() is optimized */
> > > +#define CRC32C_OPTIMIZATION    BIT(2) /* __crc32c_le() is optimized */
> > > +#if IS_ENABLED(CONFIG_CRC32_ARCH)
> > > +extern u32 crc32_optimizations;
> > > +#else
> > > +#define crc32_optimizations 0
> > > +#endif
> > > +
> >
> > Wouldn't it be cleaner to add a new library function for this, instead
> > of using a global variable?
>
> The architecture crc32 modules need to be able to write to this.  There could be
> a setter function and a getter function, but just using a variable is simpler.
>

If we just add 'u32 crc32_optimizations()', there is no need for those
modules to have init/exit hooks, the only thing they need to export is
this routine.

Or perhaps it could even be a static inline, with the right plumbing
of header files. At least on arm64,

static inline u32 crc32_optimizations() {
  if (!alternative_have_const_cap_likely(ARM64_HAS_CRC32))
    return 0;
  return CRC32_LE_OPTIMIZATION | CRC32_BE_OPTIMIZATION | CRC32C_OPTIMIZATION;
}

should be all we need.

