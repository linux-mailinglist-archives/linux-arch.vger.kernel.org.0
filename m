Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864DD515C0B
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiD3JyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382560AbiD3JyI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 05:54:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553AB6E4F2;
        Sat, 30 Apr 2022 02:50:44 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlejs-1oBr5V1OLq-00iity; Sat, 30 Apr 2022 11:50:43 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7d19cac0bso106999377b3.13;
        Sat, 30 Apr 2022 02:50:42 -0700 (PDT)
X-Gm-Message-State: AOAM5310njdym2Ubn1QhBjdz4Y15u+h1S5xjtXjBXxg6LFWF2fuefTun
        U+HIRHAvO7znpNJ/k73y+5PCtOuYBGWaOp4hewQ=
X-Google-Smtp-Source: ABdhPJyLj6FnAysaKzwwc3qOaMCFIiS1hfGGX23CKyKyqsDGd/LTntRnyBYwoZASkBTQ+TWIWhm1m1vJyXWHyLzn1Ts=
X-Received: by 2002:a81:5594:0:b0:2f8:f39c:4cfc with SMTP id
 j142-20020a815594000000b002f8f39c4cfcmr193063ywb.495.1651312241898; Sat, 30
 Apr 2022 02:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn> <20220430090518.3127980-17-chenhuacai@loongson.cn>
In-Reply-To: <20220430090518.3127980-17-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 11:50:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a097Z_DKXbrLrCB7JZUB0J0duSmZRHSJkjRM5=rteit6g@mail.gmail.com>
Message-ID: <CAK8P3a097Z_DKXbrLrCB7JZUB0J0duSmZRHSJkjRM5=rteit6g@mail.gmail.com>
Subject: Re: [PATCH V9 16/24] LoongArch: Add misc common routines
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:slXdi58PVLIZW2dmjwWM278p/kxQ+K/efsGhvsMq4gY0bvwVsbH
 xqRj7E3Ubh1et4ARsArIDWwz5/FXdE+NK6gairW1NXWkygbyNRFO83KUDkhDxl6nD0cJPVR
 MNxpcmzdRVa8ZPLrgkZPPUCkgry9m6J+YSCrm8iMhAsRBNoRf4Snp6lO7XHlhVXBU7TlXxm
 VKlB5DfidnHVjYo+/qUKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:upqXE5Dmhr0=:3dRES0OySqIuV5xuSLB4AQ
 Q/Yk2NkCtPDf/3l+AA7amKUSenGe09v1b2lv7gRF0e0JpOXCuORB/PAKpSLLbdZlhLaFg1MH+
 8uvugMjeEqaFP58aTtTedT6Ta5JOZhX08n365WUhuqLu6rLY6cXB2zObR4oHp9tUJ3uHiTyJY
 gd26wAM4LMWiPZQp3YgOwl+r+x6pc+LmoRH2uPjAnEsNcNjNM/X45Rnmz+Wq6uktAWWgbQOmL
 2CsOrDo8OuNKwwXX+dd+2S7wcMkB2iQTcaSA4XWkrTMlShEam/XN+7JRYfb/GxchvaxEKEXWU
 bo8ojNrWwiQlXaS1K6C5a5piHDdyF65kevPhdAhKjNF1c3zR1nmQMtLwtVD+8Up0dZ52QfuEj
 AM4QlfCysYFliYBEOHmKuQvaW/rfX+NSNZJfr0AcPnM8ROoA/e4zuJ0AXcn0AiXxjwErxv9qz
 SNdk0Wgoy/xzdHow8LW+3purMvcWdtvbrq7idJ1chvsU81b/xMUNDyj+2AZ1fgARYSIONl9t7
 IIup92kx0PL+aFKaWXvtQcyYnqSnvnQE06AtUgd4vXqNW2wveoxFXB+83g5BcDqu1ZLXGoWoL
 ZEW5iW0/oJkux1fn3e1F7/dK8PE4pH9iGXzEiCkJbTWugk48ODgaImyS9J9/tBWW2rOVwk8nK
 k4BnMq3cQTIX3gF8cbpzH2/rkOxizVb7uAZYd+r2UVwcgwfbnMkElyMZeY28HMAvCaGcNcXKi
 8wEO6pLGBRNl0s4lUtbJ3TQNNzlNphs6QCkciP86XFkTdyge5GnJNkugkWJQ5Qj2n/YkFTlD+
 GDfA+uRbICeu63+24sv2m11vlSF5l0s+zecfrQ1X3roVQ439kg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> +{
> +       u32 old32, mask, temp;
> +       volatile u32 *ptr32;
> +       unsigned int shift;
> +
> +       /* Check that ptr is naturally aligned */

As discussed, please remove this function and all the references to it.

      Arnd
