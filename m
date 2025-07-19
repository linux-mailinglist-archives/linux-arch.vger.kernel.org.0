Return-Path: <linux-arch+bounces-12872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC12B0AF91
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 13:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AB658059E
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB32206AF;
	Sat, 19 Jul 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFcWaj2q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD541EA73;
	Sat, 19 Jul 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923824; cv=none; b=nMEzzVcEtoAPdoICDTPRVgqM7FmN71oNPL6xGYqeJHexhGW4Y+wexDpdQlTtGpV8U8P6P4oQ1a5UNPVnsbnerPmXidKoS9ValE0EVE+iq7JEtMU5NvrXYRdSp/eEBjqQ3V9WJH7bJ5yGP0DtWq7N6qdztypBhVSJezrSTM/3rZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923824; c=relaxed/simple;
	bh=KXowqI3/RE97rgzmTulNCguE6RLBk8w7gFO0xyORFkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtWGtQI+V/iR6sbGL18TopsEoZYGsyn41xconE8CUeNA9A5jEPaM+uhg5w/TWQuYsRdV2szxLjKQWfQtlFmmPEv0ecDIRfXFRIrAS4eCWO0WxcLKcrpr8XSrrIDbBGSj/uwKIAIliJNcXz1r9tyYgx7EmqxyCsZ0N7Pix8Npirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFcWaj2q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a51481a598so1495813f8f.3;
        Sat, 19 Jul 2025 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752923821; x=1753528621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yREH1JHbpA4Pc+dF2sRYRmhDFSm/U6gj6czteq239g8=;
        b=bFcWaj2qAaap8WjDzJIIJ2W1rQ9k/G0oR/063KMFtzxLEpaN+PNRf+DMjeFriicPNX
         8BOvnv+VO2XVg6/aL695gO3ose2KS3nMdye4Yuefk/1JiJ0j9WZECYFXvOh4skkoY37r
         fGRTjPIvThnK/+whc/uBFHdFFIiASX25oLNt6muS0JQbAgsma8Mj4PstwxcVyTZdHH/x
         HPLQpCsCaERgj6/SB3f0VCDtBq+fZn6uwi1yKJXfzmct/JNKhgJ5zx26pNIUvJBA7M1p
         MA302hCXSwCu1D+3sKJqEkDHjiYv9EK9dmi4RsI5dKyamLqGoGiTx+QIHYpj6/CunowK
         Fcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752923821; x=1753528621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yREH1JHbpA4Pc+dF2sRYRmhDFSm/U6gj6czteq239g8=;
        b=RWEVokms3NIjcmJybNl93C93yGny7oANi8/B+svQmkYECjY1T336m0g1KEIPCFg0vc
         Ktdm56zUpclBXMxGm2didmWn8uohvv7yrh2+Dr8VR+H9T4p9Yp9YtYGJI3a1Pe7/3myR
         tibshsMgDPUVeOy3HsdxbNVSwJiV7FMOheGAVhBBxhhMfSxaLZWv4qjo+QPUWMH8wAun
         xUQe5eLWWSZInjbvy71qQYb+hLg7qH4hSKxxXRBqB63zgHH66MNzkW2bdkKyWw9dFQ/l
         CtWHj92PtFpS3lYi4zz8+glRqYmUYMCStUztPtPzm6YVHmcf5j1cOQMJ8ibVhtAKGDFb
         31mw==
X-Forwarded-Encrypted: i=1; AJvYcCV2WK8lGyYqk6PEXvpoO1KhGheLTFS/buMO3L0+62xWSiZA3ulW5BnWJF73Fnf489Axspd3eHkfmlg2@vger.kernel.org, AJvYcCVpZLSUD+G6mRzXLI/1mYdYP9eV4wkcPSwYyThXUwWNNuMdZeLnYBIlLDgE/E6N1TcEgWNGnMS5ehRc/1vO@vger.kernel.org, AJvYcCXIrBkS15QtECISXXP+oAUrTy+4UJaNJC06TV4xUhSAs7B9w3BD6ULmM8U4y+A4cjnZQIBCmhgy7kie1Vn93/S2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6FGskKo855iqvP7IyfSzUFTs/roVdCSFI0ZLkQXbdC7D580R
	HvRO5Pjs15h+PHYzpTwQHI566AR/vft0p0yNveiSS6u7BZDxipzXa7KI
X-Gm-Gg: ASbGncsxlGBtytAKyHeFNbvN6VX41tVOKm1Du1xyQ+cVZfBXKRciEPq7xFsIJJpLZDN
	kITks1+JRPPT0/hJSOHagBRvEdAUq6o72y1TWid5kyaDJcRJk9wfIu1gevM/ocXD0dH8ueoSZaz
	/eAhpUZSK6jSnwyze7R65RAPPDoeGtazwqh61EkVROK3wn9Y7JPBP9Cbu9GmonDKd52aUPE3niK
	vjesKXUFXT3ROqCc+c7SFVtr2S1H0fBcGHwFXdLMPE4SALWcKEl0GdreSuB9brIj3kdnLn/9m4L
	uvoxULg5EfWaUFU0Bdn2tH1dJsSOeGZa7Nl6Jyk3O6anmLSgUR5ImcuIHe7PJXPj4YvazDDtYm9
	KxdV+WNeHUK+01pngRHZy33Ygtrbcc6GoTuiu4V1EWdHELYIGfy8aQAHwvQS6
X-Google-Smtp-Source: AGHT+IFG5a/EIEtTEgi/facfq5JtWW35JzsMqA9KnJCq8jcsa36lVJQsFoBhwDYnIaAYi1qGi6pY9A==
X-Received: by 2002:a05:6000:2903:b0:3a4:f5f6:b4ab with SMTP id ffacd0b85a97d-3b60e523cc0mr9834573f8f.30.1752923820833;
        Sat, 19 Jul 2025 04:17:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c712sm4567642f8f.79.2025.07.19.04.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:17:00 -0700 (PDT)
Date: Sat, 19 Jul 2025 12:16:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Thomas Gleixner
 <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse
 <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao
 <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
Message-ID: <20250719121659.515c199b@pumpkin>
In-Reply-To: <69499cb9-b13b-4eec-a7c4-c219a77c6260@sirena.org.uk>
References: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
	<02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
	<CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
	<e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
	<20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
	<eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
	<6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
	<20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
	<3a9504d1-2c6a-459a-a98e-3010d34b546c@sirena.org.uk>
	<20250716152041-189100b1-7f5e-4388-8ada-b79ec09d18f5@linutronix.de>
	<69499cb9-b13b-4eec-a7c4-c219a77c6260@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 15:35:09 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 16, 2025 at 03:23:24PM +0200, Thomas Wei=C3=9Fschuh wrote:
>=20
> > Can you try the following?
> > I missed this despite the double-checking after the last reported issue=
. =20
>=20
> I needed to fix that up a bit, it was missing an update of the final ret
> in the function and didn't apply directly to -next for some reason so I
> had to manually apply but it seems to do the trick, thanks!
>=20
> Tested-by: Mark Brown <broonie@kernel.org>
>=20
> with this against -next:
>=20
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 97aa9059a5c97..487e3458e536e 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -365,18 +365,18 @@ __cvdso_clock_gettime32_data(const struct vdso_time=
_data *vd, clockid_t clock,
>  			     struct old_timespec32 *res)
>  {
>  	struct __kernel_timespec ts;
> -	int ret;
> +	bool ok;
> =20
> -	ret =3D __cvdso_clock_gettime_common(vd, clock, &ts);
> +	ok =3D __cvdso_clock_gettime_common(vd, clock, &ts);
> =20
> -	if (unlikely(ret))
> +	if (unlikely(!ok))

Do you even need 'ok' at all, just:
	if (unlikely(!__cvdso_clock_gettime_common(vd, clock, &ts)))

>  		return clock_gettime32_fallback(clock, res);
> =20
> -	/* For ret =3D=3D 0 */
> +	/* For ok =3D=3D true */
>  	res->tv_sec =3D ts.tv_sec;
>  	res->tv_nsec =3D ts.tv_nsec;
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static __maybe_unused int

	David



