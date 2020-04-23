Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B402D1B6180
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgDWRCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgDWRCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Apr 2020 13:02:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A773FC09B042;
        Thu, 23 Apr 2020 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=woeHLzx2UyIQ/D6tJ1KvK2T3SJtwi4BVd49pVJRsTWA=; b=ATuZoGTyc71GfTDwe7WeYFXr9q
        +WpG5ohuvFc54tA/SLkPuogLnOrIeym1WzQF1KkHX3thClqxLuoXTvhkIz+6+7vt27NDPsTidcAQz
        9aakKqD4YCXnkPWDraxl9M5BjIxbzIak65UrGHF3yWYVb3rY578OGlqzweZa4qJsGSlt5FdjDu5ax
        QTblip1z4/5b9WIJi4cC/5hsmzugJnAPFOIG88rHPtFs0gN7sYgtfP99RzlSaSwUTCETiC9j+2dMM
        Fmtia4VisQQOurt8+ipErRxMouYYiiusb3Gx8BIn/Q4KBaXjtReBO34OZ4ex8r2uhBGWaWO7uzrux
        /jo/9Gyw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRfFI-0001fB-J5; Thu, 23 Apr 2020 17:02:40 +0000
Subject: Re: [PATCH v2] io: correct documentation mismatches for io memcpy
To:     Wang Wenhu <wenhu.wang@vivo.com>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200423000945.118231-1-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84b453cb-886c-2ec6-e562-e300a3cd55d4@infradead.org>
Date:   Thu, 23 Apr 2020 10:02:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423000945.118231-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/22/20 5:09 PM, Wang Wenhu wrote:
> Minor mismatches exist between funtion documentations and parameter
> definitions. Also a dash '-' is needed between a function name and
> its description.
> 
> Function definitions are as following:
> static inline void memcpy_fromio(void *buffer,
> 				 const volatile void __iomem *addr,
> 				 size_t size)
> static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
> 			       size_t size)
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Hi,
Sorry to just notice this, but could you also fix up all of
the kernel-doc notation for memset_io() in the same manner?

thanks.

> ---
> Changes since v1:
>  * Dashes added between the function names and their descriptions.
> 
>  include/asm-generic/io.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..b6a9131ec4d4 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1066,10 +1066,10 @@ static inline void memset_io(volatile void __iomem *addr, int value,
>  #ifndef memcpy_fromio
>  #define memcpy_fromio memcpy_fromio
>  /**
> - * memcpy_fromio	Copy a block of data from I/O memory
> - * @dst:		The (RAM) destination for the copy
> - * @src:		The (I/O memory) source for the data
> - * @count:		The number of bytes to copy
> + * memcpy_fromio -	Copy a block of data from I/O memory
> + * @buffer:		The (RAM) destination for the copy
> + * @addr:		The (I/O memory) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data from I/O memory.
>   */
> @@ -1084,10 +1084,10 @@ static inline void memcpy_fromio(void *buffer,
>  #ifndef memcpy_toio
>  #define memcpy_toio memcpy_toio
>  /**
> - * memcpy_toio		Copy a block of data into I/O memory
> - * @dst:		The (I/O memory) destination for the copy
> - * @src:		The (RAM) source for the data
> - * @count:		The number of bytes to copy
> + * memcpy_toio -	Copy a block of data into I/O memory
> + * @addr:		The (I/O memory) destination for the copy
> + * @buffer:		The (RAM) source for the data
> + * @size:		The number of bytes to copy
>   *
>   * Copy a block of data to I/O memory.
>   */
> 


-- 
~Randy

