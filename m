Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE44C1D0F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 21:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiBWUW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbiBWUW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:22:58 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1227D4D266
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:22:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m14so277661lfu.4
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3H2+NYtTtjeGTQYVonE+hBzT55dUXsQnd/qXFVfW9U=;
        b=FJYeflWGBh0cbxz8hlGeGMD3+L4e4hFc/0jlzVwyFG+y4B4WF9+QCmtYl7JL34CB+2
         mXfO6w03DriGF514W5BCsF8o5mGA/NKs5uDMPQr+h6Wo6xHSlepZe0EdBcXyGBiW1XrG
         id6hqr0iWW0az6wyMpunwbHhqvhKopWPc3twU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3H2+NYtTtjeGTQYVonE+hBzT55dUXsQnd/qXFVfW9U=;
        b=BU8XHHNu60PvwwjlZQj6b29LVn0lUu6kmN+IK5uz5oQAbGHM1NbubMKlw/kizIlyWT
         74keQGh0/CY7JgztB75D3W3+FxKwCeIPJNaUAjZmeH62wYtg3wYxZ/pCFpRtedYPqOHy
         +ZJe3Rh5Oa4PFDriK7xuZb6Wo1+8FWE0e5kesgpsbVqvbGAFmkU/DykH3Rd8osOqoLPv
         khsRF8SsRTwGkrP2NbIws6/df6sXWvhcAJq2s6W86petgyAmXbVFT6TDVvPtniEAflYJ
         ee6Ie1HezLL9G2cdtKzSpD+4WvpWWOMzY06zTJzbiOBdwM379NYZhstPbvf/jvyfaKsg
         GaYg==
X-Gm-Message-State: AOAM531iBua5w3spcGmDMD0iIrTibvFY3wRGNjOSAM8WrlBMIbPPQdv+
        ex9hZttElmrmT/qBahkXhpRxg0sQ+CvyX/S+CZw=
X-Google-Smtp-Source: ABdhPJxXkQrZdgQM1bBOF+SYdV2VijIcKNe22gBeKkk5jAxFb3kOXASU8irQcBKXX8s6aObQv4cMiA==
X-Received: by 2002:ac2:4c9c:0:b0:443:7ae2:6769 with SMTP id d28-20020ac24c9c000000b004437ae26769mr846545lfl.344.1645647748127;
        Wed, 23 Feb 2022 12:22:28 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c12sm42666lfr.234.2022.02.23.12.22.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:22:25 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id f11so18611960ljq.11
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:22:25 -0800 (PST)
X-Received: by 2002:a2e:b8cc:0:b0:246:4767:7a29 with SMTP id
 s12-20020a2eb8cc000000b0024647677a29mr803446ljp.152.1645647744896; Wed, 23
 Feb 2022 12:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com> <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com> <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca> <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
 <F9A66F89-66C2-4322-808B-275384C4CC9D@gmail.com>
In-Reply-To: <F9A66F89-66C2-4322-808B-275384C4CC9D@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:22:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com>
Message-ID: <CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
To:     Jakob <jakobkoschel@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 12:15 PM Jakob <jakobkoschel@gmail.com> wrote:
>
> in such a case you would still have to set the iterator value to
> NULL when reaching the terminating condition or am I missing something?

No.

Make the rule be "you never use the iterator outside the loop".

IOW, the code sequence is

        some_struct *ptr, *iter;

        ptr = NULL;
        list_for_each_entry(iter, ...) {
                if (iter_matches_condition(iter)) {
                        ptr = iter;
                        break;
                }
        }

        .. never use 'iter' here - you use 'ptr' and check it for NULL ..

See? Same number of variables as using a separate 'bool found' flag,
but simpler code, and it matches the rule of 'don't use iter outside
the loop'.

This is how you'd have to do it anyway if we start using a C99 style
'declare iter _in_ the loop' model.

And as mentioned, it actually tends to lead to better code, since the
code outside the loop only has one variable live, not two.

Of course, compilers can do a lot of optimizations, so a 'found'
variable can be made to generate good code too - if the compiler just
tracks it and notices, and turns the 'break' into a 'goto found', and
the fallthrough into the 'goto not_found'.

So 'better code generation' is debatable, but even if the compiler can
do as good a job with a separate 'bool' variable and some cleverness,
I think we should strive for code where we make it easy for the
compiler to DTRT - and where the generated code is easier to match up
with what we wrote.

                  Linus
