Return-Path: <linux-arch+bounces-9109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FBF9CD748
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 07:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A1B22DDD
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C9185924;
	Fri, 15 Nov 2024 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uniPW9aT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A71632DA;
	Fri, 15 Nov 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652811; cv=none; b=r+SbXTCAchN2yJ6d9hHU0kZQzWB4dOcMiwS0u2Dns3aHqZTDIaKEbVUm5x3lkrXY8K7sPoQMJEZ6/HkF+1muopp+eA0L2k24KGeqkO7fbISeDymTnjCm8NqUTT5Fz20jzjK0eCXbFcQh6oN5pTMQdbv7e31E1DanVcek0TmVhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652811; c=relaxed/simple;
	bh=l1659v1Vhgg9Kq1j8Tk9tX5+AzvH84h16fnYGbm8WC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn/RLyn/PzZMnj9oFYpPQLQoDPZRIY9OHUxN+CT40z3VCbhf84NWDsouIFj2PY4DxLAi558wgFiy0X/r8mEfBtVaJ09OgErWkRC0X6B4Uug8EfURKxndpgzOWD2zSBZM6gS2NgieG1dfo/mVy4Pa3G+AXBDHAA6Nj3eJyzI3fAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uniPW9aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BD9C4CED0;
	Fri, 15 Nov 2024 06:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731652810;
	bh=l1659v1Vhgg9Kq1j8Tk9tX5+AzvH84h16fnYGbm8WC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uniPW9aTg9/jnLrtt45iCX7+ixFHW9bFtualDvSC43a4rET07uSm0EmPFeLFqz1ku
	 0d/hCdx9AV49RykBtfu50qyYPojBdij58fDrBsOZTV1R0wdjAiu1NTj3N/JPNkjbJS
	 VN+Ma3vvSy8SYwbv4swjKbAt39xrPE/V35KFVnE30HHPQzEFJ7YJJsqT07+0GyJMuK
	 BuU0KSLEDJA7YclnuPYBhRZjwYxf6SH2+cBbFWjda3MrYZHPIGFOkOl2w7bCb658vS
	 B8Zk9qpeUyLwjqQu/havUuJZsxGKPicpCO9McqEW3efcdsAEYttPcpKCmCS/ePTcvo
	 3/UaecDBVfo+A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cf8ef104a8so575347a12.2;
        Thu, 14 Nov 2024 22:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGcRoY+LGuLDCQqFXAYGco/v/Mck7Gbj/VxzO3Lsxb0j/aniWPQgEbSFUPM5uZT0qGFP/sPTk/3BgWyWrX@vger.kernel.org, AJvYcCWFnWlkgsBDU17fYLNSzZwb1TyBZRTVz3DkDHgwb/HrA/0TOXQWmudJCg8/nrtV1jeK5U/ADEcYuPPk@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFjur3op4N3K+XFolvBPjSz18NveWlZgDt9Bfv4QrPYQixXEw
	nvzYXrmwUmwXn5hUwtDmfkjt0MIYPXt6nhclty3QeyKPP8CA4jWgjkcGrGNhHEuKW9So2RrG1vL
	Ip4QUcGYtbNsbra8H/K/m31/aYK4=
X-Google-Smtp-Source: AGHT+IGmsPBnMUtgVMjP+KjPC48xzioF5vWMgugaO+nmVaot/QUTnUueJ3XtlR2QrHu1DgZm0f2HTsNWOPrU2ZPH3hM=
X-Received: by 2002:a17:907:318b:b0:a99:f0f4:463d with SMTP id
 a640c23a62f3a-aa483440a08mr126645766b.26.1731652809288; Thu, 14 Nov 2024
 22:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113124857.1959435-1-chenhuacai@loongson.cn>
 <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com>
 <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com> <CAHk-=wgC===Qx3STDjBWGHuzJ0SNP16gEz3iSc6Ebo_bM-yZtw@mail.gmail.com>
In-Reply-To: <CAHk-=wgC===Qx3STDjBWGHuzJ0SNP16gEz3iSc6Ebo_bM-yZtw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 15 Nov 2024 14:39:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74QH66JG0SrrYzYmKTazMWMs5gxp9kGCfC46B4AQtS8A@mail.gmail.com>
Message-ID: <CAAhV-H74QH66JG0SrrYzYmKTazMWMs5gxp9kGCfC46B4AQtS8A@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:21=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 13 Nov 2024 at 22:23, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Maybe the root cause is that "From" in my patch is loongson.cn but I
> > use kernel.org's SMTP server?
>
> Ahh, yes, I didn't even notice that you went through mail.kernel.org,
> I only noticed that loongson.cn did SPF but not DKIM.
>
> Yeah, if loongson had had DKIM and DMARC set up to match, it would
> have been an even noisier failure about DKIM actively failing, rather
> than not having DKIM at all.
>
> If you use mail.kernel.org, using a "From:" with a kernel.org address
> too to get the full email verification is likely the best option.
OK, and another option is use loongson.cn for both "From:" and SMTP.

Huacai

>
> That said, I went back and looked, and you've clearly been using this
> mail.kernel.org + loongson.cn model for a long time, and it hasn't
> been problematic. So your pull request being marked as spam might have
> been just a one-off.
>
>            Linus

