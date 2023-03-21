Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EE6C305E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCUL1S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 07:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCUL1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 07:27:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D79DBD315;
        Tue, 21 Mar 2023 04:27:09 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 4B2BC20FB424; Tue, 21 Mar 2023 04:27:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B2BC20FB424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679398029;
        bh=XbUvI3yATYdm3rEMcF3ylQDMEFRUhn9SDHqozXsVN7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lg8UFhH/e1x0AgS11J6fNd81E9bFf4vY1Iz0FPpM5PbvkiXY3VlkWZzQHIoKBiyNO
         eBIN1aZq4K/uY14+Q3z3sTgAipnTwj5XPfwTRwnh29e1ku/juD7i8EpktnoExZI1Bl
         pxZXccqc04UHkHdjZdL3r0EM5akfF3Psr1LcC3v0=
Date:   Tue, 21 Mar 2023 04:27:09 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] x86/hyperv: VTL support for Hyper-V
Message-ID: <20230321112709.GA26985@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-5-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688093876677DEE259C9914D7809@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688093876677DEE259C9914D7809@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 06:16:37PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, 2023 3:04 AM
> > 
>  
> [snip]
> 
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 35b16b177035..4af218e70395 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -11,6 +11,10 @@
> >  #include <asm/paravirt.h>
> >  #include <asm/mshyperv.h>
> > 
> > +#define HV_VTL_NORMAL 0x0
> > +#define HV_VTL_SECURE 0x1
> > +#define HV_VTL_MGMT   0x2
> > +
> >  union hv_ghcb;
> > 
> >  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> > @@ -272,6 +276,12 @@ static inline int hv_set_mem_host_visibility(unsigned long
> > addr, int numpages,
> >  #endif /* CONFIG_HYPERV */
> > 
> > 
> > +#ifdef CONFIG_HYPERV_VTL_MODE
> 
> Hmmm.  CONFIG_HYPERV_VTL_MODE isn't defined until Patch 5 of this series.
> I guess this works because of #ifdef behavior with non-existent values, but
> it is a little bit weird to be referencing a CONFIG_ option that hasn't been
> defined yet.

I am fine to pull Kconfig changes before this patch.

> 
> > +void __init hv_vtl_init_platform(void);
> > +#else
> > +static inline void __init hv_vtl_init_platform(void) {}
> > +#endif
> > +
> >  #include <asm-generic/mshyperv.h>
> > 
> >  #endif
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 61363ce0b335..0dd385cdc332 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -520,6 +520,7 @@ static void __init ms_hyperv_init_platform(void)
> > 
> >  	/* Register Hyper-V specific clocksource */
> >  	hv_init_clocksource();
> > +	hv_vtl_init_platform();
> >  #endif
> >  	/*
> >  	 * TSC should be marked as unstable only after Hyper-V
> > --
> > 2.34.1
