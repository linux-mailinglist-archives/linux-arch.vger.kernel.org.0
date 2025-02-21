Return-Path: <linux-arch+bounces-10305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6BDA3FDBF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905F3426097
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3A250BFA;
	Fri, 21 Feb 2025 17:45:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A679250BF0;
	Fri, 21 Feb 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159936; cv=none; b=hvVdad7sUTfUIaBY+HGNuvkD166KuHWedC2HHCTclYpwIA585lR7CaY5ZSXTwSyaPxEteHw8lu9mBY0yvBXcAa5+VvQOrhGYQs6y6G/LumaZaav/v472ARzDf6Q/h+hUVwXUcRou1Ba6/0Eq/htw5PXi4SaSATfwObuGco4VgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159936; c=relaxed/simple;
	bh=4+8PbmaauA94usuoBxYYzJADa474EnhaILlzpd6EDs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pt97MsFn09sp5HCZpFguVmsIzIUpPiNe7885tXYjgljyTN2lmEyhV04Hw0PBht/46llwPUMyPek8K70VptSHYMpGIo7xbVuL4+KG144FqTKPVu/AOk53XUKdA3cRJK0jQIm5m/MNGmRWcuPUVmi7L5GFBFSfM7G71MKVrT4EtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4bd3989f027so1406079137.1;
        Fri, 21 Feb 2025 09:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159933; x=1740764733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVlYG/IbFu9Q/R+V4VeWK18IBK9fWtgJYvhhNDBjzKM=;
        b=GtDylSPaHFKUB6KBnwxEJns5xa+M7lgN324B0tSh3ZIWmhKvZEz10/RTGlunwfaqGF
         3Aamn9Xcm/QeT+zmlyVSYYoq2oqejBSaN44WCBSwOhYgkQjsxZISIIo26XNO0OqAGaAx
         hADxHmrHN1aSig6XxchjS5nQMftZ3SqEFAK0n5o5S9JBxmBia5/tsrqgYdLae4ZugsiR
         UlJu98giFPAFU6E5l+Bqo/K+F0IO0S3UKiQbOJ9VRmpU613rgRQXz7hQZ5/agzOcMQAA
         G7eg2vDJC7COQ+FXAUsGcyXpH7TSvefs2TTPL2eUz5gHSUGMptdEoHPhOIWNsZ26i56b
         Z5nA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FZlLxp95T6/MHWJQM48xrBUIZwckRGcqQQkw5wPTvDbnA8QqVyrW9Szv5Oo3Kdu0BYQJkn7EaNN/DRBB@vger.kernel.org, AJvYcCWNZ+oTZ6Lv0xb45NJZKFRiaQVY99fTPPXsXfbZS/5MqYbk7RvtLzCZfJNthAwEVDG4FLdSYimmOWKhuw==@vger.kernel.org, AJvYcCWeNOEGxWGcm8EhiTvryPMz+/AnPX9iQ+uKOpzEIekbzUQ7cXEjfOVplv2ijOJvOLKSawXGfHeOHpRe@vger.kernel.org
X-Gm-Message-State: AOJu0YxFBc73dA02hqwk9Xg9VGlpQi9dto9HtzkLsTKIZrcERXsOOOhS
	heFGXjz8Yw2sm1swThfGG4pwBQygmHoJeMSfvo5yrkAgfK1cJH8Xw+Fm/tqX
X-Gm-Gg: ASbGncv6KSKj3N6TpqURhQXiRNml2u5dsJVrKynWxAjQx49Wq3ez4Nlvqh/PBmUxpCN
	6jwUaYuNeTSKXWbwWGPjc4Bp90/6dXBY/pg6wSTgYx/GEWRKbb/cJsDiBXzc9B8ZYzvT4yXj4KP
	JlWEQTumBttw11bF+G1t3oNYtDPIlY98mxPmxLvZd9f6XHNw8lrRmX78qZt9Xx9hRUccIeDwEN5
	nKQI3UV5cqxXnMTEcU09D36Pf5llqgc/0FgX4zjdUlP+IBayPmOPE4cSqLVLaHBlYMryO3tILvg
	8Pgp33lBV8QWZi1Xwxg3M0J2gna7I9H0egaozujBJEUyftruNLChcA==
X-Google-Smtp-Source: AGHT+IGlSxppZng25avpxgFndciwOQb1JKOM8XjDAAl7Z8BJ35o5+p2MfXq5dZXfzUYfftnznH9zpA==
X-Received: by 2002:a05:6102:8025:b0:4bb:baa0:370b with SMTP id ada2fe7eead31-4bfc0f86e72mr2254733137.7.1740159933305;
        Fri, 21 Feb 2025 09:45:33 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bd3c9acda5sm3185440137.9.2025.02.21.09.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 09:45:32 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86718541914so1806699241.1;
        Fri, 21 Feb 2025 09:45:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAZEQLUpPSJbwJYUjWuvyQuie6Prw58TtTSNYTkVpIPmrHTvuI6qCse9twCeYj5/qo1lGQ/OmYykKU@vger.kernel.org, AJvYcCVonQAkD76m5iJIYFwaTM2zCK8Y1QqRVWfoC4gbloHr2a4UuK3X1NkEZhoVj01y9SGu++NvsCkP99QFBmV5@vger.kernel.org, AJvYcCXjejikO66foz9A/1+v9kveylVBTM4gYRUPCxkHk7Atzr6+dikKUBAPAhxv44aaaQNj2CRa9dmxPQS65w==@vger.kernel.org
X-Received: by 2002:a05:6122:608b:b0:520:4d63:72da with SMTP id
 71dfb90a1353d-521eeced620mr2485638e0c.6.1740159932550; Fri, 21 Feb 2025
 09:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221092523.85632-1-xry111@xry111.site> <CAAhV-H5_bKtO2mAFmfcZvD0pn9RhTA+UPjv7K574uPKxZbxX=g@mail.gmail.com>
 <f0c15994e7a79f6cd0c82930c0dfebb50458c941.camel@xry111.site> <CAAhV-H4rDXDnzJwUE6PXMyuNGTs1NwUzQDP5eAPMmaHpqftP-Q@mail.gmail.com>
In-Reply-To: <CAAhV-H4rDXDnzJwUE6PXMyuNGTs1NwUzQDP5eAPMmaHpqftP-Q@mail.gmail.com>
From: Fangrui Song <i@maskray.me>
Date: Fri, 21 Feb 2025 09:45:40 -0800
X-Gmail-Original-Message-ID: <CAN30aBEhnR1OJycVs+F43ocJ6Vyh=Et2r+wo5cWwrtV4x-+zcg@mail.gmail.com>
X-Gm-Features: AWEUYZkb8iSWdt-9kgykuTb5jDnwB320XaxMTtxedEnbug7aRKVRXx4OPfkuauw
Message-ID: <CAN30aBEhnR1OJycVs+F43ocJ6Vyh=Et2r+wo5cWwrtV4x-+zcg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, WANG Xuerui <kernel@xen0n.name>, 
	Masahiro Yamada <masahiroy@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:26=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Fri, Feb 21, 2025 at 6:23=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >
> > On Fri, 2025-02-21 at 17:47 +0800, Huacai Chen wrote:
> > > Hi, Ruoyao,
> > >
> > > On Fri, Feb 21, 2025 at 5:25=E2=80=AFPM Xi Ruoyao <xry111@xry111.site=
> wrote:
> > > >
> > > > glibc added support for .gnu.hash in 2006 and .hash has been obsole=
ted
> > > > far before the first LoongArch CPU was taped.  Using
> > > > --hash-style=3Dsysv might imply unaddressed issues and confuse read=
ers.
> > > >
> > > > In the past we really had an unaddressed issue: the vdso selftests =
did
> > > > not know how to process .gnu.hash.  But it has been addressed by co=
mmit
> > > > e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH") now.
> > > >
> > > > Just drop the option and rely on the linker default, which is likel=
y
> > > > "both" (AOSC) or "gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch
> > > > distros.
> > > What about changing to "--hash-style=3Dboth" as most architectures do=
?
> >
> > IMO we are more close to ARM64 for the aspect that there are no libc
> > (glibc or musl) releases lacking GNU hash support, so I prefer the ARM6=
4
> > way.
> >
> > Maybe this should be changed for some of other architectures (RISC-V an=
d
> > C-SKY?) as well because I guess the only reason they used "both" was
> > "hey, without this the self tests don't work on Debian" but this is
> > resolved now.  Adding a few recipients and Cc for discussion.
> OK, maybe we can change it for RISC-V/C-SKY and see what they will.
>
> Huacai
>
> >
> > --
> > Xi Ruoyao <xry111@xry111.site>
> > School of Aerospace Science and Technology, Xidian University

Agreed that as selftests has been fixed, --hash-style=3Dsysv can be
removed from more arches.
arch/arm64/kernel/vdso/Makefile has already removed the option.

(
I probably should add more information to
https://maskray.me/blog/2022-08-21-glibc-and-dt-gnu-hash :)
)

