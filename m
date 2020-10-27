Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02BC29ABE7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440593AbgJ0MTt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 08:19:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbgJ0MTt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 08:19:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id d78so1172303wmd.3;
        Tue, 27 Oct 2020 05:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rWu4jZOOjLJYTvuNM570jYMD4IC0DmDC6oVTPfsWJH0=;
        b=akfwgDTy3M/h8+I4NM7tvfrejQPcElqysFrHL6ArXy78MfpPiRiLZfmO1hsruDFhCu
         cwWS22xCE3gDnEVUIpurWPgynQbM+9fCEHxrMQUbhcLo1c84Iwi/rTFlm/S9FAWOV/HK
         Ro/VMvVKg2pYZU3VCBgxNmPKpI290gFS9W0ycitvWUoYm1ZQHxAWHLnptg+8W4p25gXz
         KD2XlFG2G2PfVxWxPyViDQEiXPadk9KjI95n0l1Ftj1BjRWv+vR+yGwb60A4T5tcqNmZ
         XML6IscvF+LE3eH/bWEuTQowieKNBaSbb3AJ3M++8x/Ba2oHYTfnCeoLyhXeI/c3ww2K
         sBKQ==
X-Gm-Message-State: AOAM531KD0SNdfeaf7EWUNMrC9uVQMtK55L6SC1Addu0w04gkHExHU0a
        /W6C7yBw0VusVimrr6tmU3w=
X-Google-Smtp-Source: ABdhPJxVCGDd5v3RmOeSPfGiZHLuyO402GV0T/XhvIRUHlhdpV3p9hCYsgrM1mbRsF1nMQUhaBpTVA==
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr2589012wmm.49.1603801186899;
        Tue, 27 Oct 2020 05:19:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b193sm154705wmb.2.2020.10.27.05.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:19:46 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:19:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
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
Subject: Re: [PATCH RFC v1 07/18] x86/hyperv: extract partition ID from
 Microsoft Hypervisor if necessary
Message-ID: <20201027121944.s3r7l24gf4ayjobu@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-8-wei.liu@kernel.org>
 <87y2lbjpx7.fsf@vitty.brq.redhat.com>
 <20200916163243.3zkhff57gpoug6x4@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916163243.3zkhff57gpoug6x4@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 16, 2020 at 04:32:43PM +0000, Wei Liu wrote:
> On Tue, Sep 15, 2020 at 12:27:16PM +0200, Vitaly Kuznetsov wrote:
> > Wei Liu <wei.liu@kernel.org> writes:
> [...]
> > >  
> > > +void __init hv_get_partition_id(void)
> > > +{
> > > +	struct hv_get_partition_id *output_page;
> > > +	int status;
> > > +	unsigned long flags;
> > > +
> > > +	local_irq_save(flags);
> > > +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > > +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> > > +		HV_HYPERCALL_RESULT_MASK;
> > 
> > Nit: in this case status is 'u16', we can define it as such (instead of
> > signed int).
> 
> Fixed.
> 
> > 
> > > +	if (status != HV_STATUS_SUCCESS)
> > > +		pr_err("Failed to get partition ID: %d\n", status);
> > > +	else
> > > +		hv_current_partition_id = output_page->partition_id;
> > > +	local_irq_restore(flags);
> > > +
> > > +	/* No point in proceeding if this failed */
> > > +	BUG_ON(status != HV_STATUS_SUCCESS);
> > > +}
> > > +
> > >  /*
> > >   * This function is to be invoked early in the boot sequence after the
> > >   * hypervisor has been detected.
> > > @@ -440,6 +463,9 @@ void __init hyperv_init(void)
> > >  
> > >  	register_syscore_ops(&hv_syscore_ops);
> > >  
> > > +	if (hv_root_partition)
> > > +		hv_get_partition_id();
> > 
> > According to TLFS, partition ID is available when AccessPartitionId
> > privilege is granted. I'd suggest we check that instead of
> > hv_root_partition (and we can set hv_current_partition_id to something
> > like U64_MAX so we know it wasn't acuired). So the BUG_ON condition will
> > move here:
> > 
> >         hv_get_partition_id();
> >         BUG_ON(hv_root_partition && hv_current_partition_id == U64_MAX);
> > 
> 
> Good point. I will reorganize this a bit.

Actually, our current code never stashed the feature mask that contains
that privilege anywhere.  Getting access to it will require a few more
extra patches -- I would really like to rename those fields (features,
misc_features) inside ms_hyperv to something more appropriate.

We will gate it wit hv_root_partition anyway, since we a child VM may
not have the privilege, making an unconditional BUG_ON fatal.

All in all, the current code is not too bad. I intend to keep the
current structure for my RFC v2. I will see if I can find some time to
rework the feature mask extraction code and get that upstreamed first.

Wei.

> 
> Wei.
