Return-Path: <linux-arch+bounces-14568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F3EC42982
	for <lists+linux-arch@lfdr.de>; Sat, 08 Nov 2025 09:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2003AE3B9
	for <lists+linux-arch@lfdr.de>; Sat,  8 Nov 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680E2E0B47;
	Sat,  8 Nov 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGf86zAJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8C28980E
	for <linux-arch@vger.kernel.org>; Sat,  8 Nov 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762590863; cv=none; b=hXjNZns+POgbwilUO/0FWMfoQN569+37REruwMIwuUeZ9Mc3ZPRs/16Kzp+0F5J7Grb7blLrjt0gqF2t+mmxcWRxvGEHyKsqwinh/CRKfDszPzOzXh6sBVfu4+F3Levt3Q99pn07SKH1/aPQEHMkS9sGtel7DWJdw7PAr43hRJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762590863; c=relaxed/simple;
	bh=tlZEONXv4tiRT3AMc0su51y1oD5Ls6tTrIpaqE0ngs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHdqn1qUAd7OCcQ9WPTvl+PDHupZ454VQCUptffWiPsKDniab0j1heHAmjAKqgsNfEH/o2exqaskx06ShMPmBZeYahY2TqM5cZhZ5B4czdOZZmTUi1gg+5WXkJSXueJ5wv4ZTJ+j8SLFpG3mjXyWadPnZI6TwZgjk4Mz9dyew/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGf86zAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A488C19422
	for <linux-arch@vger.kernel.org>; Sat,  8 Nov 2025 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762590863;
	bh=tlZEONXv4tiRT3AMc0su51y1oD5Ls6tTrIpaqE0ngs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tGf86zAJ94DACKdaNqRgK8YNQB+EsYJB5rMwJWLYHhHSch6AzOd2IGU6E0Sc0K8oj
	 ok1/8TVSSAio+awRWFtGI7CRLOrSiIvlKjCAPJecee+p3SACLV89TYr6W2syiRBjc6
	 nYx8RSNYK5pYUDRNdX10ZILswkx/MuMDVrUChmxwCCQrEMryaa41oYtzS6hnXglBZ/
	 kGE0vMaTop1wWoElr/GDKMOd8r0Pdwe4koNP111CuyN1VaH0vP+VqM1yESVMLgxVSi
	 aUhElU7GMlnwUNstJaauNka7d2Csdclt2aPojzjzVShrxvzRwJ+cTiwmQqRO+H6kej
	 8iunQfiZTtluw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so279964066b.0
        for <linux-arch@vger.kernel.org>; Sat, 08 Nov 2025 00:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmt7njLU/OHisTdiKAm6NigGGiUVK/aXC9YJpmXrmEyQdakEDTVsH8KM1dGerhj8Cfnzh7+/hf7CfF@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcJPrxqlXUyu1Df8762waUwUJpshT8oRhH0dl5+LTCzlYqivg
	XOOtsRuCVCNJ+MntjfiVJm45VEXLfUXHXIah14PKF1tzZAtmH2KoYclRyr4rUrNfcIUpH1Mwi/I
	PNMGiN9Cv43wR8dtJkIC4k3nu7fVs+nw=
X-Google-Smtp-Source: AGHT+IGlb245/wlR/RrXg6CuqlcByT1uGzI60JlcScJKo+CxETFOnGjHVUbz2TrCf3DggZ37u6QhKQeLBIoK3JY1V2c=
X-Received: by 2002:a17:907:3d92:b0:b70:b3e8:a353 with SMTP id
 a640c23a62f3a-b72e05e5a26mr184062066b.50.1762590861638; Sat, 08 Nov 2025
 00:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107095922.3106390-1-chenhuacai@loongson.cn> <aQ4lU02gPNCO9eXB@fedora>
In-Reply-To: <aQ4lU02gPNCO9eXB@fedora>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 8 Nov 2025 16:34:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5C_Af72a5QcJs25qUMsJqO26=8oNvvLrJ7z+xHZh8oKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkuuT3NN8uTRvAGhFr6le3bzLzpE1q1tOb9RXNULYvf4D4AG-sFaEbbJVM
Message-ID: <CAAhV-H5C_Af72a5QcJs25qUMsJqO26=8oNvvLrJ7z+xHZh8oKQ@mail.gmail.com>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Vishal,

On Sat, Nov 8, 2025 at 12:59=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> On Fri, Nov 07, 2025 at 05:59:22PM +0800, Huacai Chen wrote:
> > __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> > flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> > as follows:
> >
> >  #define GFP_PGTABLE_KERNEL   (GFP_KERNEL | __GFP_ZERO)
> >  #define GFP_PGTABLE_USER     (GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> >
> > There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> > explicitly.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
>
> I'm not really sure what "Refine ... about HIGHMEM" is supposed to mean.
> Might it be clearer to title this something like "Remove unnecessary
> highmem in ..."?
Yes, that is better, but Andrew has picked this patch, should I resend
a new version?

Huacai

