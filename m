Return-Path: <linux-arch+bounces-8439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16B9ABE7A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B671F212EB
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E6146D7F;
	Wed, 23 Oct 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="TZPihWbs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6BEAC5
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664060; cv=none; b=syhLeXXHRL4nMBgYrDVeR1jN5Xq4hpidqodQgs/CbmptMDEAHnQw5+KSQY3T2AghHY6AM0uTgSs6MdQpDEWHsDDc0SqX5oCwiwoADSln9vNTGyyEY0wNuZNU7PUGXyBNv9A13GYEuwVVk7y2PvbJedsVmmZrbeHmGNw7DjhRHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664060; c=relaxed/simple;
	bh=nqh7gLyzY+i65hjx8EFoScR4DFxG12Nr8EwO1Gal6os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCE1XVPBBnJqRZJfoa462lFFuSEfm099ihFkezPW19IJFRo6YaBeWshipB/5yI9tCpxnHSi27PbYmKRGlNxhDQ10R6kPshzfs49+SIWV2adW8YgfKYzXyABo3n/ks9dE/BGTUiMWX8q5ZI2HyzsHBQwks6J6EOdZ3O+2Ez1h7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=TZPihWbs; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e290200a560so6135159276.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1729664056; x=1730268856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoS2U7s/nFksZ9J1s9QFWx+X3+eAJT+8MCN58PfkFnc=;
        b=TZPihWbsrHb6PASNwB/9hVmXG28lWrf0hnusu1Hnj8x7+jvlivaiw3/Hg0ZHonYPQ+
         jo1VVf/H+vLZeETT5qFv/48HRVxk8wJGh30vx96y8A2A4n9Rkx64R6FU5wtYdDU16ykv
         MZ8OKVjQaj5v6LZm6Zg6fkTxiEuDPjqFeO0j01mALvfGyt8kH8kpHz9ut2p2WDn7D84e
         sMZUdBf0cHHcrnXhCQ23RVZp9fv6J+G5gBCkSq1s2bTXLsKG+k1kUDOwIr4DYFa6GhHc
         2NxkSPtRLV/U2clMee3jEc5UcJJskQRy6ttmaMLDhLuH9tY1KKxdZdOWMHVBCWk8Nwzi
         VKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729664056; x=1730268856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoS2U7s/nFksZ9J1s9QFWx+X3+eAJT+8MCN58PfkFnc=;
        b=blSEtA/oRo6sVHaXcStxblOS0klP1vRJCj30oRYIeLhNEfWVeS54ofl0H4s/JfM2qj
         PEXqpz4J7Qen2w8Agulnog82JE3Cms7I7O0jrxqlrZDi+j+QSgi1Ex0CK1px+1G3dsiE
         mxdQ74QXoRwcG+UqqncurjQWosAXjrZHm3gHDEEmY8BbGvs283J/u9f+Z05MafXDS/Ya
         cz1ctTUCj3rYonfQBREKKHXxA6PNv8sX68Tgxxzs9YQBrFLzbh7mnK5673r1oHKSL6id
         c6Gi5dPuznxtQp4QGXtd/ny2/BgX/1SsSRNiRpGdjqJfTSiMJ+8r8MDOUmgl5wV/QwrZ
         ZtxA==
X-Forwarded-Encrypted: i=1; AJvYcCWKIdvGSEWE+JwzHrWi/mHFecHrVkU1gy3Hu4Ahqi5cDthQn6DWJ/hjHQb8CJDFBMbjltG2psI11ugb@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzZSij39WMAJVQWKCpC33AJtnRiyorHKQrQQ5GiyxBfY7NX1q
	fA6k0rnX/9fEI1FYduG/6fB353kEboiLjgJdxH6SLWAM7uB9Ypqsd2jdl+ShXMvLCsE2DGhvqaa
	fosCrP4DGuz8uv8trnUSCTCG7cgEspy0SQ3ms
X-Google-Smtp-Source: AGHT+IFA5LEZ6NSkdL+eAT7VRNLI9QSpKEtQ/weC0pt7eFRLDuRnLq3OtL5MZy9G1Fwyy6ovNADqFizSPXG6bmNR0hg=
X-Received: by 2002:a05:6902:848:b0:e2b:e1be:f7b5 with SMTP id
 3f1490d57ef6-e2e3a609706mr1383172276.8.1729664056118; Tue, 22 Oct 2024
 23:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502173132.57098-1-thuth@redhat.com> <834e8e07-b77b-4921-ab42-87cc434f50e9@redhat.com>
In-Reply-To: <834e8e07-b77b-4921-ab42-87cc434f50e9@redhat.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 23 Oct 2024 08:14:04 +0200
Message-ID: <CAHTX3dJiZodBSBxPOEFApH=jUXfqdaAGAf61Rzvykb4bx6q65w@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Remove empty #ifndef __ASSEMBLY__ statement
To: Thomas Huth <thuth@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 22. 10. 2024 v 20:13 odes=C3=ADlatel Thomas Huth <thuth@redhat.com>=
 napsal:
>
> On 02/05/2024 19.31, Thomas Huth wrote:
> > Likely an unnecessary remainder of the scripted UAPI cleanup that
> > happened long ago...
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   arch/microblaze/include/uapi/asm/setup.h | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze=
/include/uapi/asm/setup.h
> > index 6831794e6f2c..16c56807f86a 100644
> > --- a/arch/microblaze/include/uapi/asm/setup.h
> > +++ b/arch/microblaze/include/uapi/asm/setup.h
> > @@ -14,7 +14,4 @@
> >
> >   #define COMMAND_LINE_SIZE   256
> >
> > -# ifndef __ASSEMBLY__
> > -
> > -# endif /* __ASSEMBLY__ */
> >   #endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
>
> Ping?

thanks for ping. I didn't see the first patch.

Applied.
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

