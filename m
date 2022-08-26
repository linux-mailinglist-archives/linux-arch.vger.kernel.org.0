Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098DD5A2CB7
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbiHZQrp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbiHZQrG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 12:47:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB64DB43
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 09:46:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w20so2775582edd.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AzcQtJHhCq1M9HHqJyBU8jps37qkhWyg9JcbI9atrX0=;
        b=clP+YjSRMv2aMSc6s6pfkGuBwb18hbcN4LMP8FIL90suqd9UEviO5jlvsEMFMhPKrc
         SvpI9lj7ObC223xski6/wogooTIqPf19hTqQu36LKAy8yovElPte2v6C7NYnhvAG9OvP
         Zljm4DmKwu9XwUkI6wpFhtr1vIBosEYEvZ//0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AzcQtJHhCq1M9HHqJyBU8jps37qkhWyg9JcbI9atrX0=;
        b=eDOyH/1j2cNBohqG6e1bR72U4G3AmAGHyqnhCWH7mNDzhGDdoGkPT+jElQvYLxEsDw
         +8KzUhVzGivtDmVAOzW1SHXNv/AsX+hQ1/4+D055zMFPyrQzAyEmpaz1jc66+tRnXf15
         8EBzATY3NnkD7JtwF0V39PG9B21C83XobF8KrFLlGBnyZH88VPhXSyzwS7yRASgFgo5G
         3ZQ0R9Ofd1JrLZB03o5J73MUJExTsaGHHbpBu7rVERqa2sWmmIBuJvvN/msaMNJQxlJC
         7JRHLuz1zZEmOXoABIk9g4m2Ctld75WL/A5bnyFk/cExPzqXw0hMziNwkvlYLlq8REii
         rwVA==
X-Gm-Message-State: ACgBeo2oQMTiwii0U6KRR07xIC8d0/7dgemQtcpL8HswMxi4RWU5GWfd
        o5C/Yk1DpaPYSo8I29vvh79dCylqIA0tG8X1xQM=
X-Google-Smtp-Source: AA6agR7zzKzumfPdcGO3pLLERaUPHBYqifKA3rkgD4dXzLVJ+/nSv17Q8buTqHG3GcwNf0N0EDOtyg==
X-Received: by 2002:a05:6402:100c:b0:447:9153:8fdf with SMTP id c12-20020a056402100c00b0044791538fdfmr7480903edu.187.1661532366168;
        Fri, 26 Aug 2022 09:46:06 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906309200b0073d65a95161sm1053136ejv.222.2022.08.26.09.46.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 09:46:04 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id z16so2447426wrh.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 09:46:04 -0700 (PDT)
X-Received: by 2002:a05:6000:136f:b0:225:2fad:dde7 with SMTP id
 q15-20020a056000136f00b002252faddde7mr311126wrz.274.1661532364193; Fri, 26
 Aug 2022 09:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com> <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 09:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDeF2V7fiBEUUHHmUK8AZKq+b+=wwaMWbJ0WP+8GNvUw@mail.gmail.com>
Message-ID: <CAHk-=wjDeF2V7fiBEUUHHmUK8AZKq+b+=wwaMWbJ0WP+8GNvUw@mail.gmail.com>
Subject: Re: [PATCH v3] wait_on_bit: add an acquire memory barrier
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 6:17 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I wouldn't do this for regular test_bit because if you read memory with
> different size/alignment from what you wrote, various CPUs suffer from
> store->load forwarding penalties.

All of the half-way modern CPU's do ok with store->load forwarding as
long as the load is fully contained in the store, so I suspect the
'testb' model is pretty much universally better than loading a word
into a register and testing it there.

So narrowing the load is fine (but you generally never want to narrow
a *store*, because that results in huge problems with subsequent wider
loads).

But it's not a huge deal, and this way if somebody actually runs the
numbers and does any comparisons, we have both versions, and if the
'testb' is better, we can just rename the x86
constant_test_bit_acquire() to just constant_test_bit() and use it for
both cases.

> But for test_bit_acqure this optimization is likely harmless because the
> bit will not be tested a few instructions after writing it.

Note that if we really do that, then we've already lost because of the
volatile access, ie if we cared about a "write bit, test bit" pattern,
we should use other operations.

Now, the new "const_test_bit()" logic (commits bb7379bfa680 "bitops:
define const_*() versions of the non-atomics" and 0e862838f290
"bitops: unify non-atomic bitops prototypes across architectures")
means that as long as you are setting and testing a bit in a local
variable, it gets elided entirely. But in general use you're going to
see that load from memory, and then the wider load is likely worse
(because bigger constants, and because it requries a register).

So maybe there is room to tweak it further, but this version of the
patch looks good to me, and I've applied it.

Thanks,
                Linus
