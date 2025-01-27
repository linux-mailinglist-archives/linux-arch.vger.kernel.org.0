Return-Path: <linux-arch+bounces-9917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277BA1D9EE
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6453F188896B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC31487F8;
	Mon, 27 Jan 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opi/ZOMV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900915D5C4;
	Mon, 27 Jan 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993125; cv=none; b=Yaixk2NT9g8JS+nz72wMIxpyoC41XThvZ1riCIksfXTtYLysSA3UrwSnQ9sWF0sHTwwS8wWOeWVqWQen2NztrCCfsLfCdgHNHMY4H5rsCkVvwW9iznH5ErGFppww+Q5Da+hytEGb2XF9MlAhdTCx+rDplukRrloFRxIriOjKrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993125; c=relaxed/simple;
	bh=lKShl/TiOp2ZoXo/jImChQXPJ2hMZLXx2pOut7WiptI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLKFJfUHVX4VaBF+Z2eMkHiaDRNcIR6mJIyT/JNL2m+bKkJMX3TblJtnnT54DblrKEvsX15pyDWE7kuIM35u8d4bjeX9e5pNGzLZ5ZEwTbUfkvo6RkcRoGtXuaRz0+LgTNClx5GXD3odvjFt/caxe4wrmdUclmbHwsiKuLhffKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opi/ZOMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87519C4CED2;
	Mon, 27 Jan 2025 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737993124;
	bh=lKShl/TiOp2ZoXo/jImChQXPJ2hMZLXx2pOut7WiptI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Opi/ZOMV/zfLovkaRrjcFN22SaJmB+XJGtnDJ/cIoGIjT25SkYRyAorU+UjcclWyd
	 6DePEaUZ/QK4W0yHLc5Kb3ieU/uOi+zRZdhIrfh5zorrG9bSfVDQc9h0dR9gO+3bHq
	 ul1VD9PJ3iJuekF+lfnqBztVCR/WhUeMwXxaqNSwUyFJREhVmoO8Vtntzw4FAiTB00
	 00OvDbjpP1jbVZyUSglO9BK2uxJ3fZYicWL3MsWiS1eDM68OxCFUf3tPPbIQwtET/k
	 cGteI6qIszlohfI51re4Bs3hb3htIsly4LrqymlfAEdhSawB5JdAEcLJmnZm2zRPZn
	 N7W92SLp2WhHA==
Date: Mon, 27 Jan 2025 15:51:47 +0000
From: Will Deacon <will@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Message-ID: <20250127155146.GB25757@willie-the-truck>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 17, 2025 at 04:52:19PM +0100, Jann Horn wrote:
> On Fri, Jan 17, 2025 at 4:25 PM Valentin Schneider <vschneid@redhat.com> wrote:
> > On 14/01/25 19:16, Jann Horn wrote:
> > > On Tue, Jan 14, 2025 at 6:51 PM Valentin Schneider <vschneid@redhat.com> wrote:
> > >> vunmap()'s issued from housekeeping CPUs are a relatively common source of
> > >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> > >> flush_tlb_kernel_range() IPIs.
> > >>
> > >> Given that CPUs executing in userspace do not access data in the vmalloc
> > >> range, these IPIs could be deferred until their next kernel entry.
> > >>
> > >> Deferral vs early entry danger zone
> > >> ===================================
> > >>
> > >> This requires a guarantee that nothing in the vmalloc range can be vunmap'd
> > >> and then accessed in early entry code.
> > >
> > > In other words, it needs a guarantee that no vmalloc allocations that
> > > have been created in the vmalloc region while the CPU was idle can
> > > then be accessed during early entry, right?
> >
> > I'm not sure if that would be a problem (not an mm expert, please do
> > correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> > deferred anyway.
> 
> flush_cache_vmap() is about stuff like flushing data caches on
> architectures with virtually indexed caches; that doesn't do TLB
> maintenance. When you look for its definition on x86 or arm64, you'll
> see that they use the generic implementation which is simply an empty
> inline function.
> 
> > So after vmapping something, I wouldn't expect isolated CPUs to have
> > invalid TLB entries for the newly vmapped page.
> >
> > However, upon vunmap'ing something, the TLB flush is deferred, and thus
> > stale TLB entries can and will remain on isolated CPUs, up until they
> > execute the deferred flush themselves (IOW for the entire duration of the
> > "danger zone").
> >
> > Does that make sense?
> 
> The design idea wrt TLB flushes in the vmap code is that you don't do
> TLB flushes when you unmap stuff or when you map stuff, because doing
> TLB flushes across the entire system on every vmap/vunmap would be a
> bit costly; instead you just do batched TLB flushes in between, in
> __purge_vmap_area_lazy().
> 
> In other words, the basic idea is that you can keep calling vmap() and
> vunmap() a bunch of times without ever doing TLB flushes until you run
> out of virtual memory in the vmap region; then you do one big TLB
> flush, and afterwards you can reuse the free virtual address space for
> new allocations again.
> 
> So if you "defer" that batched TLB flush for CPUs that are not
> currently running in the kernel, I think the consequence is that those
> CPUs may end up with incoherent TLB state after a reallocation of the
> virtual address space.
> 
> Actually, I think this would mean that your optimization is disallowed
> at least on arm64 - I'm not sure about the exact wording, but arm64
> has a "break before make" rule that forbids conflicting writable
> address translations or something like that.

Yes, that would definitely be a problem. There's also the more obvious
issue that the CnP ("Common not Private") feature of some Arm CPUs means
that TLB entries can be shared between cores, so the whole idea of using
a CPU's exception level to predicate invalidation is flawed on such a
system.

Will

