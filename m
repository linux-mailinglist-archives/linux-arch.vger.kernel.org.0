Return-Path: <linux-arch+bounces-12147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F91AC8586
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 01:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0AF175055
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362121E092;
	Thu, 29 May 2025 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmXErXRH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448B22D9EA
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562897; cv=none; b=TvV1nh+IBJQbPRXIkq4eHUKSbNwI6oHvH+Yn75MrtiPyn/0Pt/RSxkxDCMz/LDjnG5jfMFzqaBe03pJHNCmsL6VhPqc+rx35hIoZ2syGsjnH4CIxPeFcqGeT5iiK92vyJq/Y3DVRf5bwOJYDsZl0OyedY4Lh+MUjcvoq+2ThAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562897; c=relaxed/simple;
	bh=mQ2X3C83MrQ+ifFd0cXmKRdvIysb8KwRrZHJnS3dFHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klOxVdle7GIRLGXn24G2QWTtfB5YRKU88st5ErBhMeLYwlZq9pUOv6LQNDukT2yIlBhe8ZnP5LKFBbUmgy2xl0Oa1UrtD41mklwgnDEJg3kOdKWylndv0rHXrUVgK6D1Oee7UxyeYbIhVkElEh3FEhEM7Xei6BtU5yNoa5osORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fmXErXRH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad8a8da2376so245848966b.3
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748562893; x=1749167693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpgeKXbWpRtz3XeS2MBk7nO0oA3f7brSdzLdQTvzhc=;
        b=fmXErXRHWEtJ/YxlW9mbbaYGNYfYLbE0QoNoIJbXHLcmxl91K1T8ehfd9FQ1FNGFzX
         9BMDwTit6ZvY7ppfxpsCzZeQ2cLajnuSBwd+DuBDS5Caq0yWAJH25jUz0BVAkKUMjUnr
         R1RXW7nUGVlqq0eHL2DsNTduETQqRY+myjtRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562893; x=1749167693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCpgeKXbWpRtz3XeS2MBk7nO0oA3f7brSdzLdQTvzhc=;
        b=nPYj/N9vypj2f20umaUqCn0rKQLaj/qFjae4cXWxWl4b4Qy9tCDrL26U4TqHfq74UF
         +8XXEMiGnSg558jyZokOeRZB3HpkDv+j6YF2UEHhguIG07ny65wnZmU5dSipFX8FoKjm
         5VRKXwvouxNsSJRnp97x7r2kRarzcC2GrGJfJs9JoWxPA/Up6ut00j1YnkA/xhY+ejYc
         oYuCLEaJo9pxJmPQpnvXvJQn1P9oGEMk43k+CZJAzVF6Rzn5KNlHm/sxKDQpat6mJp8z
         h3YB/WSPiYgJm+6AjO/9Alz5U8K+Y8mFPd6GXvnTgj6kdhSnBOoJYF8ZerKX0v38GzCe
         AWdw==
X-Forwarded-Encrypted: i=1; AJvYcCURvGXyNFDV0hHAkZBypLcY+ylMduBI9o3KXkSX87iWfN840Ddmsylyk804+VQZu0kNpQDLXGp8B0pp@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYPoVZ1KKQiR1EV4cGwwtGfwS0JcHcPGPK3gwZNk/zBTMc5JH
	Z9vGc6xlO64ecHRLv/lGD+WO1VoSg2Kgk4WD84c1ztgF7I2N5bZBAIio7bqN8YE5WMnmVvOlt/O
	+lsZQmtc=
X-Gm-Gg: ASbGncsI/lqfBj8kthgj8nQ7QUKSIRSyNffXIuvbByFLIKav7FcB5mh4dLNetcgD6eF
	5VyRS3oq2MPZtxj75+G0M6AKE/+1nkVJvevCdQsgQAdkgyJ0ODmQ4/eqZroKO73+BWtXVrPDnui
	8TmaaRtS+W+VqfxZL3EUCwiz4MNZEGIqlb+N3yoIPmD8t8RTvEZS5N2FOQJ2BG44cdgEIl7sME/
	7JcAXzYSEb7rMvL6xotT/QbRwJgHKbzZEA8mBcg6dSIa73nlJQZBG+t1gkj9NKGVFDmhNvRwjvL
	tpocvcTU2edOa0U6mkx8RSGoKKTvsgdfOSBAP2uQJ/bKc/9/173UWkf8rHkW76uLmruUSKm3tgD
	g1/I8Ul9R/XmG8rH/vk7C4T0/Dw==
X-Google-Smtp-Source: AGHT+IE1gROX8A3RcjoZkwPYyHssCzUvZV3SKDjckW3vSBQ37T9Z3PMlRmVZlvfckphPvzOn1mXTsA==
X-Received: by 2002:a17:907:6d25:b0:ad8:9ab7:a270 with SMTP id a640c23a62f3a-adb3230196dmr127157066b.38.1748562893245;
        Thu, 29 May 2025 16:54:53 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5e2befaesm226955466b.104.2025.05.29.16.54.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 16:54:51 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6055f106811so1182476a12.0
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 16:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIn4syPUALDrWkESNsk12EcPIN3AxSkehukMndtA1Igx0az9cYfGkpNBksMboHUQrzplQrCP5zQM9H@vger.kernel.org
X-Received: by 2002:a05:6402:35c6:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-6056e1597eamr926476a12.22.1748562890813; Thu, 29 May 2025
 16:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com> <20250529211639.GD23614@sol>
In-Reply-To: <20250529211639.GD23614@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2025 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
X-Gm-Features: AX0GCFuuQZJkBnHy-mtAufGSUKbxBrKrMtOhVAT8ZxGCHwWeq3lbFPW0g13cPtE
Message-ID: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 14:16, Eric Biggers <ebiggers@kernel.org> wrote:
>
> So using crc32c() + ext4 + x86 as an example (but SHA-256 would be very
> similar), the current behavior is that ext4.ko depends on the crc32c_arch()
> symbol.

Yes, I think that's a good example.

I think it's an example of something that "works", but it certainly is
a bit hacky.

Wouldn't it be nicer if just plain "crc32c()" did the right thing,
instead of users having to do strange hacks just to get the optimized
version that they are looking for?

> Does any of the infrastructure to handle "this symbol is in multiple modules and
> they must be loaded in this particular order" actually exist, though?

Hmm. I was sure we already did that for other things, but looking
around, I'm not finding any cases.

Or rather, I _am_ finding cases where we export the same symbol from
different code, but all the ones I found were being careful to not be
active at the same time.

I really thought we had cases where depending on which module you
loaded you got different implementations, but it looks like it either
was some historical thing that no longer exists - or that I need to go
take my meds.

> IMO this sounds questionable compared to just using static keys and/or branches,
> which we'd need anyway to support the non-modular case.

I really wish the non-modular case used static calls, not static keys
like it does now.

In fact, that should work even for modular users.

Of course, not all architectures actually do the optimized thing, and
the generic fallback uses indirect calls through a function pointer,
but hey, if an architecture didn't bother with the rewriting code that
is fixable - if the architecture maintainer cares.

(On some architectures, indirect calls are not noticeably slower than
direct calls - because you have to load the address from some global
pointer area anyway - so not having the rewriting can be a "we don't
need it" thing)

               Linus

