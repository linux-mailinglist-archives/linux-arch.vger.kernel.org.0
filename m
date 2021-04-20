Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA9365082
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 04:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhDTCu4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTCuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Apr 2021 22:50:55 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38AC0C06174A;
        Mon, 19 Apr 2021 19:50:24 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9483392009C; Tue, 20 Apr 2021 04:50:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8D69C92009B;
        Tue, 20 Apr 2021 04:50:22 +0200 (CEST)
Date:   Tue, 20 Apr 2021 04:50:22 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Message-ID: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

 As Huacai has recently discovered the MIPS backend for `do_div' has been 
broken and inadvertently disabled with commit c21004cd5b4c ("MIPS: Rewrite 
<asm/div64.h> to work with gcc 4.4.0.").  As it is code I have originally 
written myself and Huacai had issues bringing it back to life leading to a 
request to discard it even I have decided to step in.

 In the end I have fixed the code and measured its performance to be ~100% 
better on average than our generic code.  I have decided it would be worth 
having the test module I have prepared for correctness evaluation as well 
as benchmarking, so I have included it with the series, also so that I can 
refer to the results easily.

 In the end I have included four patches on this occasion: 1/4 is the test 
module, 2/4 is an inline documentation fix/clarification for the `do_div' 
wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a small 
performance improvement to it.

 I have investigated a fifth change as a potential improvement where I 
replaced the call to `do_div64_32' with a DIVU instruction for cases where 
the high part of the intermediate divident is zero, but it has turned out 
to regress performance a little, so I have discarded it.

 Also a follow-up change might be worth having to reduce the code size and 
place `__div64_32' out of line for CC_OPTIMIZE_FOR_SIZE configurations, 
but I have not fully prepared such a change at this time.  I did use the 
WIP form I have for performance evaluation however; see the figures quoted 
with 4/4.

 These changes have been verified with a DECstation system with an R3400 
MIPS I processor @40MHz and a MTI Malta system with a 5Kc MIPS64 processor 
@160MHz.

 See individual change descriptions and any additional discussions for
further details.

 Questions, comments or concerns?  Otherwise please apply.

  Maciej
