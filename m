Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17B351F02
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 01:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfFXXQM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 19:16:12 -0400
Received: from foss.arm.com ([217.140.110.172]:58998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfFXXQM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 19:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0D94360;
        Mon, 24 Jun 2019 16:16:10 -0700 (PDT)
Received: from [10.37.13.1] (unknown [10.37.13.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256E93F71E;
        Mon, 24 Jun 2019 16:16:06 -0700 (PDT)
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
To:     Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3ae7f595-0a15-0584-198e-b32fe3e3ea57@arm.com>
Date:   Tue, 25 Jun 2019 00:16:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
Content-Type: multipart/mixed;
 boundary="------------E09C3611481E52636CE747FD"
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------E09C3611481E52636CE747FD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Paul,

thank you for your review.

On 6/24/19 7:41 PM, Paul Burton wrote:
> Hello,
> 
> On Mon, Jun 24, 2019 at 02:34:24AM +0200, Thomas Gleixner wrote:
>> I did not merge the ARM and MIPS parts as they lack any form of
>> acknowlegment from their maintainers. Please talk to those folks. If they
>> ack/review the changes then I can pick them up and they go into 5.3 or they
>> have to go in a later cycle. Nevertheless it was well worth the trouble to
>> have those conversions done to confirm that the new common library fits a
>> bunch of different architectures.
> 
> Apologies for not being more proactive on the MIPS front here; life &
> work are extra busy at the moment... But thanks Vincenzo for including
> MIPS in the work here.
> 

No problem.

> Unfortunately after applying the 3 MIPS patches (19-21) atop the current
> tip.git timers/vdso branch at ecf9db3d1f1a ("x86/vdso: Give the
> [ph]vclock_page declarations real types") I see build failures for the
> o32 compat VDSO, shown below. This is using the gcc 8.1.0 mips-linux
> toolchain from here:
> 
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-mips-linux.tar.xz
> 
> Configuration is 64r6el_defconfig. The following helps remove the
> implicit declaration warnings (and eww to including C files via CFLAGS),
> but it still doesn't build:
> 
>   diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
>   index 95df49402a53..aa38049bdb24 100644
>   --- a/arch/mips/vdso/Makefile
>   +++ b/arch/mips/vdso/Makefile
>   @@ -36,6 +36,8 @@ aflags-vdso := $(ccflags-vdso) \
>   
>    ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
>   +CFLAGS_vgettimeofday-o32.o = -include $(c-gettimeofday-y)
>   +CFLAGS_vgettimeofday-n32.o = -include $(c-gettimeofday-y)
>    endif
> 
>  CFLAGS_REMOVE_vgettimeofday.o = -pg
> 
> So the MIPS bits here need more work.
> 

I admit, the one proposed was a nice challenge and it took me a while to
understand the differences in between the O32, N32 and N64 binaries and what was
causing the reported issue.

In the end I concluded that all the errors seen here depend on the fact that I
tested my vdso implementation on MIPS32el only (as stated in the cover letter)
and that when I tried to compile a 32BIT binary on a 64BIT configuration I did
it wrongly for two reasons, for N32 and O32 binaries:
 - we need to undefine CONFIG_64BIT and define CONFIG_32BIT
 - we need to define CONFIG_GENERIC_ATOMIC64


I have a fix for this (patch in attachment), but I do not have the hardware to
test it. If you could provide some feedback would be appreciated (really want to
see MIPS merged with the other archs in 5.3 :) ).

> Thanks,
>     Paul
> 
>   CC      arch/mips/vdso/vgettimeofday-o32.o
> In file included from ./include/linux/bitops.h:19,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/preempt.h:11,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from arch/mips/vdso/vgettimeofday.c:10:
> ./arch/mips/include/asm/bitops.h: In function '__fls':
> ./arch/mips/include/asm/bitops.h:518:21: warning: left shift count >= width of type [-Wshift-count-overflow]
>   if (!(word & (~0ul << 32))) {
>                      ^~
> ./arch/mips/include/asm/bitops.h:520:8: warning: left shift count >= width of type [-Wshift-count-overflow]
>    word <<= 32;
>         ^~~
> ./arch/mips/include/asm/bitops.h:523:21: warning: left shift count >= width of type [-Wshift-count-overflow]
>   if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>                      ^~
> ./arch/mips/include/asm/bitops.h:527:21: warning: left shift count >= width of type [-Wshift-count-overflow]
>   if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>                      ^~
> ./arch/mips/include/asm/bitops.h:531:21: warning: left shift count >= width of type [-Wshift-count-overflow]
>   if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>                      ^~
> ./arch/mips/include/asm/bitops.h:535:21: warning: left shift count >= width of type [-Wshift-count-overflow]
>   if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>                      ^~
> ./arch/mips/include/asm/bitops.h:539:21: warning: left shift count >= width of type [-Wshift-count-overflow]
>   if (!(word & (~0ul << (BITS_PER_LONG-1))))
>                      ^~
> In file included from ./arch/mips/include/asm/mmiowb.h:5,
>                  from ./include/linux/spinlock.h:60,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from arch/mips/vdso/vgettimeofday.c:10:
> ./arch/mips/include/asm/io.h: In function 'phys_to_virt':
> ./arch/mips/include/asm/io.h:136:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
>          ^
> In file included from ./include/linux/bitops.h:5,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/preempt.h:11,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from arch/mips/vdso/vgettimeofday.c:10:
> ./arch/mips/include/asm/mips-cm.h: In function 'mips_cm_max_vp_width':
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_GCR_REV_MAJOR'
>    (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:161:23: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3    CM_ENCODE_REV(8, 0)
>                        ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:367:28: note: in expansion of macro 'CM_REV_CM3'
>   if (mips_cm_revision() >= CM_REV_CM3)
>                             ^~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MINOR   GENMASK(7, 0)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_GCR_REV_MINOR'
>     ((minor) << __ffs(CM_GCR_REV_MINOR)))
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:161:23: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3    CM_ENCODE_REV(8, 0)
>                        ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:367:28: note: in expansion of macro 'CM_REV_CM3'
>   if (mips_cm_revision() >= CM_REV_CM3)
>                             ^~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:239:36: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_SYS_CONFIG2_MAXVPW  GENMASK(3, 0)
>                                     ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:368:35: note: in expansion of macro 'CM_GCR_SYS_CONFIG2_MAXVPW'
>    return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW;
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
>                                  ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:376:32: note: in expansion of macro 'CM_GCR_Cx_CONFIG_PVPE'
>    cfg = read_gcr_cl_config() & CM_GCR_Cx_CONFIG_PVPE;
>                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
>                                  ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:377:24: note: in expansion of macro 'CM_GCR_Cx_CONFIG_PVPE'
>    return (cfg >> __ffs(CM_GCR_Cx_CONFIG_PVPE)) + 1;
>                         ^~~~~~~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numclusters':
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_GCR_REV_MAJOR'
>    (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
>                          ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h:117:27: note: in expansion of macro 'CM_REV_CM3_5'
>   if (mips_cm_revision() < CM_REV_CM3_5)
>                            ^~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MINOR   GENMASK(7, 0)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_GCR_REV_MINOR'
>     ((minor) << __ffs(CM_GCR_REV_MINOR)))
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
>                          ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h:117:27: note: in expansion of macro 'CM_REV_CM3_5'
>   if (mips_cm_revision() < CM_REV_CM3_5)
>                            ^~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:133:37: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_CONFIG_NUM_CLUSTERS  GENMASK(29, 23)
>                                      ^~~~~~~
> ./arch/mips/include/asm/mips-cps.h:120:37: note: in expansion of macro 'CM_GCR_CONFIG_NUM_CLUSTERS'
>   num_clusters = read_gcr_config() & CM_GCR_CONFIG_NUM_CLUSTERS;
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:133:37: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_CONFIG_NUM_CLUSTERS  GENMASK(29, 23)
>                                      ^~~~~~~
> ./arch/mips/include/asm/mips-cps.h:121:25: note: in expansion of macro 'CM_GCR_CONFIG_NUM_CLUSTERS'
>   num_clusters >>= __ffs(CM_GCR_CONFIG_NUM_CLUSTERS);
>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_cluster_config':
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_GCR_REV_MAJOR'
>    (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
>                          ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h:137:27: note: in expansion of macro 'CM_REV_CM3_5'
>   if (mips_cm_revision() < CM_REV_CM3_5) {
>                            ^~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MINOR   GENMASK(7, 0)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_GCR_REV_MINOR'
>     ((minor) << __ffs(CM_GCR_REV_MINOR)))
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
>                          ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h:137:27: note: in expansion of macro 'CM_REV_CM3_5'
>   if (mips_cm_revision() < CM_REV_CM3_5) {
>                            ^~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numcores':
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:135:32: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_CONFIG_PCORES   GENMASK(7, 0)
>                                 ^~~~~~~
> ./arch/mips/include/asm/mips-cps.h:172:50: note: in expansion of macro 'CM_GCR_CONFIG_PCORES'
>   return (mips_cps_cluster_config(cluster) + 1) & CM_GCR_CONFIG_PCORES;
>                                                   ^~~~~~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numiocu':
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:134:33: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_CONFIG_NUMIOCU   GENMASK(15, 8)
>                                  ^~~~~~~
> ./arch/mips/include/asm/mips-cps.h:189:48: note: in expansion of macro 'CM_GCR_CONFIG_NUMIOCU'
>   num_iocu = mips_cps_cluster_config(cluster) & CM_GCR_CONFIG_NUMIOCU;
>                                                 ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:134:33: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_CONFIG_NUMIOCU   GENMASK(15, 8)
>                                  ^~~~~~~
> ./arch/mips/include/asm/mips-cps.h:190:21: note: in expansion of macro 'CM_GCR_CONFIG_NUMIOCU'
>   num_iocu >>= __ffs(CM_GCR_CONFIG_NUMIOCU);
>                      ^~~~~~~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numvps':
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_GCR_REV_MAJOR'
>    (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
>                          ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h:216:27: note: in expansion of macro 'CM_REV_CM3_5'
>   if (mips_cm_revision() < CM_REV_CM3_5) {
>                            ^~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_REV_MINOR   GENMASK(7, 0)
>                             ^~~~~~~
> ./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_GCR_REV_MINOR'
>     ((minor) << __ffs(CM_GCR_REV_MINOR)))
>                       ^~~~~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_ENCODE_REV'
>  #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
>                          ^~~~~~~~~~~~~
> ./arch/mips/include/asm/mips-cps.h:216:27: note: in expansion of macro 'CM_REV_CM3_5'
>   if (mips_cm_revision() < CM_REV_CM3_5) {
>                            ^~~~~~~~~~~~
> ./include/linux/bits.h:20:39: warning: right shift count >= width of type [-Wshift-count-overflow]
>   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>                                        ^~
> ./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENMASK'
>  #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
>                                  ^~~~~~~
> ./arch/mips/include/asm/mips-cps.h:233:21: note: in expansion of macro 'CM_GCR_Cx_CONFIG_PVPE'
>   return (cfg + 1) & CM_GCR_Cx_CONFIG_PVPE;
>                      ^~~~~~~~~~~~~~~~~~~~~
> arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime':
> arch/mips/vdso/vgettimeofday.c:17:9: error: implicit declaration of function '__cvdso_clock_gettime32'; did you mean '__vdso_clock_gettime'? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_gettime32(clock, ts);
>          ^~~~~~~~~~~~~~~~~~~~~~~
>          __vdso_clock_gettime
> arch/mips/vdso/vgettimeofday.c: In function '__vdso_gettimeofday':
> arch/mips/vdso/vgettimeofday.c:23:9: error: implicit declaration of function '__cvdso_gettimeofday'; did you mean '__vdso_gettimeofday'? [-Werror=implicit-function-declaration]
>   return __cvdso_gettimeofday(tv, tz);
>          ^~~~~~~~~~~~~~~~~~~~
>          __vdso_gettimeofday
> arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_getres':
> arch/mips/vdso/vgettimeofday.c:29:9: error: implicit declaration of function '__cvdso_clock_getres_time32'; did you mean '__vdso_clock_gettime'? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_getres_time32(clock_id, res);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>          __vdso_clock_gettime
> arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime64':
> arch/mips/vdso/vgettimeofday.c:35:9: error: implicit declaration of function '__cvdso_clock_gettime'; did you mean '__vdso_clock_gettime'? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_gettime(clock, ts);
>          ^~~~~~~~~~~~~~~~~~~~~
>          __vdso_clock_gettime
> cc1: some warnings being treated as errors
> make[1]: *** [arch/mips/vdso/Makefile:148: arch/mips/vdso/vgettimeofday-o32.o] Error 1
> make: *** [Makefile:1746: arch/mips/vdso/vgettimeofday-o32.o] Error 2
> 

-- 
Regards,
Vincenzo

--------------E09C3611481E52636CE747FD
Content-Type: text/x-patch;
 name="0001-mips-Fix-o32-and-n32-vDSO-compilation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-mips-Fix-o32-and-n32-vDSO-compilation.patch"

From 7bf2f8fe3b412e922f7d6d193763bee94b5b76c5 Mon Sep 17 00:00:00 2001
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Date: Mon, 24 Jun 2019 23:46:57 +0100
Subject: [PATCH] mips: Fix o32 and n32 vDSO compilation

The Unified vDSO implementation does not compile correctly for n32 and
o32 type of binaries on mips64 because the environment is not set
correctly.

Restore the correct behaviour addressing the configuration issues for
the generation of these types of binaries.

[ To be squashed with the "[PATCH v7 19/25] mips: Add support for generic
vDSO" ]

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/vdso/Makefile             |  6 ++++++
 arch/mips/vdso/config-n32-o32-env.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/mips/vdso/config-n32-o32-env.c

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 95df49402a53..47316964150c 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -36,6 +36,12 @@ aflags-vdso := $(ccflags-vdso) \
 
 ifneq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
+
+# config-n32-o32-env.c prepares the environment to build a 32bit vDSO
+# library on a 64bit kernel.
+# Note: Needs to be included before than the generic library.
+CFLAGS_vgettimeofday-o32.o = -include config-n32-o32-env.c -include $(c-gettimeofday-y)
+CFLAGS_vgettimeofday-n32.o = -include config-n32-o32-env.c -include $(c-gettimeofday-y)
 endif
 
 CFLAGS_REMOVE_vgettimeofday.o = -pg
diff --git a/arch/mips/vdso/config-n32-o32-env.c b/arch/mips/vdso/config-n32-o32-env.c
new file mode 100644
index 000000000000..da4994b2b3e5
--- /dev/null
+++ b/arch/mips/vdso/config-n32-o32-env.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Configuration file for O32 and N32 binaries.
+ * Note: To be included before lib/vdso/gettimeofday.c
+ */
+#if defined(CONFIG_MIPS32_O32) || defined(CONFIG_MIPS32_N32)
+/*
+ * In case of a 32 bit VDSO for a 64 bit kernel fake a 32 bit kernel
+ * configuration.
+ */
+#undef CONFIG_64BIT
+
+#define CONFIG_32BIT 1
+#define CONFIG_GENERIC_ATOMIC64 1
+
+#endif
+
-- 
2.22.0


--------------E09C3611481E52636CE747FD--
