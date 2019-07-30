Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F280C7AC18
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfG3PPv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 11:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfG3PPu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 11:15:50 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D70B2089E;
        Tue, 30 Jul 2019 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564499749;
        bh=DU7lTdgRk/UzeBFELmgega2cAE8p6s9Bfmz55blusQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bw9c0zecDNgvnAVs0fL/MzZs0C6FUYVP6p9LcjYmrSeaFg1u4lV0aenVQ0yFISy36
         +JNnw6iEs0WY3yjt9O81GGtyX8yCoNIA8NKJXY886DRywB1RCZwQKYyFXLFKRN1/XW
         nSEtObXIYr3tOcmN6vr8xX9mj2opTw/2OdI23aQU=
Received: by mail-wr1-f53.google.com with SMTP id f9so66182433wre.12;
        Tue, 30 Jul 2019 08:15:49 -0700 (PDT)
X-Gm-Message-State: APjAAAXy5Hm/Z+u3omRLkdJJ1UMr7DoCvzF2dwlHNh3ikgkAlaczNHTH
        7jTchyNk1lVOZYe+ApFexJFPKvnJ30aicZo3w0I=
X-Google-Smtp-Source: APXvYqxK0Kww7gVU9RWaH10PbI9alkw1yhpNTfq5jsKgvBVEBLf9YWTH2QiZ4m3n2mtqSbzCOXOq95eiDiDKdZgh+ng=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr50992498wro.343.1564499748009;
 Tue, 30 Jul 2019 08:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org> <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
In-Reply-To: <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Jul 2019 23:15:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2nY4dour1mMtGTm08KCyGuW4-sMP4L=cGSBP484Z5tw@mail.gmail.com>
Message-ID: <CAJF2gTR2nY4dour1mMtGTm08KCyGuW4-sMP4L=cGSBP484Z5tw@mail.gmail.com>
Subject: Re: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 30, 2019 at 9:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 30, 2019 at 2:15 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > If arch didn't define dma_r/wmb(), linux will use w/rmb instead. Csky
> > use bar.xxx to implement mb() and that will cause problem when sync data
> > with dma device, becasue bar.xxx couldn't guarantee bus transactions
> > finished at outside bus level. We must use sync.s instead of bar.xxx for
> > dma data synchronization and it will guarantee retirement after getting
> > the bus bresponse.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>
> This change looks good to me, but I think your regular barriers
> (mb, rmb, wmb) are still wrong: These are meant to be the superset
> of dma_{r,w}mb and smp_{,r,w}mb, and synchronize
> against both SMP and DMA interactions.
>
> I suspect you can drop the '.s' for non-SMP builds. What I don't
> see is whether you might need to add '.i' for dma_wmb() or
> dma_rmb().
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
