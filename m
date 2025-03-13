Return-Path: <linux-arch+bounces-10747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FAEA5FED5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245031893542
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18F1EA7D4;
	Thu, 13 Mar 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVmEhSdO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80891DC9AF
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889288; cv=none; b=rLQhu0z+BFWOGMNcF4A7SGsxb+uyRszbamQVVBdGcWDVK4R5bap5TECtB4DlqJenFP/PWOQFrZzoLxkl/sG1Bpy4IsfvsHamdkJwH1LEn9CF3deuUX2+vGShvZJ07TZheFSZV/pBYZOlkqU+Y+n1tdDm6LTojIQ9E73D27Qh50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889288; c=relaxed/simple;
	bh=UkNKXb1bKramp3ecbD5yyn/qkZfQyoZLvEdDU3QZzHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp5CU0gTQx7LqatmZ+AQ34cazg7KXt6raVOvc4Gv16X8JEiDx6pH9bL7yoIHKiEzL+triuk4ehzz4IjhwBntjEYG0FXG5+8kpHFOdn6bEZTaFQFXuXqoef+iJWw24MJSHrfR+I5QmetpUyxOhntdAqhxJ+hNa2bY+VUyAFDsXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVmEhSdO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769e30af66so29861cf.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889285; x=1742494085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ3C4fOkeNWFHbw5y8h5vEhHAYC7Z2Nh+a7nGhBzcEA=;
        b=JVmEhSdOuZ0EGN/kFyDiKUEUx9zOgQUnWqOb4kfI8V5p3tXlPQsfQJDW1PaobEiun7
         XrQV3es3S2mknWDaUT5C7Gpq1Xuokwd8Hk3oMaPMEXsCwx1b7JKfmIgPQ1OVjUaLbhEh
         b3YQmVF3L+RGtVpgz6im5drDMUbvWz83JaXcbvY5UFrDCdqh4FCIgD1lWLmkL/IaiM4U
         Ori10N2WUAkS1hLJH/kGj8ri/kmr78mu51hClwATOd7yrN+ejIoCN9H6W0XKgzYrHTv4
         /7dmUCnkqMbKOer8dNeE/2+x1rXErN4EIJpRk1fucKIQyuyRp/NKMWLmY7r9TCeluSYc
         9ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889285; x=1742494085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ3C4fOkeNWFHbw5y8h5vEhHAYC7Z2Nh+a7nGhBzcEA=;
        b=oRhEq1D0A8B2srhCO/LEoLj9vaJ5xpLGnXV+nAZPSG67u38cQNpWNvtNYh5P/2xSRC
         mB7V/3ujRdZQD0JMbw6Okl4gp5hbPli4bY4DmNWXRdOIX5fAcgdHhHLYShFOyKL7qCSN
         tPrpZYDa28LAkku2FoAa7LpMm3lA+7M49/bzAMv/Iz7lCJvRbYCzV4UmDsjE8zFTtx/e
         ZOPdUlj1k8mKn03omGrwWVKlyyjC0RmwPuDHLevLfkiMGG72sJ76KWTJX9ZJpyTsXhgB
         C9mZp5c6R2A2/dUbmiWUETFlFgpGYQl0BBZ205OXhHy98NbeGpjys+dRdvt1catfyY3D
         NToA==
X-Forwarded-Encrypted: i=1; AJvYcCWDzxiXYu7BCB0tUDoKqXg8SYkJVf0NQfw9zniuXjKrUsD1+8ho7Z8CbwRZoJPwPonpBwTOdfI5tEMU@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCABYCLTb7gOTwAnCr9FMAUePrXXzAv8SenjKMmUO4x07RQUG
	AV10PNCpnuHu21e5Po+i0wpDohiRgGF5DjsHJbHUGC+QC04/EGEV/AKihM35JeOkLnjsxbRdkTU
	I47fwikeSlnI0p8rcDJRpIKF1MVt/qgx4zS4E
X-Gm-Gg: ASbGncvsfn6ThmqYDQbaBLK5+4qV/Eay32Owp39OWS1ZbRRSP/KyU9rR44A1hd4qSI8
	5Jp7JGbtyVi2yrDRXmbU4VxTxm1zMSuNhQxtS1LCpc8DKaelXqs8nc87uf9C2XSezYu81EFYRmF
	73R3mHx01Ecx42V9liRt29Ism4c8Chf4+UFqg0/PKkGiRkWhfUpCVI2b6a
X-Google-Smtp-Source: AGHT+IHrpWqTbMqDznsTHsJ8E9Do30+x9d4gdSw8dj7dE/tKMqx+yW62kkvZYTMbk6yRcBICLabCKUwu3xD7MbVZ4tg=
X-Received: by 2002:ac8:5f4b:0:b0:471:9480:a14b with SMTP id
 d75a77b69052e-476c6a5313cmr230021cf.12.1741889285223; Thu, 13 Mar 2025
 11:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313143002.9118-1-petr.pavlu@suse.com> <jmcazyqlkimqhswwqn2du7ik5sbm5fommonrgovy5d6knqbqcr@xebmu4akkkoy>
In-Reply-To: <jmcazyqlkimqhswwqn2du7ik5sbm5fommonrgovy5d6knqbqcr@xebmu4akkkoy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 13 Mar 2025 11:07:53 -0700
X-Gm-Features: AQ5f1JqTh6MJsjdch2B1hiY959vhHY_r5y3ZS715LvCN36Z2QzffjAcAKrSyahw
Message-ID: <CAJuCfpEpFqLX-WtXzSdktkp7w3s3JWeSqeG_fms6Ydun+docTA@mail.gmail.com>
Subject: Re: [PATCH] codetag: Avoid unused alloc_tags sections/symbols
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:16=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Mar 13, 2025 at 03:29:20PM +0100, Petr Pavlu wrote:
> > With CONFIG_MEM_ALLOC_PROFILING=3Dn, vmlinux and all modules unnecessar=
ily
> > contain the symbols __start_alloc_tags and __stop_alloc_tags, which def=
ine
> > an empty range. In the case of modules, the presence of these symbols a=
lso
> > forces the linker to create an empty .codetag.alloc_tags section.
> >
> > Update codetag.lds.h to make the data conditional on
> > CONFIG_MEM_ALLOC_PROFILING.
> >
> > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>
> Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  include/asm-generic/codetag.lds.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/co=
detag.lds.h
> > index 372c320c5043..0ea1fa678405 100644
> > --- a/include/asm-generic/codetag.lds.h
> > +++ b/include/asm-generic/codetag.lds.h
> > @@ -2,6 +2,12 @@
> >  #ifndef __ASM_GENERIC_CODETAG_LDS_H
> >  #define __ASM_GENERIC_CODETAG_LDS_H
> >
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +#define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
> > +#else
> > +#define IF_MEM_ALLOC_PROFILING(...)
> > +#endif
> > +
> >  #define SECTION_WITH_BOUNDARIES(_name)       \
> >       . =3D ALIGN(8);                   \
> >       __start_##_name =3D .;            \
> > @@ -9,7 +15,7 @@
> >       __stop_##_name =3D .;
> >
> >  #define CODETAG_SECTIONS()           \
> > -     SECTION_WITH_BOUNDARIES(alloc_tags)
> > +     IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
> >
> >  /*
> >   * Module codetags which aren't used after module unload, therefore ha=
ve the
> > @@ -28,6 +34,6 @@
> >   * unload them individually once unused.
> >   */
> >  #define MOD_SEPARATE_CODETAG_SECTIONS()              \
> > -     MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
> > +     IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
> >
> >  #endif /* __ASM_GENERIC_CODETAG_LDS_H */
> >
> > base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> > --
> > 2.43.0
> >

