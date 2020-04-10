Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC61A4764
	for <lists+linux-arch@lfdr.de>; Fri, 10 Apr 2020 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDJO2C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Apr 2020 10:28:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJO2C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Apr 2020 10:28:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id t203so2659391wmt.2;
        Fri, 10 Apr 2020 07:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1h7a3vS//NbeSVSR69QjDDkWStoO28u5a03MyeOIDUQ=;
        b=gZJanZVLqrkNmVq2xLW4m+0cp0Ui3KdYD2t1p1IWYcgSjVXSpFnt8Ko3Kdf5lu5FTY
         8bCosUloRM5bMy8zd2ZDQTfz95BDQXz+qY7ikiOOVpIZRw3/kYgFZAyXszA/AJOvf/mJ
         9/X82Qf4XwbNQBS2wOqrF2avPivO9rP0+0IE26lkUsZOrwvP6kWbGqv61+fp5tryXUVT
         Am1Pl1zEclN0H1TtxSm1w5lV6IONcNV8aFkx44m9nsI91xV1iOgLWXZMt7wfAurm73wg
         iMwNhABZt4GUINJqNzrohOinoOnvCbXneRCufEumrZN3lxyk4PixB77lTG7LOesO4zS0
         sUbg==
X-Gm-Message-State: AGi0Puam8thUI6nTrdje4tLFmAQCc0l8vr66qg62eZMVvBs8PqvU8ptB
        zKTKB4Wt3APDelfGF3gvEuc=
X-Google-Smtp-Source: APiQypJS/BHR4OpTWldVzMwwd5r/4pmCwUCUgFlEcdZW6trEUIoq5+pEucSTAdzC5GRD5V9eDg6hqg==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr5250030wmj.97.1586528880476;
        Fri, 10 Apr 2020 07:28:00 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id e23sm3250395wra.43.2020.04.10.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:27:59 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:27:57 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "ltykernel@gmail.com" <ltykernel@gmail.com>,
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
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Message-ID: <20200410142757.comrxjvnf3akllmc@debian>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200409164054.72es2ykmbef3jbui@debian>
 <MW2PR2101MB10525BA673D7FA81073B9F65D7C10@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10525BA673D7FA81073B9F65D7C10@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 09, 2020 at 11:06:13PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org>  Sent: Thursday, April 9, 2020 9:41 AM
> > 
> > On Wed, Apr 08, 2020 at 08:19:47PM +0000, Michael Kelley wrote:
> > > From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020 8:54 AM
> > > >
> > > > When oops happens with panic_on_oops unset, the oops
> > > > thread is killed by die() and system continues to run.
> > > > In such case, guest should not report crash register
> > > > data to host since system still runs. Check panic_on_oops
> > > > and return directly in hyperv_report_panic() when the function
> > > > is called in the die() and panic_on_oops is unset. Fix it.
> > > >
> > > > Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
> > > > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > > ---
> > > > Change since v3:
> > > > 	- Fix compile error.
> > > >         - Add fix commit in the change log
> > > > ---
> > > >  arch/x86/hyperv/hv_init.c      | 6 +++++-
> > > >  drivers/hv/vmbus_drv.c         | 5 +++--
> > > >  include/asm-generic/mshyperv.h | 2 +-
> > > >  3 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > It seems to me only the last patch is new, others are already in my
> > tree, so I only apply the last one.
> > 
> > Let me know if my understanding is wrong.
> > 
> 
> Tianyu added "Fixes:" tags to some of the other patches in
> the series.  It appears the version you had already queued doesn't
> have those "Fixes:" tags.

Oh, I only read the subject lines and checked the Reviewed-by tags. I
will queue the new series instead.

Wei.

> 
> Michael
