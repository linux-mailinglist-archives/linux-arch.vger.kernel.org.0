Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168906DB194
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDGR0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDGR0A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:26:00 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C093E0;
        Fri,  7 Apr 2023 10:25:56 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id l26-20020a05600c1d1a00b003edd24054e0so1134096wms.4;
        Fri, 07 Apr 2023 10:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680888354; x=1683480354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQsQ9Zw7IbWQc2rh3cEQR+IFQYyiCQZXokEd/GwNUOc=;
        b=qRkTArCFKWAe3zxQN/2e+Zn29UENFbLlC2WAoelDOVWuT/NHV+7LCGaNyZb5tU56jp
         TKVoaOgeWsYZ1g13XDKXkrbXoVszr1Pz8kABh3jOqhV5ei23HFo1aX7BQBxeoGOBE/Wj
         PDnG8vKYQMkh0Mo/06Fw69MEg8/oiLnpJY4LfqKg7oxFtsaVrXvr28mewsw3enPZ+qkO
         3kmvSOcUquHfQ3OR3jfJgdae/EiYLz67ehOlvob+oH9Hloll0f/DC1/kVQhLAferdZn5
         xM7KSDkmGX8ut5OMgvCyymwljwVd7UfcbA6DR670d7s1fca5xA0RgEKSde87u8zd8qfL
         gcDg==
X-Gm-Message-State: AAQBX9c5HmjKifxKMEHYEjC6/3885sA4/KBCld+X150EDaOEsXsv842D
        RbNEM43wPa6v0x+FFa9u2HJiayJUk4U56A==
X-Google-Smtp-Source: AKy350ZLX6smnGsi+/7TKk0y7cQLzI27vPnVy+7SecbHmpQbmfDPzPhts/gwd8Rpo7+hbchSvgQuGg==
X-Received: by 2002:a05:600c:cc6:b0:3f0:3070:f4ea with SMTP id fk6-20020a05600c0cc600b003f03070f4eamr1712259wmb.11.1680888354281;
        Fri, 07 Apr 2023 10:25:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w24-20020a05600c099800b003ee74c25f12sm8835123wmp.35.2023.04.07.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:25:53 -0700 (PDT)
Date:   Fri, 7 Apr 2023 17:25:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v4 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <ZDBSHTEISe5rAHqn@liuwe-devbox-debian-v2>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680598864-16981-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 02:01:00AM -0700, Saurabh Sengar wrote:
> Make get/set_rtc_noop() to be public so that they can be used
> in other modules as well.
> 
> Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/include/asm/x86_init.h | 2 ++
>  arch/x86/kernel/x86_init.c      | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index acc20ae4079d..88085f369ff6 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -330,5 +330,7 @@ extern void x86_init_uint_noop(unsigned int unused);
>  extern bool bool_x86_init_noop(void);
>  extern void x86_op_int_noop(int cpu);
>  extern bool x86_pnpbios_disabled(void);
> +extern int set_rtc_noop(const struct timespec64 *now);
> +extern void get_rtc_noop(struct timespec64 *now);
>  
>  #endif
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 95be3831df73..d82f4fa2f1bf 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
>  static void iommu_shutdown_noop(void) { }
>  bool __init bool_x86_init_noop(void) { return false; }
>  void x86_op_int_noop(int cpu) { }
> -static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> -static __init void get_rtc_noop(struct timespec64 *now) { }
> +int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> +void get_rtc_noop(struct timespec64 *now) { }

I just had a second thought on this -- do you really need to drop the
__init annotation for these two functions?

Thanks,
Wei.

>  
>  static __initconst const struct of_device_id of_cmos_match[] = {
>  	{ .compatible = "motorola,mc146818" },
> -- 
> 2.34.1
> 
