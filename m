Return-Path: <linux-arch+bounces-9809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B86A1533C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF67A39E5
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708A19ABC3;
	Fri, 17 Jan 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpGqLvBn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705019AD93
	for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129180; cv=none; b=l4VWhDgIEJMjzJC3CfeayHMqFROWX63ecrj5lgffZwQnaRNLqjuoijAQ+6LYN6aEdSoK/scwoGQiAcgYh0LLEY1OPaDY12n0Me/jzTyPP6wkpi1irJ+Ldf+GgtM2qlJumcEJ/DNIuM/izaeIm3w4MUwLJbkZ3FvalclTykBmPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129180; c=relaxed/simple;
	bh=E7d+TpfXp3p6m5vGusLumGYBM9vV8hEetyox2i/2Tk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGEKjZ5mZRwAEAk62SIquKeUEJjSHaCrK+vOA1xsFVUdmHfMLOiHv/4R6QDhRXhgJqzqE+kb1yG/eiWdgsIavyQtwqchGfOkO9OT1aKz85ACgKwLuCveIrbGb/boy+pSjO8Q2B3339M4KH/kDLGXrpR2SVPV9xG3NcTrAKsEO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpGqLvBn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so9569a12.0
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2025 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737129176; x=1737733976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7d+TpfXp3p6m5vGusLumGYBM9vV8hEetyox2i/2Tk8=;
        b=mpGqLvBniVqxo77vfpJUti5+g+eBQMghQtwoA7cF331WeBcYbaNHa/0Apt7RaciHOt
         /ckZLqTt5IsP4hkw8MdqGv71PrORwCjtz07dDwHT5XtIP1WSXivZFw5I69VeeqOfcQF3
         ybe6UQGUK1sRDw7mWfl8g5yJZjAV4KfLbPCbsnEvoY2Is2Ir/+knCLlW/+DsbpZp+F67
         1YFefnkJmOsddMASB3if29JAVOaoojUkTxLWZBjkgUI3ScVoKgbxbMxoYS341oH/wb1u
         zde5v0gHpoYfKEPKNScMJekd0S1tXfitnEzMT2pHzwhXP/omYZPS3FKjadRdLXhf/Z61
         8+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129176; x=1737733976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7d+TpfXp3p6m5vGusLumGYBM9vV8hEetyox2i/2Tk8=;
        b=CfXtHADZH/peojTPCvNFcVZOnnhKuQrF8kr2tZEcLbsq2GViKvwJoYSs51tftzclNV
         TlA7AuEHs69gv272Pgh7DvLMjY40/aTe+CtrGxe3P0GFwB55jZxQ9/h8r1LkUVfRpM8l
         /gL5R6co/+wZeEfa8DvzjfNJqDqnWouTBbvfrBxZUtN2Aq0IDL2ByMFmSmq79AGJ5m1x
         QQrO8KVDD65CjQzb9mhvjQnNzQpY4Gd4mS/P659tlLA2rBFgW60Yy2XbTSU7MNaOMQaO
         lGc3+HEceuqOTd4gLdV4qa7O424BrTGS6reS4cpuVrQKXmAetkeDj4n3CWsisTPYgWCy
         uZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCXhQ93gD92t3WX9q8yECAO78IjbSWUltQiAiV0typwCrptj/mxF1g0Pn1Z595tnbQx1AaF73uF3mNNW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgju0drd31BNrGU8Weq2tzohnKAkbfiE54Ezf4aqk5K9qL6dde
	FqoGWyR8PyJeAOAQr/6uBMhv11xil+jP3v9wwv7qOWoi5zZy77Y0g1Hyv3F7bRvRduN2+te/Ojw
	UuixGMMmXmeE1FOE0Tb64uDUu6HLZ6JHSTzkS
X-Gm-Gg: ASbGnct/pMnR6d0pWGl/NtC12sl1M+CnVJyiv3csP7fhqZROuKIzBheEmo6FdPh6Gan
	LsFA2/J8WrNM8T1t4uN/FqPmRCX+V/qHKliKixoAxV1EuhZpGwUjFdvKvqHIFle17TQ==
X-Google-Smtp-Source: AGHT+IEEkI7Iy2SK9FPAK0t7gLelF/8kGvCq2TFqgDI01h52pfAV4lOJlwJrdbZvw3hEJ10c/9do3FNZA9vfJuC5wNY=
X-Received: by 2002:a50:8e10:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5db7e2c3f9dmr75503a12.1.1737129175787; Fri, 17 Jan 2025
 07:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com> <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Jann Horn <jannh@google.com>
Date: Fri, 17 Jan 2025 16:52:19 +0100
X-Gm-Features: AbW1kvZJ0qyEwdtkrx_UmrEU0O4aMmTblOKPsNQ-aUYqHdGS_cvMGi3arE1PehU
Message-ID: <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range()
 targeting NOHZ_FULL CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 4:25=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> On 14/01/25 19:16, Jann Horn wrote:
> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@re=
dhat.com> wrote:
> >> vunmap()'s issued from housekeeping CPUs are a relatively common sourc=
e of
> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> >> flush_tlb_kernel_range() IPIs.
> >>
> >> Given that CPUs executing in userspace do not access data in the vmall=
oc
> >> range, these IPIs could be deferred until their next kernel entry.
> >>
> >> Deferral vs early entry danger zone
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This requires a guarantee that nothing in the vmalloc range can be vun=
map'd
> >> and then accessed in early entry code.
> >
> > In other words, it needs a guarantee that no vmalloc allocations that
> > have been created in the vmalloc region while the CPU was idle can
> > then be accessed during early entry, right?
>
> I'm not sure if that would be a problem (not an mm expert, please do
> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> deferred anyway.

flush_cache_vmap() is about stuff like flushing data caches on
architectures with virtually indexed caches; that doesn't do TLB
maintenance. When you look for its definition on x86 or arm64, you'll
see that they use the generic implementation which is simply an empty
inline function.

> So after vmapping something, I wouldn't expect isolated CPUs to have
> invalid TLB entries for the newly vmapped page.
>
> However, upon vunmap'ing something, the TLB flush is deferred, and thus
> stale TLB entries can and will remain on isolated CPUs, up until they
> execute the deferred flush themselves (IOW for the entire duration of the
> "danger zone").
>
> Does that make sense?

The design idea wrt TLB flushes in the vmap code is that you don't do
TLB flushes when you unmap stuff or when you map stuff, because doing
TLB flushes across the entire system on every vmap/vunmap would be a
bit costly; instead you just do batched TLB flushes in between, in
__purge_vmap_area_lazy().

In other words, the basic idea is that you can keep calling vmap() and
vunmap() a bunch of times without ever doing TLB flushes until you run
out of virtual memory in the vmap region; then you do one big TLB
flush, and afterwards you can reuse the free virtual address space for
new allocations again.

So if you "defer" that batched TLB flush for CPUs that are not
currently running in the kernel, I think the consequence is that those
CPUs may end up with incoherent TLB state after a reallocation of the
virtual address space.

Actually, I think this would mean that your optimization is disallowed
at least on arm64 - I'm not sure about the exact wording, but arm64
has a "break before make" rule that forbids conflicting writable
address translations or something like that.

(I said "until you run out of virtual memory in the vmap region", but
that's not actually true - see the comment above lazy_max_pages() for
an explanation of the actual heuristic. You might be able to tune that
a bit if you'd be significantly happier with less frequent
interruptions, or something along those lines.)

