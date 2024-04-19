Return-Path: <linux-arch+bounces-3819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606698AA9B1
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16090281D5E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2DC4CB45;
	Fri, 19 Apr 2024 08:03:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCF4F214;
	Fri, 19 Apr 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513785; cv=none; b=EhhkNrLlVvmlqalar+hkSZhA5SjSqIhi8L1t6iITGrwTNVHjXp878X2LOH15dHVvVGDlGKq+5vZLbgDIVEC/VCTTge4uk05o/H8ALUpfuMySeW5mGZtMtDLKiYCmlNNCng0C7dBkuqFbZBwI5JBjXeCByvVdrbzyZ5WLw7QU1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513785; c=relaxed/simple;
	bh=n+2UavZoWcsMp93Asn21Hjf0+Jmf3KsEWYo3YxN6e70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bs3zEoDK2ESMTSGO81MltCecrSgy20sxSzTrZdtZCIzPzyfdhClK7rft0x5DAQYc7p9pN3h06QOlDfElIKveJGoSSaSlyhgiUyhnWRjqNmuaUOaiFSIUX8UzxMN3N9oO71qYZKaKFU173KYUOsOjt4MeU60mep7+aNM0QXxI1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6164d7a02d2so20523557b3.3;
        Fri, 19 Apr 2024 01:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513780; x=1714118580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgeGXet2e4SNWNIf1k+Rx9MxbJvkfUif/WiEiHZ/LzI=;
        b=w6pICn16tvg++licOjeznZrliftF1oRRN1ME0PhaO6epQ0715nBOtAMUY3ZLzi9QIo
         uuS8lO3OZzaa3eUFAausAfBnPiPQguuAzrWgjxTDI2Se4aa6xanF3uAm/y5aWAsUPOWc
         t7AXQLY/UB7StdAtS5FrV7a8xWpzzSGb7OqxrFL4hy0LLAFqNqjQBlerhvUncJmlXpJP
         mF3GBqPwFWxzz4PFw3FmpLEgz8bsQ7IGesHNix30J7hg/RAhEWHTI9KUstXnwk4Z/oCb
         UZcyN2vKwx0NKCjV4VgQx8+nXMpVenTfvOmMGXmYOXpeHnZ91K277kwx5OaXXPddMuGg
         PBdA==
X-Forwarded-Encrypted: i=1; AJvYcCUIfDuI5qrwWULHVd2UGWcehwwV473DLnY2hhALkZ6mZ5Z/zYibcDeSFuGICPZsyZBsLxADWyll9MwUmOiWE/XOM9OE9jyUSjQvui4/ubXHqinXRPX5OHW9uh1ICR3U4PWEp9U909LpDA==
X-Gm-Message-State: AOJu0YxHqoGT9EPTFOpPsZprPh+ZzMxe+iZAkx6+PzROAdWyelvxAAoc
	tZhJ6ZeYmIZzNBJGJLNf+x5pcQRHekn76Ywxfq2OV388kOww20ax0R2CMCYM
X-Google-Smtp-Source: AGHT+IH6ond2r24lWkM+sInsfHWcCCKgD48YYyOQfdjWxpLhUFVXZVM2Wb1XZOAlBa0d084W6K3K8Q==
X-Received: by 2002:a05:690c:c81:b0:61a:cc3c:ae69 with SMTP id cm1-20020a05690c0c8100b0061acc3cae69mr1330246ywb.18.1713513779641;
        Fri, 19 Apr 2024 01:02:59 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id t20-20020a81b514000000b0061ad6e89bdesm673551ywh.108.2024.04.19.01.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 01:02:59 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso1979109276.0;
        Fri, 19 Apr 2024 01:02:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQWPnecDAXcy4lhTEEKePowM4qp8ARS+Uzydd1t/j7Pkw68HQA1AB2V+vyIEQVWG5H2TZnY/DY2dlE0v/1zIk+SZ4sgrh0kiAMHvTRwcmu4nWgy1Zqm9e/8g68J5/xficf4mPwRaiiHg==
X-Received: by 2002:a25:5f45:0:b0:de0:ea71:9ec9 with SMTP id
 h5-20020a255f45000000b00de0ea719ec9mr1121064ybm.1.1713513778941; Fri, 19 Apr
 2024 01:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-13-paulmck@kernel.org> <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>
 <620a10e8-f5c0-4e23-8403-492ab1c7f110@paulmck-laptop> <ZiH8IBiLkYw7M281@yujie-X299>
In-Reply-To: <ZiH8IBiLkYw7M281@yujie-X299>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Apr 2024 10:02:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWF=O4fEA8aQfhmRhuH88zB3aK1Mi3UCXx8=EaONRRkg@mail.gmail.com>
Message-ID: <CAMuHMdUWF=O4fEA8aQfhmRhuH88zB3aK1Mi3UCXx8=EaONRRkg@mail.gmail.com>
Subject: Re: [PATCH cmpxchg 13/14] xtensa: Emulate one-byte cmpxchg
To: Yujie Liu <yujie.liu@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, torvalds@linux-foundation.org, 
	Arnd Bergmann <arnd@arndb.de>, Andi Shyti <andi.shyti@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:14=E2=80=AFAM Yujie Liu <yujie.liu@intel.com> wro=
te:
> On Thu, Apr 18, 2024 at 04:21:46PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 18, 2024 at 10:06:21AM +0200, Geert Uytterhoeven wrote:
> > > On Mon, Apr 8, 2024 at 7:49=E2=80=AFPM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > > > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtens=
a.
> > > >
> > > > [ paulmck: Apply kernel test robot feedback. ]
> > > > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > > >
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/arch/xtensa/include/asm/cmpxchg.h
> > > > +++ b/arch/xtensa/include/asm/cmpxchg.h
> > > > @@ -74,6 +75,7 @@ static __inline__ unsigned long
> > > >  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new=
, int size)
> > > >  {
> > > >         switch (size) {
> > > > +       case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new=
);
> > >
> > > The cast is not needed.
> >
> > In both cases, kernel test robot yelled at me when it was not present.
> >
> > Happy to resubmit without it, though, if that is a yell that I should
> > have ignored.
>
> FYI, kernel test robot did yell some reports on various architectures suc=
h as:
>
> [1] https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel=
.com/
> [2] https://lore.kernel.org/oe-kbuild-all/202404040526.GVzaL2io-lkp@intel=
.com/
> [3] https://lore.kernel.org/oe-kbuild-all/202404022106.mYwpypit-lkp@intel=
.com/
>
> In brief, there were mainly three types of issues:
>
> * The cmpxchg-emu.h header is missing
> * The parameters of cmpxchg_emu_u8 need to be cast to corresponding types
> * The return value of cmpxchg_emu_u8 needs to be cast to the "ret" type
>
> As for this specific case of xtensa arch, the compiler doesn't warn
> regardless of whether there is an explicit cast for "ptr" or not.
> The "ptr" being passed in is "void *", and it seems that a "void *"
> pointer can be automatically cast to any other type of pointer, so it
> is not necessary to have an explicit cast of "u8 *".
>
> As for the implementations of other architectures that don't pass the
> "ptr" as "void *" (such as a macro implementation), the explicit cast to
> "u8 *" may still be required.

Exactly.  On sh and xtensa, the original pointer is of type
"volatile void *", so no cast is needed.
On E.g. arc, the original pointer is of type "volatile __typeof__(ptr) _p_"=
,
which is not always compatible with "volatile u8 *".

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

