Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65775375D0E
	for <lists+linux-arch@lfdr.de>; Fri,  7 May 2021 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhEFWGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 18:06:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:25401 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhEFWGT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 May 2021 18:06:19 -0400
IronPort-SDR: aVvx8E7eLZcNY2kpyYVI9cjFAH3s1B8suKPVmc8z36twu9Sru51jqtCPpJH8q0ulLsXDPWk8Vn
 lo0AZI0zHw7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198233911"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="198233911"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:05:18 -0700
IronPort-SDR: E3B3lZ5t9BIU7x8JT3XoIkdfTP2uDRLb1wtuJN38MAl21fRXDH3sv+Vcf7oDpbQ+XVVkx4ab22
 JaNUBAXX/BSw==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="434596777"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.158.199]) ([10.251.158.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:05:16 -0700
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
 <8fd86049-930d-c9b7-379c-56c02a12cd77@intel.com>
 <CALCETrX9z-73wpy-SCy8NE1XfQgXAN0mCmjv0jXDDomMyS7TKg@mail.gmail.com>
 <a7c332c8-9368-40b1-e221-ec921f7db948@intel.com>
 <5fc5dea4-0705-2aad-cf8f-7ff78a5e518a@intel.com>
Message-ID: <bf16ab7e-bf27-68eb-efc9-c0468fb1c651@intel.com>
Date:   Thu, 6 May 2021 15:05:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5fc5dea4-0705-2aad-cf8f-7ff78a5e518a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/4/2021 1:49 PM, Yu, Yu-cheng wrote:
> On 4/30/2021 11:32 AM, Yu, Yu-cheng wrote:
>> On 4/30/2021 10:47 AM, Andy Lutomirski wrote:
>>> On Fri, Apr 30, 2021 at 10:00 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> 
>>> wrote:
>>>>
>>>> On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
>>>>> On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> 
>>>>> wrote:
>>>>>>
>>>>>> When shadow stack is enabled, a task's shadow stack states must be 
>>>>>> saved
>>>>>> along with the signal context and later restored in sigreturn. 
>>>>>> However,
>>>>>> currently there is no systematic facility for extending a signal 
>>>>>> context.
>>>>>> There is some space left in the ucontext, but changing ucontext is 
>>>>>> likely
>>>>>> to create compatibility issues and there is not enough space for 
>>>>>> further
>>>>>> extensions.
>>>>>>
>>>>>> Introduce a signal context extension struct 'sc_ext', which is 
>>>>>> used to save
>>>>>> shadow stack restore token address.  The extension is located 
>>>>>> above the fpu
>>>>>> states, plus alignment.  The struct can be extended (such as the 
>>>>>> ibt's
>>>>>> wait_endbr status to be introduced later), and sc_ext.total_size 
>>>>>> field
>>>>>> keeps track of total size.
>>>>>
>>>>> I still don't like this.
>>>>>

[...]

>>>>>
>>>>> That's where we are right now upstream.  The kernel has a parser for
>>>>> the FPU state that is bugs piled upon bugs and is going to have to be
>>>>> rewritten sometime soon.  On top of all this, we have two upcoming
>>>>> features, both of which require different kinds of extensions:
>>>>>
>>>>> 1. AVX-512.  (Yeah, you thought this story was over a few years ago,
>>>>> but no.  And AMX makes it worse.)  To make a long story short, we
>>>>> promised user code many years ago that a signal frame fit in 2048
>>>>> bytes with some room to spare.  With AVX-512 this is false.  With AMX
>>>>> it's so wrong it's not even funny.  The only way out of the mess
>>>>> anyone has come up with involves making the length of the FPU state
>>>>> vary depending on which features are INIT, i.e. making it more compact
>>>>> than "compact" mode is.  This has a side effect: it's no longer
>>>>> possible to modify the state in place, because enabling a feature with
>>>>> no space allocated will make the structure bigger, and the stack won't
>>>>> have room.  Fortunately, one can relocate the entire FPU state, update
>>>>> the pointer in mcontext, and the kernel will happily follow the
>>>>> pointer.  So new code on a new kernel using a super-compact state
>>>>> could expand the state by allocating new memory (on the heap? very
>>>>> awkwardly on the stack?) and changing the pointer.  For all we know,
>>>>> some code already fiddles with the pointer.  This is great, except
>>>>> that your patch sticks more data at the end of the FPU block that no
>>>>> one is expecting, and your sigreturn code follows that pointer, and
>>>>> will read off into lala land.
>>>>>
>>>>
>>>> Then, what about we don't do that at all.  Is it possible from now 
>>>> on we
>>>> don't stick more data at the end, and take the relocating-fpu approach?
>>>>
>>>>> 2. CET.  CET wants us to find a few more bytes somewhere, and those
>>>>> bytes logically belong in ucontext, and here we are.
>>>>>
>>>>
>>>> Fortunately, we can spare CET the need of ucontext extension.  When the
>>>> kernel handles sigreturn, the user-mode shadow stack pointer is 
>>>> right at
>>>> the restore token.  There is no need to put that in ucontext.
>>>
>>> That seems entirely reasonable.  This might also avoid needing to
>>> teach CRIU about CET at all.
>>>
>>>>
>>>> However, the WAIT_ENDBR status needs to be saved/restored for signals.
>>>> Since IBT is now dependent on shadow stack, we can use a spare bit of
>>>> the shadow stack restore token for that.
>>>
>>> That seems like unnecessary ABI coupling.  We have plenty of bits in
>>> uc_flags, and we have an entire reserved word in sigcontext.  How
>>> about just sticking this bit in one of those places?
>>
>> Yes, I will make it UC_WAIT_ENDBR.
> 
> Personally, I think an explicit flag is cleaner than using a reserved 
> word somewhere.  However, there is a small issue: ia32 has no uc_flags.
> 
> This series can support legacy apps up to now.  But, instead of creating 
> too many special cases, perhaps we should drop CET support of ia32?
> 
> Thoughts?
> 

Once we have UC_WAIT_ENDBR, IBT signal handling becomes quite simple. 
Like the following:

diff --git a/arch/x86/include/uapi/asm/ucontext.h 
b/arch/x86/include/uapi/asm/ucontext.h
index 5657b7a49f03..96375d609e11 100644
--- a/arch/x86/include/uapi/asm/ucontext.h
+++ b/arch/x86/include/uapi/asm/ucontext.h
@@ -49,6 +49,11 @@
   */
  #define UC_SIGCONTEXT_SS	0x2
  #define UC_STRICT_RESTORE_SS	0x4
+
+/*
+ * UC_WAIT_ENDBR indicates the task is in wait-ENDBR status.
+ */
+#define UC_WAIT_ENDBR		0x08
  #endif

  #include <asm-generic/ucontext.h>
diff --git a/arch/x86/kernel/ibt.c b/arch/x86/kernel/ibt.c
index d2563dd4759f..da804314ddc4 100644
--- a/arch/x86/kernel/ibt.c
+++ b/arch/x86/kernel/ibt.c
@@ -66,3 +66,32 @@ void ibt_disable(void)
  	ibt_set_clear_msr_bits(0, CET_ENDBR_EN);
  	current->thread.cet.ibt = 0;
  }
+
+int ibt_get_clear_wait_endbr(void)
+{
+	u64 msr_val = 0;
+
+	if (!current->thread.cet.ibt)
+		return 0;
+
+	fpregs_lock();
+
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+
+	if (!rdmsrl_safe(MSR_IA32_U_CET, &msr_val))
+		wrmsrl(MSR_IA32_U_CET, msr_val & ~CET_WAIT_ENDBR);
+
+	fpregs_unlock();
+
+	return msr_val & CET_WAIT_ENDBR;
+}
+
+int ibt_set_wait_endbr(void)
+{
+	if (!current->thread.cet.ibt)
+		return 0;
+
+
+	return ibt_set_clear_msr_bits(CET_WAIT_ENDBR, 0);
+}
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 66b662e57e19..5afd15419006 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -46,6 +46,7 @@
  #include <asm/syscall.h>
  #include <asm/sigframe.h>
  #include <asm/signal.h>
+#include <asm/cet.h>

  #ifdef CONFIG_X86_64
  /*
@@ -134,6 +135,9 @@ static int restore_sigcontext(struct pt_regs *regs,
  	 */
  	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && 
user_64bit_mode(regs)))
  		force_valid_ss(regs);
+
+	if (uc_flags & UC_WAIT_ENDBR)
+		ibt_set_wait_endbr();
  #endif

  	return fpu__restore_sig((void __user *)sc.fpstate,
@@ -433,6 +437,9 @@ static unsigned long frame_uc_flags(struct pt_regs 
*regs)
  	if (likely(user_64bit_mode(regs)))
  		flags |= UC_STRICT_RESTORE_SS;

+	if (ibt_get_clear_wait_endbr())
+		flags |= UC_WAIT_ENDBR;
+
  	return flags;
  }


However, this cannot handle ia32 with no SA_SIGINFO.  For that, can we 
create a synthetic token on the shadow stack?

- The token points to itself with reserved bit[1] set, and cannot be 
used for RSTORSSP.
- The token only exists for ia32 with no SA_SIGINFO *AND* when the task 
is in wait-endbr.

The signal shadow stack will look like this:

--> ssp before signal
     synthetic IBT token (for ia32 no SA_SIGINFO)
     shadow stack restore token
     sigreturn address

The synthetic token is not valid in other situations.
How is that?

Thanks,
Yu-cheng
