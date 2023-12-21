Return-Path: <linux-arch+bounces-1150-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635B81B370
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1F61F24D63
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 10:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5373C4F884;
	Thu, 21 Dec 2023 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHXejGAb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA04F203;
	Thu, 21 Dec 2023 10:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C148FC433C9;
	Thu, 21 Dec 2023 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703154168;
	bh=NLQdNdVs2WfO85/N+bwgl3CF/QIMJF8sPAIBnqfHoyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JHXejGAbJLvIX1eOdwwOFJuPDKanbcOepVaqG+OgyvvDJHLSOBeO0hvWXVEjxN6tT
	 dY4cSa/6VyYyV78nKvrhu3dBt53Y7+i3hLxeZ99x/Gay4Cnq8Op9uOsyW+ByrLRamF
	 YdIb2+SJzPNrAMM03DSqndLVhpCgItRgZmzmjlZs6IDpKgGSXBnYRO7xUxzoK9MOiF
	 /G9/I2JRPfnBPcbF6rHOFxZZIPTVNQC9dGAO/m2U9oX2gN8IXmVCWdfi+olAiaDVax
	 lOnw/fG950c8sUbB+eT6kwYGg8du/3ER4/qcKt3gBSwvwFc1oBuh1JmTfMpbFCqnS1
	 QeCDIqvlYW64A==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204235d0913so367630fac.1;
        Thu, 21 Dec 2023 02:22:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yyc+8TqvNLH4rq+Dks+QlOtmI+dx5P2r30XjiGL7GMHMtVKv+dP
	HYLGgInI/pcvSqtJrsAA37uTYSxk7i0QLrvH6cY=
X-Google-Smtp-Source: AGHT+IFD0Wb8eYzesckvtQcgLKNMTZArhr3VRhRy5ctAEtHgOX2tQvUkW1DewMY1lnpONaKv20gyp7IJLHG6Efg7Fgc=
X-Received: by 2002:a05:6870:1702:b0:203:bcd8:c5c2 with SMTP id
 h2-20020a056870170200b00203bcd8c5c2mr1469312oae.78.1703154168121; Thu, 21 Dec
 2023 02:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <20231122221814.139916-2-deller@kernel.org>
In-Reply-To: <20231122221814.139916-2-deller@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 21 Dec 2023 19:22:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
Message-ID: <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab entries
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
> An alignment of 4 bytes is wrong for 64-bit platforms which don't define
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS (which then store 64-bit pointers).
> Fix their alignment to 8 bytes.
>
> Signed-off-by: Helge Deller <deller@gmx.de>


This is correct.

Acked-by: Masahiro Yamada <masahiroy@kernel.org>

Please add


Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")





> ---
>  include/linux/export-internal.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-inter=
nal.h
> index 69501e0ec239..cd253eb51d6c 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -16,10 +16,13 @@
>   * and eliminates the need for absolute relocations that require runtime
>   * processing on relocatable kernels.
>   */
> +#define __KSYM_ALIGN           ".balign 4"
>  #define __KSYM_REF(sym)                ".long " #sym "- ."
>  #elif defined(CONFIG_64BIT)
> +#define __KSYM_ALIGN           ".balign 8"
>  #define __KSYM_REF(sym)                ".quad " #sym
>  #else
> +#define __KSYM_ALIGN           ".balign 4"
>  #define __KSYM_REF(sym)                ".long " #sym
>  #endif
>
> @@ -42,7 +45,7 @@
>             "   .asciz \"" ns "\""                                      "=
\n"    \
>             "   .previous"                                              "=
\n"    \
>             "   .section \"___ksymtab" sec "+" #name "\", \"a\""        "=
\n"    \
> -           "   .balign 4"                                              "=
\n"    \
> +               __KSYM_ALIGN                                            "=
\n"    \
>             "__ksymtab_" #name ":"                                      "=
\n"    \
>                 __KSYM_REF(sym)                                         "=
\n"    \
>                 __KSYM_REF(__kstrtab_ ##name)                           "=
\n"    \
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada

