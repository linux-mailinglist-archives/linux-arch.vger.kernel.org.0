Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8353BA262
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGBPAd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 11:00:33 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:58604 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhGBPAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 11:00:33 -0400
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 11:00:32 EDT
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lzKID-0007JQ-2I; Fri, 02 Jul 2021 15:37:21 +0100
Subject: Re: [PATCH v2 1/3] lib/string: optimized memcpy
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
 <20210702123153.14093-2-mcroce@linux.microsoft.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <0e0fa030-8995-b930-5e22-954349a0b82e@codethink.co.uk>
Date:   Fri, 2 Jul 2021 15:37:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702123153.14093-2-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/07/2021 13:31, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Rewrite the generic memcpy() to copy a word at time, without generating
> unaligned accesses.
> 
> The procedure is made of three steps:
> First copy data one byte at time until the destination buffer is aligned
> to a long boundary.
> Then copy the data one long at time shifting the current and the next long
> to compose a long at every cycle.
> Finally, copy the remainder one byte at time.
> 
> This is the improvement on RISC-V:
> 
> original aligned:	 75 Mb/s
> original unaligned:	 75 Mb/s
> new aligned:		114 Mb/s
> new unaligned:		107 Mb/s
> 
> and this the binary size increase according to bloat-o-meter:
> 
> Function     old     new   delta
> memcpy        36     324    +288
> 
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>   lib/string.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 77 insertions(+), 3 deletions(-)

Doesn't arch/riscv/lib/memcpy.S also exist for an architecture
optimised version? I would have thought the lib/string.c version
was not being used?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
