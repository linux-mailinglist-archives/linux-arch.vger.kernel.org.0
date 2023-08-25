Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCFF788245
	for <lists+linux-arch@lfdr.de>; Fri, 25 Aug 2023 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjHYIiz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Aug 2023 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbjHYIio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Aug 2023 04:38:44 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097722114
        for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2023 01:38:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d746d030a86so689090276.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2023 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692952715; x=1693557515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvrAZfZObxxG28RSeJRcZBkrJAH4pNTBPSYNsn7KlkY=;
        b=G//T8G2z8S8EcxNudW2kZb8T7NvSRhJ9V4Rlj9qkZ3and7tONGkMBru7Ywhb3Zu+AH
         NOpG8ToWQkNELg2h1n6/isJsba5YcDum19CMEHrhNIShQU0qvHOhOLMye7Csb4GO6ZtD
         exJA4P8pxHZmrz8nCVdhH9AI/8eJJm+Vabk+bXEEtxRLl3zsk5ImjORs7lsVfLuuTO42
         jPxSnVHnpTZdhcKntPS1+W+lzI/8nYEpPaiagM/lNVYK9jTvnmvMNHWid9fta6atfOXF
         kHF22Vj0YCHiJB8PRY2KCaszWizMHT6KrBfZggxJMOZLV1FcLI8+UBFwOq77rVzRy8Px
         Nf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692952715; x=1693557515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvrAZfZObxxG28RSeJRcZBkrJAH4pNTBPSYNsn7KlkY=;
        b=Mw/Thr7L1JmvhgXxda6eMHof6MWXh7HKjrsHWlms5HBWwVH3CL1mA7Iln227FbPJlr
         duvCuq70S0qnXBzNytMtlgQe2writ86YuWwF3fM4mB9KFdSYufzLQKJs2jPIe7I/89lw
         I/Uu1ssp3x2nFtub8npn40Nrt0LZhGaWs8roVMLoV45EEaBDLtgQl70W+0w11yheFrzp
         qCEcgUJqC8g86fzcvm2ldbY1Kvp1TlXMM6etCd+tICI5M6LzlrKWtSd1L6Kw4QiOSRoG
         TJ81228zm/XD8GpmFAayF9AOXj1TxF1V+iT7CFJv5PM/Z9tQheoytdB6oj6JEBo3lz9x
         kT7A==
X-Gm-Message-State: AOJu0YxSG0g0wt2q+kduYin7nZoGLOOKENB3HXR0uO3dDrPx9hTfZIfv
        BFMt93g7qjCMc/r9kZnXh4FOajYKge7UOGztwA5B/g==
X-Google-Smtp-Source: AGHT+IFifIYPXxawPovV9xM3m3Lv62e3s1l+kC3k+cZCLqS4gUQIp5jWwXRHVgrA1LaaG5gjqQbs2fL/nEGplCnMZpw=
X-Received: by 2002:a25:2985:0:b0:c00:e25d:818f with SMTP id
 p127-20020a252985000000b00c00e25d818fmr16434538ybp.27.1692952715233; Fri, 25
 Aug 2023 01:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
 <168155747955.13678.5648956145924030241.stgit@skinsburskii.localdomain>
In-Reply-To: <168155747955.13678.5648956145924030241.stgit@skinsburskii.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:38:20 +0200
Message-ID: <CACRpkdZQbGEbpTXYm5uOZsAPAzAiSRLRsWZfDMDRFWESBu4cXA@mail.gmail.com>
Subject: Re: [PATCH 7/7] asm-generic/io.h: Expect immutable pointer in virt_to_phys
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 27, 2023 at 7:43=E2=80=AFPM Stanislav Kinsburskii
<skinsburskii@linux.microsoft.com> wrote:

> From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
>
> These helper function - virt_to_phys - doesn't need the address pointer t=
o be
> mutable.
>
> In the same time expecting it to be mutable leads to the following build
> warning for constant pointers:
>
>   warning: passing argument 1 of =E2=80=98virt_to_phys=E2=80=99 discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type
>
> Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: linux-arch@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I changed several other virt_to_phys() implementations to add const to
the argument and no problems so this should work fine.

Yours,
Linus Walleij
