Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF723496B2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 17:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhCYQVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 12:21:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhCYQUz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 12:20:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72A48AA55;
        Thu, 25 Mar 2021 16:20:53 +0000 (UTC)
Date:   Thu, 25 Mar 2021 17:20:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <20210325162047.GA32296@zn.tnic>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <20210316115248.GB18822@zn.tnic>
 <16A53D65-2460-49B3-892B-81EF8D7B12B9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16A53D65-2460-49B3-892B-81EF8D7B12B9@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 06:26:46PM +0000, Bae, Chang Seok wrote:
> I suspect the AVX-512 states not enabled there.

Ok, I found a machine which has AVX-512:

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.

and applied your patch and added a debug printk, see end of mail.

Then, I ran the test case:

$ gcc tst-minsigstksz-2.c -DMY_MINSIGSTKSZ=3453 -o tst-minsigstksz-2
$ ./tst-minsigstksz-2
tst-minsigstksz-2: changed byte 50 bytes below configured stack

Whoops.

And the debug print said:

[ 5395.252884] signal: get_sigframe: sp: 0x7f54ec39e7b8, sas_ss_sp: 0x7f54ec39e6ce, sas_ss_size 0xd7d

which tells me that, AFAICT, your check whether we have enough alt stack
doesn't seem to work in this case.

Thx.

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb107c0e8..a7396f7c3832 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -237,7 +237,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int onsigstack = on_sig_stack(sp);
+	bool onsigstack = on_sig_stack(sp);
 	int ret;
 
 	/* redzone */
@@ -246,8 +246,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
+			/* On the alternate signal stack */
+			onsigstack = true;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
 		   !onsigstack &&
 		   regs->ss != __USER_DS &&
@@ -263,11 +266,16 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	sp = align_sigframe(sp - frame_size);
 
+	if (onsigstack)
+		pr_info("%s: sp: 0x%lx, sas_ss_sp: 0x%lx, sas_ss_size 0x%lx\n",
+			__func__, sp, current->sas_ss_sp, current->sas_ss_size);
+
 	/*
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
 	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
+	if (onsigstack && unlikely(sp <= current->sas_ss_sp ||
+				   sp - current->sas_ss_sp > current->sas_ss_size))
 		return (void __user *)-1L;
 
 	/* save i387 and extended state */

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
