Return-Path: <linux-arch+bounces-15053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E2C7CF12
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 12:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6D53AA091
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573E2FCBE3;
	Sat, 22 Nov 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyMF9bSj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1D2857C1
	for <linux-arch@vger.kernel.org>; Sat, 22 Nov 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812724; cv=none; b=J//qxqJ3ALkwCPIZ20xTYm0G6V1758tS1H7TyUqrzh6DjF8W4TPmzOncnzZ0ik6kgnrbP3eDQNqfgT8wZnQ+V4GjZvURWAvyq002mrdKzD911RbUOZkb6phKvhODU9fl6gB1FygpZ7pi+ubsg3fTv69Yy9l4f1tJ4p14YNNgZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812724; c=relaxed/simple;
	bh=lVscBSlapZVI6h7fcPrKOthynCe/yoerdT+HBvoA1IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxnAw9IgZdMx9tb/LzeVc3LAar+0m0/yE9hp3bMSNMDn6/JZt+Wu4jEs8lWb5QTdfvwV49U5gUNh3cKJEjtp7b9ZCESRbM/jTWToU482A/57BfnGMlDbtk2RD0xkIYUih/afWipu/wbofFvWDu8dAqo4XU2aqeaJBMB88EFi/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyMF9bSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E694C4CEF5
	for <linux-arch@vger.kernel.org>; Sat, 22 Nov 2025 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763812724;
	bh=lVscBSlapZVI6h7fcPrKOthynCe/yoerdT+HBvoA1IE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XyMF9bSjIb2hXn2QCBA3D9dXiv6pSaTJxlSyhgKMPDYeHJfkUd4gNmlbfC/4QMXTM
	 HIpv1qk3H3ceKFBbSm7uHPXn0PNBawuaCVUWTxqmZvy9+s3qyl/W78VhMw6rCco/EN
	 KuDIidZfZqi8XgSGO5bjyNqMJr/KVlRf1xq2T8esBQWNFrQR+yP4Fe15qI3/5BIrQ/
	 h3I4c9/RmjdPlz3HphVftJagWxdHX//TxPw3NMEuVfO65wQA6XFVwPurPwUdORhs9n
	 GP6n/Pad7gJ+CPlyisqyDf7+OV8M8OhUUoNXfDyW6Y7bH8jFkgnJtVnmXDJ0fFpqy0
	 v/JCd3eAeV1ug==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b735b7326e5so677223766b.0
        for <linux-arch@vger.kernel.org>; Sat, 22 Nov 2025 03:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhCScjsOE8lN5ByTOH7OcZeC0XLq59Jq7qYN5ZL+V80JXny+NUIpjuO+HBKytWFvIEFNFGBDHxh5Ag@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ26vCPLZEM20ce7Qicxp9ngO2J3L67O1InZFvu7lSQkNv9AxC
	yRmPg/33DFPZVjIF+FeJ0nFfSDcDgy3kIVr4fdKDC+IAC32OS9+yJgw5L2J7Ws+51hKJ35WCzd4
	SN/gYJcFJzTEIPHyQnIqiadlUTLl6x0I=
X-Google-Smtp-Source: AGHT+IGgnpCPWwC88qvrkNTQwdV68kX+zS0kEjc6D2juT1eXO1UBemE3YTKBcQaY5+VvMKgQWqfVYNN/l56dh94YuSo=
X-Received: by 2002:a17:907:7e89:b0:b3f:f6d:1d9e with SMTP id
 a640c23a62f3a-b76571386d9mr1071695466b.6.1763812722662; Sat, 22 Nov 2025
 03:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn> <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
In-Reply-To: <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 22 Nov 2025 19:58:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Vemxni8PrMCeubUwWcOFAV-j6AFJg4oPdxs-VNBiUGw@mail.gmail.com>
X-Gm-Features: AWmQ_bm5gJZLzWULsM4bN1MBHln4HX0yEDFKZgU33ohqm4S5SUKK-Low_szzd24
Message-ID: <CAAhV-H4Vemxni8PrMCeubUwWcOFAV-j6AFJg4oPdxs-VNBiUGw@mail.gmail.com>
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Sat, Nov 22, 2025 at 5:45=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
> > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> > loongson64_defconfig (for 64BIT).
> >
> > Also adjust graphics drivers, such as FB_EFI is replaced with EFIDRM.
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/Makefile                       |    7 +-
> >  arch/loongarch/configs/loongson32_defconfig   | 1104 +++++++++++++++++
> >  ...ongson3_defconfig =3D> loongson64_defconfig} |    6 +-
> >  3 files changed, 1113 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/loongarch/configs/loongson32_defconfig
> >  rename arch/loongarch/configs/{loongson3_defconfig =3D> loongson64_def=
config} (99%)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index 96ca1a688984..cf9373786969 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -5,7 +5,12 @@
> >
> >  boot :=3D arch/loongarch/boot
> >
> > -KBUILD_DEFCONFIG :=3D loongson3_defconfig
> > +ifdef CONFIG_32BIT
>
> Testing for CONFIG options here doesn't make sense, as the config is not =
yet
> created. Either test for $(ARCH) or uname or just use one unconditionally=
.
> Also as mentioned before, snippets can reduce the duplication.
Thank you for your clarification. But $(ARCH) also doesn't make sense
because it is always "loongarch".

'uname' is an option but I think it doesn't work for cross compile?


Huacai

>
> > +KBUILD_DEFCONFIG :=3D loongson32_defconfig
> > +else
> > +KBUILD_DEFCONFIG :=3D loongson64_defconfig
> > +endif
> > +
> >  KBUILD_DTBS      :=3D dtbs
> >
> >  image-name-y                 :=3D vmlinux
>
> (...)

