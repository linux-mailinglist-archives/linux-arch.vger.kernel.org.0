Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A0286268
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgJGPoX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJGPoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:44:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA659C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:44:22 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBbx-0010gR-6m; Wed, 07 Oct 2020 17:44:13 +0200
Message-ID: <a7d49bb4cecb14559faaedf7e875d86f2cd81d8b.camel@sipsolutions.net>
Subject: Re: [RFC v7 08/21] um: add nommu mode for UML library mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:44:12 +0200
In-Reply-To: <ac5a99db869705b284307dea21b37068ee5ae7d2.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <ac5a99db869705b284307dea21b37068ee5ae7d2.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This patch introduces the nommu operation with UML code so that host
> interface can be shrineked for broader environments support.

shrunk

> The nommu mode is implemneted as SUBARCH of arch/um, which places at

implemented

> arch/um/nommu. This SUBARCH defines mode-specific code of memory
> management as well as thread implementation, along with the uapi headers
> to be exported to users.
> 
> The headers we introduce in this patch are simple wrappers to the
> asm-generic headers or stubs for things we don't support, such as
> ptrace, DMA, signals, ELF handling and low level processor operations.
> 
> nommu mode shares most of arch/um code (irq, thread_info, process
> scheduling) but implements its own facilities, which are memory
> management (nommu), thread primitives (struct arch_thread), system call
> interface, and console.
> 
> The outlook of updated directory structure is as follows:
> 
>    arch/um
>    |-- configs         (untouched)
>    |-- drivers         unuse stdio_console.c for !MMU
>    |-- include
>    |   |-- asm         updated with !CONFIG_MMU
>    |   |-- linux       (untouched)
>    |   `-- shared      updated with new functions
>    |       `-- skas    (untouched)
>    |   `-- uapi        added for upai header installation
>    |-- kernel          updated to integrate with !MMU
>    |   `-- skas        (untouched, don't use for !MMU)
>    |-- nommu           SUBARCH dir (internally =um/nommu)
>    |   |-- include
>    |   |   |-- asm     headers for subarch specific info
>    |   |   `-- uapi    headers for user-visible APIs
>    |   `-- um
>    |       `-- shared  headers for subarch specific info
>    `-- scripts         added a script for header installation

That seems awkward. Might be nice now for "as little changes as
possible", but eventually it seems it would be better to separate that
out into arch/um/{common,nommu,mmu}/ or something like that?

Or perhaps something like

	arch/um/{common,lkl,full}

or something? Not sure I like 'full' though. 'vm'? Hmm.

(also, scripts/ doesn't exist in this patch?)

> +++ b/arch/um/nommu/Makefile
> @@ -0,0 +1 @@
> +#

hmm? maybe add a comment why an empty makefile is needed.

> diff --git a/arch/um/nommu/Makefile.um b/arch/um/nommu/Makefile.um
> new file mode 100644
> index 000000000000..3808462d8283
> --- /dev/null
> +++ b/arch/um/nommu/Makefile.um

[...]

> +ifeq ($(shell uname -s), Linux)
> +NPROC=$(shell nproc)
> +else # e.g., FreeBSD
> +NPROC=$(shell sysctl -n hw.ncpu)
> +endif

That seems very inappropriate here.

> +
> +um_headers_install: $(objtree)/$(HOST_DIR)/include/generated/uapi/asm/syscall_defs.h headers
> +# if syscall_defs.h is newer than generated headers (autoconf.h)
> +	$(Q)if [ ! -r $(objtree)/tools/um/include/lkl/autoconf.h ] || \
> +	  [ $< -nt $(objtree)/tools/um/include/lkl/autoconf.h ]; then \
> +		$(srctree)/$(ARCH_DIR)/scripts/headers_install.py \
> +			$(subst -j,-j$(NPROC),$(findstring -j,$(MAKEFLAGS))) \

Yeah ... just don't.

> +++ b/arch/um/nommu/include/asm/atomic.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_NOMMU_ATOMIC_H
> +#define __UM_NOMMU_ATOMIC_H
> +
> +#include <asm-generic/atomic.h>
> +
> +#ifndef CONFIG_GENERIC_ATOMIC64
> +#include "atomic64.h"
> +#endif /* !CONFIG_GENERIC_ATOMIC64 */
> +
> +#endif
> diff --git a/arch/um/nommu/include/asm/atomic64.h b/arch/um/nommu/include/asm/atomic64.h
> new file mode 100644
> index 000000000000..949360dea7af
> --- /dev/null
> +++ b/arch/um/nommu/include/asm/atomic64.h

That doesn't make sense to me, you can control CONFIG_GENERIC_ATOMIC64
to be on, and don't need the ifdef and this file?

> diff --git a/arch/um/nommu/include/asm/bitsperlong.h b/arch/um/nommu/include/asm/bitsperlong.h
> new file mode 100644
> index 000000000000..a150cee41e75
> --- /dev/null
> +++ b/arch/um/nommu/include/asm/bitsperlong.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_NOMMU_BITSPERLONG_H
> +#define __UM_NOMMU_BITSPERLONG_H
> +
> +#include <uapi/asm/bitsperlong.h>
> +
> +#define BITS_PER_LONG __BITS_PER_LONG
> +
> +#define BITS_PER_LONG_LONG 64
> +
> +#endif

That's very similar to the contents of include/asm-
generic/bitsperlong.h, add comments why it's needed?

> diff --git a/arch/um/nommu/include/asm/byteorder.h b/arch/um/nommu/include/asm/byteorder.h
> new file mode 100644
> index 000000000000..920a5fd26cad
> --- /dev/null
> +++ b/arch/um/nommu/include/asm/byteorder.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_NOMMU_BYTEORDER_H
> +#define __UM_NOMMU_BYTEORDER_H
> +
> +#include <uapi/asm/byteorder.h>
> +
> +#endif

Not sure why this file even exists, it doesn't for any other arch
(except for h8300 which seems odd).

> diff --git a/arch/um/nommu/include/asm/elf.h b/arch/um/nommu/include/asm/elf.h
> new file mode 100644
> index 000000000000..edcf63edeed1
> --- /dev/null
> +++ b/arch/um/nommu/include/asm/elf.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_NOMMU_ELF_H
> +#define __UM_NOMMU_ELF_H
> +
> +#define elf_check_arch(x) 0

Please add a comment ...

> +#ifdef CONFIG_64BIT
> +#define ELF_CLASS ELFCLASS64
> +#else
> +#define ELF_CLASS ELFCLASS32
> +#endif
> +
> +#define elf_gregset_t long
> +#define elf_fpregset_t double

Also here.

> +#ifndef __UM_NOMMU_SCHED_H
> +#define __UM_NOMMU_SCHED_H
> +
> +#include <linux/sched.h>
> +#include <uapi/asm/host_ops.h>
> +
> +static inline void thread_sched_jb(void)
> +{
> +	if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD)) {
> +		set_ti_thread_flag(current_thread_info(), TIF_SCHED_JB);
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		lkl_ops->jmp_buf_set(&current_thread_info()->task->thread.arch.sched_jb,
> +				     schedule);
> +	} else {
> +		lkl_bug("%s can be used only for host task", __func__);
> +	}
> +}

What's "thread_sched_jb"? Doesn't really seem to exist? Neither does
"TIF_SCHED_JB", at least in my kernel?

Looks like that's added by a later patch, should probably then add this
file also only later so it's actually consistent and one can review all
the pieces together.

> +++ b/arch/um/nommu/include/uapi/asm/Kbuild
> @@ -0,0 +1,6 @@
> +# UAPI Header export list
> +
> +generated-y += syscall_defs.h
> +
> +# no generated-y since we need special user headers handling
> +# see arch/um/script/headers_install.py

Also doesn't exist yet.

> +++ b/arch/um/nommu/um/delay.c

why the double um/ path?

> +/* skas/process.c */
> +void halt_skas(void)
> +{}

nit: missing blank line after this

> +int is_skas_winch(int pid, int fd, void *data)
> +{
> +	return 0;
> +}
> +void reboot_skas(void)
> +{}
> +
> +int __init start_uml(void)
> +{
> +	return 0;
> +}

That seems odd?

Might be better to have an own os.h, or split that into os-uml.h and
os-lkl.h or so?

johannes

