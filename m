Return-Path: <linux-arch+bounces-11682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC663AA09BB
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E5A1B655C6
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC52C2589;
	Tue, 29 Apr 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8ZBABZh"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546F2C1E08
	for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926436; cv=none; b=rN5qcYZNAgL90JIXcZwpmDEsbomCEjDAIfoLlUdzXI/BHqNXZbQc2aUKjqGZeoR8Kli+2o3ozWbrBlcwn8zWEFPXnY61d/O+TpvH56Hop3UWDPQ5lUBIQoIiNqeYh9dotGoGa3kJexa/Qvab0TPCcWWug6UkTGxkTRiq0MXTg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926436; c=relaxed/simple;
	bh=ZpzioWpFJn48xIeG0F8/IdMCTzTyHmPJ0OO4uqf73Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIHDdfOZLcRhhhD3y9ehlbwKUXby+Tcu4Z4I+Mc8rs1p8CjAShLZfDJxPzRz7/kjvAMYrUTuBeELtpHV0FVe0zHBdZ9UtD3QrGfBmrW8/bxtLFYUdBlilC+d8bACwT8ic/pcyMeV9hkg+h55a2Rw0GpietyzrYdqqY9f/CchCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8ZBABZh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745926432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4IQnRl/C7kuGVZTt4qc9FjPx3AzVXmgSwCZuorEAYzE=;
	b=B8ZBABZhGB6e5ITyAe4pti1tOZ+ELDEcB/vWrClUmDebvsaF0kMARbna0X79hc5CiDpgmT
	4/Quh1XejbkzEh6+iqkX6y28QWW+LY/IEFylayK8C1pwz0iLderGpEwwPP/hy5hz0PUlXU
	Sw4tqQR3eeazpJQBAgWdIs9c9lMDMBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-cyfhNh81OWu7-Pvfv5VHMQ-1; Tue,
 29 Apr 2025 07:33:48 -0400
X-MC-Unique: cyfhNh81OWu7-Pvfv5VHMQ-1
X-Mimecast-MFC-AGG-ID: cyfhNh81OWu7-Pvfv5VHMQ_1745926424
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77861180010A;
	Tue, 29 Apr 2025 11:33:43 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.225.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8730819560A3;
	Tue, 29 Apr 2025 11:33:10 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Naveen N Rao <naveen@kernel.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Rong Xu <xur@google.com>,
	Rafael Aquini <aquini@redhat.com>,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Stultz <jstultz@google.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a user->kernel transition
Date: Tue, 29 Apr 2025 13:32:17 +0200
Message-ID: <20250429113242.998312-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Context
=======

We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
pure-userspace application get regularly interrupted by IPIs sent from
housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
leading to various on_each_cpu() calls, e.g.:

  64359.052209596    NetworkManager       0    1405     smp_call_function_many_cond (cpu=0, func=do_kernel_range_flush)
    smp_call_function_many_cond+0x1
    smp_call_function+0x39
    on_each_cpu+0x2a
    flush_tlb_kernel_range+0x7b
    __purge_vmap_area_lazy+0x70
    _vm_unmap_aliases.part.42+0xdf
    change_page_attr_set_clr+0x16a
    set_memory_ro+0x26
    bpf_int_jit_compile+0x2f9
    bpf_prog_select_runtime+0xc6
    bpf_prepare_filter+0x523
    sk_attach_filter+0x13
    sock_setsockopt+0x92c
    __sys_setsockopt+0x16a
    __x64_sys_setsockopt+0x20
    do_syscall_64+0x87
    entry_SYSCALL_64_after_hwframe+0x65

The heart of this series is the thought that while we cannot remove NOHZ_FULL
CPUs from the list of CPUs targeted by these IPIs, they may not have to execute
the callbacks immediately. Anything that only affects kernelspace can wait
until the next user->kernel transition, providing it can be executed "early
enough" in the entry code.

The original implementation is from Peter [1]. Nicolas then added kernel TLB
invalidation deferral to that [2], and I picked it up from there.

Deferral approach
=================

Storing each and every callback, like a secondary call_single_queue turned out
to be a no-go: the whole point of deferral is to keep NOHZ_FULL CPUs in
userspace for as long as possible - no signal of any form would be sent when
deferring an IPI. This means that any form of queuing for deferred callbacks
would end up as a convoluted memory leak.

Deferred IPIs must thus be coalesced, which this series achieves by assigning
IPIs a "type" and having a mapping of IPI type to callback, leveraged upon
kernel entry.

What about IPIs whose callback take a parameter, you may ask?

Peter suggested during OSPM23 [3] that since on_each_cpu() targets
housekeeping CPUs *and* isolated CPUs, isolated CPUs can access either global or
housekeeping-CPU-local state to "reconstruct" the data that would have been sent
via the IPI.

This series does not affect any IPI callback that requires an argument, but the
approach would remain the same (one coalescable callback executed on kernel
entry).

Kernel entry vs execution of the deferred operation
===================================================

This is what I've referred to as the "Danger Zone" during my LPC24 talk [4].

There is a non-zero length of code that is executed upon kernel entry before the
deferred operation can be itself executed (before we start getting into
context_tracking.c proper), i.e.:

  idtentry_func_foo()                <--- we're in the kernel
    irqentry_enter()
      enter_from_user_mode()
	__ct_user_exit()
	    ct_kernel_enter_state()
	      ct_work_flush()        <--- deferred operation is executed here

This means one must take extra care to what can happen in the early entry code,
and that <bad things> cannot happen. For instance, we really don't want to hit
instructions that have been modified by a remote text_poke() while we're on our
way to execute a deferred sync_core(). Patches doing the actual deferral have
more detail on this.

Where are we at with this whole thing?
======================================

Dave has been incredibly helpful wrt figuring out what would and wouldn't
(mostly that) be safe to do for deferring kernel range TLB flush IPIs, see [5].

Long story short, there are ugly things I can still do to (safely) defer the TLB
flush IPIs, but it's going to be a long session of pulling my own hair out, and
I got plenty so I won't be done for a while.

In the meantime, I think everything leading up to deferring text poke IPIs is
sane-ish and could get in. I'm not the biggest fan of adding an API with a
single user, but hey, I've been working on this for "a little while" now and
I'll still need to get the other IPIs sorted out.

TL;DR: Text patching IPI deferral LGTM so here it is for now, I'm still working
on the TLB flush thing.

Patches
=======

o Patches 1-2 are standalone objtool cleanups.

o Patches 3-4 add an RCU testing feature.

o Patches 5-6 add infrastructure for annotating static keys and static calls
  that may be used in noinstr code (courtesy of Josh).
o Patches 7-20 use said annotations on relevant keys / calls.
o Patch 21 enforces proper usage of said annotations (courtesy of Josh).

o Patches 22-23 deal with detecting NOINSTR text in modules

o Patches 24-25 add the actual IPI deferral faff

Patches are also available at:
https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v5

Testing
=======

Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
RHEL10 userspace.

Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:

$ trace-cmd record -e "csd_queue_cpu" -f "cpu & CPUS{$ISOL_CPUS}" \
 	           -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
	           -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
		   rteval --onlyload --loads-cpulist=$HK_CPUS \
		   --hackbench-runlowmem=True --duration=$DURATION

This only records IPIs sent to isolated CPUs, so any event there is interference
(with a bit of fuzz at the start/end of the workload when spawning the
processes). All tests were done with a duration of 3 hours.

v6.14
# This is the actual IPI count
$ trace-cmd report | grep callback | awk '{ print $(NF) }' | sort | uniq -c | sort -nr
     93 callback=generic_smp_call_function_single_interrupt+0x0
     22 callback=nohz_full_kick_func+0x0
     
# These are the different CSD's that caused IPIs    
$ trace-cmd report | grep csd_queue | awk '{ print $(NF-1) }' | sort | uniq -c | sort -nr
   1456 func=do_flush_tlb_all
     78 func=do_sync_core
     33 func=nohz_full_kick_func
     26 func=do_kernel_range_flush

v6.14 + patches
# This is the actual IPI count
$ trace-cmd report | grep callback | awk '{ print $(NF) }' | sort | uniq -c | sort -nr
     86 callback=generic_smp_call_function_single_interrupt+0x0
     41 callback=nohz_full_kick_func+0x0

# These are the different CSD's that caused IPIs          
$ trace-cmd report | grep csd_queue | awk '{ print $(NF-1) }' | sort | uniq -c | sort -nr
   1378 func=do_flush_tlb_all
     33 func=nohz_full_kick_func

So the TLB flush is still there driving most of the IPIs, but at least the
instruction patching IPIs are gone. With kernel TLB flushes deferred, there are
no IPIs sent to isolated CPUs in that 3hr window, but as stated above that still
needs some more work.
     
Also note that tlb_remove_table_smp_sync() showed up during testing of v3, and
has gone as mysteriously as it showed up. Yair had a series adressing this [6]
which per these results would be worth revisiting.

Acknowledgements
================

Special thanks to:
o Clark Williams for listening to my ramblings about this and throwing ideas my way
o Josh Poimboeuf for all his help with everything objtool-related
o All of the folks who attended various (too many?) talks about this and
  provided precious feedback.  
o The mm folks for pointing out what I can and can't do with TLB flushes

Links
=====

[1]: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
[2]: https://github.com/vianpl/linux.git -b ct-work-defer-wip
[3]: https://youtu.be/0vjE6fjoVVE
[4]: https://lpc.events/event/18/contributions/1889/
[5]: http://lore.kernel.org/r/eef09bdc-7546-462b-9ac0-661a44d2ceae@intel.com
[6]: https://lore.kernel.org/lkml/20230620144618.125703-1-ypodemsk@redhat.com/

Revisions
=========

v4 -> v5
++++++++

o Rebased onto v6.15-rc3
o Collected Reviewed-by

o Annotated a few more static keys
o Added proper checking of noinstr sections that are in loadable code such as
  KVM early entry (Sean Christopherson)

o Switched to checking for CT_RCU_WATCHING instead of CT_STATE_KERNEL or
  CT_STATE_IDLE, which means deferral is now behaving sanely for IRQ/NMI
  entry from idle (thanks to Frederic!)

o Ditched the vmap TLB flush deferral (for now)  
  

RFCv3 -> v4
+++++++++++

o Rebased onto v6.13-rc6

o New objtool patches from Josh
o More .noinstr static key/call patches
o Static calls now handled as well (again thanks to Josh)

o Fixed clearing the work bits on kernel exit
o Messed with IRQ hitting an idle CPU vs context tracking
o Various comment and naming cleanups

o Made RCU_DYNTICKS_TORTURE depend on !COMPILE_TEST (PeterZ)
o Fixed the CT_STATE_KERNEL check when setting a deferred work (Frederic)
o Cleaned up the __flush_tlb_all() mess thanks to PeterZ

RFCv2 -> RFCv3
++++++++++++++

o Rebased onto v6.12-rc6

o Added objtool documentation for the new warning (Josh)
o Added low-size RCU watching counter to TREE04 torture scenario (Paul)
o Added FORCEFUL jump label and static key types
o Added noinstr-compliant helpers for tlb flush deferral


RFCv1 -> RFCv2
++++++++++++++

o Rebased onto v6.5-rc1

o Updated the trace filter patches (Steven)

o Fixed __ro_after_init keys used in modules (Peter)
o Dropped the extra context_tracking atomic, squashed the new bits in the
  existing .state field (Peter, Frederic)
  
o Added an RCU_EXPERT config for the RCU dynticks counter size, and added an
  rcutorture case for a low-size counter (Paul) 

o Fixed flush_tlb_kernel_range_deferrable() definition

Josh Poimboeuf (3):
  jump_label: Add annotations for validating noinstr usage
  static_call: Add read-only-after-init static calls
  objtool: Add noinstr validation for static branches/calls

Valentin Schneider (22):
  objtool: Make validate_call() recognize indirect calls to pv_ops[]
  objtool: Flesh out warning related to pv_ops[] calls
  rcu: Add a small-width RCU watching counter debug option
  rcutorture: Make TREE04 use CONFIG_RCU_DYNTICKS_TORTURE
  x86/paravirt: Mark pv_sched_clock static call as __ro_after_init
  x86/idle: Mark x86_idle static call as __ro_after_init
  x86/paravirt: Mark pv_steal_clock static call as __ro_after_init
  riscv/paravirt: Mark pv_steal_clock static call as __ro_after_init
  loongarch/paravirt: Mark pv_steal_clock static call as __ro_after_init
  arm64/paravirt: Mark pv_steal_clock static call as __ro_after_init
  arm/paravirt: Mark pv_steal_clock static call as __ro_after_init
  perf/x86/amd: Mark perf_lopwr_cb static call as __ro_after_init
  sched/clock: Mark sched_clock_running key as __ro_after_init
  KVM: VMX: Mark __kvm_is_using_evmcs static key as __ro_after_init
  x86/speculation/mds: Mark mds_idle_clear key as allowed in .noinstr
  sched/clock, x86: Mark __sched_clock_stable key as allowed in .noinstr
  KVM: VMX: Mark vmx_l1d_should flush and vmx_l1d_flush_cond keys as
    allowed in .noinstr
  stackleack: Mark stack_erasing_bypass key as allowed in .noinstr
  module: Remove outdated comment about text_size
  module: Add MOD_NOINSTR_TEXT mem_type
  context-tracking: Introduce work deferral infrastructure
  context_tracking,x86: Defer kernel text patching IPIs

 arch/Kconfig                                  |   9 ++
 arch/arm/kernel/paravirt.c                    |   2 +-
 arch/arm64/kernel/paravirt.c                  |   2 +-
 arch/loongarch/kernel/paravirt.c              |   2 +-
 arch/riscv/kernel/paravirt.c                  |   2 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/events/amd/brs.c                     |   2 +-
 arch/x86/include/asm/context_tracking_work.h  |  18 +++
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/kernel/alternative.c                 |  39 ++++++-
 arch/x86/kernel/cpu/bugs.c                    |   2 +-
 arch/x86/kernel/kprobes/core.c                |   4 +-
 arch/x86/kernel/kprobes/opt.c                 |   4 +-
 arch/x86/kernel/module.c                      |   2 +-
 arch/x86/kernel/paravirt.c                    |   4 +-
 arch/x86/kernel/process.c                     |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |  11 +-
 arch/x86/kvm/vmx/vmx_onhyperv.c               |   2 +-
 include/asm-generic/sections.h                |  15 +++
 include/linux/context_tracking.h              |  21 ++++
 include/linux/context_tracking_state.h        |  54 +++++++--
 include/linux/context_tracking_work.h         |  26 +++++
 include/linux/jump_label.h                    |  30 ++++-
 include/linux/module.h                        |   6 +-
 include/linux/objtool.h                       |   7 ++
 include/linux/static_call.h                   |  19 ++++
 kernel/context_tracking.c                     |  69 +++++++++++-
 kernel/kprobes.c                              |   8 +-
 kernel/module/main.c                          |  85 ++++++++++----
 kernel/rcu/Kconfig.debug                      |  15 +++
 kernel/sched/clock.c                          |   7 +-
 kernel/stackleak.c                            |   6 +-
 kernel/time/Kconfig                           |   5 +
 tools/objtool/Documentation/objtool.txt       |  34 ++++++
 tools/objtool/check.c                         | 106 +++++++++++++++---
 tools/objtool/include/objtool/check.h         |   1 +
 tools/objtool/include/objtool/elf.h           |   1 +
 tools/objtool/include/objtool/special.h       |   1 +
 tools/objtool/special.c                       |  15 ++-
 .../selftests/rcutorture/configs/rcu/TREE04   |   1 +
 40 files changed, 557 insertions(+), 84 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h

--
2.49.0


