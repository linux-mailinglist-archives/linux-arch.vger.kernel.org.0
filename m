Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E77D201A7D
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jun 2020 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbgFSSiR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jun 2020 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbgFSSiI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 14:38:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD03C0613EF
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 11:38:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so12615177ljn.6
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3fbVijkwGqEXjgf746UVzNHZFijt5PEP/I+cIGFrOI=;
        b=Pbi6ZcZ/j5UzKi4TuELv3vWZVoPaSRX4qHDHfjemlgk/7t9FABxdeWgh51bILfCKJ5
         wi8F+rrtMy4gj2dpmCJd8yxSDI3bKAoHjCDk9Pmgk4ebmFXb7pgJH6u8Pl1d3HL2Cn+Y
         CfZiRrUn8yF0xtr+Dhn2AXvWp8IgyXRWpqhQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3fbVijkwGqEXjgf746UVzNHZFijt5PEP/I+cIGFrOI=;
        b=Y63lGW7RybnW0dinDhev/r/kVBbaFXneDlLrFyILxmli3pcpXqU92VVsaUaxU1V4Xf
         iiBk+lhTJcpjbn2KCMoVlkELn9Lt6qgmScWDGO0DIf2kqyUYLIrhSSbSU6+w82G2BBIw
         zNZ1OhNt4IxIOgb4+Sz8kn0HAEmRlRISXONNUB9ymFJtg2UTAKcqqE46og7hzZR2ErV3
         h7ZY1uNml2nRyJxDHKDKt1Ryye/Me/keOMJpxHXVRdxIyrw7RAnLGW7XtSawoUX8DkwI
         j0Jy0QgPRfiaYVjPh3Id2A6OcE5DkdwJ7/a7yP07mTEI2KVa6Zdm6nCWzMH7GBIuABlP
         OyUw==
X-Gm-Message-State: AOAM531CVDXueLnjrUC3HhoKxm/rIQqqcDkmM/lYy/rvVlDLbhfzP8Bl
        nP3Q2CwwzjMZBY5j2q1Q7PhfnYj6fN8=
X-Google-Smtp-Source: ABdhPJxA1INTld6MRx3xdIy53X3k3tRBY4dscp/Tc6YtpJUzSRk77wAF3Vonlhw8Ti2vid0lrot9IQ==
X-Received: by 2002:a2e:83c7:: with SMTP id s7mr2607933ljh.68.1592591884747;
        Fri, 19 Jun 2020 11:38:04 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 5sm1286398ljr.64.2020.06.19.11.38.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:38:04 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id g139so5319233lfd.10
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 11:38:03 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr2684358lfc.142.1592591883165;
 Fri, 19 Jun 2020 11:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210645.GB2212102@localhost.localdomain>
In-Reply-To: <20200618210645.GB2212102@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Jun 2020 11:37:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com>
Message-ID: <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 18, 2020 at 2:06 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Rename
>         struct notifier_block *this
> to
>         struct notifier_block *nb
>
> "nb" is arguably a better name for notifier block.

Maybe it's a better name. But it doesn't seem worth it.

Because C++ reserved words are entirely irrelevant.

We did this same dance almost three decades ago, and the fact is, C++
has other reserved words that make it all pointless.

There is no way I will accept the renaming of various "new" variables.
We did it, it was bad, we undid it, and we now have a _lot_ more uses
of 'new' and 'old', and no, we're not changing it for a braindead
language that isn't relevant to the kernel.

The fact is, C++ chose bad identifiers to make reserved words.

If you want to build the kernel with C++, you'd be a lot better off just doing

   /* C++ braindamage */
   #define this __this
   #define new __new

and deal with that instead.

Because no, the 'new' renaming will never happen, and while 'this'
isn't nearly as common or relevant a name, once you have the same
issue with 'new', what's the point of trying to deal with 'this'?

             Linus
