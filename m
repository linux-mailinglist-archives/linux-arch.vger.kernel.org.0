Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19C566FA8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 15:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiGENn7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiGENnm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 09:43:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274C2C657;
        Tue,  5 Jul 2022 06:07:40 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lcjbm4NylzkX1h;
        Tue,  5 Jul 2022 21:06:12 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 21:07:39 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Jul
 2022 21:07:38 +0800
Message-ID: <155be8eb-0255-342f-bac8-46efb868d97c@huawei.com>
Date:   Tue, 5 Jul 2022 21:07:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
From:   Chen Zhongjin <chenzhongjin@huawei.com>
Subject: Re: [PATCH v5 08/10] ARM: uaccess: add __{get,put}_kernel_nofault
Reply-To: <20220201172942.nxop6cjr3xfa4237@maple.lan>
To:     <daniel.thompson@linaro.org>
CC:     <arnd@arndb.de>, <arnd@kernel.org>, <linus.walleij@linaro.org>,
        <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux@armlinux.org.uk>, <viro@zeniv.linux.org.uk>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

It seems that the problem has not been solved so far.

I found that "echo t > /proc/sysrq-trigger" causes the same fault 
because "print_worker_info()" also calls "copy_from_kernel_nofault()", 
but "worker->current_pwq" can be zero when copying.

Stack trace:

[   15.303013] 8<--- cut here ---
[   15.303315] Unhandled fault: page domain fault (0x01b) at 0x00000004
[   15.303538] [00000004] *pgd=6338f831, *pte=00000000, *ppte=00000000
[   15.304367] Internal error: : 1b [#1] SMP ARM
[   15.304721] Modules linked in:
[   15.305107] CPU: 0 PID: 89 Comm: sh Not tainted 5.19.0-rc5-dirty #332
[   15.305373] Hardware name: ARM-Versatile Express
[   15.305529] PC is at copy_from_kernel_nofault+0xf0/0x174
[   15.305712] LR is at copy_from_kernel_nofault+0x30/0x174
[   15.305873] pc : [<c0448ea4>]    lr : [<c0448de4>]    psr: 20000013
[   15.306078] sp : eac4dde8  ip : 0000bff4  fp : eac4de74
[   15.306233] r10: 00000007  r9 : 00000000  r8 : c1a09700
[   15.306397] r7 : c1a04cc8  r6 : 00000004  r5 : eac4de18  r4 : 00000004
[   15.306586] r3 : 00000000  r2 : c2440000  r1 : 00000004  r0 : 00000001
[   15.306831] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[   15.307120] Control: 10c5387d  Table: 633f006a  DAC: 00000051
...
[   15.318121]  copy_from_kernel_nofault from print_worker_info+0xd0/0x15c
[   15.318343]  print_worker_info from sched_show_task+0x134/0x180
[   15.318534]  sched_show_task from show_state_filter+0x74/0xa8
[   15.318714]  show_state_filter from sysrq_handle_showstate+0xc/0x14
[   15.318902]  sysrq_handle_showstate from __handle_sysrq+0x88/0x138
[   15.319173]  __handle_sysrq from write_sysrq_trigger+0x4c/0x5c
[   15.319356]  write_sysrq_trigger from proc_reg_write+0xa8/0xd0
[   15.319541]  proc_reg_write from vfs_write+0xb4/0x388
[   15.319708]  vfs_write from ksys_write+0x58/0xd0
[   15.319851]  ksys_write from ret_fast_syscall+0x0/0x54

> On Thu, Jan 13, 2022 at 12:14:50PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 13, 2022 at 10:47 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Wed, Jan 12, 2022 at 06:08:17PM +0000, Russell King (Oracle) 
> wrote:
> > >
> > > > The kernel attempted to access an address that is in the userspace
> > > > domain (NULL pointer) and took an exception.
> > > >
> > > > I suppose we should handle a domain fault more gracefully - what 
> are
> > > > the required semantics if the kernel attempts a userspace access
> > > > using one of the _nofault() accessors?
> > >
> > > I think the best answer might well be that, if the arch provides
> > > implementations of hooks such as copy_from_kernel_nofault_allowed()
> > > then the kernel should never attempt a userspace access using the
> > > _nofault() accessors. That means they can do whatever they like!
> > >
> > > In other words something like the patch below looks like a promising
> > > approach.
> >
> > Right, it seems this is the same as on x86.
>
> Hmnn...
>
> Looking a bit deeper into copy_from_kernel_nofault() there is an odd
> asymmetry between copy_to_kernel_nofault(). Basically there is
> copy_from_kernel_nofault_allowed() but no corresponding
> copy_to_kernel_nofault_allowed() which means we cannot defend memory
> pokes using a helper function.
>
> I checked the behaviour of copy_to_kernel_nofault() on arm, arm64, mips,
> powerpc, riscv, x86 kernels (which is pretty much everything where I
> know how to fire up qemu). All except arm gracefully handle an
> attempt to write to userspace (well, NULL actually) with
> copy_to_kernel_nofault() so I think there still a few more changes
> to fully fix this.
>
> Looks like we would need a slightly more assertive change, either adding
> a copy_to_kernel_nofault_allowed() or modifying the arm dabt handlers to
> avoid faults on userspace access.
>
> Any views on which is better?
>
I've tested the copy_from_kernel_nofault_allowed() and agree that it's a 
enough simple and effective solution. There is only one little gap 
compared to other arch that it returns -ERANGE while actually it should 
be a -EFAULT (refer to other arches).

Anyway if we want to modify the FSR handlers I guess it's also easy 
because not we do nothing special for Domain Fault now.

>
> Daniel.
>
> >
> > > From f66a63b504ff582f261a506c54ceab8c0e77a98c Mon Sep 17 00:00:00 
> 2001
> > > From: Daniel Thompson <daniel.thompson@linaro.org>
> > > Date: Thu, 13 Jan 2022 09:34:45 +0000
> > > Subject: [PATCH] arm: mm: Implement 
> copy_from_kernel_nofault_allowed()
> > >
> > > Currently copy_from_kernel_nofault() can actually fault (due to 
> software
> > > PAN) if we attempt userspace access. In any case, the documented
> > > behaviour for this function is to return -ERANGE if we attempt an 
> access
> > > outside of kernel space.
> > >
> > > Implementing copy_from_kernel_nofault_allowed() solves both these
> > > problems.
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>

Best,

Chen



