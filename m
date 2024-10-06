Return-Path: <linux-arch+bounces-7721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58E991D03
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D1C1C215CF
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459416DC3C;
	Sun,  6 Oct 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJevdzPE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8338F83;
	Sun,  6 Oct 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728201592; cv=none; b=tkXU8vjrM4WNrxM0ahDTQ63bdw2QSv2e0C39wZYSEE3JKVtQwUrIl99xPliRs25+QRzA1HBuZAaVzoGHxp/Jdj+MquuPgMZCA53CKiUDfDuPoJYsvi77MWfHC17ZjuPraXzwFNHBrpXHAZV2RrYAEgn9iMwlo2pynGIU+F7rnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728201592; c=relaxed/simple;
	bh=0WxMKip1+Fw9+cCQhm/3A9AY/qyKiRCE5qbNsKoaojU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PchLrEJs7UwXdIolqE4g1UoikMZCSOPmiOD5vCEopVo2aqF9ZdzDuud3jzQRcki1Cz1PMH12R10UYYgffACGGl4iePNGNtbunfP9xtbwHCf+C+lchmB+NQ5lfpxocv3PQwxEhFysRNiUbvxcS9aj4lA8vHtmb5T9jqjlWnBABWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJevdzPE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso38792191fa.1;
        Sun, 06 Oct 2024 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728201588; x=1728806388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPKYyYBqIk2nde1TDg/wyIZWJzsFsCGXcjUuTc5pqeY=;
        b=OJevdzPEtGlNlxbHIDgOO+1lNvL7ODuxhcAxB1FR7dX8YHK6z4eNRBZuVtjntMPpnD
         zeTxEJ6oYRmDVvD0vZ90hfWSC0rPgSkJui/x84HxYgD9oKHcVpLznQAAO+fbOvQhlTVX
         LTo8HffgFj2Hyh8B+C22+xJ1yO32TB4FPdjn6DnrfqwOO+lgfPJJqkSg77LdflEqEtmI
         RVAr17AhYV8DNdyJPOaquP3AxPYH6sU0A7rvikInuOFyeRPMCbqn0qVD+3f2w56T9Svt
         PXiUVEoU/bMJ8J1XojXTdGvAxt/SmSI/yMH5Mgn2fZISA0lrkIgFdR43FPnVAQ55lnEu
         TMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728201588; x=1728806388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPKYyYBqIk2nde1TDg/wyIZWJzsFsCGXcjUuTc5pqeY=;
        b=Pqdu4rfCDHMCHJ/B07tFwaFXfLLFNbzvRG3ipYmhmLxAhxB7HdDDcU1ITuCPnqT8OD
         UPJdVxhIk2m45MJOd60Aj0dGDhZJoliDw/vJy4GFNvbnyp4RRn3gJ5VyjYpxR9uNE//M
         8tiMWxv3hSy4hSycE6JvuAzmpow7cGu8DkTpzkmQ9yKVGVMaWCHan+7E7S1yEaeOshAY
         ku+zo0HqHGImW1DuZyi5HW9Zyj9f2Zi0amDT9kQWVgY+4S5Ad5bBkoJYE/36YmQFSp3Y
         uuP2u0U1SLYJJCjAI0BzGWfZ2KOYD6Hgc+2W6Y/esP+WDnbMT9O4w6GyMdUTyefE7cFR
         EGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7xqcXYxC2kvadaDPkaP+FtIzetjmuUeOcD+uUHu84NJq8TnWxooN0WWCwxE9UEsdXt0KIhS+KSk5V@vger.kernel.org, AJvYcCUioEptRTQfe8n3fJ/Xi+7tMUlr4YtVPJU2P+CNWRY8M9J+Cli8f9Zckrfc342eq8TuUp0=@vger.kernel.org, AJvYcCUoMMg2v90GiOqpAyC/LuKsuOPweO2xETW4lhVNu8Olfr6eIyzTXyKt2Qxrqlv86AFKdXr1G39/qDK0BPA7s8E=@vger.kernel.org, AJvYcCVHE5n3goGY8QhRrcvl5IU52VRJ3qFf9Hffk8KiSshUT2CkSKWUybb6TSB8R4Ph4mG7Bl7d4ZI3/ZjWv2f3KTqbWQ==@vger.kernel.org, AJvYcCVQ09D00PIajCVmEb0Uxe7sRrr7n3seaefxHtP8sma1kpu0VaQgnRN7HIO4DNqpOv266dHJOnBTh+hm@vger.kernel.org, AJvYcCWLL7w6urDI4YGkTFSNuS0D8tnjtjZ82hJtx0BSRQt37CWGC8deghoKTRPRK3oqQzQohEJ7lGUQTzlgZBmr@vger.kernel.org, AJvYcCWeBLWhnr4EXzzxNv18ZQcfsEUoTqt+dPM2gmDXGwraRgkFycQLDwqZtVY1vz5IICkMWpAd7t5HJxWSm3lJ@vger.kernel.org, AJvYcCWzK/HfO7nX8ByarrXUrPXrMOON+GbCcX2LuBprEl8VxL6izsjq4TyIdjXpxrU8uOxkJEEup2VMVEg=@vger.kernel.org, AJvYcCXWgDTTjpnMNx9MbhWN1TDGR4gQXL+JVu71s/rQ2zxK5zmsGV0dUu3bNqQF4B8CtmretsiQGCYoh0RnLPe8@vger.kernel.org, AJvYcCXoZXxrEGbdwAP7G+wWoarb
 66twgfaO4gZDQPFOe18iPYxDr0W4VyryTJwlvRa/T6Rd4WGDn2TJwwf6HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yI66QOvVaBMSUte3pUHWM3ywtSwwB1XI4f7DwzA2Q7pexwme
	Y8CfANz1lZ/p625PleZDMYj6Wt0xzp8PODT2KCeEqwyajE+44WFS0K3Ho7bXAwz/NmRfQz5r3TP
	jjUbS7Yh+sniRt0ay9LOGJdU6Qjo=
X-Google-Smtp-Source: AGHT+IE2zUoTNKRDJOdgkWI5Cw6UcFhRdeh7rJkjxE6MXyTsb+8X3cwADhQlSBEhykzT0ML1M4fcluEMHpcmKEmwoVU=
X-Received: by 2002:a05:651c:1549:b0:2fa:c873:45ce with SMTP id
 38308e7fff4ca-2faf3c64dcemr33189261fa.30.1728201588155; Sun, 06 Oct 2024
 00:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
 <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
In-Reply-To: <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 6 Oct 2024 09:59:40 +0200
Message-ID: <CAFULd4b==a7H0zdGVfABntL0efrS-F3eeHGu-63oyz1eh1DwXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:37=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On 10/5/24 01:31, Uros Bizjak wrote:
> >>
> >> movq $sym to leaq sym(%rip) which you said ought to be smaller (and in
> >> reality appears to be the same size, 7 bytes) seems like a no-brainer
> >> and can be treated as a code quality issue -- in other words, file bug
> >> reports against gcc and clang.
> >
> > It is the kernel assembly source that should be converted to
> > rip-relative form, gcc (and probably clang) have nothing with it.
> >
>
> Sadly, that is not correct; neither gcc nor clang uses lea:
>
>         -hpa
>
>
> gcc version 14.2.1 20240912 (Red Hat 14.2.1-3) (GCC)
>
> hpa@tazenda:/tmp$ cat foo.c
> int foobar;
>
> int *where_is_foobar(void)
> {
>          return &foobar;
> }
>
> hpa@tazenda:/tmp$ gcc -mcmodel=3Dkernel -O2 -c -o foo.o foo.c

Indeed, but my reply was in the context of -fpie, which guarantees RIP
relative access. IOW, the compiler will always generate sym(%rip) with
-fpie, but (obviously) can't change assembly code in the kernel when
the PIE is requested.

Otherwise, MOV $immediate, %reg is faster when PIE is not required,
which is the case with -mcmodel=3Dkernel. IIRC, LEA with %rip had some
performance issues, which may not be the case anymore with newer
processors.

Due to the non-negligible impact of PIE, perhaps some kind of
CONFIG_PIE config definition should be introduced, so the assembly
code would be able to choose optimal asm sequence when PIE and non-PIE
is requested?

Uros.

