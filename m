Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D375166A80
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 23:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBTWrK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 17:47:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40988 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBTWrK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 17:47:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4ub5-00G1Ve-6f; Thu, 20 Feb 2020 22:47:07 +0000
Date:   Thu, 20 Feb 2020 22:47:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] regset ->get() API
Message-ID: <20200220224707.GQ23230@ZenIV.linux.org.uk>
References: <20200217183340.GI23230@ZenIV.linux.org.uk>
 <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 12:01:54PM -0800, Linus Torvalds wrote:

> I don't mind it, but some of those buffers are big, and the generic
> code generally doesn't know how big.

That's what regset_size() returns...
 
> You'd probably have to have a whole page to pass in as the buffer -
> certainly not some stack space.
> 
> Maybe even more. I'm not sure how big the FPU regset can get on x86...

amd64:
        REGSET_GENERAL	=>	sizeof(struct user_regs_struct) (216)
        REGSET_FP	=>	sizeof(struct user_i387_struct) (512)
        REGSET_XSTATE	=>	sizeof(struct swregs_state) or 
				sizeof(struct fxregs_state) or
				sizeof(struct fregs_state) or
				XSAVE insn buffer size (max about 2.5Kb, AFAICS)
        REGSET_IOPERM64	=>	IO_BITMAP_BYTES (8Kb, that is)

> But yes, I'd love to see somebody (you, apparently) carefully simplify
> that interface. And I do not think anybody will object - the biggest
> issue is that this touches code across all architectures, and some of
> them are not having a lot of maintenance.
> 
> If you do it in small steps, it probably won't be a problem. Remove
> the "offset" parameter in one patch, do the "only copy to kernel
> space" in another, and hey, if it ends up breaking subtly on something
> we don't have any testers for, well, they can report that a year from
> now and it will get fixed up, but nobody will seriously care.
> 
> IOW, "go wild".
> 
> But at the same time, I wouldn't worry _too_ much about things like
> the performance of copying one register at a time. The reason we do
> that regset thing is not because it's truly high-performance, it's
> just that it sucked dead baby donkeys through a straw to do a full
> "ptrace(PEEKUSR)" for each register.
> 
> So "high performance" is relative. Doing the STAC/CLAC dance for each
> register on x86 is a complete non-issue. It's not that
> performance-critical.
> 
> So yes, "go wild", but do it for the right reasons: simplifying the interface.
> 
> Because if you only worry about current use of
> "__get_user()/__put_user()" optimizations, don't. Just convert to
> "get_user()/put_user()" and be done with it, it's not important. This
> is another area where people used the double-underscore version not
> because it mattered, but because it was available.

FWIW, what I have in mind is to start with making copy_regset_to_user() do
	buf = kmalloc(size, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;
	err = regset->get(target, regset, offset, size, buf, NULL);
	if (!err && copy_to_user(data, buf, size))
		err = -EFAULT;
	kfree(buf);
	return err;

That alone would make sure that ->get() instances always get called
with NULL ubuf.  There are 6 places that can call one of those -
copy_regset_to_user(), fill_thread_core_info() and 4 direct calls
(not via method) - x86 dump_fpu(), sh dump_fpu() and itanit
acces_uarea().  Only the first one went to userland buffer and
with that change it won't do that anymore.

Right after that we can just replace the kbuf == NULL case in
user_regset_copyout()/user_regset_copyout_zero() with BUG();

Next we can start converting instances to more humane helpers -
along the lines of

struct <something> {
	void *p;
	size_t left;
};

static inline void <something>_zero(struct <something> *s, size_t size)
{
	if (s->left) {
		if (size > s->left)
			size = s->left;
		memset(s->p, 0, size);
		s->p += size;
		s->left -= size;
	}
}

static inline void <something>_align(struct <something> *s, int n)
{
	int off = (unsigned long)s->p & (n - 1);
	if (off)
		<something>_zero(s, n - off);
}

static inline void <something>_write(struct <something> *s, void *v, size_t size)
{
	if (s->left) {
		if (unlikely(size < s->left) {
			<something>_zero(s, s->left);
			return;
		}
		memcpy(s->p, v, size);
		s->p += size;
		s->left -= size;
	}
}

#define __<something>_store(s, v, __size)			\
do {								\
	if ((s)->left) {					\
		if (unlikely(__size < (s)->left) {		\
			<something>_zero((s), __size);		\
		} else {					\
			*(typeof(v) *)(s)->p = (v);		\
			(s)->p += __size;			\
			(s)->left -= __size;			\
		}						\
	}							\
} while(0)

/* current s->p must be aligned for v */
#define <something>_store(s, v) __<something>_store((s), (v), sizeof(v))


E.g. genregs_get() becomes
	struct foo to = {.p = kbuf, .left = count};
	int reg;
	for (reg = 0; to.left; reg++)
		foo_store(&to, getreg(target, reg * sizeof(unsigned long)));
	return 0;

while in fpregs_soft_get() we get
	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, s387, 0,
				  offsetof(struct swregs_state, st_space));

	/* Copy all registers in stack order. */
	if (!ret)
		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
					  space + offset, 0, other);
	if (!ret)
		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
					  space, 0, offset);
replaced with
	foo_write(&to, s387, offsetof(struct swregs_state, st_space));
	foo_write(&to, space + offset, other);
	foo_write(&to, space, offset);
(fixing the mishandled pos in there, while we are at it)

Some functions (e.g. copy_xstate_to_user()) simply go away.

Conversions for all instances are independent from each other; once
they are all done, we can throw the current primitives (user_regset_copyout()
and user_regset_copyout_zero()) and do a tree-wide replacement of ->get()
instances - remove the pos and ubuf arguments.

It's doable, and after the first two steps it's uncoupled from the
uaccess series.  As for the helpers...  I'm not sure what name to use;
it's obviously a lot more generic than regset.  membuf, perhaps?
Any suggestions would be welcome, really...
