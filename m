Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B237729E6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjHGP4v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjHGP4u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7610EC;
        Mon,  7 Aug 2023 08:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 607A161EA7;
        Mon,  7 Aug 2023 15:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C030BC433C9;
        Mon,  7 Aug 2023 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691423808;
        bh=bUNIbqe6RppIbQZBnDiHUXsd36cI7wjANaENlXpWX04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WPFdT9nXiYm5ey7B6THP84a8DR2nSj4h5iElCcSgiOzDpsGqe5y/B8fmH2FxJedyZ
         ZvRjZTUfy8ouzZ+oZbJvQPH9CzwEAWbnM/bTv4R12bvVRSOTn7DN4J7qsWz60tF40D
         22EVy1p7YA0Ba4GzoASorRjjF0PD7TE5PlEjRkk+oGUyKJx0UyhkPjRhzYp3xNZvTY
         ZzPkXXDTKIaM5nq0U4l1McKeyO9rh8hSQ+G4Ed64WQTEDwSAVnICb+rPzgf/eki6rR
         Cs6niX+dQ/pdcOWop5lJihOlCL7YKRBBgfvhxGkmjytnaXz/GevLs98fBayK4zv7bY
         5kuug5ZC3Rw5g==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so6234722a12.0;
        Mon, 07 Aug 2023 08:56:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YygYwLjzjOaFBxkoqEmrOKAjOoKumBcxipootdC5iSJLp6p16zB
        GdoZBgS1F8TVhpgyOtkkBFrdoAe5Uw6z4jxK4r4=
X-Google-Smtp-Source: AGHT+IFBFZhk6mL3xRA71v8RsN9CSTJPBCNjhVXhQDh3/7fw+qvw+RcjmkDAVDtc/rYFw5X/DziaJ3ZDES256H2JH0k=
X-Received: by 2002:a05:6402:12ca:b0:523:95c:9ccb with SMTP id
 k10-20020a05640212ca00b00523095c9ccbmr6769959edx.17.1691423806998; Mon, 07
 Aug 2023 08:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230807154250.998765-1-masahiroy@kernel.org> <20230807154250.998765-3-masahiroy@kernel.org>
In-Reply-To: <20230807154250.998765-3-masahiroy@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 7 Aug 2023 23:56:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7VzqPBYD0o1qAY7v7z+G9xOMq+yOR9ZTcO1SKfCXVZ0g@mail.gmail.com>
Message-ID: <CAAhV-H7VzqPBYD0o1qAY7v7z+G9xOMq+yOR9ZTcO1SKfCXVZ0g@mail.gmail.com>
Subject: Re: [PATCH 3/3] loongarch: remove <asm/export.h>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Masahiro,

Is this series only for linux-next (6.6), or also needed by 6.5?

Huacai

On Mon, Aug 7, 2023 at 11:43=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> All *.S files under arch/loongarch/ have been converted to include
> <linux/export.h> instead of <asm/export.h>.
>
> Remove <asm/export.h>.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/loongarch/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/a=
sm/Kbuild
> index 6b222f227342..93783fa24f6e 100644
> --- a/arch/loongarch/include/asm/Kbuild
> +++ b/arch/loongarch/include/asm/Kbuild
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y +=3D dma-contiguous.h
> -generic-y +=3D export.h
>  generic-y +=3D mcs_spinlock.h
>  generic-y +=3D parport.h
>  generic-y +=3D early_ioremap.h
> --
> 2.39.2
>
