Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8FA14A26
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2019 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEFMrG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 May 2019 08:47:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:9185 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFMrG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 May 2019 08:47:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 05:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="146817375"
Received: from lilitang-mobl.ccr.corp.intel.com ([10.249.168.111])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2019 05:44:01 -0700
Message-ID: <1557146640.2456.2.camel@intel.com>
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for
 self-encapsulation
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Date:   Mon, 06 May 2019 20:44:00 +0800
In-Reply-To: <d6bc1efc-e944-09a4-e010-bfea985c66cb@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
         <20190402161256.11044-3-daniel.lezcano@linaro.org>
         <1555922585.26198.19.camel@intel.com>
         <fb45157c-38c4-7940-3252-af459d446323@linaro.org>
         <1555999165.26198.39.camel@intel.com>
         <d6bc1efc-e944-09a4-e010-bfea985c66cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 五, 2019-05-03 at 22:28 +0200, Daniel Lezcano wrote:
> On 23/04/2019 07:59, Zhang Rui wrote:
> > 
> > Hi, Daniel,
> > 
> > thanks for clarifying.
> > It is true that we need to make thermal framework ready as early as
> > possible. And a static table works for me as long as vmlinux.lds.h
> > is
> > the proper place.
> > 
> > Arnd,
> > are you okay with this patch? if yes, I suppose I can take it
> > through
> > my tree, right?
> Hi Zhang,
> 
> given the Acked-by from Arnd, will you add the missing patches in the
> tree for 5.2?
> 
I got a lot of checkpatch warnings when applying this patch.
"total: 9 errors, 6 warnings, 45 lines checked"
please resend with those errors/warnings addressed.

I don't think I will include it in the pull request for this merge
window. But I will try to queue them for -rc2 as cleanups.

thanks,
rui

> 
> 
> > 
> > On 一, 2019-04-22 at 14:11 +0200, Daniel Lezcano wrote:
> > > 
> > > Hi Zhang,
> > > 
> > > 
> > > On 22/04/2019 10:43, Zhang Rui wrote:
> > > > 
> > > > 
> > > > Hi, Daniel,
> > > > 
> > > > Thanks for the patches, it looks good to me except this one and
> > > > patch
> > > > 4/7.
> > > > 
> > > > First, I don't think this is a cyclic dependency issue as they
> > > > are
> > > > in
> > > > the same module.
> > > The governors have to export their [un]register functions in
> > > order to
> > > have the core to use them.
> > > 
> > > The core has to export the [un]register function in order to have
> > > the
> > > governors to use them.
> > > 
> > > From my point of view it is a cyclic dependency. In any other
> > > subsystems, the plugins/governor/drivers/whatever don't have to
> > > export
> > > their functions to the core, they use the core's exported
> > > functions.
> > > 
> > > > 
> > > > 
> > > > Second, I have not read include/asm-generic/vmlinux.lds.h
> > > > before,
> > > > it
> > > > seems that it is used for architecture specific stuff. Fix a
> > > > thermal
> > > > issue in this way seems overkill to me.
> > > It is not architecture specific, it belongs to asm-generic. All
> > > init
> > > calls are defined in it and more. It is a common way to define
> > > static
> > > tables from different files without adding dependency and unload
> > > it
> > > after init.
> > > 
> > > All clk, timers, acpi tables, irq chip, cpuidle and cpu methods
> > > are
> > > defined this way.
> > > 
> > > When the thermal_core.c uses at the end fs_initcall it uses the
> > > same
> > > mechanism.
> > > 
> > > 
> > > > 
> > > > 
> > > > IMO, to make the code clean, we can build the governors as
> > > > separate
> > > > modules just like we do for cpu governors.
> > > > This brings to the old commit 80a26a5c22b9("Thermal: build
> > > > thermal
> > > > governors into thermal_sys module"), and that was introduced to
> > > > fix
> > > > a
> > > > problem when CONFIG_THERMAL is set to 'm'. So I think we can
> > > > switch
> > > > back to the old way as the problem is gone now.
> > > > 
> > > > what do you think?
> > > IMO, having the governors built as module is not a good thing
> > > because
> > > the SoC needs the governor to be ready as soon as possible at
> > > boot
> > > time.
> > > I've been told some boards reboot at boot time because the
> > > governor
> > > comes too late with the userspace governor for example.
> > > 
> > > If you don't like the vmlinuz.lds.h approch (but again it is a
> > > common
> > > way to initialize table and I wrote it to extend to more thermal
> > > table
> > > in the future) we can change the thermal core to replace
> > > fs_initcall()
> > > by core_initcall() and use postcore_initcall() in the governor.
> > > 
> > > 
> > > 
> > > > 
> > > > 
> > > > Patch 1,2,5,6,7 applied first.
> > > > 
> > > > thanks,
> > > > rui
> > > > 
> > > > On 二, 2019-04-02 at 18:12 +0200, Daniel Lezcano wrote:
> > > > > 
> > > > > 
> > > > > Currently the governors are declared in their respective
> > > > > files
> > > > > but
> > > > > they
> > > > > export their [un]register functions which in turn call the
> > > > > [un]register
> > > > > the governors core's functions. That implies a cyclic
> > > > > dependency
> > > > > which is
> > > > > not desirable. There is a way to self-encapsulate the
> > > > > governors
> > > > > by
> > > > > letting
> > > > > them to declare themselves in a __init section table.
> > > > > 
> > > > > Define the table in the asm generic linker description like
> > > > > the
> > > > > other
> > > > > tables and provide the specific macros to deal with.
> > > > > 
> > > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > > ---
> > > > >  drivers/thermal/thermal_core.h    | 16 ++++++++++++++++
> > > > >  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
> > > > >  2 files changed, 27 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/thermal/thermal_core.h
> > > > > b/drivers/thermal/thermal_core.h
> > > > > index 0df190ed82a7..28d18083e969 100644
> > > > > --- a/drivers/thermal/thermal_core.h
> > > > > +++ b/drivers/thermal/thermal_core.h
> > > > > @@ -15,6 +15,22 @@
> > > > >  /* Initial state of a cooling device during binding */
> > > > >  #define THERMAL_NO_TARGET -1UL
> > > > >  
> > > > > +/* Init section thermal table */
> > > > > +extern struct thermal_governor * __governor_thermal_table[];
> > > > > +extern struct thermal_governor *
> > > > > __governor_thermal_table_end[];
> > > > > +
> > > > > +#define THERMAL_TABLE_ENTRY(table, name)			
> > > > > \
> > > > > +        static typeof(name) * __thermal_table_entry_##name	
> > > > > \
> > > > > +	__used __section(__##table##_thermal_table)		
> > > > > \
> > > > > +		= &name;
> > > > > +
> > > > > +#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_
> > > > > ENTR
> > > > > Y(go
> > > > > vernor, name)
> > > > > +
> > > > > +#define for_each_governor_table(__governor)		\
> > > > > +	for (__governor = __governor_thermal_table;	\
> > > > > +	     __governor < __governor_thermal_table_end;	
> > > > > \
> > > > > +	     __governor++)
> > > > > +
> > > > >  /*
> > > > >   * This structure is used to describe the behavior of
> > > > >   * a certain cooling device on a certain trip point
> > > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> > > > > generic/vmlinux.lds.h
> > > > > index f8f6f04c4453..9893a3ed242a 100644
> > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > @@ -239,6 +239,16 @@
> > > > >  #define ACPI_PROBE_TABLE(name)
> > > > >  #endif
> > > > >  
> > > > > +#ifdef CONFIG_THERMAL
> > > > > +#define THERMAL_TABLE(name)					
> > > > > 	
> > > > > \
> > > > > +        . = ALIGN(8);					
> > > > > 	
> > > > > 	\
> > > > > +        __##name##_thermal_table = .;			
> > > > > 	
> > > > > 	\
> > > > > +        KEEP(*(__##name##_thermal_table))			
> > > > > 	
> > > > > \
> > > > > +        __##name##_thermal_table_end = .;
> > > > > +#else
> > > > > +#define THERMAL_TABLE(name)
> > > > > +#endif
> > > > > +
> > > > >  #define KERNEL_DTB()						
> > > > > 	
> > > > > \
> > > > >  	STRUCT_ALIGN();					
> > > > > 	
> > > > > 	\
> > > > >  	__dtb_start = .;					
> > > > > 	
> > > > > \
> > > > > @@ -609,6 +619,7 @@
> > > > >  	IRQCHIP_OF_MATCH_TABLE()				
> > > > > 	
> > > > > \
> > > > >  	ACPI_PROBE_TABLE(irqchip)				
> > > > > 	
> > > > > \
> > > > >  	ACPI_PROBE_TABLE(timer)				
> > > > > 	
> > > > > 	\
> > > > > +	THERMAL_TABLE(governor)				
> > > > > 	
> > > > > 	\
> > > > >  	EARLYCON_TABLE()					
> > > > > 	
> > > > > \
> > > > >  	LSM_TABLE()
> > > > >  
> 
