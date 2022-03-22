Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FD4E373E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 04:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiCVDIu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiCVDIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 23:08:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E9140F4;
        Mon, 21 Mar 2022 20:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF37EB81B41;
        Tue, 22 Mar 2022 03:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80126C340E8;
        Tue, 22 Mar 2022 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918440;
        bh=JbminCrwvlKeHI7BEmFEsF5mDATqt+IS8qjcZ0/Jt9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QXAmVA5wzyUI2A1gidTxf5+Lo6mDAbigvc7Oy0OmXaaB60pzd2ZM3RZzXh1ONfLiQ
         rcm70kJ/Ci2YoNfEesX6/y+NDr/MfTm7yzMJcVfqf5rppfBhzFhpYm3soqnr8vyEqY
         0T9J/oRiVAWY51zw2o99VDzbxSp85Gx2cfDifP5vWxNS/tMHx13Ea+2/y90cvg03l5
         6gAp8I2yarUR5IZlxfxhCsGvLMrXZeLHenIZlvc706Alb8DGCG8hGWzfBl0t1Me22X
         omXtfJopIWR+aXYBRHLZKCZK3ZkqQ73ONWYFzfcorVZgEMzViOXN3wifI1BFd32Ulv
         JiY+QggjG5riw==
Received: by mail-vs1-f41.google.com with SMTP id 2so9784745vse.4;
        Mon, 21 Mar 2022 20:07:20 -0700 (PDT)
X-Gm-Message-State: AOAM531aCzh68XRbmaPpJ+FEO+ZW9rMf/PBCYllqnCNNjpVHOJJ2ZfBK
        NApFte2jWFdiHEXUbfg/fIdhYsGJQiSR/jFfPkU=
X-Google-Smtp-Source: ABdhPJx4+oH0hOgpdvstgqFyVbmteIBIBzG7Uewe8HbwCzcGggSv3RFh+6z7krU1v8KMTHuDPkzMCzfD1G8XtTDEGEY=
X-Received: by 2002:a05:6102:2e5:b0:325:30d7:c452 with SMTP id
 j5-20020a05610202e500b0032530d7c452mr1451473vsj.67.1647918439548; Mon, 21 Mar
 2022 20:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-4-chenhuacai@loongson.cn>
 <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com>
In-Reply-To: <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Mar 2022 11:07:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7akp8RNyw=7qJPgWeApAzf0u4kBNbOHzgQN9Mx3PfzcQ@mail.gmail.com>
Message-ID: <CAAhV-H7akp8RNyw=7qJPgWeApAzf0u4kBNbOHzgQN9Mx3PfzcQ@mail.gmail.com>
Subject: Re: [PATCH V8 11/22] LoongArch: Add process management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Mar 21, 2022 at 4:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> > +#ifdef CONFIG_PAGE_SIZE_64KB
> > +#define THREAD_SIZE_ORDER (0)
> > +#endif
> > +
> > +#define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
> > +#define THREAD_MASK (THREAD_SIZE - 1UL)
> > +
>
> Having a 64KB stack area is rather wasteful. I think you should use a sub-page
> allocation in this configuration, or possibly disallow 64KB page configuration
> entirely.
>
> Note that you have to use full pages when using CONFIG_VMAP_STACK, but
> you don't seem to support that at the moment, so allocating only 16KB stacks
> on a 64KB page config should still work.
I think using a 16KB stack for all configurations (4KB/16KB/64KB) is
the simplest way. Right?

Huacai
>
>        Arnd
