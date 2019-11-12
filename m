Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40BF89FE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 08:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfKLHy3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 02:54:29 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28678 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLHy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 02:54:29 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xAC7sPes011602;
        Tue, 12 Nov 2019 16:54:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xAC7sPes011602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573545266;
        bh=iDlxySlUV7nX35FxWeaHPxszgWMmXPkxQCXH4II5Xks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OrtZ1ZiTSUHAM8xy/JWHwVZ3pfUKQ1YdN2cp5V5uIAxHs3MYm2PzitqVLM2quNM1d
         YfaSGbnZitYk/k44cwV4QUJMhh807fFsufGR439BlR4TpTjNXvnwfzqnc7SsDaGwss
         1kAmV9P8d1O6SkbpQnzST1EZn6oaLocyL2mEWfYci0t4lbOpLbIZpNYIuN+r7vpy2p
         iCg9sHdDbWfPnor4IgzDyogBvyKYiuLlMbgIU+1YuvnrBidyHX/G/r43NO6vLX1jg2
         qSfNlOKzhb9pTR3bGuVB2rcVqC939AsP2Wb9nvmg3sAllgHmNzQRgnm691i62MrHSQ
         swlIsfvGzJI9A==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id b184so10189067vsc.5;
        Mon, 11 Nov 2019 23:54:26 -0800 (PST)
X-Gm-Message-State: APjAAAWNLmn+u3aLxj1a6tsHn4qISk6HLqUmRRL9uUdLQ176JAKQAc08
        VvlMqoK9MHbCaLQq5Bufx7k6c0YtJW3DtVsc2vo=
X-Google-Smtp-Source: APXvYqwS2w0GOOpBycu4itKhNzVpeZeulJ8dLt/RDqVQnSDtqVcybYmRkOT9L1gMkoicnYz6g0a5eywUq/jz6i4s7Co=
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr21763759vsf.181.1573545265218;
 Mon, 11 Nov 2019 23:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20191108124133.31751-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191108124133.31751-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Nov 2019 16:53:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNART2bL8C4yW5+-mP0aG=Depm3mrfLzKnhQuu3hnNSzTWA@mail.gmail.com>
Message-ID: <CAK7LNART2bL8C4yW5+-mP0aG=Depm3mrfLzKnhQuu3hnNSzTWA@mail.gmail.com>
Subject: Re: [PATCH] mm: fixmap: convert __set_fixmap_offset() to an inline function
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On Fri, Nov 8, 2019 at 9:42 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I just stopped by the ugly variable name, ________addr.
> (8 underscores!)
>
> If this is just a matter of casting to (unsigned long), this variable
> is unneeded since you can do like this:
>
> ({                                                                      \
>         __set_fixmap(idx, phys, flags);                                 \
>         (unsigned long)(fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1))); \
> })
>
> However, I'd rather like to change it to an inline function since it
> is more readable, and the parameter types are clearer.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Unfortunately, this patch broke building ppc, mips, etc.
(Not all arch implement __set_fixmap)

Could you drop it from your tree?

Thanks.


-- 
Best Regards
Masahiro Yamada
