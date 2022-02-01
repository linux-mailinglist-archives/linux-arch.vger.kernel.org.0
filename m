Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541464A5464
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 02:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiBABB7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 20:01:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39114 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiBABB7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 20:01:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D331CB82CCC;
        Tue,  1 Feb 2022 01:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809BFC340F1;
        Tue,  1 Feb 2022 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643677316;
        bh=24FXUCIsHwKxxR+z8h2fdRjDdPuEdYGTAEhE92+MHoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=clh1/HjQGb7FJU4zPzPLiisxkyHkQlnwEUc1A6WJVkLW9dIYHzQ0PXw4lW/Vg5DKn
         5onsZUt0vDOUMNoI9WfI6vQJXZKP178khvz7Rq/VRq50kAOsmLgiRpwDgWTf2d6Az7
         qLLypiHBxQ842LxMEUccZgMyk/XMUjcPBz93s3VdrNd5dv3a+NX+dhnLCXs8RsY6Ej
         szFyd6hEacAuk+xV4M1QXs0NlXsIc9Vh6ETIb6OW1MK4jno/HWBhJQ0lLshUp3jyTP
         p53YjCtDBYYTX1iJ4l0WOEvKEOBySalMQB06SHGlsy3K9zXrrAATm/rudnkdWX0ZNi
         JDIE41IDEur2Q==
Received: by mail-vs1-f44.google.com with SMTP id a19so14138948vsi.2;
        Mon, 31 Jan 2022 17:01:56 -0800 (PST)
X-Gm-Message-State: AOAM532wGK4A+TO/3YBT8t6Y5VNRFUhH9ly2flGfQJNEMYrx3c17gX2l
        SsCVSzfXa1RAUC/UsjAZv4TW5hIdowkUET/tC8o=
X-Google-Smtp-Source: ABdhPJzvz8wBZE7e6h6dqVKudXyTop3viJjp7xMEZGl4tGQghEfTaAqS8qRRv1daCipOlRappkP5Ne/ctRPXJ89sRVI=
X-Received: by 2002:a67:e947:: with SMTP id p7mr9138694vso.59.1643677315521;
 Mon, 31 Jan 2022 17:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20220131064933.3780271-1-hch@lst.de> <CAK8P3a1YzdC1ev0FP-Pe0YyjsY+H3dNWErPGtB=zfcs3kVmkyw@mail.gmail.com>
In-Reply-To: <CAK8P3a1YzdC1ev0FP-Pe0YyjsY+H3dNWErPGtB=zfcs3kVmkyw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Feb 2022 09:01:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRXiCKw8M2c10KVzn6CtLirsqx+3radkgqnKgN=H9Szzw@mail.gmail.com>
Message-ID: <CAJF2gTRXiCKw8M2c10KVzn6CtLirsqx+3radkgqnKgN=H9Szzw@mail.gmail.com>
Subject: Re: consolidate the compat fcntl definitions v2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 1, 2022 at 6:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 31, 2022 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > currenty the compat fcnt definitions are duplicate for all compat
> > architectures, and the native fcntl64 definitions aren't even usable
> > from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
> > to sort out all that.
> >
> > Changes since v1:
> >  - only make the F*64 defines uapi visible for 32-bit architectures
>
> Looks all good to me,
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> I think it would be best to merge this through the risc-v tree along
> with the coming compat support
> that depends on it.
Okay, I would include it in my next version series.

> Alternatively, I can put it into my asm-generic
> tree for 5.18.
>
>          Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
