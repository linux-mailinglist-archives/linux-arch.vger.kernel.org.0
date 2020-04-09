Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D41A3828
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgDIQk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 12:40:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgDIQk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 12:40:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so12641216wrt.6;
        Thu, 09 Apr 2020 09:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ua6zMq4u2/zu2dEUNPZVlVxJZpWxT+C/n3mr2+BYAuE=;
        b=pSoqUbHnhNxWFDWirfMj/b2UdOqAEjNfWkwrCGHSSm1QotMAvWArSZ/N2qj0Cuz0Fh
         W7rYJjiTqIpYiVS4OqxNaq+URxwz3QXQLDQfyvAthzvvZDb98dGSlGyQWYVxFYBMnz/l
         Cj3pCGdHGY4W2APqZvtPd9prh7Oz9bF6AnYBYozgNbOXmP7Q5NJDBr7ziGKijUEfAWec
         HbOVKJzMwk3CgVKUVr5473eQRZvcUnMtLHLt/y/HIdmcIlhT0wiRCqo5kyR+wk0u802L
         SUJe01eeNDXPeAR8NZJdpvVYpdcnNIO/g/l0gqgxO3v1U1okrlwfeIs6KrFxDhCkpi91
         Qvlg==
X-Gm-Message-State: AGi0PubHCJ/78w9q8DZ5R2iF6fyOpjkBBzvTIEJOd5dwIvEI/yJYMwUY
        pttdcR46+px76gGGKrUXNpo=
X-Google-Smtp-Source: APiQypJGEaWAAhbQnUPq4NgtQ36vjXYEh9XLVMB5vWCtBbtKOzKztPTBu8PPo6OVU8exexXuEhAGJg==
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr8024229wrs.415.1586450457673;
        Thu, 09 Apr 2020 09:40:57 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id j6sm41784213wrb.4.2020.04.09.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:40:56 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:40:54 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Message-ID: <20200409164054.72es2ykmbef3jbui@debian>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 08:19:47PM +0000, Michael Kelley wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020 8:54 AM
> > 
> > When oops happens with panic_on_oops unset, the oops
> > thread is killed by die() and system continues to run.
> > In such case, guest should not report crash register
> > data to host since system still runs. Check panic_on_oops
> > and return directly in hyperv_report_panic() when the function
> > is called in the die() and panic_on_oops is unset. Fix it.
> > 
> > Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> > Change since v3:
> > 	- Fix compile error.
> >         - Add fix commit in the change log
> > ---
> >  arch/x86/hyperv/hv_init.c      | 6 +++++-
> >  drivers/hv/vmbus_drv.c         | 5 +++--
> >  include/asm-generic/mshyperv.h | 2 +-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

It seems to me only the last patch is new, others are already in my
tree, so I only apply the last one.

Let me know if my understanding is wrong.

Wei.
