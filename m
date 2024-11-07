Return-Path: <linux-arch+bounces-8886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77B9C0260
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6031F21997
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27711DB54B;
	Thu,  7 Nov 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQHJumAO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A60126C01;
	Thu,  7 Nov 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975438; cv=none; b=eT6zhX31Nla5RbjzO9y484YGCsO71t02NfUDqxQsaweeaDGDx5b+UxtbCixXJPADunkMDoO29kmIdt7ycxl49AvaCjvLWpartmRTK3daBtE/VU0LyLYZngADcXfNwuLAj+zupU7pRHlWkbibcJW23bIjQJ9wpOgXRFF+sDOq/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975438; c=relaxed/simple;
	bh=ybAPtiskKz4DcrhGmZixymNGGFMFiO8a1KfZLtABtY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8ugmPYzMcu7NxjOBXomYXzBVppfYHSZ4GsiiDIJw9GEJmdlcNSRxi4x2NZmNPtjtm8XEvqwzf0/LkVO3+nF9gnpkJtEg0YdQJp4iVdFsAOHnsoxbMw/dPreV9oUwhA9ybVHWasHmNiti/qXSEgdz64QrFigSgkstaXOvuUl8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQHJumAO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso7803151fa.2;
        Thu, 07 Nov 2024 02:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975433; x=1731580233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7adgg6V1UpnypInZqfzwGSsryFp6mWpcT19KyQhxWsQ=;
        b=jQHJumAOdIFS+6wDpLOrnIGWtWSBgU+cF8UwNBKo973S09t24frHHBzSaciw3VQTlu
         vN2VwNqZ4F+8YL1wUDbZ9jPJURD3qtdfdLTnaGqZfGVzsznGym7ShyXBRADr1tW5wCDi
         JfpBbt4+fnDCDD2ym5UptiSSSjt646e7o3Gj3TqmNlu3CqcXyoYEAGbovaGrRWjwIXId
         JRAuA8L17ZgGj5Hc+ED/dsegPcA3RF/TWCpycO0i+YPJj7jurKn83Vf5cDsXrjX25lPf
         9/BUBpnILU9s8KwK81iL4ZUusxigt+fU98Qh0lDlsWNVsJmHAMZ3GvUpRy9HJFq7QfP7
         wi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975433; x=1731580233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7adgg6V1UpnypInZqfzwGSsryFp6mWpcT19KyQhxWsQ=;
        b=C39deOCIvpx3/ao2k58cZSeaJl32T6qxIQR8dvS5ZN3ywaLU4oKZDDtta+kfWPK9Ge
         4KUvCe0bVTLqRGiDkQ8BbsThqGkY636CHu90KiCd2KWJB8divkDkl1CIZ8DonZMlwIUc
         8xMgV3G84AM7hVQdgk/wwO0spQJ4XsDxnuOW7LSh7NoCALrkZbIxV+J2Zg3obmeFmT8V
         lnLzsh8dcehWCTYoKvexCPRG124hO/h9ezRHxzMULjVi+8d9U9GfbcE3tai6lSvxVywc
         HdyksN7Qa3Yl99t/t3XtQ0AuXwqUm+QuTmlrHVNOuBsCGf4G66X6UWYrAmzYTCVfhXyG
         FDMg==
X-Forwarded-Encrypted: i=1; AJvYcCUU2nxh4TtWoPiJfVL+cOpybsqCLAxtCl/RPBnHRCx+sm9CoIoCbZfs1qZ0gi3vZq8hzoEHU+kk4R9V@vger.kernel.org, AJvYcCVwn7TeGq/YOD+KpnnS1fqpAUCGm18MPMiR9RBiZ0KylEwstss0Pbr/FMllYwPGTXuj6qbVbMk2eJJRC9oL@vger.kernel.org
X-Gm-Message-State: AOJu0YylZGN7PapyLDyewFmKoJKeoMHgCNj+VBKGM4t9U5ECFUhfPaDr
	GAg0beMtYdT8sSUIrGa7iDQTq8tralmLJk0zvzwoZK2m8V1K3pzuy5a1aWb1hkxUXLRpGmHh+J5
	0ZEVm/V2LXjMhdOX6aysfFoZWteLmQ4Rf
X-Google-Smtp-Source: AGHT+IFc7eRXv1Z2roQsB71dAwxnkCOD6ZA3RMBoo3SlhllR1cKDJMbCeG4Z6pG6xJjbW8fu1nUZP13mCuSgJPwx0qU=
X-Received: by 2002:a2e:bc15:0:b0:2fb:6181:8ca1 with SMTP id
 38308e7fff4ca-2fcbdf5f91emr241525281fa.6.1730975432784; Thu, 07 Nov 2024
 02:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com> <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com> <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
 <20241106134034.GN458827@nvidia.com> <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
In-Reply-To: <4c9fd886-3305-4797-9091-3f9b0b9ee0b6@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 11:30:20 +0100
Message-ID: <CAFULd4Z86uiH+w+1N36kOuhYZ5_ZkQkaEN6nyPh8VNJth3WNhg@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, santosh.shukla@amd.com, 
	pandoh@google.com, kumaranand@google.com, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c95d6a0626501f02"

--000000000000c95d6a0626501f02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:02=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
>
>
> On Wed, Nov 6, 2024, at 14:40, Jason Gunthorpe wrote:
> > On Wed, Nov 06, 2024 at 11:01:20AM +0100, Uros Bizjak wrote:
> >> On Wed, Nov 6, 2024 at 9:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> >
> >> > On Tue, Nov 5, 2024, at 13:30, Joerg Roedel wrote:
> >> > > On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit wr=
ote:
> >> > >>  include/asm-generic/rwonce.h   | 2 +-
> >> > >>  include/linux/compiler_types.h | 8 +++++++-
> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> > >
> >> > > This patch needs Cc:
> >> > >
> >> > >       Arnd Bergmann <arnd@arndb.de>
> >> > >       linux-arch@vger.kernel.org
> >> > >
> >> >
> >> > It also needs an update to the comment about why this is safe:
> >> >
> >> > >> +++ b/include/asm-generic/rwonce.h
> >> > >> @@ -33,7 +33,7 @@
> >> > >>   * (e.g. a virtual address) and a strong prevailing wind.
> >> > >>   */
> >> > >>  #define compiletime_assert_rwonce_type(t)                       =
            \
> >> > >> -    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D size=
of(long long),  \
> >> > >> +    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D size=
of(__dword_type), \
> >> > >>              "Unsupported access size for {READ,WRITE}_ONCE().")
> >> >
> >> > As far as I can tell, 128-but words don't get stored atomically on
> >> > any architecture, so this seems wrong, because it would remove
> >> > the assertion on someone incorrectly using WRITE_ONCE() on a
> >> > 128-bit variable.
> >>
> >> READ_ONCE() and WRITE_ONCE() do not guarantee atomicity for double
> >> word types. They only guarantee (c.f. include/asm/generic/rwonce.h):
> >>
> >>  * Prevent the compiler from merging or refetching reads or writes. Th=
e
> >>  * compiler is also forbidden from reordering successive instances of
> >>  * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of so=
me
> >>  * particular ordering. ...
> >>
> >> and later:
> >>
> >>  * Yes, this permits 64-bit accesses on 32-bit architectures. These wi=
ll
> >>  * actually be atomic in some cases (namely Armv7 + LPAE), but for oth=
ers we
> >>  * rely on the access being split into 2x32-bit accesses for a 32-bit =
quantity
> >>  * (e.g. a virtual address) and a strong prevailing wind.
> >>
> >> This is the "strong prevailing wind", mentioned in the patch review at=
 [1].
> >>
> >> [1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com/
>
> I understand the special case for ARMv7VE. I think the more important
> comment in that file is
>
>   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
>   * atomicity. Note that this may result in tears!
>
> The entire point of compiletime_assert_rwonce_type() is to ensure
> that these are accesses fit the stricter definition, and I would
> prefer to not extend that to 64-bit architecture. If there are users
> that need the "once" behavior but not require atomicity of the
> access, can't that just use __READ_ONCE() instead?

If this is the case, then the patch could be simply something like the
attached (untested) patch.

Thanks,
Uros.

--000000000000c95d6a0626501f02
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m3761jhw0>
X-Attachment-Id: f_m3761jhw0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCBiL2luY2x1ZGUvbGlu
dXgvY29tcGlsZXJfdHlwZXMuaAppbmRleCAxYTk1N2VhMmY0ZmUuLjk0YTE4ZThjY2Y3ZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvY29tcGlsZXJfdHlwZXMuaApAQCAtNDY5LDcgKzQ2OSw4IEBAIHN0cnVjdCBmdHJhY2VfbGlr
ZWx5X2RhdGEgewogCQl1bnNpZ25lZCB0eXBlOgkodW5zaWduZWQgdHlwZSkwLAkJCVwKIAkJc2ln
bmVkIHR5cGU6CShzaWduZWQgdHlwZSkwCiAKLSNkZWZpbmUgX191bnF1YWxfc2NhbGFyX3R5cGVv
Zih4KSB0eXBlb2YoCQkJCVwKKyNpZiBkZWZpbmVkKENPTkZJR19BUkNIX1NVUFBPUlRTX0lOVDEy
OCkgJiYgZGVmaW5lZChfX1NJWkVPRl9JTlQxMjhfXykKKyAjZGVmaW5lIF9fdW5xdWFsX3NjYWxh
cl90eXBlb2YoeCkgdHlwZW9mKAkJCQlcCiAJCV9HZW5lcmljKCh4KSwJCQkJCQlcCiAJCQkgY2hh
cjoJKGNoYXIpMCwJCQkJXAogCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhjaGFyKSwJ
CVwKQEAgLTQ3Nyw3ICs0NzgsMTkgQEAgc3RydWN0IGZ0cmFjZV9saWtlbHlfZGF0YSB7CiAJCQkg
X19zY2FsYXJfdHlwZV90b19leHByX2Nhc2VzKGludCksCQlcCiAJCQkgX19zY2FsYXJfdHlwZV90
b19leHByX2Nhc2VzKGxvbmcpLAkJXAogCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhs
b25nIGxvbmcpLAlcCisJCQkgX19zY2FsYXJfdHlwZV90b19leHByX2Nhc2VzKF9faW50MTI4KSwJ
CVwKIAkJCSBkZWZhdWx0OiAoeCkpKQorI2Vsc2UKKyAjZGVmaW5lIF9fdW5xdWFsX3NjYWxhcl90
eXBlb2YoeCkgdHlwZW9mKAkJCQlcCisJCV9HZW5lcmljKCh4KSwJCQkJCQlcCisJCQkgY2hhcjoJ
KGNoYXIpMCwJCQkJXAorCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhjaGFyKSwJCVwK
KwkJCSBfX3NjYWxhcl90eXBlX3RvX2V4cHJfY2FzZXMoc2hvcnQpLAkJXAorCQkJIF9fc2NhbGFy
X3R5cGVfdG9fZXhwcl9jYXNlcyhpbnQpLAkJXAorCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9j
YXNlcyhsb25nKSwJCVwKKwkJCSBfX3NjYWxhcl90eXBlX3RvX2V4cHJfY2FzZXMobG9uZyBsb25n
KSwJXAorCQkJIGRlZmF1bHQ6ICh4KSkpCisjZW5kaWYKIAogLyogSXMgdGhpcyB0eXBlIGEgbmF0
aXZlIHdvcmQgc2l6ZSAtLSB1c2VmdWwgZm9yIGF0b21pYyBvcGVyYXRpb25zICovCiAjZGVmaW5l
IF9fbmF0aXZlX3dvcmQodCkgXAo=
--000000000000c95d6a0626501f02--

