Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27B828521A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 21:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgJFTJq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 15:09:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:2830 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgJFTJq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 15:09:46 -0400
IronPort-SDR: n56n7rZuxMGwRK5+ajLQmflyb6X5095g5SU6YP/RePGpdD8DXdL0HhYW/LXrEQaEX6AqoImMLO
 yLws0Ihtj2pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="152407987"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="152407987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 12:09:43 -0700
IronPort-SDR: JVWNXCsyOshtk0iJy2Jdo3aA/TVZgk6KdZAoBEzJNnTPbm1wt/z6a5DH2PNKLeGTZq8riBNXXh
 0xMKCudOVmRQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="342444942"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.179.62]) ([10.212.179.62])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 12:09:39 -0700
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
 <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net>
 <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
 <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
 <b8797fcd-9d70-5749-2277-ef61f2e1be1f@intel.com>
 <CALCETrWvWAxEuyteLaPmmu-r5LcWdh_DuW4JAOh3pVD4skWoBQ@mail.gmail.com>
 <CALCETrVvob1dbdWSvaB0ZK1kJ19o9ZKy=U3tFifwOR++_xk=zA@mail.gmail.com>
 <dd4310bd-a76b-cf19-4f12-0b52d7bc483d@intel.com>
 <CALCETrXgde6yHTKw1Njnxp9cANp6Ee8bmG9C2X4e-Fz0ZZCuBw@mail.gmail.com>
 <CAMe9rOonjX-b46sJ3AYSJZV84d=oU6-KhScnk5vksVqoLgQ90A@mail.gmail.com>
 <CALCETrWoGXDDEvy10LoYVY6c_tkpMVABhCy+8pse9Rw8L9L=5A@mail.gmail.com>
 <79d1e67d-2394-1ce6-3bad-cce24ba792bd@intel.com>
 <CALCETrU-pjSFBGBROukA8dtSUmft9E1j86oS16Lw0Oz1yzv8Gw@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <ac8da604-3dff-ddb2-f530-2a256da3618d@intel.com>
Date:   Tue, 6 Oct 2020 12:09:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CALCETrU-pjSFBGBROukA8dtSUmft9E1j86oS16Lw0Oz1yzv8Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/1/2020 10:26 AM, Andy Lutomirski wrote:
> On Thu, Oct 1, 2020 at 9:51 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> On 9/30/2020 6:10 PM, Andy Lutomirski wrote:
>>> On Wed, Sep 30, 2020 at 6:01 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>>>>
>>>> On Wed, Sep 30, 2020 at 4:44 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> [...]
>>
>>>>>>>>>     From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
>>>>>>>>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>>>>>>> Date: Thu, 29 Nov 2018 14:15:38 -0800
>>>>>>>>> Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and
>>>>>>>>> Indirect Branch
>>>>>>>>>      Tracking for vsyscall emulation
>>>>>>>>>
>>>>>>>>> Vsyscall entry points are effectively branch targets.  Mark them with
>>>>>>>>> ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
>>>>>>>>> and reset IBT state machine.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

[...]

>>>>>>>>
>>>>>>>
>>>>>>> For what it's worth, I think there is an alternative.  If you all
>>>>>>> (userspace people, etc) can come up with a credible way for a user
>>>>>>> program to statically declare that it doesn't need vsyscalls, then we
>>>>>>> could make SHSTK depend on *that*, and we could avoid this mess.  This
>>>>>>> breaks orthogonality, but it's probably a decent outcome.
>>>>>>>
>>>>>>
>>>>>> Would an arch_prctl(DISABLE_VSYSCALL) work?  The kernel then sets a
>>>>>> thread flag, and in emulate_vsyscall(), checks the flag.
>>>>>>
>>>>>> When CET is enabled, ld-linux will do DISABLE_VSYSCALL.
>>>>>>
>>>>>> How is that?
>>>>>
>>>>> Backwards, no?  Presumably vsyscall needs to be disabled before or
>>>>> concurrently with CET being enabled, not after.
>>>>>
>>>>> I think the solution of making vsyscall emulation work correctly with
>>>>> CET is going to be better and possibly more straightforward.
>>>>>
>>>>
>>>> We can do
>>>>
>>>> 1. Add ARCH_X86_DISABLE_VSYSCALL to disable the vsyscall page.
>>>> 2. If CPU supports CET and the program is CET enabled:
>>>>       a. Disable the vsyscall page.
>>>>       b. Pass control to user.
>>>>       c. Enable the vsyscall page when ARCH_X86_CET_DISABLE is called.
>>>>
>>>> So when control is passed from kernel to user, the vsyscall page is
>>>> disabled if the program
>>>> is CET enabled.
>>>
>>> Let me say this one more time:
>>>
>>> If we have a per-process vsyscall disable control and a per-process
>>> CET control, we are going to keep those settings orthogonal.  I'm
>>> willing to entertain an option in which enabling SHSTK without also
>>> disabling vsyscalls is disallowed, We are *not* going to have any CET
>>> flags magically disable vsyscalls, though, and we are not going to
>>> have a situation where disabling vsyscalls on process startup requires
>>> enabling SHSTK.
>>>
>>> Any possible static vsyscall controls (and CET controls, for that
>>> matter) also need to come with some explanation of whether they are
>>> properties set on the ELF loader, the ELF program being loaded, or
>>> both.  And this explanation needs to cover what happens when old
>>> binaries link against new libc versions and vice versa.  A new
>>> CET-enabled binary linked against old libc running on a new kernel
>>> that is expected to work on a non-CET CPU MUST work on a CET CPU, too.
>>>
>>> Right now, literally the only thing preventing vsyscall emulation from
>>> coexisting with SHSTK is that the implementation eeds work.
>>>
>>> So your proposal is rejected.  Sorry.
>>>
>> I think, even with shadow stack/ibt enabled, we can still allow XONLY
>> without too much mess.
>>
>> What about this?
>>
>> Thanks,
>> Yu-cheng
>>
>> ======
>>
>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
>> b/arch/x86/entry/vsyscall/vsyscall_64.c
>> index 8b0b32ac7791..d39da0a15521 100644
>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>> @@ -48,16 +48,16 @@
>>    static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
>>    #ifdef CONFIG_LEGACY_VSYSCALL_NONE
>>           NONE;
>> -#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
>> +#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY) || defined(CONFIG_X86_CET)
>>           XONLY;
>> -#else
>> +#else
>>           EMULATE;
>>    #endif
> 
> I don't get it.
> 
> First, you can't do any of this based on config -- it must be runtime.
> 
> Second, and more importantly, I don't see how XONLY helps at all.  The
> (non-executable) text that's exposed to user code in EMULATE mode is
> trivial to get right with CET -- your code already handles it.  It's
> the emulation code (that runs identically in EMULATE and XONLY mode)
> that's tricky.
> 

Hi,

There has been some ambiguity in my previous proposals.  To make things 
clear, I created a patch for arch_prctl(VSYSCALL_CTL), which controls 
the TIF_VSYSCALL_DISABLE flag.  It is entirely orthogonal to shadow 
stack or IBT.  On top of the patch, we can do SET_PERSONALITY2() to 
disable vsyscall, e.g.

======
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0e1be2a13359..c730ff00bc62 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -394,6 +394,19 @@ struct arch_elf_state {
  	.gnu_property = 0,	\
  }

+#define SET_PERSONALITY2(ex, state)				\
+do {								\
+	unsigned int has_cet;					\
+								\
+	has_cet = GNU_PROPERTY_X86_FEATURE_1_SHSTK |		\
+		  GNU_PROPERTY_X86_FEATURE_1_IBT;		\
+								\
+	if ((state)->gnu_property & has_cet)			\
+		set_thread_flag(TIF_VSYSCALL_DISABLE);		\
+								\
+	SET_PERSONALITY(ex);					\
+} while (0)
+
  #define arch_elf_pt_proc(ehdr, phdr, elf, interp, state) (0)
  #define arch_check_elf(ehdr, interp, interp_ehdr, state) (0)
  #endif

======
The is the patch.

 From a124b81086122495d6837f26df99db619cd5402a Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Mon, 5 Oct 2020 12:10:26 -0700
Subject: [PATCH 34/45] x86/vsyscall/64: Introduce arch_prctl(VSYCALL_CTL)

Vsyscall emulation provides compatibility to older applications.  Newer
applications use the vDSO interface and do not use vsyscalls, and it is
desirable to have a per-task control of vsyscall.

One use case of the interface is when shadow stack and/or indirect branch
tracking is enabled and vsyscall emulation needs to cancel out the control-
flow protection.  The cancelling code, if implemented, could become a back
door for evading the protection.  Disabling vsyscall eliminates the risk.

Introduce arch_prctl(VSYSCALL_CTL), which sets/clears TIF_VSYSCALL_DISABLE
flag.  When the flag is set, vsyscall is disabled.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
  arch/x86/entry/vsyscall/vsyscall_64.c   |  3 +++
  arch/x86/include/asm/thread_info.h      |  2 ++
  arch/x86/include/uapi/asm/prctl.h       |  1 +
  arch/x86/kernel/process_64.c            | 17 +++++++++++++++++
  tools/arch/x86/include/uapi/asm/prctl.h |  1 +
  5 files changed, 24 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c 
b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..fe8f3db6d21b 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -127,6 +127,9 @@ bool emulate_vsyscall(unsigned long error_code,
  	long ret;
  	unsigned long orig_dx;

+	if (test_thread_flag(TIF_VSYSCALL_DISABLE))
+		return false;
+
  	/* Write faults or kernel-privilege faults never get fixed up. */
  	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
  		return false;
diff --git a/arch/x86/include/asm/thread_info.h 
b/arch/x86/include/asm/thread_info.h
index 267701ae3d86..c0cce3401c0f 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -98,6 +98,7 @@ struct thread_info {
  #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
  #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
  #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_VSYSCALL_DISABLE	26	/* set when vsyscall is disallowed */
  #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
  #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
  #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -127,6 +128,7 @@ struct thread_info {
  #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
  #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
  #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
+#define _TIF_VSYSCALL_DISABLE	(1 << TIF_VSYSCALL_DISABLE)
  #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
  #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
  #define _TIF_ADDR32		(1 << TIF_ADDR32)
diff --git a/arch/x86/include/uapi/asm/prctl.h 
b/arch/x86/include/uapi/asm/prctl.h
index 9245bf629120..223fa382a81e 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -13,6 +13,7 @@
  #define ARCH_MAP_VDSO_X32	0x2001
  #define ARCH_MAP_VDSO_32	0x2002
  #define ARCH_MAP_VDSO_64	0x2003
+#define ARCH_VSYSCALL_CTRL	0x2004

  #define ARCH_X86_CET_STATUS		0x3001
  #define ARCH_X86_CET_DISABLE		0x3002
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1147a1052a07..eba61791c9cf 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -719,6 +719,20 @@ static long prctl_map_vdso(const struct vdso_image 
*image, unsigned long addr)
  }
  #endif

+static long prctl_vsyscall_ctrl(unsigned int disable)
+{
+	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION)) {
+		if (disable)
+			set_thread_flag(TIF_VSYSCALL_DISABLE);
+		else
+			clear_thread_flag(TIF_VSYSCALL_DISABLE);
+
+		return 0;
+	} else {
+		return disable ? 0 : -EINVAL;
+	}
+}
+
  long do_arch_prctl_64(struct task_struct *task, int option, unsigned 
long arg2)
  {
  	int ret = 0;
@@ -807,6 +821,9 @@ long do_arch_prctl_64(struct task_struct *task, int 
option, unsigned long arg2)
  		return prctl_map_vdso(&vdso_image_64, arg2);
  #endif

+	case ARCH_VSYSCALL_CTRL:
+		return prctl_vsyscall_ctrl(arg2);
+
  	default:
  		ret = -EINVAL;
  		break;
diff --git a/tools/arch/x86/include/uapi/asm/prctl.h 
b/tools/arch/x86/include/uapi/asm/prctl.h
index 9245bf629120..2476f46fa51f 100644
--- a/tools/arch/x86/include/uapi/asm/prctl.h
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -13,6 +13,7 @@
  #define ARCH_MAP_VDSO_X32	0x2001
  #define ARCH_MAP_VDSO_32	0x2002
  #define ARCH_MAP_VDSO_64	0x2003
+#define ARCH_VSYSCALL_CTL	0x2004

  #define ARCH_X86_CET_STATUS		0x3001
  #define ARCH_X86_CET_DISABLE		0x3002
-- 
2.21.0


