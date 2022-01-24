Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CDB49A68B
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jan 2022 03:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2373585AbiAYCSN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 21:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445632AbiAXVEj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 16:04:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DDCC06808E
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 12:04:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so329164pjl.0
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HWwbmK/pAa8TicZndugMntIsGVz9WaQyv1NGfSzTgcw=;
        b=evyr4/5YrkVKxbwBNuvYxJPRCdA1sS+6XauE9QA/AOykrR1cFC5lAmQtnSW4Ni9gnD
         HRxJURxVyLSZoQ/nFrB3dPmgsdCU8KkKuxmhjkd0VELhaN+Br1rppOIEfAwAx2mDVMWD
         Hx6SOeIczWZB2HIfdkCHMLsgs3toX5mM6kres=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWwbmK/pAa8TicZndugMntIsGVz9WaQyv1NGfSzTgcw=;
        b=EArO3lrnOWKHdDYEp1va7qZa5PRRbVfsY6eX8V1NaH7EnHeF23QTZbxZe1q3G1Yitx
         riNtl4psj1tbIfJ3CZzqEq7sm+58IXXl3Uj5CtS5BNhmCvI+3CWPQARCfMIS1zzWDg98
         xwOzv8WEOJ+h+ofBXE5MNxvFaMlSUtandk2QypskFgxIlz6Vgi9VlTS1PmXZdxmlTZG1
         Lwn/YdD61PEtUfbdeWk7Yq74TUOilLFrSbbBfhXHRS9ap4wHBylRCyFNfLWfzdYfBPr7
         z13+QUyQAU7GhrEC9yJfjduucr4Z2fY/sBJ65VDaCwhYc8kibBbdSG+bRvOStyDF/zQm
         jq/g==
X-Gm-Message-State: AOAM5329n0LZuFQV6t/9ej9uakDDFXzMY9lKwRVHxQ3t80lKmzryU1VL
        ICOKo7NObhJ0BnCnpNTeh24BXg==
X-Google-Smtp-Source: ABdhPJyey0HzmygEmv9p2/wz3TGvEUw5WhWIlrs4My5MbuEhhFNmubVbuxVL85Pw43NTudYXYZas3w==
X-Received: by 2002:a17:902:8ec9:b0:149:8864:cfd4 with SMTP id x9-20020a1709028ec900b001498864cfd4mr15745741plo.16.1643054659774;
        Mon, 24 Jan 2022 12:04:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n34sm15246142pfv.209.2022.01.24.12.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 12:04:19 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:04:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        carnil@debian.org, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] Revert "Makefile: Do not quote value for
 CONFIG_CC_IMPLICIT_FALLTHROUGH"
Message-ID: <202201241203.BC2D1B63@keescook>
References: <20220120053100.408816-1-masahiroy@kernel.org>
 <CAKwvOd=52G2J2nXRbefjJ57B_ySZaZ6SD8UwwHziZMPoR6ABHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=52G2J2nXRbefjJ57B_ySZaZ6SD8UwwHziZMPoR6ABHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 11:55:43AM -0800, Nick Desaulniers wrote:
> + Salvatore, Kees, Gustavo, Nathan
> 
> On Wed, Jan 19, 2022 at 9:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This reverts commit cd8c917a56f20f48748dd43d9ae3caff51d5b987.
> >
> > Commit 129ab0d2d9f3 ("kbuild: do not quote string values in
> > include/config/auto.conf") provided the final solution.

Oh nice!

> >
> > Now reverting the temporary workaround.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> > ---
> >
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 3f07f0f04475..c94559a97dca 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -778,7 +778,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> >  KBUILD_CFLAGS += $(stackp-flags-y)
> >
> >  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> > -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
> > +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CPPFLAGS += -Qunused-arguments
> > --
> > 2.32.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
Kees Cook
