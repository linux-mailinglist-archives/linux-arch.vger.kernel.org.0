Return-Path: <linux-arch+bounces-4539-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A018CF027
	for <lists+linux-arch@lfdr.de>; Sat, 25 May 2024 18:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167491C20D56
	for <lists+linux-arch@lfdr.de>; Sat, 25 May 2024 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1A85C48;
	Sat, 25 May 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQqtpjF9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F37487A5;
	Sat, 25 May 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655423; cv=none; b=c118QrdgyCSlZZlJnLdBDX7fiRLEquiUEm0LeVsb8LrSHs4GYduz2hgHKsSFbn2RQ4ohtnB2VllrxL/9y1F07Pde3aF0Y5DaH7wifqneblD195a6jm4UKibZFKhWeyD1P7yry5/quMm7dDtNj7RQprj5k4m4cX/TQR3153UuuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655423; c=relaxed/simple;
	bh=BYvRVlfnOcEYCohSU9+i09Mb94lZWB25nxoPHqEd0Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2O1ILAelfdsVYL3Js5DIXexgzRzDwGE/mpoWZVOb7KBJTFoHPn317XKWDT96ho7mNz8auqD2zAsMi764+sOcc+jGSumgxTpMrtJhp00EQrgQbuQ2xWguyHLakIHqPOT2zBgs/LpVZA0a81vlDU9ULp8hkScxGSueihonK8XmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQqtpjF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C50C32782;
	Sat, 25 May 2024 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716655423;
	bh=BYvRVlfnOcEYCohSU9+i09Mb94lZWB25nxoPHqEd0Lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VQqtpjF9ci4TPs43sML4DRO6vWzmik2gcCGgE+GkYfnYvRG/M+vOkmXt+6stMhwLt
	 VTNDWHqvhai/cNU8SVheBNeFZLQZQKKQ6eUsnjdXbGEnDgOqpCxX27+SmipVMXryKz
	 EH7epCNj8esHUS2vIuo94Dz7LJrk8QKQ5SKjer8RnLDZzbQPxbP7ex0PSCGLVvtXLp
	 oLK7Lj3G0rPSrcBo1UWKqNTSX8DDrMliwuD7cPivwdenX4u8vQQ2M0jHZgho9/3DQS
	 HuoTNoL4W941MxLn9HjS8SlINoIOsulBKr3rF7DqEGHAbIYzKIWUtkEN/zV78liRi4
	 pDb65u3yAlOdw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so85398291fa.0;
        Sat, 25 May 2024 09:43:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb4q7tbW0A0+UPZEO/cPjyY0sk69EgM1tDnUrOFDe1J/Mcb9txjLX31CD6Vk8W+eWjfSDIq9LpXk343dFQxonpQgcKbG4N25Koz6YhyuDBGb9VoQTVziunPn/W9rkF5IRAHirDAJriWV/uF+FfaFO0nWzUGl8OnwUSHcFnhg==
X-Gm-Message-State: AOJu0YwvLOm7idn3Ql73J0Wx2yNwn77pj/o3D72YlT/IldUD4H2avBBN
	x1D0f5WJrqCvXMreW6VfUYHX4dWvSBCpR00EzzxVgDjQzF+PTIQpT3QiUuF0v8etm0G9uhe7+ye
	QP6n1jpQhErmYwU4nH0Jo31F8wsA=
X-Google-Smtp-Source: AGHT+IGho3f8KKeAWOOGieu1BeXrWfXkamAMqAEvp1bl5gSAUC88VYD3wLf3Li0DW8C4rCu3GIr+nmE3+gU7YXcmSu0=
X-Received: by 2002:ac2:4e10:0:b0:51b:e0f0:e4f8 with SMTP id
 2adb3069b0e04-52964bb0ea4mr4203773e87.31.1716655422028; Sat, 25 May 2024
 09:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522114755.318238-1-masahiroy@kernel.org> <20240522114755.318238-3-masahiroy@kernel.org>
 <CAMj1kXHwEMxAhj=zCBRCAxE8MXhzT95CTtAin+fPQr3DSJ46fA@mail.gmail.com>
In-Reply-To: <CAMj1kXHwEMxAhj=zCBRCAxE8MXhzT95CTtAin+fPQr3DSJ46fA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 26 May 2024 01:43:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQCq+hGm2CJz149fiCs5sOAZ15HmeYbmWK0h70KF5sFxw@mail.gmail.com>
Message-ID: <CAK7LNAQCq+hGm2CJz149fiCs5sOAZ15HmeYbmWK0h70KF5sFxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: remove PROVIDE() for kallsyms symbols
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 6:32=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Wed, 22 May 2024 at 13:48, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > This reimplements commit 951bcae6c5a0 ("kallsyms: Avoid weak references
> > for kallsyms symbols").
> >
> > I am not a big fan of PROVIDE() because it always satisfies the linker
> > even in situations that should result in a link error. In other words,
> > it can potentially shift a compile-time error into a run-time error.
> >
>
> I don't disagree. However, I did realize that, in this particular
> case, we could at least make the preliminary symbol definitions
> conditional on CONFIG_KALLSYMS rather than always providing them.


Fair enough. I am fine with dropping this statement.




>
> This approach is also fine with me, though.
>
>
> > Duplicating kallsyms_* in vmlinux.lds.h also reduces maintainability.
> >
> > As an alternative solution, this commit prepends one more kallsyms step=
.
> >
> >     KSYMS   .tmp_vmlinux.kallsyms0.S          # added
> >     AS      .tmp_vmlinux.kallsyms0.o          # added
> >     LD      .tmp_vmlinux.btf
> >     BTF     .btf.vmlinux.bin.o
> >     LD      .tmp_vmlinux.kallsyms1
> >     NM      .tmp_vmlinux.kallsyms1.syms
> >     KSYMS   .tmp_vmlinux.kallsyms1.S
> >     AS      .tmp_vmlinux.kallsyms1.o
> >     LD      .tmp_vmlinux.kallsyms2
> >     NM      .tmp_vmlinux.kallsyms2.syms
> >     KSYMS   .tmp_vmlinux.kallsyms2.S
> >     AS      .tmp_vmlinux.kallsyms2.o
> >     LD      vmlinux
> >
> > Step 0 takes /dev/null as input, and generates .tmp_vmlinux.kallsyms0.o=
,
> > which has a valid kallsyms format with the empty symbol list, and can b=
e
> > linked to vmlinux. Since it is really small, the added compile-time cos=
t
> > is negligible.
> >
>
> OK, so the number of linker invocations is the same, right? The
> difference is that the kallsyms symbol references are satisfied by a
> dummy object?


Correct.

In 3/3, I even reduce the number of link steps
when both CONFIG_DEBUG_INFO_BTF and CONFIG_KALLSYMS are enabled.





>
> That seems reasonable to me.
>
> For the series,
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>


--=20
Best Regards
Masahiro Yamada

