Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE03D59EF
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhGZMRV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 08:17:21 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhGZMRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 08:17:21 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6srB-1l0KEl43P5-018Hya; Mon, 26 Jul 2021 14:57:49 +0200
Received: by mail-wr1-f42.google.com with SMTP id h14so3014664wrx.10;
        Mon, 26 Jul 2021 05:57:48 -0700 (PDT)
X-Gm-Message-State: AOAM533lSHAA2y0GYbJqhTZ9utSPIGOkdWSj4XtxeOQJYjXgAMwkqrIx
        Lx3lvPyOuo1sdRXshuW3dPx11grubYtigpFlzG4=
X-Google-Smtp-Source: ABdhPJwCfqbh7SY1HczIHQboW40+xF1z3TRH8jhjG6PiC5glUphKKnEg3U09bKgxsDvY0zlQmQg+heF0MWWUIFL0iWs=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr468847wrq.99.1627304268605;
 Mon, 26 Jul 2021 05:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210724162429.394792-1-sven@narfation.org> <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
In-Reply-To: <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 26 Jul 2021 14:57:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MVQMFFBUzudy+yrcp4Md8mm=NcvX7YzGVz4C8W61sgQ@mail.gmail.com>
Message-ID: <CAK8P3a2MVQMFFBUzudy+yrcp4Md8mm=NcvX7YzGVz4C8W61sgQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sven Eckelmann <sven@narfation.org>, Arnd Bergmann <arnd@arndb.de>,
        b.a.t.m.a.n@lists.open-mesh.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fKJECek9OzzLHyjtdZnLzqAe/msTkAvsG4KDqe7E13ALYvUfr8S
 70Kaj2gWidd0g5LYqs3JckproBYRYL0Vr+z2eG1zqR4GEH4rH5fsFt9KMZWxqUS0a2isrcQ
 tniZyDpvsjVntX2OsegXAliet0h+LqLZ2BefyDgr55d/Iudyc7WFhNn+Ya8a3syA38/VCqZ
 JZ16U72/k9BpQrrzjIcWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q+LjeDyzOg4=:p0RW/tu0iWGTeRznCgL0gb
 TxffZtg0XV4ci5CuLweAF4L7Xepa2H1D8voJYQRGTiLIEWHCHWD9+N2wkYu+TWaGZOIsMkb8e
 f0Cd/b550lK7kjwgsvDU7h8PlBjvuiqPb5e2KJ3EL92raNrFQ6Y9c8PR8QewLbjBCH5y1+Nfp
 AZYSqeAmctPmJ7joj2eCWl7Ohh+2u74FgfLRYlUp7JpVcs+5b//tcgy2EGSshLdP+DDmPfUdV
 iMZOwaCKoFGp1WOWwG9zBVe0WU2jjhZYsf+6GCF+O7AvMGna7qr4HCWKxHR9c27WXAkfFcPN1
 2PG7mGooXWSe0REp1iBi2++JMeZlrOe8c4z/9AfEbFTnpFpliGC4kBc6fAL11EvGhPJxrcdNe
 b+LnuISsmOni3h7Hstiu+lMsMhI04Wk8V1NxaILuerwuzW/PVvD01aNpcG1LCxqLr+oqqZqmq
 bwbqiGszWT1jWez8qrP/YENKygU1+Et9XliVXBtNbPrUMXyMqFs5IH6F3OnfXwiyg6Py5+gWx
 UHsgjnZjStL28adk44TGQVIviVYi4CtdmGqPLYhLI1MWJMpyqS1Hm1m4yAIF1gXrtLz/tsWEG
 b1CLhnYOoGikhmLVQwhaFka/7ynHWg4ZN0Yl4WvHMcB5atLKCur83t5zAiB+maF7tNu9Y2GKx
 cavJAK4EUpYtnUXriOk/nrOgy/nKDwgH+Se4l8AvayR8hVwATBW20LnrZXK6mnvMoGwl2VqRE
 NMK3rbtfB6Or4KMclBBs4t32riFN4h1liZq1WcPVf2s31PQXwbeQK4z4Nrakc6xwA2zeBEPeV
 2F6xKDyZ7wG7yDP4ZwFP/lEB2Lwo8hr2p3KwW24c1kU0gQSG17qsQwSEMBXEHmYVN3H2Mg2
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 24, 2021 at 7:01 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jul 24, 2021 at 06:24:29PM +0200, Sven Eckelmann wrote:
>
> > The special attribute force must be used in such statements when the cast
> > is known to be safe to avoid these warnings.

I can see why this would warn, but I'm having trouble reproducing the
warning on linux-next.

>         How about container_of(ptr, typeof(*__pptr), x) instead of a cast?
> Would be easier to follow...

If both work equally well, I'd prefer Sven's patch since that only
expands 'type'
once, while container_of() expands it three more times. This may not make
much of a difference, but I've seen a number of cases where nested macros
can explode the preprocessed code size enough to slow down kernel compilation
over all, and it's quite possible to have get_unaligned()/put_unaligned in
the middle of that, with a complex expression passed into that.

      Arnd
