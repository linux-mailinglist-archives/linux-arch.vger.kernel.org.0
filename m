Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F715A350E
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiH0GdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 02:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiH0GdB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 02:33:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE8DD763;
        Fri, 26 Aug 2022 23:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B002B82851;
        Sat, 27 Aug 2022 06:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D65C43140;
        Sat, 27 Aug 2022 06:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661581977;
        bh=qmU3paAtykBex7YGKV/aqzGRIkXBQc960SgD6HR6SY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YEHT/bli5qd1ay+q9HVMBR0oI+9PoTqAAy0yM6hF5kclq8yMNW/F4uefUyffak5sU
         ypg6p/CyD+jGLvDXIl5lg1S4Z/zONnl3Y7YAGB3qMP/Iw4x8Ox2h2AOkN67BmRhHzu
         tN9veLAeutSoousW4F7HKg+Svsh5BuwXeKKqkLZEkMWnAu531Qd+pBLVcSSFovwk0P
         nMKpkmOIe1mUWEDDWhjZRMFR0vR3TiafeqjCcIc0LKpkuXW/cPMfeQcKslxyRg4F2u
         hIU2Q9mIk45VNGJQrbT1bTD+YihVieLVcv4MgbZyiQDQMBFj61NDFPQ/VmvUJLpQcf
         992piLBHt21yA==
Received: by mail-wm1-f41.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso1827828wmr.3;
        Fri, 26 Aug 2022 23:32:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo1V1PsYdOVpo6tTIFD6vlUWzmJC6Q0tKeFxL+abwM4s//APZ5A3
        Q8ULSoX6tqoorScAuddTP69pyOib4DenjHbS8ic=
X-Google-Smtp-Source: AA6agR4he6zsNcQiJrvVUUEahEtSHtY6xyW/86rJ3vJuW45ByDRjY2ilU7UTEpf5R0bj+rVl2HMTawK+DUNyZiAZmwY=
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id
 s15-20020a05600c384f00b003a6603c4338mr1504042wmr.192.1661581976098; Fri, 26
 Aug 2022 23:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <20220826112327.GA19774@willie-the-truck> <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208261003590.27240@file01.intranet.prod.int.rdu2.redhat.com>
 <20220826174352.GA20386@willie-the-truck> <alpine.LRH.2.02.2208261424580.31963@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXHmXHKG4TXG+e7FgHCB2KKjmSeAdoAVR_bQTjb6NTVD4A@mail.gmail.com> <alpine.LRH.2.02.2208261447400.32583@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208261447400.32583@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Aug 2022 08:32:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEqF_wKibwvdXVzjBfLrTJpXquNLOyuQVrbF+ZyNvLDaA@mail.gmail.com>
Message-ID: <CAMj1kXEqF_wKibwvdXVzjBfLrTJpXquNLOyuQVrbF+ZyNvLDaA@mail.gmail.com>
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

On Fri, 26 Aug 2022 at 21:10, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Fri, 26 Aug 2022, Ard Biesheuvel wrote:
>
> > Could you try booting with earlycon?
> >
> > Just 'earlycon' and if that does not help,
>
> It doesn't help.
>
> > 'earlycon=uart8250,mmio32,<uart PA>' [IIRC, mcbin uses 16550
> > compatible UARTs, right?]
>
> mcbin is the host system (running a stable kernel fine). The crash happens
> in a virtual machine. The vm uses /dev/ttyAMA0 as a console:
>
> Serial: AMBA PL011 UART driver
> 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 45, base_baud = 0) is a PL011 rev1
> printk: console [ttyAMA0] enabled
>
> I tried earlycon=pl011,mmio32,0x9000000 - but it doesn't help, it hangs
> without printing anything.
>

If you are using pl011, you should drop the mmio32 - it only takes a
physical address (and optionally baud rate etc, but QEMU doesn't need
those)
