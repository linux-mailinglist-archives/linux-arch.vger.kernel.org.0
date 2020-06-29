Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1441920D6C8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgF2TXz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732336AbgF2TXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:23:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E56C03E979
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:23:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so19481928ljg.13
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkLALwEBsfgrF/H397Lx9Gt+sC05sJ13vZdNeAjTZ5E=;
        b=FPlpwVAPUFD3v6bVUhip7cfhfzuueSDNYo7W0SMPvHcy6jzZIQis6GYHuGsYXXfKf3
         ALP2bWjkMLoY3aUn94tO9sMxLR4uZyaVnIgdqw+dVS0hN08AsAYTmLgAbVhQzlDndEU7
         PR1/ytPMFHpUV9rh2wieVICotA43fZMtUaYFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkLALwEBsfgrF/H397Lx9Gt+sC05sJ13vZdNeAjTZ5E=;
        b=hBjvMeRLjpXRrLGH4aM1nQx49kQ/S53OfzO4aThWiroWZNfrlcMW8uQVIHBEWWLncL
         qMiBt9dRKghB8TpVPHt+vyjgusHFTcYgfY204lYDyJ3DkdBnqLDz52ju74nt9C4rihqV
         LyUTaQAYR4TgucjZMmQOgO1jVIrB4tecr4vSTGA14Q/Tkib+mgOEhchKjlolvViMyivI
         IpQvucQwkDR4DQBJdLds+fVEyuVJOGDs4iUdQIgNVqmotuq8lZaxGJXH8AATARm31SVy
         EWuQOMz9PfX9uHTsda2KMuN6bnZIfemv/HQf1KFL5y9QIp8SQLD+CEQ3FrR4In0Jj1jE
         2m+Q==
X-Gm-Message-State: AOAM5306rjkQyfB+R7pGXHAVXpdfo7bx8Kpq8g/4uwcN+B24rQ7hmPrQ
        opuKM++e7Fo1h8xy8vw5zwfINp+TRMM=
X-Google-Smtp-Source: ABdhPJyikNp8n65oZ3/+yNfvNgm2hDMsY516Qgk4KiwocSzXgMymWn9limUiiC3D861rVHByMf4USQ==
X-Received: by 2002:a2e:a492:: with SMTP id h18mr8891444lji.45.1593458631832;
        Mon, 29 Jun 2020 12:23:51 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r25sm120727lfi.70.2020.06.29.12.23.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:23:51 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q7so6275008ljm.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 12:23:50 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr6878545ljn.421.1593458630544;
 Mon, 29 Jun 2020 12:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 12:23:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
Message-ID: <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 11:28 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->get2() takes task+regset+buffer, returns the amount of free space
> left in the buffer on success and -E... on error.

Can we please give it a better name than "get2"?

That's not a great name to begin with, and it's a completely
nonsensical name by the end of this series when you've removed the
original "get" function.

So either:

 (a) add one final patch to rename "get2" all back to "get" after you
got rid of the old "get"

 (b) or just call it something better to begin with. Maybe just
"get_regset" instead?

I'd prefer (b) just because I think it will be a lot clearer if we
ever end up having old patches forward-ported (or, more likely,
newpatches back-ported), so having a "get" function that changed
semantics but got back the old name sounds bad to me.

Other than that, I can't really argue with the numbers:

 41 files changed, 1368 insertions(+), 2347 deletions(-)

looks good to me, and the code seems more understandable.

But I only scanned the individual patches, maybe I missed some other horror.

               Linus
