Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7088E5709E5
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jul 2022 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiGKSY5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGKSY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 14:24:56 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D94F694;
        Mon, 11 Jul 2022 11:24:54 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 189so5696463vsh.2;
        Mon, 11 Jul 2022 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hYm81WINPrMZthIUaIjVabJcBqoap/pn/CVPWFtAPRc=;
        b=jP00e8WXgNi59EPBq786OXRY48TLcrtJvIpnSus2fEJx2vRONRr4ho2d6LWdhGbnU6
         ErYOMAhG3FYx7KgPoY4DAXWOX9ZA7jhKd1Fi1XvNscDdKZN24FsKU2SPJgRJ4W5/ygEx
         ymdjIzvQ+StwQH7aoZnZQjl0Epw762jEt924cMmyjrZ80Y5skk7a0+FsddSS79RuUB6S
         UC8QGFAao3O9xB1cMJWQjPEAw1XkN/WqaD5OeCCjgVkG+SGYEACqQJYqE/hnroiluG1y
         zLYDElPeBFpwdPVIJJhxFOP6zpxmbxLq5LdEhrp6+e6gmx1ypr4TnmyVYJPhljoST2Wz
         5PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hYm81WINPrMZthIUaIjVabJcBqoap/pn/CVPWFtAPRc=;
        b=ZyzRl0sfKXAvDGrhb1LjEFvhgvC2ItnGqUcW1zED1WrCTXEd8v1WOtolokpVsJwjw2
         kh00WMecla1tT0L27beUyuZQaD0KoHhYFOOjiqx8+a69B/Yd4Cp252BH/z5kE8YmhSTv
         y9k7nH/5M9RDgBClRqmoSGFShtsqWT3DmhzBouuN0JMOKGxl9vIIOwxjxL1LTxhN1FSC
         ave2RfoKbPy8zIadKcBO+4KBS7DoZHsy1BVTXkPSloUAsyd68STmmkXK9c60wLa1iMD9
         x9N9pdYXPrH0lTGfH0HMjt8oEv6tYhnWRy/FsADN6WRB59FF45/zDTQNZn/B/krDrC5e
         5U/w==
X-Gm-Message-State: AJIora+6yg3Blkz5ymWOdeOVmhUE5Z/BqOnLLua5tuS9I2U0VT7hv06f
        KNdqPY7MICify6Viee5Po9zkPOlQcaAKs1TyvmU=
X-Google-Smtp-Source: AGRyM1vYccBjI43XWDxR+KjpZwEhVKtFCtA5PQ33fPzH9ISwl6oFUXJpVSx8kZOE1FgIRQS/yP/gH23zsbPlDHra4Eg=
X-Received: by 2002:a05:6102:2387:b0:34b:9f6d:10da with SMTP id
 v7-20020a056102238700b0034b9f6d10damr7447669vsr.28.1657563893068; Mon, 11 Jul
 2022 11:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <YsbpTNmDaam8pl+f@xsang-OptiPlex-9020> <YsggZNUQcsKIU9xU@smile.fi.intel.com>
 <20220711161341.21605-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220711161341.21605-1-alexandr.lobakin@intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 11 Jul 2022 11:24:42 -0700
Message-ID: <CAAH8bW_fypvDtWEFX32iFSagyAS2Mi+yG+bafTeTynYynBdDWA@mail.gmail.com>
Subject: Re: [bitops] 0e862838f2: BUG:KASAN:wild-memory-access_in_dmar_parse_one_rhsa
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 11, 2022 at 9:15 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Fri, 8 Jul 2022 15:17:40 +0300
>
> > On Thu, Jul 07, 2022 at 10:10:20PM +0800, kernel test robot wrote:
> > >
> > > (please be noted we reported
> > > "[bitops]  001bea109d: BUG:KASAN:wild-memory-access_in_dmar_parse_one=
_rhsa"
> > > on
> > > https://lore.kernel.org/all/YrnGLtDXAveqXGok@xsang-OptiPlex-9020/
> > > now we noticed this commit has already been merged into linux-next/ma=
ster,
> > > and the issue is still existing. report again FYI)
> > >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-11):
> > >
> > > commit: 0e862838f290147ea9c16db852d8d494b552d38d ("bitops: unify non-=
atomic bitops prototypes across architectures")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >
> > > in testcase: xfstests
> > > version: xfstests-x86_64-c1144bf-1_20220627
> > > with following parameters:
> > >
> > >     disk: 2pmem
> > >     fs: ext4
> > >     test: ext4-dax
> > >     ucode: 0x700001c
> > >
> > > test-description: xfstests is a regression test suite for xfs and oth=
er files ystems.
> > > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> > >
> > > on test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2=
.10GHz with 48G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire =
log/backtrace):
> > >
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > >
> > >
> > > [ 4.668325][ T0] BUG: KASAN: wild-memory-access in dmar_parse_one_rhs=
a (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 incl=
ude/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask=
.h:415 drivers/iommu/intel/dmar.c:497)
> > > [    4.676149][    T0] Read of size 8 at addr 1fffffff85115558 by tas=
k swapper/0/0
> > > [    4.683454][    T0]
> > > [    4.685638][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19=
.0-rc3-00004-g0e862838f290 #1
> > > [    4.694331][    T0] Hardware name: Supermicro SYS-5018D-FN4T/X10SD=
V-8C-TLN4F, BIOS 1.1 03/02/2016
> > > [    4.703196][    T0] Call Trace:
> > > [    4.706334][    T0]  <TASK>
> > > [ 4.709133][ T0] ? dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h=
:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumen=
ted-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.=
c:497)
> > > [ 4.714272][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator =
1))
> > > [ 4.718632][ T0] kasan_report (mm/kasan/report.c:162 mm/kasan/report.=
c:493)
> > > [ 4.722903][ T0] ? dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h=
:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumen=
ted-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.=
c:497)
> > > [ 4.728042][ T0] kasan_check_range (mm/kasan/generic.c:190)
> > > [ 4.732750][ T0] dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:2=
14 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumente=
d-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:=
497)
> > > [ 4.737715][ T0] dmar_walk_remapping_entries (drivers/iommu/intel/dma=
r.c:609)
> > > [ 4.743375][ T0] parse_dmar_table (drivers/iommu/intel/dmar.c:671)
> > > [ 4.748079][ T0] ? dmar_table_detect (drivers/iommu/intel/dmar.c:633)
> > > [ 4.752872][ T0] ? dmar_free_dev_scope (drivers/iommu/intel/dmar.c:40=
8)
> > > [ 4.758010][ T0] ? init_dmars (drivers/iommu/intel/iommu.c:3359)
> > > [ 4.762370][ T0] ? iommu_resume (drivers/iommu/intel/iommu.c:3419)
> > > [ 4.766903][ T0] ? dmar_walk_dsm_resource+0x300/0x300
> > > [ 4.772909][ T0] ? dmar_acpi_insert_dev_scope (drivers/iommu/intel/dm=
ar.c:466)
> > > [ 4.778655][ T0] ? dmar_check_one_atsr (drivers/iommu/intel/iommu.c:3=
521)
> > > [ 4.783795][ T0] dmar_table_init (drivers/iommu/intel/dmar.c:846)
> > > [ 4.788239][ T0] intel_prepare_irq_remapping (drivers/iommu/intel/irq=
_remapping.c:742)
> > > [ 4.793811][ T0] irq_remapping_prepare (drivers/iommu/irq_remapping.c=
:102)
> > > [ 4.798778][ T0] enable_IR_x2apic (arch/x86/kernel/apic/apic.c:1928)
> > > [ 4.803395][ T0] default_setup_apic_routing (arch/x86/kernel/apic/pro=
be_64.c:25 (discriminator 1))
> > > [ 4.808883][ T0] apic_intr_mode_init (arch/x86/kernel/apic/apic.c:144=
6)
> > > [ 4.813761][ T0] x86_late_time_init (arch/x86/kernel/time.c:101)
> > > [ 4.818467][ T0] start_kernel (init/main.c:1101)
> > > [ 4.822827][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head=
_64.S:358)
> >
> > Seems like related to nodemask APIs.
>
> It points to arch_test_bit() (node_online() -> test_bit()),
> converted from a macro to a function, more precisely, to
> variable_test_bit(), which I didn't touch.
>
> ...oh ok I got it!
>
> pxm_to_node() can return %NUMA_NO_NODE which equals to -1. The
> mentioned commit converts the macro to the function which now takes
> `unsigned long` as @nr (bit number). So I guess it gets converted to
> %ULONG_MAX - 1.
>
> Now the question is: what should a bitop do if we have negative bit
> number? Because there are 2 solutions:
>
> 1. (I prefer it) A caller must check that bitop arguments are valid.
>    UB for negative (=3D=3D too big) bit numbers.
>    dmar_parse_one_rhsa() must be fixed so that it will check return
>    value of pxm_to_node():
>
>                         int node =3D pxm_to_node(rhsa->proximity_domain);
>
> -                       if (!node_online(node))
> +                       if (node !=3D NUMA_NO_NODE && !node_online(node))

Would it make sense to check it inside node_online()?

>                                 node =3D NUMA_NO_NODE;
>
> 2. My code is broken, I shouldn't change `long` to `unsigned long`
>    or should change it for {constant,variable}_test_bit() as well
>    or do something else and let it behave as it was previously
>    (it wasn't crashing probably due to a good luck or...).

This is definitely a NUMA problem. Bitmap has 2 kernel-wide users:
cpumasks and numa nodes. Both use negative indexes for their
reasons, which is dangerous, as we can see from here, because
bitmaps don't support them and don't handle it properly...

Can you please send a fix dmar_parse_one_rhsa() as you suggested,
so that I'll add the fix before the beginning of next merge window?

Regarding a general path, this is what I'm thinking on (for a while):
 - #define NUMA_NO_NODE MAX_NUMNODES;
 - stronger typechecking, like you did in your series;
 - introduce CONFIG_DEBUG_BITMAP  to catch bad arguments
   on-the-fly;

I'm working on DEBUG_BITMAP, hopefully submit it for next merge
cycle.

Thanks,
Yury
