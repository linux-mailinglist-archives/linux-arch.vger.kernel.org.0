Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C973771925
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 06:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHGEsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 00:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHGEsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 00:48:38 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011210FA;
        Sun,  6 Aug 2023 21:48:37 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-686f94328a4so2650225b3a.0;
        Sun, 06 Aug 2023 21:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691383717; x=1691988517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHaI90zLVm9UmyIHAgixKBjmZYk2mzQNBjP3afow5B8=;
        b=Zv570BrMys7LTtNdnX2I0K+PwRdgc3AbM8ZY0IfLfEr2WyRy0NDVQZj13Gm4FnOh91
         QKPb7o2sijJtCnTJjFcY5LPYulZpMYnyGWdnyM61o2lVkfAYvGXQgoEveT3TYW5lxvu6
         +W17mFxEKqIo+M5tNaxu4mH6wf5DN0mvMtIPdojyBwJtK6gQEGbF4qdRrvMoqE40RuZ4
         Qw3a40nne62Fm8jebbwNKbjOf5QF0Hyoq8S+iIAMFIR03sdiUpMkCVgPjUGOp+06QRhu
         tF63YbKU9drDAUxFUARJnENAXBlmsFPSHL7gZibNb/3vWIOhBkIsiNq9xc5sjGNqIAhd
         pqBg==
X-Gm-Message-State: AOJu0YykL9TytVUuVxEW1Q89FNbSdiwrTVqT3PDGxpbtVd3QHAVVVmzK
        6AuSxDGN5uKtajZYvJu89hk=
X-Google-Smtp-Source: AGHT+IHTRmQqWW+jMFvBzOFJ/0G/HTzbr1gYKAzWxSuPx7gVHwSSht8vd4++MUuQOw+XrdACs3h/Rg==
X-Received: by 2002:a05:6a00:2355:b0:682:5e8f:d8ba with SMTP id j21-20020a056a00235500b006825e8fd8bamr7077573pfj.11.1691383717144;
        Sun, 06 Aug 2023 21:48:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0065e154bac6dsm5109516pfe.133.2023.08.06.21.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 21:48:36 -0700 (PDT)
Date:   Mon, 7 Aug 2023 04:48:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Message-ID: <ZNB3m6Qiml7JDTQ7@liuwe-devbox-debian-v2>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-3-ltykernel@gmail.com>
 <PUZP153MB0749BAAA8E288D76938704A5BE2DA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB0749BAAA8E288D76938704A5BE2DA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 07, 2023 at 09:07:54AM +0000, Saurabh Singh Sengar wrote:
> 
> 
[...]
> > +static u8 __init get_vtl(void)
> > +{
> > +	u64 control = HV_HYPERCALL_REP_COMP_1 |
> > HVCALL_GET_VP_REGISTERS;
> > +	struct hv_get_vp_registers_input *input;
> > +	struct hv_get_vp_registers_output *output;
> > +	u64 vtl = 0;
> > +	u64 ret;
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = (struct hv_get_vp_registers_output *)input;
> > +	if (!input) {
> > +		local_irq_restore(flags);
> > +		goto done;
> > +	}
> > +
> > +	memset(input, 0, struct_size(input, element, 1));
> > +	input->header.partitionid = HV_PARTITION_ID_SELF;
> > +	input->header.vpindex = HV_VP_INDEX_SELF;
> > +	input->header.inputvtl = 0;
> > +	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
> > +
> > +	ret = hv_do_hypercall(control, input, output);
> > +	if (hv_result_success(ret))
> > +		vtl = output->as64.low & HV_X64_VTL_MASK;
> > +	else
> > +		pr_err("Hyper-V: failed to get VTL! %lld", ret);
> 
> In case of error this function will return vtl=0, which can be the valid value of vtl.
> I suggest we initialize vtl with -1 so and then check for its return.
> 
> This could be a good utility function which can be used for any Hyper-V VTL system, so think
> of making it global ?
> 

Tianyu -- your thought on this?
