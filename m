Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28156DB1F3
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDGRnO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGRnN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:43:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEBCE11D;
        Fri,  7 Apr 2023 10:43:12 -0700 (PDT)
Received: from skinsburskii.localdomain (unknown [131.107.1.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 32B962121EA8;
        Fri,  7 Apr 2023 10:43:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32B962121EA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680889392;
        bh=VNS8j224KC10lIB5867HLeqzbNqb1R2Gw6/D8+WPj0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLH+MoABPreTvuT/wx0glKynSk7bWJ4eFZZ4+DjM+LKqsfZ0+hAmw5WjPuL7uNR6Q
         3t06ehm4tLMQuBJDpYzPzqGKX6fi8eYUJWi3ODZwnzq7dDBevF6UO+Owa4zsHQuIKv
         Gxf8FIVC0Pf3f6M0kS3bJ0gcNgY7yLPkLkK7KiV8=
Date:   Thu, 6 Apr 2023 06:45:40 -0700
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v4 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <20230406134540.GA1317@skinsburskii.localdomain>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680598864-16981-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.4 required=5.0 tests=DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
>  

These functions are just empty place holders.
What is the value in having then exported at all?

Also, if you do want to use exactly there functions, a better option
would be to move them to the header file as "static inline" ones.

>  static __initconst const struct of_device_id of_cmos_match[] = {
>  	{ .compatible = "motorola,mc146818" },
> -- 
> 2.34.1
