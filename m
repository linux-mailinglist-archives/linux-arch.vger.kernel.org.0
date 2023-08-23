Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C4785119
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjHWHGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 03:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHWHGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 03:06:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9AA185;
        Wed, 23 Aug 2023 00:06:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so1612340a91.0;
        Wed, 23 Aug 2023 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692774379; x=1693379179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HurChyAGdIeZIEmXo40ae/GPpY2M43AtWuOafUdiH0=;
        b=O/s997Q5PN56nEC2lwTbxkTiTnffL6a1EipTrBhTFMFFHRCVz/uMUW90Q1KeXO8dlN
         NUQzLdNIakvBzbpCLFODGV+4MvJb/al7khbs5iIXQuu/EeAUfnFiIeiNnW8tfiR4w7+c
         9REFASousRsf+/O7nhnqxiKzL9hw/nyo7iykm+AeJvBz9UvQvzTJpHDZE5/ydHjLjrcy
         bGUTmZU0eprG9RFDDvP6d2+TKVZViYEVkRpi+aEj33zYSSycg+qIsmt4mjV1p0hg0Ey5
         2G/VXpzsT4JOraLYI/E2RjpumFsWmJ1ToPAlK0f0+4f/PJQMsII27ggu0jVUJ6HIKAS/
         u1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692774379; x=1693379179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HurChyAGdIeZIEmXo40ae/GPpY2M43AtWuOafUdiH0=;
        b=McCElIgDiKPgO/rQh1Fa6pfPAOmTJPobEh/XWx/ref4FyujufEJs5rqxG3gVHIjZn3
         wVAI1LhJtagSeFZVwwKW9aG/fwCyFw7ZgKdKHHbYtPwoBisGvX2/mcJnOz+lRTbAwckv
         As3SbEQjpLODxTTz2IgakpdCWPgpTi+ePDA1OzlsS7RYUNb7/p+/T/jW9ncZmHBOtEwa
         lWisKWSnlzM7l7W61alLoS6ogiUmguDoQIBlGWEgQQBOZf+VFMzY1+X5PcapKfx/ZJrl
         GO6jwLTSmFTzp7bcYy9t0Xx/ndXWZg0Q2NudOEzzJzp7eg2ta5IzcJ6Q1Uo+keuQzp/4
         g7ZQ==
X-Gm-Message-State: AOJu0YwNprlQblXjOSuPn4mRAaQb0uZuW8ONPuRQlq0fN2OAtQJQo1a8
        qGEX6OrqH+NU9HbBea+vKuY=
X-Google-Smtp-Source: AGHT+IEkoSYhjYhg28YfiIvQ6zxsm4pAFS3yRUCZgdMe9EYSmy8xC4XrwV9EpnILl5RHuwvgMB+J1g==
X-Received: by 2002:a17:90a:db15:b0:263:2335:594e with SMTP id g21-20020a17090adb1500b002632335594emr10965283pjv.38.1692774379461;
        Wed, 23 Aug 2023 00:06:19 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090a740300b0026b3a86b0d5sm8883044pjg.33.2023.08.23.00.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:06:17 -0700 (PDT)
Message-ID: <6ba2366a-5a7a-839c-6b7a-3500a43c3d93@gmail.com>
Date:   Wed, 23 Aug 2023 15:05:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/9] x86/hyperv: Support hypercalls for fully enlightened
 TDX guests
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
References: <20230811221851.10244-1-decui@microsoft.com>
 <20230811221851.10244-3-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230811221851.10244-3-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/12/2023 6:18 AM, Dexuan Cui wrote:
> A fully enlightened TDX guest on Hyper-V (i.e. without the paravisor) only
> uses the GHCI call rather than hv_hypercall_pg.
> 
> In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> must have the cc_mask.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Michael Kelley<mikelley@microsoft.com>
> Signed-off-by: Dexuan Cui<decui@microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

>   arch/x86/hyperv/hv_init.c       |  8 ++++++++
>   arch/x86/hyperv/ivm.c           | 17 +++++++++++++++++
>   arch/x86/include/asm/mshyperv.h | 15 +++++++++++++++
>   drivers/hv/hv_common.c          | 10 ++++++++--
>   include/asm-generic/mshyperv.h  |  1 +
>   5 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 547ebf6a03bc9..d8ea54663113c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -481,6 +481,10 @@ void __init hyperv_init(void)
>   	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
>   	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
>   
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		goto skip_hypercall_pg_init;
> +

Nitpick:
	Put hypercal page initialization code into a sepearate function and 
skip the function in the tdx guest instead of adding the label.
