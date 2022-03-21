Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613684E2515
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 12:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbiCULQn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiCULQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 07:16:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A554F99;
        Mon, 21 Mar 2022 04:15:14 -0700 (PDT)
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhDEq-1o1iwU4Btq-00eIp5; Mon, 21 Mar 2022 12:15:13 +0100
Received: by mail-wm1-f51.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7460077wmb.4;
        Mon, 21 Mar 2022 04:15:12 -0700 (PDT)
X-Gm-Message-State: AOAM531nrNOtTOrV1uTHOBAJuVJiM0llPWnSOSRP2RHda1BJHRBEqeoy
        kcKHu2aW3KVq8lxPnojYv4A8PCYDQekmi/j6LTU=
X-Google-Smtp-Source: ABdhPJzKxQl6VSttlmzvEi1hOv2leyycaxxTRshXcWMv4AXgfyXlahFpsNNQtY+AZ5wBEfDoPO06uRJRVwd5uyfNNS0=
X-Received: by 2002:a05:600c:4b83:b0:38c:49b5:5bfc with SMTP id
 e3-20020a05600c4b8300b0038c49b55bfcmr24337091wmp.33.1647857360314; Mon, 21
 Mar 2022 03:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
In-Reply-To: <20220319142759.1026237-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 11:09:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
Message-ID: <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
Subject: Re: [PATCH V8 00/22] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@kernel.org>
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZnGkfk570X1mQgyfANU13nhtx8Unvo25TN3oV2Riz+Tha+mptO5
 LUYkQe3vwkCqXCPjGIjuR3VgXdTqpzTiYgDl6npzESHpjpMEhoKv+I80lWpGVDjWpkjjrss
 hF3Fr68I/fRF+wzC16d2CX08JR7qLFF39jGBieyiFIHDmIBhx3hQOUw/y1aA4z87NQzin/t
 EEavyeCv3+D9aNMwhTA8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTy4IGEUdE0=:9wy/OcskBTsPHIi+puE+dH
 08jh+kRc/1DFhA9C9Z0/G2JBNxpJNsb3hBSaGRyJ+9JhoBCfz8R56X55PAg7E104WpkVe1LTX
 8oKRwaYaD4qxgOtTWZNyL4JSxGB5a3rj7Bz5ndCUhxv/44SYOzsfU8LGiPWF6F+uBobPKoKrQ
 DlV6s26wKQcphKt3c0V61+X3ZolWwnyqK8wTu6qszfhMjRyQ4dPa9ihsFwj9AK2VEy4lRxzE6
 IfNSFPgNz64o4q089G5P8f9+9is2Cmb0/iP/MkqfGCewWMd+WdPR87a3qBwTeDoxzC1G6y9XB
 oeEyTWP7KrRZayvw/Hg0SLjRnDpt5x24L/dqoqWbTJf8jAIsmEwUazMtdMw3/1z1wLnuvThEw
 4ZU+JN6SV3kV1tgcj49y/fCdQqI+MJ7ehV7mrjIEQ3h8W3S3kAWEzNbgUW4x7LmyjYfZH6T1H
 xmEdDSMrYV+807AugkiCbRlYa/N4acUIxlFf+uUAcLL8cZUyg2ndFTJxFFcdDfx3XXOxc9UGc
 1C759GZ8UVEB0L4bzV5OFMw5d8VTWIHhx+aYG2LwKusfWVTwUz1etR6SbqZKu0wIjgavL5uE/
 IiaGfRuYWZzLiB8PJlVggKIsh7KB0+e9iW5xuss4CvkFMMO4ijuSRVFwNNe8RCr4weGzBYq65
 sjX2vKjFJxlxGeqYyphYf4xigEtsVZM1opX3yBMu/Ptzn2oo4g2vM+MMd0byMmvwGzACe1h01
 lW6SqAO/ge5nib1z1BpwlEXwZDBE1wDGZm0qxSNmj3QUJ+Pq0caAdd6LLhRbeHLv+jRXx8L/A
 1XPsupWL4sg7tIeAfiPSA/Xtc/qoJT2tDwJEnudA1lBFKZ9kO4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 3:27 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the next revision of ACPI Specification (current
> revision is 6.4).
>
> This patchset is adding basic LoongArch support in mainline kernel, we
> can see a complete snapshot here:
> https://github.com/loongson/linux/tree/loongarch-next

This looks fine to me for the most part, and I only had comments on
a couple of things that we we had discussed before. I think the syscall
interface and the spinlock implementation bits can be addressed now
by leaving the controversial bits out of the submission, but the boot
interface still remains to be resolved.

As discussed before, I think the best way to do this is to not have a
documented custom interface but instead use the UEFI wrapper
code for both the (current) ACPI based boot and potential DT based
embedded systems that may get added later.

       Arnd
