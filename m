Return-Path: <linux-arch+bounces-11777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C1AA6526
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 23:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84189859AF
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C082609DF;
	Thu,  1 May 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gBx1c6u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E61E3DFA
	for <linux-arch@vger.kernel.org>; Thu,  1 May 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133933; cv=none; b=KacSNxxkf0XKRSwC91xI7kY9CHmXLhzbkn28G2jOIcZvrndQqyKOhsXG4hQRuIttod6InEREcJPlLc1p6LP4ePtsykGS5FAGB4C6wdf3Ccs4CtbFg0JqZOdt/C5u9aEEI6066+RkXc5sUHpLCNqV0u2xGo5EkW6nZF1gu0Lw9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133933; c=relaxed/simple;
	bh=/Eb23qJBhyHlMhuJZd/Tff5w9BO6SQY+7OdWqtn+OBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9weIX1G+09bARzCCDd1Gkes/NjA9KdKUVC7pwqcRXuNnnTltau94irSaKgYmf1a4p7cHa7phOahB7g+iaOFyklVPDWzTOm6QoKhxzL11yuG74JQDJhBT8ysff4c4yKAMkPX2tJgudq10ENjA/nbsq/q4NufFikbiMR/2lR/BL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gBx1c6u; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so41535ab.0
        for <linux-arch@vger.kernel.org>; Thu, 01 May 2025 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746133931; x=1746738731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCZkInUa43XvzVkTgrWtsmIIL8E2slTp2+RlsbLPc/E=;
        b=3gBx1c6uPJa/Cgpao7mkxSf1S1AiJ+rSyqZ6duNiWjsrr3akQXFCskUdR90rpqBgyf
         8vpgrJEwsuDW02zLQKs5t/4BzK6drhZel/zBuWd3tRYCQW9acc6IgKFrzdeBynxkt8uY
         TTmvQDnzJK6TDXIpnNQjpzVuL4gH0I1Q0YZxhn2P6MyIPW3ArG1mA7k1lVfCCpLIRedD
         GSj6uvBqUKqOGP8ZaqUlLkglcgpSnEI93ZMViPuYXhhlseZpNJCD/fwWCZ/uB8cixHNE
         Brgv6dLWZM63zqmlX4IbPlRgaVTlAjqERAITfSwAaVmcTE1I16PEIYbDSqkZIGj6B1UL
         qy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746133931; x=1746738731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCZkInUa43XvzVkTgrWtsmIIL8E2slTp2+RlsbLPc/E=;
        b=DOdl0aDP2OKAtHB5G0y8RASlBOVB+RQaPtFVu5u0yDWS/NBG9VsxDy3TPwPaW26Sfc
         gewGO+nF8aJYXtSvazkjGgdJMTDEvxK85AYQCv1T4Ctr/LuMHxrsMU5njvjwmgHZXMrn
         XV2lRtFfgBciLvk5CPnF1IuwwldIW20cdJMFqDe5m0n4RHV8nlArHWbTD79ZA8DxiFEX
         BRdN+rreMKfYZg5g1Ysh4WJ0nAwLP4P6q8xNFaIKbtTV5ZOxpOR9Tou2G2LX+nmDWLsT
         pntrhEwWhgxalRIJXGNXgK3OAVmrRML9cfvjKoFI5fg+2b9tDAVppPKCGgM12owxVkUS
         IQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWNl6p28IuJp/h3QW+nfRQj31MEJ4YlANLFn1mfoCvpThc5aAvAm8QUB6GpbUPiOolJXFcslYVmj6r@vger.kernel.org
X-Gm-Message-State: AOJu0YykjTvO1iQn3Js+fSO8HQ5MmpldkLZ1lNy/DJKXz7bLcu8nkLnt
	0hEHOte6oGEXdIBpiNQG+ycvMdOCX9Zb1GNvDlggfnliX4z119BD5GDHCug3rbqa8sJw+H4RyrX
	4MR+5XcJ7XbevO/YYv6q+dprQlyTcDIfuerQZ
X-Gm-Gg: ASbGncudRwAW6eNz6YjD5xsw8gjs5vLCYgK3JxStAHxA4anBU+BItmSU2uhsfkcOKNq
	ddyVQdnKYmlOc622McdLA/9eMB669+8Oh1Ji3YFnYmzx4/vUAI76E5pkFtG/YyAYf38n7yWx3WL
	Q78Q8ZWKfHdtuzAhuBJnZbbXCuP/4RFzL38ucArhyKQl3XTUBQp+7rRK8uI4e0tQ==
X-Google-Smtp-Source: AGHT+IE99CKIC22IVzgDs015sHGpd/5BSYT3SVvkHXeo8sNfxIPZdJFCnU5B2adsGYjONhE7TymIKB+d0HAj2pTW8Zw=
X-Received: by 2002:a92:cdae:0:b0:3d9:6cb3:d6d2 with SMTP id
 e9e14a558f8ab-3d96f22d89dmr4887205ab.4.1746133930728; Thu, 01 May 2025
 14:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430171534.132774-1-irogers@google.com> <20250430171534.132774-5-irogers@google.com>
 <20250501210729.60558b33@pumpkin> <CAP-5=fXrhsZYJwjJzqb-zMg+UoC-bKoYCjstq8yD9wHNCfbS5g@mail.gmail.com>
 <20250501212659.7e642411@pumpkin>
In-Reply-To: <20250501212659.7e642411@pumpkin>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 May 2025 14:11:59 -0700
X-Gm-Features: ATxdqUFxaht-zoWQknlLFZvQ7KKBfBCHWsnBwcRW0qV3e-0LXiEzKSMCN1_1aBg
Message-ID: <CAP-5=fVjAR0g=wN8sWetHoNWdoDVGNoKb8d8UdwxF_te=wmMLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] math64: Silence a clang -Wshorten-64-to-32 warning
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 1:27=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 1 May 2025 13:15:30 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > On Thu, May 1, 2025 at 1:07=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Wed, 30 Apr 2025 10:15:33 -0700
> > > Ian Rogers <irogers@google.com> wrote:
> > >
> > > > The clang warning -Wshorten-64-to-32 can be useful to catch
> > > > inadvertent truncation. In some instances this truncation can lead =
to
> > > > changing the sign of a result, for example, truncation to return an
> > > > int to fit a sort routine. Silence the warning by making the implic=
it
> > > > truncation explicit. This isn't to say the code is currently incorr=
ect
> > > > but without silencing the warning it is hard to spot the erroneous
> > > > cases.
> > >
> > > Except that the extra casts make the reader think something 'extra'
> > > is going on.
> > > For readability you want as few casts as possible.
> >
> > Agreed except when not having the cast can introduce bugs which is why
> > the cast is always required in other languages. Consider in Java:
> > ```
> > class a {
> >   public static void main(String args[]) {
> >      long x =3D args.length;
> >      int y =3D x;
> >  }
> > }
> > $ javac a.java
> > a.java:4: error: incompatible types: possible lossy conversion from lon=
g to int
> >      int y =3D x;
> >              ^
> > 1 error
>
> I'm not a java expert, but I suspect it has 'softer' type conversions
> for integers than C casts.

Sorry I don't understand what you're saying. Java certainly has bugs
in this area which is why I've written checkers like:
https://errorprone.info/bugpattern/BadComparable
For code similar to:
```
s32 compare(s64 a, s64 b) { return (s32)(a - b); }
```
where the truncation is going to throw away the sign of the subtract
and is almost certainly a bug. This matches the bugs that are fixed in
this patch series for the perf code, in particular an issue on ARM
that Leo Yan originally provided the fix for:
https://lore.kernel.org/lkml/20250331172759.115604-1-leo.yan@arm.com/

> I've been badly bitten by C casts that make code compile when it really
> shouldn't, or incorrectly mask off high bits.
> There are actually loads of them in the Linux kernel.
> As well as all the dubious min_t(u16,...) there are the (__force ...)
> where the compiler shouldn't see a cast at all (it is for sparse).

Are you arguing for or against checks here? It seems to be about
casts. I'm not getting you.

> > ```
> > Having -Wshorten-64-to-32 enabled for building with clang would allow
> > possible mistakes to be spotted, but that's not currently possible
> > without wading through warnings that this series cleans up.
> >
> > I also don't really think anyone will be confused about the purpose of
> > the cast in something like:
> > ```
> > al =3D (u32)a;
>
> And no one is confused by what the code is doing without the cast.

Someone who saw that `a` was 64-bit may assume from the assignment
that `al` were also 64-bit. The cast is making explicit that you want
to throw away bits after the bottom 32, so I'd disagree.

> We live with the 'integer to pointer of differ size' warning,
> but even that was only really useful 30 years ago and is well
> past its 'best before' date.

You want C to be weakly typed more than it is? Not sure and it seems
we've drifted far from the topic of the patch series.

Thanks,
Ian

>         David
>
> > ```
> >
> > Thanks,
> > Ian
> >
> > >         David
> > >
> > >
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  include/linux/math64.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/math64.h b/include/linux/math64.h
> > > > index 6aaccc1626ab..f32fcb2a2331 100644
> > > > --- a/include/linux/math64.h
> > > > +++ b/include/linux/math64.h
> > > > @@ -179,7 +179,7 @@ static __always_inline u64 mul_u64_u64_shr(u64 =
a, u64 mul, unsigned int shift)
> > > >  #ifndef mul_u64_u32_shr
> > > >  static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigne=
d int shift)
> > > >  {
> > > > -     u32 ah =3D a >> 32, al =3D a;
> > > > +     u32 ah =3D a >> 32, al =3D (u32)a;
> > > >       u64 ret;
> > > >
> > > >       ret =3D mul_u32_u32(al, mul) >> shift;
> > >
>

