Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD72D01D2
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 09:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgLFIbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 03:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFIbq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Dec 2020 03:31:46 -0500
Date:   Sun, 6 Dec 2020 09:31:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607243465;
        bh=gG+D2N0kxRvniYUcbpmdsHQy9H2+ijJ6pQARcCkRJmk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvmuYdlLQnCa0N556ComZVtAzdo2LtE/wmfS2PyzQi5p6YP2Drg7eBmRBQE3ldy3l
         QFlbH0MJOzEy7N32yOt8qFA7bnQ9A7TI+ovdeJ0d19JT2qqWayAuZ//Ips3A/2mhfZ
         UE4hgSoi93HI/3XqoOMus8Q2qmFgg6LF10vFnFB4=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     akpm@linux-foundation.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        arnd@arndb.de, jpoimboe@redhat.com, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        mhiramat@kernel.org, jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        glider@google.com, orson.zhai@unisoc.com,
        takahiro.akashi@linaro.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, dushistov@mail.ru, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
Message-ID: <X8yWxe/9gzosFOam@kroah.com>
References: <20201206064624.GA5871@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206064624.GA5871@ubuntu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 06, 2020 at 03:46:24PM +0900, Levi Yun wrote:
> Inspired find_next_*_bit and find_last_bit, add find_last_zero_bit
> And add le support about find_last_bit and find_last_zero_bit.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  lib/find_bit.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 4a8751010d59..f9dda2bf7fa9 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -90,7 +90,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  EXPORT_SYMBOL(find_next_zero_bit);
>  #endif
>  
> -#if !defined(find_next_and_bit)
> +#ifndef find_next_and_bit
>  unsigned long find_next_and_bit(const unsigned long *addr1,
>  		const unsigned long *addr2, unsigned long size,
>  		unsigned long offset)
> @@ -141,7 +141,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>  {
>  	if (size) {
>  		unsigned long val = BITMAP_LAST_WORD_MASK(size);
> -		unsigned long idx = (size-1) / BITS_PER_LONG;
> +		unsigned long idx = (size - 1) / BITS_PER_LONG;
>  
>  		do {
>  			val &= addr[idx];

This, and the change above this, are not related to this patch so you
might not want to include them.

Also, why is this patch series even needed?  I don't see a justification
for it anywhere, only "what" this patch is, not "why".

thanks

greg k-h
