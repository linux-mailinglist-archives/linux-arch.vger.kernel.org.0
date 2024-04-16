Return-Path: <linux-arch+bounces-3730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FF88A6EA2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8A1F23649
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A012E1DE;
	Tue, 16 Apr 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDfLa4/S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBF12DDBD;
	Tue, 16 Apr 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278493; cv=none; b=tzSA1mVFZz8ScW8hhsPZfF+Y9AZn5U7qv/QjzmuYgUAOHvdpxQK5ytuSuigyP3GUMAl7PeLle36p/TCM/hwaM8HpElhWyO/Pjd/UDJ+rIUy4sLjUWnPbA79UZNfDqx3/1uawOT4hQMiDz6/9r+1Ba3aMfrQih3lQkp/EH/JRqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278493; c=relaxed/simple;
	bh=QFSr4wVV/e7e8YSqnMvX38E0a06A53lGWX69D6/6jlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn7AHQRrevDnkWXqV5IuPxOHQb8H/Jgv6qkXnRp2oiUgJf5RwzRvl3ABUsZdcutekusGWDKLjq1pb9Y+FvnHUqE1qtg4eKnrT6v3Gi+Y1j0iZCFvwnZ/VZAQ1KPFhcpRzSvh5YVPhtal0tBv2tOHH+MHKSQlAlr8zcKoyImKqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDfLa4/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E93EC2BD11;
	Tue, 16 Apr 2024 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278493;
	bh=QFSr4wVV/e7e8YSqnMvX38E0a06A53lGWX69D6/6jlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qDfLa4/SoBzVXvSPIGArjAyJwzvANkOpG+6enMa8kj0JbCrzyogzIIGdAf1i7TnAY
	 tRdNhNSWae+F75GkcxfRVrAtYCBBfglk7WyCyvWs8xTzxIEY6MvDZx7wvgoRF+EYAQ
	 63/i43I/YJPVus+Gn81W8sXBXmeTeerG/3q2xZhN6kZKu0O6cpPy3JeqlK8IByOWNB
	 lR0Bco6TLZ7DO+9CubDRAqQ8kgWyNZAPguiRFeW/ayvJWUh/sBTebjC1do0FpuLr9f
	 iSNJWsllCVIsSQLTCc7aEAaZgoIdbctB30QVe0sAMutbkyCvZdUxF3WhAggBsPuQ0A
	 mgGkgVDXABywA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d82713f473so83992861fa.3;
        Tue, 16 Apr 2024 07:41:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPNF/FmATLaXFeZPlW0ja8YTsTb6PR3cbBC1j4cEBJz8LPV76U3a0wYj+1nXKttOfCmBB7UWlga/mlSh4bmjJeqdjeCssJPudQ36mu6WwtTWbmMi15A9eH5XQ5Z5yHsuM0CUCpRZ68VQ==
X-Gm-Message-State: AOJu0Yxo4XJqz1AXMcrRqljH9qkdM0SVMkmL7hZ+FONLI6wmhJPPYf/m
	POIdqiOaSld4OcqiYDMAmS1EOKDfV4e4spc6ESGyzWHB3GgOIvKJaRE3hxLI2qNOfrsJWGXiuwG
	0fRF2BCSNWfPeKq+g9HxcQdV2e5A=
X-Google-Smtp-Source: AGHT+IGN2nz/xTDmRgoYKeTLq3wairO+eDlQiHnk3PLxMapmMED08oZsVrPb0CIY2mj+wK+zCdR/PWSsYeNurFFvENw=
X-Received: by 2002:a2e:9ed4:0:b0:2d9:fd90:af57 with SMTP id
 h20-20020a2e9ed4000000b002d9fd90af57mr9292681ljk.51.1713278491369; Tue, 16
 Apr 2024 07:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mQh3O9S4umbvrKBgMMorty48UMwS01U22FR0mRyd3cyQ@mail.gmail.com>
 <c82af143-b620-44d9-8647-f52096b851ab@redhat.com> <53d194db-c7d4-4026-9fbb-3b41de545849@app.fastmail.com>
In-Reply-To: <53d194db-c7d4-4026-9fbb-3b41de545849@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 16 Apr 2024 22:41:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7dw_44kWC5ph=Bia6i=fjUh8HxA6b4=vtZ8oQx_Br1aw@mail.gmail.com>
Message-ID: <CAAhV-H7dw_44kWC5ph=Bia6i=fjUh8HxA6b4=vtZ8oQx_Br1aw@mail.gmail.com>
Subject: Re: ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
 but not used
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Hildenbrand <david@redhat.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	WANG Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	loongarch@lists.linux.dev, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Tue, Apr 16, 2024, at 15:51, David Hildenbrand wrote:
> > On 16.04.24 12:26, Miguel Ojeda wrote:
> >> Hi David, Arnd, LoongArch,
> >>
> >> In a linux-next defconfig LLVM=3D1 build today I got:
> >>
> >>      ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
> >> but not used [-Werror,-Wunused-but-set-parameter]
> >>        629 |                 pte_t *ptep, unsigned int nr, unsigned lo=
ng address)
> >>            |                        ^
> >>
> >> Indeed, in loongarch, `__tlb_remove_tlb_entry` does not do anything.
> >> This seems the same that Arnd reported for arm64:
> >>
> >>      https://lore.kernel.org/all/20240221154549.2026073-1-arnd@kernel.=
org/
> >>
> >> So perhaps the loongarch's one should also be changed into an static i=
nline?
> >
> > 4d5bf0b6183f79ea361dd506365d2a471270735c is already part of v6.9-rc1. H=
ow come
> > we see that only now on linux-next?
>
> Andrew merged my patch to enable -Wextra yesterday, and it appears
> that this one fell through the cracks with my testing, either I
> missed the combination of loongarch with clang, or I last tested
> it before your patches got merged.
>
> > I assume we should see the same on upstream Linux with LLVM=3D1, correc=
t?
>
> On upstream, it only shows up with 'make W=3D1'.
>
> > If so, we should likely just drop that completely and rely on the
> > asm-generic one:
> >
> > diff --git a/arch/loongarch/include/asm/tlb.h
> > b/arch/loongarch/include/asm/tlb.h
> > index da7a3b5b9374a..e071f5e9e8580 100644
> > --- a/arch/loongarch/include/asm/tlb.h
> > +++ b/arch/loongarch/include/asm/tlb.h
> > @@ -132,8 +132,6 @@ static __always_inline void invtlb_all(u32 op, u32
> > info, u64 addr)
> >                  );
> >   }
> >
> > -#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
> > -
> >   static void tlb_flush(struct mmu_gather *tlb);
>
> Yes, this looks like the best solution, and I can confirm that this
> addresses the warning on linux-next.
Emmm, this should be removed in the first place because x86 removed it
at 5.12...

Huacai
>
> Tested-by: Arnd Bergmann <arnd@arndb.de>

