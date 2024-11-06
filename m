Return-Path: <linux-arch+bounces-8876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF659BE35F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A314EB20F91
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08B1D63D3;
	Wed,  6 Nov 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK3VAb1Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B41D358B;
	Wed,  6 Nov 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887296; cv=none; b=oN5nx7fXA3GbpWPV8CG6FubapUM15BcvfPcfH2IPaatOf7jy5Ah922R0mvAeHTzW1jWzaMTJV/mrcMcxkneFsQ3xxpqgNldeJRH3gNprGI5pLESFjnKwurkN44Icini8B1+G/jw6eutHuj0aunMkAY0fDu67YLsjCH3HRfBjgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887296; c=relaxed/simple;
	bh=4KWvGlAzbnzzsBhuOFLrlVXpY/vqqdBCj7f8ApXp0Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR0jwqxCAryWd4z/y813WLnqGaOiCQPanh1OV4ZZH6os4WylT9rKlSrTThsX+qkNkM4ClyhjB4LxAUJU8BRBlnbeqS/uLaKevvudPQ2fifDohyy/v00SgcZHI6C7AWeDRWsxeVleFYRhdPaaqaMaSIUCp0i1YiKJCaZH/ofgAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK3VAb1Y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5111747cso61521761fa.2;
        Wed, 06 Nov 2024 02:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730887293; x=1731492093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZhbpyVRfgvljLe/iXBQmcZBRcKpdXm1vY0T+Z7FP0I=;
        b=JK3VAb1Y85RdBKMoP130JWrvrYJ2tqc2lZhYZRK/2UaItX/9su31lhPZRTiwlvclji
         O3hyMRu6PqBBpagM7UP+TEs3I7eS96tIKeU0vGzOhTgmvGq6sXoC+26sK+o6+9njxtko
         sU9e6eiw1pyAbg94IkJv+CwjiuSl36WpD2N9aeyFqN7m869dmqcWi5P3myp3XyHr60Oh
         YmbA0aXXDIW9VII8u1I6BtreGPHkbaEU51UP9Etyny4Upy/fqc/Za/9LgfaorpPZDB4K
         jvLsF+Dz6EdBvsSKQBHkn6+nFe3XDqKnaG9bHT5DgYDxqgjhsYOOwKAgBLVDX6TkQMWd
         P1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730887293; x=1731492093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZhbpyVRfgvljLe/iXBQmcZBRcKpdXm1vY0T+Z7FP0I=;
        b=gcafwhx2h2m1NvPazbPD1p39FLZtlWF3eDO1xHQBztKhisAlkrDNXNOTRKK4TzLbj1
         FBmuylRC7I6C9ggbAIKUNDFpb0HHWzTY7vRuGkezfSkkG4RTsRpZ8N8H4npaNW8R2/FH
         oSuTzqbpQA0i6p9uIpnMOXi+Wvrm56KLAD1aFB06fk/Ai8D0aICQf4KrmoIiXn56gjzz
         P49uXwvs0MvDx+42t8kBdTRmNArACNncgyUD6zdXqJAMUoUmCHY6tydwcbtcORtjFa3J
         vf8ubISN5jrv2ZCls80ztj1H9788Brd0Si4UJkxQGI7VhTe/EToyksCxQsPeaw++cPiH
         leEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrgFkQ+QVOlAjrmBSpaVkoeefxj7obO41LImg+g0Kbv96OFNklysZ1De+zhjcFhDpiZMemZmxUdd895ciZ@vger.kernel.org, AJvYcCWAHnn/EGnoa9UhhFyxfLvR9d9GVRR+mJy4gC7IDeyiFHKYqd0xa2lr7kX53mm2ovzGvYR/pky/HgGc@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwlxOHZ1GIdFKgt2MsIroJsWUaTFrYIYdMz9IUXpg2S/eRHLh
	YQvnbc8p3LaBL/f0GZu6Oe4XEeu0l+ZD3oMF8XznupWiz5veRBTSr5MqqiScAMHgnGTPTk92L0I
	bLF2E42KnbLyLQ7pIKRp6a8y3lk8=
X-Google-Smtp-Source: AGHT+IFUyr5bB92xtqyuMhGUSRHo8VYiCSwYRtD+4nnqc6tbqiR/8sRnGqGs/qpLapnaYDiiZdE8vFp+YOJXapC5Nv4=
X-Received: by 2002:a2e:4c12:0:b0:2fc:97a8:48f9 with SMTP id
 38308e7fff4ca-2fdec83ab34mr82498691fa.19.1730887292875; Wed, 06 Nov 2024
 02:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com> <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
In-Reply-To: <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 6 Nov 2024 11:01:20 +0100
Message-ID: <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
To: Arnd Bergmann <arnd@arndb.de>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Nov 5, 2024, at 13:30, Joerg Roedel wrote:
> > On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit wrote:
> >>  include/asm-generic/rwonce.h   | 2 +-
> >>  include/linux/compiler_types.h | 8 +++++++-
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > This patch needs Cc:
> >
> >       Arnd Bergmann <arnd@arndb.de>
> >       linux-arch@vger.kernel.org
> >
>
> It also needs an update to the comment about why this is safe:
>
> >> +++ b/include/asm-generic/rwonce.h
> >> @@ -33,7 +33,7 @@
> >>   * (e.g. a virtual address) and a strong prevailing wind.
> >>   */
> >>  #define compiletime_assert_rwonce_type(t)                            =
       \
> >> -    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D sizeof(lo=
ng long),  \
> >> +    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D sizeof(__=
dword_type), \
> >>              "Unsupported access size for {READ,WRITE}_ONCE().")
>
> As far as I can tell, 128-but words don't get stored atomically on
> any architecture, so this seems wrong, because it would remove
> the assertion on someone incorrectly using WRITE_ONCE() on a
> 128-bit variable.

READ_ONCE() and WRITE_ONCE() do not guarantee atomicity for double
word types. They only guarantee (c.f. include/asm/generic/rwonce.h):

 * Prevent the compiler from merging or refetching reads or writes. The
 * compiler is also forbidden from reordering successive instances of
 * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
 * particular ordering. ...

and later:

 * Yes, this permits 64-bit accesses on 32-bit architectures. These will
 * actually be atomic in some cases (namely Armv7 + LPAE), but for others w=
e
 * rely on the access being split into 2x32-bit accesses for a 32-bit quant=
ity
 * (e.g. a virtual address) and a strong prevailing wind.

This is the "strong prevailing wind", mentioned in the patch review at [1].

[1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com/

FYI, Processors with AVX guarantee 128bit atomic access with SSE
128bit move instructions, see e.g. [2].

[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104688

Uros.

