Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC9617F3C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiKCOSN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKCORy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 10:17:54 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC57326DC;
        Thu,  3 Nov 2022 07:16:47 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bk15so2937822wrb.13;
        Thu, 03 Nov 2022 07:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80B2b1bMn1FZmClWYd3FX65ywdaYJT+10GImN40lUiM=;
        b=YtiSEalBmGnnNRutR6EHaozR1TvbreGBqzWUT6T+5vejXH40Dj9xEEg7PQivKifH+u
         yTUItl/Wxqz7LpYeOs2ZroRxSGVdVGyLcHkUzJX5DaxM4mM71qs0y5x0bsIDpaqvgNa1
         Y3Ahk3zvSJcwF2zOUD5d2/GHtGzhgOxSWL3Bt48bDhBBVhCP8lJMDo71sbwKEDXDkS+S
         emY4D2Np80NB5Q5N6HA/4gLFAEDkOk0Ben4EcrkXXRa7AhnBv7S20PdLf8YS0lhbmoEv
         q4wISvqGWDlXvsxga8vCd1iDodODIB051CfXgoqYSXxOwG0ujuMj5/mfmrzg7r6kiVu2
         owuw==
X-Gm-Message-State: ACrzQf3s9YgT7dHW95H3VJbsTBQy03LqntsLJVU45yWUr2QuD1ckWxpF
        AWBPqtC58D/me8cQvh+nJoE=
X-Google-Smtp-Source: AMsMyM7on/BQsGLd9/ikyaypEllg8CbAEx0xNHuurebxCLJjdkjrBl+DoN6mhjxyOUzqX2ta/wscow==
X-Received: by 2002:a5d:4cca:0:b0:236:aecc:60cb with SMTP id c10-20020a5d4cca000000b00236aecc60cbmr18748510wrt.11.1667485006250;
        Thu, 03 Nov 2022 07:16:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5266000000b00236a16c00ffsm1032357wrc.43.2022.11.03.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:16:45 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:16:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] hv: Enable vmbus driver for nested root partition
Message-ID: <Y2PNRKLTnbHUPPFq@liuwe-devbox-debian-v2>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
 <b5ea40f7e84e17a4338a313ab74292a293b1efa4.1667406350.git.jinankjain@linux.microsoft.com>
 <BYAPR21MB16880A610264D54C141B7D79D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16880A610264D54C141B7D79D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 03, 2022 at 03:30:35AM +0000, Michael Kelley (LINUX) wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, November 2, 2022 9:36 AM
> > 
> > Currently VMBus driver is not initialized for root partition but we need
> > to enable the VMBus driver for nested root partition. This is required
> > to expose VMBus devices to the L2 guest in the nested setup.
> > 
> > Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 8b2e413bf19c..2f0cf75e811b 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2723,7 +2723,7 @@ static int __init hv_acpi_init(void)
> >  	if (!hv_is_hyperv_initialized())
> >  		return -ENODEV;
> > 
> > -	if (hv_root_partition)
> > +	if (hv_root_partition && !hv_nested)
> 
> Note that this code must compile and run when Linux is built
> to run as a guest on Hyper-V for ARM64.  There's currently
> no definition for hv_nested on the ARM64 side, so the compile
> will fail.  But per my comments in Patch 1 in this series, using the
> same technique as for hv_root_partition in hv_common.c should
> solve the ARM64 problem as well.

Jinank, you can use the following commands to cross-compile Linux.

  make ARCH=arm64 mshv_defconfig
  make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image

I think there are some follow-up patches in the internal tree which
fixed the arm64 build. You may be able to squash some of those patches
into series.

Thanks,
Wei.
