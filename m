Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556EE586181
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jul 2022 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiGaU5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaU5n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 16:57:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F97DEA6
        for <linux-arch@vger.kernel.org>; Sun, 31 Jul 2022 13:57:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so3779168edi.8
        for <linux-arch@vger.kernel.org>; Sun, 31 Jul 2022 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D1fnuTWJXlc2dukCsRsC5YQz2zD6ofMDDxPYK2SWWv4=;
        b=d4o7e56v6jaT/H39UmhsDACmb3MPAMvJJPhLDSCiN2LHVwivDQ648MIwKHekYwgCeK
         yNYv4J6/pOe8JmTVWy1w2wnXmQagkxahHOq+/eIYdSbqC1T6I7bBJiwyd+hqGrvUgq4Q
         pLQG2n9c3fDKVgK0znE3hVIfiq3PTKLVMybfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D1fnuTWJXlc2dukCsRsC5YQz2zD6ofMDDxPYK2SWWv4=;
        b=MymoyxKr9UMwSjg7gaZOLtVZiAK1r8eJYubGq9bfZiq2uwBX0dZ3Ugp48GD7JWlbC4
         GOadn6U20wabJ5NeYMv8hytJpQroDzOkkDBB67EET1+1mjz7asNp/UmX/wYXOa4Y21dE
         enFWbrAaZpZxUGNy3+i0T7tpcTPModoOJuWEXdROow0ADXRpTqwvr0R5r+v4FGn8W8HK
         T09fXjkV9oHiLalgAVRTs/hbpC820duDyxXLGOYxZmmKOb9Y6RYDp8hSRs9euAtGaOcJ
         WXtkNzDJWPp9gftbdRU+A2zkpFpK6ozIwyXugBs6UiSv0V3UR+4G+NANHdbiFnJA0xBZ
         mYmA==
X-Gm-Message-State: ACgBeo1PkmXMbPP04x51VcX8KtkFD1l6MdwF6UBNDklmdLVwJsTlTWxX
        mervG+/C4qPsb94cYLgB0Out1hDD59L52dVQ4bE=
X-Google-Smtp-Source: AA6agR64Ri4WWlezqKIdNm0J7Rv2rM1SDUBO7lAu4d9o5+Sdic8kLX28JGiwMixobTF84Q4wus1G+A==
X-Received: by 2002:a05:6402:438d:b0:43d:b383:660f with SMTP id o13-20020a056402438d00b0043db383660fmr515222edc.283.1659301061124;
        Sun, 31 Jul 2022 13:57:41 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b00704fa2748ffsm2648509ejf.99.2022.07.31.13.57.40
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 13:57:40 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso5494268wmq.1
        for <linux-arch@vger.kernel.org>; Sun, 31 Jul 2022 13:57:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr9272114wmq.154.1659300698214; Sun, 31
 Jul 2022 13:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 13:51:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmO0aWk_X5nKWEmquQ9VDzauKRW4oK4++0HNFgGo9Rvw@mail.gmail.com>
Message-ID: <CAHk-=wjmO0aWk_X5nKWEmquQ9VDzauKRW4oK4++0HNFgGo9Rvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] make buffer_locked provide an acquire semantics
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 31, 2022 at 1:43 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> +
> +static __always_inline int buffer_locked(const struct buffer_head *bh)
> +{
> +       unsigned long state = smp_load_acquire(&bh->b_state);
> +       return test_bit(BH_Lock, &state);

This should not use 'test_bit()'. I suspect that generates horrendous
code, because it's a volatile access, so now you'll load it into a
register, and I suspect it will generate s pointless spill just to do
a volatile load.

I didn't check.

So once you've loaded b_state, just test the bit directly with

    return (state & (1u << BH_Lock)) != 0;

or whatever.

              Linus
