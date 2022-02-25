Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF614C4A26
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiBYQIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbiBYQHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 11:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EB21131F;
        Fri, 25 Feb 2022 08:07:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EE9AB83273;
        Fri, 25 Feb 2022 16:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22393C340F2;
        Fri, 25 Feb 2022 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645805236;
        bh=KbJfW32hJ/F19yfN7A1bXil25wuVvtsMCViBmRGt63Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WkbIlFcJhtK50zmM1SUqT+c2BPoPb/PAsS5g6c6LqFS7dLJTZxLAPvig1x6SXi8te
         l5Cx5rIlFRnbSFqV0Md2Gt99TvNmEAE85nc8zZkW2KAysaFXNYW8weU3KRSI1Joub1
         XfgGa954+3/CiMxkbGo51ZitZf59ze3/G/mztC6h6fIENRXkrcAjUFFN1d6J+PDcBw
         gx1uVRfyOgaOR4bZKjVcG7PIz/MCA3RNLoXSnngVfstymXQ0A55zH1r8rE0BbpfyBI
         53H/HcqUiVVHaCBF70mR9z8l6owgUIz3VOsTGHF1gt/NgeAutWcTYSskkxOKLmnMHx
         9rb/DOmJIf44g==
Received: by mail-ua1-f46.google.com with SMTP id 4so2689384uaf.0;
        Fri, 25 Feb 2022 08:07:16 -0800 (PST)
X-Gm-Message-State: AOAM532qmB3RCzM2eOyjrm4h1R0Jocb2mLGQ2iLUY34AQqe43FcrxgKL
        8xYBWINlULGTU8a+TQKYajEleFQ9L6CmhHkvOLQ=
X-Google-Smtp-Source: ABdhPJzyFkCkLFwk2uiu55UbxfUmfSs3x9iDpfEO2XzZ1mh9E9zaiS00R4pCw1xb9Wsx0R973/NIBGmLnXTfXz/Q4Mk=
X-Received: by 2002:ab0:1112:0:b0:33e:802f:e335 with SMTP id
 e18-20020ab01112000000b0033e802fe335mr3769822uab.57.1645805235064; Fri, 25
 Feb 2022 08:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-17-guoren@kernel.org>
 <CAK8P3a13_VBpTidoF_pUdV5g0MFqpSe17rgw=XUv69CCFCN0_g@mail.gmail.com>
 <CAJF2gTTu5=XwDUwNq=PfnzVRj-jPHH+0cOGhhLr_dFED1H24_g@mail.gmail.com> <CAK8P3a0MtcB7YMWKZKvpcy4Txi4JTXT61KqFoKZOqhVP530oEA@mail.gmail.com>
In-Reply-To: <CAK8P3a0MtcB7YMWKZKvpcy4Txi4JTXT61KqFoKZOqhVP530oEA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 26 Feb 2022 00:07:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQtUonLQn+aRyf6f1Ei9o6wWCrjHXNkfa2rxKMEGuDw2g@mail.gmail.com>
Message-ID: <CAJF2gTQtUonLQn+aRyf6f1Ei9o6wWCrjHXNkfa2rxKMEGuDw2g@mail.gmail.com>
Subject: Re: [PATCH V6 16/20] riscv: compat: vdso: Add rv32 VDSO base code implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 25, 2022 at 11:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 25, 2022 at 4:42 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Arnd & Palmer,
> >
> > Here is the new modified compat_vdso/Makefile, please have a look,
> > first. Then I would update it to v7:
> > ===========================================
> > # SPDX-License-Identifier: GPL-2.0-only
> > #
> > # Makefile for compat_vdso
> > #
> >
> > # Symbols present in the compat_vdso
> > compat_vdso-syms  = rt_sigreturn
> > compat_vdso-syms += getcpu
> > compat_vdso-syms += flush_icache
> >
> > ifdef CROSS_COMPILE_COMPAT
> >         COMPAT_CC := $(CROSS_COMPILE_COMPAT)gcc
> >         COMPAT_LD := $(CROSS_COMPILE_COMPAT)ld
> > else
> >         COMPAT_CC := $(CC)
> >         COMPAT_LD := $(LD)
> > endif
> >
> > COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
> > COMPAT_LD_FLAGS := -melf32lriscv
>
> Have you come across a case in which a separate cross toolchain
> is required? If not, I would leave this out and just set the flags for the
> normal toolchain.
Okay

>
> I also think it would be a nicer split to build the two vdso variants
> as vdso64/vdso32 rather than vdso/compat_vdso. That way,
> the build procedure can be kept as close as possible to the
> native 32-bit build.
Yes, current native 32-bit vdso & 64-bit vdso use the same
vdso/Makfile. So, I think it could be another patch for this cleanup.

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
