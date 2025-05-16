Return-Path: <linux-arch+bounces-11980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDAAABA1DB
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2425A2247C
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1526D4F1;
	Fri, 16 May 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEdk/ax+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F026B974
	for <linux-arch@vger.kernel.org>; Fri, 16 May 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416467; cv=none; b=cNtxj4vYSmivfHronb7kvxqjdNW6RhckSi7PmB0CzSDvr0a7Kl1vFNA/EbY7mKyRJ9161WOY0Jx9E/hziAVipBlhm5n+KPB1tG4buAFinURbG4g3IAqQ1bATRlwPDgbTR6YOhSxD6TMg50+YInp7YITZmnM4k3CeCbYU54SI23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416467; c=relaxed/simple;
	bh=MtylXcFWq3qn98jvL766Uh0qOHpS0CsyIpl7lZrz5yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zvt7zBOH3Mqxfg9Wk/Bbct/gmokA0osl6pPRubo1LKYAdLKbCYwt8Y40UJGwtsGgGKOXPSW4uRgeOZymuGPSC7faujtgs8eZcUQOnOHcTZINtJUvVCoJdN7BJpZUUoaxCxLexe8EUWim4h47zP7qOl4pudJKAZaneU+EmWKB778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEdk/ax+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22d95f0dda4so25441125ad.2
        for <linux-arch@vger.kernel.org>; Fri, 16 May 2025 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747416465; x=1748021265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xWnBIK0SHaIhFLuBsh2KnXQeheJaU2ELmMMx1MjgmU=;
        b=zEdk/ax+4wOwzxkI1bzlTMyy28dSo11kEwVhnf/Nbv0W3oZYkoilyux2DpvnRMCf00
         i0SYTC1uAv3ZyXjSs8o8riWnpsYRvTYij4upwBIwln7tuI2CKHJs7Q7Xr9a1Wyixqiyn
         EuqhsHGRnOmjgVN414OHgpDuvbN/Zm+YfHnkxboz7nPOXL4dMSZFulQ1qVuyBAq/6MG0
         k4BwineXzLX9O+u0fI++zHTHxzYrBgBIRpn0QuC6S127fc/IP9GblPjN6FIlrPPCasSM
         ZGwAx9j2sK/5WriqFxh3n97k2qAnLkwJJEYlXqvTbSbdvLH8kbMHRs+4Xi5t4GBPTWB0
         8+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747416465; x=1748021265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xWnBIK0SHaIhFLuBsh2KnXQeheJaU2ELmMMx1MjgmU=;
        b=wciyRRLMAxqx8hltN1zSyxRwwEhE4SOHuShbeNy6SwDb7y0x/gq7C2WbQt5Tbht3I4
         1xOb/gfvh8FffHfcUsyYvGp8zb/QalIRdOOHe6VKq0RoHU1pl1I2rPoRZ5q3mX0HOUR4
         JE2bWcPqgIyW1bSb4bwoAlN9xenRgbB4dXLatN+yZLaCcfwfkXFdr6yQ8MEHUX5JvyqO
         xGeD0ZmVvcYaM03TjEfcpoBItwrXOzodi2CytjCcaxRb0lrM5pJ3Bdj7cKOgGghlIjz+
         TTH6Pqm3zM8w+xhb485dCQ9TISdE4BGCeSKWhZgDJD0Xd6tzcgv15EsyHQW22sLJMh4D
         RJGg==
X-Forwarded-Encrypted: i=1; AJvYcCWc8WRPU9FWeewc0Z0q56PJJAY4pW5oK16bixa38Hxdq4eo96zYGyExrsz0ChRfqnsqgifepzghGCys@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsrclk71MDlLsl3vAYJccjshRuc4Hn5u9sDmBdvqLcE9LFk/pR
	ov+3G61FJGBzqWLH3Kwn/KfX09e8enRXwRWoNyNjZm4KC4ARMCEKL5+SuXz2zStOW75thHlDSSg
	a6RHSpUswMuzmNJbf09UOWmLDwf6hqd9Xg8TgR9fP
X-Gm-Gg: ASbGncuQcJPje0RsSfLl5VAy0p7XemQtU7bH5gyZN3A9iTZBCcMgaLAxLHkuk30XlFm
	9XDOLS3DW00o8M6S1Q0SXarPeS5qXWOGMipLUif81j0jfNUhm/JBHd2J4de+yW33BGBGcHJ+fe0
	r3WLlWCL0LldtvoUaEr/Hmq/h7OxzEdA==
X-Google-Smtp-Source: AGHT+IGhCWNYC+IAAY8uUYKdNEo3LXDAH10+Ml7x60i0AWrRxDwoK9ysOTWLwdZIZxUSqIy9U9H/H8DF+PsXOShKbPc=
X-Received: by 2002:a17:903:94e:b0:224:910:23f0 with SMTP id
 d9443c01a7336-231d45bcdffmr56054745ad.49.1747416464305; Fri, 16 May 2025
 10:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
 <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com> <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com>
In-Reply-To: <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com>
From: enh <enh@google.com>
Date: Fri, 16 May 2025 13:27:31 -0400
X-Gm-Features: AX0GCFutJkc9E21NiBl3aAEK8ZxdmOqIr50qfqXqxPgOJNZ-7bPmZ2Q9VWGIOiA
Message-ID: <CAJgzZopjvYgKTRLD6X9f1EiEo2AsEeyokqfNuO8EjdZ71-c-6A@mail.gmail.com>
Subject: Re: Metalanguage for the Linux UAPI
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, libc-alpha@sourceware.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:24=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On 5/15/25 13:26, enh wrote:
> > On Thu, May 15, 2025 at 4:05=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> =
wrote:
> >>
> >> OK, so this is something I have been thinking about for quite a while.
> >> It would be a quite large project, so I would like to hear people's
> >> opinions on it before even starting.
> >>
> >> We have finally succeeded in divorcing the Linux UAPI from the general
> >> kernel headers, but even so, there are a lot of things in the UAPI tha=
t
> >> means it is not possible for an arbitrary libc to use it directly; for
> >> example "struct termios" is not the glibc "struct termios", but
> >> redefining it breaks the ioctl numbering unless the ioctl headers are
> >> changed as well, and so on. However, other libcs want to use the struc=
t
> >> termios as defined in the kernel, or, more likely, struct termios2.
> >
> > bionic is a ("the only"?) libc that tries to not duplicate _anything_
> > and always defer to the uapi headers. we have quite an extensive list
> > of hacks we need to apply to rewrite the uapi headers into something
> > directly usable (and a lot of awful python to apply those hacks):
> >
> > https://cs.android.com/android/platform/superproject/main/+/main:bionic=
/libc/kernel/tools/defaults.py
> >
>
> Not "the only".
>
> > a lot are just name collisions ("you say 'class', my c++ compiler says
> > wtf?!"), but there are a few "posix and linux disagree"s too. (other
> > libcs that weren't linux-only from day one might have more conflicts,
> > such as a comically large sigset_t, say :-) )
> >
> > but i think most if not all of that could be fixed upstream, given the =
will?
> >
> > (though some c programmers do still get upset if told they shouldn't
> > use c++ keywords as identifiers, i note that the uapi headers _were_
> > recently fixed to avoid a c extension that's invalid c++. thanks,
> > anyone involved in that who's reading this!)
> >
> >> Furthermore, I was looking further into how C++ templates could be use=
d
> >> to make user pointers inherently safe and probably more efficient, but
> >> ran into the problem that you really want to be able to convert a
> >> user-tagged structure to a structure with "safe-user-tagged" members
> >> (after access_ok), which turned out not to be trivially supportable ev=
en
> >> after the latest C++ modernizations (without which I don't consider C+=
+
> >> viable at all; I would not consider versions of C++ before C++17 worth=
y
> >> of even looking at; C++20 preferred.)
> >
> > (/me assumes you're just trolling linus with this.)
>
> I'm not; I posted a long article about why I think it might be an
> alternative worth pursuing. I know, of course, Linus' long time hatred
> of C++, but as I said: I think *very recent* versions of C++ have a lot
> to offer, mainly in the form of metaprogramming (which we currently do
> using some amazingly ugly macros.)
>
> https://lore.kernel.org/lkml/3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.c=
om
>
> >> And it is not just generation of in-kernel versus out-of-kernel header=
s
> >> that is an issue (which we have managed to deal with pretty well.) The=
re
> >> generally isn't enough information in C headers alone to do well at
> >> creating bindings for other languages, *especially* given how many
> >> constants are defined in terms of macros.
> >
> > (yeah, while i think the _c_ [and c++] problems could be solved much
> > more easily, solving the swift/rust/golang duplication of all that
> > stuff is a whole other thing. i'd try to sign up one of those
> > languages' library's maintainers before investing too much in having
> > another representation of the uapi though...)
>
> Yes, that's one of the reasons for posting this.
>
> >> The use of C also makes it hard to mangle the headers for user space.
> >> For example, glibc has to add __extension__ before anonymous struct or
> >> union members in order to be able to compile in strict C90 mode.
> >
> > (again, that one seems easily fixable upstream.)
>
> Agreed... until it breaks again. And how much

that's just an argument for more/better CI though. android's kernel
folks do do abi checking on the uapi headers. there's no theoretical
reason we couldn't do source compatibility checking too, other than
"funding, lack of".

> >> I have been considering if it would make sense to create more of a
> >> metalanguage for the Linux UAPI. This would be run through a more
> >> advanced preprocessor than cpp written in C and yacc/bison. (It could
> >> also be done via a gcc plugin or a DWARF parser, but I do not like tyi=
ng
> >> this to compiler internals, and DWARF parsing is probably more complex
> >> and less versatile.)
> >>
> >> It could thus provide things like "true" constants (constexpr for C++1=
1
> >> or C23, or enums), bitfield macro explosions and so on, depending on
> >> what the backend user would like: namespacing, distributed enumeration=
s,
> >> and assembly offset constants, and even possibly syscall stubs.
> >
> > (given a clean slate that wouldn't be terrible, but you get a lot of
> > #if nonsense. though the `#define foo foo` trick lets you have the
> > best of both worlds [at some cost to compile time].)
>
> Again, that would be a choice for the data consumer (backend), which is
> one of the main advantages here.
>
>         -hpa
>

