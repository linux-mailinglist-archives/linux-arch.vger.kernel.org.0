Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702A4C1C49
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiBWTb7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 14:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiBWTb6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 14:31:58 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3FD483BB
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:31:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id w27so56813lfa.5
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEyhUpG5h+UzsnkwaWDI2eM3wTHuE75grcoHH/zJYag=;
        b=P06RhFQPqHMaTnXXTqQiWy7i3ZvuvEnaxcFwUNwLKfDh834mazjKFAOBMkuBI31nYY
         LkL6nIoyNjJTId+oTv5veateVEDhsfGxHdM9k4hMUFpmTxShWxiuxBPNZCrZqiQZADzX
         oTmBvX8/Yd2JbxYqu3ZOPPHBH72oYvgZQX2s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEyhUpG5h+UzsnkwaWDI2eM3wTHuE75grcoHH/zJYag=;
        b=ZfQT3KgZx5HB0MS9ZdVMO0KTj963ig6k7Zjn0bkFuHO0k05wNW4Mr9PEaKRjxSKvaL
         u3hQdkLradl5CgJ6XUAJrlNcy6Q7SOGnFlErbYVyAdwCyI3HtJAV/P5VpKIjse0cOlJy
         cTCFTxskzY37fnbzPBRkdo/xIEtnv82xoEkbTfiO4M24uY413mVsepJZmWJD4u2UFfl9
         ic14IzSJyKMtvXUiLW/+zSUcH8pArT1wRw1vDdhtp8SSRzyCsPVLrCKKQZpomm+7/wvM
         rT9+7kxXs5vUvcMEcw3bqPalOMjPxoTGUOSFi8qfLa54/Fo37P+uHfcvGciGHfAfL6Pj
         ffRg==
X-Gm-Message-State: AOAM5335IhUXkV6S2dD1+9YAVCaifcy4utrqkorGJgmgEV08wBUG4uU6
        UwHxfyy/BDjswVNTZ5yTcudeVcMH0XWlW1x+lnE=
X-Google-Smtp-Source: ABdhPJwILbtq9fG4y6thrpeXbqDr10k7kSK2qlZV+ur4dPLaWvNVgoZTRp2O7nVFElZs9al63Dxiaw==
X-Received: by 2002:a05:6512:312f:b0:438:8567:7b4f with SMTP id p15-20020a056512312f00b0043885677b4fmr719334lfd.379.1645644687565;
        Wed, 23 Feb 2022 11:31:27 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m1sm33578lfg.308.2022.02.23.11.31.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 11:31:26 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id e5so22434lfr.9
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:31:26 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr745790lfu.27.1645644686317; Wed, 23 Feb
 2022 11:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com> <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com> <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca>
In-Reply-To: <20220223191222.GC10361@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 11:31:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
Message-ID: <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jakob <jakobkoschel@gmail.com>,
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

On Wed, Feb 23, 2022 at 11:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Yes, this is what I had put together as well about this patch, and I
> think it is OK as-is. In this case the list head is in the .bss of a
> module so I don't think it is very likely that the type confused
> container_of() will alias a kalloc result, but it is certainly
> technically wrong as-is.

I think that the pattern we should strive to use is not top use a
'bool' with the

 - initialize to false, and then in loop: do 'found = true;' if found

 - use the iterator variable if 'found'.

but instead strive to

 - either only use the iterator variable inside the loop

 - if you want to use it after the loop, have a externally visible
separate pointer initialized to NULL, and set it to the iterator
variable inside the loop

IOW, instead of having a variable that is a 'bool', just make that
variable _be_ the pointer you want. It's clearer, and it avoids using
the iterator variable outside the loop.

It also is likely to generate better code, because there are fewer
live variables - outside the loop now only uses that one variable,
rather than using the 'bool' variable _and_ the iterator variable.

               Linus
