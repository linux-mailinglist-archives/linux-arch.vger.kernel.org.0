Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF09388761
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhESGNd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236026AbhESGNV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 02:13:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDC5E611AE;
        Wed, 19 May 2021 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621404722;
        bh=aliJ2A5IaLQl1kaFJpcVaP8FxOlUquhNHY8hfbwV5oQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9DZR23da4IjsoJ/mtAo2AxCyf5GDW2IBuWal8rsvRSUyw0YGESWBWY9765O/zFUq
         OnqbcN7Xothn9+c0LxanS4KEHJFBdg7HNlH5a7rdHiMyBlCUh1DDhbKVBx2ZPl5z1T
         SPuWPJT/TmE2An9xwQXLbCq/JmtSIpzY2dTaSpllQnS2hujMM2i0xiKWOKGhum8cAE
         nde1rhH/lYw62U5AeKtUbRnV2sD44ZCQlwXr0e2I6VYgukoTamidjdhgzrnudauYJq
         zKyF21Fnyqd+NpIXsFzM0lCvqPJA8PaZOHLV+Mezrqm25c8acZlF3PHChGjmJjsBgX
         RoQPiT48pGerA==
Received: by mail-lf1-f48.google.com with SMTP id r5so17302623lfr.5;
        Tue, 18 May 2021 23:12:01 -0700 (PDT)
X-Gm-Message-State: AOAM531Kza4MirKSLL9NDNC/gyXKxLuhTPRUa2L3IAFnorgqCxK9UHE7
        howoEg+vvtgW3cVCNRdxzSi9vW6qjH4z7A94IRg=
X-Google-Smtp-Source: ABdhPJxlGj9xlx+dM6z1cg/1XfTAYuNHni/4fS0DrteOYCWlgF9XOUG9wrp/nkdsQ6fjglLfVBF0odXgygjFL2krD6E=
X-Received: by 2002:ac2:5493:: with SMTP id t19mr7293363lfk.346.1621404720345;
 Tue, 18 May 2021 23:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
 <20210519060617.GA28397@lst.de>
In-Reply-To: <20210519060617.GA28397@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 May 2021 14:11:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSd273ZuRpgFZK-UKA=LgDHGEVrWdN8admScta-mF-Hvw@mail.gmail.com>
Message-ID: <CAJF2gTSd273ZuRpgFZK-UKA=LgDHGEVrWdN8admScta-mF-Hvw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        drew@beagleboard.org, wefu@redhat.com, lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 2:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> > Since the existing RISC-V ISA cannot solve this problem, it is better
> > to provide some configuration for the SOC vendor to customize.
>
> We've been talking about this problem for close to five years.  So no,
> if you don't manage to get the feature into the ISA it can't be
> supported.

arch/riscv/errata/ is also defined in riscv ISA?

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
