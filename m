Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D867406982
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhIJKM1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 06:12:27 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhIJKM0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Sep 2021 06:12:26 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5n81-1mzO1Z1qsV-017Bb6; Fri, 10 Sep 2021 12:11:14 +0200
Received: by mail-wr1-f45.google.com with SMTP id m9so1862419wrb.1;
        Fri, 10 Sep 2021 03:11:14 -0700 (PDT)
X-Gm-Message-State: AOAM533euSl0Ch8BnaKPN6EvEtiUdpnxkasAvmFZaj767clW65BO9jqQ
        FUZ3PVooqr0rXXpiiHgFbsmJi9yN7zG5p83NhII=
X-Google-Smtp-Source: ABdhPJwDwtZratwUWNtJYxVI1GkhCaKDzteRxo1cgezGuX4el7rN8VJUCymQ3JBP7wFBv6GT0+cIVAvTq5CSK/QRvZ0=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr8545666wrv.369.1631268673953;
 Fri, 10 Sep 2021 03:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-19-chenhuacai@loongson.cn> <YTjbaz7iea1kwGYb@robh.at.kernel.org>
 <CAAhV-H6yPscb_wZRDjaY+h0HB8No-7muP87G+wWnUJdSPE00+g@mail.gmail.com>
In-Reply-To: <CAAhV-H6yPscb_wZRDjaY+h0HB8No-7muP87G+wWnUJdSPE00+g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Sep 2021 12:10:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FZ6tM1njitj2+W+npSfkbQD3My0iHDtReh8acZGf3mA@mail.gmail.com>
Message-ID: <CAK8P3a0FZ6tM1njitj2+W+npSfkbQD3My0iHDtReh8acZGf3mA@mail.gmail.com>
Subject: Re: [PATCH V2 18/22] LoongArch: Add PCI controller support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
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
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D1fFd8SSJyioOBWABsxp4nMVNZXc4Y9MdRnH30ere8M/ikLnYxk
 APY/vGJjKhlpjs3asXXFfN1GFFp+LgThFjsk++cOKyQ63cXyvW755HFtyE8+/8kp1FYpDs1
 a+sR7i5C6ajHMhZV2Ht5B4P7obJFJXmeN6ISh0lpXWOG7Ge8aZf++UxfuGP9qNJMVKCdIap
 bg3G4uNAYcw1fMC18I+Kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tt+nTBfAiSM=:tTwHElebYAsbAYv1ngaB6w
 SXf2gBUXusPx2vGSecEWoef4/wDUt1/A/V+8shdUZ80W2hGWhqIG3cumdBOotY5o5dmXxIRZX
 nnQ2jHtKDLqktznO1G7onLdcCwFKBmhxgtjicI+K6z7TR56WS1LMS6BHePxljGydXPW5DuOFN
 llZOkJ/pOBcsH55ecTpWRiYxMqbplilSDnJGe14e1Emw06UoiXJD62joMRnmJYSDsuwI5NVw1
 jgdebAse6Q27GjIe/OSoof//jQHXu2ocmm5UzQmlJqOutMUKiiAn5dt7y+NeAO7T+fKEi7yIL
 g01oaFoyxdrzuql/NmpAXSWTLoVCSdAzKAOGuZZzAxNuMptkgzwnnjLH62wMD8XNwnbko5KsE
 hP8o5HSrGg7g455QM4mkpNCluHENCD2QVqzCRqqg2anvEiOH8dGOpRa219sH0Y9NxWAAokTzo
 ld7dCT0OPsjTiLFVsTLZOEw6BT6JbB24JloDd3QzEDW2aX55bmwQEyU7V/HhqyZ50j1s0ax+F
 OEwg077idyylhNa/GBcx8Ax9vdnb5oq53XyCsjywNPFoZoMVcwab46wHlN/hWNWFbw1rVV1E0
 dzQW1d0Vrc+aUtkiqXn2lCVamfl/Op8Q1M30dEZc8AMOaHlvE1V7/aoo/6MFoBmKd4WlC/Yt/
 ImNxZsDhPG1cuu7+jVVnUir5VGBM8JDsi1O1qIettSYMBw0bXNo1C2lqmD6e6eIGvksksSOPD
 1w7mjQ6h+RfXakMWJkFBYarJZjKS61GoF8VQURYSrrVJCDzc2b7PTOBdnfWdt6h+284TI5hfh
 ZcI49n39uVf/irrBOzgUbqQvB1gpVT12pMb8EZrAomtw1qidIZL5lZg+VX8M11xxtqsinmIDf
 4pLB+38N4aBDPHTv1zKg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 10, 2021 at 9:43 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Wed, Sep 8, 2021 at 11:49 PM Rob Herring <robh@kernel.org> wrote:
> >
> > It might be time for default implementations here that can be shared
> > with arm64. The functions look the same or similar to the arm64
> > version in many cases and why they are different isn't that clear to me
> > not being all that familar with the ACPI code.
>
> I agree, but I think that cannot be done in this series.

I would propose to split the PCI changes out into a separate series. Let's keep
this out of the Loongarch architecture support and do it separately,
like you would
for other drivers.

       Arnd
