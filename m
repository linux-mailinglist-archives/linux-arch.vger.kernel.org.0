Return-Path: <linux-arch+bounces-7115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3C96F3F3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 14:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42223286745
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5F1CBE8C;
	Fri,  6 Sep 2024 12:04:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F22233B;
	Fri,  6 Sep 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624285; cv=none; b=ZHVTy+r2dHYL0D6AbOEOvwSmrLdQEZvwa7sCgN20VXi/w7WVbn5oqXKeEFsutpk90Gq4G0J86YfxDXmdJTDthBtRUn+lQl9AwzecEy+QdZesjNB0mlmOcFOZVOzTRJ7p7z5uPy/t0WgqCjgrLwZCYv/azvzljziFbsmP5kxlrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624285; c=relaxed/simple;
	bh=55gUJMDTC3/pBOEkdNxLHnHLs7HndChLxy9qDTL78u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moVc02Q4h5NWbfJ7XiIy9m0+YnwAJY+846SOkQjJjTV28GjX/liRXPT7XR3L/c8BGYhDxto2IegP+UBuvIBQwAWFGIqeJOKbYOgftU8sagGVuYOeBbLDhcw/4qrYcGomH3fkWWJ2Rj16XjKhdtC97PsC2t7gokihUT8I6Re0feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0ZfJ4QQgz9sRs;
	Fri,  6 Sep 2024 14:04:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUm50aOSwMqG; Fri,  6 Sep 2024 14:04:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0ZfJ3513z9sRr;
	Fri,  6 Sep 2024 14:04:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5364E8B778;
	Fri,  6 Sep 2024 14:04:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xTSHCMgcQrW2; Fri,  6 Sep 2024 14:04:40 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EBB48B764;
	Fri,  6 Sep 2024 14:04:39 +0200 (CEST)
Message-ID: <4a4873d9-c783-4374-a505-3628d3c92137@csgroup.eu>
Date: Fri, 6 Sep 2024 14:04:38 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vdso: Modify getrandom to include the correct
 namespace
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-10-vincenzo.frascino@arm.com>
 <b899bce8-8704-4288-9f32-bcb2fa0d29a8@csgroup.eu>
 <72f3d6cf-a03b-4a16-9983-77d3dd70b0ea@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <72f3d6cf-a03b-4a16-9983-77d3dd70b0ea@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/09/2024 à 13:52, Vincenzo Frascino a écrit :
> 
> 
> On 04/09/2024 18:26, Christophe Leroy wrote:
>>
>>
>> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
> ...
> 
>>
>> Now build fails on powerpc because struct vgetrandom_opaque_params is unknown.
>>
>> x86 get it by chance via the following header inclusion chain:
>>
>> In file included from ./include/linux/random.h:10,
>>                   from ./include/linux/nodemask.h:98,
>>                   from ./include/linux/mmzone.h:18,
>>                   from ./include/linux/gfp.h:7,
>>                   from ./include/linux/xarray.h:16,
>>                   from ./include/linux/radix-tree.h:21,
>>                   from ./include/linux/idr.h:15,
>>                   from ./include/linux/kernfs.h:12,
>>                   from ./include/linux/sysfs.h:16,
>>                   from ./include/linux/kobject.h:20,
>>                   from ./include/linux/of.h:18,
>>                   from ./include/linux/clocksource.h:19,
>>                   from ./include/clocksource/hyperv_timer.h:16,
>>                   from ./arch/x86/include/asm/vdso/gettimeofday.h:21,
>>                   from ./include/vdso/datapage.h:164,
>>                   from arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:7,
>>                   from arch/x86/entry/vdso/vgetrandom.c:7:
>>
>>
>>
>>
> 
> This tells me very little ;)
> 
> Can you please provide more details? e.g. What is the error you are getting? How
> do I reproduce it?
> 
> I am happy to include the required change as part of this series.
> 
> Overall, the reason why I am doing this exercise it to sanitize the headers for
> all the architectures so that in future we do not have issues. It is good we
> find problems now.
> 

More details:

$ make ARCH=powerpc CROSS_COMPILE=ppc-linux- mpc885_ads_defconfig

$ LANG= make ARCH=powerpc CROSS_COMPILE=ppc-linux- vmlinux
   SYNC    include/config/auto.conf
   SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_32.h
   SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_64.h
   SYSTBL  arch/powerpc/include/generated/asm/syscall_table_32.h
   SYSTBL  arch/powerpc/include/generated/asm/syscall_table_64.h
   SYSTBL  arch/powerpc/include/generated/asm/syscall_table_spu.h
   HOSTCC  scripts/dtc/dtc.o
   HOSTCC  scripts/dtc/flattree.o
   HOSTCC  scripts/dtc/fstree.o
   HOSTCC  scripts/dtc/data.o
   HOSTCC  scripts/dtc/livetree.o
   HOSTCC  scripts/dtc/treesource.o
   HOSTCC  scripts/dtc/srcpos.o
   HOSTCC  scripts/dtc/checks.o
   HOSTCC  scripts/dtc/util.o
   LEX     scripts/dtc/dtc-lexer.lex.c
   YACC    scripts/dtc/dtc-parser.tab.[ch]
   HOSTCC  scripts/dtc/dtc-lexer.lex.o
   HOSTCC  scripts/dtc/dtc-parser.tab.o
   HOSTLD  scripts/dtc/dtc
   HOSTCC  scripts/dtc/libfdt/fdt.o
   HOSTCC  scripts/dtc/libfdt/fdt_ro.o
   HOSTCC  scripts/dtc/libfdt/fdt_wip.o
   HOSTCC  scripts/dtc/libfdt/fdt_sw.o
   HOSTCC  scripts/dtc/libfdt/fdt_rw.o
   HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
   HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
   HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
   HOSTCC  scripts/dtc/fdtoverlay.o
   HOSTLD  scripts/dtc/fdtoverlay
   HOSTCC  scripts/kallsyms
   HOSTCC  scripts/sorttable
   CC      scripts/mod/empty.o
   HOSTCC  scripts/mod/mk_elfconfig
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/modpost.o
   CC      scripts/mod/devicetable-offsets.s
   HOSTCC  scripts/mod/file2alias.o
   HOSTCC  scripts/mod/sumversion.o
   HOSTCC  scripts/mod/symsearch.o
   HOSTLD  scripts/mod/modpost
   CC      kernel/bounds.s
   CC      arch/powerpc/kernel/asm-offsets.s
   CALL    scripts/checksyscalls.sh
   CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
   CHKSHA1 include/linux/atomic/atomic-instrumented.h
   CHKSHA1 include/linux/atomic/atomic-long.h
   LDS     arch/powerpc/kernel/vdso/vdso32.lds
   VDSO32A arch/powerpc/kernel/vdso/sigtramp32-32.o
   VDSO32A arch/powerpc/kernel/vdso/gettimeofday-32.o
   VDSO32A arch/powerpc/kernel/vdso/datapage-32.o
   VDSO32A arch/powerpc/kernel/vdso/cacheflush-32.o
   VDSO32A arch/powerpc/kernel/vdso/note-32.o
   VDSO32A arch/powerpc/kernel/vdso/getcpu-32.o
   VDSO32A arch/powerpc/kernel/vdso/getrandom-32.o
   VDSO32A arch/powerpc/kernel/vdso/vgetrandom-chacha-32.o
   VDSO32C arch/powerpc/kernel/vdso/vgettimeofday-32.o
   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
In file included from <command-line>:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function 
'__cvdso_getrandom_data':
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:75:23: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    75 |                 params->size_of_opaque_state = sizeof(*state);
       |                       ^~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:76:23: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    76 |                 params->mmap_prot = VDSO_MMAP_PROT;
       |                       ^~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:77:23: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    77 |                 params->mmap_flags = VDSO_MMAP_FLAGS;
       |                       ^~
In file included from ./include/linux/array_size.h:5,
                  from ./include/linux/kernel.h:16,
                  from ./arch/powerpc/include/asm/page.h:11,
                  from ./arch/powerpc/include/asm/vdso/page.h:8,
                  from ./include/vdso/page.h:5,
                  from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:10:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/vdso/array_size.h:11:33: note: in definition of macro 'ARRAY_SIZE'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       |                                 ^~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/vdso/array_size.h:11:48: note: in definition of macro 'ARRAY_SIZE'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       |                                                ^~~
In file included from ./include/linux/container_of.h:5,
                  from ./include/linux/kernel.h:22:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/linux/build_bug.h:16:62: note: in definition of macro 
'BUILD_BUG_ON_ZERO'
    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { 
int:(-!!(e)); })))
       |                                                              ^
./include/linux/compiler.h:243:51: note: in expansion of macro '__same_type'
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                                   ^~~~~~~~~~~
./include/vdso/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:40: note: in 
expansion of macro 'ARRAY_SIZE'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/linux/build_bug.h:16:62: note: in definition of macro 
'BUILD_BUG_ON_ZERO'
    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { 
int:(-!!(e)); })))
       |                                                              ^
./include/linux/compiler.h:243:51: note: in expansion of macro '__same_type'
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                                   ^~~~~~~~~~~
./include/vdso/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:40: note: in 
expansion of macro 'ARRAY_SIZE'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
./include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width 
not an integer constant
    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { 
int:(-!!(e)); })))
       |                                                   ^
./include/linux/compiler.h:243:33: note: in expansion of macro 
'BUILD_BUG_ON_ZERO'
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                 ^~~~~~~~~~~~~~~~~
./include/vdso/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:78:40: note: in 
expansion of macro 'ARRAY_SIZE'
    78 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:79:31: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    79 |                         params->reserved[i] = 0;
       |                               ^~
In file included from ./include/vdso/datapage.h:7,
                  from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:6:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:88:32: error: 
'GRND_NONBLOCK' undeclared (first use in this function); did you mean 
'MAP_NONBLOCK'?
    88 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       |                                ^~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:88:32: note: each 
undeclared identifier is reported only once for each function it appears in
    88 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       |                                ^~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:88:48: error: 
'GRND_RANDOM' undeclared (first use in this function)
    88 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       |                                                ^~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:88:62: error: 
'GRND_INSECURE' undeclared (first use in this function)
    88 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       | 
^~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
make[2]: *** [arch/powerpc/kernel/vdso/Makefile:87: 
arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1
make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
make: *** [Makefile:227: __sub-make] Error 2



FWIW, here are the changes I added on top of your series:

diff --git a/arch/powerpc/include/asm/vdso/getrandom.h 
b/arch/powerpc/include/asm/vdso/getrandom.h
index 501d6bb14e8a..4af9efdbe296 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -5,6 +5,8 @@
  #ifndef _ASM_POWERPC_VDSO_GETRANDOM_H
  #define _ASM_POWERPC_VDSO_GETRANDOM_H

+#include <vdso/datapage.h>
+
  #ifndef __ASSEMBLY__

  static __always_inline int do_syscall_3(const unsigned long _r0, const 
unsigned long _r3,
diff --git a/arch/powerpc/include/asm/vdso/mman.h 
b/arch/powerpc/include/asm/vdso/mman.h
new file mode 100644
index 000000000000..4c936c9d11ab
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/mman.h
@@ -0,0 +1,15 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_MMAN_H
+#define __ASM_VDSO_MMAN_H
+
+#ifndef __ASSEMBLY__
+
+#include <uapi/linux/mman.h>
+
+#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
+#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_MMAN_H */
diff --git a/arch/powerpc/include/asm/vdso/page.h 
b/arch/powerpc/include/asm/vdso/page.h
new file mode 100644
index 000000000000..c41fd44aca5b
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/page.h
@@ -0,0 +1,15 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_PAGE_H
+#define __ASM_VDSO_PAGE_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/page.h>
+
+#define VDSO_PAGE_MASK	PAGE_MASK
+#define VDSO_PAGE_SIZE	PAGE_SIZE
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PAGE_H */


Christophe


