Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1C6BB3F8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 14:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjCONKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCONKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 09:10:49 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9382A67706;
        Wed, 15 Mar 2023 06:10:40 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pcQtk-0006KN-00; Wed, 15 Mar 2023 14:10:32 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1A279C1AB5; Wed, 15 Mar 2023 13:52:16 +0100 (CET)
Date:   Wed, 15 Mar 2023 13:52:16 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Message-ID: <20230315125216.GA12532@alpha.franken.de>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-3-bhe@redhat.com>
 <20230313175521.GA14404@alpha.franken.de>
 <ZA/iZHEHaQ2WR+HL@MiWiFi-R3L-srv>
 <20230314153421.GA13322@alpha.franken.de>
 <7f39daad-05b0-46f8-bc89-185b336d8fd4@gmail.com>
 <3fd94bd7-ab10-4d50-bcb6-7c13a3346d6a@app.fastmail.com>
 <ZBEWMSdzzvsYCAnd@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBEWMSdzzvsYCAnd@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 08:49:53AM +0800, Baoquan He wrote:
> On 03/14/23 at 06:19pm, Arnd Bergmann wrote:
> > On Tue, Mar 14, 2023, at 17:31, Florian Fainelli wrote:
> > > On 3/14/23 08:34, Thomas Bogendoerfer wrote:
> > >> On Tue, Mar 14, 2023 at 10:56:36AM +0800, Baoquan He wrote:
> > >>>> In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
> > >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
> > >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
> > >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
> > >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
> > >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
> > >>>>                   from /local/tbogendoerfer/korg/linux/init/version.c:17:
> > >> 
> > >> already tried it, but it doesn't fix the issue. I've attached the
> > >> config.
> > >
> > > I had attempted a similar approach before as Baoquan did, but met the 
> > > same build issue as Thomas that was not immediately clear to me why it 
> > > popped up. I would be curious to see how this can be resolved.
> > 
> > I think this is the result of recursive header inclusion:
> > spinlock.h includes lockdep.h, but its header guard is already
> > there from the include chain.
> > 
> > There is probably something in one of the mips asm/*.h headers that
> > causes this recursion that is not present elsewhere.
> > 
> > I think this should fix it, but is likely to cause another problem elsewhere:
> > 
> > --- a/arch/mips/include/asm/smp-ops.h
> > +++ b/arch/mips/include/asm/smp-ops.h
> > @@ -13,8 +13,6 @@
> >  
> >  #include <linux/errno.h>
> >  
> > -#include <asm/mips-cps.h>
> > -
> >  #ifdef CONFIG_SMP
> >  
> >  #include <linux/cpumask.h>
> 
> Will meet below compiling error after appllying above patch. Adding
> asm/mips-cps.h including in arch/mips/kernel/setup.c will fix it as below.
> 
> arch/mips/kernel/setup.c: In function ‘setup_arch’:
> arch/mips/kernel/setup.c:781:9: error: implicit declaration of function ‘mips_cm_probe’ [-Werror=implicit-function-declaration]
>   781 |         mips_cm_probe();
>       |         ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index f1c88f8a1dc5..e8c4020ef367 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <asm/smp-ops.h>
>  #include <asm/prom.h>
>  #include <asm/fw/fw.h>
> +#include <asm/mips-cps.h>
>  
>  #ifdef CONFIG_MIPS_ELF_APPENDED_DTB
>  char __section(".appended_dtb") __appended_dtb[0x100000];

with

diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index d85cbf84e41c..973faea61cad 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -7,6 +7,9 @@
  * Copyright (C) 1999, 2000, 04 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+
+#include <linux/io.h>
+
 #include <asm/sn/addrs.h>
 #include <asm/sn/types.h>
 #include <asm/sn/klconfig.h>

on top, all my builds are ok. But my malta qemu setup crashes:

Unhandled kernel unaligned access[#1]:
CPU: 0 PID: 1 Comm: systemd Not tainted 6.3.0-rc1-00022-gff6bffcfbf9e #290
$ 0   : 00000000 00000001 81000640 00000001
$ 4   : 80bd8641 00000001 00000000 00000000
$ 8   : 00000001 00000001 77c5abae ffffffff
$12   : 00000000 7b3eeedb 820f7380 bdd54e39
$16   : 80bd8641 820fbdc4 81000640 80ad0000
$20   : 00000008 80ad0000 80ad0000 80ad0000
$24   : 00000000 f592e7d4                  
$28   : 820f8000 820fbd48 80c20000 801c44f4
Hi    : 001f93e2
Lo    : 18073cf3
epc   : 80902188 _raw_spin_lock+0xc/0x54
ra    : 801c44f4 add_timer_on+0x94/0x1b0
Status: 1400a402	KERNEL EXL 
Cause : 10800010 (ExcCode 04)
BadVA : 80bd8641
PrId  : 00019300 (MIPS 24Kc)
Modules linked in:
Process systemd (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=76f2b6e0)
Stack : 80bd8641 820fbdc4 80ad0000 80ad0000 00000008 80ad0000 80ad0000 801c44f4
        80ad0000 80ad0000 820f8000 820fbd98 00000001 f01a83f8 00000008 820fbdc0
        80ad0000 820fbdc4 80ad0000 808f4f20 00000001 822f7640 822f7940 f01a83f8
        00000000 820fbec0 00000001 00000001 00000001 77d3fafc 3e01e433 00000122
        00000000 ffff8c77 808f513c 0dc40000 00000001 00000001 00000001 82a1f900
        ...
Call Trace:
[<80902188>] _raw_spin_lock+0xc/0x54
[<801c44f4>] add_timer_on+0x94/0x1b0
[<808f4f20>] try_to_generate_entropy+0x1e8/0x270
[<805c7408>] urandom_read_iter+0x10c/0x114
[<802d77f8>] vfs_read+0x21c/0x2bc
[<802d8284>] ksys_read+0x7c/0x118
[<8011b130>] syscall_common+0x34/0x58

Code: 27bdffe0  afbf001c  24030001 <c0850000> 14a00005  00000000  00600825  e0810000  1020fffa 

---[ end trace 0000000000000000 ]---

I guess this has something to do with the removal of #include <asm/mips-cps.h>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
