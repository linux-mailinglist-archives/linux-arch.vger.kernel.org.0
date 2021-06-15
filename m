Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3F3A7EB2
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFONLI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFONLH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:11:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62425C061574;
        Tue, 15 Jun 2021 06:09:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id q21so20368942ybg.8;
        Tue, 15 Jun 2021 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMoUsP+kTPDRNp3NldXN+6OEKu9qLojvf+qqhyJ9SvI=;
        b=e2K8Av2mPhp/Qeq3KR/ThAvnqvDFvMbejy/3Ex/owuKzje5Y+wwd9CsaR90l/bXbGJ
         kdqtd2J+YMSQ7wycS5aBVY2UliD5oBSunimr+X4dkG+Wx53oya8zvYk/d+2LuKuQDMHk
         1divJo+iYnTBNUHIiP1bujE5Wnvj29JmhoW9yQHCmXGmP5S/EtgnVlm/hdHNUvl5CCST
         SO6xRhB2a2ceKa+8RF02NdHUVs0chn4sbbnG5SNX/cx5vhyW7g2Xm5YGzh8d46vMFZVd
         vrEDf4jcScYNQ04YJugroFYx+OxQz1Fne/K6s0JaL2BG2N87f3YGPkDYEwn0X1Sv5DUI
         7Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMoUsP+kTPDRNp3NldXN+6OEKu9qLojvf+qqhyJ9SvI=;
        b=udUpgEp+CfNSlFBgpZJZ3kiBBVrvU5OudBXBfhYHNPaJNwZnq0KGmNYeT4ru+s4DOJ
         Wvb0ZJLoXAj3BjfR0ZGEv6/mMZqzIYUdDXaKcLf4c3qKbYhnP/Z1h9KimEoHcrH0vsOy
         D7y330k8t3SjMMTCzOej2inB35m+gkALbWbAS0U/GikSg3hF2o4X1Emrj8EaCjmOD+3g
         IZQy64LGTq0nt+MQiSilInly4mgekY6PbNwlZ1TRA9fOVKBDSI3G+4MNk7Rz3vAN+i9O
         mV/JdXbr8JzeeEoxT94sv+5dn4T0VnDGIN0G8PR7WGpg5Oa9hMfCdtadd6/5fcF17CmU
         SA0Q==
X-Gm-Message-State: AOAM532GmibZCod/NbPB6gSHRBx8j2nDLBiHWlpQNkGKGSd54GBeEzV8
        b0x4FmfTZV67fZ/IfpnzzdqMKhPhuKmln8M/KqVUrAyI
X-Google-Smtp-Source: ABdhPJzqnqyJZ1wDf7Pt24OTXE9VQutGzT6s5BF+/eUK7LCanbzAlwyIlJMFKWxTx4KlYzWXOWf4uy5yzQIhIDzKAys=
X-Received: by 2002:a25:2e43:: with SMTP id b3mr31849821ybn.152.1623762541678;
 Tue, 15 Jun 2021 06:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
In-Reply-To: <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 15 Jun 2021 21:08:50 +0800
Message-ID: <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     David Laight <David.Laight@aculab.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 4:57 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Matteo Croce
> > Sent: 15 June 2021 03:38
> >
> > Write a C version of memcpy() which uses the biggest data size allowed,
> > without generating unaligned accesses.
>
> I'm surprised that the C loop:
>
> > +             for (; count >= bytes_long; count -= bytes_long)
> > +                     *d.ulong++ = *s.ulong++;
>
> ends up being faster than the ASM 'read lots' - 'write lots' loop.

I believe that's because the assembly version has some unaligned
access cases, which end up being trap-n-emulated in the OpenSBI
firmware, and that is a big overhead.

>
> Especially since there was an earlier patch to convert
> copy_to/from_user() to use the ASM 'read lots' - 'write lots' loop
> instead of a tight single register copy loop.
>
> I'd also guess that the performance needs to be measured on
> different classes of riscv cpu.
>
> A simple cpu will behave differently to one that can execute
> multiple instructions per clock.
> Any form of 'out of order' execution also changes things.
> The other big change is whether the cpu can to a memory
> read and write in the same clock.
>
> I'd guess that riscv exist with some/all of those features.

Regards,
Bin
