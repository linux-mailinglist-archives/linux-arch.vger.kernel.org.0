Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1B1B4ABC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgDVQm5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgDVQm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 12:42:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1CC03C1A9;
        Wed, 22 Apr 2020 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=QrOT19ZBwGb45jWLFj76OzHtPNsa1vHjv1F1pWQrc8k=; b=VL29IIAvz3o+pIOic+M/ERYU0q
        EVI7jhensQnBa/i3Cl+yBEjQM+pug+vJ63mFgTybIr3L24mfuh424niWhU75TZRa0vSGtw3hiHoFH
        SPTVUAJoXqp2HCEleBZAVTgVInlqvAulYNK1Tqhk5FoTSxddTtxrmLALx6Yze6ctKuHwFP4QMjLRs
        +zioDDI0XAaQ6eXVAEXUANy2YamaKd0bJHu2mFs9es1hdPeVAJXIwHpu5NNc4eeTZL4VYbfZ+3Ifz
        +AL84IlMjDG1B2vxhXGfX3tXREdXLwsgXZPjZKdfrQ4ort/wdga8pMgM2un27ePOxkXJDSJE1j+BF
        +Okd6D7A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRISf-0007OW-3J; Wed, 22 Apr 2020 16:42:57 +0000
Subject: Re: [PATCH] io: correct documentation mismatches for io memcpy
To:     Wang Wenhu <wenhu.wang@vivo.com>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200422092905.39529-1-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b0a80ed-a639-c8c0-e6c3-01ba3266b7de@infradead.org>
Date:   Wed, 22 Apr 2020 09:42:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422092905.39529-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi--

2 small nits: please see below.

On 4/22/20 2:29 AM, Wang Wenhu wrote:
> Minor mismatches exist between funtion documentations and parameter
> definitions.
> 
> Function definition lines are as following:
> static inline void memcpy_fromio(void *buffer,
> 				 const volatile void __iomem *addr,
> 				 size_t size)
> 
> static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
> 			       size_t size)
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  include/asm-generic/io.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..63131ec4857f 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1067,9 +1067,9 @@ static inline void memset_io(volatile void __iomem *addr, int value,
>  #define memcpy_fromio memcpy_fromio
>  /**
>   * memcpy_fromio	Copy a block of data from I/O memory

This needs a dash ('-') between the function name & its description.

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

Same here.

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

If you would fix the above, you can also add:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
