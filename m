Return-Path: <linux-arch+bounces-3838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710D8ABB87
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E43B2127F
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661E13FF2;
	Sat, 20 Apr 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2RhZd5S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75760625;
	Sat, 20 Apr 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713616342; cv=none; b=LDd70CL4uMsBbLCPM3mMPwR0qMw4SMpB0TrGDydWxIyG4MRUxhpGUU0xSvO4O9TdFJX7LQ8i/4ylBAeuT1E2gDeSYlMAJHMwN4Z7OiL+Mgi+PFanJrPJzEs8iNU/XeJBvKlXhYqZfhDcaUBXMeD9jjWbrxRyRkFwshD95Jt63iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713616342; c=relaxed/simple;
	bh=7ydtcwqOMK/ZievWeOZ4+j7tWKbe2GkJ8dG2UAyB0zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrnQxvwOJEq8aOEqTKg0VrpSI0iKGJXC9v+/gaxmQdLylnOmBus4W9Vh5K1hF1WKPtV4kIlOwq6dqt31+scEcLxM5xZUcty8lCkzz4BvHNf+HDpJUqzimn1OyZL5k+7BddLFpsQDGWqX5Cj8nyNpGK56ya3/hdWIEb6MvoDpsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2RhZd5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA615C4AF07;
	Sat, 20 Apr 2024 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713616342;
	bh=7ydtcwqOMK/ZievWeOZ4+j7tWKbe2GkJ8dG2UAyB0zU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h2RhZd5S6r1eHwiOPL1Ypvzjp0yGfFii/fNo3JHIWW3SfTcp873mazjsH+MXLEtda
	 28E2c1Yz8gmXG2v/lv6P6hn6agXCTIKPAX+V8bvqdUMZ4XOtB5BIOkhueaflWVjYPL
	 0sIFGx3jSVW44TUHHTfK5+Ujk/bt9qsuVc8y+9AqLa38EXg23uvHV0nQQ6qjWG0jqU
	 hTInwU5rtBUqDW1C/+FxUiT/+convJHYdV3UEB1iB1uSTnGhShgGrqL/Oc+qeEJq/3
	 il3ODajwPsqNVTkG+wlI5WMbLDD+XaQ0Ip8M1wOY0s7v9ARNvJKtGk1AaqjIDq+OhU
	 vnH89d4RCi5Xg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ab47ce811so2203984e87.1;
        Sat, 20 Apr 2024 05:32:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVudO6NH6NdmjpL20CLV8PNLY3/Yjw7b/MreugcH0OpMgICHLmKXU7SUFpBTgriFZxuvMs/J9tFwAIh4Sumb6p7sYIgJ+yOFgME9E/3LziKTijYWKexuvP77Ad/2mh3wB795hU/4TBcS6XxxdNGlLL6A89MJDIwWsSBcFrPXzDfUkMw9S8td0IlkiwkpATHiNtoKIZUzTnvsLnFLA==
X-Gm-Message-State: AOJu0Yy1rBJgSQqUdA7RQGs/Bp7ubLv9fWXNqMzpwhOD9xDSNpdCBLtS
	b5I6bBmaJD5yv4G3Xauuqh8WRPFu4PmiWhbctezFOeh6j88oFL4L/l+Lz8KgKp/gjHvbfipSKLf
	qMv6BZtOn7PLEdgdh1iB+8Uv3Cnw=
X-Google-Smtp-Source: AGHT+IEFSFK8NPvRUYpFGmQ5TuKuL4Jrf4zzXumb0E5S/r71HLdh8KBM+iPSt/4AyVgq1nXLA37NpzPGKPvdwDy6h8Q=
X-Received: by 2002:a05:6512:ea4:b0:51a:e03a:aa15 with SMTP id
 bi36-20020a0565120ea400b0051ae03aaa15mr1670235lfb.5.1713616340582; Sat, 20
 Apr 2024 05:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
 <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
In-Reply-To: <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 21:31:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
Message-ID: <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: Ard Biesheuvel <ardb@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, martin.lau@linux.dev, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.org> wrote:
> >
> > Hello:
> >
> > This series was applied to bpf/bpf-next.git (master)
> > by Daniel Borkmann <daniel@iogearbox.net>:
> >
> > On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Weak external linkage is intended for cases where a symbol reference
> > > can remain unsatisfied in the final link. Taking the address of such =
a
> > > symbol should yield NULL if the reference was not satisfied.
> > >
> > > Given that ordinary RIP or PC relative references cannot produce NULL=
,
> > > some kind of indirection is always needed in such cases, and in posit=
ion
> > > independent code, this results in a GOT entry. In ordinary code, it i=
s
> > > arch specific but amounts to the same thing.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbols
> >     (no matching commit)
> >   - [v4,2/3] vmlinux: Avoid weak reference to notes section
> >     (no matching commit)
> >   - [v4,3/3] btf: Avoid weak external references
> >     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
> >
>
>
> Thanks.
>
> Masahiro, could you pick up patches #1 and #2 please?
>


I do not like PROVIDE() because it potentially shifts
a build error (i.e. link error) into
a run-time error, which is usually more difficult to debug
than build error.

If someone references the kallsyms_* symbols
when CONFIG_KALLSYMS=3Dn, it is likely a mistake.
In general, it should be reported as a link error.

With PROVIDE() added, we will never detect it
at a build time.

Do you want me to pick up 1/3?







--
Best Regards
Masahiro Yamada

