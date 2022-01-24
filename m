Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC149959B
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 22:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbiAXUxP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390680AbiAXUqD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 15:46:03 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627FDC061345
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 11:55:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z7so9184013ljj.4
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsGwBiMEkwe4bLg19ywjdJZ3/5M1hRBHlVRcQEjbGmo=;
        b=rtbY+gqfHYd5dj6xP5LOP4QpTVnE0wZG3g8n7uzpDUJ4jVInle5CceB62w4oNxWy8u
         xXN8vN7IrBOKmQcgtvQFaTfgpVvlZ1C7rg8TWBiysAfRSiqHZV5kZTrpHFseJFjMV4Od
         +Jk5BAqTQjingEkJlsAfH3x7sfC03xhNfh0ADDu2Y2dMke7fwHzLmPKHUaTG7d2OKHNx
         fysiqoVSVENsXqjTFvu/VWsdgDVMLFS6QU1EAZh0HnTGPYzaozPOI7hgaS4vbnNHE24k
         ov5CQ5YvZP7tmNZBSSD6kToX7EO1i/6HTOWafDrGLNTOSJU6Ciew4FpN1aYt0fGglLwQ
         8/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsGwBiMEkwe4bLg19ywjdJZ3/5M1hRBHlVRcQEjbGmo=;
        b=W9OkvOPtU9+ZwxVpAN8wRbWgl9gXXlNM/zCHjABG6WpV04JLBBvcqkqSv7QdYQAT3/
         8PctQQNbkwXphT0/+gkFLS37HfRNW5E7SZHHYd4T+gt3xIfEiCZ6su1cv0l+M7MkvGeG
         3KYQpwlOFZRYgA8HqvwAUaClTo81VgjvNUw9KDhqXK4xk7p345+fySsE4xXWbByYq0sp
         YZikM1eh7yXtt4B2pQCtSBhOp5+JxBfzxaSoop4VAZbfOv1l1K+EBD9KdOhlB3KW8J97
         esSsKAoyLCE/QA/11/xKhxdiyDor9H1bzeO/Prk2ethzFYQAnxFsoY35RHREnr4afIwZ
         if7g==
X-Gm-Message-State: AOAM530Oz7PRnMCXx58oV7Ic+rGBbboyQW95frotPfktfbGMQE5i6aU2
        5+0GANTABA93gAuLC29zINov19QIsOW8xpt8RWWILQ==
X-Google-Smtp-Source: ABdhPJyOtLsKZqsENjScci++5Pp4Q0kOx1naLw57dM5+mMcu04T6dj7bnpqZLaem4TA31GMKPuqL3D7+h16zW5aDmyc=
X-Received: by 2002:a2e:8283:: with SMTP id y3mr12029632ljg.128.1643054155425;
 Mon, 24 Jan 2022 11:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20220120053100.408816-1-masahiroy@kernel.org>
In-Reply-To: <20220120053100.408816-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 11:55:43 -0800
Message-ID: <CAKwvOd=52G2J2nXRbefjJ57B_ySZaZ6SD8UwwHziZMPoR6ABHQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Makefile: Do not quote value for CONFIG_CC_IMPLICIT_FALLTHROUGH"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        carnil@debian.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+ Salvatore, Kees, Gustavo, Nathan

On Wed, Jan 19, 2022 at 9:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This reverts commit cd8c917a56f20f48748dd43d9ae3caff51d5b987.
>
> Commit 129ab0d2d9f3 ("kbuild: do not quote string values in
> include/config/auto.conf") provided the final solution.
>
> Now reverting the temporary workaround.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 3f07f0f04475..c94559a97dca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -778,7 +778,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  KBUILD_CFLAGS += $(stackp-flags-y)
>
>  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
