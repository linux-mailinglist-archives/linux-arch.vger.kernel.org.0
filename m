Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA13EE362
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 03:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhHQBdR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 21:33:17 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:55645 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbhHQBch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2021 21:32:37 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17H1VaIY014246;
        Tue, 17 Aug 2021 10:31:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17H1VaIY014246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629163896;
        bh=kY53EEVlSun2OrKhcICxxahQyp4LjpGB4vWVi50Hfv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hEgIO1zWNUAm6z5VyOMrHJozJTbFvTC4GZGGT/xs0or8+aknjNi4Qg/k+PM9xRW8H
         dhG4tEdo2VcWThFTG4dq6eAt3xiG8SjETLTVNgDb5wZypdfOciA9iXLFJ4NvZZHuEI
         aV1GUUL0ftt1kkVpeUcnjS+2IO3Jxu0JMxEBbxAk0IORaWggnO4QI/ueMTXe7w0xYD
         l7Lmu6RmCpPo5fvjzIiJC8WhBX72VUb6kZkEkps+VppZp+MzorFpzq91TeFdtGVj1B
         Z04PwxgUfciFtWVdPwJygUUSlw659yMgtf6LGDWpmLOF3Y8yH4a/ZsbKPg9SxhG6Oy
         jjz/K3fDcpqlQ==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso1483099pjb.1;
        Mon, 16 Aug 2021 18:31:36 -0700 (PDT)
X-Gm-Message-State: AOAM531Z2bX9S0TpZgOkhaDEHuWL5Nn02EE4ZDCtQ8zztisO2A6JPwP6
        T3wgRjiaygQ4IRiYG966J6kkt30h/GGz3cmybuo=
X-Google-Smtp-Source: ABdhPJzUC1mmq2wCI0eNYzNj3+5YcxsdYaAPsGrDHqhNpNjMg6v7t/v+55kBQh5YgHzqvhSB78bp5YUPd+OKtA1A/Jo=
X-Received: by 2002:a65:6459:: with SMTP id s25mr950393pgv.7.1629163895760;
 Mon, 16 Aug 2021 18:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210801201336.2224111-1-adobriyan@gmail.com> <20210801201336.2224111-2-adobriyan@gmail.com>
 <CAMj1kXHA64+6j2HRwxmh0Q9L2X65bWrURBHSBEnGCgmoAemTSw@mail.gmail.com>
In-Reply-To: <CAMj1kXHA64+6j2HRwxmh0Q9L2X65bWrURBHSBEnGCgmoAemTSw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Aug 2021 10:30:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARJUTZ-VDP0bTQqjCQwznWB8d+OpYUQJGOOoaQx1X0FcQ@mail.gmail.com>
Message-ID: <CAK7LNARJUTZ-VDP0bTQqjCQwznWB8d+OpYUQJGOOoaQx1X0FcQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] isystem: ship and use stdarg.h
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 3, 2021 at 4:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 1 Aug 2021 at 22:13, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Ship minimal stdarg.h (1 type, 4 macros) as <linux/stdarg.h>.
> > stdarg.h is the only userspace header commonly used in the kernel.
> >
>
> I /think/ I know why this is a good thing, but it is always better to
> spell it out.
>
> So with a better explanation in the commit log:
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>


I added your Ack because the benefit of this refactoring
is described in this:

https://lore.kernel.org/lkml/YQhY40teUJcTc5H4@localhost.localdomain/



-- 
Best Regards
Masahiro Yamada
