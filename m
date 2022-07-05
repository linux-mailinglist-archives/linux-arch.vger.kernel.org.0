Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD25673C3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiGEQDG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGEQDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 12:03:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E721839A;
        Tue,  5 Jul 2022 09:03:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lw20so22462065ejb.4;
        Tue, 05 Jul 2022 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PzUf+FWtruBA74xPia/zJ0RuCFti96ThSU9HTzIsqY=;
        b=XluqUvEc2FFAEeUVR9EHhmnZ4fduhRT7w/m9u0J2BO7tZOwSBo7mn8BaOQgqzoSDjh
         X0pO9Rj7sIcvIuoe/ROCFriYf+jU1vOTUfqvfCtN125Ylu3zQgqKqEbKSpZrITIomEan
         BZAau+BMtL5HOpzppw5a+e3jGUrgHgPPfbGc5bsU3OpFMoGuJuoBj847iLPHKCzZpauf
         jf+2378y/+37186yQm4a00uEwBFAvMwZm17YIt+qATt8ZYGJLJ4pWsc0U3fKbmLSOXLk
         5+3oyqmZyrGCj6g5F5sm3U2otbom9tA/Hnz9GFjdlZ5PnMVgvCa13m+Igy3HH86a48ZB
         o7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PzUf+FWtruBA74xPia/zJ0RuCFti96ThSU9HTzIsqY=;
        b=DdvilV/O8btxcG22IQrFkpZXndg76aZS1DxrHUOQz5yLhLas05SQjsyJD6Jedz6F1g
         OtUnymw0f+e39RpgJsk42xVFN9iS1odhhbo+dH1I3IyYiGm8OjEb0xsNI1iR5ms+xL5o
         oEDLyfiztSrr528qwANDg0sEkrU8DYPHIP381AYISiFK6Qh/r9DavbueywtbYZ/UzuZe
         2piydJZMsGBbjjh0c+1FKC/thEYvWbZ8Qc0vZ7SPss9jkgBpySNHMJwJnAuvKSB2VZNb
         ng/otydBW7kzdegmGYExFzjEh8DeYsq/8XN08wP++1wTpxbhGuKRDk5iyYWH9Z6sPQdU
         2AYg==
X-Gm-Message-State: AJIora+R1CULmGpXCTQjGE6KigdiCazBWoouH6s8nHp6Zmk56FlLPWcO
        5XPpC96AU0aTPXl/FtZJpEjvGCjhLfprb1/Xeak=
X-Google-Smtp-Source: AGRyM1s2bR2/fTLYxh4UjqmPZv6LUB0HejEOyCZJAkhG5FfXs1uf2EFDs1t2xo1dxtAeQiITYADdpH1zQ6Q1UVRLsF0=
X-Received: by 2002:a17:907:2d8c:b0:726:2b37:6d44 with SMTP id
 gt12-20020a1709072d8c00b007262b376d44mr34529009ejc.224.1657036982875; Tue, 05
 Jul 2022 09:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220705154708.181258-1-rppt@kernel.org> <20220705154708.181258-15-rppt@kernel.org>
In-Reply-To: <20220705154708.181258-15-rppt@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 5 Jul 2022 09:03:01 -0700
Message-ID: <CAMo8Bf+5cN4TYNGs=PXsZuunyZX2xQAdk+nGd5wARP8MuZVXuA@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] xtensa: drop definition of PGD_ORDER
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 5, 2022 at 8:48 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> This is the order of the page table allocation, not the order of a PGD.
> Since its always hardwired to 0, simply drop it.

it's

>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/xtensa/include/asm/pgalloc.h | 2 +-
>  arch/xtensa/include/asm/pgtable.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
> index eeb2de3a89e5..7fc0f9126dd3 100644
> --- a/arch/xtensa/include/asm/pgalloc.h
> +++ b/arch/xtensa/include/asm/pgalloc.h

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
