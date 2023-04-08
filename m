Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3576DB8FB
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 07:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDHFDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 01:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDHFDj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 01:03:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 233D1E046;
        Fri,  7 Apr 2023 22:03:38 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 56B34213B640; Fri,  7 Apr 2023 22:03:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56B34213B640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680930217;
        bh=p0knpnyI5uRd/YJk3Z59mI/o+WhlUYC2jWfoETa7CTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDfB6YkvjiOHoi3a+IgCCAE7xM1MPb2bnMy2frpsAee/jTtEG2VsBil8pZYG7zbVv
         sNpr4pUpHYeKBYCOZIELqhsoT3FQbC4ywx1Cp+daf+jXozHN2sAP68GV3ccwJkApKF
         EpO6Fnf+NnGjdTyJs1u4W1tt30ihEv/4cSSmFKpM=
Date:   Fri, 7 Apr 2023 22:03:37 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
Subject: Re: [PATCH v4 5/5] x86/hyperv: VTL support for Hyper-V
Message-ID: <20230408050337.GA21166@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-6-git-send-email-ssengar@linux.microsoft.com>
 <20230406140743.GA1443@skinsburskii.localdomain>
 <BYAPR21MB1688E43D583B016AA3DAD906D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688E43D583B016AA3DAD906D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 07, 2023 at 08:56:29PM +0000, Michael Kelley (LINUX) wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, April 6, 2023 7:08 AM
> > 
> > On Tue, Apr 04, 2023 at 02:01:04AM -0700, Saurabh Sengar wrote:
> 
> [snip]
> 
> > > --- /dev/null
> > > +++ b/arch/x86/hyperv/hv_vtl.c
> > > @@ -0,0 +1,227 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2023, Microsoft Corporation.
> > > + *
> > > + * Author:
> > > + *   Saurabh Sengar <ssengar@microsoft.com>
> > > + */
> > > +
> > > +#include <asm/apic.h>
> > > +#include <asm/boot.h>
> > > +#include <asm/desc.h>
> > > +#include <asm/i8259.h>
> > > +#include <asm/mshyperv.h>
> > > +#include <asm/realmode.h>
> > > +
> > > +extern struct boot_params boot_params;
> > > +static struct real_mode_header hv_vtl_real_mode_header;
> > > +
> > > +void __init hv_vtl_init_platform(void)
> > > +{
> > > +	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > > +
> > > +	x86_init.irqs.pre_vector_init = x86_init_noop;
> > > +	x86_init.timers.timer_init = x86_init_noop;
> > > +
> > > +	x86_platform.get_wallclock = get_rtc_noop;
> > > +	x86_platform.set_wallclock = set_rtc_noop;
> > 
> > Nit: this code is VTL feature and hypevisor specific.
> > Defining vtl_get_rtc_noop instead of exporting get_rtc_noop would allow to make
> > this series less intrusive to the rest of x86 generic code.
> > 
> > Reviewed-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> > 
> 
> Saurabh's initial version of the code did define its own version of
> get/set_rtc_noop().  I had suggested that he use the existing functions
> from x86 generic code, and KY had also commented about re-using
> existing code wherever possible.  :-)   My suggestion was partly because
> the VTL code is already re-using x86_init_noop(), and then just to avoid
> code duplication.  Admittedly, there's not much code being duplicated
> in these stub functions.  I slightly prefer re-using the existing functions,
> but don't feel strongly about it.

Thank you, Stanislav and Michael, for your comments.
Since the function is not doing anything significant, I think it's best to
minimize its effect on x86 generic code in this series.

I would like to redefine these functions in VTL code. Unless there are
compelling reasons against it, I plan to incorporate this change in the next
version.

- Saurabh

> Michael
