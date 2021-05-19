Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0483887DB
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhESG6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:58:23 -0400
Received: from verein.lst.de ([213.95.11.211]:36976 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232019AbhESG6V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 02:58:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADB9468B05; Wed, 19 May 2021 08:56:58 +0200 (CEST)
Date:   Wed, 19 May 2021 08:56:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        paul.walmsley@sifive.com
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210519065658.GB31590@lst.de>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <20210519052048.GA24853@lst.de> <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com> <20210519060617.GA28397@lst.de> <20210519065431.GB3076809@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519065431.GB3076809@x1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 11:54:31PM -0700, Drew Fustini wrote:
> Isn't it a good goal for Linux to support the capabilities present in
> the SoC that a currently being fab'd?
> 
> I believe the CMO group only started last year [1] so the RV64GC SoCs
> that are going into mass production this year would not have had the
> opporuntiy of utilizing any RISC-V ISA extension for handling cache
> management.

Then the vendors need to push harder.  This problem has been known
for years but ignored by the vendors.
