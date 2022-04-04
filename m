Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020494F15E4
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352733AbiDDNcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352768AbiDDNcL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 09:32:11 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD7421839;
        Mon,  4 Apr 2022 06:30:15 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso5223142otj.5;
        Mon, 04 Apr 2022 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZellbTNVDmTMxAgtDVNk9zjzT/qb3sIv3YZKoTrbp+w=;
        b=1KfbxEDz38L5R9KdesZHkY5ynl/UX0AnY9Fyb+czL6Gbvf3vJ/l2ULBhZgg/uHwL4T
         aykgjcV25Ib2yaccgxUc4diqfj/MqbPGkkPEiPGHcE+4yBd9m7kyCEVeHvw2TGvmOEvq
         jBzRsZ90h/zHC8aeMlIfVceZPGzhILwdE9WK9YOGJCdeudOUDnxlW7OyQwT5Dby+qsBT
         SvY2q6wQZEw9y9/gSwlgQrlTanTDU4YlQLCSAHeRLCxxDgCCTxp9cRAstQABcd0vAbLQ
         V3ogOPtlBFtU5em14L0DYTLK0nyCIChIoUigZGOF2Ed3/8xfjbD/o3ColF1oOYXZeNxp
         gZiA==
X-Gm-Message-State: AOAM533cm4bpClOPyYrkfJGhw7j831GpmeTV/+J3+tdysiN0zhjNQYbj
        oRjkJBDz8uYZlUA+bJkiV6wmVyAvA0yotQ==
X-Google-Smtp-Source: ABdhPJwfzMcr7Vf5J9Ba+NiuXJokEEdlN7dIQtrMSP2AO/+MkLtbJL7dhYZeavgWHKEtMv4vV+iZUA==
X-Received: by 2002:a9d:1b68:0:b0:5c9:5da1:3752 with SMTP id l95-20020a9d1b68000000b005c95da13752mr5858otl.354.1649079014713;
        Mon, 04 Apr 2022 06:30:14 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm4144385oak.12.2022.04.04.06.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:30:14 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so7242708otj.1;
        Mon, 04 Apr 2022 06:30:14 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr20945994yba.393.1649078582711;
 Mon, 04 Apr 2022 06:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 15:22:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
Message-ID: <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, Apr 4, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
> > > If there are no other objections, I'll just queue this up for 5.18 in
> > > the asm-generic
> > > tree along with the nds32 removal.
> >
> > So it is the last day of te merge window and arch/h8300 is till there.
> > And checking nw the removal has also not made it to linux-next.  Looks
> > like it is so stale that even the removal gets ignored :(
>
> I was really hoping that someone else would at least comment.

Doh, I hadn't seen this patch before ;-)
Nevertheless, I do not have access to H8/300 hardware.

> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
> changes, but I think
>     Rich still cares about it and wants to add J32 support (with MMU)
> in the future

Yep, when the SH4 patents will have expired.
I believe that's planned for 2016 (Islamic calendar? ;-)

BTW, the unresponsiveness of the SH maintainers is also annoying.
Patches are sent to the list (sometimes multiple people are solving
the same recurring issue), but ignored.

Anyway, I do regular boot tests on SH4.

> 5. K210 was added in 2020. I assume you still want to keep it.

FTR, I do regular boot tests on K210.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
