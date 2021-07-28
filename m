Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E763D8C12
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhG1KlM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhG1KlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 06:41:11 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89561C061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 03:41:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r18so2448526iot.4
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+NgCmBU6kJvzpP1rKQiBcGQxks7MZw3KVXSzh/evjc=;
        b=lhvg8KrhPQS/qUlOd6+DGWZAIeLrgFRaLneNsvlOkWs9Q8EnrOG9sVf35wS5u/K20R
         bO1Q97bJFTyPQQnutPI6G3B3yZMiXZyn/jFVbpRA3k2kgJAyoUcVWSH76TQtG7qMfU3W
         P4c26qDJi+4GGGUBmrmQUg24CyNN73ZTvbOPmLI/GelRTWd//lh14EaeHg65mioioaQd
         Z15X4okpKpnJru3pP5+67wQkCWXCyjd7EWcmcErmogxmzIv/82GjMQe/qvN99OxxR7yx
         ICTlT6iPUmLE4TJnA86IxA+l5rGjQZXMUGXu0KiYFJPZ19EehVJSpC9IBS8ZILj/vYFx
         i1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+NgCmBU6kJvzpP1rKQiBcGQxks7MZw3KVXSzh/evjc=;
        b=B3ghd6ctJen+Q4+nQO6eSODNEuhBwtebDDZVE0wyBCtlb4U9oICMi2tcq1OiamfM/C
         EbHrYMS5gz8lzRCdr5P1yKDgd2KVjji5ZPiu4Gw9y+jRQfrIfGZbcctMThyAbN0FFyPn
         4/jxwcW+FM3vahedTXGMR40+e3PRqx/HLgwPOujhoIXzcNayB7e92Qi7VWW/2t8PCH+f
         CaxrwN3twSYgTUq00/VwZAtiy6AeoaqR+tfIL2q+gno1YvARclQb1AW2IinfoEppQf5q
         TtITuo5oT5NwRwS3HGmRjxylVyBu5CHtHBIeU/Pbx1hnCgG+9h3NNsAWiWerjql4BGOa
         dehw==
X-Gm-Message-State: AOAM533bpum+siIQNT7phZwoilC+sfIT1NknBWwVOmCs4cOKJXg9E4Dr
        +O7F1JSeBGupSNxYrr6oJT6Css0+u+3SMMWaWz3sDPBZVlg=
X-Google-Smtp-Source: ABdhPJyxjFCLGZiEWi7NVqc0mmXi/VunOob5B7JG7W8rM6zKvIBRYEghGiScbE8iRumoly2Nm0mXLvgr8ewHQHwwPRw=
X-Received: by 2002:a05:6602:48c:: with SMTP id y12mr19298491iov.14.1627468869033;
 Wed, 28 Jul 2021 03:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux> <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux> <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
 <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
 <YP9vp8/acj9TpwyZ@boqun-archlinux> <YP/oYc1A39bMS87H@hirez.programming.kicks-ass.net>
In-Reply-To: <YP/oYc1A39bMS87H@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 28 Jul 2021 18:40:54 +0800
Message-ID: <CAAhV-H7Jnoa3AOTjG_=+WvxkcjqDxYVU4jAudjnu8WMtAVyPCw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Waiman Long <llong@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Tue, Jul 27, 2021 at 7:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 27, 2021 at 10:29:59AM +0800, Boqun Feng wrote:
>
> > > "How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
> > > the arch could choose.
> >
> > I actually agree with this part, but this patchset failed to provide
> > enough evidences on why we should choose xchg_tail() implementation
> > based on whether hardware has xchg16, more precisely, for an archtecture
> > which doesn't have a hardware xchg16, why cmpxchg emulated xchg16() is
> > worse than a "load+cmpxchg) implemeneted xchg_tail()? If it's a
> > performance reason, please show some numbers.
>
> Right. Their problem is their broken xchg16() implementation.

Please correct me if I'm wrong. Now my understanding is like this:
1, _Q_PENDING_BITS=1 qspinlock can be used by all archs, though it may
be not optimized.
2, _Q_PENDING_BITS=8 qspinlock can be used if hardware supports
sub-word xchg/cmpxchg, or the software emulation is correctly
implemented. But the current MIPS emulation is not correct.

If so, I want to rename ARCH_HAS_HW_XCHG_SMALL to
ARCH_HAS_FAST_XCHG_SMALL, and let these archs select it:
1, X86, ARM, ARM64, IA64, M68K, because they have hardware support.
2, Other archs who select qspinlock currently (including MIPS),
because their current behavior is use _Q_PENDING_BITS=8 qspinlock and
we don't want to change anything in this patch. If their emulation is
broken or not as "fast" as expected, we can make new patches to
unselect the ARCH_HAS_FAST_XCHG_SMALL option.

Huacai
