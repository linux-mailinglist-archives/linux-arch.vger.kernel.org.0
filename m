Return-Path: <linux-arch+bounces-13780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3CBA207F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932043BBE7D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA24C79;
	Fri, 26 Sep 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bP3Jo4Vf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51234BA49
	for <linux-arch@vger.kernel.org>; Fri, 26 Sep 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845486; cv=none; b=S5mu6fcHXnoQiqNDKUMjKc0BnG4B1fYdegNbr8Fq1YZzbdhUmS3JeEPhkBQ10hb8OIROR+mCQvsTltXdmgD6epHAkFNUsloOyJxxRh573yKgGXXSWlDjh7cr4S3lTQlW9SD1GGbUvOlMkMEb6isM+k5rcGK+n9yYMhmBeerPLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845486; c=relaxed/simple;
	bh=Hzl/6sm0ijMbECDHUBEDiRfaMfrSYxO0jGDcnP2SoAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIiHgXGgP+hPVoGutCjJCG/MydPeu3MfQ2PuHeC1TdpaMZWH1lSNOy70W7n3ybb8B3sBgDKEnN+BGASQw4KERXtweBnXBVcHPMDv/zdPzaZtMs4Glcfj9B3iNRj+qPBMS0HAhIHpqueENkpCc1QJDbZ5ztkVhw+94ygCVa2X0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bP3Jo4Vf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60501806so16239197b3.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Sep 2025 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758845484; x=1759450284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlSE1rUBrC9T1DFQ/5OfHtt+g6SfJ20nkl63DkWshCc=;
        b=bP3Jo4Vf/EC1Gi82y7K8BAS7Va2DYYHZGFVkgCoJ2iG5B/ygeo6pTYAMxLVpi8dbie
         9fqtxyt+z6qWchDwENOpsh10htzQbtlxnEQ50k+1PaHaTHI/uPxFgDky6hzv5CVkXdeb
         CjdZB4Z7nWqTPJ3pGgNghbZwSo1HS2h92rBAbZis5hGzZSy/D3OY6tqF7/TZr6i02MTI
         nUrO2vGRSwqr9iiI31dBqcsn3wiyCmRVGfs5CgaGTwoBj+7tPJAKEvDzoWXzHGKRuH+4
         UriW0DguxNsi3Kahab4Gr/A7+IM0HywtQeHEBOrAZv7R70njk2pQHc8wqe7ltT8mqqd/
         srGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845484; x=1759450284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlSE1rUBrC9T1DFQ/5OfHtt+g6SfJ20nkl63DkWshCc=;
        b=Z6GfXEUoBIsa7Bm74KTEMajSIVse21M5fV+wqQzq9Q0CMsaXp41B+7roU26Z5EHN1/
         pQoB2/71VccVEeT1V8SuHNWckWAm2IqZ8jRW6PcSy5wr26G+Jw2/YsewSiQTyGWg19BF
         +G8OfTAoAM3xshIkYym3D8Ns41UEDPf0srkRf0VAr+WUac16KAj49KlnhbX+T/C2N2Tv
         erG6IjghD6DJ2W4JjMEpY2AGOT4RkOkEZufNpwsmzEvepW+tX3zKT64tOT05Hcphh/zH
         9Z5totOcywquhMm7sA8tFehGoKuTOc2qPDON9uq3J7mdh2pgXqpu4b8sWCnxlrdJq1Hm
         mAiA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtlh5H5bhOtyFcad7ubGml8zzG9XBgz3C1jigSHu3GxVKzcAmgkxXeclEP40NSWj0ILkEaahYyHqB@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuprvC10SEYPUToHCvz2Berh6WSM8vXoY6/zuiePJhVClPBGt
	FmYpgUlZp7mUYAIF8bEfOChtwK7uwCDawp7OIgl6dAAExWjlAcgJ2XIIUMQOUpDcnmVF83ZCA1S
	GROlBEk1cw/4BUqcCSfC6w4eJvqU2onbsFnFqwixP
X-Gm-Gg: ASbGncvD3NhzhTDer0yH7/OltF0GvEA6oNbee2SDJ09z+R5zy1TZro2Pv58vdV7eGZX
	95EFu7xK1HXRDa7rSWFXOO0Ko3iRjbCXyZQry6s3KBRcuqQJgvO34GcnpTaas+rpotVcfG3jAxy
	VXJAuk9cUdyR/F0M/e7NHB2l40ZnPhIGv1gAAQKLjdVve8kS3v+Vx0cG+qoMFq1cZtM9F7mX1H6
	Z32uoNfJp4MYhD4MPuz0sj7Fdk=
X-Google-Smtp-Source: AGHT+IFjkjg1CJK2kqFcJZmVZhckeV1dW5wAwLpyJnWVbu+PQmvkA/uVH/e/0tYM6tLXM/d7UXxi8O7HF6KX7EuWjD0=
X-Received: by 2002:a05:690e:159a:10b0:636:d570:c4ed with SMTP id
 956f58d0204a3-636d570cab0mr1348537d50.10.1758845483874; Thu, 25 Sep 2025
 17:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com> <CA+OvW8ZY1D3ECy2vw_Nojm1Kc8NzJHCpqNJUF0n8z3MhLAQd8A@mail.gmail.com>
 <409ddefc-24f8-465c-8872-17dc585626a6@suse.com> <CA+OvW8bhWK7prmyQMMJ_VYBeGMbn_mNiamHhUgYuCsnht+LFtA@mail.gmail.com>
 <2bf54830-ea9c-4962-a7ef-653fbed8f8c0@suse.com>
In-Reply-To: <2bf54830-ea9c-4962-a7ef-653fbed8f8c0@suse.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Fri, 26 Sep 2025 01:11:12 +0100
X-Gm-Features: AS18NWAL2BOfXlIfw0PmfY9rpNA0-1bzCD1zhOmyRpqI4MrEa3fGtNm7DZbnVa0
Message-ID: <CA+OvW8ZrbdqDGDkt8jXUX3Vg2aLSzVrP-a39Lqvxd1DYOOUg5g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:41=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
> This is useful information. However, I was specifically interested in
> the impact of having the new flags field present as part of __ksymtab
> (kernel_symbol), compared to keeping it in a separate section. Sorry for
> not being clear.
>
> I ran a small test to get a better understanding of the different sizes.
> I used v6.17-rc6 together with the openSUSE x86_64 config [1], which is
> fairly large. The resulting vmlinux.bin (no debuginfo) had an on-disk
> size of 58 MiB, and included 5937 + 6589 (GPL-only) exported symbols.
>
> The following table summarizes my measurements and calculations
> regarding the sizes of all sections related to exported symbols:
>
>                       |  HAVE_ARCH_PREL32_RELOCATIONS  | !HAVE_ARCH_PREL3=
2_RELOCATIONS
>  Section              | Base [B] | Ext. [B] | Sep. [B] | Base [B] | Ext. =
[B] | Sep. [B]
> -------------------------------------------------------------------------=
---------------
>  __ksymtab            |    71244 |   200416 |   150312 |   142488 |   400=
832 |   300624
>  __ksymtab_gpl        |    79068 |       NA |       NA |   158136 |      =
 NA |       NA
>  __kcrctab            |    23748 |    50104 |    50104 |    23748 |    50=
104 |    50104
>  __kcrctab_gpl        |    26356 |       NA |       NA |    26356 |      =
 NA |       NA
>  __ksymtab_strings    |   253628 |   253628 |   253628 |   253628 |   253=
628 |   253628
>  __kflagstab          |       NA |       NA |    12526 |       NA |      =
 NA |    12526
> -------------------------------------------------------------------------=
---------------
>  Total                |   454044 |   504148 |   466570 |   604356 |   704=
564 |   616882
>  Increase to base [%] |       NA |     11.0 |      2.8 |       NA |     1=
6.6 |      2.1
>
> The column "HAVE_ARCH_PREL32_RELOCATIONS -> Base" contains the numbers
> that I measured. The rest of the values are calculated. The "Ext."
> column represents the variant of extending __ksymtab, and the "Sep."
> column represents the variant of having a separate __kflagstab. With
> HAVE_ARCH_PREL32_RELOCATIONS, each kernel_symbol is 12 B in size and is
> extended to 16 B. With !HAVE_ARCH_PREL32_RELOCATIONS, it is 24 B,
> extended to 32 B. Note that this does not include the metadata needed to
> relocate __ksymtab*, which is freed after the initial processing.
>
> The base export data in this case totals 0.43 MiB. About 50% is used for
> storing the names of exported symbols.
>
> Adding __kflagstab as a separate section has a negligible impact, as
> expected. When extending __ksymtab (kernel_symbol) instead, the worst
> case with !HAVE_ARCH_PREL32_RELOCATIONS increases the export data size
> by 16.6%.
>
> Based on the above, I think introducing __kflagstab makes senses, as the
> added complexity is minimal, although I feel we could probably also get
> away with extending kernel_symbol.

This investigation is very informative, thank you for sharing your
findings. I am in agreement with your conclusions.

> This seems to answer why the in-tree flag is not sufficient for you.
> However, I also suggested an alternative that the symbol protection
> could be determined by whether the module is signed by a key from the
> .builtin_trusted_keys keyring, as opposed to being signed by another key
> reachable from the .secondary_trusted_keys keyring or being completely
> unsigned.
>
> Distributions can require that external modules be signed and allow
> additional keys to be added as Machine Owner Keys, which can be made
> reachable from .secondary_trusted_keys. Nonetheless, such distributions
> might be still interested in limiting the number of symbols that such
> external modules can use.
>
> I think this option is worth considering, as it could potentially make
> this symbol protection useful for other distributions as well.

This sounds like a great solution to enhance trust and security,
apologies for missing this in the previous email. I will explore this
approach, but I would like to do it in a separate series.

> I'm personally ok with adding the kflagstab support. I think it
> introduces minimal complexity and, as you point out, simplifies certain
> aspects. Additionally, if we add it, I believe that adding the proposed
> symbol protection is simple enough to be included as well, at least from
> my perspective.

Since we are in agreement, I would like to seek code review for this
series. The code is ready for review from my side, but if you prefer I
can send out a non-RFC patch series for code review.

--
Thanks,
Siddharth Nayyar

