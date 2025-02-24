Return-Path: <linux-arch+bounces-10345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30AAA42C07
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5E417C8A5
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EAF266B52;
	Mon, 24 Feb 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1NinDUi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8232266B4A;
	Mon, 24 Feb 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423113; cv=none; b=U2cPF3VMy8u1DrSW/FzOnZkadZMG9DvcPgA5BgD+IKbZB2DWikTpw45H7JiDZ60TXTTLIQwP1vKDcljdyBVyisfJ1P39mZ0babEOrEMlapZjqykDMWFxQ3iB3n4Gat8qEaaiXJGkueCgwt4uinVtlz46recNkQhTFwp5M01Xt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423113; c=relaxed/simple;
	bh=TUEqaIXpwI/RfqdyMieJkO4fzyFhGbd9bZvDzL0LVtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apph5K5wSIqAxM3D0friY3jcOJuUhThqf2lDs+7+a7DuYowtDODXkV322I6XaU3sFwLjpxHqzbln/0UOjUsrZQRO86/hgjDe/g1z3721KI64Ok/jmOfeG+ghv6v7C4esI0fiqrEHdwwJoDz5vkjIcQ0STVj4GUTj37hSm8lmIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1NinDUi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc4418c0b9so7309770a91.0;
        Mon, 24 Feb 2025 10:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740423111; x=1741027911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUEqaIXpwI/RfqdyMieJkO4fzyFhGbd9bZvDzL0LVtg=;
        b=e1NinDUiIBwWKB75/J8RGZ3Egic/V/HYS01tcHTqEV24KffFTQt+e9JSrcdWkV2+rc
         TWVHQBYWXdEn3434GizAUDoIf+mBFUHiijPWuE2hvDn1c85hXV9AIJtWiGhy7EZMkTdL
         NzwuzBV9WevNfTj9Olweo01Y6YtoWiat4aCawuX1s9NzS9S7R5+m0t7AS60puFNEBC1s
         zip4CLI9tK8mevOgsTHS+1mEnIjkMA4xm665Rpd2lGxyCua0ORDVolU3iqQ9xc/6uXil
         ARrxczAii0lNtFMrS2y5GOlVNMdV56i7bE7xWL7eonrMApnz3x/GcfI3G2NNkZDWOZE1
         2zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423111; x=1741027911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUEqaIXpwI/RfqdyMieJkO4fzyFhGbd9bZvDzL0LVtg=;
        b=w1WbvQpFweZgDiSptST2sCBKFmDal1f5/xfvyGHnRd4uLYIjhsrOt0bjzAfmZUdejX
         Uuzg1p0dTX+XaH3IZiIKzE5bqbbvwL3RFVboBKsNgCAgsbS7rtOun3xu4cTMTPP2dfB8
         WGn7TM+Tx1QJfWCaog6NoZL8OOXdkT/0XZLalsqHm8lUbOPuul7ijgwhbtfyArAl14QY
         dCQapjGITO32I9KZtqYEfiY8zWq80of0f5PMAK2Ils8S479/B3R+Hqhdloxz0fsGwcVn
         H4Pc9ftJ8l2Yl4OMxUHPiA986GUYnY9yWYFc6USdeqPOtpnfEWz5F1cfLV9GZv5fo2DO
         Ilxw==
X-Forwarded-Encrypted: i=1; AJvYcCUJjDccSUEqMJvusfMlQ2HQj0y9RBSo84JlR+7XiY8QJPtzMYis/EJ+B52Ua3lZRU8gOVwD1FIDU3E62g==@vger.kernel.org, AJvYcCV1MjxSFx8Qr+9qUxnuLgVQQU1tYN3jrQcoef0iVu1Fe8N8R6IycZ80QtwqNVG8LGQu8M7ezo9Fz5PORLPvxv2i@vger.kernel.org, AJvYcCVxtp7w6YnuPgPWuF1D5zwAr91A+mO6Pf5IpliHfVfqJHrdAKdkp3b9j/qK7v6YH0xEDDG71mJxI2nPQWYE@vger.kernel.org, AJvYcCW20q4jPYzxeNiVdZ9PnR9sZrs/O1IXrA8Z9en8Tsr1F3EUXxZpThCP+Q2P36RGgzW5W28=@vger.kernel.org, AJvYcCX5aXtCYqyP5rhnjtzGF6ObMGWkxRgBoLGheKZkfHwhMrqozye7dqIJwdgmGthGg7RNVlJguL0xRjrGd9ox@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhJoiYE5M/u1C15iGHFA/K1HCjn7HB4yr1KrzILqftw2aP81V
	rtkXUOA7CPgqOvShEC/zsOM94kk77ugegQgtKWd1mI0i/AsPkZ/TbNH9w5gKT7v1Imw0y4EYTl0
	a8KfYpNrNHmAcnuVgnTYb51MW/bk=
X-Gm-Gg: ASbGnctyOcIbs3nmayznqSybb+QQSBvA8MWf0uh7TpFr5QUB0ezzlm74f3FuFWC/iji
	/IepP6VXqSbak+5TXaQCFJjWaoUBFviQ1UgKfen8FFzaGUVx1gXIWh+HHQePjqwuXJx/AKdLr9+
	/+o2tr8D3tKNFJShd8xWfbxvE=
X-Google-Smtp-Source: AGHT+IEM92T52Wzy74biCjdt13zNava/7AlYK1wNiCPPQTiFKurSCN5AvJp5hFsbNvAbAeL2dN9RyVPPvrf75/LQ5Wo=
X-Received: by 2002:a17:90b:1344:b0:2fc:a3b7:10a2 with SMTP id
 98e67ed59e1d1-2fce78cb879mr27572269a91.17.1740423110927; Mon, 24 Feb 2025
 10:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-2-stephen.s.brennan@oracle.com> <CAK7LNAQokoST0FnByeWywaghTMP2aG7hQaV1T=TcQ=1v4ZLQrg@mail.gmail.com>
In-Reply-To: <CAK7LNAQokoST0FnByeWywaghTMP2aG7hQaV1T=TcQ=1v4ZLQrg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 10:51:38 -0800
X-Gm-Features: AWEUYZlWebfCB8ebdoh-Z8K_EKpop-kMh4XUx8JTAFtvrkByBiikkkZM8iT5dTo
Message-ID: <CAEf4Bzb9rYHTVkuxxSuoW=0P84M7UPkBr-4991KiMnFsv10hjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: output rodata to ".kallsyms_rodata"
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Nathan Chancellor <nathan@kernel.org>, 
	linux-debuggers@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 6:21=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Feb 7, 2025 at 10:21=E2=80=AFAM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > When vmlinux is linked, the rodata from kallsyms is placed arbitrarily
> > within the .rodata section. The linking process is repeated several
> > times, since the kallsyms data size changes, which shifts symbols,
> > requiring re-generating the data and re-linking.
> >
> > BTF is generated during the first link only. For variables, BTF include=
s
> > a BTF_K_DATASEC for each data section that may contain a variable, whic=
h
> > includes the variable's name, type, and offset within the data section.
> > Because the size of kallsyms data changes during later links, the
> > offsets of variables placed after it in .rodata will change. This means
> > that BTF_K_DATASEC information for those variables becomes inaccurate.
> >
> > This is not currently a problem, because BTF currently only generates
> > variable data for percpu variables. However, the next commit will add
> > support for generating BTF for all global variables, including for the
> > .rodata section.
> >
> > We could re-generate BTF each time vmlinux is linked, but this is quite
> > expensive, and should be avoided at all costs. Further as each chunk of
> > data (BTF and kallsyms) are re-generated, there's no guarantee that
> > their sizes will converge anyway.
> >
> > Instead, we can take advantage of the fact that BTF only cares to store
> > the offset of variables from the start of their section. Therefore, so
> > long as the kallsyms data is stored last in the .rodata section, no
> > offsets will be affected. Adjust kallsyms to output to .rodata.kallsyms=
,
> > and update the linker script to include this at the end of .rodata.
> >
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > ---
>
> I am fine if this is helpful for BTF.

This seems like a useful change all by itself even while the main
feature of this patch set is still being developed and reviewed.
Should we land just this .kallsyms_rodata change?

>
>
>
> --
> Best Regards
> Masahiro Yamada

