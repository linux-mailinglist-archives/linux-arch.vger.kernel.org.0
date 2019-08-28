Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2CA0C36
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfH1VNt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 17:13:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38393 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1VNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 17:13:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so1571326edo.5;
        Wed, 28 Aug 2019 14:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scK6EtL0VQwZVHWRtxKBD1vWCx0TbIgqwfjMtIULIk0=;
        b=FSPd/nWqslwbGt9CLhe1VUgpL9sHFETICjfqNaCy9WzjDA8qjI3jVLJDv58xVmqRzy
         Y4qNQlqBc05RdZVCavZ92clY8GTO+660b0QGlkUVa7SnupzWC87UQisOwQU35Kz5y9uU
         aV5ZGubjAuOGlGYymFcYxZueS3URL4avM6rlUFXAwnJ2Kyo4NzTgZ0nHyU8aCsdoi/ig
         oWpxJLSRU5wF/vUNCaPBC3IFf8aPVPdHzHz96/mpTbfBTeWBZYHgLt+quLT0dNT+zZM3
         ChsVoc3rFVr6uDEDoyLGttU5VwSV3UOqW45QwcR6a11F3OBM38Ba/F69uzzzkU3q/vTN
         h0HA==
X-Gm-Message-State: APjAAAWCF/NNpUwEHk0PFimTNIV46oxft3DjehYeZEmQ8VQFItNyWjhk
        hnrvgwVSWVEC3JzNDu9CUVzNYlmh
X-Google-Smtp-Source: APXvYqyYf54WpAacmkMqduyg8ZjKz2tV4o5faV+CAveWMK5SZdnG0I32wU3kLLWYqFV/TqfSEtwd3Q==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr5219849ejb.253.1567026827020;
        Wed, 28 Aug 2019 14:13:47 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id g22sm66386ejr.87.2019.08.28.14.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:13:46 -0700 (PDT)
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20190828210934.17711-1-efremov@linux.com>
To:     Arnd Bergmann <arnd@arndb.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <4ad61875-f694-58a6-f5d8-fca52c093c1d@linux.com>
Date:   Thu, 29 Aug 2019 00:13:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828210934.17711-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Maybe it will be better to move this define out of ifdef, i.e.:

#ifdef CONFIG_BUG
...
-#define BUG_ON()...
...
#else
...
-#define BUG_ON()...
...
#endif

+#define BUG_ON()...

I can prepare a patch if you think it worth it.

Thanks,
Denis

On 29.08.2019 00:09, Denis Efremov wrote:
> Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> the define consistent with BUG_ON(x) in CONFIG_BUG.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>
> ---
>  include/asm-generic/bug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index aa6c093d9ce9..7357a3c942a0 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -185,7 +185,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  #endif
>  
>  #ifndef HAVE_ARCH_BUG_ON
> -#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
> +#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>  #endif
>  
>  #ifndef HAVE_ARCH_WARN_ON
> 
