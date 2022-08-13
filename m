Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361FE591869
	for <lists+linux-arch@lfdr.de>; Sat, 13 Aug 2022 04:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiHMC6Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Aug 2022 22:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMC6Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2022 22:58:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D59DB74;
        Fri, 12 Aug 2022 19:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69674B82574;
        Sat, 13 Aug 2022 02:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106F5C43142;
        Sat, 13 Aug 2022 02:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660359501;
        bh=S+ptBClyQvqTPLvZgFl34sQO5hs8nfDxmaVbp3iNtt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t6U8vYJgigU1+NGns1yuARmMiNXoz6yZtGEGP4mIeLgRgbvnzEQzPzx8BjVg28RV+
         qRlAdCx+vhUq1TFEgGpfD0fsOYq+cZKH7AUmnZAfmrukOuzyTM7R5A/9C03t5AUDs0
         EnJl3K7THiQ12KGeEYUJaXQyRw/bqnyTz2SySQmX7D5BEbDvTOQG+wH708ZnbCe6yR
         eYkjTCkcjoPqxUGiCFNHz1j+h0/YLQ/p7tFI1jMk0V4lnT//Xx48FYSBfX+sat7mwi
         1XwLKea28vJtOCyPwqBL8eSE5UTixonnKBpmaOAlo3/v4swrxp5KX/Wds34jipjeNY
         +roDmhKgNcSfw==
Received: by mail-vs1-f45.google.com with SMTP id 66so2522613vse.4;
        Fri, 12 Aug 2022 19:58:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo2dQm1qKAcpvx3mMyAsDEGFkSdAI54z27mQElwt1gonNLphIIL6
        Gufr2XKh5M2udJhPu/sAJ/IPlPHQoxy1ur7j5F4=
X-Google-Smtp-Source: AA6agR621z8UmCKNvKEH07aD82KjSz+RoZz5UfOHXhJ6RkIgDmig1UHkK8QImoc4Y3clYfyPqUPL5qq5HxlH25yg1Jk=
X-Received: by 2002:a67:e288:0:b0:388:b41d:1654 with SMTP id
 g8-20020a67e288000000b00388b41d1654mr3044272vsf.70.1660359499868; Fri, 12 Aug
 2022 19:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220812072403.3075518-1-chenhuacai@loongson.cn> <CAHk-=wgopYkkZxSTCZGP783868VjoyGALMRst_nceA3aH-TW6Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgopYkkZxSTCZGP783868VjoyGALMRst_nceA3aH-TW6Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 13 Aug 2022 10:58:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5k-9L1tM4yu4uoNAEB=cadWw3x4OqnJ1eVbncAkMDjfw@mail.gmail.com>
Message-ID: <CAAhV-H5k-9L1tM4yu4uoNAEB=cadWw3x4OqnJ1eVbncAkMDjfw@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch changes for v5.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Linus,

On Sat, Aug 13, 2022 at 12:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Aug 12, 2022 at 12:24 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Note: There is a conflict in arch/loongarch/include/asm/irq.h but can
> > be fixed simply (just remove both lines from the irqchip tree and the
> > loongarch tree).
>
> Hmm. I don't see any conflict, so I assume there is something else in
> linux-next that I haven't yet gotten.
Yes, the conflict will happen when merge the irqchip-fixes tree.

Huacai
>
>              Linus
>
