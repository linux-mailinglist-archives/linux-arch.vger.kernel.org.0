Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A45A2E80
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiHZSbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiHZSbq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 14:31:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7772E1ABA;
        Fri, 26 Aug 2022 11:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C1761DC8;
        Fri, 26 Aug 2022 18:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B26C43470;
        Fri, 26 Aug 2022 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661538704;
        bh=0H01RklNGrPANMW+PptFqvWyKqPZuO1DsLzgvE1+ZRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=equV6IgP31VxjutZFVThpMqRhVWcMn3ZaTiDfghJ9CkjN0VLE/YyEM+/vLmK1ZUA5
         RndJdRwzm8aER7ImWDgg507EA0j6h/WrZuDuit3LxpP7vE0DDHcRAEWdcCbq83RATC
         9ATNsG3n63V6GslG6rbasAtEMIl7a+oY6QktdVPhVdwKJxx4c1NUoWCOCXwORgEDep
         LjTIpNKgUlE6XLgZcQZvf/Nps4bGKoGn7g0/Hn4oD8kpQJJA4vVBzzisNvcV/+m+dO
         TKGH9wjkG8N1RWgvLgrdkXXPX0XJ/wmXLDPgQZRuHDql6IJVvZhnRcBeh5QeVlld/q
         68l54dfdSazyw==
Received: by mail-wr1-f53.google.com with SMTP id bs25so2763715wrb.2;
        Fri, 26 Aug 2022 11:31:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo1MPprELN8L2FfDf5LFp6yucaSoBplWibuvrzV+V87Db5q1BfaB
        SndBsMKM53wZecHNGHFLQ37is7143BnjVUBaZPw=
X-Google-Smtp-Source: AA6agR7ObnkDMb8uSexWZlMD5F3llB3RlifIrpjHl1fXLMlaTnYkDOfF7gBtBmoEedimNc5izZWz67KkAzM8k53xQXo=
X-Received: by 2002:a05:6000:782:b0:225:3e46:3dd5 with SMTP id
 bu2-20020a056000078200b002253e463dd5mr477961wrb.103.1661538703104; Fri, 26
 Aug 2022 11:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <20220826112327.GA19774@willie-the-truck> <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208261003590.27240@file01.intranet.prod.int.rdu2.redhat.com>
 <20220826174352.GA20386@willie-the-truck> <alpine.LRH.2.02.2208261424580.31963@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208261424580.31963@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 Aug 2022 20:31:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHmXHKG4TXG+e7FgHCB2KKjmSeAdoAVR_bQTjb6NTVD4A@mail.gmail.com>
Message-ID: <CAMj1kXHmXHKG4TXG+e7FgHCB2KKjmSeAdoAVR_bQTjb6NTVD4A@mail.gmail.com>
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
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

On Fri, 26 Aug 2022 at 20:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Fri, 26 Aug 2022, Will Deacon wrote:
>
> > > So, the bad commit is aacd149b62382c63911060b8f64c1e3d89bd405a ("arm64:
> > > head: avoid relocating the kernel twice for KASLR").
> >
> > Thanks. Any chance you could give this a go, please?
> >
> > https://lore.kernel.org/r/20220826164800.2059148-1-ardb@kernel.org
> >
> > Will
>
> This doesn't help.
>

Could you try booting with earlycon?

Just 'earlycon' and if that does not help,
'earlycon=uart8250,mmio32,<uart PA>' [IIRC, mcbin uses 16550
compatible UARTs, right?]
