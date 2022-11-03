Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28D6182E8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 16:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiKCPbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiKCPao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 11:30:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8E151CB3C;
        Thu,  3 Nov 2022 08:30:25 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id A3C65205DA30;
        Thu,  3 Nov 2022 08:30:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3C65205DA30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667489425;
        bh=LVBwdOCgh5S6moCYBOoLpAcgiJqiRXPqQN4nBFQUFc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKj6uG4ALhiUoBACqTyMJgoglFkzdtbwaHbNPafkQqBy8VihwsnkHXpXGBqq/BEVU
         +XbhLL+Jd3q/81THSkWW0JFeg1/0S5/cmK/uiA59yi9HCD5xyw7OYEAWlR38ysRRU5
         N897vK30B2PQdT0BPVi5a5sfNc/n/SMoqoR4VhAQ=
Date:   Thu, 3 Nov 2022 21:00:15 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
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
Message-ID: <Y2Peh/+kz8FtlnAm@anrayabh-desk>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-2-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688E0040710DF040BB7FCCDD7339@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB168844A39612131C920DA954D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y2PPBREz76rMyhnx@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PPBREz76rMyhnx@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 03, 2022 at 02:24:05PM +0000, Wei Liu wrote:
> On Wed, Nov 02, 2022 at 08:33:31PM +0000, Michael Kelley (LINUX) wrote:
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, October 27, 2022 6:43 AM
> > > From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday,
> > > October 27, 2022 2:57 AM
> > > >
> > > > Add a data structure to represent the reference TSC MSR similar to
> > > > other MSRs. This simplifies the code for updating the MSR.
> > > >
> > > > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > > > ---
> > > >  drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
> > > >  include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
> > > >  2 files changed, 23 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/clocksource/hyperv_timer.c
> > > b/drivers/clocksource/hyperv_timer.c
> > > > index bb47610bbd1c..11332c82d1af 100644
> > > > --- a/drivers/clocksource/hyperv_timer.c
> > > > +++ b/drivers/clocksource/hyperv_timer.c
> > > > @@ -395,25 +395,25 @@ static u64 notrace read_hv_sched_clock_tsc(void)
> > > >
> > > >  static void suspend_hv_clock_tsc(struct clocksource *arg)
> > > >  {
> > > > -	u64 tsc_msr;
> > > > +	union hv_reference_tsc_msr tsc_msr;
> > > >
> > > >  	/* Disable the TSC page */
> > > > -	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > > -	tsc_msr &= ~BIT_ULL(0);
> > > > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > > > +	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > > +	tsc_msr.enable = 0;
> > > > +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> > > >  }
> > > >
> > > >
> > > >  static void resume_hv_clock_tsc(struct clocksource *arg)
> > > >  {
> > > >  	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
> > > > -	u64 tsc_msr;
> > > > +	union hv_reference_tsc_msr tsc_msr;
> > > >
> > > >  	/* Re-enable the TSC page */
> > > > -	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > > -	tsc_msr &= GENMASK_ULL(11, 0);
> > > > -	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
> > > > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > > > +	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > > +	tsc_msr.enable = 1;
> > > > +	tsc_msr.pfn = __phys_to_pfn(phys_addr);
> > 
> > My previous review missed a problem here (and in the similar line below).
> > __phys_to_pfn() will return a PFN based on the guest page size, which might
> > be different from Hyper-V's page size that is always 4K.  This needs to be a
> > Hyper-V PFN, and we have virt_to_hvpfn() available to do just that, assuming
> > that function is safe to use here and in the case below. 
> 
> Anirudh, please take a look.

Just sent a fix for this using HVPFN_DOWN() which looks safe to use
here.

Thanks,
Anirudh.

> 
> I'm holding off sending hyperv-fixes to Linus for now.
> 
> Thanks,
> Wei.
