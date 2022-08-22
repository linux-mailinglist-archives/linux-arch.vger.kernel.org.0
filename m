Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49059C4B9
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiHVRKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiHVRJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 13:09:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97543E6C
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 10:09:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so13840112ejt.6
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FBSmStkotiGF5Og7ExawLkOys7P/24UjQfsLmwYIr/M=;
        b=a1uslqfzoUrzXGd0AtZpa/7qVFuOyaBocH8utbCHMh+IkSOo3bi2iA+PM0xZRNUJXv
         t1cspoXmBEBzEkIS9Wllb9Qh/U1c5tYnnJ4nHm80ZZthOK6BkFbBx1u7VhL2Ep9q2HGo
         sz1FnS+mb8UOtjAbiizHgEwMu4Gfjzk0Cl1cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FBSmStkotiGF5Og7ExawLkOys7P/24UjQfsLmwYIr/M=;
        b=HWWA7HbJ5fkuS7E78+kCVZtsFnJTX7cjvY45/9BXFLKN4NPK3seDm5ApDsAJO++Ixx
         J0+Hq4OQaplok3Qmmu1iJarKYOe5RN3Df5+nd8d/HqvXrRF/jhJ/jCaRVaC0VgmShUjy
         VEWSe6FTXJmVzNPDJUmVf3UkPb1bNYLMZW3aICP8HhoBMjQbPVxThMkoxgEqmyAd4KlO
         REFFzt6gi4LNLrjQ25CXcNIYLVO6GT6rJLCXEI/b2RdLTzcujZVPJrOdkM7Y/0pBm7eq
         BC8dokseWFjaGLEAxoEdAseD75QodYKQ+ZY5HqVDUz/jg8yG2ZwkBfcHAVHkkFX11AXM
         cpuA==
X-Gm-Message-State: ACgBeo1ytDXSX1NRjA1D9FIKfj08B/9n/s7b8pa5YOAgL7OEaeQJjlhu
        1UJE6Kv/5S/hS+oEpiQIbONw3uRHNAK9+6zh
X-Google-Smtp-Source: AA6agR7Ku5Gwg7VjbJSbOvq0y6Ewlxsy3w6aAmKcWwUGpXsYHhoM5rBogYqxsg+HeiE1UyIkrrvXOw==
X-Received: by 2002:a17:906:eec7:b0:733:189f:b07a with SMTP id wu7-20020a170906eec700b00733189fb07amr13723714ejb.230.1661188146430;
        Mon, 22 Aug 2022 10:09:06 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id d6-20020a50fb06000000b0043a5bcf80a2sm6294edq.60.2022.08.22.10.09.05
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:09:05 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so5082119wmk.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 10:09:05 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr15334285wmm.68.1661188144843; Mon, 22
 Aug 2022 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Aug 2022 10:08:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
Message-ID: <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
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

On Mon, Aug 22, 2022 at 2:39 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I'd like to ask what do you think about this patch?

I really don't like it. It adds a pointless read barrier only because
you didn't want to do it properly.

On x86, it doesn't matter, since rmb is a no-op and only a scheduling
barrier (and not noticeable in this case anyway).

On other architectures, it might.

But on all architectures it's just ugly.

I suggested in an earlier thread that you just do it right with an
explicit smp_load_acquire() and a manual bit test.

So why don't we just create a "test_bit_acquire()" and be done with
it? We literally created clear_bit_unlock() for the opposite reason,
and your comments about the new barrier hack even point to it.

Why is "clear_bit_unlock()" worthy of a real helper, but
"test_bit_acquire()" is not and people who want it have to use this
horrendous hack?

Please stop adding random barriers already. Just do it right. I've
said this before, why do you then keep doing this and asking for
comments?

My reply will remain the same: JUST DO IT RIGHT.

                Linus
