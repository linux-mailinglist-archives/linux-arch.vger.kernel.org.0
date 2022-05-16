Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD722527EB4
	for <lists+linux-arch@lfdr.de>; Mon, 16 May 2022 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbiEPHlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 May 2022 03:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiEPHlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2022 03:41:12 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3712261C;
        Mon, 16 May 2022 00:41:10 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id e19so14582843vsu.12;
        Mon, 16 May 2022 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=da0tSqTpoZccXNC6Mon6l1Je9BJX/v1Bpiwu4fXyLMQ=;
        b=MN1SfpWtfgHZisIRElpcWhlOvw1hNBSnFuOn6GxqAoHNiqWAP+xjY4LJFLvdBIlqs4
         feqjLC/vRblVTe6p5VqKxIKMbdCRPvbxiIVumSo9aPEeiegmwaZysWj07xAA+5c+xr1I
         3aldzCwPPLPJPD9TeS8HXWUIFEqYictOfhlHrBk3vMIpsqci7LTd8PV3zxt5wrO0cNkp
         HN3sA1u/ByVZwfxRIw0clGdONDzzq4jsXrdEFXIm0nvqKIHzZOghxcrUl2vyd0tY3kik
         cXWFjffR95p+kRsRBjdXURg6F27B879a9uVv6QhsCM7KZtAG/RjUPInC/6GVqTVsyaYo
         SqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=da0tSqTpoZccXNC6Mon6l1Je9BJX/v1Bpiwu4fXyLMQ=;
        b=N3lr3VJQ9z3tXglUxIKuRlYjYxn7GMKlFM3H6roU4IIe4TNixZUxoQ2KEGBqwd5JTf
         t3Er/0BNeXtEI99tt+pn2rXePumCcNQXdZHQXWvJRsxToslV0m0CvWwB2lCyIpBaA1nX
         gZHB+jB5vPo6PFQyEE/QDO84OA1kyU54gMoYq71XMbzQUmpYubNI2yBdqqxNgzZUVW+7
         2EUgcPQD6EDj0INnrzgiOEwlLpaTXmWYDVnozf+b75YBdu7JtUU17SXKSv/PFN+PMWci
         PHUperQBqY2Fcp9srg46YFN/0pYWBF7gxYUhmvSzaeLhrUzKEJsh5DJppJUZ6C/Iaun7
         0jow==
X-Gm-Message-State: AOAM531Uh6R16Ljjii1/x7I6DKAmMWGA9b6kuzceFC+lx8nZsn4hnMVT
        ddGHP3iLCBKedlAl4LULjmeJLtn0XOTMarGts00=
X-Google-Smtp-Source: ABdhPJwuWz80i/I8hD+856n9c8YC3uWj0GrQfY1p2XZMv4zghrLtnob8d/4S6HgnHY7H8AamoB81dntwIiiFApBBmww=
X-Received: by 2002:a67:be0b:0:b0:32c:d82f:6723 with SMTP id
 x11-20020a67be0b000000b0032cd82f6723mr6170771vsq.67.1652686869723; Mon, 16
 May 2022 00:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn> <CAK8P3a2Xu79zzJ=c3WJJEXAmcL2RT6NBZy-dd7s-Kz3Yk4yJzw@mail.gmail.com>
In-Reply-To: <CAK8P3a2Xu79zzJ=c3WJJEXAmcL2RT6NBZy-dd7s-Kz3Yk4yJzw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 16 May 2022 15:41:01 +0800
Message-ID: <CAAhV-H5xSUoLv1rtrZTwEsd+yn8msHFFJ8eGRitzoxJ_XQDNNw@mail.gmail.com>
Subject: Re: [PATCH V10 00/22] arch: Add basic LoongArch support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Sun, May 15, 2022 at 4:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, May 14, 2022 at 10:03 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > Cross-compile tool chain to build kernel:
> > https://github.com/loongson/build-tools/releases/download/2021.12.21/loongarch64-clfs-2022-03-03-cross-tools-gcc-glibc.tar.xz
>
> I also uploaded a clean build of gcc-12.1 with loongarch64 in the
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ builds.
> I have not tried it yet.
>
> > This patchset is adding basic LoongArch support in mainline kernel, we
> > can see a complete snapshot here:
> > https://github.com/loongson/linux/tree/loongarch-next
>
> Note: I have pulled in the generic ticket lock series into the asm-generic tree.
> Please rebase your series on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux
> generic-ticket-spinlocks-v6
> to avoid duplicating the commits. As long as you are based on top of the
> 9282d0996936 commit, that should be fine.
>
> > V9 -> V10:
> > 1, Rebased on 5.18-rc6;
> > 2, Use generic efi stub;
> > 3, Use generic string library;
> > 4, Use generic ticket spinlock;
> > 5, Use more meaningful macro naming;
> > 6, Remove the zboot patch;
> > 7, Fix commit message and documentations;
> > 8, Some other minor fixes and improvements.
>
> I think with this you have addressed the comments that I had in the past.
> Xuerui Wang and some others had additional comments that of course
> need to be addressed, but this is looking good to me.
Thanks, I will solve the problems and send V11 ASAP.

Huacai
>
>        Arnd
