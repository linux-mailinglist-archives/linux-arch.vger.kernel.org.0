Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82CA6C78A3
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 08:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCXHRl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCXHRk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 03:17:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D110248;
        Fri, 24 Mar 2023 00:17:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e11so721473lji.8;
        Fri, 24 Mar 2023 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679642257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVnaw2hgp9FboCDJT5LeK6jax5DS42qierHOwTuDhEo=;
        b=Ul5Adt9vV73KOAtCJAPoRUkFbMKviWxP75y69ETtv/S51sJstcOJ19GDH1v5GgaIH5
         ie8SUq/GF1InOqbSL8l3BsX++GWMFjPZ0V9Oo7I836RPMn5UGxyxaMI31jNDPH0+0a/y
         SlVa5EM9CbnZf2Es5Q80uxeLOcteFd+Hdq1D//th/TAy7qJivRv51ltLC8SrRvYdUOWx
         TEH9NG6rL5Za5dZO2h0gd6XBpFFduEgtsCmS5iLJZmeMFweBY/w1sGSUA7ma0Be8M86E
         YR9UsxCjtvoQK02am7a1rSdRgHD7uJoVha30Hiq2CND/s3xIGgOPGUfxJhK4o70ML+FD
         3/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVnaw2hgp9FboCDJT5LeK6jax5DS42qierHOwTuDhEo=;
        b=tOrWtr+0tyer04gF7yABjc5G0/1YE1kJjX8zUNs0+k7v9YyLLOcAVP6P7MdgtwGiRQ
         akfCexWHdNMMxCXl6PvFzAyqt2Q1sz/qgBAn5pcu/UPDwnjYO77Df0V9bkIZCp/kaddZ
         WePCvgP8dSum87rLJb7MHXqkJcfPbmZaV+WMoMFvXvZ1ra9RZeTq8k6KflCbyfQaJ/Q8
         MY3Qal0qIDHF1QwawSoWHu6Rs6+lrH8KIyVz/IWZUQaUGrYvdBJFlq+fsnsUjEGaO7th
         gWmVtFrKXDksmYGcbNdU4GZoGIOE8dSnz8Xtp6hf3Ysm6eCYkAzXVhbBnB5Z+S6C85L5
         WdpA==
X-Gm-Message-State: AAQBX9fQBUqXEdg8YqEzF+nfsl/QIvmdeJmjh+S16keyTH4/OECH2W6Z
        YrCP6RJNxtmEFTZJUtQepkDMvSk6u6+AUtcjjCQ=
X-Google-Smtp-Source: AKy350arIb/k/z4ZK/W5u7TFlWu9j/tTPVd9U0ey6zviqDiriCkTXQIxOjJaYRkvPgrom/IIrbeqvU+tvox/p4/gnlw=
X-Received: by 2002:a2e:240b:0:b0:29c:9226:33f7 with SMTP id
 k11-20020a2e240b000000b0029c922633f7mr555322ljk.1.1679642256759; Fri, 24 Mar
 2023 00:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323221948.352154-1-corbet@lwn.net> <20230323221948.352154-2-corbet@lwn.net>
In-Reply-To: <20230323221948.352154-2-corbet@lwn.net>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 24 Mar 2023 15:16:59 +0800
Message-ID: <CAJy-Am=B6ELff_oQ01HVhoe1wLXw0m89=xzJjouNJwhvAVRozA@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs: zh_CN: create the architecture-specific
 top-level directory
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 6:20=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> This mirrors commit 4f1bb0386dfc ("docs: create a top-level arch/
> directory"), creating a top-level directory to hold architecture-specific
> documentation.
>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks alot for take core!

Acked-by: Alex Shi <alexs@kernel.org>

> ---
>  .../translations/zh_CN/{arch.rst =3D> arch/index.rst}  | 12 ++++++------
>  Documentation/translations/zh_CN/index.rst           |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>  rename Documentation/translations/zh_CN/{arch.rst =3D> arch/index.rst} (=
72%)
>
> diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/tr=
anslations/zh_CN/arch/index.rst
> similarity index 72%
> rename from Documentation/translations/zh_CN/arch.rst
> rename to Documentation/translations/zh_CN/arch/index.rst
> index 690e173d8b2a..aa53dcff268e 100644
> --- a/Documentation/translations/zh_CN/arch.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -8,12 +8,12 @@
>  .. toctree::
>     :maxdepth: 2
>
> -   mips/index
> -   arm64/index
> -   riscv/index
> -   openrisc/index
> -   parisc/index
> -   loongarch/index
> +   ../mips/index
> +   ../arm64/index
> +   ../riscv/index
> +   ../openrisc/index
> +   ../parisc/index
> +   ../loongarch/index
>
>  TODOList:
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/t=
ranslations/zh_CN/index.rst
> index 7c3216845b71..299704c0818d 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -120,7 +120,7 @@ TODOList:
>  .. toctree::
>     :maxdepth: 2
>
> -   arch
> +   arch/index
>
>  =E5=85=B6=E4=BB=96=E6=96=87=E6=A1=A3
>  --------
> --
> 2.39.2
>
