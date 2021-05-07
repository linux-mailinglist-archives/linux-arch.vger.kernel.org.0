Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01F1376D1E
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 01:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhEGXDf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 19:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGXDd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 May 2021 19:03:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A3C061574;
        Fri,  7 May 2021 16:02:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u13so11991558edd.3;
        Fri, 07 May 2021 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38ULn+OwZaEekiuv6xhRuA2bEJaogBDMw8bfMrQc/YY=;
        b=XDblBBk9CyTpFhSL1O13vR6Dsco6KDKUZtk6a19GSyzwsxADxSRRblMlh+mJK+tx9Y
         yMVHE61PmiP6xHi/2zGhmkf9z5ilJGqrCWYCCFpgSRtA51WL0AZNl25lYIsu+VozNe7Z
         bLkelhv7Kvvqb0qUVt6fYX9J/s9Pn4urfJChMaPBrEg6TlHgjDO/ueADGhojNTT0ZO4Z
         vrx606MxCQyBLV4w0JuTDdR+L/bttoG3oZeX619susFjPPuLyE0mYSbHiT2uQvdd7S0c
         /7hhKfRx6XHQancq0d/IpdWIzRJpUjq4hBZzdBHVzTUJYyt9uNyMFwFAq2MFrISDSwlV
         Xq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38ULn+OwZaEekiuv6xhRuA2bEJaogBDMw8bfMrQc/YY=;
        b=ktzllT7HGdo3B3jyE/sefvscjOntrMCyVrg1K/R79Y0Xk8awTJBKP8LOssV94DVSSn
         XzuIu4LtM8CBJFLQWObXnt/hLOksDZgH6pmBJHsmh3d14INqUrZqbznetKUVOcpBPh33
         Em9dg75pV832SXRYfF/x9+gqA/+tIk1gQN0CnNKdVhDSpiUhiC2SaWw6u1QAXCTZa6NT
         6UUQ4nprYrU+GHLxDyw+qUhtUdZRX9HqUymSnqyTYyz7gffQ9xbiOsfNthgDTFbOUO3w
         qTSD6039DUh3RLu9Ys1xqQFGFvsP5/pBu0X5laYiWHOm901/VlhKxu5fRsbtHaoSIMek
         cGTA==
X-Gm-Message-State: AOAM531hdMIsf2El0II0MOdDEMUsolkvVoPvxj6n/kdBH9YGwAsq8kOY
        WmlAZlzcKtYL12gDkYJH8sIk68wzRyj4uqfmHmY=
X-Google-Smtp-Source: ABdhPJy86zQpfnrAnV3u2eyy5bdWdlpCTzNDUbhj78N0nCrWk094oosvAk5GWLZsTW48/uS9hx8AHh94O3ppiH56G4I=
X-Received: by 2002:a50:d0c1:: with SMTP id g1mr6897542edf.201.1620428548878;
 Fri, 07 May 2021 16:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-3-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-3-arnd@kernel.org>
From:   Stafford Horne <shorne@gmail.com>
Date:   Sat, 8 May 2021 08:02:17 +0900
Message-ID: <CAAfxs77U4-ojjmsX1uQ9QwhnKa69Aqcs=br+H-Yc7E7RNODqvQ@mail.gmail.com>
Subject: Re: [RFC 02/12] openrisc: always use unaligned-struct header
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 8, 2021 at 7:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> openrisc is the only architecture using the linux/unaligned/*memmove
> infrastructure. There is a comment saying that this version is more
> efficient, but this was added in 2011 before the openrisc gcc port
> was merged upstream.
>
> I checked a couple of files to see what the actual difference is with
> the mainline gcc (9.4 and 11.1), and found that the generic header
> seems to produce better code now, regardless of the gcc version.
>
> Specifically, the be_memmove leads to allocating a stack slot and
> copying the data one byte at a time, then reading the whole word
> from the stack:
>
> 00000000 <test_get_unaligned_memmove>:
>    0:   9c 21 ff f4     l.addi r1,r1,-12
>    4:   d4 01 10 04     l.sw 4(r1),r2
>    8:   8e 63 00 00     l.lbz r19,0(r3)
>    c:   9c 41 00 0c     l.addi r2,r1,12
>   10:   8e 23 00 01     l.lbz r17,1(r3)
>   14:   db e2 9f f4     l.sb -12(r2),r19
>   18:   db e2 8f f5     l.sb -11(r2),r17
>   1c:   8e 63 00 02     l.lbz r19,2(r3)
>   20:   8e 23 00 03     l.lbz r17,3(r3)
>   24:   d4 01 48 08     l.sw 8(r1),r9
>   28:   db e2 9f f6     l.sb -10(r2),r19
>   2c:   db e2 8f f7     l.sb -9(r2),r17
>   30:   85 62 ff f4     l.lwz r11,-12(r2)
>   34:   85 21 00 08     l.lwz r9,8(r1)
>   38:   84 41 00 04     l.lwz r2,4(r1)
>   3c:   44 00 48 00     l.jr r9
>   40:   9c 21 00 0c     l.addi r1,r1,12
>
> while the be_struct version reads each byte into a register
> and does a shift to the right position:
>
> 00000000 <test_get_unaligned_struct>:
>    0:   9c 21 ff f8     l.addi r1,r1,-8
>    4:   8e 63 00 00     l.lbz r19,0(r3)
>    8:   aa 20 00 18     l.ori r17,r0,0x18
>    c:   e2 73 88 08     l.sll r19,r19,r17
>   10:   8d 63 00 01     l.lbz r11,1(r3)
>   14:   aa 20 00 10     l.ori r17,r0,0x10
>   18:   e1 6b 88 08     l.sll r11,r11,r17
>   1c:   e1 6b 98 04     l.or r11,r11,r19
>   20:   8e 23 00 02     l.lbz r17,2(r3)
>   24:   aa 60 00 08     l.ori r19,r0,0x8
>   28:   e2 31 98 08     l.sll r17,r17,r19
>   2c:   d4 01 10 00     l.sw 0(r1),r2
>   30:   d4 01 48 04     l.sw 4(r1),r9
>   34:   9c 41 00 08     l.addi r2,r1,8
>   38:   e2 31 58 04     l.or r17,r17,r11
>   3c:   8d 63 00 03     l.lbz r11,3(r3)
>   40:   e1 6b 88 04     l.or r11,r11,r17
>   44:   84 41 00 00     l.lwz r2,0(r1)
>   48:   85 21 00 04     l.lwz r9,4(r1)
>   4c:   44 00 48 00     l.jr r9
>   50:   9c 21 00 08     l.addi r1,r1,8
>
> I don't know how the loads/store perform compared to the shift version
> on a particular microarchitecture, but my guess is that the shifts
> are better.

Thanks for doing the investigation on this as well.

Load stores are slow like on most architectures.  WIth caching it will
be faster, but
still not faster than the shifts.  So this looks good to me.

> In the trivial example, the struct version is a few instructions longer,
> but building a whole kernel shows an overall reduction in code size,
> presumably because it now has to manage fewer stack slots:
>
>    text    data     bss     dec     hex filename
> 4792010  181480   82324 5055814  4d2546 vmlinux-unaligned-memmove
> 4790642  181480   82324 5054446  4d1fee vmlinux-unaligned-struct

That's a plus.

> Remove the memmove version completely and let openrisc use the same
> code as everyone else, as a simplification.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/include/asm/unaligned.h | 47 ---------------------------
>  include/linux/unaligned/be_memmove.h  | 37 ---------------------
>  include/linux/unaligned/le_memmove.h  | 37 ---------------------
>  include/linux/unaligned/memmove.h     | 46 --------------------------
>  4 files changed, 167 deletions(-)
>  delete mode 100644 arch/openrisc/include/asm/unaligned.h
>  delete mode 100644 include/linux/unaligned/be_memmove.h
>  delete mode 100644 include/linux/unaligned/le_memmove.h
>  delete mode 100644 include/linux/unaligned/memmove.h

Thanks again,

-Stafford
