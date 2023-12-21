Return-Path: <linux-arch+bounces-1151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895C81B6FC
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 14:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6471C2302B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6936E2A1;
	Thu, 21 Dec 2023 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9/5Tybk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76E6979B;
	Thu, 21 Dec 2023 13:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608C8C433C8;
	Thu, 21 Dec 2023 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703164111;
	bh=iA0nMBqfGGvyFCpyzaTwayJwz5GyTjLlqiAdO6NpX0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V9/5Tybkt7owiZq1VzlYE78r7O/R++PQqPqgMK8eZ4E/w6uYXnXJw1yLWxuIOsbPU
	 IkSJMNKaN+IQoo6MIrymT8vFXG2AzOnKQSCNWexrLRXTKeLkXWHs1aPiAn+12K95+b
	 fhc04oIbk2qkM3zH2ChH44/7xhDS7k74By4bG5kr7c0Q/4sjofIyV8xnuNOU+zsWRA
	 AD8shMxfnQTWFnMZRyZupiS/aX1uCpWlsMvEqiSlmg7jgaLfJ6agB5rWodWWnqj87E
	 uifdEadvCN7hmnaICXmXnqYpYQUOutJy1vh05on1rWPbT8r86ZkCX3oQ359Fwmw4xc
	 SLQPqNvdGeUQg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2041c292da8so473070fac.3;
        Thu, 21 Dec 2023 05:08:31 -0800 (PST)
X-Gm-Message-State: AOJu0YzT0JfmX6JxMHm5wTSlG/hPxfY3RxuAYtQ2/nT9O7+kxxVcezpk
	PXKHaB6ma915Bu8a8l7i7VsjyQHa8Mvo9vC/exA=
X-Google-Smtp-Source: AGHT+IHwZ+9ZrMjZ/s27O4pXGsY8niPUk4a4s88Max/9z2dQkBPlGNyxZrffUnFgxBYMLkgU0m/v8uVoQCvdgF11+mY=
X-Received: by 2002:a05:6870:b51e:b0:204:1204:d2c5 with SMTP id
 v30-20020a056870b51e00b002041204d2c5mr1481574oap.102.1703164110637; Thu, 21
 Dec 2023 05:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <20231122221814.139916-4-deller@kernel.org>
In-Reply-To: <20231122221814.139916-4-deller@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 21 Dec 2023 22:07:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgQ0t=4dfkJXDhSzdFGbxDuN2kPGxTgDR7siCYTtGU5w@mail.gmail.com>
Message-ID: <CAK7LNARgQ0t=4dfkJXDhSzdFGbxDuN2kPGxTgDR7siCYTtGU5w@mail.gmail.com>
Subject: Re: [PATCH 3/4] vmlinux.lds.h: Fix alignment for __ksymtab*,
 __kcrctab_* and .pci_fixup sections
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-modules@vger.kernel.org, linux-arch@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
> 64-bit pointers into the __ksymtab* sections.
> Make sure that the start of those sections is 64-bit aligned in the vmlin=
ux
> executable, otherwise unaligned memory accesses may happen at runtime.


Are you solving a real problem?


1/4 already ensures the proper alignment of __ksymtab*, doesn't it?



I applied the following hack to attempt to
break the alignment intentionally.


diff --git a/include/asm-generic/vmlinux.lds.h
b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..e2b5c9acee97 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -482,7 +482,7 @@
        TRACEDATA                                                       \
                                                                        \
        PRINTK_INDEX                                                    \
-                                                                       \
+       . =3D . + 1;                                                      \
        /* Kernel symbol table: Normal symbols */                       \
        __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
                __start___ksymtab =3D .;                                  \




The __ksymtab section and __start___ksymtab symbol
are still properly aligned due to the '.balign'
in <linux/export-internal.h>



So, my understanding is this patch is unneeded.


Or, does the behaviour depend on toolchains?








> The __kcrctab* sections store 32-bit entities, so make those sections
> 32-bit aligned.
>
> The pci fixup routines want to be 64-bit aligned on 64-bit platforms
> which don't define CONFIG_HAVE_ARCH_PREL32_RELOCATIONS. An alignment
> of 8 bytes is sufficient to guarantee aligned accesses at runtime.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: <stable@vger.kernel.org> # v6.0+


















> ---
>  include/asm-generic/vmlinux.lds.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index bae0fe4d499b..fa4335346e7d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -467,6 +467,7 @@
>         }                                                               \
>                                                                         \
>         /* PCI quirks */                                                \
> +       . =3D ALIGN(8);                                                  =
 \
>         .pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {        \
>                 BOUNDED_SECTION_PRE_LABEL(.pci_fixup_early,  _pci_fixups_=
early,  __start, __end) \
>                 BOUNDED_SECTION_PRE_LABEL(.pci_fixup_header, _pci_fixups_=
header, __start, __end) \
> @@ -484,6 +485,7 @@
>         PRINTK_INDEX                                                    \
>                                                                         \
>         /* Kernel symbol table: Normal symbols */                       \
> +       . =3D ALIGN(8);                                                  =
 \
>         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
>                 __start___ksymtab =3D .;                                 =
 \
>                 KEEP(*(SORT(___ksymtab+*)))                             \
> @@ -491,6 +493,7 @@
>         }                                                               \
>                                                                         \
>         /* Kernel symbol table: GPL-only symbols */                     \
> +       . =3D ALIGN(8);                                                  =
 \
>         __ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {     \
>                 __start___ksymtab_gpl =3D .;                             =
 \
>                 KEEP(*(SORT(___ksymtab_gpl+*)))                         \
> @@ -498,6 +501,7 @@
>         }                                                               \
>                                                                         \
>         /* Kernel symbol table: Normal symbols */                       \
> +       . =3D ALIGN(4);                                                  =
 \
>         __kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {         \
>                 __start___kcrctab =3D .;                                 =
 \
>                 KEEP(*(SORT(___kcrctab+*)))                             \
> @@ -505,6 +509,7 @@
>         }                                                               \
>                                                                         \
>         /* Kernel symbol table: GPL-only symbols */                     \
> +       . =3D ALIGN(4);                                                  =
 \
>         __kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {     \
>                 __start___kcrctab_gpl =3D .;                             =
 \
>                 KEEP(*(SORT(___kcrctab_gpl+*)))                         \
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada

