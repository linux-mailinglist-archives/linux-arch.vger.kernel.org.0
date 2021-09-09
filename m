Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277F3404862
	for <lists+linux-arch@lfdr.de>; Thu,  9 Sep 2021 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhIIK0g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Sep 2021 06:26:36 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40804 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIIK0f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2021 06:26:35 -0400
Received: by mail-wr1-f47.google.com with SMTP id q26so1786915wrc.7;
        Thu, 09 Sep 2021 03:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQZwZsjIQ5Q/ho824nwsq8pKl7BJRI2ZqOu5uQ0Ypxc=;
        b=nybk5nOfU76mlSt8V5DsNPIm9Ocrfq227x3LBImd1Vj57QUka4cqMzRWEZR5x/jzgy
         WYRX3VEkecDulzgSib2JISdmbrI3bHfLm+yFjtIxyzpzDHPiMtGBFZY36nCRlHGybs7k
         NfFTpt4tixwNTonDItYd2FJg3YwHkqZAAj8PipjEhBMpGG2uz/7ZIQ40eDAsyokjuKo/
         /c2QUmS/kk1kKPZMykKMEC++kA5DlztrgRhx3Kdc1bqeQqTBF+1tl391ytWz59wK4qL8
         UsEXFu+TS58wkwluD7qr/Y5EtP9I1ZXCG4auja80uq/Qqg6bTBM7NT+2SoSUEZxZNWih
         dvYg==
X-Gm-Message-State: AOAM530NBBw8PiWoFpXQUSWuWWu2Ycnn48OFbfPC4cUR3kOivd+xs3T+
        rk9KpmWkFwaqelyANMMtL2s=
X-Google-Smtp-Source: ABdhPJzmYcQPiiHR5bNZCWlq993uM8GJMIN2WQRwEmjcswqF2BgTtTFidVConaV+w/HBXZUCVAlHgQ==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr2698754wrz.242.1631183125246;
        Thu, 09 Sep 2021 03:25:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o2sm1425734wrh.13.2021.09.09.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:25:24 -0700 (PDT)
Date:   Thu, 9 Sep 2021 10:25:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/hyperv: provide cpumask_to_vpset_noself
Message-ID: <20210909102523.wvjy62jqsz7ixwop@liuwe-devbox-debian-v2>
References: <20210908194243.238523-1-wei.liu@kernel.org>
 <20210908194243.238523-2-wei.liu@kernel.org>
 <871r5y48bv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r5y48bv.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 09, 2021 at 07:38:28AM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > This is a new variant which removes `self' cpu from the vpset. It will
> > be used in Hyper-V enlightened IPI code.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > Provide a new variant instead of adding a new parameter because it makes
> > it easier to backport -- we don't need to fix the users of
> > cpumask_to_vpset.
> > ---
> >  include/asm-generic/mshyperv.h | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index 9a000ba2bb75..d89690ee95aa 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -184,10 +184,12 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
> >  	return hv_vp_index[cpu_number];
> >  }
> >  
> > -static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> > -				    const struct cpumask *cpus)
> > +static inline int cpumask_to_vpset_ex(struct hv_vpset *vpset,
> 
> I'd suggest to avoid '_ex' suffix as we use it for 'extended hypercalls'
> (e.g. __send_ipi_mask_ex). Assuming nobody needs to call
> cpumask_to_vpset_ex() directly, should we just go with
> __cpumask_to_vpset() instead?

Sure. I'm not too fussed about the name.

I will wait a bit for other people to express their opinions.

> 
> > +				    const struct cpumask *cpus,
> > +				    bool exclude_self)
> >  {
> >  	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
> > +	int this_cpu = smp_processor_id();
> >  
> >  	/* valid_bank_mask can represent up to 64 banks */
> >  	if (hv_max_vp_index / 64 >= 64)
> > @@ -205,6 +207,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> >  	 * Some banks may end up being empty but this is acceptable.
> >  	 */
> >  	for_each_cpu(cpu, cpus) {
> > +		if (exclude_self && cpu == this_cpu)
> > +			continue;
> >  		vcpu = hv_cpu_number_to_vp_number(cpu);
> >  		if (vcpu == VP_INVAL)
> >  			return -1;
> > @@ -219,6 +223,18 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> >  	return nr_bank;
> >  }
> >  
> > +static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> > +				    const struct cpumask *cpus)
> > +{
> > +	return cpumask_to_vpset_ex(vpset, cpus, false);
> > +}
> > +
> > +static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
> > +				    const struct cpumask *cpus)
> > +{
> > +	return cpumask_to_vpset_ex(vpset, cpus, true);
> 
> 
> We need to make sure this is called with preemption disabled. We
> could've just swapped smp_processor_id() for get_cpu() in
> cpumask_to_vpset_ex() but this is hardly a solution: we can get
> preempted right after put_cpu() so it's really the caller of this
> function which needs to be protected.
> 
> TL;DR: I suggest we add 'WARN_ON_ONCE(preemptible());' or something like
> this here to catch wrong usage.

Good suggestion. I can add this check to the noself variant. Or if
people prefer, this check can also be moved into the leaf helper.

Wei.

> 
> > +}
> > +
> >  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
> >  bool hv_is_hyperv_initialized(void);
> >  bool hv_is_hibernation_supported(void);
> 
> -- 
> Vitaly
> 
