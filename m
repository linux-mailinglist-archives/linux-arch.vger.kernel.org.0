Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECCC7D3CDF
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjJWQwg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjJWQwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 12:52:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B1DB;
        Mon, 23 Oct 2023 09:52:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5199C433C9;
        Mon, 23 Oct 2023 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698079953;
        bh=nCtnA++YH4GS3eG6W2wL2J30XXMWQEHO20vUYEFJw1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNJRQ99IjKvayYTywMrhrwcvTxawuFRCQPVt8FxvXRfpypDLUJoCIvwcy7nCJOyxt
         0tTrh9YBE4II+a8SjnIjo6c3EU4t4IoebfYWcg88gJAytZb+RXpZpTAPjrt8u8oihD
         Qr4ajVFRo6jqcvyloTtNgGa6itseIG9AdFTG+DqK/G4H76sTAckI6nSZeEuAQkQzZk
         HPSmChtWH7n+fjTPEQjDY97JfSjcswZJVfdPwxStcdMDD9Z7seGHWwECmRWJUz62g6
         VQX1MoVxkR/NF7LqnG3unpfpSS6vWPO7ZY3Pm2ZpQf0RNQhxoIBVK3k4zWpyKg7mHk
         IjLzOLdTImEng==
Date:   Tue, 24 Oct 2023 00:40:20 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "minda.chen@starfivetech.com" <minda.chen@starfivetech.com>
Subject: Re: [PATCH RT 0/3] riscv: add PREEMPT_RT support
Message-ID: <ZTah9NOMbZkf6dfL@xhacker>
References: <20230510162406.1955-1-jszhang@kernel.org>
 <a37fc706-78cd-4721-9af3-aabb610f49b1@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a37fc706-78cd-4721-9af3-aabb610f49b1@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 23, 2023 at 04:33:13PM +0000, Schaffner, Tobias wrote:
> On 10.05.23 18:24, Jisheng Zhang wrote:
> > This series is to add PREEMPT_RT support to riscv. Compared with last
> > try[1], there are two major changes:
> > 
> > 1. riscv has been converted to Generic Entry. And riscv uses
> > asm-generic/preeempt.h, so we need to patch asm-generic's preeempt to
> > enable lazy preempt support for riscv. This is what patch1 does.
> > However, it duplicates the preempt_lazy_count() defintion, I'm sure
> > there must be an elegant solution. Neverless, it doesn't impact the
> > riscv PREEMPT_RT support itself.
> > 
> > 2. three preparation patches(patch1/2/3 in [1]) has been merged in
> > mainline.
> > 
> > I back-ported the lastest linux-6.3.y-rt patches to the lastest Linus tree,
> > then cook this series.
> > 
> > Link: https://lore.kernel.org/linux-riscv/20220831175920.2806-1-jszhang@kernel.org/
> 
> Any news on this series? Are there any open tasks blocking this?
> I am willing to help, but do not see what's missing to get this merged.

Hi Thomas, Sebastian

could you please review? Any comments are appreciated. or do you want a
rebase on linux-6.5.y-rt?

Thanks

> 
> > Jisheng Zhang (3):
> >    asm-generic/preempt: also check preempt_lazy_count for
> >      should_resched() etc.
> >    riscv: add lazy preempt support
> >    riscv: Allow to enable RT
> > 
> >   arch/riscv/Kconfig                   | 2 ++
> >   arch/riscv/include/asm/thread_info.h | 5 ++++-
> >   arch/riscv/kernel/asm-offsets.c      | 1 +
> >   include/asm-generic/preempt.h        | 8 +++++++-
> >   4 files changed, 14 insertions(+), 2 deletions(-)
> > 
> 


