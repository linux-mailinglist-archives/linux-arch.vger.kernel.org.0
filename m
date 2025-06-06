Return-Path: <linux-arch+bounces-12257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01CAD083A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149B13B1BA9
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0761E0DFE;
	Fri,  6 Jun 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpiMfTEc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A21D432D;
	Fri,  6 Jun 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235723; cv=none; b=avDncWbKt2PZzqH6j7v0a7bBaDcuSxep1T29n3kP9OcAwUNAl6hn11FbtXcdjzSjIJV3rRo6QxhkCr3waYWIWGEu+Yw14bEOWCfSjqONOVq2yZYRA3AK/PINhHA8AZPaO+cL20yXl88R3fr+Twgoe5vjEAREmb9g1Z/XUGFNG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235723; c=relaxed/simple;
	bh=u04s2l7lgDPKZ6dFtdINL+UHcdN7QHWvT6iYBViISn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/yizLWDUgSLVndMqNv1q144wmgImHnRy55n5fWgu02ePkgL9C8xeaFG+EdMqPu8vUrMsPcrT8rCPzfxb8daeBpvDGl4Z0TcgToSc54677kSpCgt/C+tfIU3x0C1Xmwf3TCZiYoMy9oCUVvKn5EncshFBcHukMtLuVVQOkfHY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpiMfTEc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32addf54a01so14422741fa.3;
        Fri, 06 Jun 2025 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749235719; x=1749840519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u04s2l7lgDPKZ6dFtdINL+UHcdN7QHWvT6iYBViISn8=;
        b=jpiMfTEcwGT2tjd/7jV+opmqO2r47jbKiF/EWuVturN4l0fHHiPZHlAsQyrhdFIaGw
         qQ6ZAJv6mN1byH/r9ZNlGeLCB2qaW8D+m1s3rGTh7bavQBTBa6QSYDGdMH8oQ7q72PGM
         m2/T8ziokM1A1gmrAQpswDbck805FVl6molGPkIOKdkHFm0Xo2gwE6lXSbGx7uTJbUPI
         HmcmWhU6tC5ifOb5p/nMI/Eowx64hpSb+/ak/CMTqgz7XjIC0zaaG8Y1MYjXlp4XzjtY
         4thAvQZLC4zjQr3Ku6RdFARD8SNrYcO+g0a3mFNmQssd0MaK/fcI2I0wdRhvYAOSWMYB
         Xr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749235719; x=1749840519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u04s2l7lgDPKZ6dFtdINL+UHcdN7QHWvT6iYBViISn8=;
        b=J92fLOEtvRlUeUkTME2yx7gKIXKMqEzsu1coI3m2iPZl99+VmDYdPvn5J+72wmO8Gq
         glnG/uXKVpTxnl9Qd8Ldr7sm3bza4KAz6gzOuxHxECAaGjSHXeOgouBzz/q5prlOW4KD
         wX7LmNgU4lvO1UYD+aIIcWs6tU4jStNXqC2ozvHVvWv7/VDGKxdhWDSlIRCTmNJ7FbL+
         yUezeC6OqwkGqV7i5ddHEbxVz5ZtTbv83pVkb+bKVC8V3RYSVY3fA2+kEvBi8i3iPlop
         N9PLWuIjSmnxC1XKNQGgUpux1gY7ELEjprgbcM9r47KEzHOZB6T+4/yevadpkYgsQZE5
         PIgw==
X-Forwarded-Encrypted: i=1; AJvYcCVYdf7+XHGdjok/BvpWGrSWS3Xn+YlblJuGZQANvnqKyChJ0GRpoTc97guivTUCyR0x0QSYAE4zTi5ayemcrc4=@vger.kernel.org, AJvYcCXZNSLt77FB1wifTa86buTyx44Dzjx+w6oDF9M5gauX3qWZ6EVNKDWbq1phFm2nsyJmDmvj8/S3u7PLgF1H@vger.kernel.org, AJvYcCXgS63U88UlKqJKvWRdXccIdF9ezau1J2a2n+Rk343mkDrwzYzx6t2R7vOdT8JCNMiyMHl+Lt6aHhNj@vger.kernel.org, AJvYcCXz+QbSvRbkdd/4nrxDvG3fGvhAGRabQEF7CLAn1ADFV3iJ/wuwRpnoUkHE9h0/Rkpvm2IHVXK4@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTFDvvtkA0ItEuRuL5kI/AqM6uawW0Cd+DyNXAemZNxqGraro
	DvPxhwCXOlsg+I1NObFtYMURPIacEFb/6oya1+Xrxwh6rUXeuB/8NPutBbptY3FLhGkYh4iwR4I
	OBTKKj30ZN6k2JfiiiF18VB6nx+Dl8lg=
X-Gm-Gg: ASbGncsYc1C8fXPnPVZl3QYGgEsll8pT6xVsHxbkClNwmcDQvbMPNfoVMvy7pXrXNoi
	/6O3DRs8mKcYTYzctUhgp2OtCF02S6vvEbHkLqVbDsQRYLWOUjT92B2sahn3Djyqlc9lA7LSId2
	gah8sqUZamvH1EWzSh5aOupauuDGdvRT3nHnwcEdIVDrc=
X-Google-Smtp-Source: AGHT+IHRFX6pedFewi8e06EiF+Tweg5TPKPhvAts3knS7mZumhUVV8MZdcXwJlSfigEyad1PYjODCtTTIDO1cPYXieo=
X-Received: by 2002:a05:651c:1a0a:b0:32a:ec98:e15c with SMTP id
 38308e7fff4ca-32aec98e9fbmr5564231fa.19.1749235719187; Fri, 06 Jun 2025
 11:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org> <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
 <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com>
 <9767d411-81dc-491b-b6da-419240065ffe@kernel.org> <CAFULd4Zf4FOP-h0GVYo=frJ90tF07yvbuLbngnqUwyx9x+qz6w@mail.gmail.com>
 <CAADnVQ+FG9BH=FrgPctQfC+cSMoP2rZwR1d8cHVqn28xv-Uc1Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+FG9BH=FrgPctQfC+cSMoP2rZwR1d8cHVqn28xv-Uc1Q@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Jun 2025 20:48:36 +0200
X-Gm-Features: AX0GCFvXERXK_nHAKIR60I6AOdB-3j1GvEhNua1NJKWBq6uXzktIDbaVIardb-k
Message-ID: <CAFULd4bnOA=pBKSkxqpWEX7yTwSNc0duR0enJHY5sBTGzsw46A@mail.gmail.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-bcachefs@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 6:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 2:27=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Fri, Jun 6, 2025 at 11:17=E2=80=AFAM Jiri Slaby <jirislaby@kernel.or=
g> wrote:
> > >
> > > On 05. 06. 25, 19:31, Uros Bizjak wrote:
> > > > On Thu, Jun 5, 2025 at 7:15=E2=80=AFPM Dave Hansen <dave.hansen@int=
el.com> wrote:
> > > >>
> > > >> On 6/5/25 07:27, Jiri Slaby wrote:
> > > >>> Reverting this gives me back to normal sizes.
> > > >>>
> > > >>> Any ideas?
> > > >>
> > > >> I don't see any reason not to revert it. The benefits weren't exac=
tly
> > > >> clear from the changelogs or cover letter. Enabling "various compi=
ler
> > > >> checks" doesn't exactly scream that this is critical to end users =
in
> > > >> some way.
> > > >>
> > > >> The only question is if we revert just this last patch or the whol=
e series.
> > > >>
> > > >> Uros, is there an alternative to reverting?
> > > >
> > > > This functionality can easily be disabled in include/linux/compiler=
.h
> > > > by not defining USE_TYPEOF_UNQUAL:
> > > >
> > > > #if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> > > > # define USE_TYPEOF_UNQUAL 1
> > > > #endif
> > > >
> > > > (support for typeof_unqual keyword is required to handle __seg_gs
> > > > qualifiers), but ...
> > > >
> > > > ... the issue is reportedly fixed, please see [1], and ...
> > >
> > > Confirmed, I need a patched userspace (libbpf).
> > >
> > > > ... you will disable much sought of feature, just ask tglx (and ple=
ase
> > > > read his rant at [2]):
> > >
> > > Given this is the second time I hit a bug with this, perhaps introduc=
e
> > > an EXPERIMENTAL CONFIG option, so that random users can simply disabl=
e
> > > it if an issue occurs? Without the need of patching random userspace =
and
> > > changing random kernel headers?
> >
> > In both cases, the patch *exposed* a bug in a related utility
> > software, it is not that the patch itself is buggy. IMO, waving off
> > the issue by disabling the feature you just risk the bug in the
> > related software to hit even harder in some not too distant future.
>
> The typeof_unqual exposed the issue in the way GCC generates dwarf.
> The libbpf/pahole is a workaround for incorrect dwarf.
> The compiler shouldn't emit two identical dwarf definition for
> one underlying type within one compilation unit. In this case
> typeof_unqual somehow confused gcc.

Can you please file a bugreport in GCC bugzilla, so we can analyze the issu=
e?

Uros.

