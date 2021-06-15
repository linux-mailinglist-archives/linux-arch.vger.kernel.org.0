Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59713A8620
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFOQOs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 12:14:48 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:37863 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFOQOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 12:14:47 -0400
Received: by mail-yb1-f178.google.com with SMTP id b13so21314600ybk.4;
        Tue, 15 Jun 2021 09:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Wv7CHWzkockHzF8pGG/3fcdtGeJKMuare4U3i4RVgA=;
        b=UCGRMHje62eyMwKro/B+MJhQjmxxSp5Rm821t9QFKYUhWbT59WOvtDVarRAatvjTXk
         1icJkJmsz9XvlX3b3KYN//zZe1N/i9eDq2rYTpiAiVxcn9ebv2Z3cb2lYUgHpXPvxxMU
         Gw+98wBkXd75EW0ZXXoUypN8rWtKWZVse+jwyRGden7n1dveo1He/FMSsfwy+LQCOZrL
         jWw3BgXAEAXMv5ZCiOk+rw50ZeRChid4u6sRh4t7Azl43Vx0psK+7b2mvrbO7ECGAB5p
         H2mMJs2LwEsJoY8ID9kXQVUuI3NWrzPwp2k50lbPJP/GD1Yakogr9AZQPWMZVdmQuomh
         BptQ==
X-Gm-Message-State: AOAM530oei9rFdjuELizIlJ6B9kYnkxHDM8UT5xWcU1DOjpztr6YfWPb
        BXU1jt/f/VyZT/xHNZNihuK265q29Kmo/wCWSyw=
X-Google-Smtp-Source: ABdhPJzem0nOOYC0h+0gvK/9pLOrRYLo1iiurmeFo4Dna/ffTj8redI7Hw0vk+bc5/9Buy9+CHwRZcgMNeRx5wRB8ac=
X-Received: by 2002:a5b:d11:: with SMTP id y17mr33994254ybp.18.1623773562254;
 Tue, 15 Jun 2021 09:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
 <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
 <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com> <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
In-Reply-To: <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 15 Jun 2021 18:12:31 +0200
Message-ID: <CANBLGcxi2mEA5MnV-RL2zFpB2T+OytiHyOLKjOrMXgmAh=fHAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Gary Guo <gary@garyguo.net>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 15 Jun 2021 at 15:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> ...
> Yes, Gary Guo sent one patch long time ago against the broken assembly
> version, but that patch was still not applied as of today.
> https://patchwork.kernel.org/project/linux-riscv/patch/20210216225555.4976-1-gary@garyguo.net/
>
> I suggest Matteo re-test using Gary's version.

That's a good idea, but if you read the replies to Gary's original patch
https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/
.. both Gary, Palmer and David would rather like a C-based version.
This is one attempt at providing that.

> > I'm surprised IP_NET_ALIGN isn't set to 2 to try to
> > avoid all these misaligned copies in the network stack.
> > Although avoiding 8n+4 aligned data is rather harder.
> >
> > Misaligned copies are just best avoided - really even on x86.
> > The 'real fun' is when the access crosses TLB boundaries.
>
> Regards,
> Bin
