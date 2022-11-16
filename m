Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6740462BD56
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiKPMRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 07:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiKPMRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 07:17:23 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F6C74C;
        Wed, 16 Nov 2022 04:12:44 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id p16so11755684wmc.3;
        Wed, 16 Nov 2022 04:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ8ph4l1mfdEGV8CU7TCC1pqTufUaTfVC7K/h54NUVo=;
        b=GkXy3Tyf2/z/m2mWc0e0gkV89UkARM1LvbRt/Y2HNpp72vQCcCcMcpDjwYAW1C+ysI
         g7gm6sh6w6FlfQdT10RMM6qP1J9sWERkKySn/RaTN1LOp6Mx0n1J3+2utQz/to+C7lrW
         YE+J91pv6kE6dfZG5kXx8VH8lSAZGnsVbyixVCYJPitLHNU4628Tux5di7+vT0vkt4kJ
         ou9SS2vdvtWcnS7HOluJl7dlveYsH9Ma8YNRLKBHpE2E7Q1MTLEPmMtievnX9/DQ2LBb
         QRo0n3e/D3/eDd4DN8OQ9iSuoGdiXM7z0R3b9dxerqTEKL7ytS0iObcjvin1TPfz/YR8
         d8HA==
X-Gm-Message-State: ANoB5pkiLN+ngSyNtRfyoZzL0j2WFiKuaUmuvx9SMLmizbBcYQzeELmp
        56mxsZG6xpYf2jRItx7u0+8=
X-Google-Smtp-Source: AA0mqf4vpEtJ4sOoJSvEEzkE1Y2F7445a0boMPzirN1EBS7h+W8a3SBsDoR+WxrUIqzY0ON6gpBTHg==
X-Received: by 2002:a05:600c:3ba0:b0:3cf:a6e9:fad6 with SMTP id n32-20020a05600c3ba000b003cfa6e9fad6mr1857948wms.206.1668600762615;
        Wed, 16 Nov 2022 04:12:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bw24-20020a0560001f9800b00226dba960b4sm14891142wrb.3.2022.11.16.04.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:12:41 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:12:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, peterz@infradead.org, jpoimboe@kernel.org,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v3 0/5]  Add support running nested Microsoft Hypervisor
Message-ID: <Y3TTt/mOe3pzDLZn@liuwe-devbox-debian-v2>
References: <https://lore.kernel.org/linux-hyperv/cover.1667406350.git.jinankjain@linux.microsoft.com/T/#t>
 <cover.1667480257.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667480257.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 03, 2022 at 01:04:02PM +0000, Jinank Jain wrote:
> This patch series plans to add support for running nested Microsoft
> Hypervisor. In case of nested Microsoft Hypervisor there are few
> privileged hypercalls which need to go L0 Hypervisor instead of L1
> Hypervisor. This patches series basically identifies such hypercalls and
> replace them with nested hypercalls.
> 
> Jinank Jain (5):
>   x86/hyperv: Add support for detecting nested hypervisor

I see `__weak hv_nested` in this patch.

I guess this version has fixed ARM64 build?

>   Drivers: hv: Setup synic registers in case of nested root partition
>   x86/hyperv: Add an interface to do nested hypercalls
>   Drivers: hv: Enable vmbus driver for nested root partition
>   x86/hyperv: Change interrupt vector for nested root partition
> 
>  arch/x86/include/asm/hyperv-tlfs.h | 17 +++++++-
>  arch/x86/include/asm/idtentry.h    |  2 +
>  arch/x86/include/asm/irq_vectors.h |  6 +++
>  arch/x86/include/asm/mshyperv.h    | 68 ++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/mshyperv.c     | 22 ++++++++++
>  arch/x86/kernel/idt.c              |  9 ++++
>  drivers/hv/hv.c                    | 18 +++++---
>  drivers/hv/hv_common.c             |  7 ++-
>  drivers/hv/vmbus_drv.c             |  5 ++-
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  10 files changed, 141 insertions(+), 14 deletions(-)
> 
> -- 
> 2.25.1
> 
