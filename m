Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8246E0389
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDMBQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 21:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDMBQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 21:16:18 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57E2D58;
        Wed, 12 Apr 2023 18:16:13 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i3so3303411wrc.4;
        Wed, 12 Apr 2023 18:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348572; x=1683940572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfIRGx4NmUH+6AwOlHWuuT1aV7ClftxmalQe00WqSS8=;
        b=CyZHsL+IDly3ElcF5YkGbF+9QmFZJm0NGdS6C6Bj1ndEuCB3DdR6wu4Igu3cgEPZkM
         X+I8qMITLsyko2IgYAryJSbXsizsWCXaVl3oAQUM6z974Q5i29iDS2NQzNnspx1WY8Cc
         ErpdMb48FXMe7pTthwpJr8bLE1dVF59ozkVIa17ltiG0Ad8+bpvUVSam/URBSFKWq7er
         nowOzadGNhBX61KXinI3Rh7l/iY/QYHGaGtSc5ArgXhCjJVTr6UlbwqNiVweGdbEBtFW
         +zIwXXB5xRQWKJcndLsosb77NKgPsOkgq6ZkLJh3HHfz8LUUuSwX7e7N4qhfWoGEOcRZ
         aq6g==
X-Gm-Message-State: AAQBX9dOrrLDBBgLpVXFg9lRGZy8v7ThnOm88NRbY6d9PNFj83tJfqbE
        hofMLvePOoB9MwmxFywQxVw=
X-Google-Smtp-Source: AKy350YzdXdXMww1bxV4fYIJG4lRNJ+IggH071o/rb5LVmffYnDOwBFe7RHucNOzB6hlkJy0W8diow==
X-Received: by 2002:adf:dd8c:0:b0:2cf:e868:f789 with SMTP id x12-20020adfdd8c000000b002cfe868f789mr123340wrl.48.1681348572055;
        Wed, 12 Apr 2023 18:16:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b002efdf3e5be0sm115885wrm.44.2023.04.12.18.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:16:11 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:16:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v5 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <ZDdX11GuiTu0uvpW@liuwe-devbox-debian-v2>
References: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
 <1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 10, 2023 at 10:55:28PM -0700, Saurabh Sengar wrote:
> Make get/set_rtc_noop() to be public so that they can be used
> in other modules as well.
> 
> Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

x86 maintainers, can you please ack or nack this patch?

This looks trivially correct, but I don't want to apply this patch
without an ack since this is under arch/x86.

Thanks,
Wei.

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
>  
>  static __initconst const struct of_device_id of_cmos_match[] = {
>  	{ .compatible = "motorola,mc146818" },
> -- 
> 2.34.1
> 
