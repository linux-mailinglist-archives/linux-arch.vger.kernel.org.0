Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C14C4997
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 16:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiBYPuj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 10:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiBYPui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 10:50:38 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1296BDD7;
        Fri, 25 Feb 2022 07:50:05 -0800 (PST)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mtf7H-1oDw3g12Nz-00v42n; Fri, 25 Feb 2022 16:50:03 +0100
Received: by mail-wr1-f48.google.com with SMTP id s1so5125752wrg.10;
        Fri, 25 Feb 2022 07:50:03 -0800 (PST)
X-Gm-Message-State: AOAM532T7Z2pc1YU+YopXLubdUeMfitJTxUPHucNwZM3+g/43QTOFdty
        UFasBnUGe99F+tBA9K6Ow4GdDLxGkOiuVfoPwN8=
X-Google-Smtp-Source: ABdhPJysyJQAyOWUBXwECRmjF7nJ/3KDCWU/jhvnP3qXA/ljoo2U2xK+NNU2HPSONjjfnno6VeVoMKIwA9lIuOaBaho=
X-Received: by 2002:a5d:59aa:0:b0:1ed:9f45:c2ff with SMTP id
 p10-20020a5d59aa000000b001ed9f45c2ffmr6588564wrr.192.1645804202754; Fri, 25
 Feb 2022 07:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-17-guoren@kernel.org>
 <CAK8P3a13_VBpTidoF_pUdV5g0MFqpSe17rgw=XUv69CCFCN0_g@mail.gmail.com> <CAJF2gTTu5=XwDUwNq=PfnzVRj-jPHH+0cOGhhLr_dFED1H24_g@mail.gmail.com>
In-Reply-To: <CAJF2gTTu5=XwDUwNq=PfnzVRj-jPHH+0cOGhhLr_dFED1H24_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Feb 2022 16:49:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0MtcB7YMWKZKvpcy4Txi4JTXT61KqFoKZOqhVP530oEA@mail.gmail.com>
Message-ID: <CAK8P3a0MtcB7YMWKZKvpcy4Txi4JTXT61KqFoKZOqhVP530oEA@mail.gmail.com>
Subject: Re: [PATCH V6 16/20] riscv: compat: vdso: Add rv32 VDSO base code implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VJmerkgNSVRaQs6ZdeKmfJ/UIRQqAkKTaskIAwrKr/BRXblvHF1
 Q9ojRcsi00yiaKba6v+JD/RpfxY5jDkEe5Yy9SG4QgVFPJQG1/7Af//f6EJiofuGjY67KN/
 owJqmXBrS36FZJJ5a7C/ePLaN+mWXGB5Mpl5GeK2mG7/XoKE5dA/TRrGsB+rMbq/DsG4oPE
 kZuNrhloqf4bdqMgqSekw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AtbfbC+a71g=:JoPSHBClamW4vFn8Dbx4qD
 JTdYG+rQH/rqTKOb3Vi9+abJqdQBhrB3+KpP5R1gK3CmCAVcAEswn4Iqjx4jC2ILsMEXdAAdK
 vMP3gOpkKGKuxlp+ckY4zeaCtPU1YDanEPyBL8+5tmFb+rFxQG/iEfzyvQF4eCPvjTDL8BOBA
 uUBt4ybyLndHcqDpxlsRaiaxR6URTeYqRy4G48IbA613ToXaEiDXnbZnobDfJx3sjvn0jtFAq
 BGsJl3o06/QHJuu/uK9EwD5Fh5WSFzcqdVMBOR6bNkvy8zTS2cW9Dw5CYaV6H5yqjFT3RmLR1
 3xuTU3nx+0OykEigJNz0DVHQ7E5lxRkgwLbIMR339Fvq4DTiqBvZb7YAJbxhRoEfPsgfD27+K
 M2AFSUTkNrgo6oNlyOGjf9zj2uLMMGz94eudWpQuyblzjUQLVkWRtI44cLpBOFmnN9keZ8FfC
 6XjaKJPloLtA2kvXREwWuNmc4XFvnyM0svwy1Gy9ZIWhdt/lzKgXWpMCArOpP/amBbHBcNjyz
 N2DkRA49bJyH6XNWtdZCDrjeuEU8HfZd2tKrykqHYKGyYgTv5T4Ysm24bFuxSzm4IyTQ2jtJh
 IaepGFNB2LBaS+aiS/TmU4cHxyv0D8OXpv5yoKQm6gPDFqEYBoPlYLu5K0gOpa9Wmzwik05hz
 SoSnSsOZ+MokbJjo9pWCGDf1ggwA9eGdElxcDzj23/lV4k2xH//BFQLSX2yoD2vVILoO4rv0y
 3sJW2SijUswXNVAuyXSmOnSFKHmXUHJj2cPHx6kfO6FTrZBQjEjrTkKewCgG4GdhsHt/corwx
 Dm3NaC8qUymw5Rf6HFOZN6NtpPV2gJ1vYH7IgDAOHSPkxBvKEg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 25, 2022 at 4:42 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Arnd & Palmer,
>
> Here is the new modified compat_vdso/Makefile, please have a look,
> first. Then I would update it to v7:
> ===========================================
> # SPDX-License-Identifier: GPL-2.0-only
> #
> # Makefile for compat_vdso
> #
>
> # Symbols present in the compat_vdso
> compat_vdso-syms  = rt_sigreturn
> compat_vdso-syms += getcpu
> compat_vdso-syms += flush_icache
>
> ifdef CROSS_COMPILE_COMPAT
>         COMPAT_CC := $(CROSS_COMPILE_COMPAT)gcc
>         COMPAT_LD := $(CROSS_COMPILE_COMPAT)ld
> else
>         COMPAT_CC := $(CC)
>         COMPAT_LD := $(LD)
> endif
>
> COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
> COMPAT_LD_FLAGS := -melf32lriscv

Have you come across a case in which a separate cross toolchain
is required? If not, I would leave this out and just set the flags for the
normal toolchain.

I also think it would be a nicer split to build the two vdso variants
as vdso64/vdso32 rather than vdso/compat_vdso. That way,
the build procedure can be kept as close as possible to the
native 32-bit build.

        Arnd
