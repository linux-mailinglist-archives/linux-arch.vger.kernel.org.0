Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92E60F450
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiJ0KC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 06:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiJ0KCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 06:02:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92EE825E7;
        Thu, 27 Oct 2022 03:01:37 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id A1954210D86A;
        Thu, 27 Oct 2022 03:01:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1954210D86A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666864897;
        bh=6KQYehyzA42XebAaFlbNJVdMgguB/LDgiJKpKe/Ug68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jU5CqsWfQcPxchwyYcHysjgEZ992DP5WADuvIqSyTkmhswuGMfCbsBLARvfW3blvA
         I58XuiJsv8YXX1IScTpH67uM5edDbeEZz6r3Jvk1kZg1GbCHPSwOOeAoN7c5Zzfgu8
         nMJOUzL0xrL3NKGgupeBcK8l4Roc/hz3zj6LrRD4=
Date:   Thu, 27 Oct 2022 15:31:24 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
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
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: Re: [PATCH 1/2] x86/hyperv: fix invalid writes to MSRs during root
 partition kexec
Message-ID: <Y1pW9AeKjKNDGb5L@anrayabh-desk>
References: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
 <20221026134715.1438789-2-anrayabh@linux.microsoft.com>
 <BYAPR21MB168837A9E4B73D7B26040B52D7309@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168837A9E4B73D7B26040B52D7309@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 26, 2022 at 02:58:16PM +0000, Michael Kelley (LINUX) wrote:
> From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Wednesday, October 26, 2022 6:47 AM
> > 
> > hv_cleanup resets the hypercall page by setting the MSR to 0. However,
> > the root partition is not allowed to write to the GPA bits of the MSR.
> > Instead, it uses the hypercall page provided by the MSR. Similar is the
> > case with the reference TSC MSR.
> > 
> > Clear only the enable bit instead of zeroing the entire MSR to make
> > the code valid for root partition too.
> 
> When the enable bit is cleared (but not the PFN) in the MSR, do we know
> for sure that Hyper-V removes the overlay page for the PFN?  Making sure
> that the overlay page is removed is the main reason for clearing the entire
> MSR.   If we're going to leave the PFN in place and just clear the enable bit,
> we need to confirm with the Hyper-V guys that the overlay page will be
> removed.

I checked the hypervisor code. Just clearing the enable bit does cause
the overlay page to be unmapped by the hypervisor.

Thanks,
Anirudh.

> 
> Michael
> 
> > 
> > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 29774126e931..76ff63d69461 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -537,6 +537,7 @@ void __init hyperv_init(void)
> >  void hyperv_cleanup(void)
> >  {
> >  	union hv_x64_msr_hypercall_contents hypercall_msr;
> > +	u64 tsc_msr;
> > 
> >  	unregister_syscore_ops(&hv_syscore_ops);
> > 
> > @@ -552,12 +553,14 @@ void hyperv_cleanup(void)
> >  	hv_hypercall_pg = NULL;
> > 
> >  	/* Reset the hypercall page */
> > -	hypercall_msr.as_uint64 = 0;
> > +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +	hypercall_msr.enable = 0;
> >  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > 
> >  	/* Reset the TSC page */
> > -	hypercall_msr.as_uint64 = 0;
> > -	wrmsrl(HV_X64_MSR_REFERENCE_TSC, hypercall_msr.as_uint64);
> > +	rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
> > +	tsc_msr &= ~BIT_ULL(0);
> > +	wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
> >  }
> > 
> >  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
> > --
> > 2.34.1
