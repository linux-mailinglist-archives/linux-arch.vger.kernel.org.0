Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429FE377178
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEHLjy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 May 2021 07:39:54 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHLjx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 May 2021 07:39:53 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mk0e8-1lHEtG30BM-00kRTx; Sat, 08 May 2021 13:38:50 +0200
Received: by mail-wr1-f45.google.com with SMTP id d4so11774690wru.7;
        Sat, 08 May 2021 04:38:50 -0700 (PDT)
X-Gm-Message-State: AOAM530oiKh2MMZczvHPrNgu7fSD+VN8zO5/lSTjR/pBiVVMXua+ZRzY
        C/AmWmvTiLYcNz1zJIw1OVqQuDEXioGgwqqzRhU=
X-Google-Smtp-Source: ABdhPJz9Ugr0PcKykwE/hh6B427vWc6utZRdX8QIU/0Cr6kUxmxhdoRfUEI4Usf4M2X1Uz94Uu4T5nd0trDb5rVyhQE=
X-Received: by 2002:a5d:4452:: with SMTP id x18mr19275744wrr.286.1620473930435;
 Sat, 08 May 2021 04:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-7-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-7-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 8 May 2021 13:38:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3GP7Wwyes_08nRQ-ESfx2dQr2Ygdz6jpSC1754M2s82A@mail.gmail.com>
Message-ID: <CAK8P3a3GP7Wwyes_08nRQ-ESfx2dQr2Ygdz6jpSC1754M2s82A@mail.gmail.com>
Subject: Re: [RFC 06/12] asm-generic: unaligned: remove byteshift helpers
To:     linux-arch <linux-arch@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XIlD8vjJ1W0rLa4aosdkuaHT/wJ+yPvLA/7TDScMAiGnUZCyqxh
 +4KaoW2vz/TF7k2wlKZzm3p11YXDyOVX4jRAGtHWRTx8gbLBN3cegyQV6C2YZUhGysY6F7S
 R9CCRYlLsOT3MCa5bSxIlUrffruSigXnSNMBYiFF+lBocA1ukt0JFo6oDEGUgL6gHJPdDeH
 i0C7zbtIlQybllb1Z0SYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0bghlFN1rqo=:xGxxNCBXGlDvRQFCULRRjW
 rs0RgZTUzaY6c7wXv3Gwe8HCYsAMC3JIY1eGN2kTkt4DMtmSSJJ4UcZApHv0xtIhlOnknQx4Z
 NE2Hbs5vH0YI+GfqBA/cLKR1881YRlsctcsCtFbaVhJXtgjB17wo3GZE54eWgDLU8N68XWmLE
 lD8AbcvnppxzP8p3yGaNKEJ3PMNx0dTdbHHM6Zd5Y2PzI1uZNQ75jZs5TPdVYVHRj8PWNedJx
 8cmZZ3JZJTs6/yyLQbshZYXsdCvaWj+3FRyXGfHW5xQLkKMkXbCJo4cgXxx29D/1yjh9ys5xz
 n+mM+Y+fjkteLNpWFckp9N8KPiGTcHsO+CQ/NdGYl2thZwjyOzci5eZwA7THLB5W90UZZpL8S
 Vjk6stl+lpJhQHkir5iteuy8P9t5jlLnmVQahxfVS0Gx6vgmKP1riQXQP8vjwDRZo9YS85w80
 he+zGIv9cjMV19FfmdLX5MeWO3PYjQCiHOQROhZ/Z5o1/CTmozPEzlPzWTqtHAsEotg/6rtC8
 w5qOv2kWcQ6wBLseEcMyRY=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 8, 2021 at 12:11 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I've included this patch in the series because Linus asked about
> removing the byteshift version, but after trying it out, I'd
> prefer to drop this and use the byteshift version for the
> generic code as well.

Update: I've tried to create a small test case that illustrates the problem
with using the swab() based version, however all cases combinations
I tried showed either both producing identical output, or the shift
version being worse, see https://godbolt.org/z/bTdsjnjfT

I'll rewrite the patch description accordingly and leave this in place.

       Arnd
