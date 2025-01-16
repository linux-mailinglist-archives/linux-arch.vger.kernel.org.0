Return-Path: <linux-arch+bounces-9793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D7A12F8E
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2025 01:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF0D3A5A30
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2025 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B9A94A;
	Thu, 16 Jan 2025 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J4tKA2z9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6117991;
	Thu, 16 Jan 2025 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736986918; cv=none; b=eX94l3yaVeNk6hI+KbxmbJM0TcqHzEQSVZncL7CUTGS7fyF+ir+Mg1Q8KjI97/skJuzWZPEb+lSBrfXmmi+r+ha9oaEskVl3afsSprpK7WhANkSB8SF0U306XZQ/v13O/H+uf+9fM8vRpCoqB2U3jNLVRD9nvb6Awa8r86mYdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736986918; c=relaxed/simple;
	bh=CnVEtvm6r0FK1c66L6L7ntFsmh6oSuFSfI8+wFyyIis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og/iiOTZmfQRvncJEDafE6drCBB9PlLG6Tr5fHi55vwpszlqP3mdXYsVujcDNLc4fv5w73mVWIzg6262dxTm8snjjwzl0z/9SqzEcLH3XNkGAJGdMQHN2g1r0xJRIL1h/3DpgxS0TaOp7UJQcTqH/faiFCtmgdUSlxjPY14dts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J4tKA2z9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C56940E016C;
	Thu, 16 Jan 2025 00:21:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VbKRelzzy0f1; Thu, 16 Jan 2025 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736986908; bh=sf+0ox9qps9OCdNOEgrNakgxyzYQCzMyDXp9Teo1SPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4tKA2z9c1dX6/H2/3UFIDVILO8xBwPl1TEyUVQC4DlsQu0QI4LpBFQsTv6iHdtZ2
	 p9YzSu1IhOTiU08BN0L2M0PecKjs22CleittrM2qBO2cPFFy2HJaYp5I0uY6OZRukR
	 zozlAlfCzmYK6zA6a7rnwMrIQ0b9nW+RolLTUFHyU+pjU2cgIrmrHLhc5fWiU93M7s
	 2LkZr/YbbEmZFQD4jIKQDyVrDvGkXqUQxr/6r6ASqtjZeCHNBw03OzcKbqcsL4Zf7y
	 r1sNh+hwC4E+Sr34rsrK2zYDvzgRcnP4r3tkiHo/VN5TYvqIp98CXQqbLfpwJEbhX6
	 LaT6JfdqWRw5QyxhDfkiFjx/XLr9NsYyJlC7ZF0t4iyxrgh9cNrQSodGzZq46p9SyW
	 +WsaNZgJgyJuKoQeomDMVOTWzfADMeQN5FYTZwJH0fqluCcbXDu1gyb+MVca8Gq90k
	 llpN+og3N+QW/Z2lzB9EkrkOeRj43toNWqIzt56gvuiATFuUMDYR70QV3oeogpE80D
	 afkT8idhQsUhKtFR8pKG/nJdJsboyyBxDAYqoVUea/m1agSvHxOA/qykF1MomKo6Rn
	 83v/tkyRaK2qlfWRqxNzTUP0WyMRLSCK9+KBi9ZUGMvUEoc5K77pSKK9g5j/jP4qjT
	 q2Tju1YxL09ppY+Av5Rr7RuI=
Received: from zn.tnic (p200300eA971f93c3329C23fFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93c3:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7299840E0277;
	Thu, 16 Jan 2025 00:19:07 +0000 (UTC)
Date: Thu, 16 Jan 2025 01:18:58 +0100
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
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/29] mm: asi: Make some utility functions
 noinstr compatible
Message-ID: <20250116001858.GDZ4hQctZe_PFvJ0AJ@fat_crate.local>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-1-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110-asi-rfc-v2-v2-1-8419288bc805@google.com>

On Fri, Jan 10, 2025 at 06:40:27PM +0000, Brendan Jackman wrote:
> Subject: Re: [PATCH RFC v2 01/29] mm: asi: Make some utility functions noinstr compatible

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

So I guess "x86/asm:" or so.

> Some existing utility functions would need to be called from a noinstr
> context in the later patches. So mark these as either noinstr or
> __always_inline.
> 
> An earlier version of this by Junaid had a macro that was intended to
> tell the compiler "either inline this function, or call it in the
> noinstr section", which basically boiled down to:
> 
>  #define inline_or_noinstr noinline __section(".noinstr.text")
> 
> Unfortunately Thomas pointed out this will prevent the function from
> being inlined at call sites in .text.
> 
> So far I haven't been able[1] to find a formulation that lets us :
> 1. avoid calls from .noinstr.text -> .text,
> 2. while also letting the compiler freely decide what to inline.
> 
> 1 is a functional requirement so here I'm just giving up on 2. Existing
> callsites of this code are just forced inline. For the incoming code
> that needs to call it from noinstr, they will be out-of-line calls.

I'm not sure some of that belongs in the commit message - if you want to have
it in the submission, you should put it under the --- line below, right above
the diffstat.

> [1] https://lore.kernel.org/lkml/CA+i-1C1z35M8wA_4AwMq7--c1OgjNoLGTkn4+Td5gKg7QQAzWw@mail.gmail.com/
> 
> Checkpatch-args: --ignore=COMMIT_LOG_LONG_LINE

Yeah, you can drop those. People should not turn off brain, use checkpatch and
point at all the silly errors it spits anyway.

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/include/asm/processor.h     |  2 +-
>  arch/x86/include/asm/special_insns.h |  8 ++++----
>  arch/x86/include/asm/tlbflush.h      |  3 +++
>  arch/x86/mm/tlb.c                    | 13 +++++++++----
>  4 files changed, 17 insertions(+), 9 deletions(-)

So I was just about to look at the below diff but then booting the patch in my
guest causes it to stop at:

[    1.110988] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    1.114210] PM: Image not found (code -22)
[    1.114903] clk: Disabling unused clocks
[    1.119397] EXT4-fs (sda2): mounted filesystem 90868bc4-a017-4fa2-ac81-931ba260346f ro with ordered data mode. Quota mode: disabled.
[    1.121069] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
<--- EOF

with the below call stack.

Booting it on Linus' master branch is ok but this is tip/master with all that
we've accumulated for the next merge window along with other stuff I'm poking
at...

Long story short, lemme try to poke around tomorrow to try to figure out what
actually happens. It could be caused by the part of Rik's patches and this one
inlining things. We'll see...

native_flush_tlb_one_user (addr=2507219558400) at arch/x86/mm/tlb.c:1177
1177            if (!static_cpu_has(X86_FEATURE_PTI))
(gdb) bt
#0  native_flush_tlb_one_user (addr=2507219558400) at arch/x86/mm/tlb.c:1177
#1  0xffffffff8128206e in flush_tlb_one_user (addr=addr@entry=2507219558400) at arch/x86/mm/tlb.c:1196
#2  flush_tlb_one_kernel (addr=addr@entry=2507219558400) at arch/x86/mm/tlb.c:1151
#3  0xffffffff812820b7 in do_kernel_range_flush (info=0xffff88807dc311c0) at arch/x86/mm/tlb.c:1092
#4  0xffffffff8137beb6 in csd_do_func (csd=0x0 <fixed_percpu_data>, info=0xffff88807dc311c0, 
    func=0xffffffff81282090 <do_kernel_range_flush>) at kernel/smp.c:134
#5  smp_call_function_many_cond (mask=<optimized out>, func=func@entry=0xffffffff81282090 <do_kernel_range_flush>, 
    info=0xffff88807dc311c0, scf_flags=scf_flags@entry=3, cond_func=cond_func@entry=0x0 <fixed_percpu_data>)
    at kernel/smp.c:876
#6  0xffffffff8137c254 in on_each_cpu_cond_mask (cond_func=cond_func@entry=0x0 <fixed_percpu_data>, 
    func=func@entry=0xffffffff81282090 <do_kernel_range_flush>, info=<optimized out>, wait=wait@entry=true, 
    mask=<optimized out>) at kernel/smp.c:1052
#7  0xffffffff81282020 in on_each_cpu (wait=1, info=<optimized out>, func=0xffffffff81282090 <do_kernel_range_flush>)
    at ./include/linux/smp.h:71
#8  flush_tlb_kernel_range (start=start@entry=18446683600570097664, end=<optimized out>, end@entry=18446683600579907584)
    at arch/x86/mm/tlb.c:1106
#9  0xffffffff81481c3f in __purge_vmap_area_lazy (start=18446683600570097664, start@entry=18446744073709551615, 
    end=18446683600579907584, end@entry=0, full_pool_decay=full_pool_decay@entry=false) at mm/vmalloc.c:2284
#10 0xffffffff81481fde in _vm_unmap_aliases (start=start@entry=18446744073709551615, end=end@entry=0, 
    flush=<optimized out>, flush@entry=0) at mm/vmalloc.c:2899
#11 0xffffffff81482049 in vm_unmap_aliases () at mm/vmalloc.c:2922
#12 0xffffffff81284d9f in change_page_attr_set_clr (addr=0xffffc9000001fef0, numpages=<optimized out>, mask_set=..., 
    mask_clr=..., force_split=<optimized out>, in_flag=0, pages=0x0 <fixed_percpu_data>)
    at arch/x86/mm/pat/set_memory.c:1881
#13 0xffffffff81285c52 in change_page_attr_set (array=0, mask=..., numpages=511, addr=0xffffc9000001fef0)
    at arch/x86/mm/pat/set_memory.c:1922
#14 set_memory_nx (addr=<optimized out>, addr@entry=18446744071759204352, numpages=numpages@entry=511)
    at arch/x86/mm/pat/set_memory.c:2110
#15 0xffffffff8127b729 in free_init_pages (what=what@entry=0xffffffff8226bac0 "unused decrypted", 
    begin=18446744071759204352, end=18446744071761297408) at arch/x86/mm/init.c:929
#16 0xffffffff898f25aa in mem_encrypt_free_decrypted_mem () at arch/x86/mm/mem_encrypt_amd.c:574
#17 0xffffffff81ca06c3 in free_initmem () at arch/x86/mm/init.c:973
#18 0xffffffff81c9fa48 in kernel_init (unused=<optimized out>) at init/main.c:1475
#19 0xffffffff812398a0 in ret_from_fork (prev=<optimized out>, regs=0xffffc9000001ff58, 
    fn=0xffffffff81c9fa10 <kernel_init>, fn_arg=0x0 <fixed_percpu_data>) at arch/x86/kernel/process.c:148
#20 0xffffffff81206f7a in ret_from_fork_asm () at arch/x86/entry/entry_64.S:244
#21 0x1f0f2e6600000000 in ?? ()
#22 0x2e66000000000084 in ?? ()
#23 0x0000000000841f0f in ?? ()
#24 0x000000841f0f2e66 in ?? ()
#25 0x00841f0f2e660000 in ?? ()
#26 0x1f0f2e6600000000 in ?? ()
#27 0x2e66000000000084 in ?? ()
#28 0x0000000000841f0f in ?? ()
#29 0x000000841f0f2e66 in ?? ()
#30 0x00841f0f2e660000 in ?? ()
#31 0x0000000000000000 in ?? ()
(gdb)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

