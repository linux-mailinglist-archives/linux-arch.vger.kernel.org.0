Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E915F39C7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJCXWc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJCXWZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:22:25 -0400
X-Greylist: delayed 723 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 16:22:23 PDT
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A261C42E;
        Mon,  3 Oct 2022 16:22:23 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 293N9Fbk3151198
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 3 Oct 2022 16:09:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 293N9Fbk3151198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1664838557;
        bh=xJZ6nhVm/uE8olKGBqYb8kGcNYZAUZBCq+szEAts8vs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=YDCWBOXA9dtO9GXhncKtVNe41sHgCGquhdh/jFCCdsUuYC7CPmt/x8BD78j+TZcWF
         vPb7yTkdH0GMIhvByh58AHAqpck5YinqAs4OBs2jmCH8VsxfXz78OqJvuvhxX5QQtJ
         NX6fNW0lfuwEISIHIhQ/Z0XquLZe4tG3cGPRlMVsyuHvrlAGD9I9iQmewd+Jgq1Lrm
         f1qAzmqshvoXI/KNYSIO02vFacZx1hxk8iEcDgdm9PgAg30eSnsIR1rqUHbX3PQ8XX
         W733g7fu59ey3VkOGbs8Lfb1VilDFxhr+hmDoY6IBNWiZ74uzYwp78lXHtm0ogZrmx
         GCfwjWud/boUg==
Date:   Mon, 03 Oct 2022 16:09:14 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_07/39=5D_x86/cet=3A_Add_u?= =?US-ASCII?Q?ser_control-protection_fault_handler?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4e145653-a62c-e4ea-dfa7-f18c0282c315@kernel.org>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com> <20220929222936.14584-8-rick.p.edgecombe@intel.com> <4e145653-a62c-e4ea-dfa7-f18c0282c315@kernel.org>
Message-ID: <B17B3140-1C8F-4470-80D3-877EF0FD7113@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On October 3, 2022 3:51:59 PM PDT, Andy Lutomirski <luto@kernel=2Eorg> wrot=
e:
>On 9/29/22 15:29, Rick Edgecombe wrote:
>> From: Yu-cheng Yu <yu-cheng=2Eyu@intel=2Ecom>
>>=20
>
>> +static void do_user_control_protection_fault(struct pt_regs *regs,
>> +					     unsigned long error_code)
>>   {
>> -	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
>> -		pr_err("Unexpected #CP\n");
>> -		BUG();
>> +	struct task_struct *tsk;
>> +	unsigned long ssp;
>> +
>> +	/* Read SSP before enabling interrupts=2E */
>> +	rdmsrl(MSR_IA32_PL3_SSP, ssp); > +
>> +	cond_local_irq_enable(regs);
>
>I feel like I'm missing something=2E  Either PL3_SSL is context switched =
correctly and reading it with IRQs off is useless, or it's not context swit=
ched, and I'm very confused=2E
>
>Please either improve the comment or move it after the cond_local_irq_ena=
ble()=2E
>
>--Andy
>
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
>> +		WARN_ONCE(1, "User-mode control protection fault with shadow support=
 disabled\n");
>> +
>> +	tsk =3D current;
>> +	tsk->thread=2Eerror_code =3D error_code;
>> +	tsk->thread=2Etrap_nr =3D X86_TRAP_CP;
>> +
>> +	/* Ratelimit to prevent log spamming=2E */
>> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
>> +	    __ratelimit(&cpf_rate)) {
>> +		unsigned int cpec;
>> +
>> +		cpec =3D error_code & CP_EC;
>> +		if (cpec >=3D ARRAY_SIZE(control_protection_err))
>> +			cpec =3D 0;
>> +
>> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(=
%s)%s",
>> +			 tsk->comm, task_pid_nr(tsk),
>> +			 regs->ip, regs->sp, ssp, error_code,
>> +			 control_protection_err[cpec],
>> +			 error_code & CP_ENCL ? " in enclave" : "");
>> +		print_vma_addr(KERN_CONT " in ", regs->ip);
>> +		pr_cont("\n");
>>   	}
>>   -	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) !=3D CP_EN=
DBR))
>> -		return;
>> +	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
>> +	cond_local_irq_disable(regs);
>> +}
>> +#else
>> +static void do_user_control_protection_fault(struct pt_regs *regs,
>> +					     unsigned long error_code)
>> +{
>> +	WARN_ONCE(1, "User-mode control protection fault with shadow support =
disabled\n");
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_X86_KERNEL_IBT
>> +
>> +static __ro_after_init bool ibt_fatal =3D true;
>> +
>> +extern void ibt_selftest_ip(void); /* code label defined in asm below =
*/
>>   +static void do_kernel_control_protection_fault(struct pt_regs *regs)
>> +{
>>   	if (unlikely(regs->ip =3D=3D (unsigned long)&ibt_selftest_ip)) {
>>   		regs->ax =3D 0;
>>   		return;
>> @@ -283,9 +335,29 @@ static int __init ibt_setup(char *str)
>>   }
>>     __setup("ibt=3D", ibt_setup);
>> -
>> +#else
>> +static void do_kernel_control_protection_fault(struct pt_regs *regs)
>> +{
>> +	WARN_ONCE(1, "Kernel-mode control protection fault with IBT disabled\=
n");
>> +}
>>   #endif /* CONFIG_X86_KERNEL_IBT */
>>   +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STAC=
K)
>> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>> +{
>> +	if (!cpu_feature_enabled(X86_FEATURE_IBT) &&
>> +	    !cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pr_err("Unexpected #CP\n");
>> +		BUG();
>> +	}
>> +
>> +	if (user_mode(regs))
>> +		do_user_control_protection_fault(regs, error_code);
>> +	else
>> +		do_kernel_control_protection_fault(regs);
>> +}
>> +#endif /* defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_=
STACK) */
>> +
>>   #ifdef CONFIG_X86_F00F_BUG
>>   void handle_invalid_op(struct pt_regs *regs)
>>   #else
>> diff --git a/arch/x86/xen/enlighten_pv=2Ec b/arch/x86/xen/enlighten_pv=
=2Ec
>> index 0ed2e487a693=2E=2E57faa287163f 100644
>> --- a/arch/x86/xen/enlighten_pv=2Ec
>> +++ b/arch/x86/xen/enlighten_pv=2Ec
>> @@ -628,7 +628,7 @@ static struct trap_array_entry trap_array[] =3D {
>>   	TRAP_ENTRY(exc_coprocessor_error,		false ),
>>   	TRAP_ENTRY(exc_alignment_check,			false ),
>>   	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
>> -#ifdef CONFIG_X86_KERNEL_IBT
>> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
>>   	TRAP_ENTRY(exc_control_protection,		false ),
>>   #endif
>>   };
>> diff --git a/arch/x86/xen/xen-asm=2ES b/arch/x86/xen/xen-asm=2ES
>> index 6b4fdf6b9542=2E=2Ee45ff6300c7d 100644
>> --- a/arch/x86/xen/xen-asm=2ES
>> +++ b/arch/x86/xen/xen-asm=2ES
>> @@ -148,7 +148,7 @@ xen_pv_trap asm_exc_page_fault
>>   xen_pv_trap asm_exc_spurious_interrupt_bug
>>   xen_pv_trap asm_exc_coprocessor_error
>>   xen_pv_trap asm_exc_alignment_check
>> -#ifdef CONFIG_X86_KERNEL_IBT
>> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
>>   xen_pv_trap asm_exc_control_protection
>>   #endif
>>   #ifdef CONFIG_X86_MCE
>> diff --git a/include/uapi/asm-generic/siginfo=2Eh b/include/uapi/asm-ge=
neric/siginfo=2Eh
>> index ffbe4cec9f32=2E=2E0f52d0ac47c5 100644
>> --- a/include/uapi/asm-generic/siginfo=2Eh
>> +++ b/include/uapi/asm-generic/siginfo=2Eh
>> @@ -242,7 +242,8 @@ typedef struct siginfo {
>>   #define SEGV_ADIPERR	7	/* Precise MCD exception */
>>   #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>>   #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
>> -#define NSIGSEGV	9
>> +#define SEGV_CPERR	10	/* Control protection fault */
>> +#define NSIGSEGV	10
>>     /*
>>    * SIGBUS si_codes
>

Could something change the value under a switched-out thread, though?
