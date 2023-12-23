Return-Path: <linux-arch+bounces-1171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413681D215
	for <lists+linux-arch@lfdr.de>; Sat, 23 Dec 2023 05:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B0128583B
	for <lists+linux-arch@lfdr.de>; Sat, 23 Dec 2023 04:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E9B6110;
	Sat, 23 Dec 2023 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmZOmP5G"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D146108;
	Sat, 23 Dec 2023 04:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACCBC433C8;
	Sat, 23 Dec 2023 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703304655;
	bh=REV9/Zx5FgKggOJ8WxjNU6ABdvkJMIvl6xbQ7ra4ahs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JmZOmP5GZ4X1zSpVjaJcxWvbZ0gV/+qqDcOvY0z9iwMuJQgxr1hOazBnVSBwCl/tj
	 CAg9g3pUOcPFc+V41306d2/vbQggAuVV3VVy+6LGZW5/YlV64iwh6vqd7HakhZeq9L
	 LS5XrUMOKvMJGHu4GvABy43ePZgwUi3NYFjFaIx0sCiOUZvz/LvLAy/9QuESx5Vku5
	 IpIaEsnUDQBYRzA1kuWpqsqDRHjSlaLp6hB4DXMTDa4xMDdZw1HG/nwwfxIiF3aHkY
	 itxeWdY3J/Cr4P6IiWFF0B/J9WTgq1EYVx3NVa5cniv/RfZMK/fyXghVi1brPWz/gG
	 yQpi0RQDc9A9Q==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5945c41e32cso71190eaf.0;
        Fri, 22 Dec 2023 20:10:55 -0800 (PST)
X-Gm-Message-State: AOJu0YyvLwJBeuT9u12LuJg1WxMhsZTKEVpr9urlQtqxk7VhxjpFdPuk
	GpBwHX9K+CQUGFu/n1FN4ycRSySm+VuUGAWjwLo=
X-Google-Smtp-Source: AGHT+IHf0WKxpXoa1Zs4E2Uu5+s9HyvBN6AATppCUNZ9xo4bMSjfttgvbiykHjLqhGscQ0rIAPE35s735pXmZaakrKs=
X-Received: by 2002:a05:6870:a706:b0:203:f963:d969 with SMTP id
 g6-20020a056870a70600b00203f963d969mr2737463oam.34.1703304655002; Fri, 22 Dec
 2023 20:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <20231122221814.139916-4-deller@kernel.org>
 <CAK7LNARgQ0t=4dfkJXDhSzdFGbxDuN2kPGxTgDR7siCYTtGU5w@mail.gmail.com> <7a504ceb-da00-4c0b-acc0-3ab48fb60f5e@gmx.de>
In-Reply-To: <7a504ceb-da00-4c0b-acc0-3ab48fb60f5e@gmx.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 13:10:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5gyn0C9EJhh1EeFT7gF0rOudWcdqAVN=+C4jR42W90w@mail.gmail.com>
Message-ID: <CAK7LNAT5gyn0C9EJhh1EeFT7gF0rOudWcdqAVN=+C4jR42W90w@mail.gmail.com>
Subject: Re: [PATCH 3/4] vmlinux.lds.h: Fix alignment for __ksymtab*,
 __kcrctab_* and .pci_fixup sections
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org, linux-arch@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 6:02=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> On 12/21/23 14:07, Masahiro Yamada wrote:
> > On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
> >>
> >> From: Helge Deller <deller@gmx.de>
> >>
> >> On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> >> (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
> >> 64-bit pointers into the __ksymtab* sections.
> >> Make sure that the start of those sections is 64-bit aligned in the vm=
linux
> >> executable, otherwise unaligned memory accesses may happen at runtime.
> >
> >
> > Are you solving a real problem?
>
> Not any longer.
> I faced a problem on parisc when neither #1 and #3 were applied
> because of a buggy unalignment exception handler. But this is
> not something which I would count a "real generic problem".
>
> > 1/4 already ensures the proper alignment of __ksymtab*, doesn't it?
>
> Yes, it does.
>
> >...
> > So, my understanding is this patch is unneeded.
>
> Yes, it's not required and I'm fine if we drop it.
>
> But regarding __kcrctab:
>
> >> @@ -498,6 +501,7 @@
> >>          }                                                            =
   \
> >>                                                                       =
   \
> >>          /* Kernel symbol table: Normal symbols */                    =
   \
> >> +       . =3D ALIGN(4);                                               =
    \
> >>          __kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {      =
   \
> >>                  __start___kcrctab =3D .;                             =
     \
> >>                  KEEP(*(SORT(___kcrctab+*)))                          =
   \
>
> I think this patch would be beneficial to get proper alignment:
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-inter=
nal.h
> index cd253eb51d6c..d445705ac13c 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -64,6 +64,7 @@
>
>   #define SYMBOL_CRC(sym, crc, sec)   \
>          asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
> +           ".balign 4"                                         "\n" \
>              "__crc_" #sym ":"                                   "\n" \
>              ".long " #crc                                       "\n" \
>              ".previous"                                         "\n")


Yes!


Please send a patch with this:


Fixes: f3304ecd7f06 ("linux/export: use inline assembler to populate
symbol CRCs")



--=20
Best Regards
Masahiro Yamada

