Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B67389D4F
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhETFtl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 01:49:41 -0400
Received: from verein.lst.de ([213.95.11.211]:40759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhETFtk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 01:49:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5452967373; Thu, 20 May 2021 07:48:16 +0200 (CEST)
Date:   Thu, 20 May 2021 07:48:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210520054816.GA21693@lst.de>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com> <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de> <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 20, 2021 at 09:45:45AM +0800, Guo Ren wrote:
> It's a very big MIPS smell. What's the attribute of the uncached
> window? (uncached + strong-order/ uncached + weak, most vendors still
> use AXI interconnect, how to deal with a bufferable attribute?) In
> fact, customers' drivers use different ways to deal with DMA memory in
> non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
> the same way in DMA memory is a smart choice. So using PTE attributes
> is more suitable.

I'm not saying it is a good idea.  Just that apparently this exists in
the ASICs.
