Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84FB30C2F7
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhBBPFo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 10:05:44 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36517 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbhBBPEj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 10:04:39 -0500
Received: by mail-wr1-f46.google.com with SMTP id 6so20813460wri.3;
        Tue, 02 Feb 2021 07:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVYfyMGBBAdTwlcTSqM4uE3+4I43aqu6Fgew0A9CUJo=;
        b=mFab0TAT4rf17zoJsCwDhYWKGjt2vNQnR4sUsVBV8kINshGedIeHKsjONAL79j+bj3
         zUJMRcw4e0bZeteVcC8nZfr6/YQOpgf0Rk3s/pbKopV1EFZb3r2X7bH4jTXLaZ8p1TLi
         jmQmpaChKuPFzq4c4o1QvbSGwNMoTBuMGrUD5lN6aXVpVQWRH5YVQXNfvjWEmsfNK7XH
         +WWfTawVzwslAv/O3AAt+bcG0uvUdln19rf1UzCE3+r3pbOFCxbwzlCn2IL4bXMjHuz2
         tSQrf0o0BkmBqxkHpZrKI59x6lTFp64aS6d0+8E6v1ujRASd1H6XVjG0xi1DC74q4qEU
         MFLg==
X-Gm-Message-State: AOAM5327wX+UXrMKyGmd1SxPnYrFUtyoYMId1o9K4Z7r+oOdAAqVfXXC
        2U1ca5KEv00d9o8sw+qZVD8=
X-Google-Smtp-Source: ABdhPJzZC+iTEVoSjeOCsdq0a216h8yyFQ8OwFveadeqHCEB8hpTo/BBt1NUI/bDNVAowd+d4xZLnQ==
X-Received: by 2002:adf:f183:: with SMTP id h3mr24722949wro.30.1612278236320;
        Tue, 02 Feb 2021 07:03:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r13sm3840262wmh.9.2021.02.02.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 07:03:55 -0800 (PST)
Date:   Tue, 2 Feb 2021 15:03:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 07/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Message-ID: <20210202150353.6npksy7tobrvfqlt@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-8-wei.liu@kernel.org>
 <MWHPR21MB15932CD9CB9DA046EFFBA310D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932CD9CB9DA046EFFBA310D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 26, 2021 at 12:48:37AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > 
> > We will need the partition ID for executing some hypercalls later.
> > 
> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > v3:
> > 1. Make hv_get_partition_id static.
> > 2. Change code structure a bit.
> > ---
> >  arch/x86/hyperv/hv_init.c         | 27 +++++++++++++++++++++++++++
> >  arch/x86/include/asm/mshyperv.h   |  2 ++
> >  include/asm-generic/hyperv-tlfs.h |  6 ++++++
> >  3 files changed, 35 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 6f4cb40e53fe..fc9941bd8653 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -26,6 +26,9 @@
> >  #include <linux/syscore_ops.h>
> >  #include <clocksource/hyperv_timer.h>
> > 
> > +u64 hv_current_partition_id = ~0ull;
> > +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> > +
> >  void *hv_hypercall_pg;
> >  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> > 
> > @@ -331,6 +334,25 @@ static struct syscore_ops hv_syscore_ops = {
> >  	.resume		= hv_resume,
> >  };
> > 
> > +static void __init hv_get_partition_id(void)
> > +{
> > +	struct hv_get_partition_id *output_page;
> > +	u16 status;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> > +		HV_HYPERCALL_RESULT_MASK;
> > +	if (status != HV_STATUS_SUCCESS) {
> 
> Across the Hyper-V code in Linux, the way we check the hypercall result
> is very inconsistent.  IMHO, the and'ing of hv_do_hypercall() with 
> HV_HYPERCALL_RESULT_MASK so that status can be a u16 is stylistically
> a bit unusual.
> 
> I'd like to see the hypercall result being stored into a u64 local variable.
> Then the subsequent test for the status should 'and' the u64 with
> HV_HYPERCALL_RESULT_MASK to determine the result code.
> I've made a note to go fix the places that aren't doing it that way.
> 

I will fold in the following diff in the next version. I will also check
if there are other instances in this patch series that need fixing.
Pretty sure there are a few.

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index fc9941bd8653..6064f64a1295 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -337,14 +337,13 @@ static struct syscore_ops hv_syscore_ops = {
 static void __init hv_get_partition_id(void)
 {
        struct hv_get_partition_id *output_page;
-       u16 status;
+       u64 status;
        unsigned long flags;

        local_irq_save(flags);
        output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
-       status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
-               HV_HYPERCALL_RESULT_MASK;
-       if (status != HV_STATUS_SUCCESS) {
+       status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
+       if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS) {
                /* No point in proceeding if this failed */
                pr_err("Failed to get partition ID: %d\n", status);
                BUG();
> > +		/* No point in proceeding if this failed */
> > +		pr_err("Failed to get partition ID: %d\n", status);
> > +		BUG();
> > +	}
> > +	hv_current_partition_id = output_page->partition_id;
> > +	local_irq_restore(flags);
> > +}
> > +
> >  /*
> >   * This function is to be invoked early in the boot sequence after the
> >   * hypervisor has been detected.
> > @@ -426,6 +448,11 @@ void __init hyperv_init(void)
> > 
> >  	register_syscore_ops(&hv_syscore_ops);
> > 
> > +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> > +		hv_get_partition_id();
> 
> Another place where the EBX value saved into the ms_hyperv structure
> could be used.

If you're okay with my response earlier, this will be handled later in
another patch (series).

Wei.
