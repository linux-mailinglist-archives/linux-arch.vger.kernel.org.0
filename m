Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FA76DC76
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHCAQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHCAQq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:16:46 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF3E4C;
        Wed,  2 Aug 2023 17:16:45 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8b2b60731so3302215ad.2;
        Wed, 02 Aug 2023 17:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021805; x=1691626605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVrG8SmJV4YoZPJumklaBBg3JMAiIwsiaH9SPEZme84=;
        b=aNc2p/RVAqEKrojNIR9QUs3puW/8nOXNkI26IciuR4v7XQFG00NH9O14NQsIpGyxe7
         fajrYbcPkEyGGaY4MlS7WABFV9RM3rVzkAEMov9UZvsQ6XRWycGoRqRxoAd+xNrh3gh7
         NDpTfO6p1Ko5kkhK4CN9JP7vrML+VE8Zr5aatBYoKPVB7AQBRfH8WephZZO3TW7Zy8sK
         k61l+sBWkpweNoKf/GVwmzR6hoOR1fHIgLZ/aX8k/H3R7s0vVXlI+qqDbSY1uwiwQ7kq
         Ig24rv7YWwmnmiSRfRMKfGLZcYM7RLcfdD4oncfjuFsWnpdX/xpM+9VQutHZtZPHh54t
         1+pA==
X-Gm-Message-State: ABy/qLb4YU8PKWUyUky7fcXTjW+ZYRSQMBHVvhuZGYCgiIs+d298gMvD
        vq1xs45dbvbqlkOR2bJF/XI=
X-Google-Smtp-Source: APBJJlFPPRsV/o6afwX7zXRPC1zXopOTPZFHt1xcbcX9/fyCA2S/CaERxMT7ZHQ4WwWf8Dtuj3IbmQ==
X-Received: by 2002:a17:902:7b85:b0:1ac:3605:97ec with SMTP id w5-20020a1709027b8500b001ac360597ecmr14604489pll.62.1691021804751;
        Wed, 02 Aug 2023 17:16:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b001b9be2e2b3esm12932603plg.277.2023.08.02.17.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:16:44 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:16:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 09/15] Drivers: hv: Introduce hv_output_arg_exists in
 hv_common
Message-ID: <ZMrx5m2Tg7bfX9Ce@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-10-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-10-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:44PM -0700, Nuno Das Neves wrote:
> This is a more flexible approach for determining whether to allocate the
> output page.

> This will be used in both mshv_vtl and root partition.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 99d9b262b8a7..16f069beda78 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -57,6 +57,18 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  void * __percpu *hyperv_pcpu_output_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>  
> +/*
> + * Determine whether output arg is in use, for allocation/deallocation
> + */
> +static bool hv_output_arg_exists(void)
> +{
> +	bool ret = hv_root_partition ? true : false;
> +#ifdef CONFIG_MSHV_VTL
> +	ret = true;
> +#endif

This should not be here. As far as I can tell, CONFIG_MSHV_VTL is
introduced in a later patch.

The rest looks okay.

Thanks,
Wei.
