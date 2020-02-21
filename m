Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA94B166DBE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 04:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgBUDaV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 22:30:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45130 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUDaV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 22:30:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4z16-00G8es-2v; Fri, 21 Feb 2020 03:30:16 +0000
Date:   Fri, 21 Feb 2020 03:30:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] regset ->get() API
Message-ID: <20200221033016.GV23230@ZenIV.linux.org.uk>
References: <20200217183340.GI23230@ZenIV.linux.org.uk>
 <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk>
 <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
 <20200220232929.GU23230@ZenIV.linux.org.uk>
 <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 03:31:56PM -0800, Linus Torvalds wrote:
> On Thu, Feb 20, 2020 at 3:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > We do know that caller does not want more than the value it has passed in
> > 'size' argument, though.
> 
> Ok, fair enough. That's probably a good way to handle the "allocate in
> the caller".
> 
> So then I have no issues with that approach.

Turns out that "nobody uses those for userland destinations after that" is not
quite right - we have this:
int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
{
        struct task_struct *tsk = current;
        int ia32_fxstate = (buf != buf_fx);
        int ret;

        ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
                         IS_ENABLED(CONFIG_IA32_EMULATION));

        if (!access_ok(buf, size))
                return -EACCES;

        if (!static_cpu_has(X86_FEATURE_FPU))
                return fpregs_soft_get(current, NULL, 0,
                        sizeof(struct user_i387_ia32_struct), NULL,
                        (struct _fpstate_32 __user *) buf) ? -1 : 1;

... with fpregs_soft_get() behing the shared helper that does, in turn,
call user_regset_copyout().  OTOH, _that_ sure as hell is "fill local
variable, then copy_to_user()" case.

Sigh...  Wish we had a quick way to do something along the lines of
"find all callchains leading to <function> that would not come via
-><method>" - doing that manually stank to high heaven ;-/  And in
cases like that nothing along the lines of "simulate a build" is
practical - call chains are all over arch/*, and config-sensitive
as well (32bit vs. 64bit is only beginning of that fun).  Thankfully,
none of those involved token-pasting...

Anyway, one observation that came out of that is that we might
be better off with signature change done first; less boilerplate
that way, contrary to what I expected.

Alternatively, we could introduce a new method, with one-by-one
conversion to it.  Hmm...
	int (*get2)(struct task_struct *target,
		    const struct user_regset *regset,
		    struct membuf to);
returning -E... on error and amount left unfilled on success, perhaps?
That seems to generate decent code and is pretty easy on the instances,
especially if membuf_write() et.al. are made to return to->left...
Things like

static int evr_get(struct task_struct *target, const struct user_regset *regset,
                   struct membuf to)
{
        flush_spe_to_thread(target);

        membuf_write(&to, &target->thread.evr, sizeof(target->thread.evr));

        BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
                     offsetof(struct thread_struct, spefscr));

        return membuf_write(&to, &target->thread.acc, sizeof(u64));
}

in place of current

static int evr_get(struct task_struct *target, const struct user_regset *regset,
                   unsigned int pos, unsigned int count,
                   void *kbuf, void __user *ubuf)
{
        int ret;

        flush_spe_to_thread(target);

        ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                  &target->thread.evr,
                                  0, sizeof(target->thread.evr));

        BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
                     offsetof(struct thread_struct, spefscr));

        if (!ret)
                ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                          &target->thread.acc,
                                          sizeof(target->thread.evr), -1);

        return ret;
}

and

static int vr_get(struct task_struct *target, const struct user_regset *regset,
                  struct membuf to)
{
	union {
		elf_vrreg_t reg;
		u32 word;
	} vrsave;

        flush_altivec_to_thread(target);

        BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
                     offsetof(struct thread_vr_state, vr[32]));

        membuf_write(&to, &target->thread.vr_state, 33 * sizeof(vector128));
	/*
	 * Copy out only the low-order word of vrsave.
	 */
	memset(&vrsave, 0, sizeof(vrsave));
	vrsave.word = target->thread.vrsave;

	return membuf_write(&to, &vrsave, sizeof(vrsave);
}

instead of

static int vr_get(struct task_struct *target, const struct user_regset *regset,
                  unsigned int pos, unsigned int count,
                  void *kbuf, void __user *ubuf)
{
        int ret;

        flush_altivec_to_thread(target);

        BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
                     offsetof(struct thread_vr_state, vr[32]));

        ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
                                  &target->thread.vr_state, 0,
                                  33 * sizeof(vector128));
        if (!ret) {
                /*
                 * Copy out only the low-order word of vrsave.
                 */
                int start, end;
                union {
                        elf_vrreg_t reg;
                        u32 word;
                } vrsave;
                memset(&vrsave, 0, sizeof(vrsave));

                vrsave.word = target->thread.vrsave;

                start = 33 * sizeof(vector128);
                end = start + sizeof(vrsave);
                ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
                                          start, end);
        }

        return ret;
}
