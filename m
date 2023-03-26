Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6476C96EA
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCZQrD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 12:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZQrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 12:47:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CAE54C15;
        Sun, 26 Mar 2023 09:47:01 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id B20C320FD05D; Sun, 26 Mar 2023 09:47:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B20C320FD05D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679849220;
        bh=5g48Pkq3wb7Oxb65S5AJphPh6t8/qMGHjHIhQQVtTKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoZQYVwMfGqy8Y4q9OBBj20/l1g9cCj/FaB5D/lFFe67wxNu6zYhwEl75DWdLkuBF
         6aVAF9/pKp5dh1c64P5mNrPbNBF0/XhBq3XWCSJpUBE1JZJCWs0HRA4SB/DSK5STCm
         WnMrgQdx1DMa7QFvoF0bCTrLTTJQDE9/7gkjVq/0=
Date:   Sun, 26 Mar 2023 09:47:00 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] x86/Kconfig: Add HYPERV_VTL_MODE
Message-ID: <20230326164700.GA10074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-6-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16885C786D5DC8381C21868AD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16885C786D5DC8381C21868AD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On Sun, Mar 26, 2023 at 03:16:15PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, 2023 3:04 AM
> > 
> > Add HYPERV_VTL_MODE Kconfig flag for VTL mode.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/Kconfig         | 24 ++++++++++++++++++++++++
> >  arch/x86/hyperv/Makefile |  1 +
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 453f462f6c9c..c3faaaea1e31 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -782,6 +782,30 @@ menuconfig HYPERVISOR_GUEST
> > 
> >  if HYPERVISOR_GUEST
> > 
> > +config HYPERV_VTL_MODE
> > +	bool "Enable Linux to boot in VTL context"
> > +	depends on X86_64 && HYPERV
> > +	default n
> > +	help
> > +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> > +	  enlightenments offered to host and guest partitions which enables
> > +	  the creation and management of new security boundaries within
> > +	  operating system software.
> > +
> > +	  VSM achieves and maintains isolation through Virtual Trust Levels
> > +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> > +	  being more privileged than lower levels. VTL0 is the least privileged
> > +	  level, and currently only other level supported is VTL2.
> > +
> > +	  Select this option to build a Linux kernel to run at a VTL other than
> > +	  the normal VTL0, which currently is only VTL2.  This option
> > +	  initializes the x86 platform for VTL2, and adds the ability to boot
> > +	  secondary CPUs directly into 64-bit context as required for VTLs other
> > +	  than 0.  A kernel built with this option must run at VTL2, and will
> > +	  not run as a normal guest.
> > +
> > +	  If unsure, say N
> > +
> 
> Is there a reason for putting this in arch/x86/Kconfig instead of in
> drivers/hv/Kconfig under the "Microsoft Hyper-V guest support"
> menu with the other Hyper-V settings?  It seems like grouping
> this with the other Hyper-V settings would make it easier to find,
> unless there's some reason that doesn't work.

As all the code dependent on this flag is in arch/x86/hyperv, and all
other kernel flags used in arch/x86/hyperv/Makefile are define in
arch/x86/Kconfig, arch/x86/Kconfig was my default choice.

But your suggestion makes perfect sense, I will move it to
drivers/hv/Kconfig

Regards,
Saurabh

> 
> Michael
> 
> >  config PARAVIRT
> >  	bool "Enable paravirtualization code"
> >  	depends on HAVE_STATIC_CALL
> > diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> > index 5d2de10809ae..3a1548054b48 100644
> > --- a/arch/x86/hyperv/Makefile
> > +++ b/arch/x86/hyperv/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
> >  obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
> > +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
> > 
> >  ifdef CONFIG_X86_64
> >  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
> > --
> > 2.34.1
