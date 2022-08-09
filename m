Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7B58E2B2
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 00:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiHIWJq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiHIWIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 18:08:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57227B06
        for <linux-arch@vger.kernel.org>; Tue,  9 Aug 2022 15:06:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s11so16768042edd.13
        for <linux-arch@vger.kernel.org>; Tue, 09 Aug 2022 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1VsFqqcFXS3n/9+2goZhST4QJC7Ug49yVOYAb2PF94c=;
        b=g2oKOWygAqs06kX5yZw9/NAo7v0Zm7bWI2z8kj3BN5Dj/ubZ2QDeilkkWtUk2RqnEi
         hCByUhB0cGj/zaxF286P463nEiuoqSY2NIrqaf4TqFohK7JVfsZncQBKsB+C8/dWd6Ut
         /p2j7+iJhaHzQ2HabVc05AxIr7TdReAYHEL/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1VsFqqcFXS3n/9+2goZhST4QJC7Ug49yVOYAb2PF94c=;
        b=5qP/1hZqLg2OJ813U8wj28wYmDY1caF758dmlh5XIJBTxRW6IwQPyHT5dNYvzeZRzz
         pi6Yq8FeNNhbftRN/mZRl6IFp+Jl7EDRZCP3RiQpMy/1ImEzagav388Pq2PNewVL4pkO
         IoqTRnqjG3OFvut3QirakN5cJZ42BYo94pQKWXZIflDETaZVv45DlxkzKsxNc6Yx2Q7h
         f+/c3lYN9t5gDEcBZF020EyekEmFpEMbHdWtTorQHer3rMI4vldtmQID0Vdq8gaqOjEd
         QpeRO3IVsNkNPqwBM8kx+qxlZZ7gNVb7ddVpwaBE/PFidxXnugEllr80iwjq4Vmwv3ea
         bfEw==
X-Gm-Message-State: ACgBeo2s9D6Ngpu8f7TG6MlPECX207k8kcCwLYXUpoPuAD3I9J2v3OQc
        Q/eQ0V5Z7DTyg86H2C/7VCvjdI+MALkrflmXFac=
X-Google-Smtp-Source: AA6agR7lHdt8eVqFjtP8b2DHkwy99HKaE3XiRcG+zyhmF4MfpDPV9vzGKhc/u4eKHA1tG+FwIG+wuw==
X-Received: by 2002:a05:6402:b85:b0:43c:f8e8:96ba with SMTP id cf5-20020a0564020b8500b0043cf8e896bamr24222049edb.183.1660082804834;
        Tue, 09 Aug 2022 15:06:44 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id d16-20020a50fe90000000b0043b986751a7sm6599041edt.41.2022.08.09.15.06.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 15:06:42 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso116962wmq.3
        for <linux-arch@vger.kernel.org>; Tue, 09 Aug 2022 15:06:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr283826wms.8.1660082801459; Tue, 09 Aug
 2022 15:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <YuflGG60pHiXp2z/@casper.infradead.org> <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org> <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
 <Yu/RJtoJPhkWXIdP@casper.infradead.org> <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEgZuSdv8XHtkJg@casper.infradead.org> <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEuIg3669UeSwjD@casper.infradead.org> <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 15:06:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiivNAj+jdXUdo91PQgh__vtE3WCFgufV0yVu7mWAKQWg@mail.gmail.com>
Message-ID: <CAHk-=wiivNAj+jdXUdo91PQgh__vtE3WCFgufV0yVu7mWAKQWg@mail.gmail.com>
Subject: Re: [PATCH v6] add barriers to buffer_uptodate and set_buffer_uptodate
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 9, 2022 at 11:32 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Let's have a look at this piece of code in __bread_slow:
>         get_bh(bh);
>         bh->b_end_io = end_buffer_read_sync;
>         submit_bh(REQ_OP_READ, 0, bh);
>         wait_on_buffer(bh);
>         if (buffer_uptodate(bh))
>                 return bh;
> Neither wait_on_buffer nor buffer_uptodate contain any memory barrier.
> Consequently, if someone calls sb_bread and then reads the buffer data,
> the read of buffer data may be executed before wait_on_buffer(bh) on
> architectures with weak memory ordering and it may return invalid data.
>
> Fix this bug by adding a memory barrier to set_buffer_uptodate and an
> acquire barrier to buffer_uptodate (in a similar way as
> folio_test_uptodate and folio_mark_uptodate).

Ok, I've applied this to my tree.

I still feel that we should probably take a long look at having the
proper "acquire/release" uses everywhere for the buffer / page / folio
flags, but that wouldn't really work for backporting to stable, so I
think that's a "future fixes/cleanup" thing.

Thanks,
              Linus
