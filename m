Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939125A2D51
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiHZRUR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbiHZRUP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 13:20:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DE37FB1
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 10:20:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u6so2872957eda.12
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=It4+5CS+UNBeAwCRSjUort6xAl6L4rhn+tviYQlJwV4=;
        b=bvVWbRsktC7uen3WmN2PR8rG2BVOvL443OYu0EBa6/QF6kvq+eoPJi12hOyXu1k5h9
         WeXhFzxlOqfnkM1hvvIC3iy16tiosu1od8Wr8f1gSgK7zWcNTVRdhNeujpHzZWDPu+rU
         aEJwvLB6HBpWriiIAr0rAJNsmgfaLDjBiRt94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=It4+5CS+UNBeAwCRSjUort6xAl6L4rhn+tviYQlJwV4=;
        b=5d1yOIkRTcpop0CZ8JJCXuLRWaj96Apyajy6tuA18xcyYqPT9ZtPqo7mA8rk3gauK3
         /CtKhHsvF85Ok5fS566b/rkG2OsVCsHgFABtgnHpzbKs6ZOoTR9MiNk4A/NWliTOm91Z
         znNghCw/hq8cIN9vwVRL5NdLFE7sqY6nNX54VjfxRkdvsKBKtSxdAyw4UyayxEeg6H9x
         h5QyWS4Ya/iVWR7H0UPum3D/OiKcYO2wrWV28WdT7ASnKLckJzWbHecdsCxuDACEPEvO
         MQe+scj8zepFToU4fKio/kRlYAXC3PQSKcSA/WaVcnVVM6OcsgUIyPWLBmRFViWlZA1Q
         kRpg==
X-Gm-Message-State: ACgBeo1MrGTagSoGw+UG48jEvwFNHX0KbFskix9BO4ESx8tC1+h5Kiva
        FwHNVuKJP/r0u9PX1aSbUhCac8Dc5kES8fkKG9s=
X-Google-Smtp-Source: AA6agR6Nxc0SVEVJpZ5cUJuOHslNun1/dgKkLrZWLDYluueTmzoNv+QeeoiPJEbFos8O94qU5pv9gw==
X-Received: by 2002:a05:6402:430d:b0:446:e72e:d446 with SMTP id m13-20020a056402430d00b00446e72ed446mr7695512edc.69.1661534411925;
        Fri, 26 Aug 2022 10:20:11 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090609b200b0073ddff7e432sm1161686eje.14.2022.08.26.10.20.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:20:11 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id e20so2533122wri.13
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 10:20:10 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr354955wrp.281.1661534410125; Fri, 26
 Aug 2022 10:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjDeF2V7fiBEUUHHmUK8AZKq+b+=wwaMWbJ0WP+8GNvUw@mail.gmail.com>
In-Reply-To: <CAHk-=wjDeF2V7fiBEUUHHmUK8AZKq+b+=wwaMWbJ0WP+8GNvUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 10:19:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdVsunbZNq39nv4dbcXiro3fzpt-v2TGV_nR0DUsUCLw@mail.gmail.com>
Message-ID: <CAHk-=wjdVsunbZNq39nv4dbcXiro3fzpt-v2TGV_nR0DUsUCLw@mail.gmail.com>
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

On Fri, Aug 26, 2022 at 9:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So narrowing the load is fine (but you generally never want to narrow
> a *store*, because that results in huge problems with subsequent wider
> loads).

.. so making that statement made me go look around, and it's exactly
what we use for clear_bit() on x86.

Which is actually ok too, because it's a locked operation, and at that
point the whole "store buffer forwarding" issue pretty much goes out
the window anyway.

But because I looked at where the new test_bit_acquire() triggers and
where there are other bitops around it, I found this beauty in
fs/buffer.c: clean_bdev_aliases():

                                if (!buffer_mapped(bh) ||
(bh->b_blocknr < block))
                                        goto next;
                                if (bh->b_blocknr >= block + len)
                                        break;
                                clear_buffer_dirty(bh);
                                wait_on_buffer(bh);
                                clear_buffer_req(bh);

where it basically works on four different bits (buffer_mapped, dirty,
lock, req) right next to each other.

That code sequence really doesn't matter, but it was interesting
seeing the generated code. Not pretty, but the ugliest part was
actually how the might_sleep() calls in those helper functions result
in __cond_resched() when PREEMPT_VOLUNTARY is on, and how horrid that
is for register allocation.

And in bh_submit_read() we have another ugly thing:

        mov    (%rdi),%rax
        test   $0x4,%al
        je     <bh_submit_read+0x7d>
        push   %rbx
        mov    %rdi,%rbx
        testb  $0x1,(%rdi)

where we have a mix of those two kinds of "test_bit()" (and test
"testb" version most definitely looks better. But that's due to the
source code being

        BUG_ON(!buffer_locked(bh));
        if (buffer_uptodate(bh)) {

ie we have that *ancient* BUG_ON() messing things up. Oh well.

None of the buffer-head code matters any more, bit it's certainly
showing the effects of that patch of yours, and the code isn't pretty.

But none of the ugliness I found was actually _due_ to your patch. It
was all due to other things, and your patch just makes code generation
better in the cases I looked at.

             Linus
