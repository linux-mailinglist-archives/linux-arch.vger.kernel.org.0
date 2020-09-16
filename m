Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95E926CAAF
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIPULt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 16:11:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50735 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgIPRdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2020 13:33:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id e17so3577749wme.0;
        Wed, 16 Sep 2020 10:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldHCQZEbH6mXJ0nQIfyxhFzRsfVxNZ4TaLzszON1d9k=;
        b=tKcYuEPnMMRxhy/wAXuhZfR7duE+RlVJZ1geQRopYt+9xTP7aBKncwRlXPbDuExdPY
         WrNrxFlesM+qK2v3+o0Lw+IZbCWZc2sOD0YcWZaB0T4/ucjDp6F1egTnzF0ZyhQrI0n8
         ok/GZL13xlr+eNRmt2PG8pNA1s6DFdORUgA2kVWkTJYqOhKszqaA/kfSRjYhSMeALmGj
         xKVm32iGWsagqRbqQhw5sBaK2xyIii4HV2cZ5Lm2ixO6rKX1clUkQGUM9Kpn+c2P6BOr
         pTQ92oNdMuVZTfSA+GJusubzR0jRLR5CWbNDaNgnsp7VgB4naGUlmfB+iDYqKSKlpf1Y
         4uWA==
X-Gm-Message-State: AOAM533i2WIidp+sHXdIDWxDzQ8e4xnulz/naQFsrWK8izquhddn6G9D
        xETdkXrcRRTxXExdE3GC2Djm8pRHyaA=
X-Google-Smtp-Source: ABdhPJxKE9LndKWPqE9c0rk+ywJAV/cod/ghoctHMJq5VT/1ihI9WVcOOfs570RwJJYaVmhfZp36RQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr5502058wmg.164.1600273965104;
        Wed, 16 Sep 2020 09:32:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z14sm32544835wrh.14.2020.09.16.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 09:32:44 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:32:43 +0000
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
Message-ID: <20200916163243.3zkhff57gpoug6x4@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-8-wei.liu@kernel.org>
 <87y2lbjpx7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2lbjpx7.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 15, 2020 at 12:27:16PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
[...]
> >  
> > +void __init hv_get_partition_id(void)
> > +{
> > +	struct hv_get_partition_id *output_page;
> > +	int status;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> > +		HV_HYPERCALL_RESULT_MASK;
> 
> Nit: in this case status is 'u16', we can define it as such (instead of
> signed int).

Fixed.

> 
> > +	if (status != HV_STATUS_SUCCESS)
> > +		pr_err("Failed to get partition ID: %d\n", status);
> > +	else
> > +		hv_current_partition_id = output_page->partition_id;
> > +	local_irq_restore(flags);
> > +
> > +	/* No point in proceeding if this failed */
> > +	BUG_ON(status != HV_STATUS_SUCCESS);
> > +}
> > +
> >  /*
> >   * This function is to be invoked early in the boot sequence after the
> >   * hypervisor has been detected.
> > @@ -440,6 +463,9 @@ void __init hyperv_init(void)
> >  
> >  	register_syscore_ops(&hv_syscore_ops);
> >  
> > +	if (hv_root_partition)
> > +		hv_get_partition_id();
> 
> According to TLFS, partition ID is available when AccessPartitionId
> privilege is granted. I'd suggest we check that instead of
> hv_root_partition (and we can set hv_current_partition_id to something
> like U64_MAX so we know it wasn't acuired). So the BUG_ON condition will
> move here:
> 
>         hv_get_partition_id();
>         BUG_ON(hv_root_partition && hv_current_partition_id == U64_MAX);
> 

Good point. I will reorganize this a bit.

Wei.
