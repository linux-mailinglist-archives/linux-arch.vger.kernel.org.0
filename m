Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E023281BB
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhCAPEO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 10:04:14 -0500
Received: from elvis.franken.de ([193.175.24.41]:33733 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236883AbhCAPEB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 10:04:01 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lGk4s-00041h-00; Mon, 01 Mar 2021 16:03:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2FAB8C03C2; Mon,  1 Mar 2021 15:49:08 +0100 (CET)
Date:   Mon, 1 Mar 2021 15:49:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210301144908.GC11261@alpha.franken.de>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
 <20210225135700.1381396-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225135700.1381396-3-yury.norov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 25, 2021 at 05:57:00AM -0800, Yury Norov wrote:
> From: Alexander Lobakin <alobakin@pm.me>
> 
> MIPS doesn't have architecture-optimized bitsearching functions,
> like find_{first,next}_bit() etc.
> It's absolutely harmless to enable GENERIC_FIND_FIRST_BIT as this
> functionality is not new at all and well-tested. It provides more
> optimized code and saves some .text memory (32 R2):
> 
> add/remove: 4/1 grow/shrink: 1/53 up/down: 216/-372 (-156)
> 
> Users of for_each_set_bit() like hotpath gic_handle_shared_int()
> will also benefit from this.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
