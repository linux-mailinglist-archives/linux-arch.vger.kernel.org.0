Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8492B76E8F3
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHCNAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjHCNAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 09:00:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F11712;
        Thu,  3 Aug 2023 06:00:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b4749013so8095535ad.2;
        Thu, 03 Aug 2023 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067639; x=1691672439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ne4TLOkbOjf1MkMkI08KdCgdWtyARI72DRJ1ahPA7Lg=;
        b=hFey5S88VtrEj8gHmZzWxck98y+If6caA2T8qnAZkJ4duvjNkDzWWvcFEw/uspdv1X
         wD909xuUDRoQrQNpiHSLdRLZFriZDRvwOiKmkduwJ/kahZ22t59tHpZak9YzHIedp9hg
         4exCm1UfhAwy9Geeh5yuFeA2Wem+KZowfiT7EVhdWDgjjUaVbE8nV8fXdufVzS2h5dcH
         lKahNstvLkEJSry6FNlRSsneeYNI7kFkzZTmeU1O+VhTC7eYPGgFf1w1Re/dYov6Ox9I
         NzdEyNEL1gV6qv2uPri+ROXf0dRLmwYIOOjSZAra0jXjh8NQZabvgjARx8v0dLaz/64x
         Ij+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067639; x=1691672439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne4TLOkbOjf1MkMkI08KdCgdWtyARI72DRJ1ahPA7Lg=;
        b=cjcN8AKJlu7b6BxOSvyGdwklfy1elMFZ1cmnIE0bOIyYMOlPCuIgBDnQ/Uv/zukpQ2
         hL7PPQbrZV/LwQ3m4BGlSCx0jhwx5vSvWKD7pIhBhL4VoqGR32jorXxZFNoekK1D2R3x
         ZWnICgi5xhfBsExyia1ePWfTsPvu+7ScGHhRQfBAEdw0t1RikGjA4FvsGynmdu7SK87l
         VyYLyyLNAAxJEx+oYLLs9Aisc6cJ87mFaD05byR6nyDW5EEVbjjkN2v6yoGUC0/I4ZPX
         J6e8IYpooKXL7J8uLUS/uVxBCshgSp4vOeLgd12AhbmMjEEpO+VsRkLtEDJefTdvfpsM
         KItQ==
X-Gm-Message-State: ABy/qLZgRz88xPacqEkSYhCUF0vBYeoSpISreNgtxmAlja0POtIAD4iS
        c1YbNuxVzPZhrLdNFsnLQtj3U1r/zyc=
X-Google-Smtp-Source: APBJJlFjk8oBOgHwouxONCLHTACkD4p2a6yaYuNz3BKom3qdfdhJRvnnBf3GbKpUGgyT1J5gs6W8Bg==
X-Received: by 2002:a17:902:9045:b0:1bb:bbd4:aadf with SMTP id w5-20020a170902904500b001bbbbd4aadfmr15609107plz.61.1691067638758;
        Thu, 03 Aug 2023 06:00:38 -0700 (PDT)
Received: from [192.168.1.100] (bb220-255-255-44.singnet.com.sg. [220.255.255.44])
        by smtp.gmail.com with ESMTPSA id iz20-20020a170902ef9400b001b9ecee9f81sm14369433plb.129.2023.08.03.06.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:00:38 -0700 (PDT)
Message-ID: <cf3085ba-5b2e-c048-20bf-4b9a54443cc8@gmail.com>
Date:   Thu, 3 Aug 2023 21:00:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 01/38] minmax: Add in_range() macro
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-2-willy@infradead.org>
Content-Language: en-US
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <20230802151406.3735276-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/2023 11:13 PM, Matthew Wilcox (Oracle) wrote:
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 798c6963909f..83aebc244cba 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -3,6 +3,7 @@
>   #define _LINUX_MINMAX_H
>   
>   #include <linux/const.h>
> +#include <linux/types.h>
>   
>   /*
>    * min()/max()/clamp() macros must accomplish three things:
> @@ -222,6 +223,32 @@
>    */
>   #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
>   
> +static inline bool in_range64(u64 val, u64 start, u64 len)
> +{
> +	return (val - start) < len;
> +}
> +
> +static inline bool in_range32(u32 val, u32 start, u32 len)
> +{
> +	return (val - start) < len;
> +}
> +

I think these two functions return wrong result if val is smaller than 
start and len is big enough.
