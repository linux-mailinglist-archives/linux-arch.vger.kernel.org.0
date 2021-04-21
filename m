Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D333D366E27
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbhDUO1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 10:27:01 -0400
Received: from elvis.franken.de ([193.175.24.41]:35319 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243507AbhDUO1B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 10:27:01 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lZDoA-0005BV-00; Wed, 21 Apr 2021 16:26:26 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7AC22C0840; Wed, 21 Apr 2021 16:15:18 +0200 (CEST)
Date:   Wed, 21 Apr 2021 16:15:18 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/math/test_div64: Fix error message formatting
Message-ID: <20210421141518.GA11331@alpha.franken.de>
References: <alpine.DEB.2.21.2104211445290.44318@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2104211445290.44318@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 21, 2021 at 03:25:22PM +0200, Maciej W. Rozycki wrote:
> Align the expected result with one actually produced for easier visual 
> comparison; this has to take into account what the format specifiers 
> will actually produce rather than the characters they consist of.  E.g.:
> 
> test_div64: ERROR: 10000000ab275080 / 00000009 => 01c71c71da20d00e,00000002
> test_div64: ERROR: expected value              => 0000000013045e47,00000001
> 
> (with a failure induced by setting bit #60 of the divident).
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  lib/math/test_div64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
