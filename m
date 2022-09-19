Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC73E5BD117
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiISPdW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISPdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 11:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98428704
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663601600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWg8VC3Y2I+R8H0oWyV4jcW6qd/ETEFixpJMwEeGBEQ=;
        b=Cik/DxkwJogEzAuoLfU6MONRlxrWldD0qcCfDRQSv8/7PVXbye7QQSsVq0YyEz51hhMZPo
        0T3V14/INni4ydQ2Izs3W4bZwMlMj6fZR/VfQp9YtKmm8GU9JWVaYgcywKyv8ytBxusE3s
        do1S5Gw0Y6gB3McYmKMyiNAf39/n628=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-MpgMOojnOGSGVhmO6mldSw-1; Mon, 19 Sep 2022 11:33:18 -0400
X-MC-Unique: MpgMOojnOGSGVhmO6mldSw-1
Received: by mail-ed1-f71.google.com with SMTP id m3-20020a056402430300b004512f6268dbso19783722edc.23
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 08:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=CWg8VC3Y2I+R8H0oWyV4jcW6qd/ETEFixpJMwEeGBEQ=;
        b=zkyeFZQhSD1xCRaWGZWYL12yr0vihsNpGSyE2gtb8HZnuynFfb1jqZlxpptouUobXM
         IdkoELUfTIv83SXsRjsqq9rta9dbXlc71EIgJhUYBfcPFFjKnD/6sjcd8Z6XSs1J6haj
         FmUZHeNeFgP473965s+avO77RiQKiI9dJp7Y3c52HMFRqbm3erFNWhCAlcW66VYtWCOh
         A/4+ioDkJTEMasaummn00O7VBQ7+5Y1A65rXR9sj4QUoVT1PI9UBrJMCkGtTEt9CbJxt
         LYENsJkXamx9ApvdWk8o9I3qXSfxlvgEDUmN2S4USAGOlRplHhYg3iyjaZC9JA7OISKp
         Z98g==
X-Gm-Message-State: ACrzQf2mEc8FqeytXrGN0M4ivfT3SZcqu2b76rxRjA1Qk9X8VsvHCZEE
        eBrJbCpTV+VWhxIl7VLmVyN6zrHJtaqwbtvyQNGtX5WyYoJBEk37vB9SnSvY1kgmOaETjvWUXXu
        ttgqXq0XlJRQH6Ab7tvz6Gw==
X-Received: by 2002:a17:906:8a52:b0:781:7aa7:9dde with SMTP id gx18-20020a1709068a5200b007817aa79ddemr2059400ejc.70.1663601597740;
        Mon, 19 Sep 2022 08:33:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jpBl4EP1V68hm/6NhmgPAuWQStwEK91hLMOo30kSRGmXQzpiq1jOr3grUtqbEYYMJJjDx3Q==
X-Received: by 2002:a17:906:8a52:b0:781:7aa7:9dde with SMTP id gx18-20020a1709068a5200b007817aa79ddemr2059386ejc.70.1663601597530;
        Mon, 19 Sep 2022 08:33:17 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906314700b007708130c287sm15627839eje.40.2022.09.19.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:33:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Li zeming <zeming@nfschina.com>
Cc:     linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] asm-generic: Remove unnecessary =?utf-8?B?4oCYMA==?=
 =?utf-8?B?4oCZ?= values from guest_id
In-Reply-To: <20220919015136.3409-1-zeming@nfschina.com>
References: <20220919015136.3409-1-zeming@nfschina.com>
Date:   Mon, 19 Sep 2022 17:33:15 +0200
Message-ID: <878rmfpef8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Li zeming <zeming@nfschina.com> writes:

> The file variable is assigned guest_id, it does not need to be initialized.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  include/asm-generic/mshyperv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c05d2ce9b6cd..cd5ce86c218a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -108,7 +108,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>  static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
>  				       __u64 d_info2)
>  {
> -	__u64 guest_id = 0;
> +	__u64 guest_id;
>  
>  	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
>  	guest_id |= (d_info1 << 48);

The initializer is certainly not needed, however, if we are to do some
changes, let's be bold. Suggestions:

1) Stop using "__u64" type, "u64" is good enough.

2) Drop all the parameters from the function, both call sites look like

 generate_guest_id(0, LINUX_VERSION_CODE, 0);

3) Rename the function to make it clear it's Hyper-V related,
e.g. "hv_generate_guest_id()".

...

-- 
Vitaly

