Return-Path: <linux-arch+bounces-11804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC18AA778F
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6674686A4
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EA2609D0;
	Fri,  2 May 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4jAsoWx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F317DFE7
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204208; cv=none; b=RhcX8+6wD/cRRhN616PrFgNU56z2gEl9dGmHpoEoUHbG1+oAAomb4Vh/LZLeVi329GRvSkVukAouQ/Gy3+yd2rCQeAADo37EQiZkeITTJUvuAxC13pppPV8W7bVEj2CU8DDtLl3Ltn/H50OxIiPEiVXHRdxlDvB9bHJh1G19/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204208; c=relaxed/simple;
	bh=HSWejsQUIC5AVkuX0S8B3IVpbNA6F4zhsZS0ah5X99o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeLByKIWX/sdlzn0b98srOLxGw09Kh2bUrF//UTEdXPECugK5xdjd4YopfifqFJ2UZkQrro4ej28iFhUNHBmqAfRijVlEXD8s3mSuCxgOKz+kuXNXTHmz6dO2dMPl8uiNX7xWr5L98grwpCxsxkizGiQ2Zj4e2xhcXKc+90iPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4jAsoWx; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d91a45d148so295ab.1
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746204205; x=1746809005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfhSF1OBdwUfsA1pakNcUwq7Cj4Gcs5LK2vK2irHdRY=;
        b=W4jAsoWxAl2hQcwXwKhaxrR5OTdkXvIMnG65vu+uH9e4Uo74a/G0jAWzW6P19qaFyx
         qk+u0KyQV9Id/WoB3zxf11uhqi56tHH2wHEpWP846hsOLXjBjCmdEBdcD6HK/OTnPS+y
         uHBAYPTy5QyS04PNnK//ttWYwzwAeCmSfEp+KYuGr87yGzCpiraX63BFkvFr6yhMFAt7
         eBJ54KhZFhv1aMaMW9T21BrDJR9DMBSvQ+ppluvftRF6hfqo5Q8Sy8Fajivp51V/hYgp
         KFhKoda4OOP15zmSWGH4O36kpYPxk8KcqryX4vmNGxYsFrqKhmzKZMcMCVRH4cxvDvao
         oYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204205; x=1746809005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfhSF1OBdwUfsA1pakNcUwq7Cj4Gcs5LK2vK2irHdRY=;
        b=p/uq9mUFk5DCRXiQkA9RsYjxU3g9Wq/+DtNPMqvcsjt6Okz+Ne0IcME9Abq0A2SaVY
         3CY+2VUCsKeT8YHxC3ogASL42If5+XqodSbz2VGTYm2dBqJDSaAuH4ZMHSRJXouT5DjW
         RnTvnGQTKC/AENrrtnDeucGKhgsCXfsW8c4kbHd1g6ZnJpA9whKOfA820eW8/BvXvivW
         Z9KQBQrOeiZMhz3CGmQtaCNnxuA9z+g9s2bSvqTdCwn4/zNlhBmtcDwMTktqzE34iLlF
         +lS/lEIAWXM4ubcxXQdMPGS+OkJjoQ9wyy4aNR9MJAr0BZYIErW73Da/IIUiM1vxzDlE
         yVvA==
X-Forwarded-Encrypted: i=1; AJvYcCXidBjxQGdefJHqxLMm21TP4ElXIPLQnAw72hELSNOgb8gradhQQ6q9krxny6zvQpDW+1GL+LsJ2TRm@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpqj1jp29Dn9bTKVvPYtrR61IhVwh4AR9SKGwbLB1Iz6TociY
	+b9BCJY3Nfgay1IVsz6iGtfwRMZYvxUsLSfCEkVKk+rmqlDeUcqqDg6Y4c170cdfdKZJIZLihZ9
	FEezPSa40VfYPL5LieQmTqQ/rOY3O8uxR83bw
X-Gm-Gg: ASbGncu1lKESJboH5kyhcWPA3nsi8wx67JJ0e4FKeE+3ohgQZXLQYTMMGIw4DvM7rkI
	6l+WedjD3T/oWweAmT6Fq5U+ShEAztwP9VRaZrUP9gJNSayjZDnW/6N7YOz/RKr2W5c1Ssha04Y
	/lGARP9NdG9Ou188TrpEnrTjp5x9zWXlrb1g==
X-Google-Smtp-Source: AGHT+IGl8Ey1mD7g9HdYk+68mf77nPG69tteIpFx6Qvv3ot7wI3HcIw7QJ3SYNwPij9nPcd00LD5BKx8PJeqjrdMYP8=
X-Received: by 2002:a05:6e02:b4c:b0:3d9:6463:a8cd with SMTP id
 e9e14a558f8ab-3d96f2523dcmr6638415ab.14.1746204204424; Fri, 02 May 2025
 09:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430171534.132774-1-irogers@google.com> <20250430171534.132774-3-irogers@google.com>
 <aBTs6yvKlCYYgU2O@yury>
In-Reply-To: <aBTs6yvKlCYYgU2O@yury>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 May 2025 09:43:12 -0700
X-Gm-Features: ATxdqUEaNzyEBZLtUQ1jfImxKvfknBZnmDSgU_oST5gHw-xFYWsjcme0fXmFH_E
Message-ID: <CAP-5=fXqLh7RdUok5oqVwyGOWCH3fktmVeECdi4ENBWnEHeJYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] bitmap: Silence a clang -Wshorten-64-to-32 warning
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:03=E2=80=AFAM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Hi Ian,
>
> On Wed, Apr 30, 2025 at 10:15:31AM -0700, Ian Rogers wrote:
> > The clang warning -Wshorten-64-to-32 can be useful to catch
> > inadvertent truncation. In some instances this truncation can lead to
> > changing the sign of a result, for example, truncation to return an
> > int to fit a sort routine. Silence the warning by making the implicit
> > truncation explicit. This isn't to say the code is currently incorrect
> > but without silencing the warning it is hard to spot the erroneous
> > cases.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/linux/bitmap.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 595217b7a6e7..4395e0a618f4 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -442,7 +442,7 @@ static __always_inline
> >  unsigned int bitmap_weight(const unsigned long *src, unsigned int nbit=
s)
> >  {
> >       if (small_const_nbits(nbits))
> > -             return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> > +             return (int)hweight_long(*src & BITMAP_LAST_WORD_MASK(nbi=
ts));
>
> This should return unsigned int, I guess?

Hi Yury, I don't disagree. The issue there is that this could break
printf flags, etc. reliant on the return type. I've tried to keep the
patch minimal in this regard.

> Also, most of the functions you touch here have their copies in tools.
> Can you please keep them synchronized?

Yes, I do most of my work on the perf tool in the tools directory and
these patches come from adding -Wshorten-64-to-32 there due to a bug
found in ARM code that -Wshorten-64-to-32 would have caught:
https://lore.kernel.org/lkml/20250331172759.115604-1-leo.yan@arm.com/
The most recent patch series for tools is:
https://lore.kernel.org/linux-perf-users/20250430175036.184610-1-irogers@go=
ogle.com/
However, I wanted to get the kernel versions of these headers agreed
before syncing them into the tools directory.

Thanks,
Ian



> Thanks,
> Yury
>
> >       return __bitmap_weight(src, nbits);
> >  }
> >
> > --
> > 2.49.0.906.g1f30a19c02-goog

