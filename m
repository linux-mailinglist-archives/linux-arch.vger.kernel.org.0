Return-Path: <linux-arch+bounces-10215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48261A3BC2F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AAB17829C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4581DE891;
	Wed, 19 Feb 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RfHqzYxe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C31DE896;
	Wed, 19 Feb 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962627; cv=none; b=NULkBV2qwe95AsO8q+0LWNeRP0jWi8lomwvawj/BmSOawnFyk0OB/zMf5QgLypkaayDKcfT4cF0Y2hMwqhpViNeOaa+mw+TiC8GyAwcjAelu2MJ5Isi+VM3wauiyWMbxPjyRZZEmO8vSRKfzktpQBOjgbvL47L2RdSyhxZGLrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962627; c=relaxed/simple;
	bh=luKAxHsvrVJI3rjvtCOJTo+55XyMmeRCwJO3mKY+DZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxQDGzcwruVXYoXMByNPh/UlKsu0NGTIreXaYCbly4ZFMC8/RbAYNnw6K3zth35mkIzQ5pK3cczhtmzloLVoiRMSM7eirw9Jp0iL0tzeOOhw5QDVlwEGZStBMYKSKFZutvwvP7+URd34jZwiHMru4N9K1YkkUwvFBRqeFMN9v98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RfHqzYxe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C20F40E01AD;
	Wed, 19 Feb 2025 10:57:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MuhRjJG8dSVG; Wed, 19 Feb 2025 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739962615; bh=fzmVeMolHHfNK8MWJfns5nr6CAxpqySaRGO9y0S6Ies=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RfHqzYxeNSeAwm0yBKkt3BFRT6WwRDtGptKKmYYtod2NbMtpM8bqaE4Am0115gKQq
	 s6bzbi/QMuXqHH4rIsMbHnfyyDb/DMMnBqunn967EXG3HP4Vb787URNEAt2Jv4Wifz
	 hjADK77YpGhp1s3RFjOLF/gYxWNONBAJagKefBNWITn6NJ0eYEU+ES1M54R+UHBl+2
	 tFDb3vrO8d8gT/XUbWKLkelvkoUjHlGjcwLDD+3cyHcjf+qnaJ3xttjJD6YWMTsdic
	 vLr5uy9kU/QcukaM9vg1ms3QLHmluggCCZkpJoPXOlSFrkZl6XiCR30lPvPnaiFo6Z
	 gjzm0Lu9Sg2EN/W5nk9YuCgx01RXkLTj+B+bpR/wf2WkzodbKQao7sGsqbLQ6cHO5e
	 lL5eYSFUOjHcUY7n0QWvEwe1q+pEZDIdy1LBMdgHOIP5xag8eQ49lWbSaBmCtqLpgO
	 v0mj9+AWqeSta32LTtksTU3GcwgPcoNromU5+0ig0J1hp54vI0TNhPIbaiBUE/yxCx
	 RByGXppWJ5Mz1zYQdan4Qc1DV2UoBXp+Yofox8o/3u74nyLd4cP9bb/l1FrGM8W9FD
	 nOpA/QHPNBj0NZ6ejfAJrlH/EWHRG4iJHNVkYORtCbb3pumsRXfRjCOC1BU0BGCnZ0
	 uvBdPPgX8OStzakizKy8yHUU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F08F40E0220;
	Wed, 19 Feb 2025 10:55:10 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:55:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mike Rapoport <rppt@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, Ofir Weisse <oweisse@google.com>,
	Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API
Message-ID: <20250219105503.GKZ7W4h6QW1CNj48U9@fat_crate.local>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-3-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110-asi-rfc-v2-v2-3-8419288bc805@google.com>

On Fri, Jan 10, 2025 at 06:40:29PM +0000, Brendan Jackman wrote:
> Subject: Re: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API

x86/asi: ...

> Introduce core API for Address Space Isolation (ASI).  Kernel address
> space isolation provides the ability to run some kernel
> code with a restricted kernel address space.
> 
> There can be multiple classes of such restricted kernel address spaces
> (e.g. KPTI, KVM-PTI etc.). Each ASI class is identified by an index.
> The ASI class can register some hooks to be called when
> entering/exiting the restricted address space.
> 
> Currently, there is a fixed maximum number of ASI classes supported.
> In addition, each process can have at most one restricted address space
> from each ASI class. Neither of these are inherent limitations and
> are merely simplifying assumptions for the time being.
> 
> To keep things simpler for the time being, we disallow context switches

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

> within the restricted address space. In the future, we would be able to
> relax this limitation for the case of context switches to different
> threads within the same process (or to the idle thread and back).
> 
> Note that this doesn't really support protecting sibling VM guests
> within the same VMM process from one another. From first principles
> it seems unlikely that anyone who cares about VM isolation would do
> that, but there could be a use-case to think about. In that case need
> something like the OTHER_MM logic might be needed, but specific to
> intra-process guest separation.
> 
> [0]:
> https://lore.kernel.org/kvm/1562855138-19507-1-git-send-email-alexandre.chartre@oracle.com
> 
> Notes about RFC-quality implementation details:
> 
>  - Ignoring checkpatch.pl AVOID_BUG.
>  - The dynamic registration of classes might be pointless complexity.
>    This was kept from RFCv1 without much thought.
>  - The other-mm logic is also perhaps overly complex, suggestions are
>    welcome for how best to tackle this (or we could just forget about
>    it for the moment, and rely on asi_exit() happening in process
>    switch).
>  - The taint flag definitions would probably be clearer with an enum or
>    something.
> 
> Checkpatch-args: --ignore=AVOID_BUG,COMMIT_LOG_LONG_LINE,EXPORT_SYMBOL
> Co-developed-by: Ofir Weisse <oweisse@google.com>
> Signed-off-by: Ofir Weisse <oweisse@google.com>
> Co-developed-by: Junaid Shahid <junaids@google.com>
> Signed-off-by: Junaid Shahid <junaids@google.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/include/asm/asi.h       | 208 +++++++++++++++++++++++
>  arch/x86/include/asm/processor.h |   8 +
>  arch/x86/mm/Makefile             |   1 +
>  arch/x86/mm/asi.c                | 350 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/mm/init.c               |   3 +-
>  arch/x86/mm/tlb.c                |   1 +
>  include/asm-generic/asi.h        |  67 ++++++++
>  include/linux/mm_types.h         |   7 +
>  kernel/fork.c                    |   3 +
>  kernel/sched/core.c              |   9 +
>  mm/init-mm.c                     |   4 +
>  11 files changed, 660 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7cc635b6653a3970ba9dbfdc9c828a470e27bd44
> --- /dev/null
> +++ b/arch/x86/include/asm/asi.h
> @@ -0,0 +1,208 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ASI_H
> +#define _ASM_X86_ASI_H
> +
> +#include <linux/sched.h>
> +
> +#include <asm-generic/asi.h>
> +
> +#include <asm/pgtable_types.h>
> +#include <asm/percpu.h>
> +#include <asm/processor.h>
> +
> +#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
> +
> +/*
> + * Overview of API usage by ASI clients:
> + *
> + * Setup: First call asi_init() to create a domain. At present only one domain
> + * can be created per mm per class, but it's safe to asi_init() this domain
> + * multiple times. For each asi_init() call you must call asi_destroy() AFTER
> + * you are certain all CPUs have exited the restricted address space (by
> + * calling asi_exit()).
> + *
> + * Runtime usage:
> + *
> + * 1. Call asi_enter() to switch to the restricted address space. This can't be
> + *    from an interrupt or exception handler and preemption must be disabled.
> + *
> + * 2. Execute untrusted code.
> + *
> + * 3. Call asi_relax() to inform the ASI subsystem that untrusted code execution
> + *    is finished. This doesn't cause any address space change. This can't be
> + *    from an interrupt or exception handler and preemption must be disabled.
> + *
> + * 4. Either:
> + *
> + *    a. Go back to 1.
> + *
> + *    b. Call asi_exit() before returning to userspace. This immediately
> + *       switches to the unrestricted address space.

So only from reading this, it does sound weird. Maybe the code does it
differently - I'll see soon - but this basically says:

I asi_enter(), do something, asi_relax() and then I decide to do something
more and to asi_enter() again!? And then I can end it all with a *single*
asi_exit() call?

Hm, definitely weird API. Why?

/*
 * Leave the "tense" state if we are in it, i.e. end the critical section. We
 * will stay relaxed until the next asi_enter.
 */
void asi_relax(void);

Yeah, so there's no API functions balance between enter() and relax()...

> + *
> + * The region between 1 and 3 is called the "ASI critical section". During the
> + * critical section, it is a bug to access any sensitive data, and you mustn't
> + * sleep.
> + *
> + * The restriction on sleeping is not really a fundamental property of ASI.
> + * However for performance reasons it's important that the critical section is
> + * absolutely as short as possible. So the ability to do sleepy things like
> + * taking mutexes oughtn't to confer any convenience on API users.
> + *
> + * Similarly to the issue of sleeping, the need to asi_exit in case 4b is not a
> + * fundamental property of the system but a limitation of the current
> + * implementation. With further work it is possible to context switch
> + * from and/or to the restricted address space, and to return to userspace
> + * directly from the restricted address space, or _in_ it.
> + *
> + * Note that the critical section only refers to the direct execution path from
> + * asi_enter to asi_relax: it's fine to access sensitive data from exceptions
> + * and interrupt handlers that occur during that time. ASI will re-enter the
> + * restricted address space before returning from the outermost
> + * exception/interrupt.
> + *
> + * Note: ASI does not modify KPTI behaviour; when ASI and KPTI run together
> + * there are 2+N address spaces per task: the unrestricted kernel address space,
> + * the user address space, and one restricted (kernel) address space for each of
> + * the N ASI classes.
> + */
> +
> +/*
> + * ASI uses a per-CPU tainting model to track what mitigation actions are
> + * required on domain transitions. Taints exist along two dimensions:
> + *
> + *  - Who touched the CPU (guest, unprotected kernel, userspace).
> + *
> + *  - What kind of state might remain: "data" means there might be data owned by
> + *    a victim domain left behind in a sidechannel. "Control" means there might
> + *    be state controlled by an attacker domain left behind in the branch
> + *    predictor.
> + *
> + *    In principle the same domain can be both attacker and victim, thus we have
> + *    both data and control taints for userspace, although there's no point in
> + *    trying to protect against attacks from the kernel itself, so there's no
> + *    ASI_TAINT_KERNEL_CONTROL.
> + */
> +#define ASI_TAINT_KERNEL_DATA		((asi_taints_t)BIT(0))
> +#define ASI_TAINT_USER_DATA		((asi_taints_t)BIT(1))
> +#define ASI_TAINT_GUEST_DATA		((asi_taints_t)BIT(2))
> +#define ASI_TAINT_OTHER_MM_DATA		((asi_taints_t)BIT(3))
> +#define ASI_TAINT_USER_CONTROL		((asi_taints_t)BIT(4))
> +#define ASI_TAINT_GUEST_CONTROL		((asi_taints_t)BIT(5))
> +#define ASI_TAINT_OTHER_MM_CONTROL	((asi_taints_t)BIT(6))
> +#define ASI_NUM_TAINTS			6
> +static_assert(BITS_PER_BYTE * sizeof(asi_taints_t) >= ASI_NUM_TAINTS);

Why is this a typedef at all to make the code more unreadable than it needs to
be? Why not a simple unsigned int or char or whatever you need?

> +
> +#define ASI_TAINTS_CONTROL_MASK \
> +	(ASI_TAINT_USER_CONTROL | ASI_TAINT_GUEST_CONTROL | ASI_TAINT_OTHER_MM_CONTROL)
> +
> +#define ASI_TAINTS_DATA_MASK \
> +	(ASI_TAINT_KERNEL_DATA | ASI_TAINT_USER_DATA | ASI_TAINT_OTHER_MM_DATA)
> +
> +#define ASI_TAINTS_GUEST_MASK (ASI_TAINT_GUEST_DATA | ASI_TAINT_GUEST_CONTROL)
> +#define ASI_TAINTS_USER_MASK (ASI_TAINT_USER_DATA | ASI_TAINT_USER_CONTROL)
> +
> +/* The taint policy tells ASI how a class interacts with the CPU taints */
> +struct asi_taint_policy {
> +	/*
> +	 * What taints would necessitate a flush when entering the domain, to
> +	 * protect it from attack by prior domains?
> +	 */
> +	asi_taints_t prevent_control;

So if those necessitate a flush, why isn't this var called "taints_to_flush"
or whatever which exactly explains what it is?

> +	/*
> +	 * What taints would necessetate a flush when entering the domain, to

+	 * What taints would necessetate a flush when entering the domain, to
Unknown word [necessetate] in comment.
Suggestions: ['necessitate',

Spellchecker please. Go over your whole set.

> +	 * protect former domains from attack by this domain?
> +	 */
> +	asi_taints_t protect_data;

Same.

> +	/* What taints should be set when entering the domain? */
> +	asi_taints_t set;


So "required_taints" or so... hm?

> +};
> +
> +/*
> + * An ASI domain (struct asi) represents a restricted address space. The

no need for "(struct asi)" - it is right below :).

> + * unrestricted address space (and user address space under PTI) are not
> + * represented as a domain.
> + */
> +struct asi {
> +	pgd_t *pgd;
> +	struct mm_struct *mm;
> +	int64_t ref_count;
> +	enum asi_class_id class_id;
> +};
> +
> +DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);

Or simply "asi" - this per-CPU var will be so prominent so that when you do
"per_cpu(asi)" you know what exactly it is



> +
> +void asi_init_mm_state(struct mm_struct *mm);
> +
> +int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy);
> +void asi_uninit_class(enum asi_class_id class_id);

"uninit", meh. "exit" perhaps? or "destroy"?

And you have "asi_destroy" already so I guess you can do:

asi_class_init()
asi_class_destroy()

to have the namespace correct.

> +const char *asi_class_name(enum asi_class_id class_id);
> +
> +int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi);
> +void asi_destroy(struct asi *asi);
> +
> +/* Enter an ASI domain (restricted address space) and begin the critical section. */
> +void asi_enter(struct asi *asi);
> +
> +/*
> + * Leave the "tense" state if we are in it, i.e. end the critical section. We
> + * will stay relaxed until the next asi_enter.
> + */
> +void asi_relax(void);
> +
> +/* Immediately exit the restricted address space if in it */
> +void asi_exit(void);
> +
> +/* The target is the domain we'll enter when returning to process context. */
> +static __always_inline struct asi *asi_get_target(struct task_struct *p)
> +{
> +	return p->thread.asi_state.target;
> +}
> +
> +static __always_inline void asi_set_target(struct task_struct *p,
> +					   struct asi *target)
> +{
> +	p->thread.asi_state.target = target;
> +}
> +
> +static __always_inline struct asi *asi_get_current(void)
> +{
> +	return this_cpu_read(curr_asi);
> +}
> +
> +/* Are we currently in a restricted address space? */
> +static __always_inline bool asi_is_restricted(void)
> +{
> +	return (bool)asi_get_current();
> +}
> +
> +/* If we exit/have exited, can we stay that way until the next asi_enter? */
> +static __always_inline bool asi_is_relaxed(void)
> +{
> +	return !asi_get_target(current);
> +}
> +
> +/*
> + * Is the current task in the critical section?
> + *
> + * This is just the inverse of !asi_is_relaxed(). We have both functions in order to
> + * help write intuitive client code. In particular, asi_is_tense returns false
> + * when ASI is disabled, which is judged to make user code more obvious.
> + */
> +static __always_inline bool asi_is_tense(void)
> +{
> +	return !asi_is_relaxed();
> +}

So can we tone down the silly helpers above? You don't really need
asi_is_tense() for example. It is still very intuitive if I read

	if (!asi_is_relaxed())

...

> +
> +static __always_inline pgd_t *asi_pgd(struct asi *asi)
> +{
> +	return asi ? asi->pgd : NULL;
> +}
> +
> +#define INIT_MM_ASI(init_mm) \
> +	.asi_init_lock = __MUTEX_INITIALIZER(init_mm.asi_init_lock),
> +
> +void asi_handle_switch_mm(void);
> +
> +#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
> +
> +#endif

Splitting the patch here and will continue with the next one as this one is
kinda big for one mail.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

