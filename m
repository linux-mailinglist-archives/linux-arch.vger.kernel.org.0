Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B8367310
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbhDUTEr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 15:04:47 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:39368 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbhDUTEq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 15:04:46 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D056F92009D; Wed, 21 Apr 2021 21:04:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CAD8792009C;
        Wed, 21 Apr 2021 21:04:10 +0200 (CEST)
Date:   Wed, 21 Apr 2021 21:04:10 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
In-Reply-To: <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com>
Message-ID: <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 21 Apr 2021, H. Nikolaus Schaller wrote:

> > In the end I have included four patches on this occasion: 1/4 is the test 
> > module, 2/4 is an inline documentation fix/clarification for the `do_div' 
> > wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a small 
> > performance improvement to it.
> 
> How can I apply them to the kernel? There is something wrong which makes
> git am fail.

 I don't know.  The changes were made against vanilla 5.12-rc7, but then 
the pieces affected have not changed for ages.  FWIW I can `git am' the 
series as received back just fine.

> > These changes have been verified with a DECstation system with an R3400 
> > MIPS I processor @40MHz and a MTI Malta system with a 5Kc MIPS64 processor 
> > @160MHz.
> 
> I'd like to test on ~320 MHz JZ4730.

 Sure, I'd love to hear how this code performs with other implementations.  

  Maciej
