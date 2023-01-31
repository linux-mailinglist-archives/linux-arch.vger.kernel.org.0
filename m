Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4258682EBB
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 15:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAaODw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 09:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjAaODv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 09:03:51 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0B61BD;
        Tue, 31 Jan 2023 06:03:40 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso4552391wms.0;
        Tue, 31 Jan 2023 06:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP46eoHMy0QQYTCPonziWXrKVD1CtL7gNynXxWXBiio=;
        b=6jQm+uCmIMmc/4gOCx3vkY/f3Z3oaCum6+M5Cu4QWThbPQHgMoMcYMx4V6CIqf+UCm
         iQVfwa4xrX0x4csk5X3VMFvdzTwdK+vHNJ7pFgWMBTXEWlCsNtbqJ9lFWJNGJvDRIX2+
         jdeHXdoXTRqVoOF6a11ViVqXANHs/90MnjofiwRRORdr5Fj8mRVPHvVvOcPOOVc47YlP
         RpF8f9tcwn8PjujgeNUGoxxRlFUI9wIM8DBc6O+2fPSHjKFWLGu75uhquOvoc1USltSg
         x3mcFXzpX6rplncll1wrowDGluRe7xjyanN/ghp+uvFgek45KX4mEPQV+2WY0MYSca2b
         63yA==
X-Gm-Message-State: AFqh2koCZmvKNF2KQvQn35S//idBJdR3yx3/EDq1Jdkiz+rWYSojqxZ5
        pXfcALS1IjeByx4ttnSqGwo=
X-Google-Smtp-Source: AMrXdXsiOeq0P18xWjlHlrkHIORAOC9Tm4WATFMzLHCkskZWUoYwpSM042wufE/gqI38lYzh8zU3Dg==
X-Received: by 2002:a05:600c:4fc9:b0:3d9:f769:2115 with SMTP id o9-20020a05600c4fc900b003d9f7692115mr54372049wmq.26.1675173818996;
        Tue, 31 Jan 2023 06:03:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w10-20020adfcd0a000000b002bff7caa1c2sm3834349wrm.0.2023.01.31.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:03:38 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:03:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [RFC PATCH V3 09/16] x86/hyperv: SEV-SNP enlightened guest don't
 support legacy rtc
Message-ID: <Y9kfuFGVoIlOfnoK@liuwe-devbox-debian-v2>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-10-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122024607.788454-10-ltykernel@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 21, 2023 at 09:45:59PM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> SEV-SNP enlightened guest doesn't support legacy rtc. Set
> legacy.rtc, x86_platform.set_wallclock and get_wallclock to
> 0 or noop(). Make get/set_rtc_noop() to be public and reuse
> them in the ms_hyperv_init_platform().
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 7 ++++++-
>  arch/x86/include/asm/x86_init.h | 2 ++
>  arch/x86/kernel/cpu/mshyperv.c  | 3 +++
>  arch/x86/kernel/x86_init.c      | 4 ++--
>  4 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 1a4af0a4f29a..7266d71d30d6 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -33,6 +33,12 @@ extern bool hv_isolation_type_en_snp(void);
>  
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>  
> +/*
> + * Hyper-V puts processor and memory layout info
> + * to this address in SEV-SNP enlightened guest.
> + */
> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR	0x802000

This hunk should be moved to the previous patch. It is not needed in
this patch.

Thanks,
Wei.
