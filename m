Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8057D91FB8
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfHSJNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 05:13:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34290 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHSJNX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 05:13:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id g128so778098oib.1;
        Mon, 19 Aug 2019 02:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0y2+cvmrQ2J36ckpTJ1wK3QpGmGrA4dEroFbUBTAf2k=;
        b=fnxR+KhYdylupWaDcNbWj/D+HxL2aagWFKY2R1O3M1fajLcYt8ckeSWJYy3YHl47yz
         1Qcilttk6IH4RVsLGlDjsEAnzJGaXhyDFt07wDQ/iuElbxkOwUYj77cT2whz9r4F7/wX
         2BjGC5abEVwFBCnn+vSdoUCVgQjQ2BXozM/C2GV1hu6UxC4p/dYH4+vaX6/czjNEO0sE
         K1dU71FucUkkVsIY7dE5SlWDuHr7YuBVXdvtc5pMoIpFLMA2D0RUXy6yOE30sPxXeLB3
         r2eXxFoJBXl3MZTLVt8kNUXAN3o3SfZ/G+B/ZuMAFQ5Ht6wr8IgnGXSyycaf3Grr1E8d
         cLIw==
X-Gm-Message-State: APjAAAUn89m6bP9K/jdpDXK2c+xSZRF5FrDvZtAlNDMENnCZTaR8C/Ot
        Yg38m5xarGhnsHe3V2//AWgYUFd+4sSGPMvF5VO0+esu
X-Google-Smtp-Source: APXvYqx47jLY4yaIeyXgLPXjrzjmn42FcnQLatOy99DdZ2Om2H8oFE6ANbFROVIMOq3cgh5udAE8d2kYfC7pgQF5Czg=
X-Received: by 2002:a54:478d:: with SMTP id o13mr12747916oic.54.1566206002310;
 Mon, 19 Aug 2019 02:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190819055421.13482-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190819055421.13482-1-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 11:13:11 +0200
Message-ID: <CAMuHMdVpn01Tcjm1Z3Jp--kiNYf4R5=AyH-huc26RwP19w9OZQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add CONFIG_ASM_MODVERSIONS
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 19, 2019 at 7:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Add CONFIG_ASM_MODVERSIONS to remove one if-conditional nesting
> from Makefile.build
>
> This also avoid $(wildcard ...) evaluation for every descending,
> but I did not see measurable performance improvement.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  arch/m68k/Kconfig      | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
