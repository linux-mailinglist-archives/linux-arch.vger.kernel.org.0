Return-Path: <linux-arch+bounces-3839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1E8ABB8D
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 14:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064651F2130A
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF314AA8;
	Sat, 20 Apr 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+2LsWFY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32F134DE;
	Sat, 20 Apr 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713616528; cv=none; b=qUWRThxyIR6NLbL4h3ujS2a7u4xlDK9Hdj83Pt/X6s5bAW+qOyRBCIQVyE9ARVKLuhI5w5x3ZwZItN5SdQiqdK/Mvem/5ymXZL7c2Et+krXM6rBj6wj3AA+X5cVuBp7B4kgei36OTSR8jpmXRTROu0+cbkY2LkuBulHh84r6mys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713616528; c=relaxed/simple;
	bh=C0su14Vv0GkdCzCyyCJ0B3w9yZVmYkLEBcVFLOb3IX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoeyY3rxG+tlIE+nuaJ0WGaHWg0VUYigdctwkvGl+9lyGafgN35v7PTcn11B92/gLe7iQVB3SE9s56RhHJFLrXVZJOjqsZMqsrGS6sVZZyldYuCeokRryWNsu+4pYZwEEIIEoCGrfB3XdIcEmyixrdQh2npFHqkgSDO1BtCkiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+2LsWFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDEDC113CC;
	Sat, 20 Apr 2024 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713616527;
	bh=C0su14Vv0GkdCzCyyCJ0B3w9yZVmYkLEBcVFLOb3IX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B+2LsWFY63h0+Zezv8olMsNCNtyIAbywGg+kf3FYoAaMqJKsMGT/lmMTfsOsqODt+
	 3M90dTFazRRFdL7hM4lru6gJmtrHvAXIWoAzR2ijru4hni+qJBiiHnxjlzD+iqpusJ
	 Zx0M8G3IGfmXFdLv5i71dLmnISED8On6zU0oYDyIGfNCsxACKJzfDiQ4e4PquXH67w
	 6R7siWH/apCc13wo36FLqcUN9c9yWyQMFxUNCTi7NywGT+4173HYN9Nd0b04atlY6M
	 VXQqpk+PAbGFgiNptTJpwlgWXEyg5sv4dp+OKph3oOnpt/v6vkT1k8c+c1nfa3JyAy
	 D4CrKOabAitPg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518931f8d23so2982161e87.3;
        Sat, 20 Apr 2024 05:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxav0VnfNSOXSLw6Sk+16wcR83R96j++bKG40EdSATlz2BBIIkbQiLmT95pJiSR8VPNqGLaNkCY0JC6JfZWMpYqPAQzjp28y+V2QGkZGwOhmG/mVIeI3s3m+SnerAfkpn+dEOO1pG/+WNk1bS7SkmTKqLqmoFsv7pl7hJrImc+3DNSvUXlyEpNxuOZfA1r5c4j/nqaVaFrSkbe9g==
X-Gm-Message-State: AOJu0Yweb4wtUtKXsS9otYar3BV5KZa7UkOKYc0RHlsGTkfUwbsKd58E
	6viMQRVJxm6SocLZJzj6EfrkWFEaiuL70NCvppGOzLIfEdoK12rLv+qC+49Pg7Judh+Apj9D7Aw
	7n3rXkT1+zPC0Px2Bg+GVRCTpxks=
X-Google-Smtp-Source: AGHT+IG+f9NykjJU+m3Tes2ZqKak5Ja88RIp2O/pH4J+7li5X0p5AnFOH7cTPN85CHpHY01aZ+qGzU6SF/Y8gjK7qgk=
X-Received: by 2002:ac2:5041:0:b0:51a:f728:d67b with SMTP id
 a1-20020ac25041000000b0051af728d67bmr320613lfm.67.1713616526199; Sat, 20 Apr
 2024 05:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
 <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com> <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
In-Reply-To: <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 20 Apr 2024 14:35:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com>
Message-ID: <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, martin.lau@linux.dev, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Apr 2024 at 14:32, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Apr 19, 2024 at 4:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.org> wrot=
e:
> > >
> > > Hello:
> > >
> > > This series was applied to bpf/bpf-next.git (master)
> > > by Daniel Borkmann <daniel@iogearbox.net>:
> > >
> > > On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Weak external linkage is intended for cases where a symbol referenc=
e
> > > > can remain unsatisfied in the final link. Taking the address of suc=
h a
> > > > symbol should yield NULL if the reference was not satisfied.
> > > >
> > > > Given that ordinary RIP or PC relative references cannot produce NU=
LL,
> > > > some kind of indirection is always needed in such cases, and in pos=
ition
> > > > independent code, this results in a GOT entry. In ordinary code, it=
 is
> > > > arch specific but amounts to the same thing.
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbols
> > >     (no matching commit)
> > >   - [v4,2/3] vmlinux: Avoid weak reference to notes section
> > >     (no matching commit)
> > >   - [v4,3/3] btf: Avoid weak external references
> > >     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
> > >
> >
> >
> > Thanks.
> >
> > Masahiro, could you pick up patches #1 and #2 please?
> >
>
>
> I do not like PROVIDE() because it potentially shifts
> a build error (i.e. link error) into
> a run-time error, which is usually more difficult to debug
> than build error.
>
> If someone references the kallsyms_* symbols
> when CONFIG_KALLSYMS=3Dn, it is likely a mistake.
> In general, it should be reported as a link error.
>

OK, so the PROVIDE() should be conditional on CONFIG_KALLSYM=3Dy. I can fix=
 that.

> With PROVIDE() added, we will never detect it
> at a build time.
>
> Do you want me to pick up 1/3?
>

???

