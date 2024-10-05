Return-Path: <linux-arch+bounces-7714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F0991551
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43B9B20BCB
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB355896;
	Sat,  5 Oct 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQu1KS/F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58932231C8F;
	Sat,  5 Oct 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728117110; cv=none; b=AHUKk98nqHkDqcniESqKC000HHEppf3SXLdE34Lhyt/LZU38h2UHaBQ4paoHZRt8Cbxet5zH7MRwQ+/6WhKvlX87LAco5/0uDfA8R0/JF1yIMJiuJD7/t3TeLjKUHJ49/r0Q42xmJvrp9qPYhrOvvAwdfSaDskCwjpBkcjQY+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728117110; c=relaxed/simple;
	bh=70cU5jNP52zmkSWZHO+lBdHOcE1V/JTH2eNm2kkh0zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzZ4FuRn+JzFUNpYK4eeftCryJu7St05ef86z20wxvzoTydIzblrRlWu7UBIg/MBZ4/r1RCanAsOsQc4hqP0GWn+ZbUDIJ8XqsFysviuYPFNmI55Ve9Ui4f/LwkwTFaOJslTCTOKur8wg2ukeGfdEBgmC64kZ1buMOUmFjAgIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQu1KS/F; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac63abf63so29110871fa.1;
        Sat, 05 Oct 2024 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728117106; x=1728721906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70cU5jNP52zmkSWZHO+lBdHOcE1V/JTH2eNm2kkh0zg=;
        b=OQu1KS/FWp+vzB8M90wWzv2DwL28c54821ES4HbZa+/kKuP7aC4tPzCuACELJth2qQ
         pc9TZ2ISdUc6Q3VGwRml0HF61sHqy00yXzh/B7M2IYtDQuGOx1FTY9tXqGMCjG+Uh1YI
         CH3l6iMAReMliUXAh/KUG1C9XYkm5rF9WqkNCAPtjOQVYHZNAGUauycZEaAo4d/sUvs9
         8Ja3w2AraLXHPkaWD0taM65FMiEx++s1FLs/fIjQAloxQA4Xc/uWuxjbem80Duk1xzYe
         jg4nn9ac/6E4uKdgBLnCooPggnnO0dcKcg03qHT9C/RWGNVAI7CsSpDC6hVc+Emg3af5
         ZAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728117106; x=1728721906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70cU5jNP52zmkSWZHO+lBdHOcE1V/JTH2eNm2kkh0zg=;
        b=BU8HxWJkL0J0MvXjRkBZlUS+kEYYoccrQm/bQBdvqHzhlYDa0a6bJjifAVO1zSrMB0
         0tP2oTQp2sr0GN9oCneHl2sQOx+0hANGRBQWMOvZk9ZIQHsUjeIFsInPLFFvAWZzTMBc
         VYPKcH71a7DlwQeN2hJ5QM/r9SClkvXEN0tBGBotKXEQ1701RVKxfekgea2rBRuny09F
         z92N0WGYw56iYGtYmPmWcYNbLmpI3IAMWwPqioZ+CsOdNV2NeIdVKswvcFiu7ldu3C6J
         CN41cP9yNOhnGMiMeGoLYPJQ+Ew4LIvaTXTCyAV8cidBszwsE3Wo1m2w1FmCSVhyAz0E
         D7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPitWEeOD/aD62yn7DZZSU7JaVuaUVQq63I5CtmFD+j1DMntN2JyOFJ5aRDQN2PpB31dHqzLqeRozpf1bN@vger.kernel.org, AJvYcCUUu5XYKZkbzD5ywYHVCuo/Oew/4JpdnctTarrOSg34Op3ZjuHbg04SmfqDfGoSTXFh1p09IU3GLx4HRCC3PCnNaw==@vger.kernel.org, AJvYcCUgZvCOfGNX4TJSytk7wDmxGhD+1RQxiPpvhElemmASV3+V1qIVuinUiQjMHnZAavfVd8G5r1NLSbRX@vger.kernel.org, AJvYcCV5wmWz2VgZgJEQcX3F+wkZMCnZF+RHkLhJgNuAOgIGb5mbzChbkA9hyJvvI+8uubsEYlmFYMx5GC+nyNJq@vger.kernel.org, AJvYcCVD6Sla1wkCBvjYeoYBeokskNlnZai5vX4pjC8PLoFq+8JVkKxUhtPhkBdOiAauXSYQ9fxTqCEz7Gds@vger.kernel.org, AJvYcCVVksKusLXvQcncn6esUy7zSDSKvfSj4K6GQcSEkitc+S20k+5xLeyxtgMvzku/+zQVqLHwmAOWpqo=@vger.kernel.org, AJvYcCW3iH3oRT9iEo7Ws8ml7G4upB5KNWRBt0lXaRAmtbM4vq4z/bSGdvjh+/xJijE+qTU1LRs=@vger.kernel.org, AJvYcCW7AaJe08TpCmIEfn4tXdnQQYzQcDSiKnZ6lZaG/LJuQCLREvQEnMf12WWLT1TGZ6qUCx1pDwNO8NueKO5yopk=@vger.kernel.org, AJvYcCWWelSF+HpJ8dD8RyCnk7ab1i9zhoCd5FuYnEKeZnQFdZkrZFIgBfN+XmSVRY72IXbJCPnxqB9ndzfSng==@vger.kernel.org, AJvYcCXssYm+wkam8a1z6IjlfmkP
 d85FzcygzwPgGkLqzEOE0CU1XAd/Knko2Fdzd/aGj2WDSSGFqGyR9T4g3BB0@vger.kernel.org
X-Gm-Message-State: AOJu0YzEN7mgZAeB2itvJi8KUsdLt48HLvHeVuRj1Vy3oZYcJlb8QqXO
	J53RBjYQ1FbS5u9EWG26BNQ81bxsl1FjR4yrVfTRzIxm3gjWS/TzE76MOzV85kl+nDZrJtiW6i7
	ysifs0ldfc9CJwDHmo6KecaiQ5II=
X-Google-Smtp-Source: AGHT+IGi0j/icjLt8RhHlOdJvbjdouTPFKKMu/CT/oe6l0e9sNaP3mHWfqnG22Q9j4GVb6Cdm+e2KfCpXo/Kl8KNmek=
X-Received: by 2002:a05:651c:1547:b0:2fa:d978:a6c4 with SMTP id
 38308e7fff4ca-2faf3d73888mr22769461fa.30.1728117106123; Sat, 05 Oct 2024
 01:31:46 -0700 (PDT)
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
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com> <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com>
In-Reply-To: <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 5 Oct 2024 10:31:37 +0200
Message-ID: <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
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

On Fri, Oct 4, 2024 at 11:06=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On 10/3/24 04:13, Ard Biesheuvel wrote:
> >
> >> That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
> >> feel are a complete no-brainer and should be done regardless of any
> >> other code generation issues.
> >
> > Yes, this is the primary reason I ended up looking into this in the
> > first place. Earlier this year, we ended up having to introduce
> > RIP_REL_REF() to emit those RIP-relative references explicitly, in
> > order to prevent the C code that is called via the early 1:1 mapping
> > from exploding. The amount of C code called in that manner has been
> > growing steadily over time with the introduction of 5-level paging and
> > SEV-SNP and TDX support, which need to play all kinds of tricks before
> > the normal kernel mappings are created.
> >
>
> movq $sym to leaq sym(%rip) which you said ought to be smaller (and in
> reality appears to be the same size, 7 bytes) seems like a no-brainer
> and can be treated as a code quality issue -- in other words, file bug
> reports against gcc and clang.

It is the kernel assembly source that should be converted to
rip-relative form, gcc (and probably clang) have nothing with it.

Uros.

