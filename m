Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4A38096D
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhENMZM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 08:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhENMZL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 08:25:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 800DA613CD;
        Fri, 14 May 2021 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620995040;
        bh=wbxGv9t6GbRKjxv6rSslyvniGKsYirDLOL8luJLhqnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U8RD4a6z1w6XaGa8ekohGmVHORARKCNldy0gUnyY2EqA4yJIydt/e79qIxr1+UoyW
         VUC877n7ZwbBEK6O7s8oDpWSl3Ycbe9UEM6sXBZnRvSCMhVSnsu+IEJUaLVbCnEDZd
         hJR0tbTj7eeAAa81AzZizDS42VIq3Oc8JZT7q/C1k2wuSRZIm3ePWQBeYaeta0ZdYj
         kjNLiKAppuu/sn3XW5v1pndVul0Kyn+cxoxbmrVJ86k6NKvsxbr1AQQpfOCHEZ5fEG
         JZP1QHPgOEvsdanB/NuSDHkvd/N83HebpVEsUfIL6PWCtPUzKZDZyVFUlwRsshqVsJ
         3GexNN4/yWKrA==
Received: by mail-ot1-f54.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so5143328otp.4;
        Fri, 14 May 2021 05:24:00 -0700 (PDT)
X-Gm-Message-State: AOAM531d3+9D9XeJhUn54U5tjSWsha9vQ06jhPdHw3L1OICH8qH/KG5H
        XScxqN64Ii0oDV2rb78cM2Hdfbfr/jNxtLzU4JU=
X-Google-Smtp-Source: ABdhPJzROl7Fjyj6XasZO8+BKHJUHE5O/PN10u+bqcgEIYgEvw0o6mBqLsX7pHbqhU/n94ZuitW4NB9Oem1Vvp+o28k=
X-Received: by 2002:a9d:222a:: with SMTP id o39mr38555525ota.246.1620995039855;
 Fri, 14 May 2021 05:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-4-arnd@kernel.org>
 <3d70eb2a-2969-197e-63e8-f3e0a6a8ddd8@physik.fu-berlin.de>
In-Reply-To: <3d70eb2a-2969-197e-63e8-f3e0a6a8ddd8@physik.fu-berlin.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 14:22:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1oO_moABCtNqLkM9ccVh9c=andfz+qiSucTCXcqJkYVA@mail.gmail.com>
Message-ID: <CAK8P3a1oO_moABCtNqLkM9ccVh9c=andfz+qiSucTCXcqJkYVA@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] sh: remove unaligned access for sh4a
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 14, 2021 at 12:34 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Arnd!
>
> On 5/14/21 12:00 PM, Arnd Bergmann wrote:
> > Unlike every other architecture, sh4a uses an inline asm implementation
> > for get_unaligned(). I have shown that this produces better object
> > code than the asm-generic version. However, there are very few users of
> > arch/sh/ overall, and most of those seem to use sh4 rather than sh4a CPU
> > cores, so it seems not worth keeping the complexity in the architecture
> > independent code.
>
> My Renesas SH4-Boards actually run an sh4a-Kernel, not an sh4-Kernel:
>
> root@tirpitz:~> uname -a
> Linux tirpitz 5.11.0-rc4-00012-g10c03c5bf422 #161 PREEMPT Mon Jan 18 21:10:17 CET 2021 sh4a GNU/Linux
> root@tirpitz:~>
>
> So, if this change reduces performance on sh4a, I would rather not merge it.

It only makes a difference in very specific scenarios in which unaligned
accesses are done in a fast path, e.g. when forwarding network packet
at a high rate on a big-endian kernel (little-endian kernels wouldn't run into
this on IP headers). If you have a use case for this machine on which the
you can show a performance regression, I can add a patch on top to put
the optimized sh4a get_unaligned_le32() back. Dropping this patch
altogether would make the series much more complex because most of
the associated code gets removed in the end.

As I mentioned, supporting "movua" in the compiler likely has a much
larger impact on performance, as it would also help in user space, and
it should improve the networking case on little-endian kernels by replacing
the four separate byte loads/shift pairs with a movua plus a byteswap.

Not sure if there are gcc developers that have an active interest in sh4a
support any more.

      Arnd
