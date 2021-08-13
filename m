Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB103EB32C
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhHMJI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 05:08:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbhHMJI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Aug 2021 05:08:56 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N0WLC-1mzx1s2QEO-00wTC5 for <linux-arch@vger.kernel.org>; Fri, 13 Aug
 2021 11:08:28 +0200
Received: by mail-wm1-f43.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso6449942wms.2
        for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2021 02:08:28 -0700 (PDT)
X-Gm-Message-State: AOAM5316A8vJ2tz8Mpu6DaCAA3ZGfvn+DZYyUIzuRECE5R+VIacE7yGA
        l5cnLmTMf0uBCLdtW6W+QaCZacTdWEerjd2zBbM=
X-Google-Smtp-Source: ABdhPJxO9/HQCRwccUdSD2ocjhjzzNs3UgyTIzki/WEj/Fyy1lWVZ5mir9mgkY7Hc+1/9UdF49iCoILZYkz5dVwEQoM=
X-Received: by 2002:a1c:20c5:: with SMTP id g188mr1652264wmg.142.1628845708232;
 Fri, 13 Aug 2021 02:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com> <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
In-Reply-To: <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Aug 2021 11:08:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
Message-ID: <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ikDDuTXbm/uvuqeHlfia8YMz6DC06lOPV2eckKKBqYbh6t0eplD
 jrM5DDGtgHK01rDA3lYIIwsAFAw0LuIQmPiJwCBUKBkxyw2PcR0RVL7+LzE+Yt5PGcqdqH8
 OVzSXTfcP8syQHNGFkFHApCI9ruXx4Pj4XFY+ZsvpbRQ3gVSQRb67L+Y91vlE4e28VkDWkl
 X4725KX7oY2qN+txbAwhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:azqNuz5dodY=:7/F43OAt48ZHeqI9EUcT3K
 VdGR58EBsoD/ht7a4s7Rnc/gT1W1lPhjuYspFODkwsQjjRzgp/dXloSSUZKD1YA3bpkS6FRQO
 YuyPjGrxm+9875AVrzuYPPq4dLpQ8t/JxG84jOGQTEeqf7R0ye1Eeon557/8qFOY2GjJhjdn+
 Y+SVq9U29icXiOV0UGFGwwfvvpm6o3Kbjv6js6LclJoGfqIiKfJh/Q3oByh8T1wfW7MXdoHWk
 fM5KZccWHCzCa31usEah9jhOjvgg5ZRJhXiNp5tO4l5GNMwIcYiQ+Aozo/jGwKrfv1mf/WA6a
 NoyAf08RAyWLksqo6bdFQf6q20CjvXma3sSzCCo2RJAUwAPm/Jsxb4Lizt4Q4c2gXsDKNq7Io
 qnCqWuE3VlP2yJFBXltfUVxN7cf6Oioq+/j9Y1unT+nU2v7pt23Swrzk3fmHVBd8c0kPR2jo+
 +1F3pJa/xL4Srw0KJP3QHbn4qKvHe3m4/WUggcqFzRK1VstSeP7nR5yDfckVX36TrzBDvCBGv
 mvbVchkmX7q/rvLDi16ykfOCqT57gSS5MO9IXfSvsjVZmvlx5xgzAXBXBVUvJ+eoCP0lg6jlB
 wDbuWBQH1EOjjuy5lF0njysW8G1g5W7IWD2WZM6FYla5FTOIKHfbyKh6+mJ6fC8z0xvJnbVxE
 3/orBo70QmyJe+CKhwWx2oOo2y/G3oxYmZvak9mYxLmP86LB1qkrL3JNVeU4KHvJhlPYkQT8f
 ZqQtdx+P++JjuAAnbLfinBtTZJKln0B1D7vLUoSWE8JEHNwxrFhGB2P1q7sZksrkipaOVr6nQ
 qYcZ/BDOMaGUhr7RZjxy3IJbectzVDweogzZFNgn6yaApmes5tuMfblcm7rnwQvS+eAlM2Rpi
 9MKgV4T+oDojeHEY+OhUptSPhUCtFqRLUZmD6v6VBSfPVaQD53hhBOQ0kldftp8+cTMLx4ENb
 TxoPL9cJRjqfFhL64tuSESrIy6Jn2FloCQbEjRNS3rvSgODBJznDH
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 13, 2021 at 10:14 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Fri, Aug 13, 2021 at 3:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I still don't see what is special about 40 and 48. From what I can tell,
> > you have two constraints: the maximum address space size for
> > the kernel configuration based on the page size and number of
> > page table levels, and the capabilities of the CPU as described
> > in the CPUCFG1 register.
> >
> > What is the point of introducing an arbitrary third compile-time
> > limit here rather than calculating it from the page page size?
>
> So your problem is why we should provide two configurations VA40 and
> VA48? This is derived from MIPS of course, but I found that RISC-V and
> ARM64 also provide VA BITS configuration.

The difference is that on arm64 and riscv, the CONFIG_VA_BITS
configuration is directly derived from the page table layout.

E.g. when using 16K pages on arm64, you have the choice between
47 bits and 36 bits, while your method would apparently force going
to 40 bits and either waste most of the theoretically available address
space, or require three-level tables even if you only need 36 bits.

        Arnd
