Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CA28E9D6
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 03:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgJOBTj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 21:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbgJOBTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9FCC05BD3A
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:51:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d24so1101823ljg.10
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6oBIo6NMPMfLWaK5KgxYK4Ufg4k2ubTwgmyCFt3P0g=;
        b=NGV+3tygGODZy3py0l471EDO3cAhaCKm/0oH+GnoAnl8uVT08bj08gcxgVjtxWV8Tq
         Bed7WTMDPptLmWYRwNNDJfe+ozsotmCMfsUYGxxJdsub/va6psKbBlDpWECbhy12PwLh
         i1CkPu58C5kDeyvD9pLBgOx+0mzgUNJvq+gN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6oBIo6NMPMfLWaK5KgxYK4Ufg4k2ubTwgmyCFt3P0g=;
        b=Z7PWjRIkNWN0iC0K0Lh6l/8y8sxTHyVwx9x/QXDPXpRW/z+WTv65kbkjyaKtIE/G+P
         4y1Z2rbrZhICRlAqT7mCTjUcbIlfL9a8Gp80bRXfa9QoqvK6FLLBAgALfn2CkN+ccdm2
         KYsF1BDpvctZI3F4d2W2lX9+t4Jl8uDMMr92BROzXiyHmwIk1nq33nYa8T8QBieK1pvm
         iB4Ra5MUYwW1goUSyX6btbW+LXf7mzk/kqtntyPCJbx93dPJX18UjI0bwGZTM9XU7cIK
         5hig1rxBtEshBWSFxCJmTEIHTVF/2un1XUOIMpU4/ZsmsOHQ9OjrbiB71dT0Gz7dx/iK
         HVnA==
X-Gm-Message-State: AOAM533aEiQdvmcolDaOUDtCooBKfw/JO+nzONMNl/Y3goVBNBMSWm8i
        TwWC2OigErlyHLpWKwSXL6w3qsfLvCGzMw==
X-Google-Smtp-Source: ABdhPJwJcPi7L1jAQyJVPoXXs0rRwOFvokEdtCPgojXELj9Jucq2mduXTZe2Gbxkbb/wNbSICK6XpA==
X-Received: by 2002:a2e:90d4:: with SMTP id o20mr124830ljg.291.1602715879297;
        Wed, 14 Oct 2020 15:51:19 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k21sm429319ljb.43.2020.10.14.15.51.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 15:51:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y16so1168918ljk.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:51:17 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr156315ljh.312.1602715877030;
 Wed, 14 Oct 2020 15:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200724012512.GK2786714@ZenIV.linux.org.uk> <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-20-viro@ZenIV.linux.org.uk> <20201014222650.GA390346@zx2c4.com>
In-Reply-To: <20201014222650.GA390346@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 15:51:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
Message-ID: <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] ppc: propagate the calling conventions change
 down to csum_partial_copy_generic()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 3:27 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This patch is causing crashes in WireGuard's CI over at
> https://www.wireguard.com/build-status/ . Apparently sending a simple
> network packet winds up triggering refcount_t's warn-on-saturate code. I

Ouch.

The C parts look fairly straightforward, and I don't see how they
could cause that odd refcount issue.

So I assume it's the low-level asm code conversion that is buggy. And
it's apparently the 32-bit conversion, since your ppc64 status looks
fine.

I think it's this instruction:

        addi    r1,r1,16

that should be removed from the function exit, because Al removed the

-       stwu    r1,-16(r1)

on function entry.

So I think you end up with a corrupt stack pointer and basically
random behavior.

Mind trying that? (This is obviously all in
arch/powerpc/lib/checksum_32.S, the csum_partial_copy_generic()
function).

               Linus
