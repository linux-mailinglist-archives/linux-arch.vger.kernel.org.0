Return-Path: <linux-arch+bounces-13702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F365FB8BCC4
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 03:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2227C46FA
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 01:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1718DB02;
	Sat, 20 Sep 2025 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HtoOOYq7"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93D262A6;
	Sat, 20 Sep 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332559; cv=none; b=oELHOABzMutngcMF3XkYonH4Uba3u6FUcDZPuNFbBB2y0M8AY2RY2zAG2OKjpTExUmxrx9VGzlQugRaWyonCQbiOuaOiLXJg+41zNoGKhSd2KlWU4n3I/SpaklVxz5fNAg28w4eaExb0uDF7Od/pC1L45l9XnJ+NFE4rvgzsUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332559; c=relaxed/simple;
	bh=YqJUo1uJhup7SB/w6z/0/vmgUnc11nXFoXHzIlDI4CM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bcc0gZaxoaQHcBjqoSV6jKnjMyop5m9UYdzjq+A/NT2kJ+tjaT6lLhxtsO5R5xo39NJ6NffF+LASSymTWa/u4Y0thPq0Efbkrgti0x072htYLML7nIZydWyW9JUIUYPLsaGMp2rWVbGk1c6ZEyNwfHLLeFR6z0EiwZQeFwvxk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HtoOOYq7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 906A72114240;
	Fri, 19 Sep 2025 18:42:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 906A72114240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758332554;
	bh=mEPnASWOsEI7Z481b2oWAaZiOh6uMb0iDO3qffEe5FA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HtoOOYq7bNMSxRXhHlbu8Z3ep4i5tfr3XR3ZbSNI+nImme8u7EELRIn3YoDgNm0kt
	 cuBgxsZF7V2Ao6TZyHPmA84G0X8lC/TZHuZC/nd1B0NWyE5l7DNjED8fZZy+AMxVbK
	 ksWH4iHWR+SjvZeB4hof2THSJ4hfDj2zgxQIULTQ=
Message-ID: <eb755e6d-3adf-ee3b-2942-666bc1bedef5@linux.microsoft.com>
Date: Fri, 19 Sep 2025 18:42:33 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Content-Language: en-US
From: Mukesh R <mrathor@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <SN6PR02MB4157CD8153650CC9D379A03DD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cab5ec-ab76-b1cf-4891-30314e5dace6@linux.microsoft.com>
 <SN6PR02MB4157AFD23F088FC243A24C17D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <58e4f6b3-6ae3-4bf4-3e1f-0981d6af91ea@linux.microsoft.com>
In-Reply-To: <58e4f6b3-6ae3-4bf4-3e1f-0981d6af91ea@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 19:32, Mukesh R wrote:
> On 9/18/25 16:53, Michael Kelley wrote:
>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 16, 2025 6:13 PM
>>>
>>> On 9/15/25 10:55, Michael Kelley wrote:
>>>> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
>>>>>
>>>>> Introduce a new file to implement collection of hypervisor ram into the
>>>>
>>>> s/ram/RAM/ (multiple places)
>>>
>>> a quick grep indicates using saying ram is common, i like ram over RAM
>>>
>>>>> vmcore collected by linux. By default, the hypervisor ram is locked, ie,
>>>>> protected via hw page table. Hyper-V implements a disable hypercall which
>>>>
>>>> The terminology here is a bit confusing since you have two names for
>>>> the same thing: "disable" hypervisor, and "devirtualize". Is it possible to
>>>> just use "devirtualize" everywhere, and drop the "disable" terminology?
>>>
>>> The concept is devirtualize and the actual hypercall was originally named
>>> disable. so intermixing is natural imo.
>>>
>>>>> essentially devirtualizes the system on the fly. This mechanism makes the
>>>>> hypervisor ram accessible to linux. Because the hypervisor ram is already
>>>>> mapped into linux address space (as reserved ram),
>>>>
>>>> Is the hypervisor RAM mapped into the VMM process user address space,
>>>> or somewhere in the kernel address space? If the latter, where in the kernel
>>>> code, or what mechanism, does that? Just curious, as I wasn't aware that
>>>> this is happening ....
>>>
>>> mapped in kernel as normal ram and we reserve it very early in boot. i
>>> see that patch has not made it here yet, should be coming very soon.
>>
>> OK, that's fine. The answer to my question is coming soon ....
>>
>>>
>>>>> it is automatically
>>>>> collected into the vmcore without extra work. More details of the
>>>>> implementation are available in the file prologue.
>>>>>
>>>>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>>> ---
>>>>>  arch/x86/hyperv/hv_crash.c | 622 +++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 622 insertions(+)
>>>>>  create mode 100644 arch/x86/hyperv/hv_crash.c
>>>>>
>>>>> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
>>>>> new file mode 100644
>>>>> index 000000000000..531bac79d598
>>>>> --- /dev/null
>>>>> +++ b/arch/x86/hyperv/hv_crash.c
>>>>> @@ -0,0 +1,622 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * X86 specific Hyper-V kdump/crash support module
>>>>> + *
>>>>> + * Copyright (C) 2025, Microsoft, Inc.
>>>>> + *
>>>>> + * This module implements hypervisor ram collection into vmcore for both
>>>>> + * cases of the hypervisor crash and linux dom0/root crash.
>>>>
>>>> For a hypervisor crash, does any of this apply to general guest VMs? I'm
>>>> thinking it does not. Hypervisor RAM is collected only into the vmcore
>>>> for the root partition, right? Maybe some additional clarification could be
>>>> added so there's no confusion in this regard.
>>>
>>> it would be odd for guests to collect hyp core, and target audience is
>>> assumed to be those who are somewhat familiar with basic concepts before
>>> getting here.
>>
>> I was unsure because I had not seen any code that adds the hypervisor memory
>> to the Linux memory map. Thought maybe something was going on I hadn?t
>> heard about, so I didn't know the scope of it.
>>
>> Of course, I'm one of those people who was *not* familiar with the basic concepts
>> before getting here. And given that there's no spec available from Hyper-V,
>> the comments in this patch set are all there is for anyone outside of Microsoft.
>> In that vein, I think it's reasonable to provide some description of how this
>> all works in the code comments. And you've done that, which is very
>> helpful. But I encountered a few places where I was confused or unclear, and
>> my suggestions here and in Patch 4 are just about making things as precise as
>> possible without adding a huge amount of additional verbiage. For someone
>> new, English text descriptions that the code can be checked against are
>> helpful, and drawing hard boundaries ("this is only applicable to the root
>> partition") is helpful.
>>
>> If you don't want to deal with it now, I could provide a follow-on patch later
>> that tweaks or augments the wording a bit to clarify some of these places. 
>> You can review, like with any patch. I've done wording work over the years
>> to many places in the VMBus code, and more broadly in providing most of
>> the documentation in Documentation/virt/hyperv.
> 
> with time, things will start making sense... i find comment pretty clear
> that it collects core for both cases of hv crash and dom0 crash, and no
> mention of guest implies has nothing to do with guests. 
> 
>>>
>>>> And what *does* happen to guest VMs after a hypervisor crash?
>>>
>>> they are gone... what else could we do?
>>>
>>>>> + * Hyper-V implements
>>>>> + * a devirtualization hypercall with a 32bit protected mode ABI callback. This
>>>>> + * mechanism must be used to unlock hypervisor ram. Since the hypervisor ram
>>>>> + * is already mapped in linux, it is automatically collected into linux vmcore,
>>>>> + * and can be examined by the crash command (raw ram dump) or windbg.
>>>>> + *
>>>>> + * At a high level:
>>>>> + *
>>>>> + *  Hypervisor Crash:
>>>>> + *    Upon crash, hypervisor goes into an emergency minimal dispatch loop, a
>>>>> + *    restrictive mode with very limited hypercall and msr support.
>>>>
>>>> s/msr/MSR/
>>>
>>> msr is used all over, seems acceptable.
>>>
>>>>> + *    Each cpu then injects NMIs into dom0/root vcpus.
>>>>
>>>> The "Each cpu" part of this sentence is confusing to me -- which CPUs does
>>>> this refer to? Maybe it would be better to say "It then injects an NMI into
>>>> each dom0/root partition vCPU." without being specific as to which CPUs do
>>>> the injecting since that seems more like a hypervisor implementation detail
>>>> that's not relevant here.
>>>
>>> all cpus in the system. there is a dedicated/pinned dom0 vcpu for each cpu.
>>
>> OK, that makes sense now that I think about it. Each physical CPU in the host
>> has a corresponding vCPU in the dom0/root partition. And each of the vCPUs
>> gets an NMI that sends it to the Linux-in-dom0 NMI handler, even if it was off
>> running a vCPU in some guest VM.
>>
>>>
>>>>> + *    A shared page is used to check
>>>>> + *    by linux in the nmi handler if the hypervisor has crashed. This shared
>>>>
>>>> s/nmi/NMI/  (multiple places)
>>>
>>>>> + *    page is setup in hv_root_crash_init during boot.
>>>>> + *
>>>>> + *  Linux Crash:
>>>>> + *    In case of linux crash, the callback hv_crash_stop_other_cpus will send
>>>>> + *    NMIs to all cpus, then proceed to the crash_nmi_callback where it waits
>>>>> + *    for all cpus to be in NMI.
>>>>> + *
>>>>> + *  NMI Handler (upon quorum):
>>>>> + *    Eventually, in both cases, all cpus wil end up in the nmi hanlder.
>>>>
>>>> s/hanlder/handler/
>>>>
>>>> And maybe just drop the word "wil" (which is misspelled).
>>>>
>>>>> + *    Hyper-V requires the disable hypervisor must be done from the bsp. So
>>>>
>>>> s/bsp/BSP  (multiple places)
>>>>
>>>>> + *    the bsp nmi handler saves current context, does some fixups and makes
>>>>> + *    the hypercall to disable the hypervisor, ie, devirtualize. Hypervisor
>>>>> + *    at that point will suspend all vcpus (except the bsp), unlock all its
>>>>> + *    ram, and return to linux at the 32bit mode entry RIP.
>>>>> + *
>>>>> + *  Linux 32bit entry trampoline will then restore long mode and call C
>>>>> + *  function here to restore context and continue execution to crash kexec.
>>>>> + */
>>>>> +
>>>>> +#include <linux/delay.h>
>>>>> +#include <linux/kexec.h>
>>>>> +#include <linux/crash_dump.h>
>>>>> +#include <linux/panic.h>
>>>>> +#include <asm/apic.h>
>>>>> +#include <asm/desc.h>
>>>>> +#include <asm/page.h>
>>>>> +#include <asm/pgalloc.h>
>>>>> +#include <asm/mshyperv.h>
>>>>> +#include <asm/nmi.h>
>>>>> +#include <asm/idtentry.h>
>>>>> +#include <asm/reboot.h>
>>>>> +#include <asm/intel_pt.h>
>>>>> +
>>>>> +int hv_crash_enabled;
>>>>
>>>> Seems like this is conceptually a "bool", not an "int".
>>>
>>> yeah, can change it to bool if i do another iteration.
>>>
>>>>> +EXPORT_SYMBOL_GPL(hv_crash_enabled);
>>>>> +
>>>>> +struct hv_crash_ctxt {
>>>>> +	ulong rsp;
>>>>> +	ulong cr0;
>>>>> +	ulong cr2;
>>>>> +	ulong cr4;
>>>>> +	ulong cr8;
>>>>> +
>>>>> +	u16 cs;
>>>>> +	u16 ss;
>>>>> +	u16 ds;
>>>>> +	u16 es;
>>>>> +	u16 fs;
>>>>> +	u16 gs;
>>>>> +
>>>>> +	u16 gdt_fill;
>>>>> +	struct desc_ptr gdtr;
>>>>> +	char idt_fill[6];
>>>>> +	struct desc_ptr idtr;
>>>>> +
>>>>> +	u64 gsbase;
>>>>> +	u64 efer;
>>>>> +	u64 pat;
>>>>> +};
>>>>> +static struct hv_crash_ctxt hv_crash_ctxt;
>>>>> +
>>>>> +/* Shared hypervisor page that contains crash dump area we peek into.
>>>>> + * NB: windbg looks for "hv_cda" symbol so don't change it.
>>>>> + */
>>>>> +static struct hv_crashdump_area *hv_cda;
>>>>> +
>>>>> +static u32 trampoline_pa, devirt_cr3arg;
>>>>> +static atomic_t crash_cpus_wait;
>>>>> +static void *hv_crash_ptpgs[4];
>>>>> +static int hv_has_crashed, lx_has_crashed;
>>>>
>>>> These are conceptually "bool" as well.
>>>>
>>>>> +
>>>>> +/* This cannot be inlined as it needs stack */
>>>>> +static noinline __noclone void hv_crash_restore_tss(void)
>>>>> +{
>>>>> +	load_TR_desc();
>>>>> +}
>>>>> +
>>>>> +/* This cannot be inlined as it needs stack */
>>>>> +static noinline void hv_crash_clear_kernpt(void)
>>>>> +{
>>>>> +	pgd_t *pgd;
>>>>> +	p4d_t *p4d;
>>>>> +
>>>>> +	/* Clear entry so it's not confusing to someone looking at the core */
>>>>> +	pgd = pgd_offset_k(trampoline_pa);
>>>>> +	p4d = p4d_offset(pgd, trampoline_pa);
>>>>> +	native_p4d_clear(p4d);
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * This is the C entry point from the asm glue code after the devirt hypercall.
>>>>> + * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
>>>>> + * page tables with our below 4G page identity mapped, but using a temporary
>>>>> + * GDT. ds/fs/gs/es are null. ss is not usable. bp is null. stack is not
>>>>> + * available. We restore kernel GDT, and rest of the context, and continue
>>>>> + * to kexec.
>>>>> + */
>>>>> +static asmlinkage void __noreturn hv_crash_c_entry(void)
>>>>> +{
>>>>> +	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
>>>>> +
>>>>> +	/* first thing, restore kernel gdt */
>>>>> +	native_load_gdt(&ctxt->gdtr);
>>>>> +
>>>>> +	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
>>>>> +	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>>>>> +
>>>>> +	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
>>>>> +	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
>>>>> +	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
>>>>> +	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
>>>>> +
>>>>> +	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
>>>>> +	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
>>>>> +
>>>>> +	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
>>>>> +	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
>>>>> +	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
>>>>> +
>>>>> +	native_load_idt(&ctxt->idtr);
>>>>> +	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
>>>>> +	native_wrmsrq(MSR_EFER, ctxt->efer);
>>>>> +
>>>>> +	/* restore the original kernel CS now via far return */
>>>>> +	asm volatile("movzwq %0, %%rax\n\t"
>>>>> +		     "pushq %%rax\n\t"
>>>>> +		     "pushq $1f\n\t"
>>>>> +		     "lretq\n\t"
>>>>> +		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
>>>>> +
>>>>> +	/* We are in asmlinkage without stack frame, hence make a C function
>>>>> +	 * call which will buy stack frame to restore the tss or clear PT entry.
>>>>> +	 */
>>>>> +	hv_crash_restore_tss();
>>>>> +	hv_crash_clear_kernpt();
>>>>> +
>>>>> +	/* we are now fully in devirtualized normal kernel mode */
>>>>> +	__crash_kexec(NULL);
>>>>
>>>> The comments for __crash_kexec() say that "panic_cpu" should be set to
>>>> the current CPU. I don't see that such is the case here.
>>>
>>> if linux panic, it would be set by vpanic, if hyp crash, that is
>>> irrelevant.
>>>
>>>>> +
>>>>> +	for (;;)
>>>>> +		cpu_relax();
>>>>
>>>> Is the intent that __crash_kexec() should never return, on any of the vCPUs,
>>>> because devirtualization isn't done unless there's a valid kdump image loaded?
>>>> I wonder if
>>>>
>>>> 	native_wrmsrq(HV_X64_MSR_RESET, 1);
>>>>
>>>> would be better than looping forever in case __crash_kexec() fails
>>>> somewhere along the way even if there's a kdump image loaded.
>>>
>>> yeah, i've gone thru all 3 possibilities here:
>>>   o loop forever
>>>   o reset
>>>   o BUG() : this was in V0
>>>
>>> reset is just bad because system would just reboot without any indication
>>> if hyp crashes. with loop at least there is a hang, and one could make
>>> note of it, and if internal, attach debugger.
>>>
>>> BUG is best imo because with hyp gone linux will try to redo panic
>>> and we would print something extra to help. I think i'll just go
>>> back to my V0: BUG()
>>>
>>>>> +}
>>>>> +/* Tell gcc we are using lretq long jump in the above function intentionally */
>>>>> +STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
>>>>> +
>>>>> +static void hv_mark_tss_not_busy(void)
>>>>> +{
>>>>> +	struct desc_struct *desc = get_current_gdt_rw();
>>>>> +	tss_desc tss;
>>>>> +
>>>>> +	memcpy(&tss, &desc[GDT_ENTRY_TSS], sizeof(tss_desc));
>>>>> +	tss.type = 0x9;        /* available 64-bit TSS. 0xB is busy TSS */
>>>>> +	write_gdt_entry(desc, GDT_ENTRY_TSS, &tss, DESC_TSS);
>>>>> +}
>>>>> +
>>>>> +/* Save essential context */
>>>>> +static void hv_hvcrash_ctxt_save(void)
>>>>> +{
>>>>> +	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
>>>>> +
>>>>> +	asm volatile("movq %%rsp,%0" : "=m"(ctxt->rsp));
>>>>> +
>>>>> +	ctxt->cr0 = native_read_cr0();
>>>>> +	ctxt->cr4 = native_read_cr4();
>>>>> +
>>>>> +	asm volatile("movq %%cr2, %0" : "=a"(ctxt->cr2));
>>>>> +	asm volatile("movq %%cr8, %0" : "=a"(ctxt->cr8));
>>>>> +
>>>>> +	asm volatile("movl %%cs, %%eax" : "=a"(ctxt->cs));
>>>>> +	asm volatile("movl %%ss, %%eax" : "=a"(ctxt->ss));
>>>>> +	asm volatile("movl %%ds, %%eax" : "=a"(ctxt->ds));
>>>>> +	asm volatile("movl %%es, %%eax" : "=a"(ctxt->es));
>>>>> +	asm volatile("movl %%fs, %%eax" : "=a"(ctxt->fs));
>>>>> +	asm volatile("movl %%gs, %%eax" : "=a"(ctxt->gs));
>>>>> +
>>>>> +	native_store_gdt(&ctxt->gdtr);
>>>>> +	store_idt(&ctxt->idtr);
>>>>> +
>>>>> +	ctxt->gsbase = __rdmsr(MSR_GS_BASE);
>>>>> +	ctxt->efer = __rdmsr(MSR_EFER);
>>>>> +	ctxt->pat = __rdmsr(MSR_IA32_CR_PAT);
>>>>> +}
>>>>> +
>>>>> +/* Add trampoline page to the kernel pagetable for transition to kernel PT */
>>>>> +static void hv_crash_fixup_kernpt(void)
>>>>> +{
>>>>> +	pgd_t *pgd;
>>>>> +	p4d_t *p4d;
>>>>> +
>>>>> +	pgd = pgd_offset_k(trampoline_pa);
>>>>> +	p4d = p4d_offset(pgd, trampoline_pa);
>>>>> +
>>>>> +	/* trampoline_pa is below 4G, so no pre-existing entry to clobber */
>>>>> +	p4d_populate(&init_mm, p4d, (pud_t *)hv_crash_ptpgs[1]);
>>>>> +	p4d->p4d = p4d->p4d & ~(_PAGE_NX);    /* enable execute */
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Now that all cpus are in nmi and spinning, we notify the hyp that linux has
>>>>> + * crashed and will collect core. This will cause the hyp to quiesce and
>>>>> + * suspend all VPs except the bsp. Called if linux crashed and not the hyp.
>>>>> + */
>>>>> +static void hv_notify_prepare_hyp(void)
>>>>> +{
>>>>> +	u64 status;
>>>>> +	struct hv_input_notify_partition_event *input;
>>>>> +	struct hv_partition_event_root_crashdump_input *cda;
>>>>> +
>>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>> +	cda = &input->input.crashdump_input;
>>>>
>>>> The code ordering here is a bit weird. I'd expect this line to be grouped
>>>> with cda->crashdump_action being set.
>>>
>>> we are setting two pointers, and using them later. setting pointers
>>> up front is pretty normal.
>>>
>>>>> +	memset(input, 0, sizeof(*input));
>>>>> +	input->event = HV_PARTITION_EVENT_ROOT_CRASHDUMP;
>>>>> +
>>>>> +	cda->crashdump_action = HV_CRASHDUMP_ENTRY;
>>>>> +	status = hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT, input, NULL);
>>>>> +	if (!hv_result_success(status))
>>>>> +		return;
>>>>> +
>>>>> +	cda->crashdump_action = HV_CRASHDUMP_SUSPEND_ALL_VPS;
>>>>> +	hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT, input, NULL);
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Common function for all cpus before devirtualization.
>>>>> + *
>>>>> + * Hypervisor crash: all cpus get here in nmi context.
>>>>> + * Linux crash: the panicing cpu gets here at base level, all others in nmi
>>>>> + *		context. Note, panicing cpu may not be the bsp.
>>>>> + *
>>>>> + * The function is not inlined so it will show on the stack. It is named so
>>>>> + * because the crash cmd looks for certain well known function names on the
>>>>> + * stack before looking into the cpu saved note in the elf section, and
>>>>> + * that work is currently incomplete.
>>>>> + *
>>>>> + * Notes:
>>>>> + *  Hypervisor crash:
>>>>> + *    - the hypervisor is in a very restrictive mode at this point and any
>>>>> + *	vmexit it cannot handle would result in reboot. For example, console
>>>>> + *	output from here would result in synic ipi hcall, which would result
>>>>> + *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as possible.
>>>>> + *
>>>>> + *  Devirtualization is supported from the bsp only.
>>>>> + */
>>>>> +static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
>>>>> +{
>>>>> +	struct hv_input_disable_hyp_ex *input;
>>>>> +	u64 status;
>>>>> +	int msecs = 1000, ccpu = smp_processor_id();
>>>>> +
>>>>> +	if (ccpu == 0) {
>>>>> +		/* crash_save_cpu() will be done in the kexec path */
>>>>> +		cpu_emergency_stop_pt();	/* disable performance trace */
>>>>> +		atomic_inc(&crash_cpus_wait);
>>>>> +	} else {
>>>>> +		crash_save_cpu(regs, ccpu);
>>>>> +		cpu_emergency_stop_pt();	/* disable performance trace */
>>>>> +		atomic_inc(&crash_cpus_wait);
>>>>> +		for (;;);			/* cause no vmexits */
>>>>> +	}
>>>>> +
>>>>> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
>>>>> +		mdelay(1);
>>>>> +
>>>>> +	stop_nmi();
>>>>> +	if (!hv_has_crashed)
>>>>> +		hv_notify_prepare_hyp();
>>>>> +
>>>>> +	if (crashing_cpu == -1)
>>>>> +		crashing_cpu = ccpu;		/* crash cmd uses this */
>>>>
>>>> Could just be "crashing_cpu = 0" since only the BSP gets here.
>>>
>>> a code change request has been open for while to remove the requirement
>>> of bsp..
>>>
>>>>> +
>>>>> +	hv_hvcrash_ctxt_save();
>>>>> +	hv_mark_tss_not_busy();
>>>>> +	hv_crash_fixup_kernpt();
>>>>> +
>>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>> +	memset(input, 0, sizeof(*input));
>>>>> +	input->rip = trampoline_pa;	/* PA of hv_crash_asm32 */
>>>>> +	input->arg = devirt_cr3arg;	/* PA of trampoline page table L4 */
>>>>
>>>> Is this comment correct? Isn't it the PA of struct hv_crash_tramp_data?
>>>> And just for clarification, Hyper-V treats this "arg" value as opaque and does
>>>> not access it. It only provides it in EDI when it invokes the trampoline
>>>> function, right?
>>>
>>> comment is correct. cr3 always points to l4 (or l5 if 5 level page tables).
>>
>> Yes, the comment matches the name of the "devirt_cr3arg" variable.
>> Unfortunately my previous comment was incomplete because the value
>> stored in the static variable "devirt_cr3arg" isn?t the address of an L4 page
>> table. It's not a CR3 value. The value stored in devirt_cr3arg is actually the
>> PA of struct hv_crash_tramp_data. The CR3 value is stored in the
>> tramp32_cr3 field (at offset 0) of that structure, so there's an additional level
>> of indirection. The (corrected) comment in the header to hv_crash_asm32()
>> describes EDI as containing "PA of struct hv_crash_tramp_data", which
>> ought to match what is described here. I'd say that "devirt_cr3arg" ought
>> to be renamed to "tramp_data_pa" or something else parallel to
>> "trampoline_pa".
> 
> hyp needs trampoline cr3 for transition, we pass it as an arg. we piggy 
> back extra information for ourselves needed in trampoline.S. so it's 
> all good.

actually, what i said earlier was true, not above. that the arg is
opaque and hyp does not use it (we are transitioning paging off after
all!). i did this all almost two years ago, so had vague recollections
but finally had time today to go back to square one and old notes,
and remember things now. so final answer:

the hypercall calls it TrampolineCr3, i guess this is how windows uses it
(they have customized kernel code for core collection). doing that was
becoming too intrusive on linux, so i decided to use the arg to pass the
info i needed in the trampoline code. Since the hypercall calls the arg
TrampolineCr3, i must have just used that name for the arg to match it,
probably falsely assuming hypervisor somehow looked at it. (actually,
the windows hypercall wrapper does look at it to make sure it is a
ram address).

since the hypercall doesn't use the arg, it could just call it
devirtArg, but maybe in the past they used it somehow. in my latest
version, i just call it devirt_arg.


>>> right, comes in edi, i don't know what EDI is (just kidding!)...
>>>
>>>>> +
>>>>> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
>>>>> +
>>>>> +	/* Devirt failed, just reboot as things are in very bad state now */
>>>>> +	native_wrmsrq(HV_X64_MSR_RESET, 1);    /* get hv to reboot */
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Generic nmi callback handler: could be called without any crash also.
>>>>> + *   hv crash: hypervisor injects nmi's into all cpus
>>>>> + *   lx crash: panicing cpu sends nmi to all but self via crash_stop_other_cpus
>>>>> + */
>>>>> +static int hv_crash_nmi_local(unsigned int cmd, struct pt_regs *regs)
>>>>> +{
>>>>> +	int ccpu = smp_processor_id();
>>>>> +
>>>>> +	if (!hv_has_crashed && hv_cda && hv_cda->cda_valid)
>>>>> +		hv_has_crashed = 1;
>>>>> +
>>>>> +	if (!hv_has_crashed && !lx_has_crashed)
>>>>> +		return NMI_DONE;	/* ignore the nmi */
>>>>> +
>>>>> +	if (hv_has_crashed) {
>>>>> +		if (!kexec_crash_loaded() || !hv_crash_enabled) {
>>>>> +			if (ccpu == 0) {
>>>>> +				native_wrmsrq(HV_X64_MSR_RESET, 1); /* reboot */
>>>>> +			} else
>>>>> +				for (;;);	/* cause no vmexits */
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	crash_nmi_callback(regs);
>>>>> +
>>>>> +	return NMI_DONE;
>>>>
>>>> crash_nmi_callback() should never return, right? Normally one would
>>>> expect to return NMI_HANDLED here, but I guess it doesn't matter
>>>> if the return is never executed.
>>>
>>> correct.
>>>
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * hv_crash_stop_other_cpus() == smp_ops.crash_stop_other_cpus
>>>>> + *
>>>>> + * On normal linux panic, this is called twice: first from panic and then again
>>>>> + * from native_machine_crash_shutdown.
>>>>> + *
>>>>> + * In case of mshv, 3 ways to get here:
>>>>> + *  1. hv crash (only bsp will get here):
>>>>> + *	BSP : nmi callback -> DisableHv -> hv_crash_asm32 -> hv_crash_c_entry
>>>>> + *		  -> __crash_kexec -> native_machine_crash_shutdown
>>>>> + *		  -> crash_smp_send_stop -> smp_ops.crash_stop_other_cpus
>>>>> + *  linux panic:
>>>>> + *	2. panic cpu x: panic() -> crash_smp_send_stop
>>>>> + *				     -> smp_ops.crash_stop_other_cpus
>>>>> + *	3. bsp: native_machine_crash_shutdown -> crash_smp_send_stop
>>>>> + *
>>>>> + * NB: noclone and non standard stack because of call to crash_setup_regs().
>>>>> + */
>>>>> +static void __noclone hv_crash_stop_other_cpus(void)
>>>>> +{
>>>>> +	static int crash_stop_done;
>>>>> +	struct pt_regs lregs;
>>>>> +	int ccpu = smp_processor_id();
>>>>> +
>>>>> +	if (hv_has_crashed)
>>>>> +		return;		/* all cpus already in nmi handler path */
>>>>> +
>>>>> +	if (!kexec_crash_loaded())
>>>>> +		return;
>>>>
>>>> If we're in a normal panic path (your Case #2 above) with no kdump kernel
>>>> loaded, why leave the other vCPUs running? Seems like that could violate
>>>> expectations in vpanic(), where it calls panic_other_cpus_shutdown() and
>>>> thereafter assumes other vCPUs are not running.
>>>
>>> no, there is lots of complexity here!
>>>
>>> if we hang vcpus here, hyp will note and may trigger its own watchdog.
>>> also, machine_crash_shutdown() does another ipi.
>>>
>>> I think the best thing to do here is go back to my V0 which did not
>>> have check for kexec_crash_loaded(), but had this in hv_crash_c_entry:
>>>
>>> +       /* we are now fully in devirtualized normal kernel mode */
>>> +       __crash_kexec(NULL);
>>> +
>>> +       BUG();
>>>
>>>
>>> this way hyp would be disabled, ie, system devirtualized, and
>>> __crash_kernel() will return, resulting in BUG() that will cause
>>> it to go thru panic and honor panic= parameter with either hang
>>> or reset. instead of bug, i could just call panic() also.
>>>
>>>>> +
>>>>> +	if (crash_stop_done)
>>>>> +		return;
>>>>> +	crash_stop_done = 1;
>>>>
>>>> Is crash_stop_done necessary?  hv_crash_stop_other_cpus() is called
>>>> from crash_smp_send_stop(), which has its own static variable
>>>> "cpus_stopped" that does the same thing.
>>>
>>> yes. for error paths.
>>>
>>>>> +
>>>>> +	/* linux has crashed: hv is healthy, we can ipi safely */
>>>>> +	lx_has_crashed = 1;
>>>>> +	wmb();			/* nmi handlers look at lx_has_crashed */
>>>>> +
>>>>> +	apic->send_IPI_allbutself(NMI_VECTOR);
>>>>
>>>> The default .crash_stop_other_cpus function is kdump_nmi_shootdown_cpus().
>>>> In addition to sending the NMI IPI, it does disable_local_APIC(). I don't know, but
>>>> should disable_local_APIC() be done somewhere here as well?
>>>
>>> no, hyp does that.
>>
>> As part of the devirt operation initiated by the HVCALL_DISABLE_HYP_EX
>> hypercall in crash_nmi_callback()? This gets back to an earlier question/comment
>> where I was trying to figure out if the APIC is still enabled, and in what mode,
>> when hv_crash_asm32() is invoked.
> 
>>>
>>>>> +
>>>>> +	if (crashing_cpu == -1)
>>>>> +		crashing_cpu = ccpu;		/* crash cmd uses this */
>>>>> +
>>>>> +	/* crash_setup_regs() happens in kexec also, but for the kexec cpu which
>>>>> +	 * is the bsp. We could be here on non-bsp cpu, collect regs if so.
>>>>> +	 */
>>>>> +	if (ccpu)
>>>>> +		crash_setup_regs(&lregs, NULL);
>>>>> +
>>>>> +	crash_nmi_callback(&lregs);
>>>>> +}
>>>>> +STACK_FRAME_NON_STANDARD(hv_crash_stop_other_cpus);
>>>>> +
>>>>> +/* This GDT is accessed in IA32-e compat mode which uses 32bits addresses */
>>>>> +struct hv_gdtreg_32 {
>>>>> +	u16 fill;
>>>>> +	u16 limit;
>>>>> +	u32 address;
>>>>> +} __packed;
>>>>> +
>>>>> +/* We need a CS with L bit to goto IA32-e long mode from 32bit compat mode */
>>>>> +struct hv_crash_tramp_gdt {
>>>>> +	u64 null;	/* index 0, selector 0, null selector */
>>>>> +	u64 cs64;	/* index 1, selector 8, cs64 selector */
>>>>> +} __packed;
>>>>> +
>>>>> +/* No stack, so jump via far ptr in memory to load the 64bit CS */
>>>>> +struct hv_cs_jmptgt {
>>>>> +	u32 address;
>>>>> +	u16 csval;
>>>>> +	u16 fill;
>>>>> +} __packed;
>>>>> +
>>>>> +/* This trampoline data is copied onto the trampoline page after the asm code */
>>>>> +struct hv_crash_tramp_data {
>>>>> +	u64 tramp32_cr3;
>>>>> +	u64 kernel_cr3;
>>>>> +	struct hv_gdtreg_32 gdtr32;
>>>>> +	struct hv_crash_tramp_gdt tramp_gdt;
>>>>> +	struct hv_cs_jmptgt cs_jmptgt;
>>>>> +	u64 c_entry_addr;
>>>>> +} __packed;
>>>>> +
>>>>> +/*
>>>>> + * Setup a temporary gdt to allow the asm code to switch to the long mode.
>>>>> + * Since the asm code is relocated/copied to a below 4G page, it cannot use rip
>>>>> + * relative addressing, hence we must use trampoline_pa here. Also, save other
>>>>> + * info like jmp and C entry targets for same reasons.
>>>>> + *
>>>>> + * Returns: 0 on success, -1 on error
>>>>> + */
>>>>> +static int hv_crash_setup_trampdata(u64 trampoline_va)
>>>>> +{
>>>>> +	int size, offs;
>>>>> +	void *dest;
>>>>> +	struct hv_crash_tramp_data *tramp;
>>>>> +
>>>>> +	/* These must match exactly the ones in the corresponding asm file */
>>>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, tramp32_cr3) != 0);
>>>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, kernel_cr3) != 8);
>>>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, gdtr32.limit) != 18);
>>>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data,
>>>>> +						     cs_jmptgt.address) != 40);
>>>>
>>>> It would be nice to pick up the constants from a #include file that is
>>>> shared with the asm code in Patch 4 of the series.
>>>
>>> yeah, could go either way, some don't like tiny headers...  if there are
>>> no objections to new header for this, i could go that way too.
>>
>> Saw your follow-on comments about this as well. The tiny header
>> is ugly. It's a judgment call that can go either way, so go with your
>> preference.
>>
>>>
>>>>> +
>>>>> +	/* hv_crash_asm_end is beyond last byte by 1 */
>>>>> +	size = &hv_crash_asm_end - &hv_crash_asm32;
>>>>> +	if (size + sizeof(struct hv_crash_tramp_data) > PAGE_SIZE) {
>>>>> +		pr_err("%s: trampoline page overflow\n", __func__);
>>>>> +		return -1;
>>>>> +	}
>>>>> +
>>>>> +	dest = (void *)trampoline_va;
>>>>> +	memcpy(dest, &hv_crash_asm32, size);
>>>>> +
>>>>> +	dest += size;
>>>>> +	dest = (void *)round_up((ulong)dest, 16);
>>>>> +	tramp = (struct hv_crash_tramp_data *)dest;
>>>>> +
>>>>> +	/* see MAX_ASID_AVAILABLE in tlb.c: "PCID 0 is reserved for use by
>>>>> +	 * non-PCID-aware users". Build cr3 with pcid 0
>>>>> +	 */
>>>>> +	tramp->tramp32_cr3 = __sme_pa(hv_crash_ptpgs[0]);
>>>>> +
>>>>> +	/* Note, when restoring X86_CR4_PCIDE, cr3[11:0] must be zero */
>>>>> +	tramp->kernel_cr3 = __sme_pa(init_mm.pgd);
>>>>> +
>>>>> +	tramp->gdtr32.limit = sizeof(struct hv_crash_tramp_gdt);
>>>>> +	tramp->gdtr32.address = trampoline_pa +
>>>>> +				   (ulong)&tramp->tramp_gdt - trampoline_va;
>>>>> +
>>>>> +	 /* base:0 limit:0xfffff type:b dpl:0 P:1 L:1 D:0 avl:0 G:1 */
>>>>> +	tramp->tramp_gdt.cs64 = 0x00af9a000000ffff;
>>>>> +
>>>>> +	tramp->cs_jmptgt.csval = 0x8;
>>>>> +	offs = (ulong)&hv_crash_asm64_lbl - (ulong)&hv_crash_asm32;
>>>>> +	tramp->cs_jmptgt.address = trampoline_pa + offs;
>>>>> +
>>>>> +	tramp->c_entry_addr = (u64)&hv_crash_c_entry;
>>>>> +
>>>>> +	devirt_cr3arg = trampoline_pa + (ulong)dest - trampoline_va;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Build 32bit trampoline page table for transition from protected mode
>>>>> + * non-paging to long-mode paging. This transition needs pagetables below 4G.
>>>>> + */
>>>>> +static void hv_crash_build_tramp_pt(void)
>>>>> +{
>>>>> +	p4d_t *p4d;
>>>>> +	pud_t *pud;
>>>>> +	pmd_t *pmd;
>>>>> +	pte_t *pte;
>>>>> +	u64 pa, addr = trampoline_pa;
>>>>> +
>>>>> +	p4d = hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(p4d);
>>>>> +	pa = virt_to_phys(hv_crash_ptpgs[1]);
>>>>> +	set_p4d(p4d, __p4d(_PAGE_TABLE | pa));
>>>>> +	p4d->p4d &= ~(_PAGE_NX);	/* disable no execute */
>>>>> +
>>>>> +	pud = hv_crash_ptpgs[1] + pud_index(addr) * sizeof(pud);
>>>>> +	pa = virt_to_phys(hv_crash_ptpgs[2]);
>>>>> +	set_pud(pud, __pud(_PAGE_TABLE | pa));
>>>>> +
>>>>> +	pmd = hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(pmd);
>>>>> +	pa = virt_to_phys(hv_crash_ptpgs[3]);
>>>>> +	set_pmd(pmd, __pmd(_PAGE_TABLE | pa));
>>>>> +
>>>>> +	pte = hv_crash_ptpgs[3] + pte_index(addr) * sizeof(pte);
>>>>> +	set_pte(pte, pfn_pte(addr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Setup trampoline for devirtualization:
>>>>> + *  - a page below 4G, ie 32bit addr containing asm glue code that mshv jmps to
>>>>> + *    in protected mode.
>>>>> + *  - 4 pages for a temporary page table that asm code uses to turn paging on
>>>>> + *  - a temporary gdt to use in the compat mode.
>>>>> + *
>>>>> + *  Returns: 0 on success
>>>>> + */
>>>>> +static int hv_crash_trampoline_setup(void)
>>>>> +{
>>>>> +	int i, rc, order;
>>>>> +	struct page *page;
>>>>> +	u64 trampoline_va;
>>>>> +	gfp_t flags32 = GFP_KERNEL | GFP_DMA32 | __GFP_ZERO;
>>>>> +
>>>>> +	/* page for 32bit trampoline assembly code + hv_crash_tramp_data */
>>>>> +	page = alloc_page(flags32);
>>>>> +	if (page == NULL) {
>>>>> +		pr_err("%s: failed to alloc asm stub page\n", __func__);
>>>>> +		return -1;
>>>>> +	}
>>>>> +
>>>>> +	trampoline_va = (u64)page_to_virt(page);
>>>>> +	trampoline_pa = (u32)page_to_phys(page);
>>>>> +
>>>>> +	order = 2;	   /* alloc 2^2 pages */
>>>>> +	page = alloc_pages(flags32, order);
>>>>> +	if (page == NULL) {
>>>>> +		pr_err("%s: failed to alloc pt pages\n", __func__);
>>>>> +		free_page(trampoline_va);
>>>>> +		return -1;
>>>>> +	}
>>>>> +
>>>>> +	for (i = 0; i < 4; i++, page++)
>>>>> +		hv_crash_ptpgs[i] = page_to_virt(page);
>>>>> +
>>>>> +	hv_crash_build_tramp_pt();
>>>>> +
>>>>> +	rc = hv_crash_setup_trampdata(trampoline_va);
>>>>> +	if (rc)
>>>>> +		goto errout;
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +errout:
>>>>> +	free_page(trampoline_va);
>>>>> +	free_pages((ulong)hv_crash_ptpgs[0], order);
>>>>> +
>>>>> +	return rc;
>>>>> +}
>>>>> +
>>>>> +/* Setup for kdump kexec to collect hypervisor ram when running as mshv root */
>>>>> +void hv_root_crash_init(void)
>>>>> +{
>>>>> +	int rc;
>>>>> +	struct hv_input_get_system_property *input;
>>>>> +	struct hv_output_get_system_property *output;
>>>>> +	unsigned long flags;
>>>>> +	u64 status;
>>>>> +	union hv_pfn_range cda_info;
>>>>> +
>>>>> +	if (pgtable_l5_enabled()) {
>>>>> +		pr_err("Hyper-V: crash dump not yet supported on 5level PTs\n");
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	rc = register_nmi_handler(NMI_LOCAL, hv_crash_nmi_local, NMI_FLAG_FIRST,
>>>>> +				  "hv_crash_nmi");
>>>>> +	if (rc) {
>>>>> +		pr_err("Hyper-V: failed to register crash nmi handler\n");
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	local_irq_save(flags);
>>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>>>> +
>>>>> +	memset(input, 0, sizeof(*input));
>>>>> +	memset(output, 0, sizeof(*output));
>>>>
>>>> Why zero the output area? This is one of those hypercall things that we're
>>>> inconsistent about. A few hypercall call sites zero the output area, and it's
>>>> not clear why they do. Hyper-V should be responsible for properly filling in
>>>> the output area. Linux should not need to do this zero'ing, unless there's some
>>>> known bug in Hyper-V for certain hypercalls, in which case there should be
>>>> a code comment stating "why".
>>>
>>> for the same reason sometimes you see char *p = NULL, either leftover
>>> code or someone was debugging or just copy and paste. this is just copy
>>> paste. i agree in general that we don't need to clear it at all, in fact,
>>> i'd like to remove them all! but i also understand people with different
>>> skills and junior members find it easier to debug, and also we were in
>>> early product development. for that reason, it doesn't have to be
>>> consistent either, if some complex hypercalls are failing repeatedly,
>>> just for ease of debug, one might leave it there temporarily.  but
>>> now that things are stable, i think we should just remove them all and
>>> get used to a bit more inconvenient debugging...
>>
>> I see your point about debugging, but on balance I agree that they
>> should all be removed. If there's some debug case, add it back
>> temporarily to debug, but leave upstream without it. The zero'ing is
>> also unnecessary code in the interrupt disabled window, which you
>> have expressed concern about in a different thread.
> 
> yeah, i've been extremely busy so not able to pay much attention to
> upstreaming, but imo they should have been removed before upstreaming.
> a simple patch that just removes memset of output would be welcome.
> 
>>>
>>>>> +	input->property_id = HV_SYSTEM_PROPERTY_CRASHDUMPAREA;
>>>>> +
>>>>> +	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
>>>>> +	cda_info.as_uint64 = output->hv_cda_info.as_uint64;
>>>>> +	local_irq_restore(flags);
>>>>> +
>>>>> +	if (!hv_result_success(status)) {
>>>>> +		pr_err("Hyper-V: %s: property:%d %s\n", __func__,
>>>>> +		       input->property_id, hv_result_to_string(status));
>>>>> +		goto err_out;
>>>>> +	}
>>>>> +
>>>>> +	if (cda_info.base_pfn == 0) {
>>>>> +		pr_err("Hyper-V: hypervisor crash dump area pfn is 0\n");
>>>>> +		goto err_out;
>>>>> +	}
>>>>> +
>>>>> +	hv_cda = phys_to_virt(cda_info.base_pfn << PAGE_SHIFT);
>>>>
>>>> Use HV_HYP_PAGE_SHIFT, since PFNs provided by Hyper-V are always in
>>>> terms of the Hyper-V page size, which isn't necessarily the guest page size.
>>>> Yes, on x86 there's no difference, but for future robustness ....
>>>
>>> i don't know about guests, but we won't even boot if dom0 pg size
>>> didn't match.. but easier to change than to make the case..
>>
>> FWIW, a normal Linux guest on ARM64 works just fine with a page
>> size of 16K or 64K, even though the underlying Hyper-V page size
>> is only 4K. That's why we have HV_HYP_PAGE_SHIFT and related in
>> the first place. Using it properly really matters for normal guests.
>> (Having the guest page size smaller than the Hyper-V page size
>> does *not* work, but there are no such use cases.)
>>
>> Even on ARM64, I know the root partition page size is required to
>> match the Hyper-V page size. But using HV_HYP_PAGE_SIZE is
>> still appropriate just to not leave code that will go wrong if the
>> match requirement should ever change.
>>
>>>
>>>>> +
>>>>> +	rc = hv_crash_trampoline_setup();
>>>>> +	if (rc)
>>>>> +		goto err_out;
>>>>> +
>>>>> +	smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
>>>>> +
>>>>> +	crash_kexec_post_notifiers = true;
>>>>> +	hv_crash_enabled = 1;
>>>>> +	pr_info("Hyper-V: linux and hv kdump support enabled\n");
>>>>
>>>> This message and the message below aren't consistent. One refers
>>>> to "hv kdump" and the other to "hyp kdump".
>>>
>>>>> +
>>>>> +	return;
>>>>> +
>>>>> +err_out:
>>>>> +	unregister_nmi_handler(NMI_LOCAL, "hv_crash_nmi");
>>>>> +	pr_err("Hyper-V: only linux (but not hyp) kdump support enabled\n");
>>>>> +}
>>>>> --
>>>>> 2.36.1.vfs.0.0

