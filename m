Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BEB52741A
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiENUzN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiENUzN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 16:55:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1D403DB;
        Sat, 14 May 2022 13:55:10 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MZCOl-1oL8aj1fSD-00V5zn; Sat, 14 May 2022 22:55:08 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2fb965b34easo120183737b3.1;
        Sat, 14 May 2022 13:55:08 -0700 (PDT)
X-Gm-Message-State: AOAM530C4aEcGR9rEbOUJJhmVsVLUXfab0msFJB2+Am9qS2xQPDsnrGo
        3AAkZulzSV3nll1YZciRxigy1lgCZRA9viLUH9o=
X-Google-Smtp-Source: ABdhPJzpLGyXsVrNJlvP7WL6o5iccD8hLd/+gg4Ia1m634qB7o2qs/9CBGsnf3lGCXzpz3Yzv4xbyGW7DIkrBKCLkYg=
X-Received: by 2002:a81:456:0:b0:2fe:dee5:fbbc with SMTP id
 83-20020a810456000000b002fedee5fbbcmr1569021ywe.249.1652561707006; Sat, 14
 May 2022 13:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
In-Reply-To: <20220514080402.2650181-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 14 May 2022 22:54:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Xu79zzJ=c3WJJEXAmcL2RT6NBZy-dd7s-Kz3Yk4yJzw@mail.gmail.com>
Message-ID: <CAK8P3a2Xu79zzJ=c3WJJEXAmcL2RT6NBZy-dd7s-Kz3Yk4yJzw@mail.gmail.com>
Subject: Re: [PATCH V10 00/22] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RLYdBQMRfs0VRj5YvnHzqR4SnCvb0gHg6NTSCuHKS9abTBY9hIR
 58Uou5At376gsaqKdwPLbXCruy8o3YAznEIwam+m4xLDQ0YZuPborKftLL+rOEbZlwmqFoD
 LrWsqauIcg9QWP4OZi/9PagjESYz9ttVTG2O9YrVrYmdieN087fAyBBtLGnIJ4IJN354TdG
 XUChB7hhKme9GFNBQWbzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x5w9uFk6R6Y=:pBWg+zbZvsCoPRzXDDv9ZI
 4E/87Pq6on7G0qjNejfd+N4bmWxGAqylE2uCD13SfV+MHRUroa14oujr3P72qaGHC9/O4PDir
 UMbE9tNqsOiSBwkFFL2oTHYTpixbf2UThwjHR0UFLClGZ+PXg+SezzABTtW/08wzNYhmZccgo
 BprPq+EdMN48KQ75z1UOYXa3JyyuQ1RKMBc57CNGWAmNFNi8P8T5Rj8/VEtG4CciKQglDaxTG
 yV8wUc5gDNC1Q19GP3D2my8SbgGWtd4yjhGV2TPmUQG5CCnW38uR9MhT05fadlsdgsT6ak+El
 DZIyC4nM5W4dHbALWvSiuy7yKmGOlyU8hEXe7fwpv0Tksd4h8KJGdhEeRkyjSVKjxte2puwhc
 sgCebLD/ze/vV7Ypt53sLoFnazLOdGOgXjk41rgRZ5iRuwNVdq7BA49GdWHABSXtXVtglFdo9
 FRcj82xsQsD8/xf45XT+vWreF0OSv7/wqPo7pAvntZ7WoJ4IhsD4h52qwkISknNCg/nbrSu0U
 SZahSILzY5P1tHCxz7+6XKxlaeijBJjSUiMIjcC1viqno1tCPA7gP+6RXenCpzYkbRPjUHE+1
 ZgJd3a5V3ts5wqG0LJjzABD9yxYKMPjOBouAA6ZrrgLzqPI8rdiwA+1VSAtnnzcTPug8i8PJn
 7a6P2qRj9RjVzGRTDh2AGuVBS12bYLJo6xxHuqrMv856xrbUydJ63+Wc/rqO04mzQWmyQVbc4
 7BIz/GhpFZmysUeL3HH3vNHGLiSK+A8P813mxILRnOyDNVwO3+FuXQiSZ8sbc7oU958OAbhGM
 m3GKZZo5lJwxufH+5wsRAPAtQ7VcO9IMy//TfYib2nXocWIOiPa4deYyIjNFh8A0sm3Cn5r+W
 aID1LsnKSlp7HhuCV8lg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 14, 2022 at 10:03 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> Cross-compile tool chain to build kernel:
> https://github.com/loongson/build-tools/releases/download/2021.12.21/loongarch64-clfs-2022-03-03-cross-tools-gcc-glibc.tar.xz

I also uploaded a clean build of gcc-12.1 with loongarch64 in the
https://mirrors.edge.kernel.org/pub/tools/crosstool/ builds.
I have not tried it yet.

> This patchset is adding basic LoongArch support in mainline kernel, we
> can see a complete snapshot here:
> https://github.com/loongson/linux/tree/loongarch-next

Note: I have pulled in the generic ticket lock series into the asm-generic tree.
Please rebase your series on top of
git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux
generic-ticket-spinlocks-v6
to avoid duplicating the commits. As long as you are based on top of the
9282d0996936 commit, that should be fine.

> V9 -> V10:
> 1, Rebased on 5.18-rc6;
> 2, Use generic efi stub;
> 3, Use generic string library;
> 4, Use generic ticket spinlock;
> 5, Use more meaningful macro naming;
> 6, Remove the zboot patch;
> 7, Fix commit message and documentations;
> 8, Some other minor fixes and improvements.

I think with this you have addressed the comments that I had in the past.
Xuerui Wang and some others had additional comments that of course
need to be addressed, but this is looking good to me.

       Arnd
