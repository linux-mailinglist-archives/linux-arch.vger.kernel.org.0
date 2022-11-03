Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E00617F5E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 15:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKCOYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 10:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKCOYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 10:24:17 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49815838;
        Thu,  3 Nov 2022 07:24:16 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1294771wmq.4;
        Thu, 03 Nov 2022 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1LT03bLiRuIHRMNZ/VBHuLAuNEKFfSIdBpGFc2+9sA=;
        b=r1t3vLWxamxM4coqto9QOkOiy1is0Ax+3QyuRBz5axMJZeDIgRWLJOw9n+uoSB1T7K
         Kq+HOX3D+9un5owkZN5X7gN75ZqwazJ4FeuE0ZBjam3vfx+7XlBp4RgHDKCEbt27A76J
         4sNY4+3912HqeZ55Ty+RkP7H6dT2YBjlVFE8DnWPsSYmzEgyrNjyqixdv1jOERcSm6X7
         2cvG5j3Rz6WQONgdpNQInMhW9aIpMD1nm3/dUjgLRtUNIt7oeR4+ITLFpxsGgudI51ot
         wGz/OWr9OUvls81h+PmxEDHw7i5zUP+THIBavlyrwxFV1IRk4NuT6PRgEAgDXfbVpptW
         jSjg==
X-Gm-Message-State: ACrzQf2p72c4spr+BjXbjYdQtVaGYAhpWBRq6xhVcOVNYpzcvMV3oLf1
        pz7piTNkhIERo/wEa3rpemY=
X-Google-Smtp-Source: AMsMyM4ke2iyyMAnoCrhGCzCaGHhhDeyDynNHBdskVE6dhi6oDEpiIQ2fWHmd9zmf+pjyz4RpsKJsA==
X-Received: by 2002:a05:600c:4fcf:b0:3c6:cdb9:b68f with SMTP id o15-20020a05600c4fcf00b003c6cdb9b68fmr30684663wmq.73.1667485454723;
        Thu, 03 Nov 2022 07:24:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003cf57329221sm47245wmb.14.2022.11.03.07.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:24:14 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:24:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: Re: [PATCH v2 1/2] clocksource/drivers/hyperv: add data structure
 for reference TSC MSR
Message-ID: <Y2PPBREz76rMyhnx@liuwe-devbox-debian-v2>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-2-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688E0040710DF040BB7FCCDD7339@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB168844A39612131C920DA954D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168844A39612131C920DA954D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 02, 2022 at 08:33:31PM +0000, Michael Kelley (LINUX) wrote:
> From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, October 27, 2022 6:43 AM
> > From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday,
> > October 27, 2022 2:57 AM
> > >
> > > Add a data structure to represent the reference TSC MSR similar to
> > > other MSRs. This simplifies the code for updating the MSR.
> > >
> > > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > > ---
> > >  drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
> > >  include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
> > >  2 files changed, 23 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/clocksource/hyperv_timer.c
> > b/drivers/clocksource/hyperv_timer.c
> > > index bb47610bbd1c..11332c82d1af 100644
> > > --- a/drivers/clocksource/hyperv_timer.c
> > > +++ b/drivers/clocksource/hyperv_timer.c
> > > @@ -395,25 +395,25 @@ static u64 notrace read_hv_sched_clock_tsc(void)
> > >
> > >  static void suspend_hv_clock_tsc(struct clocksource *arg)
> > >  {
> > > -	u64 tsc_msr;
> > > +	union hv_reference_tsc_msr tsc_msr;
> > >
> > >  	/* Disable the TSC page */
> > > -	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > -	tsc_msr &= ~BIT_ULL(0);
> > > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > > +	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > +	tsc_msr.enable = 0;
> > > +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> > >  }
> > >
> > >
> > >  static void resume_hv_clock_tsc(struct clocksource *arg)
> > >  {
> > >  	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
> > > -	u64 tsc_msr;
> > > +	union hv_reference_tsc_msr tsc_msr;
> > >
> > >  	/* Re-enable the TSC page */
> > > -	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > -	tsc_msr &= GENMASK_ULL(11, 0);
> > > -	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
> > > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > > +	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > +	tsc_msr.enable = 1;
> > > +	tsc_msr.pfn = __phys_to_pfn(phys_addr);
> 
> My previous review missed a problem here (and in the similar line below).
> __phys_to_pfn() will return a PFN based on the guest page size, which might
> be different from Hyper-V's page size that is always 4K.  This needs to be a
> Hyper-V PFN, and we have virt_to_hvpfn() available to do just that, assuming
> that function is safe to use here and in the case below. 

Anirudh, please take a look.

I'm holding off sending hyperv-fixes to Linus for now.

Thanks,
Wei.
