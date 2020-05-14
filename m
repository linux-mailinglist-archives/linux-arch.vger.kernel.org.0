Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAD1D383A
	for <lists+linux-arch@lfdr.de>; Thu, 14 May 2020 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgENRbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 May 2020 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726027AbgENRbJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 13:31:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D427C061A0E;
        Thu, 14 May 2020 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nNCtX7q0Lfr0RUH931wFr5lvCbJuxXDC/EmVXz8oOc8=; b=UrPcEW9qedTTtjihlckv8yKneK
        /oZcOob9xiX+JvHyh1vFQvXBOIapM+tRrtYKpR7zM1b6U/iSpJyoCe5EsP5EA7rKzlvRrsBhDkkZP
        rV2MiPNgig2r56/j3fi2yMLVY/qWWSIbn4OIBKVvq+SlkWXU0Q/USlYPgpm2dBC78j80Ik2XhqNNb
        mOwxms74IRUlyN14fFCM65ywJsHjVS3y3OPu7KXZD/U2wf3gk70FktWOZefukgpDhXnR0u0dP3IA2
        hBk19J83aCku7ghqiG3kXcPJh63cp38ybYKXD+4UWgkV3pHfw7C54X+lqNhzikRnoIo5iqHG6Mn18
        YtlIkVeA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZHhI-0000O8-Fq; Thu, 14 May 2020 17:31:04 +0000
Subject: Re: [PATCH] asm-generic: Update kernel documentation in io.h
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20200514170818.24598-1-miquel.raynal@bootlin.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9e29e70-b0c9-9d54-bf87-31d5dcd211ab@infradead.org>
Date:   Thu, 14 May 2020 10:31:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514170818.24598-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/14/20 10:08 AM, Miquel Raynal wrote:
> The kernel documentation of:
> * bus_to_virt()
> * memcpy_fromio()
> * memcpy_toio()
> refers to older parameters.
> 
> Update it to fit the actual names.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/asm-generic/io.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..cb617baf8d47 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1051,8 +1051,8 @@ static inline void *bus_to_virt(unsigned long address)
>  /**
>   * memset_io	Set a range of I/O memory to a constant value
>   * @addr:	The beginning of the I/O-memory range to set
> - * @val:	The value to set the memory to
> - * @count:	The number of bytes to set
> + * @value:	The value to set the memory to
> + * @size:	The number of bytes to set
>   *
>   * Set a range of I/O memory to a given value.
>   */
> @@ -1067,9 +1067,9 @@ static inline void memset_io(volatile void __iomem *addr, int value,
>  #define memcpy_fromio memcpy_fromio
>  /**
>   * memcpy_fromio	Copy a block of data from I/O memory
> - * @dst:		The (RAM) destination for the copy
> - * @src:		The (I/O memory) source for the data
> - * @count:		The number of bytes to copy
> + * @buffer:		The (RAM) destination for the copy
> + * @addr:		The (I/O memory) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data from I/O memory.
>   */
> @@ -1085,9 +1085,9 @@ static inline void memcpy_fromio(void *buffer,
>  #define memcpy_toio memcpy_toio
>  /**
>   * memcpy_toio		Copy a block of data into I/O memory
> - * @dst:		The (I/O memory) destination for the copy
> - * @src:		The (RAM) source for the data
> - * @count:		The number of bytes to copy
> + * @addr:		The (I/O memory) destination for the copy
> + * @buffer:		The (RAM) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data to I/O memory.
>   */
> 

https://lore.kernel.org/lkml/20200424020831.30494-1-wenhu.wang@vivo.com/
is a better (more complete) patch IMO.

if Arnd would merge...

thanks.
-- 
~Randy

