Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3C262695
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 07:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgIIE74 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgIIE73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 00:59:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D6C061786
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 21:59:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v196so1219372pfc.1
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 21:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rdk6qUroklOezfjw+3dsA2Gu4Mz4XSO7jbxK/CWDMqk=;
        b=JLdEHyMNpt93ohv4NKJl4ziWIkVTXyKDXL23hqJYtMGUwYVaCFrN0D+e4FEGsUwX6w
         Q6ieMcouBJy1YjgP3onPlT8k7nXF4bBWteYTZIy1rNDVeU9n5w63TXKmbdT+vaH5xEfe
         8h/7gF0OUTKShx6D8uy6czh+MWyjk/uq2bkYoJZToXb8+w64AYVEsmx9+Cx4HBP4+FqI
         G/qsuKVYv6ma70aopXEJDY9VLsGF8ErWVyshKumui1bHfHsHjDVKNSSUevajiUUv12K9
         G16hBntoZRqrzfUSck1ceDayhfa6dUs3bilNqzPIQ5iyTNwbfmz1Prd0wFf0Da+BjAbt
         ub9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rdk6qUroklOezfjw+3dsA2Gu4Mz4XSO7jbxK/CWDMqk=;
        b=EN80APSuBR02JR15q84nr0MXWYft/afgjZg3385R9q6fkAZ9tMpqSe9OMM0ukDBxIJ
         gA0NGrt7DchQesBlKHuDzTFO6rl1UYhrheurKSa9U47Q1qOGsXs9+iNinMMv8STHcgt6
         Bt/ZIk28dXZFFnF8W880smSkO3mvbw41YO7AY7BXXtmHyDxehAXQLcmhgvhqITPNRWSD
         NAyPlLzEvirJ3Jq9BeIyVy9SHBBFKRA5soJ4kKTYlshjuoD6wRBRe3PF9/tU9VKp3w/a
         +JKIZZmAXG5P0heIUcwWin0iXDu8GJyJ6hJa+YOmsuZRjgxhuwcyb6lBDySlHAtHUm9Z
         ar0Q==
X-Gm-Message-State: AOAM5304B4Q5HzAlJ+EpB3qBrPLej5kLgrRi2Vg6HQF8dNTc9KMndVAr
        gF+RYGPaZrkm3xSViv0cqzIBsg==
X-Google-Smtp-Source: ABdhPJy+mcRn9gBxX26OAJWUpRkuRfLoO0RKY/cwXfFGpspac8HvpMtXj5XV/6ZXVEST2GvI7VaEVA==
X-Received: by 2002:a63:cd49:: with SMTP id a9mr1595915pgj.277.1599627567758;
        Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gb19sm705987pjb.38.2020.09.08.21.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:44:39 PDT (-0700)
Subject:     Re: [PATCH 7/8] riscv: implement __get_kernel_nofault and __put_user_nofault
In-Reply-To: <20200907055825.1917151-8-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-c08d96cd-2db3-413b-8e5c-cc159e12b507@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 06 Sep 2020 22:58:24 PDT (-0700), Christoph Hellwig wrote:
> Implement the non-faulting kernel access helpers directly instead of
> abusing the uaccess routines under set_fs(KERNEL_DS).
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index b67d1c616ec348..264e52fb62b143 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -486,6 +486,26 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  	__ret;							\
>  })
>
> +#define HAVE_GET_KERNEL_NOFAULT
> +
> +#define __get_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	long __kr_err;							\
> +									\
> +	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)
> +
> +#define __put_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	long __kr_err;							\
> +									\
> +	__put_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)
> +
>  #else /* CONFIG_MMU */
>  #include <asm-generic/uaccess.h>
>  #endif /* CONFIG_MMU */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
