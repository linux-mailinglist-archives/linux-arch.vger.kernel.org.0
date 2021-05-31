Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E13395A6D
	for <lists+linux-arch@lfdr.de>; Mon, 31 May 2021 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhEaMWZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 May 2021 08:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhEaMWZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 May 2021 08:22:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7285361263;
        Mon, 31 May 2021 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622463645;
        bh=Gv8FIYmeqMDJOTDXgyQdyOGAwgOhxU1Bft/3S63ev/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LIrvAoqfkN1K2eyb6iQNPpp0M0V0008b+jty/0d4NbU9p/eXzuUMTPvpmOOxW2VOV
         eHt2gdjGUXu6qrX8vZlATRzIg5wvCJpbHMHKbWOFqvTQCEscAAFKR+gB+lr7D0zQFJ
         eEQZuI1EKTHpQXBRMfmQFLyPvh28yFM7LPrRV6+NAQdoplNXqoJ8uJhKtFH4xrwIZJ
         iJwwbcdv9XUjQKxivXKbeqUlPLw9YMbdOts1Qc+xjyTLGOioZvmVtPBHRSSEZjp25A
         mQYDjxpWIYdpN/oaFW9XPf9RM3Oxtdc+rGQG8He4tlPHPx2Vg4wECp0+f2fayR0VIm
         vtudJO3fG8hNw==
Received: by mail-lf1-f54.google.com with SMTP id v8so16564403lft.8;
        Mon, 31 May 2021 05:20:45 -0700 (PDT)
X-Gm-Message-State: AOAM533bxy+lo6ikBqLjtWvpPMvaPvChdKRgkbfcnuFjLbiwVpRmjBQh
        00E2bxtRz3Gntm2PzD7MJKnyN1rRMHu1Mto8Fqk=
X-Google-Smtp-Source: ABdhPJyFueMXhrZ6j6LIAaHblvrdO4uem3DqJOQMzoQ2ZdLNHJ3ha7iWTvss38IAeL7E3PsB/WXGsAmUI6WPXCMR6lY=
X-Received: by 2002:a05:6512:218d:: with SMTP id b13mr9389933lft.346.1622463643822;
 Mon, 31 May 2021 05:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <1622393366-46079-1-git-send-email-guoren@kernel.org>
 <1622393366-46079-3-git-send-email-guoren@kernel.org> <20210531061742.GB824@lst.de>
In-Reply-To: <20210531061742.GB824@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 May 2021 20:20:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ3pG-EoDnqonEcMyKzdXPkf5s7qcyLSm9x79RiETCWkg@mail.gmail.com>
Message-ID: <CAJF2gTQ3pG-EoDnqonEcMyKzdXPkf5s7qcyLSm9x79RiETCWkg@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] riscv: Add ASID-based tlbflushing methods
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 31, 2021 at 2:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, May 30, 2021 at 04:49:25PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement optimized version of the tlb flushing routines for systems
> > using ASIDs. These are behind the use_asid_allocator static branch to
> > not affect existing systems not using ASIDs.
>
> I still think the code duplication and exposing of new code in a global
> header here is a bad idea and would suggest the version I sent instead.
Your idea is in the third patch, and I also add you with
Co-developed-by. Please have a look:

https://lore.kernel.org/linux-riscv/1622393366-46079-4-git-send-email-guoren@kernel.org/T/#u

[PATCH V5 3/3] riscv: tlbflush: Optimize coding convention


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
