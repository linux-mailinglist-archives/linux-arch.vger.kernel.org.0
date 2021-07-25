Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760023D4D0C
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhGYJ2e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 25 Jul 2021 05:28:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhGYJ2e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 05:28:34 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mrggc-1lKBsR3Gtw-00nkfb for <linux-arch@vger.kernel.org>; Sun, 25 Jul
 2021 12:09:03 +0200
Received: by mail-wm1-f42.google.com with SMTP id 9-20020a05600c26c9b02901e44e9caa2aso4334895wmv.4
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 03:09:03 -0700 (PDT)
X-Gm-Message-State: AOAM532XNr6XG35ebqncDGSWTpdYb6fN0warEt8faWJUDIEz5o4zZUpd
        /SbpzLbWSw2b9ganahiUe7MfRL/pu1NAhsHTQ30=
X-Google-Smtp-Source: ABdhPJwKkuq9IyT9ix9adMAIBJvApSkY0aVFSbpXN2wXNtPNLvh2TJXlAkOVna8U7GvDUui15zMpNgHsagBC8nPgQNU=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr22048881wmb.142.1627207743442;
 Sun, 25 Jul 2021 03:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAK8P3a0ZabB0cBR_SnOhi2=qxdQOYPGPEJeOqV0em1+bsvZKWw@mail.gmail.com> <ec727497-7fe9-a52c-3063-ccd0459159fe@flygoat.com>
In-Reply-To: <ec727497-7fe9-a52c-3063-ccd0459159fe@flygoat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Jul 2021 12:08:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15Naj5R6nti-s0R-NRoB3SB_kMpix-ymjjrFhRghpAGw@mail.gmail.com>
Message-ID: <CAK8P3a15Naj5R6nti-s0R-NRoB3SB_kMpix-ymjjrFhRghpAGw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:eHQMSulQF/NycijIbi7tjP/4EhnMZ+PawpSqQvXIh5Z3Olnkzg0
 1ffiMLo6uoDGUBXfhbgWzMq8HMRjhVlSzkpI/NVv0Q+wnFEGbySFROdmhOXYCi8oq7Kz834
 oryovAT0Gprdq3vnVa5YmycjdHZ6KQt8uvfW8VxKQochzeyb8iYgoYFb5zqimRp3AN5ZSh/
 v2O0Qs42y614bTNDCRgww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1ycOAy8bU0=:hJd4UqfYzXINxCHJo8J4AH
 k6DY+Till4MvQXz0YRZpW9KzIGTO2u0yR9TMIG5//x2lQ8sOnrxkLj9jY0YuqRqgdWkW+wBqV
 pVEybVJisU94iLlRlbHhtlXsA+XAwU3IBzTuGGX1CnQ0obRNDrcg+RM6EQD7xttvOsPq3DRnm
 0sgX1OD7TzZba8prouh3IS2ImTVmH8NJeFW+cXTq2lWSA+OU0Rx15WQS1K/8QVRuA/pBN+Sim
 1XE14906/JL+XjcbqqZ7HkoaY3N9hVm4xgvKBzaEqHblSXJiCa7cat+6g/DxkkNId09syugIA
 vgDCbqRsmpWJqF60ROr7KIdfthPcOMckTblBf8YFms7ra5w7Bn2XWfXZg9qCObfHAEsM9ZCY9
 ZuGmK2otYwBICxzLJiDUNTLziI6be0TxoXEsk1btMsO4AVRSVHzb33JM8Nry9C4ZEzfAdWy/T
 oO9F2OMXtQhLnAv7WtZGhJ6Sgck4wCxoJkVFZiUe5rJ1NWfZdxnWc2efw++FkPrjvmjsjppd7
 ZFE9RqtwHZtfifZ4Wcpb4ZsyedBulN+k+rhRWFDrFu+X4546EKNUTue3XhtWBI3LAsXDgm/5P
 cgJ5bskasKjio2+57B65s3CPmSgvZ9AP0MpbQmv1xnYberAvt1GIkfW1cAIDtD09glPsSiMPX
 i4X+R0zqeHjM4gmBoGS0/x5Vh5JK9y9kEgFedZFhMUWePM1GwoiZMe1Flv5X9owJy5Zd+fGoO
 6+oofjs8jIhBqpiFC2mXo13LHuAY74I5PCXK15hvfbNb7Cq8Jrujr+ma0TNy2K5zIGY9BkF1x
 dM9R1EQSw8s7Pcpxwo2rNODtEhVpvcHn6+Z0WljCNdUGyCsV8FVe7VvxfJSZ07pZpymdbv7T+
 qMIPDAnJkEE1gOOBQZ3sVQzO/PE1XE5P+5EmlVZcGq+qpMTegg7oH8wXWffI6gTZJIU1pz+IH
 fjh0K+vj/I7YnAuWX7QhVNoTQMOup7LXujw2ZUbe5TcrJ9mkWgBLa
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 25, 2021 at 5:06 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在 2021/7/25 上午3:24, Arnd Bergmann 写道:
> > - If I remember correctly, there were some concerns about whether using
> >    this information for picking the qspinlock implementation is a good idea.
> We've checked previous attempt made by Guo Ren about
> ARCH_USE_QUEUED_SPINLOCKS_XCHG32[1], the concerns of potential livelock
> do exist.
>
> So in this patch Huacai took another, dropping the whole standalone
> tailing logic to remove the usage of sub-word xchg. It could be understood as
> partial revert of 69f9cae9 ("locking/qspinlock: Optimize for smaller NR_CPUS")
> [2] on these architectures.

Ok, I see. Let's see what Peter thinks about it.

        Arnd
