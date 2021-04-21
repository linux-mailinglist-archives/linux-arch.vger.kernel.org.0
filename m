Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD84366B34
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhDUMw3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 08:52:29 -0400
Received: from elvis.franken.de ([193.175.24.41]:35165 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239950AbhDUMw2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 08:52:28 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lZCKf-0004Cw-02; Wed, 21 Apr 2021 14:51:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AA7E0C0840; Wed, 21 Apr 2021 14:01:48 +0200 (CEST)
Date:   Wed, 21 Apr 2021 14:01:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Message-ID: <20210421120148.GC8637@alpha.franken.de>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 20, 2021 at 04:50:22AM +0200, Maciej W. Rozycki wrote:
> Hi,
> 
>  As Huacai has recently discovered the MIPS backend for `do_div' has been 
> broken and inadvertently disabled with commit c21004cd5b4c ("MIPS: Rewrite 
> <asm/div64.h> to work with gcc 4.4.0.").  As it is code I have originally 
> written myself and Huacai had issues bringing it back to life leading to a 
> request to discard it even I have decided to step in.
> 
>  In the end I have fixed the code and measured its performance to be ~100% 
> better on average than our generic code.  I have decided it would be worth 
> having the test module I have prepared for correctness evaluation as well 
> as benchmarking, so I have included it with the series, also so that I can 
> refer to the results easily.
> 
>  In the end I have included four patches on this occasion: 1/4 is the test 
> module, 2/4 is an inline documentation fix/clarification for the `do_div' 
> wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a small 
> performance improvement to it.
> 
>  I have investigated a fifth change as a potential improvement where I 
> replaced the call to `do_div64_32' with a DIVU instruction for cases where 
> the high part of the intermediate divident is zero, but it has turned out 
> to regress performance a little, so I have discarded it.
> 
>  Also a follow-up change might be worth having to reduce the code size and 
> place `__div64_32' out of line for CC_OPTIMIZE_FOR_SIZE configurations, 
> but I have not fully prepared such a change at this time.  I did use the 
> WIP form I have for performance evaluation however; see the figures quoted 
> with 4/4.
> 
>  These changes have been verified with a DECstation system with an R3400 
> MIPS I processor @40MHz and a MTI Malta system with a 5Kc MIPS64 processor 
> @160MHz.
> 
>  See individual change descriptions and any additional discussions for
> further details.
> 
>  Questions, comments or concerns?  Otherwise please apply.

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
