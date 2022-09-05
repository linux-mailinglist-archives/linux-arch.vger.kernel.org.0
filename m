Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B553C5ADA2F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiIEUbM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 16:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiIEUa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 16:30:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D22F647D4
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=evXPKDiTefqmYvqBhx3DzCWnldGzYwfE5UX+UO4CDuc=; b=jdBmF3eqR2iUvmTfv8o+efwLGQ
        ik/I06J0s/BjmsX8gc2i1AkYaZIdb75b5pjl6o4/HVfWLqebx8gcBbaqAucjgUYwqzfk4gTfUl7xD
        CNbyXYIXjcQvO0giHdMBVDbM3JsDITrqUs7idsU6hFnaNHebpw5XUV2rruUw8nF6jfTbcinrabHt6
        D0TkDUUmCcnZMM0hQrToLcZm5gUAlVaIPXA3F0ZMhZR8QfIraijU4rPbPSF/LrKgKHCk293CR3pcl
        LrL+qyPBQ0df+R7OqW7fN7FgLxI+gCDvaj6fKGLFJm0/KDMtOYkS/Tls+8hXmBvkQunhsky/OrTh7
        DK1mymmw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVIk2-00AZbi-6d; Mon, 05 Sep 2022 20:30:46 +0000
Message-ID: <feb2ad2f-c3ed-54e4-6c06-9787f20ce8f2@infradead.org>
Date:   Mon, 5 Sep 2022 13:30:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tools/headers: Fix undefined behaviour (34 << 26)
Content-Language: en-US
To:     Matthias Goergens <matthias.goergens@gmail.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <a8f4cf90-8ae7-0542-8363-d425dfdecb0a@infradead.org>
 <20220905031904.150925-1-matthias.goergens@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        songmuchun@bytedance.com
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220905031904.150925-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 9/4/22 20:19, Matthias Goergens wrote:
> Left-shifting past the size of your datatype is undefined behaviour in
> C.  The literal 34 gets the type `int`, and that one is not big enough
> to be left shifted by 26 bits.
> 
> An `unsigned` is long enough (on any machine that has at least 32 bits
> for their ints.)
> 
> For uniformity, we mark all the literals as unsigned.  But it's only
> really needed for HUGETLB_FLAG_ENCODE_16GB.
> 
> Thanks to Randy Dunlap for an initial review and suggestion.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

a. Since the header file in tools/ is just a synced-up copy of the
include/uapi/asm-generic/ header file, I think that the subject would be
better if "tools/" were omitted.

b. Adding Andrew Morton and the HUGETLB maintainers to Cc: list.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/uapi/asm-generic/hugetlb_encode.h  | 26 +++++++++++-----------
>  tools/include/asm-generic/hugetlb_encode.h | 26 +++++++++++-----------
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
> index 4f3d5aaa11f5..de687009bfe5 100644
> --- a/include/uapi/asm-generic/hugetlb_encode.h
> +++ b/include/uapi/asm-generic/hugetlb_encode.h
> @@ -20,18 +20,18 @@
>  #define HUGETLB_FLAG_ENCODE_SHIFT	26
>  #define HUGETLB_FLAG_ENCODE_MASK	0x3f
>  
> -#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16KB	(14U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
>  
>  #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
> diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
> index 4f3d5aaa11f5..de687009bfe5 100644
> --- a/tools/include/asm-generic/hugetlb_encode.h
> +++ b/tools/include/asm-generic/hugetlb_encode.h
> @@ -20,18 +20,18 @@
>  #define HUGETLB_FLAG_ENCODE_SHIFT	26
>  #define HUGETLB_FLAG_ENCODE_MASK	0x3f
>  
> -#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16KB	(14U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
>  
>  #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */

-- 
~Randy
