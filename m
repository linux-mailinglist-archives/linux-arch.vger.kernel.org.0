Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F265A2FB4
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiHZTKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiHZTKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 15:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628F60FC
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661541030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUwRbO3uFlvDvYv65a559xQ/YfsqDnJwSlt3g7FFV/E=;
        b=SXkVLdyiRVV8ykkjUA6IyXNNR6+jz3U1/wbw7nbx9Lol+ZPF8KCm/KcDg3bc97ASYXKjig
        1YQQAVT/0V9nrbzJaxX/jG0/J5yIRd3cG/mxIZ5ztQwm3LCwtUpXCatLsixrEAEhbjDl34
        3v6I6iX9569Y0preZlYUHuAD3rm6/Q4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-mOrVSmcxM6esGkvF4B1KRQ-1; Fri, 26 Aug 2022 15:10:27 -0400
X-MC-Unique: mOrVSmcxM6esGkvF4B1KRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01AFE3815D34;
        Fri, 26 Aug 2022 19:10:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF299492C3B;
        Fri, 26 Aug 2022 19:10:25 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27QJAP4x003039;
        Fri, 26 Aug 2022 15:10:25 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27QJAPwr003035;
        Fri, 26 Aug 2022 15:10:25 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Aug 2022 15:10:25 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
In-Reply-To: <CAMj1kXHmXHKG4TXG+e7FgHCB2KKjmSeAdoAVR_bQTjb6NTVD4A@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2208261447400.32583@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <20220826112327.GA19774@willie-the-truck> <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2208261003590.27240@file01.intranet.prod.int.rdu2.redhat.com>
 <20220826174352.GA20386@willie-the-truck> <alpine.LRH.2.02.2208261424580.31963@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXHmXHKG4TXG+e7FgHCB2KKjmSeAdoAVR_bQTjb6NTVD4A@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, 26 Aug 2022, Ard Biesheuvel wrote:

> Could you try booting with earlycon?
> 
> Just 'earlycon' and if that does not help,

It doesn't help.

> 'earlycon=uart8250,mmio32,<uart PA>' [IIRC, mcbin uses 16550
> compatible UARTs, right?]

mcbin is the host system (running a stable kernel fine). The crash happens 
in a virtual machine. The vm uses /dev/ttyAMA0 as a console:

Serial: AMBA PL011 UART driver
9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 45, base_baud = 0) is a PL011 rev1
printk: console [ttyAMA0] enabled

I tried earlycon=pl011,mmio32,0x9000000 - but it doesn't help, it hangs 
without printing anything.

Mikulas

