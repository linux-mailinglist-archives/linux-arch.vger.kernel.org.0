Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E772B1E80
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 16:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKMPWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 10:22:00 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35887 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKMPV7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 10:21:59 -0500
Received: by mail-wr1-f51.google.com with SMTP id j7so10324181wrp.3;
        Fri, 13 Nov 2020 07:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZZec1UP1XPcIdy5fKYFw1mzad8DvYZuIK/MWVjeSRM=;
        b=KmL9sj03sEWqqN6nS0jNLOulUUGm4URpZlB5CxQ4r/FAlHcSKxV95Q1hVldHBxoyaG
         2p6h5fCC2+6ihK2TYtyABFqVj278YRSEVnVdPQyMYFSeNRhXRSMNO1K9S1aK9HU/A1JH
         3Xnzz9O2DHIO6oRPieCI0oYD1704mAHPcKyTl2UTwURhGjx2Oc9zqMN6NkNv62PbzYX6
         o/GrY5geSuEXBiVePoPrtstgBuLBWa0v7lIMdWIGcqTxhVbIq4pDihyfgl+kWRn/IIXl
         SSEpW6T1HJkMMutnNclfRGQKxsDSJeVzc7+RuKZY6jvM8pgUC4ABU2z4K8n9skLnCBN+
         7lMA==
X-Gm-Message-State: AOAM532orn0zZugeB4FMXHFVzNwIDEFO6FQnyBGEcqL1IprjamhguE5p
        ETvSx6/xZRZFaqfH62+1P54=
X-Google-Smtp-Source: ABdhPJzBdtuPpgt+j2Np+tFFbKUsasVLHBh68MsaUYgv2L7B+Zk/61mo73OVJC/luZPKqb4waQ5eCw==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr4384031wrt.38.1605280914863;
        Fri, 13 Nov 2020 07:21:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m20sm13924160wrg.81.2020.11.13.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:21:54 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:21:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 07/17] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Message-ID: <20201113152152.omo6pljscvlrzpsc@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-8-wei.liu@kernel.org>
 <877dqqy3yw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dqqy3yw.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 12, 2020 at 04:44:39PM +0100, Vitaly Kuznetsov wrote:
[...]
> > +void __init hv_get_partition_id(void)
> > +{
> > +	struct hv_get_partition_id *output_page;
> > +	u16 status;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> > +		HV_HYPERCALL_RESULT_MASK;
> > +	if (status != HV_STATUS_SUCCESS)
> > +		pr_err("Failed to get partition ID: %d\n", status);
> > +	else
> > +		hv_current_partition_id = output_page->partition_id;
> 
> Nit: I'd suggest we simplify this to:
> 
> 	if (status != HV_STATUS_SUCCESS) {
> 		pr_err("Failed to get partition ID: %d\n", status);
> 		BUG();
> 	}
> 	hv_current_partition_id = output_page->partition_id;
> 
> and drop BUG_ON() below;
> 
> > +	local_irq_restore(flags);
> > +
> > +	/* No point in proceeding if this failed */
> > +	BUG_ON(status != HV_STATUS_SUCCESS);
> > +}
> > +
> >  /*
> >   * This function is to be invoked early in the boot sequence after the
> >   * hypervisor has been detected.
> > @@ -430,6 +453,9 @@ void __init hyperv_init(void)
> >  
> >  	register_syscore_ops(&hv_syscore_ops);
> >  
> > +	if (hv_root_partition)
> > +		hv_get_partition_id();
> > +
> 
> 
> We don't seem to check that the partition has AccessPartitionId
> privilege. While I guess that root partitions always have it, I'd
> suggest we write this as:
> 

Yes. Root should always have that permission. That's my understanding.

> 	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> 		hv_get_partition_id();
> 
> 	BUG_ON(hv_root_partition && !hv_current_partition_id);
> 
> for correctness. Also, we need to make sure '0' is not a valid partition
> id and use e.g. -1 otherwise.
> 

I've changed both places.

Wei.
