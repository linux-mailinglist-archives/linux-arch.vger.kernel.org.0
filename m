Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69DB770C6F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Aug 2023 01:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHDXeq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHDXeq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 19:34:46 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72B3AAF;
        Fri,  4 Aug 2023 16:34:45 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1bfb91ac4edso325456fac.3;
        Fri, 04 Aug 2023 16:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691192084; x=1691796884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgaGHeK+x45T0uBposuXNDHy4W2O36LVGsjSTOp7FtE=;
        b=OaIZKfpTQ6JY4Pun04bkWu9FsvWrOkqI8yRtyUh2xRRbQ7P3MYrkKUn3uFGoFV5XJY
         V4LkMZUHy8VeW4L6pF/XEpW11x9K7SKqrtFICl+WdqrqPgBl7DyXssY6xM1yyo9oJhII
         IR/Lc+e+rsi4IuVZz7uU2g31ukGFrtHnsU7wWrlsHrkLd9eKHUaNY7rjcbvPuDP96GVA
         mLTt+rTEBFwlU7/0711xMeaWBPrjnnkNgUV2LFoNHTh0snnHXzwhr3FO5/ORD2ZwFp2d
         4rWeBQOZgzzkK4DHS2CCZv+DKy96AbQKk9AQfXD6Ug11tqjvRDwtKOg6XxoAWaI3IoEY
         7mBw==
X-Gm-Message-State: AOJu0YwR7eAfgNMWTOXE4DDG1IyaDi1gq59gTAhcyEEIMoFQxhYRFWS9
        gJD58s3vUzERlqkfPeySJzU=
X-Google-Smtp-Source: AGHT+IGigyJq1KYItR+aET9WOFeEcJw+NoDrzW16pCsPvcDQA8z9KX6n2UWJILpHQfBge/3ViL0W6Q==
X-Received: by 2002:a05:6870:3288:b0:1bb:4d4e:ea69 with SMTP id q8-20020a056870328800b001bb4d4eea69mr3758911oac.54.1691192084434;
        Fri, 04 Aug 2023 16:34:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b00268b9862343sm4637377pjb.24.2023.08.04.16.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 16:34:43 -0700 (PDT)
Date:   Fri, 4 Aug 2023 23:34:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Message-ID: <ZM2LDKrcXvVUVta9@liuwe-devbox-debian-v2>
References: <20230804152254.686317-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 04, 2023 at 11:22:44AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
[...]
> Tianyu Lan (9):
>   x86/hyperv: Add sev-snp enlightened guest static key
>   x86/hyperv: Set Virtual Trust Level in VMBus init message
>   x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP
>     enlightened guest
>   drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP
>     enlightened guest
>   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
>     enlightened guest
>   clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp
>     enlightened guest
>   x86/hyperv: Add smp support for SEV-SNP guest
>   x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

I applied all but the last patch to hyperv-next. Thanks.

>   x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest

