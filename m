Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A8787C65
	for <lists+linux-arch@lfdr.de>; Fri, 25 Aug 2023 02:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjHYAGT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 20:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjHYAF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 20:05:59 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42811BC9;
        Thu, 24 Aug 2023 17:05:51 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1c11d53221cso248278fac.2;
        Thu, 24 Aug 2023 17:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692921951; x=1693526751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ikij8/b8zirnL2MAlmKvPfxpbBx1IweG0AWwXIMf2t0=;
        b=GqTYxfdn4TiiDbPuGysK7JDoX+5dlMnt9zSfJYevMLFhyZKTN9QIb7Nxcte7amndAg
         +zKBWbig+NOZpeWE5Qp5mO56fQTBv8n+QbRsm/p8/bM2bngoOa2sYCla6vCfxNIHGjYt
         3df+cl2U0Fz0UJNWbai2F5XrufnnPcZKbIH7vIoONScmPXSZbi9jrWYFm7vhlpDCA5TW
         1pvugl7Vq/8+SsKmWmq1OittQcCw3BdwlceABc3badGmMM8ler/v1r/rSc+Jk8kWXpS6
         6VlBEkt5XTFMEuMGwG+MhPZ2qMIuXdQL5wSC5+I8uoq1p8wxyppS1qnhwdmHsPj2Q+Nv
         W+1A==
X-Gm-Message-State: AOJu0YxpoBJkEHr0eIaN1MHtaPFPBm0xJKCGrZn5HzvOGPa4LMstnZy9
        IMBMzpxkSgc/0CrFLXeSt1c=
X-Google-Smtp-Source: AGHT+IEwoDOBRgmhijxFtDxmlkGfDko035hx8x4SXO30KYLfx5dpMV5O8k910e16GKozhJVGlMeusw==
X-Received: by 2002:a05:6870:4153:b0:1be:c688:1c0 with SMTP id r19-20020a056870415300b001bec68801c0mr1543473oad.47.1692921950980;
        Thu, 24 Aug 2023 17:05:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b134-20020a63348c000000b00564aee22f33sm198792pga.14.2023.08.24.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 17:05:50 -0700 (PDT)
Date:   Fri, 25 Aug 2023 00:05:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v3 00/10] Support TDX guests on Hyper-V (the Hyper-V
 specific part)
Message-ID: <ZOfwSDjW0wlHozYV@liuwe-devbox-debian-v2>
References: <20230824080712.30327-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 24, 2023 at 01:07:02AM -0700, Dexuan Cui wrote:
> Dexuan Cui (10):
>   x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
>   x86/hyperv: Support hypercalls for fully enlightened TDX guests
>   Drivers: hv: vmbus: Support fully enlightened TDX guests
>   x86/hyperv: Fix serial console interrupts for fully enlightened TDX
>     guests
>   Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
>   x86/hyperv: Introduce a global variable hyperv_paravisor_present
>   Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the
>     paravisor
>   x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the
>     paravisor
>   x86/hyperv: Remove hv_isolation_type_en_snp
>   x86/hyperv: Move the code in ivm.c around to avoid unnecessary ifdef's
> 
>  arch/x86/hyperv/hv_apic.c          |  15 +-
>  arch/x86/hyperv/hv_init.c          |  59 ++++-
>  arch/x86/hyperv/ivm.c              | 374 ++++++++++++++++++-----------
>  arch/x86/include/asm/hyperv-tlfs.h |   3 +-
>  arch/x86/include/asm/mshyperv.h    |  43 +++-
>  arch/x86/kernel/cpu/mshyperv.c     |  65 ++++-
>  drivers/hv/connection.c            |  15 +-
>  drivers/hv/hv.c                    |  78 +++++-
>  drivers/hv/hv_common.c             |  43 +++-
>  drivers/hv/hyperv_vmbus.h          |  11 +
>  include/asm-generic/mshyperv.h     |   5 +-
>  11 files changed, 505 insertions(+), 206 deletions(-)

Applied to hyperv-next, thanks!
