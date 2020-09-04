Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED125E3BC
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 00:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgIDWfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgIDWfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 18:35:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B797C061244;
        Fri,  4 Sep 2020 15:35:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEKIg-00AaHv-Ll; Fri, 04 Sep 2020 22:35:18 +0000
Date:   Fri, 4 Sep 2020 23:35:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in
 raw_copy_{from,to}_user
Message-ID: <20200904223518.GR1236603@ZenIV.linux.org.uk>
References: <20200904165216.1799796-1-hch@lst.de>
 <20200904165216.1799796-4-hch@lst.de>
 <20200904180617.GQ1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904180617.GQ1236603@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 07:06:17PM +0100, Al Viro wrote:
> On Fri, Sep 04, 2020 at 06:52:11PM +0200, Christoph Hellwig wrote:
> > Use get_unaligned and put_unaligned for the small constant size cases
> > in the generic uaccess routines.  This ensures they can be used for
> > architectures that do not support unaligned loads and stores, while
> > being a no-op for those that do.
> 
> Frankly, I would rather get rid of those constant-sized cases entirely;
> sure, we'd need to adjust asm-generic/uaccess.h defaults for __get_user(),
> but there that kind of stuff would make sense; in raw_copy_from_user()
> it really doesn't.

FWIW, we have asm-generic/uaccess.h used by
	arc
	c6x
	hexagon
	riscv/!MMU
	um
by direct includes from asm/uaccess.h
	h8300
picked as default from asm-generic, in place of absent native uaccess.h

In asm-generic/uaccess.h we have
	raw_copy_from_user(): CONFIG_UACCESS_MEMCPY
		[h8300, riscv with your series]
	raw_copy_to_user(): CONFIG_UACCESS_MEMCP
		[h8300, riscv with your series]
	set_fs group: MAKE_MM_SEG KERNEL_DS USER_DS set_fs() get_fs() uaccess_kernel()
		all, really
	access_ok()/__access_ok() (unless overridden)
		[c6x/!CONFIG_ACCESS_CHECK h8300 riscv]
	__put_user()/put_user()
		all, implemented via __put_user_fn()
	__put_user_fn(): raw_copy_to_user(), unless overridden [all except arc]
	__get_user()/get_user()
		all, implemented via __get_user_fn()
	__get_user_fn(): raw_copy_from_user(), unless overridden [all except arc]
	__strncpy_from_user() (unless overridden) [c6x h8300 riscv]
	strncpy_from_user()
	__strnlen_user() (unless overridden) [c6x h8300 riscv]
	strnlen_user()
	__clear_user() (unless overridden) [c6x h8300 riscv]
	clear_user()

__strncpy_from_user()/__strnlen_user()/__clear_user() are never used outside
of arch/*, and there almost all callers are non-__ variants of the same.
Exceptions:
arch/hexagon/include/asm/uaccess.h:76:  long res = __strnlen_user(src, n);
	racy implementation of __strncpy_from_user()
arch/c6x/kernel/signal.c:157:   err |= __clear_user(&frame->uc, offsetof(struct ucontext, uc_mcontext));
arch/x86/include/asm/fpu/internal.h:367:        err = __clear_user(&buf->header, sizeof(buf->header));
arch/x86/kernel/fpu/signal.c:138:       if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))

and that's it.

	Now, if you look at raw_copy_from_user() you'll see an interesting
picture: some architectures special-case the handling of small constant sizes.
Namely,
	arc (any size; inlining in there is obscene, constant size or not),
	c6x (1,4,8),
	m68k/MMU (1,2,3,4,5,6,7,8,9,10,12)
	ppc (1,2,4,8),
	h8300 (1,2,4),
	riscv (with your series)(1,2,4, 8 if 64bit).

	If you look at the callers of e.g. raw_copy_from_user(), you'll
see this:
	* default __get_user_fn() [relevant on c6x, h8300 and riscv - in
all cases it should be doing get_unaligned() instead]
	* __copy_from_user_inatomic()
	* __copy_from_user()
	* copy_from_user() in case of INLINE_COPY_FROM_USER [relevant on
arc, c6x and m68k]
	* lib/* callers, all with non-constant sizes.

Callers of __copy_from_user_inatomic() on relevant architectures, excluding the
ones with non-constant (or huge - several get PAGE_SIZE) sizes:
	* [ppc] p9_hmi_special_emu() - 16 bytes read; not recognized as special
	* [riscv] user_backtrace() - 2 words read; not recognized as special
	* __copy_from_user_inatomic_nocache()
	* arch_perf_out_copy_user()

All callers of __copy_from_user_inatomic_nocache() pass it non-constant sizes.
arch_perf_out_copy_user() is called (via layers of preprocessor abuse) via
__output_copy_user(), which gets non-constant size.

Callers of __copy_from_user() potentially hitting those:
arch/arc/kernel/signal.c:108:   err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
arch/c6x/kernel/signal.c:82:    if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
arch/h8300/kernel/signal.c:114: if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
arch/m68k/kernel/signal.c:340:          if (__copy_from_user(current->thread.fpcntl,
arch/m68k/kernel/signal.c:794:       __copy_from_user(&set.sig[1], &frame->extramask,
arch/m68k/kernel/signal.c:817:  if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
arch/powerpc/kernel/signal_64.c:688:    if (__copy_from_user(&set, &new_ctx->uc_sigmask, sizeof(set)))
arch/powerpc/kernel/signal_64.c:719:    if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
arch/powerpc/kvm/book3s_64_mmu_hv.c:1864:               if (__copy_from_user(&hdr, buf, sizeof(hdr)))
arch/riscv/kernel/signal.c:113: if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2244:            if (__copy_from_user(&fence, user++, sizeof(fence))) {
include/linux/regset.h:256:             } else if (__copy_from_user(data, *ubuf, copy))

The last one is user_regset_copyin() and it's going to die.
A bunch of signal-related ones are in in sigreturn variants, reading
sigset_t.  Considering that shitloads of data get copied nearby for
each such call, I would be surprised if those would be worth bothering
with.   Remaining ppc case is kvm_htab_write(), which just might be
hot enough to care; we are copying a 64bit structure, and it might
be worth reading it as a single 64bit.  And i915 is reading 64bit
objects in a loop.  Hell knows, might or might not be hot.

copy_from_user() callers on arc, c6x and m68k boil down to one case:
arch/arc/kernel/disasm.c:37:            bytes_not_copied = copy_from_user(ins_buf,
8-byte read.  And that's it.

IOW, there's a scattering of potentially valid uses that might be better
off with get_user().  And there's generic non-MMU variant that gets
used in get_user()/__get_user() on h8300 and riscv.  This one *is*
valid, but I don't think that raw_copy_from_user() is the right layer
for that.

For raw_copy_to_user() the picture is similar.  And I'd like to get
rid of that magical crap.  Let's not make it harder...
