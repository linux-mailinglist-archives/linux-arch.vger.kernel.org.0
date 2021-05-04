Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E97372ECE
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEDRW6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 13:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhEDRW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 13:22:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA72C061574;
        Tue,  4 May 2021 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Nts/+xIWR17zmFxlJ7GtFvHSObw051b9Oj5iVqkqHO4=; b=EZ7MDZsCSx25OCFbAYCOo0KXh1
        6kF+lL9DfpUNEnqdLF0n6q5701nnicBTvakqxbRSWcA2s1oGalbtbc3gZEBSLQGMVAIWJ1vPhyqvC
        mxZ5X6qxRyT9YjnOG/EID/rnewphi12+5QasvyHNa6iQLVVWx6NUlbqQKwkDsioD0P1O3NflRvXHt
        i1GYePglollvoByFS3wKvBLc5v6RrqdNgXGuaZqY+hst3pD19JsSH8pA3h9pALAnaZzweFPHQnbUc
        j7SnPIjzUl69eNQb3//YOtHORay5YzoQ1t5tcWUsquUum2RTQYkOzvL98ihsguwwQLEzo/4ue4l1I
        XTvWevXg==;
Received: from [2601:1c0:6280:3f0::7376]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldyjU-00GrbD-2p; Tue, 04 May 2021 17:21:32 +0000
Subject: Re: [PATCH] csky: syscache: Fixup duplicate cache flush
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <1620112488-18773-1-git-send-email-guoren@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <00cd7f1a-c6d4-b8ed-ba60-5c74516f4534@infradead.org>
Date:   Tue, 4 May 2021 10:21:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1620112488-18773-1-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/4/21 12:14 AM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The current csky logic of sys_cacheflush is wrong, it'll cause
> icache flush call dcache flush again. Now fixup it with a
> conditional "break & fallthrough".
> 
> Fixes: 997153b9a75c ("csky: Add flush_icache_mm to defer flush icache all")
> Fixes: 0679d29d3e23 ("csky: fix syscache.c fallthrough warning")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

more below:

> ---
>  arch/csky/mm/syscache.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/csky/mm/syscache.c b/arch/csky/mm/syscache.c
> index 4e51d63..a7b53b0 100644
> --- a/arch/csky/mm/syscache.c
> +++ b/arch/csky/mm/syscache.c
> @@ -12,15 +12,18 @@ SYSCALL_DEFINE3(cacheflush,
>  		int, cache)
>  {
>  	switch (cache) {
> -	case ICACHE:
>  	case BCACHE:
> -		flush_icache_mm_range(current->mm,
> -				(unsigned long)addr,
> -				(unsigned long)addr + bytes);
> -		fallthrough;
>  	case DCACHE:
>  		dcache_wb_range((unsigned long)addr,
>  				(unsigned long)addr + bytes);
> +		if (cache == BCACHE)
> +			fallthrough;
> +		else
> +			break;

I think the above would be more readable as:

		if (cache != BCACHE)
			break;
		fallthrough;

fwiw.

> +	case ICACHE:
> +		flush_icache_mm_range(current->mm,
> +				(unsigned long)addr,
> +				(unsigned long)addr + bytes);
>  		break;
>  	default:
>  		return -EINVAL;
> 

thanks.
-- 
~Randy

