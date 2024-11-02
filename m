Return-Path: <linux-arch+bounces-8778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868429B9F1A
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68371C214E8
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1516F0CA;
	Sat,  2 Nov 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG8rN+aG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17947155753;
	Sat,  2 Nov 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545515; cv=none; b=e+c1QSMiYgnNMKxebB1pI0J4NMN94pZv8hYqUzJzM8YfDHxKXPBSZpdTwrcs73uD4iydv0aqc8iLdkxFMBcAaZZlhUXocoY54oTUY9qgk2YKSXyErL79z/KaSNrwivenFKxFZwx/VOFCiblBQchaaXSywVTXvQJoE7c7nctisXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545515; c=relaxed/simple;
	bh=/5V9RBqkx2P66EvYaaaASBdjOLj2pXbKfVO3Hh2MXq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJsmQntV3NEmCWUc64J+AgaQrilpGh0lNasBa2Uz1sYms6ehOjg9aq4pONzcWj+rwxYS2/fj6UIgp+tNFmIaCmyljbiDV1gAvPHG/PAg535JLrd2+ONqyOjmtL6t6AL3ejgkuR/E4yXFJa2H2Ke3IPf6v6dV47E7yZKrV54hqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG8rN+aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C1C4CED3;
	Sat,  2 Nov 2024 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730545514;
	bh=/5V9RBqkx2P66EvYaaaASBdjOLj2pXbKfVO3Hh2MXq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aG8rN+aGdtH1DPyPt0RE+7lAJgUL/xXXHUelv4xEoDkJGS1o2la6NNuXa5xis93nN
	 K8IKDmq8EiG0o9WOHBCJO193R3Cwdp0VFuoF6oYHS3VAZ2z7ZDdAaNSMmOu/MMLl0R
	 c+5IA9wcIbiEVqWbp16rgmOQIRrPNN2745gD9NAycIDtw6YYRxmQQEvGoyQopB0/Vg
	 9k08OIbmYhcPdDTgy3bov/BTbh35m6h2xJTok/8HFYPtgtvuO45X4GGAawAIkKqaMa
	 YSVdXfZNrwS+ONIBbLTrgDZiGfuTf4K6InWgWETrzpSoUbxTA5sO4ko6HmUl4OCzgy
	 RXaied76n8YRQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so34167561fa.1;
        Sat, 02 Nov 2024 04:05:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZdQEVfF6ZUNTDckT1GEcpU7rHjdnZStQhjHmcP9ppCzvsZqxuM6Jl3tp1dearGDWbWDrEjQkEHQcsog==@vger.kernel.org, AJvYcCV+KNhPm4NasTb1Soqg7AoyjuSrb0H7utDy4TcdndiO7I2LqH+XyNr3Fwi4djC7q5hpD4R3Oz0JzvVFwg==@vger.kernel.org, AJvYcCV3zZVVVLsvjNJdZrog2r+TzK3JeCtlcGJ28BsiPl1uEk1bbFaqAQ7wvgSvOw5N0NL63JuzjznrdOkDWA==@vger.kernel.org, AJvYcCVx59gkLsPO8wUYU/Iu8c/f9KkG17WlPy2BwAis8VY/oqhe3zFPyFla2hI0Mv9QwMhnesWJtZeKhp78Dw1v@vger.kernel.org, AJvYcCW2YpBmn/XOd/GeypxwE/523DbRv306y+slyflmEC9zOMnGCzTI9oX9Wvx+dSpo2mZvEv0heY7wqqMKVQ==@vger.kernel.org, AJvYcCWbMiQLY/MsyoOl0J6W+jN5LG5e9nqbzrfauaV7ow5kKa4u7B4ycLwKPpJ3pgdu+WGBxoLvmUAb7QB5Aw==@vger.kernel.org, AJvYcCWim29nzfa/eB7xEBR3Fj4T1PnOh2IV0rvs83C2arjz3BhfWcf1bjhxL0/icu7U3M0mT+UvG5kUYnqQ@vger.kernel.org, AJvYcCXvjITxkCMmRhLOWeMbyYvJuONbDYzSKelP/amSL0mZuowrQLGXfKcDbuyuWXmKMAk675dvOcS7GpVTgiOp@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmKQxfNvjQzOOP+jsrHI7meyRBVJWy+ExcP0Uemv92nwnUZ2w
	s6fUBYkD+W6KtkZv4t1oafnX54BCHv62sIGWtiGA5R7ZNqAFAgig1zX5a0CIN9wmeMWZHJbcyyQ
	t015LoXOHOXsiBkGBfOSga6y9kZ8=
X-Google-Smtp-Source: AGHT+IE5o/Xo+U8T2tXn6oxoafBjKshUHZrf+SWe+VK5IeGRU8mut4uUUJkKbM8eXFrd2HiwYXSp4cYXTpXetvFDWaA=
X-Received: by 2002:a2e:b8ca:0:b0:2fb:5a42:da45 with SMTP id
 38308e7fff4ca-2fedb46de0dmr21026331fa.16.1730545513001; Sat, 02 Nov 2024
 04:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026040958.GA34351@sol.localdomain> <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
 <ZyX8yEqnjXjJ5itO@gondor.apana.org.au> <CAMj1kXHje-BwJVffAxN9G96Gy4Gom3Ca7dJ-_K7sgcrz7_k7Kw@mail.gmail.com>
In-Reply-To: <CAMj1kXHje-BwJVffAxN9G96Gy4Gom3Ca7dJ-_K7sgcrz7_k7Kw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Nov 2024 12:05:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>
Message-ID: <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>
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

On Sat, 2 Nov 2024 at 11:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 2 Nov 2024 at 11:20, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Sat, Nov 02, 2024 at 10:58:53AM +0100, Ard Biesheuvel wrote:
> > >
> > > At least btrfs supports a variety of checksums/hashes (crc32c, xxhash,
> > > sha) via the shash API.
> >
> > OK, given that btrfs is still doing this, I think we should still
> > register crc32c-arch conditionally.  Having it point to crc32c-generic
> > is just confusing (at least if you use btrfs).
> >
>
> Agreed. So we should take this patch.
>
> The current issue with btrfs is that it will misidentify
> crc32c-generic on arm64 as being 'slow', but this was already fixed by
> my patches that are already in cryptodev.
>
> On arm64, crc32 instructions are always available (the only known
> micro-architecture that omitted them has been obsolete for years), and
> on x86_64 the situation is similar in practice (introduced in SSE
> 4.2), and so this patch changes very little for the majority of btrfs
> users.
>
> But on architectures such as 32-bit ARM, where these instructions are
> only available if you are booting a 32-bit kernel on a 64-bit CPU
> (which is more common than you might think), this patch will ensure
> that crc32-arm / crc32c-arm are only registered if the instructions
> are actually available, and btrfs will take the slow async patch for
> checksumming if they are not. (I seriously doubt that btrfs on 32-bit
> ARM is a thing but who knows)

(actually, backpedalling a little bit - apologies)

OTOH,btrfs is the only user where this makes a difference, and its use
of the driver name is highly questionable IMO. On x86, it shouldn't
make a difference in practice, on arm64, it was broken for a long
time, and on the remaining architectures, I seriously doubt that
anyone cares about this, and so we can fix this properly if there is a
need.

The only issue resulting from *not* taking this patch is that btrfs
may misidentify the CRC32 implementation as being 'slow' and take an
alternative code path, which does not necessarily result in worse
performance.

And I'd prefer static_call() / static_call_query() over a separate
global variable to keep track of whether or not the generic code is in
use.

