Return-Path: <linux-arch+bounces-12287-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3DAD19A8
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31113169D42
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE01AE877;
	Mon,  9 Jun 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHlmWMB5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4166A92E;
	Mon,  9 Jun 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456940; cv=none; b=p9celhQr/liaZglIEavVwDbjDCFcXM4z6D8CdtkXj2lA95QqyP8airjEuZ7mdB4mYc9MFecYCo9Vv4PmDh2GYFOkM561cpbuoc5WSZbdbs/lnpCZt1J7COLiSqzPVz5ErUVdMnANnZ6ShwQXfecUD9NTUgGXCeF3+JF+HhQa2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456940; c=relaxed/simple;
	bh=6biSLqDt8gO7ruJmOh16RBlP1yDZqTM/WuIwSMjWngY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icLlWp7cOsH+UWSdINsg5mjHMqCUxjrUx+uY3DdqXEMqgv+chPiacG1E02xx1E9R0ANM5kWwtTE7ZT9I9eVvAfnSLAG77FTpG1+lvC5iZPi8GMUwBPX75gqb9Z55yglRbehhteH4uqe4FqBK5ZAoUaQVNovesIgB390wFV/Fxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHlmWMB5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fad4e6d949so22011896d6.0;
        Mon, 09 Jun 2025 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749456937; x=1750061737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avUZtz3QyLzrtWeLJ2NgcAc7qvPmPgbfgTpeZiYZBXg=;
        b=hHlmWMB586pA6FEK49ecKFQuFv6PzQwW0yW8LiKY2HMR71k21x3x8rYhTf41XKHRgd
         QX8oZQYCt+EozPJt2XAwWWxQ+kNnWI8j4pOflgu4Ob9DnGGQSLLPLpwaWJ7rCu9l37Fb
         KeUlxKlxzyAu+i4hMt1/2s6NdSKSx9S2bDfMC7bi7ga14m1+AXf077JhTRSEihtdSveY
         q0xMMQXHOiqs7N/3xy8WMpIHqqwgk4ftN9A2FpXqD3mFd7L8y4+C5P/P5o8OPOtPAumv
         /wRP768R/EH7hX/XQCx3c8c711kbD0XUDFDGaa4gRmrQ1obcEyIlJXoQuVdKUUbcjf1I
         bUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749456937; x=1750061737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avUZtz3QyLzrtWeLJ2NgcAc7qvPmPgbfgTpeZiYZBXg=;
        b=ltV7dscYfE7jLb24k+w9Efd8bm/ifqYrByOS0YDt2kuvOl1C6gXlZ0J2xlHvwEQyjt
         IFtks+3M0nz8EUiIIhy34WhEw83tE/mK6i5rF3DFgao2dmH7w158aJDDcT1Hf+7sVuhC
         Rtd1EY8ZDvs/UYVpyCigjFawK9i9aJfpgYeytVyx0VznWhmOiPkvEjRHO4e/5qmeEwS2
         /M4rJRPW9JKYnJo5JKf/0dw8VfjszZBzGBWFbPyrBQvmGp2xNuHPxWXYma+nmnSYIMc+
         1ibV361EEvDfnN2C/GbfoNpzVwDpiFq9vcKrY9uxr84uf2SGfw8fUALYwDO8DFjVKRnZ
         Pk8A==
X-Forwarded-Encrypted: i=1; AJvYcCUEgzQMxH4uOhPIUAil7YQBr3+meygxfCDuqPVMxPn+HYbQOmnnGAXvRfIWQsbOwD9tm97FDszLxFjIHw==@vger.kernel.org, AJvYcCULo1lUmTl6den+CD1LB8fzoGyslPz5H/YosbszilReC7y2Tm7qT9fHFFI0ItKtYbiGjHrgV+/tdCGQ@vger.kernel.org, AJvYcCWCAgB7uCKQRu7uUbUHuh6cWCntvijnXvepINYXtKGJ0UvLmRQ7hUkK1r70cJUkBkruy6kbpishY/OZ3w==@vger.kernel.org, AJvYcCWs7q19+s31WAKC74xdjW70GV0VtmSndwHVol+NV+afrDDszzeeMJvVOpCwq0ksbeGHGO8jcdgHmWmzyG04@vger.kernel.org, AJvYcCXAo6eXv5f3iFtR2GNteyGJ6beV20yITtiwzB5eDSD1cLeWmeh3SCR3PHX93LzXe6N542qLs7Mg2MUKmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfo8mhpV0Z9dwNHpW7+9Ox2gbfZ+BaWhpnd444pPhkwCh1ykSd
	R39Vot3nCy3OH8Rox7EVXS0AIE7QPQuSbmuCRFf98OMedcOgo0jQFIKt0V5H+cDb8X3FzxOpG9n
	WwGgeqTneOaMONdxTHojK3vnK4E5cnNrX/Q==
X-Gm-Gg: ASbGnctUDNg2ikWerb31Cwn6LxNeCKNEsqy/tanU0YvHce7WK/sKKjVS9Om5VR7pc7l
	DsYCiRLC45/4MU+7pVHubgvlonC3vOKy0PWTaVnwwkj+4mSu6ifAstMIFyy7hvVUUpU1GL7VIjK
	pDYOiFnOU1jaPXxk3q0KitdTFi4Rom8tvQ
X-Google-Smtp-Source: AGHT+IH9me4CEdVFtIOCuIg1XAKf5VF3TkyjvnvcV85fkEmF6RBw78F2p/ZOsZjFija3GtR5SXP0ijToaYQxk0VMGhA=
X-Received: by 2002:ad4:5f09:0:b0:6fa:c81a:6204 with SMTP id
 6a1803df08f44-6fb08f50942mr228433326d6.10.1749456937558; Mon, 09 Jun 2025
 01:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607200454.73587-1-ebiggers@kernel.org>
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 9 Jun 2025 18:15:24 +1000
X-Gm-Features: AX0GCFtpUUxU8yEaZey6YSh4XuBhQlOITIBZOiB21tfxDGQbnIThjp-0HFxjxHQ
Message-ID: <CAGRGNgV_4X3O-qo3XFGexi9_JqJXK9Mf82=p8CQ4BoD3o-Hypw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is integrated
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Sun, Jun 8, 2025 at 6:07=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> This series is also available at:
>
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/li=
nux.git lib-crc-arch-v2
>
> This series improves how lib/crc supports arch-optimized code.  First,
> instead of the arch-optimized CRC code being in arch/$(SRCARCH)/lib/, it
> will now be in lib/crc/$(SRCARCH)/.  Second, the API functions (e.g.
> crc32c()), arch-optimized functions (e.g. crc32c_arch()), and generic
> functions (e.g. crc32c_base()) will now be part of a single module for
> each CRC type, allowing better inlining and dead code elimination.  The
> second change is made possible by the first.
>
> As an example, consider CONFIG_CRC32=3Dm on x86.  We'll now have just
> crc32.ko instead of both crc32-x86.ko and crc32.ko.  The two modules
> were already coupled together and always both got loaded together via
> direct symbol dependency, so the separation provided no benefit.
>
> Note: later I'd like to apply the same design to lib/crypto/ too, where
> often the API functions are out-of-line so this will work even better.
> In those cases, for each algorithm we currently have 3 modules all
> coupled together, e.g. libsha256.ko, libsha256-generic.ko, and
> sha256-x86.ko.  We should have just one, inline things properly, and
> rely on the compiler's dead code elimination to decide the inclusion of
> the generic code instead of manually setting it via kconfig.
>
> Having arch-specific code outside arch/ was somewhat controversial when
> Zinc proposed it back in 2018.  But I don't think the concerns are
> warranted.  It's better from a technical perspective, as it enables the
> improvements mentioned above.  This model is already successfully used
> in other places in the kernel such as lib/raid6/.  The community of each
> architecture still remains free to work on the code, even if it's not in
> arch/.  At the time there was also a desire to put the library code in
> the same files as the old-school crypto API, but that was a mistake; now
> that the library is separate, that's no longer a constraint either.

Quick question, and apologies if this has been covered elsewhere.

Why not just use choice blocks in Kconfig to choose the compiled-in
crc32 variant instead of this somewhat indirect scheme?

This would keep the dependencies grouped by arch and provide a single
place to choose whether the generic or arch-specific method is used.

It would also allow for alternatives if that ever becomes a thing and
compile testing of the arch-specific variants if that even offers any
actual value.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

