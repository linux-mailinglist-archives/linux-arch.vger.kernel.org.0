Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFAF33A6FD
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhCNQto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhCNQte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 12:49:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764CBC061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 09:49:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLTvc-00G3Cx-0I; Sun, 14 Mar 2021 17:49:20 +0100
Message-ID: <ad59d36bc01805bd6f2d2e63e52d85f948b0c7f6.camel@sipsolutions.net>
Subject: Re: [RFC v8 06/20] um: add UML library mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 17:49:19 +0100
In-Reply-To: <30b989750979c00b5ceec4fe5faa6fb8332212d5.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <30b989750979c00b5ceec4fe5faa6fb8332212d5.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:
> 
> +++ b/arch/um/lkl/include/asm/atomic.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_LIBMODE_ATOMIC_H
> +#define __UM_LIBMODE_ATOMIC_H
> +
> +#include <asm-generic/atomic.h>
> +
> +#ifndef CONFIG_GENERIC_ATOMIC64
> +#include "atomic64.h"
> +#endif /* !CONFIG_GENERIC_ATOMIC64 */

That's not actually configurable, is it? When is this on or off?


> +static inline void cpu_relax(void)
> +{
> +	unsigned long flags;
> +
> +	/* since this is usually called in a tight loop waiting for some
> +	 * external condition (e.g. jiffies) lets run interrupts now to allow
> +	 * the external condition to propagate
> +	 */
> +	local_irq_save(flags);
> +	local_irq_restore(flags);

Hmm?

If interrupts are enabled, then you'll get them anyway, and if not, then
this does nothing?

> +static inline void arch_copy_thread(struct arch_thread *from,
> +				    struct arch_thread *to)
> +{
> +	panic("unimplemented %s: fork isn't supported yet", __func__);
> +}

"yet" seems kind of misleading - I mean, it really *won't* be, since
that's basically what UML is, no?

I mean, in principle, nothing actually stops you from building a
linux.so instead of linux binary, and having main() renamed to
linux_main() so the application can start up whenever it needs to, or
something like that?



> +#endif
> diff --git a/arch/um/lkl/include/asm/ptrace.h b/arch/um/lkl/include/asm/ptrace.h
> new file mode 100644
> index 000000000000..83f4e10fb677
> --- /dev/null
> +++ b/arch/um/lkl/include/asm/ptrace.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_LIBMODE_PTRACE_H
> +#define __UM_LIBMODE_PTRACE_H
> +
> +#include <linux/errno.h>
> +
> +static int reg_dummy __attribute__((unused));
> +
> +#define PT_REGS_ORIG_SYSCALL(r) (reg_dummy)
> +#define PT_REGS_SYSCALL_RET(r) (reg_dummy)
> +#define PT_REGS_SET_SYSCALL_RETURN(r, res) (reg_dummy = (res))
> +#define REGS_SP(r) (reg_dummy)
> +
> +#define user_mode(regs) 0
> +#define kernel_mode(regs) 1
> +#define profile_pc(regs) 0
> +#define user_stack_pointer(regs) 0
> +
> +extern void new_thread_handler(void);
> +
> +#endif
> diff --git a/arch/um/lkl/include/asm/segment.h b/arch/um/lkl/include/asm/segment.h
> new file mode 100644
> index 000000000000..1f6746866b8b
> --- /dev/null
> +++ b/arch/um/lkl/include/asm/segment.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_LIBMODE_SEGMENT_H
> +#define __UM_LIBMODE_SEGMENT_H
> +
> +typedef struct {
> +	unsigned long seg;
> +} mm_segment_t;
> +
> +#endif /* _ASM_LKL_SEGMENT_H */
> diff --git a/arch/um/lkl/include/uapi/asm/bitsperlong.h b/arch/um/lkl/include/uapi/asm/bitsperlong.h
> new file mode 100644
> index 000000000000..f6657ba0ff9b
> --- /dev/null
> +++ b/arch/um/lkl/include/uapi/asm/bitsperlong.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_LIBMODE_UAPI_BITSPERLONG_H
> +#define __UM_LIBMODE_UAPI_BITSPERLONG_H
> +
> +#ifdef CONFIG_64BIT
> +#define __BITS_PER_LONG 64
> +#else
> +#define __BITS_PER_LONG 32
> +#endif
> +
> +#include <asm-generic/bitsperlong.h>

First, that include does nothing. Second, the comment there says:

/*
 * There seems to be no way of detecting this automatically from user
 * space, so 64 bit architectures should override this in their
 * bitsperlong.h. In particular, an architecture that supports
 * both 32 and 64 bit user space must not rely on CONFIG_64BIT
 * to decide it, but rather check a compiler provided macro.
 */


So you're doing exactly what it says *not* to?

In fact, that totally makes sense - I mean, this is *uapi* and
applications don't have access to CONFIG_ defines etc.

Do you expose that somehow to LKL users that makes this OK-ish? But it's
still very confusing, and you've not made sure the necessary header is
actually included. IIUC, lkl builds a (shared?) library, so it won't
really work this way?

> +++ b/arch/um/lkl/include/uapi/asm/byteorder.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UM_LIBMODE_UAPI_BYTEORDER_H
> +#define __UM_LIBMODE_UAPI_BYTEORDER_H
> +
> +#if defined(CONFIG_BIG_ENDIAN)
> +#include <linux/byteorder/big_endian.h>

Same here.

> +++ b/arch/um/lkl/um/delay.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/jiffies.h>
> +#include <linux/delay.h>
> +#include <os.h>
> +
> +void __ndelay(unsigned long nsecs)
> +{
> +	long long start = os_nsecs();
> +
> +	while (os_nsecs() < start + nsecs)
> +		;

At least do something like cpu_relax()? Although ... you made that do
nothing, so you probably want an arch-specific thing here?

johannes

