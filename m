Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA14C1C1C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiBWTYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 14:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBWTYa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 14:24:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3346144
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:24:00 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b9so5007lfv.7
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjArSS8ANU0AmF9VRiQ+JwaB1JolSh6jU4/KfBIWJSg=;
        b=SxgxuRG0OkfsBfuvCa7RY3/WZgvDzK2U9zqimJb2S8qNwZdf5H//RLR918xc8lgJj+
         M68mG5a/yJboRqjg/HEaGiIjdE+20eno7KhkjxVE6tVzmRLvywdJPoHydDzgl6AIzIaI
         ZKh+7HuT69NwKddIUvjRtBnkS0FxhwvyckzOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjArSS8ANU0AmF9VRiQ+JwaB1JolSh6jU4/KfBIWJSg=;
        b=ESQeTYYVOmDO0A6b0P1B6QSJVDkm4yYBiF9c9JAzpsjtZrLGNw1sJQ1HibioaHSqgY
         pe22k+GLASJSSz3ZpWrBb9Q++bUx4Dl5my/vAkVFiKoZp9uHAbOY8fH6YLiNfn2kMWQ0
         BfyF7eyKkuk6iWshVsPNswLOVFrjzqPGvR2rtH4iHqC9OXMNJZQdkOXh6Ml1G8WJN8c2
         eYHSwtxlI7iErbQ2i0TAwX2jeKPfyhIeTtHmLmwg3BvrNnfqiPN1qBr/SwPBZzI2ZDjS
         yv/KHzoj24Vnw3cKM1KgEAV9/nfomQRMpfVK619DQTL7RIHTaakJFWwCo+bk1dYnEMeu
         /nyw==
X-Gm-Message-State: AOAM530vZyzxAssJb5+P6HXrGrb8QzPKCK59Od2l3a56IbmRwCZp3fYs
        2OljuKc5Iv3Zkkk3eIgLA38uxNRdZz2Ir5yMYLU=
X-Google-Smtp-Source: ABdhPJwr65aAtYsk5iYCk/wMy0cRGnie/Vh2pxvOhVNKr8nwuEXoo8Z/6muy4kr+W6PNk7ylx2jU7w==
X-Received: by 2002:a05:6512:a93:b0:43c:cf81:d848 with SMTP id m19-20020a0565120a9300b0043ccf81d848mr758756lfu.538.1645644239011;
        Wed, 23 Feb 2022 11:23:59 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id cf34sm33128lfb.97.2022.02.23.11.23.56
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 11:23:56 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id j7so15092lfu.6
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:23:56 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr728782lfu.27.1645644235739; Wed, 23 Feb
 2022 11:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
In-Reply-To: <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 11:23:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
Message-ID: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Feb 23, 2022 at 10:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Arnd - remind me, please.. Was there some other problem than just gcc-4.9?

Hmm. Interesting. I decided to just try it and see for the compiler I
have, and changing the gnu89 to gnu99 I get new warnings
(-Werror=shift-negative-value).

Very annoying.  Especially since negative values are in many contexts
actually *safer* than positive ones when used as a mask, because as
long as the top bit is set in 'int', if the end result is then
expanded to some wider type, the top bit stays set.

Example:

  unsigned long mask(unsigned long x)
  { return x & (~0 << 5); }

  unsigned long badmask(unsigned long x)
  { return x & (~0u << 5); }

One does it properly, the other is buggy.

Now, with an explicit "unsigned long" like this, some clueless
compiler person  might say "just use "~0ul", but that's completely
wrong - because quite often the type is *not* this visible, and the
signed version works *regardless* of type.

So this Werror=shift-negative-value warning seems to be actively
detrimental, and I'm not seeing the reason for it. Can somebody
explain the thinking for that stupid warning?

That said, we seem to only have two cases of it in the kernel, at
least by a x86-64 allmodconfig build. So we could examine the types
there, or we could just add '-Wno-shift-negative-value".

               Linus
