Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304D779942
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHKVP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 17:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKVPZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 17:15:25 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1EB171F;
        Fri, 11 Aug 2023 14:15:25 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so1869080b3a.0;
        Fri, 11 Aug 2023 14:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788524; x=1692393324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCGZn5SPgUComZTwtmCaZ+gQn0nxBc61ZSFlcpc5Pco=;
        b=SwKtnMVH93+aWgYFZejmq1Ir5VIc1bcAPT5Cl/HvJW+EOKQUW9yk5ySyi0A2l0Qx39
         FWWdO5PUjI9Adoepi1iojO1PZKFKEsE7Pl/gciWKx4q191zFbtwjxOxUAxw2IAaJ8wUZ
         MLlxVCHIQPl7o4vHHE9v1npNsD2VYcIesoOAhQXz7dV4iFE60Z/MMabxJSB10aAe/nWZ
         XNXsLhg6vo2MEFmij0pKSNlTH8VedQ9NncpU6rcQ/5nPp+Khn42mdZP9q+GyfGbK1ra1
         TfxWb4/vcK1gcsJdATY3DFZnldZJFgGU5sPMJtBJSPm7yC8tFrZ0PW3u1jVGD6i2zbxH
         Rxyw==
X-Gm-Message-State: AOJu0YwpriuqNKI5f3J8Zc3lpIfTfn2wnQ7QwF4HBO19Et5RflnTOm1k
        bWpTq3CSPD9lAG2PU7izL5bdFjl+Vwo=
X-Google-Smtp-Source: AGHT+IFyKD1l2Cb2VzbLz+X3FocfQpqvWKfswjPNDe0j6F5Jyjjc1L8nEJLj8+A0nIKBPJtxtkmnUg==
X-Received: by 2002:a05:6a20:970e:b0:133:bc8:e362 with SMTP id hr14-20020a056a20970e00b001330bc8e362mr2733331pzc.24.1691788524509;
        Fri, 11 Aug 2023 14:15:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b0068713008f98sm3718537pfo.129.2023.08.11.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:15:23 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:15:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH V5 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Message-ID: <ZNak31AH7u7rR9oS@liuwe-devbox-debian-v2>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-3-ltykernel@gmail.com>
 <SA1PR21MB1335C309189196688CDAA7CCBF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335C309189196688CDAA7CCBF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 10, 2023 at 10:59:35PM +0000, Dexuan Cui wrote:
> > From: Tianyu Lan <ltykernel@gmail.com>
> > Sent: Thursday, August 10, 2023 9:04 AM
> >  [...]
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > @@ -378,6 +378,41 @@ static void __init hv_get_partition_id(void)
> >  	local_irq_restore(flags);
> >  }
> > 
> > +static u8 __init get_vtl(void)
> > +{
> > +	u64 control = HV_HYPERCALL_REP_COMP_1 |
> > HVCALL_GET_VP_REGISTERS;
> > +	struct hv_get_vp_registers_input *input;
> > +	struct hv_get_vp_registers_output *output;
> > +	unsigned long flags;
> > +	u64 ret;
> 
> This should be
> 	u64 ret = 0;
> 
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = (struct hv_get_vp_registers_output *)input;
> > +	if (!input) {
> > +		local_irq_restore(flags);
> > +		goto done;
> 
> Here the uninitialized 'ret' is returned. 
> 
> If we move the "done:" label one line earlier, we won't need the 
> the above " local_irq_restore(flags);"
> Maybe we should add a WARN_ON_ONCE(1) before "goto done"?

Out of interest why will input be NULL here?

Thanks,
Wei.
