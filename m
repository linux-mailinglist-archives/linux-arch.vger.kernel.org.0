Return-Path: <linux-arch+bounces-5794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C08943846
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 23:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87A11F21E4E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 21:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E916D325;
	Wed, 31 Jul 2024 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFXIhAa4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3D160860;
	Wed, 31 Jul 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462729; cv=none; b=qMX9SZjSQ/9YKrqTk+yYtEIaAKZ0NIuwvg08qaeHZ096A9VwqUo5HcQE+WCgKuKGtkzxrmFHR8rYOobuTjhLtUjogeIUAUyyk75e+A9civh1nLd4gUJdwMzm+R0YgiKBkYhtB/g4oPrHZusPgX0yhIY3UEvC+Y+BjzVqlhfKQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462729; c=relaxed/simple;
	bh=dMejEloAEVcCZyvgcOEVM+yjF7rV83Fb47hNrMHcm60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHtg85PDOyVMQsMOpVm4QzLbSbjoTb7w0Wg1uVKqyYDHDWMJvjMOAptLFzmY9WniKf5mGoB0+ID81F6U9MtpljBUH1PR814rnc+stEwhVXMklfKk8mX4DH4tZfL1mYWZ6iWppgIoOacSbwlOvD9pxgRG1MuUTtR8OYZPknsO4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFXIhAa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98839C4AF10;
	Wed, 31 Jul 2024 21:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462728;
	bh=dMejEloAEVcCZyvgcOEVM+yjF7rV83Fb47hNrMHcm60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OFXIhAa49ozspRb+Vkg+haQ1CJdlME/Xu6FJdG8xHm7AzdmrR0yzch+x0i9bROVyY
	 A7wd3yYyAt+eCNuFst9nR2ZQS/1gpYyvZOzG/cuh2mlrXx6WzgcLLOyi12IUWANWpx
	 h8dSoJG1kAWngOTiF0/6RrXOEz6P42V5R+CIQai4isVMDTBYGAvSi1IewPlHxhqdY8
	 7wYaZEhcMyhOkfCLDmRYEmNbNpGUW/p+Att0Sfiiq6WqbV3DJ/P0kVgHLqPYbB+F+N
	 ZvD9Jkl3Xu6RT1X8KGEr2viOY0DavTkf5K8zxAMghH1Cu+pYg1q+Ae5sLsXF+hOpaq
	 Lgp93F6wJDETw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso6450764a12.0;
        Wed, 31 Jul 2024 14:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjhpIWkT9GxUjipgmLwwtWoDWTF3iKPV0Yy2RJJ2QHj6+LZno4PJY+O5uWzIdFljSXJKSIQMya/1QhnkVMPcTarQuVCd99MkqX+HMZcdr14eP1Bh67n2jMtfWa1+OEziYwONsz1wOW7ekXKhfyXbL/3QRaCxDehn+7IWr99sAlPhjnpZ3fG25ozOE8BaU5vOMHiProJcN3CQlW8Xiuefc=
X-Gm-Message-State: AOJu0YyJ1yCbKxmbc23v/hsQIZpLTNBQdq+ZFHUO+P7K4RXMu39zClxj
	BxfFRtepXB0W4VHl0vIQkOfWFNMmNWwbZq61cWX1P8F9nlGb8bd8/GUBC0viu6Rhl1Y8gIh3czJ
	paNakYdR8BcxxNQ7yqeugXLbVqYM=
X-Google-Smtp-Source: AGHT+IG6u+LBC1U/4ah8Phx3p1l/q7k/uRvdbCWTGY0uN3N8etMJmLSzVrI0hwkofLSh7v3Pv8RNG16kgZqR0K/TkXM=
X-Received: by 2002:a05:6402:3d6:b0:5a1:73fc:6bd4 with SMTP id
 4fb4d7f45d1cf-5b6ff0005f4mr189800a12.19.1722462727169; Wed, 31 Jul 2024
 14:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-3-alexghiti@rivosinc.com> <ea55bb29-c3ba-4e71-a76a-f788c4a7ea16@redhat.com>
In-Reply-To: <ea55bb29-c3ba-4e71-a76a-f788c4a7ea16@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 1 Aug 2024 06:51:55 +0900
X-Gmail-Original-Message-ID: <CAJF2gTTGpTG6Va+7Sa9t2BFGFc5oy-yR5zEdiWretygO1jD_Ww@mail.gmail.com>
Message-ID: <CAJF2gTTGpTG6Va+7Sa9t2BFGFc5oy-yR5zEdiWretygO1jD_Ww@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword
 operations with Zawrs
To: Waiman Long <longman@redhat.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:27=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> On 7/31/24 03:23, Alexandre Ghiti wrote:
> > riscv does not have lr instructions on byte and halfword but the
> > qspinlock implementation actually uses such atomics provided by the
> > Zabha extension, so those sizes are legitimate.
>
> Note that the native qspinlock code only need halfword atomic cmpxchg
> operation. However, if you also plan to use paravirtual qspinlock, you
> need to have byte-level atomic cmpxchg().
Thx for reminding me; I will update paravirt qspinlock after these
patches merge.

Zabha & Zcas extension provides byte and half-word atomic cmpxchg.

>
> Cheers,
> Longman
>
> >
> > Then instead of failing to build, just fallback to the !Zawrs path.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/cmpxchg.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index ebbce134917c..9ba497ea18a5 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -268,7 +268,8 @@ static __always_inline void __cmpwait(volatile void=
 *ptr,
> >               break;
> >   #endif
> >       default:
> > -             BUILD_BUG();
> > +             /* RISC-V doesn't have lr instructions on byte and half-w=
ord. */
> > +             goto no_zawrs;
> >       }
> >
> >       return;
>


--=20
Best Regards
 Guo Ren

