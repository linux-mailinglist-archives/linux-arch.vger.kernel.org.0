Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11D71619C3
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgBQSdm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 13:33:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37422 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgBQSdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Feb 2020 13:33:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lDA-00EJGf-2W; Mon, 17 Feb 2020 18:33:40 +0000
Date:   Mon, 17 Feb 2020 18:33:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC] regset ->get() API
Message-ID: <20200217183340.GI23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Looking at the regset guts, I really wonder if the interface
is right.  What happens goes along the lines of

ptrace(PTRACE_GETREGS, pid, whatever, buf)
  arch_ptrace(task, PTRACE_GETREGS, whatever, buf)
    copy_regset_to_user(task, task_user_regset_view(current),
		REGSET_GENERAL, 0, sizeof(struct user_regs_struct), buf);
     check access_ok(buf, sizeof(...)
     genregs_get(task, regset, 0, sizeof(...), NULL, buf);
and we hit
static int genregs_get(struct task_struct *target,
                       const struct user_regset *regset,
                       unsigned int pos, unsigned int count,
                       void *kbuf, void __user *ubuf)
{
        if (kbuf) {
                unsigned long *k = kbuf;
                while (count >= sizeof(*k)) {
                        *k++ = getreg(target, pos);
                        count -= sizeof(*k);
                        pos += sizeof(*k);
                }
        } else {
                unsigned long __user *u = ubuf;
                while (count >= sizeof(*u)) {
                        if (__put_user(getreg(target, pos), u++))
                                return -EFAULT;
                        count -= sizeof(*u);
                        pos += sizeof(*u);
                }
        }

        return 0;
}
 
IOW, we call getreg() in a loop, with separate __put_user() for each
value.  For one thing, it's going to be painful on any recent x86 -
the cost of stac/clac on each of those is not going to be cheap.
And we obviously can't extend stac/clac area over the entire loop
there - getreg() is not trivial.

For another, the calling conventions are too generic - the callers
of ->get() always pass zero for pos, for example.  And this "pass
kbuf and ubuf separately" wart does not make it any prettier.

Other instances (e.g. powerpc gpr_get()) do not use __put_user() -
they make a series of user_regset_copyout()/user_regset_copyout_zero()
calls (4 in this case):
static inline int user_regset_copyout(unsigned int *pos, unsigned int *count,
                                      void **kbuf,
                                      void __user **ubuf, const void *data,
                                      const int start_pos, const int end_pos)
{
        if (*count == 0)
                return 0;
        BUG_ON(*pos < start_pos);
        if (end_pos < 0 || *pos < end_pos) {
                unsigned int copy = (end_pos < 0 ? *count
                                     : min(*count, end_pos - *pos));
                data += *pos - start_pos;
                if (*kbuf) {
                        memcpy(*kbuf, data, copy);
                        *kbuf += copy;
                } else if (__copy_to_user(*ubuf, data, copy))
                        return -EFAULT;
                else
                        *ubuf += copy;
                *pos += copy;
                *count -= copy;
        }
        return 0;
}

The caller obviously needs to check if the damn thing has failed, and the
calling conventions are still over-generic (grep and you'll see).  The
actual calls of __copy_to_user()/__clear_user() have destinations back-to-back.
And while in case of ppc their number is not too large, for e.g.
arch/arc/kernel/ptrace.c:genregs_get() we get 39 calls of those things -
basically, back to the __put_user-inna-loop-and-thats-cuttin-me-own-throat
situation we have on x86, only with more overhead per register.

And too convoluted calling conventions come with the usual price - they
are too easy to get wrong.  Example:
arch/x86/math-emu/fpu_entry.c:fpregs_soft_get() is
{
        struct swregs_state *s387 = &target->thread.fpu.state.soft;
        const void *space = s387->st_space;
        int ret;
        int offset = (S387->ftop & 7) * 10, other = 80 - offset;

        RE_ENTRANT_CHECK_OFF;

#ifdef PECULIAR_486
        S387->cwd &= ~0xe080;
        /* An 80486 sets nearly all of the reserved bits to 1. */
        S387->cwd |= 0xffff0040;
        S387->swd = sstatus_word() | 0xffff0000;
        S387->twd |= 0xffff0000;
        S387->fcs &= ~0xf8000000;
        S387->fos |= 0xffff0000;
#endif /* PECULIAR_486 */

        ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, s387, 0,
                                  offsetof(struct swregs_state, st_space));

OK, here we copy everything in s387 up to the beginning of s387->st_space.
Fair enough.  Now pos is offsetof(struct swregs_state, st_space)), and...
        /* Copy all registers in stack order. */
        if (!ret)
                ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                          space + offset, 0, other);
        if (!ret)
                ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                          space, 0, offset);
We _intend_ to copy stack entries, top..7, then 0..top-1, out of
s387->st_space.  What we actually do is different - pos is updated
by each call, so the last two arguments in these calls are wrong.
They should've been offsetof(struct swregs_state, st_space)) and
offsetof(struct swregs_state, st_space)) + other in the first
one and offsetof(struct swregs_state, st_space)) + other and
offsetof(struct swregs_state, st_space)) + 80 in the second one.

It's not hard to fix, and nobody really uses !CONFIG_FPU setups
on x86 anyway; the point is that this is really easy to get wrong.

What I really wonder is whether it's actually worth bothering - the
life would be much simpler if we *always* passed a kernel buffer to
->get() instances and did all copyout at once.  Sure, it results in
double copies, but... would that really cost more than all the complexity
we have there?

What are the typical amounts of data copied in such ptrace() calls
and how hot they normally are?
