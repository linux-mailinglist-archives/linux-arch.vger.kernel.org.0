Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5D47BCB2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 10:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhLUJRp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 04:17:45 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbhLUJRp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2021 04:17:45 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MpTpc-1mgmBH2Ywu-00prv9; Tue, 21 Dec 2021 10:17:43 +0100
Received: by mail-wr1-f49.google.com with SMTP id v7so18221107wrv.12;
        Tue, 21 Dec 2021 01:17:43 -0800 (PST)
X-Gm-Message-State: AOAM532cLczbJqgvgXFFTh0sy4wUIyQzFBKtlI+h0FFCk+/I1J9ekMJO
        FOdEfS7IRdrPYL/DVgbvtgCgF/TfKojn4LSJCjk=
X-Google-Smtp-Source: ABdhPJzSg/DkO5oE3IpvcWojgUNLOt2TpzC+WZUyEhNexs7m69kqA5tNkN9T2lwEeM1LC0W2EFxg+0+V0IHyS9nfo1w=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr1803113wru.12.1640078263218;
 Tue, 21 Dec 2021 01:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20211221035556.60346-1-wangxiongfeng2@huawei.com>
In-Reply-To: <20211221035556.60346-1-wangxiongfeng2@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 10:17:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fBdh2kPDo8UGHBD0MhF5k_DoomqUaW+=ZOgksKmGg5A@mail.gmail.com>
Message-ID: <CAK8P3a2fBdh2kPDo8UGHBD0MhF5k_DoomqUaW+=ZOgksKmGg5A@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: introduce io_stop_wc() and add
 implementation for ARM64
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5MHFck5vnwG8jhfhBH+Q7Xxq+xcPqesO01jOoFKMDNvEqNKBcYU
 x2t82qOX8py4EBFyHHdxUwhqEXVGQOMiOWizlaM3WF/R08gxaE+b9Y0FhaL6XupE1Pdn5he
 D9Y3lxhWmARelPWJFK37XVZPKfsRkJAxSecbAzjk9LlIGVzdnPyh+6obynUjK0I0Jabdq6C
 5wtnaVzbInaaGVskZLsxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MBdxIucVV0U=:ykaQsqWYHGiIqkqflWph+c
 wRm1TVXsyTLIBkdQrgrQA+qmK+wJP/e6OSnHD8T82MuINe8fWj2z4rx1GAblxKkoD9BUaCEsX
 US43uepTHMM3k1Yh560Pe6QbMgEixTT5ATa+/Ek1tnC7nuVze8Pd/TFU1eJl8Ker3gV07pv6X
 k7vPTooiUwe6TvfV0bIQc72MygY9SdmIfCdJrZHT0Ou9Oba7XHuIeriXsl/POSlEMczvi7gKS
 5F0K6UyyNvMwok61hKsmIj2IrycFTg/Qq/Jf4DCbhpSD4ZmVLJc5Sg5uQ1qLbc8lTSladUijS
 VhmFYXP61k5+VvSkMw9pIhLSaWzGM9qPP9PNnZKZKx/ipdgLcCSNXS8TJYdCLOxFyC5CmKGZa
 qMUZLToAIHLp6Jpb2nrseiyvsb7Koz6JeuBmkt7cZNMotX7i8FAVHlZDVrdqdl+wvSMQN8xCj
 m0rX2qSrZdKV+jNNpS4nC6YV/uG85Y/1IPuKYKT3BPy9xOfQ7e5W19GWTBG5OPXfj0jYeyGd3
 CpsnOG6CawLLdu0Fx0zwCxMMOS34VdmS7IdJP6o934bajUKFvXVhu0KyFTiTUm07fBt6nR/5V
 6vm9BwBK4F0ARpch7GCj1V5fFIU+yuXyMLtPBOyUCLh/XXiHEsGRIZYB8TybOqlLezUdDEY2m
 e8nP81hqWPCJCu+tMTGTdxRyZvg6Ek12+LQsMbIPkQgMTJFjX/KGjjkts8jzXhxPAewo03YLy
 6aaI+spTL4ZfDin1TTf6MF3x/iTajdXN77GejJtOFc4e1Hom+gZoECbsUHtn+gW8L7nEbIkSu
 A9dhru8C4vgS8GObEOAIn5/COOguszlyXsdmVVuwt1AqmuoHTw=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 21, 2021 at 4:55 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> For memory accesses with write-combining attributes (e.g. those returned
> by ioremap_wc()), the CPU may wait for prior accesses to be merged with
> subsequent ones. But in some situation, such wait is bad for the
> performance.
>
> We introduce io_stop_wc() to prevent the merging of write-combining
> memory accesses before this macro with those after it.
>
> We add implementation for ARM64 using DGH instruction and provide NOP
> implementation for other architectures.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Suggested-by: Will Deacon <will@kernel.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> v1->v2: change 'Normal-Non Cacheable' to 'write-combining'

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Will, Catalin: if you are happy with this version, please merge it through the
arm64 tree.
