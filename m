Return-Path: <linux-arch+bounces-3845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A98ABBED
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335CE2818F3
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA31219E2;
	Sat, 20 Apr 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klwwiv2I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8AB669;
	Sat, 20 Apr 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621951; cv=none; b=LYAwKVC69Y3kxFsrD4VC+mRkoFgyhitmO2tim+U884SAeTyxVJR1CT6BI8/9jqXCQ1tby/+rLTvbcy4/cGZbsct6qXhZg3r2RMtkKKz4sopfGhmj0KPt5rhlkHtvA72lPmA816uNriIh203LlXxFPII/mpfDixOROAaYLdMiYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621951; c=relaxed/simple;
	bh=cqnb9OJE3P1VZzS2ArQ+qXik84KwiE/PGpx9+DVa4f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvZjlodAMqknlQd2E0IGTJlr++7sNWA9jyNQx8TrULmCtKPuvUJPmr5GgNNeF9Jr3uHAUAkKBZ5atP3GvejKQJp5QDp9PRtCXdEXYSfXBxHPZDtTofkOToEmyLm4n0t2ByefGc//BfcdvY6KKFDxiQjOceJ3cyvHVHMoyQhgewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klwwiv2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5131BC072AA;
	Sat, 20 Apr 2024 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713621950;
	bh=cqnb9OJE3P1VZzS2ArQ+qXik84KwiE/PGpx9+DVa4f8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=klwwiv2IN3Bw2Zhip0k3i9mu8/tRn0Io6OkXzF4aR34U+3F6WlVAmoo1pPAFdHmz5
	 OXYv2DP1r6lBPcG70Exz/lfDYDIdN0m+iL6HRB5hiVRqL7dQgX6WjgKGsMX1nKAiTn
	 4I6Dt3Tt7ENhCWla7PTfE7k+lgam8etzK8xoB9P892TlgisT6c5KbaSscKHkq9k0mV
	 FtCWBClXS0tVqGBjjfJX6ih8hEJg27Dvn3xGzKD1s4Kqfc/NW96Ov5LnwNwVqiQcPt
	 Ht4hTephValjoYGwROjtCEPGzSSsakhVRWz/nOMjrAnvXGCivKBI36N0OFVg7dUD9d
	 /M1oFVP8EwnLg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51967f75729so3474555e87.0;
        Sat, 20 Apr 2024 07:05:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/Wyfc/V0PSW1n52DjSFYCzLwlhCnxDhY06y9F7cZf4Zb10R0gSORpgkATqPzKBVkfR7H2F34lkYamxn4PGy+TrqDnchSg06TkRDSWB2O+lQxVHI2zFTM1BtilymGXo51lpfByafxw3zJ0ScX6uCU7Bt0PHnLoCqhupNQXCvlO1W3yX7y5MFJF4TLNW+GLP3DIW1OU0BItPVwKrA==
X-Gm-Message-State: AOJu0YxEKTXaP95ySK1kz214nqkBYIfxxSSqmeRI+NKwTmvtqiyuavH1
	F1pY76Q2VF63CqVVlnGmP5wsxWiFzlXOSbvi58LZ6TITW6DmwqAgXhoHUqrLs90KwizdNSCLLm1
	tq2fw29syY7VK4PcxS18VnK738jQ=
X-Google-Smtp-Source: AGHT+IG0Ocg1AZoSs3v/LzffVF+IuMaiqTRS4giDtD5s/bJ/AESAhWEBu9R1lIxKpWn5wp61vOAlPJk5ja4Sgp0X0wY=
X-Received: by 2002:a05:6512:3488:b0:51a:d2ea:97c3 with SMTP id
 v8-20020a056512348800b0051ad2ea97c3mr1965074lfr.69.1713621949038; Sat, 20 Apr
 2024 07:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
 <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
 <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
 <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com>
 <CAK7LNAT9Y5C+Shr1Pq=xrL2tcBK6rpBn05iovdZ2=kMHW5UCkw@mail.gmail.com>
 <CAMj1kXEbXfsNarFMbDC-Dzk6H9X9C4Ax2pWPSZhmt93mV4_Q2w@mail.gmail.com> <CAMj1kXFt5kbZ8yFgO-jU5ZP3-WZi5ZZJKKTCpEYRdUYFRj9CYQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFt5kbZ8yFgO-jU5ZP3-WZi5ZZJKKTCpEYRdUYFRj9CYQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 23:05:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxd4KK7Yj0ah+tFrwWrnr9P=HqXwYQE86q9v8pxmCQNw@mail.gmail.com>
Message-ID: <CAK7LNARxd4KK7Yj0ah+tFrwWrnr9P=HqXwYQE86q9v8pxmCQNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: Ard Biesheuvel <ardb@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, martin.lau@linux.dev, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 11:00=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Sat, 20 Apr 2024 at 15:56, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sat, 20 Apr 2024 at 15:42, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Sat, Apr 20, 2024 at 9:35=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> > > >
> > > > On Sat, 20 Apr 2024 at 14:32, Masahiro Yamada <masahiroy@kernel.org=
> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2024 at 4:57=E2=80=AFPM Ard Biesheuvel <ardb@kern=
el.org> wrote:
> > > > > >
> > > > > > On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> > > > > > >
> > > > > > > Hello:
> > > > > > >
> > > > > > > This series was applied to bpf/bpf-next.git (master)
> > > > > > > by Daniel Borkmann <daniel@iogearbox.net>:
> > > > > > >
> > > > > > > On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > > > > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > > > >
> > > > > > > > Weak external linkage is intended for cases where a symbol =
reference
> > > > > > > > can remain unsatisfied in the final link. Taking the addres=
s of such a
> > > > > > > > symbol should yield NULL if the reference was not satisfied=
.
> > > > > > > >
> > > > > > > > Given that ordinary RIP or PC relative references cannot pr=
oduce NULL,
> > > > > > > > some kind of indirection is always needed in such cases, an=
d in position
> > > > > > > > independent code, this results in a GOT entry. In ordinary =
code, it is
> > > > > > > > arch specific but amounts to the same thing.
> > > > > > > >
> > > > > > > > [...]
> > > > > > >
> > > > > > > Here is the summary with links:
> > > > > > >   - [v4,1/3] kallsyms: Avoid weak references for kallsyms sym=
bols
> > > > > > >     (no matching commit)
> > > > > > >   - [v4,2/3] vmlinux: Avoid weak reference to notes section
> > > > > > >     (no matching commit)
> > > > > > >   - [v4,3/3] btf: Avoid weak external references
> > > > > > >     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > Masahiro, could you pick up patches #1 and #2 please?
> > > > > >
> > > > >
> > > > >
> > > > > I do not like PROVIDE() because it potentially shifts
> > > > > a build error (i.e. link error) into
> > > > > a run-time error, which is usually more difficult to debug
> > > > > than build error.
> > > > >
> > > > > If someone references the kallsyms_* symbols
> > > > > when CONFIG_KALLSYMS=3Dn, it is likely a mistake.
> > > > > In general, it should be reported as a link error.
> > > > >
> > > >
> > > > OK, so the PROVIDE() should be conditional on CONFIG_KALLSYM=3Dy. I=
 can fix that.
> > >
> > >
> > > You may need to take care of the dependency
> > > between CONFIG_KALLSYMS and CONFIG_VMCORE_INFO
> > > because kernel/vmcore_info.c has references
> > > to the kallsyms_* symbols.
> > >
> > > (I am still not a big fan of PROVIDE() though)
> > >
> >
> >
> > OK, how about we use weak definitions (as opposed to weak references)
> > in kernel/kallsyms.c, which will get superseded by the actual ones in
> > the second linker pass.
> >
> > The only difference is that we will use some space in the binary for
> > the weak definitions that are never used in the final build.


I am fine if that fixes the issue.


"git grep __weak" shows a bunch of weak definitions.




> Btw those references in kernel/vmcore_info.c are guarded by #ifdef
> CONFIG_KALLSYMS=3Dy too.

Ah, OK.
Then, this is not an issue.


--=20
Best Regards
Masahiro Yamada

