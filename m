Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB141B6B13
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 04:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDXCKx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 22:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDXCKw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Apr 2020 22:10:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF0C09B042;
        Thu, 23 Apr 2020 19:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OBgNK9rHfKSNp69sjU/hI+pzYQtmKHgWZHtwk3DP7WE=; b=CmhCC7v+hcbIBC5NgHTD1CC0nL
        SH6fio7SRIzVm5jIGhH04zf6ns69fK33yc/SzSZcSd/M6DkmtEgkd7nnx8R1vDcbIB7lQNGyco0ah
        cpJ1STuJtX7NqtgmQsHkKlm7N+T56ucvmTBKlh2Bt1c4xPBFiIl/ISyj6Ipu7io6Qsn8QHqLz1P/I
        yzSQf/Tipva6H7KIeY5tDqqWrr8divsP4SUfArkSSbZrqVJhCOn/LSLAONFoyqTSBghgIBEstvOYS
        eXJ876+5UR27R5PtA8QBPCNPM6UMmRBbKApFj9O9h+tnRIbYZmfYxpx1DG4Tu9UC+OTcIJfodA9la
        0l/WORoQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRnnl-0002WL-BI; Fri, 24 Apr 2020 02:10:49 +0000
Subject: Re: [PATCH v3] io: correct doc-mismatches for io mem ops
To:     Wang Wenhu <wenhu.wang@vivo.com>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200424020831.30494-1-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef0a77eb-202c-6772-ab46-ebd2a393df32@infradead.org>
Date:   Thu, 23 Apr 2020 19:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424020831.30494-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/23/20 7:08 PM, Wang Wenhu wrote:
> Minor mismatches exist between funtion documentations and parameter
> definitions. Also a dash '-' is needed between a function name and
> its description.
> 
> Function definitions are as following:
> static inline void memset_io(volatile void __iomem *addr, int value,
> 			     size_t size)
> static inline void memcpy_fromio(void *buffer,
> 				 const volatile void __iomem *addr,
> 				 size_t size)
> static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
> 			       size_t size)
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Thanks for taking care of that.

> ---
>  include/asm-generic/io.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d39ac997dda8..83ac47bfa33a 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1049,10 +1049,10 @@ static inline void *bus_to_virt(unsigned long address)
>  #ifndef memset_io
>  #define memset_io memset_io
>  /**
> - * memset_io	Set a range of I/O memory to a constant value
> + * memset_io -	Set a range of I/O memory to a constant value
>   * @addr:	The beginning of the I/O-memory range to set
> - * @val:	The value to set the memory to
> - * @count:	The number of bytes to set
> + * @value:	The value to set the memory to
> + * @size:	The number of bytes to set
>   *
>   * Set a range of I/O memory to a given value.
>   */
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

