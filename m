Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECB36C5EA
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhD0MRd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 08:17:33 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:39598 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0MRd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Apr 2021 08:17:33 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 87CD092009C; Tue, 27 Apr 2021 14:16:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7CD1092009B;
        Tue, 27 Apr 2021 14:16:47 +0200 (CEST)
Date:   Tue, 27 Apr 2021 14:16:47 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be
 zero
In-Reply-To: <alpine.DEB.2.21.2104221053500.44318@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2104270511060.2587@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk> <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com> <alpine.DEB.2.21.2104211810200.44318@angie.orcam.me.uk> <20210422075645.GA5996@alpha.franken.de>
 <alpine.DEB.2.21.2104221053500.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021, Maciej W. Rozycki wrote:

>  NB, I have benchmarked the update with my DECstation, however my Malta 
> has not come up after a reboot last evening and neither it has after a few 
> remote power cycles.  I have planned a visit in my lab next week anyway, 
> so I'll see what has happened there; hopefully I'm able to bring the board 
> back to life as I find it valuable for my purposes.  I had to replace the 
> PSU it came with already a couple years back and the new one is supposedly 
> high-quality, so I fear it's the board itself.

 For the record I have put the Malta back in service now.

 It was weird: the YAMON status shown on the ASCII display was "E:P_UNKN",
i.e. "Unknown PCI device on board (should never happen)" (according to the 
manual).  Indeed I never saw that message before.  By elimination I have 
tracked down the DEFPA FDDI network interface to be the culprit and upon a 
close inspection found a bent pin with the PFI ASIC (the PCI interface 
chip), a 160-pin 20-mil PQFP part.  It was IDSEL shorting to RST_L, the 
adjacent pin.  No wonder the card wreaked havoc with the system.  Fixed by 
carefully moving the pins apart with a razor blade (always good to have 
one at hand!).

 Now I wonder how this card happened to work with the pin bent for some
15 years and only finally developed a short now.  Weird indeed, and 
weirder even to see a second failure related to IC pins this year only.

  Maciej
