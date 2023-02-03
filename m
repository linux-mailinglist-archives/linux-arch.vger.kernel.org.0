Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D81688CD6
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 03:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBCCBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 21:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBCCBH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 21:01:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE85A370;
        Thu,  2 Feb 2023 18:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B49F61D48;
        Fri,  3 Feb 2023 02:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD0AC4339B;
        Fri,  3 Feb 2023 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675389654;
        bh=Ppnrlr2Of62m9p9RCJwEmdFH/cKYlwUfnbwHcwZolP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y3tztUIxT4B76/0oHhSOvJJhzu5QowRhwKdvd9v1jVQACxzk/G3qqdsTyn2VEGAHt
         nxiBkLwfKdOxnwP+vNigkQ+0V+MFbDEzlJoGxVGh9zzFzCNhyy8yLr3tP82wKBQ0SE
         RsCk/Fx9hM4fWhE783wYHe5kMcBDplLsnxg+CgLh3tMcgQ9bwqh6rujH6iV99U6H66
         seGJsR7bQGKZ6ceSHc3FoCwjv9dl6gOjMoiv5Y080V2uqq90AyREVtNobJ5u3vAdoW
         gHNQ/zIVwCwmyn99Cpp+9VOZIDM8pkO4cWLGFIClOYfRxeL1P7jMQYdxwFMyWyix10
         s34JeM5rKM64A==
Received: by mail-ed1-f52.google.com with SMTP id cw4so3840511edb.13;
        Thu, 02 Feb 2023 18:00:54 -0800 (PST)
X-Gm-Message-State: AO0yUKWRtqppTKMFGwrzLM3TM80c8kOcl0SGgmq7zy8FGv8Z0Q1rgsZI
        lg63B9qSDoRVjTMQdvxX24nsFNjdZ2r12M48OEk=
X-Google-Smtp-Source: AK7set8/irv84ZiakV0771/M/EefHiXbhcsZ2NjT5di96kWUpYycaQxPCjZtVXZLod9FoZdvXzwJuK8NZ8pwwfnQ9+E=
X-Received: by 2002:a05:6402:557:b0:4a2:45e7:ee63 with SMTP id
 i23-20020a056402055700b004a245e7ee63mr2554310edx.38.1675389652903; Thu, 02
 Feb 2023 18:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20230202084238.2408516-1-chenhuacai@loongson.cn> <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
In-Reply-To: <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 3 Feb 2023 10:00:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
Message-ID: <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     David Laight <David.Laight@aculab.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, David,

On Thu, Feb 2, 2023 at 5:01 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Huacai Chen
> > Sent: 02 February 2023 08:43
> >
> > Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
> > configurable.
> >
> > Not all LoongArch cores support h/w unaligned access, we can use the
> > -mstrict-align build parameter to prevent unaligned accesses.
> >
> > This option is disabled by default to optimise for performance, but you
> > can enabled it manually if you want to run kernel on systems without h/w
> > unaligned access support.
>
> Should there be an associated run-time check during kernel initialisation
> that a kernel compiled without -mstrict-align isn't being run on hardware
> that doesn't support unaligned accesses.
>
> It can be quite a while before you get a compiler-generated misaligned accesses.
If we don't use -mstrict-align, the kernel cannot be run on hardware
that doesn't support unaligned accesses, so I think the run-time check
is useless, and it has no chance to run the checking.

>
> Also isn't there a HAVE_EFFICIENT_MISALIGNED_ACCESS define that would
> also need to be set correctly??
Yes, HAVE_EFFICIENT_MISALIGNED_ACCESS should be kept consistency with
ARCH_STRICT_ALIGN, thank you.

Huacai
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
