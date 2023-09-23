Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD64F7AC524
	for <lists+linux-arch@lfdr.de>; Sat, 23 Sep 2023 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIWU6x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Sep 2023 16:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIWU6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Sep 2023 16:58:51 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7F11B;
        Sat, 23 Sep 2023 13:58:45 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso3210625b3a.0;
        Sat, 23 Sep 2023 13:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695502725; x=1696107525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JQqm/IVrcsmgTAsdrlxoxSmuKKq2qQmGkyMVhE/DVg=;
        b=UGIg9F5slJfMRHCYX1pX5KQXdFa7no/Q9AyUjB1ERYfdPPPrUsMqaZqqySv19y474U
         SDvpvFI1LzMnrai+cbvuhFx0dcFK54Djgn2BRQ+rN9qqBYQk6wr7hzpWXOQ3syue9+Bs
         c45BpRjDaUshOOxtTpuuMO38jVqMd2VVIF/Rl5CnxHnZrwxTIvNWrLdod4mjWpT2S6/U
         tnI1sk5fSOodft/sPcQdvm9ImqIFzSI9kva0OWTR4V++7S9R9iaPzOYjTy7KjIEBwMv1
         vlAbnfpMMXOMSl9Xp0n2x2NcIwoi66fCwv+7foAWoKv3F0VhNDPAXN8ZkYlbO62Ek1Ii
         W85w==
X-Gm-Message-State: AOJu0YxsaDqXcNcFYlFEf1D59FHzCYQaWsWI4YqXrkDUXZBrkseajc80
        r1M6FKvJL7tOIFredXBSQkU=
X-Google-Smtp-Source: AGHT+IGLsgmqCfwszNPSgEZ54z3W+6vxUJ/kWD5yJUxDrK/C3A/n6GNmdW50LzQ5Yrx+aO9ZIIeQaQ==
X-Received: by 2002:a05:6a00:32cc:b0:68f:c8b4:1a2b with SMTP id cl12-20020a056a0032cc00b0068fc8b41a2bmr9179930pfb.17.1695502724656;
        Sat, 23 Sep 2023 13:58:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b0068a0c403636sm5309505pfa.192.2023.09.23.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 13:58:43 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:58:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZQ9RWMPDh3RBZJZI@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092318-starter-pointing-9388@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092318-starter-pointing-9388@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Greg, thank you for looking at the code.

On Sat, Sep 23, 2023 at 09:56:13AM +0200, Greg KH wrote:
> On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> > +static int __init mshv_vtl_init(void)
> > +{
> > +	int ret;
> > +
> > +	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
> > +	init_waitqueue_head(&fd_wait_queue);
> > +
> > +	if (mshv_vtl_get_vsm_regs()) {
> > +		pr_emerg("%s: Unable to get VSM capabilities !!\n", __func__);
> > +		BUG();
> > +	}
> 
> 
> So you crash the whole kernel if someone loads this module on a non-mshv
> system?
> 
> That seems quite excessive and hostile :(
> 

I agree this can be more lenient. It should be safe to just return an
error code (ENODEV) and let user space decide the next action.

Saurabh, let me know what you think.

Thanks,
Wei.

> Or am I somehow reading this incorrectly?
> 
> thanks,
> 
> greg k-h
> 
