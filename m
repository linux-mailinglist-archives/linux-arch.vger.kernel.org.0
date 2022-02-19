Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509F4BCA80
	for <lists+linux-arch@lfdr.de>; Sat, 19 Feb 2022 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiBSTo4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Feb 2022 14:44:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbiBSToy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Feb 2022 14:44:54 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771A2AFB
        for <linux-arch@vger.kernel.org>; Sat, 19 Feb 2022 11:44:34 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r20so9021328ljj.1
        for <linux-arch@vger.kernel.org>; Sat, 19 Feb 2022 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4ygKhiha2w81mFp35k6HnVjHKstOlRMTFzZECx5vNI=;
        b=IktfDu44u+ZBl7LXYDdB+a4/t3sJFwoE1XPrU/66Ycjh4yBQThK8AY0I9nF2x7mRfJ
         7ehEkTXyo+K+zTpxWBDQcwwSqhWOm5RZHCY8jVEOzsREVE1R98JQ6N0Bj15ypu6sDJo/
         3MfjVwgbHq1gnZyw+w+W9mbImVk/mdRpQ/boJJJcZdb+fBHVdE0oKz4qDneKXI9f1R22
         JPlKnRQgzz5uTnajaxAP5fWGvqpwod2J71yzuQuAQRI0Gy7MOGW0SXr6kd1DCAk+rscY
         EO5fWumULKHNX7qK6V37lohxL5eZQoiVmzz0hxx1jXWCUPEGvF+hqm/gmzx9lnGq0jvt
         b+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4ygKhiha2w81mFp35k6HnVjHKstOlRMTFzZECx5vNI=;
        b=K5dxRyu3boWE0VNFOMaB/iIpAMumr8utv/eHz9k3uQyYyjIwj5Uas0exci8Lp1Ws90
         auD2dPVBzhfzZPKHKM/YRvJr2/j+geqxdHM5wOMS7UGe5AzP1Gf2HnmdU0JpgM56+2wj
         DQzeJD2Nbm0RITgeQHXTLSm/y7ZscrQhAMULFmkjzruAz6gk/VQf8YRDYXAxE0haAvDW
         ECq1mctsYak6ErYSozaL8KVd5/h5D6tjDTYCgHMk8q12/HfUkAF5LHJWmUk57s9uGPP+
         1/wbYsQCRYEJ046eTx9LsweDa4nh6bDXVv/0gC/B1RWRADfrYi3VLuQ41fNTLcFnUXzH
         ZoWg==
X-Gm-Message-State: AOAM531DFGbXBc0VhisVLSZisFt2KDFT9msBUV45wMCB8dVVxJv7Rgyx
        gFK4Sy8lFc9g7cyks0HHal2l4gtdVlSeCsYrDaPjHA==
X-Google-Smtp-Source: ABdhPJxxbPRQYl9gtrGRBmlOTi1cGA+dTg5STBR/j2psBl+nfqXJtsxZy72mbaNbt4sKH4N5zfjGKQfW1PmLiBuNWmo=
X-Received: by 2002:a05:651c:1509:b0:241:8db:ca24 with SMTP id
 e9-20020a05651c150900b0024108dbca24mr9567535ljf.347.1645299872364; Sat, 19
 Feb 2022 11:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-2-jakobkoschel@gmail.com>
In-Reply-To: <20220217184829.1991035-2-jakobkoschel@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 19 Feb 2022 20:44:04 +0100
Message-ID: <CAG48ez2fcxaESyXiB=+KMWy=JV3KH_2G78bTQEnzRSbYqg-zZw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/13] list: introduce speculative safe list_for_each_entry()
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 7:48 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
> list_for_each_entry() selects either the correct value (pos) or a safe
> value for the additional mispredicted iteration (NULL) for the list
> iterator.
> list_for_each_entry() calls select_nospec(), which performs
> a branch-less select.
>
> On x86, this select is performed via a cmov. Otherwise, it's performed
> via various shift/mask/etc. operations.
[...]
>  #define list_for_each_entry(pos, head, member)                         \
>         for (pos = list_first_entry(head, typeof(*pos), member);        \
> -            !list_entry_is_head(pos, head, member);                    \
> +           ({ bool _cond = !list_entry_is_head(pos, head, member);     \
> +            pos = select_nospec(_cond, pos, NULL); _cond; }); \
>              pos = list_next_entry(pos, member))

Actually I do have one ugly question about this:

Is NULL a good/safe choice here?

We already know that CPUs try very aggressively to do store-to-load
forwarding. Until now, my mental model of store-to-load forwarding was
basically: "The CPU has to guess whether the linear addresses will be
the same, and once it knows the linear addresses, it can verify
whether that guess was correct."

But of course that can't really be the whole mechanism, because many
architectures guarantee that if you access the same physical page
through multiple linear addresses, everything stays coherent. So I'm
wondering: Are there basically two stages of speculation based on
address guesses? A first stage where the CPU guesses whether the
linear addresses are the same, and a second stage where it assumes
that different linear addresses also map to different physical
addresses, or something like that?

And so, if we don't have a TLB entry for NULL, and we misspeculate
through a speculative write to an object of type A at NULL and then a
speculative read (at the same offset) from an object of type B at
NULL, will we get speculative type confusion through the nonexistent
object at NULL that lasts until either the branches are resolved or
the page walk for NULL reports back that there is no page at NULL?

(Also, it's been known for a long time that speculative accesses to
NULL can be a performance problem, too:
https://lwn.net/Articles/444336/)

So I'm wondering whether, on 64-bit architectures that have canonical
address bits, it would be safer and also reduce the amount of useless
pagetable walks to try to butcher up the canonical bits of the address
somehow so that the CPU can quickly see that the access is bogus,
without potentially having to do a pagetable walk first.
