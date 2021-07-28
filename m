Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013613D8DA5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhG1MYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 08:24:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhG1MYJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 08:24:09 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1HmE-1mBShA3w54-002pFc for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021
 14:24:06 +0200
Received: by mail-wr1-f50.google.com with SMTP id n12so2314130wrr.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 05:24:06 -0700 (PDT)
X-Gm-Message-State: AOAM531SroQLpGoEhEB+COji4x8SCC3lCt+ZOXZAcWZ0iQkwIj4lvV9R
        IYDF6on8XIQZyRByLyjQMG/S1IWIxpcAlYn/zx4=
X-Google-Smtp-Source: ABdhPJy0Yfv9Ldi6wCLkEKDsV9vexeIZKTKruIBUNQH8U1CDXVmLxgWFZ56YfUZEaKIZ0mym8fMZkLRU4Ya4MliTCGc=
X-Received: by 2002:adf:f446:: with SMTP id f6mr17475923wrp.361.1627475046612;
 Wed, 28 Jul 2021 05:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-7-chenhuacai@loongson.cn> <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
 <1625665981.7hbs7yesxx.astroid@bobo.none> <YQATv/MahhrKUu8Z@hirez.programming.kicks-ass.net>
 <CAK8P3a1RduCKfRG34hf-Aia8n_2pThZ-s0D-m+qABMs2o3=bMw@mail.gmail.com> <CAAhV-H5bfYc849Z2QGkztxfPQ7V-ZkHOhS8gbqA0k3=8teTCGA@mail.gmail.com>
In-Reply-To: <CAAhV-H5bfYc849Z2QGkztxfPQ7V-ZkHOhS8gbqA0k3=8teTCGA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Jul 2021 14:23:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TG2inZ=dEsaPv3v0b0XS+s2DMAa+EAGgZ-0OX5dxmog@mail.gmail.com>
Message-ID: <CAK8P3a1TG2inZ=dEsaPv3v0b0XS+s2DMAa+EAGgZ-0OX5dxmog@mail.gmail.com>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IKy2diZFaMDIOxDo9ufQbK6OkyD8bdTYVLFsQSJqXcz2/U53oYT
 sdj4DfT4wE3nwGdeQ9HMUXO6yB8HQZqM0QaZs67Ib7LfDrxUm5hAB8sBWgUjtN6uOm2Nbz+
 ELIFdGx+fjSlR2rGsJF3i1t9Al0XHV2NRim8ZSAdq2/IfjPzBpsfwrfAo+S/eWhXSMYzXdz
 f8XUWCL9cPMZxNnhur/8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:03WfF7m1Ivw=:uDvXwTYi7K2gIgeAfG9erD
 BImW/SCJwT3HGm5eXO37+6HHfa21909ZqOGw4I6fTyQFhzjcsHWeAUJTxnLJw6aD4xWVFmwBz
 RVudMAMsMDLImKodwwktVkLNZVSvjpewi3lgb5+NbsKl3hZ73gTXMTNu0zCbpZBrJOaiXZFGb
 8Ho8OSErBuLitkt8iSJkyL85C5ldB8RdBUdPyW17M4eq3jyz95MkYTy1wJCbiHCwsScvBfMu8
 Ne2WSccyCqhCynJJKAhIfga7nkvTsDwYOPQQQZkkYkBv3A7bDzZN6WuiTNW6Hw9yw1eUp1pBY
 sHWZk0FJ1sOh7ILRs8TVHugx+/LI8THr83eGT4eMjoPAAVBXjp0MbxyNBmw1KNxsx+ZKJwjgI
 LEA4MCZ23q1IXe7Jw7LKhtaBjFmmYtXs1TK9/M7qVgSRjUepTp3VLQPAdnzsuIQMFxuvfXCDZ
 RC3HZQdFy1YCbfy2UJnpNI30K7R6yYWGLOGde82EO0qsULI+F1Vt9ss3iprWABECsl8NnG52s
 Wtvs75lmrYzmCtZUiV9ScXmAxWmvu8wPpFu56c5BSmIUlDuG+CrP+EKz8jh22fVAGs8MJTOc+
 mcok5Gzztzxh0rom8wt/XTfu5NRExaAN8fzXKqJkLKq840hXnq6HOL9meEbvlnKAAOnwAOMbl
 1cKpeFAKBc69qGJtipAxoHSOz9MqY+7ZT+BFutKIl9hrDOjySItibyjHSwapSK7YQ03ONA487
 xzc0sAzMR4bI+G87nt7PxVIGAq1YrwLbmNMqJ3teNOczyKAyOxBz7HaBG6F/U9EtGyCRfWMlN
 cWO3s7QpdiDgT3rgXuVIzAI4AXWyQhxWFSq1ryNZYbUv+Gm6WtFodrCul0fQqKLczeaJAuYS5
 HkpWRQ55s1Qe+MtVGyEkK37Kv9SN9tWAbkNE3q9gQaEt98BaDKDKwIwrSi211TLGC2kqfCULH
 TJn/GXE3PrR46bHk4XzEZpBZQdyBDjQA5n38jDjUP/3vP2W0iZjGu
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 12:16 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> Very very unfortunately, the idle instruction of LoongArch cannot
> executed with irq disabled. In other word, LoongArch should use a
> variant like r4k_wait(), not r4k_wait_irqoff().

Ok, got it. Thanks a  lot for the clarification!

       Arnd
