Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3628659C5A0
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiHVSAz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHVSAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 14:00:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0C4620A
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 11:00:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 10so8969743iou.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Yy+VCdeRgyIswu0CubtFfhUCsZgH35AGFG4Ign730ws=;
        b=Mo+5ifl51BAeqfBpFxhVxm/AfNbeeoQ/9eB5mIIsoaF06OdGvL3SX6o5cyHpgQ3Qfo
         WG5wV//8QaYLWW+It1muL+YFBS8gqV99Ds2cAn92ukJ/uJ27xOI6q9/lfOx2PJ5jHPLK
         26tsZLwQ0HTIcDLjt/RpJbCVcnhkt1FY0i4Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Yy+VCdeRgyIswu0CubtFfhUCsZgH35AGFG4Ign730ws=;
        b=4tmYFJ+gYIUPdZUiyMF5PzwiKo5OzckYKVsqvNsYqBAxIoOlP4ECAiTe1GDp0A5y+Z
         k5STSmixc61Wi5s8rcSJ8nzD1R9VEZ2C0h6cdx/euorz37m2sLckQSyUbvRLJetMqbHF
         2Frr7Rpl5H0elc0uOoJoRgfQFSnvCR+2zgbI9GwlxeypFgYIicJz+ANkdSfYA4RpKLa0
         m3wjpb6IIzdoMmKGpby2v8MRKQDMw6PcVoN0F/QXts3yzFq2IL2PP8Zvc1Z/xHhkwLBc
         9MORAhTpUN0NOL20rByhfp9Joua+AqjzeVIX1PeG21nRv9UZbyfLU/7ZYForRDOUZLLL
         pTqg==
X-Gm-Message-State: ACgBeo3jmgoXrP5jDYLLeiTmJ9krROxdpzFmjyipNyqnaJ05GYkpMj69
        XPX9W/ns53XooaKDsrkNPhe6shbZ+7RPc0z12FHLIQ==
X-Google-Smtp-Source: AA6agR4PiAg9W3J1Kjke4ZDulydfcB5kDGfFIWEbvF6a+CadWvvy79fC0sF+MDSVFsweS5N3LvlJoANsx/yaGdmPsGU=
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr9087348iol.201.1661191252848; Mon, 22
 Aug 2022 11:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
In-Reply-To: <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 22 Aug 2022 14:00:41 -0400
Message-ID: <CAEXW_YTtQNTLEj9wz9ETt=6USLYO2yrJcSZ-mkiVVHj7y6Z12g@mail.gmail.com>
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 22, 2022 at 1:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Aug 22, 2022 at 10:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So why don't we just create a "test_bit_acquire()" and be done with
> > it? We literally created clear_bit_unlock() for the opposite reason,
> > and your comments about the new barrier hack even point to it.
>
> Here's a patch that is
>
>  (a) almost entirely untested (I checked that one single case builds
> and seems to generate the expected code)
>
>  (b) needs some more loving
>
> but seems to superficially work.
>
> At a minimum this needs to be split into two (so the bitop and the
> wait_on_bit parts split up), and that whole placement of
> <asm/barrier.h> and generic_bit_test_acquire() need at least some
> thinking about, but on the whole it seems reasonable.
>
> For example, it would make more sense to have this in
> <asm-generic/bitops/lock.h>, but not all architectures include that,
> and some do their own version. I didn't want to mess with
> architecture-specific headers, so this illogically just uses
> generic-non-atomic.h.
>
> Maybe just put it in <linux/bitops.h> directly?
>
> So I'm not at all claiming that this is a great patch. It definitely
> needs more work, and a lot more testing.
>
> But I think this is at least the right _direction_ to take here.
>
> And yes, I think it also would have been better if
> "clear_bit_unlock()" would have been called "clear_bit_release()", and
> we'd have more consistent naming with our ordered atomics. But it's
> probably not worth changing.

Also, as a suggestion to Mikulas or whoever works on this - update the
ORDERING section of Documentation/atomic_bitops.txt too?

Thanks,

 - Joel
