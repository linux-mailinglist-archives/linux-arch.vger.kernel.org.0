Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60A0410B03
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhISKAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 06:00:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhISKAm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 06:00:42 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqatE-1nETsx2yie-00md1Y; Sun, 19 Sep 2021 11:59:15 +0200
Received: by mail-wm1-f51.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso9982029wme.0;
        Sun, 19 Sep 2021 02:59:15 -0700 (PDT)
X-Gm-Message-State: AOAM533g+/02eU1o8+gb4tNdwD8H+eKMXk/Y2iZLPcR+gcrqFJopemw2
        SiChCP+gb2R8rGmhneNkkdp5Z/1dnLawqOaj0ow=
X-Google-Smtp-Source: ABdhPJxsiYpMBTO/1b42xob7UzIfMzCj3uxlTG5GOgHmI4N1kFt2G98bvOPQDObG3ehhWKsZ603sNzoyOe6YsUGyCWE=
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr24216482wmf.82.1632045555252;
 Sun, 19 Sep 2021 02:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-15-chenhuacai@loongson.cn> <87tuii52o2.fsf@disp2133> <CAAhV-H5MZ9uYyEnVoHXBXkrux1HdcPsKQ66zvB2oeMfq_AP7_A@mail.gmail.com>
In-Reply-To: <CAAhV-H5MZ9uYyEnVoHXBXkrux1HdcPsKQ66zvB2oeMfq_AP7_A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 19 Sep 2021 11:58:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0xghZKNBWbZ-qUWQVKyus4xqJMhSV_baQO7zKDoTtGQg@mail.gmail.com>
Message-ID: <CAK8P3a0xghZKNBWbZ-qUWQVKyus4xqJMhSV_baQO7zKDoTtGQg@mail.gmail.com>
Subject: Re: [PATCH V3 14/22] LoongArch: Add signal handling support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:M4QGaLW8sGv+N9ZkG7UZScaavewX/4WPGr5MLrAfJ/9mLxZlhvP
 /qLs60mD2YPTJGM0PPMme9qZ1i8t97oT8Z3bguvoG3nA4vXDleImDCuZsTwAZHiJEpaswbm
 6fCvyoGbHqCr1fCb+iOyiw3sG/i62VJiGGfjSJbRa9o2zSgCeyVAKCMpFP2u8GbyKOEUXZt
 WVY/7ZHKhwqxZ5/S1s38w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UdY+7XsgiCY=:9nblT3GytNvc6W8RBaQgSX
 KAiz9+1nOU5HIoutns4ursP8ZjHftD2nWm+wEMCJhphdSMW+0W7tcweJ3dL4mPGH5Kfl8ciDe
 VXTeEAdPvLV9X+xtMAwF1hwxs/9cbqNiZeethLCpbfqziR2um3lvVHHlzC3nTQ6aSu/ScVvvb
 AFWyv74mzzTWVKCiURdq8xEX4m7nX5mS+I3ykiXWQTujTfrL70UPwGDoKMuOBSax1jzmBckth
 LwflU6KY6CoSSaJn7a4Lrf4BIDt4nLEP8+GU018t5kUhCtPYSTir7Nw5srTfpTUpdh7eH4y3Y
 HaWkyomq57rcmQTHuKnQA7pJgIaXCkisN5lFaex4P0rZg+fo5kQRcwysIf+kRVY3CAKMDQX4J
 3sRAUd7+oCqLILj6KtqkSrPaJvgLBb999dD1Nawpuu2DXpHTHKQ/zr2xm7kIZB62l8Qs7YgPH
 Rls4kkxrXVXHETxOTz7+cTaaLDU2JV/GLXcAyiIPBuVLgTcsFhINFBVmASom0DzIxTPylrnzN
 yDoKIxpERHzn97ojBQ5I9oIlypWt5oPT+xa6qzDO5AEEIeMTrFq+5pMG3ywTIg2M9eZwala3M
 6NzGfdJUeoiANjQF8hYRT0Lrrlln+9vduF7LGTZvXeNSS75dsiAdJjxtSEIz++YgAnWRI9TOF
 UBQI20yDKkpyv12SUI0yFAr6M8bST0Ia7tsI+k9bMPThwYrGfVKm7cJoyfmObK9/Qk7pHpHmy
 90STlJgvQvDEKUlVQOZdGjBlUJcaC9x6LiNwtkaidp6ejfqLJB9XjPU9LUueG/e/q6L99+Z+S
 a+muqJJxJVmOlIV27/3I+oCw9MHVX1DEAuTHPG95HUnsrop3VDhnMxu3gdcRU3Jz9ZOJSWNkc
 TdBXB3V7g7c7RrraGuhw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 18, 2021 at 9:12 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Sat, Sep 18, 2021 at 5:10 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > For example does LoongArch have a version without built in floating
> > point support?
>
> Some of these structures seems need rethinking, But we really have
> LoongArch-based MCUs now (no FP, no SMP, and even no MMU).

NOMMU Linux is kind-of on the way out as interest is fading, so I hope you
don't plan on supporting this in the future.

Do you expect to see future products with MMU but no FP or no SMP?

        Arnd
