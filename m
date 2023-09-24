Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD537AC697
	for <lists+linux-arch@lfdr.de>; Sun, 24 Sep 2023 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjIXEs6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Sep 2023 00:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIXEsz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Sep 2023 00:48:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC01127;
        Sat, 23 Sep 2023 21:48:48 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id B9DCC212C7EF; Sat, 23 Sep 2023 21:48:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9DCC212C7EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695530927;
        bh=ycdXSwymT+4UmVHxCWgMAhINq6kUwu+Xv1H+CeeYOLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hrul3pMrxBJndXzEFkHYh9mydeunHWFlPfGkKSERsWSDnbH+BAzx5yyNkVU/bdh07
         ylJxwm2Yy1U6fwlNVPP9Pmj7kwfjQ8t4/zA/430tW1DiTX4yiaznGs6YSbXtsHmd+w
         Gs03oZNEijfP929dG/c1EZvK1e+5MdwHS4ErPARg=
Date:   Sat, 23 Sep 2023 21:48:47 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <20230924044847.GA14276@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092318-starter-pointing-9388@gregkh>
 <ZQ9RWMPDh3RBZJZI@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ9RWMPDh3RBZJZI@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 23, 2023 at 08:58:00PM +0000, Wei Liu wrote:
> Greg, thank you for looking at the code.
> 
> On Sat, Sep 23, 2023 at 09:56:13AM +0200, Greg KH wrote:
> > On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> > > +static int __init mshv_vtl_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
> > > +	init_waitqueue_head(&fd_wait_queue);
> > > +
> > > +	if (mshv_vtl_get_vsm_regs()) {
> > > +		pr_emerg("%s: Unable to get VSM capabilities !!\n", __func__);
> > > +		BUG();
> > > +	}
> > 
> > 
> > So you crash the whole kernel if someone loads this module on a non-mshv
> > system?
> > 
> > That seems quite excessive and hostile :(
> > 
> 
> I agree this can be more lenient. It should be safe to just return an
> error code (ENODEV) and let user space decide the next action.
> 
> Saurabh, let me know what you think.

Thanks for reporting this. I agree, returning an error makes more sense here.
We should do this for both BUG() in this init.

- Saurabh

> 
> Thanks,
> Wei.
> 
> > Or am I somehow reading this incorrectly?
> > 
> > thanks,
> > 
> > greg k-h
> > 
