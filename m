Return-Path: <linux-arch+bounces-9819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F334A16B54
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AD0169BA2
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954C1DF273;
	Mon, 20 Jan 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbfAo8lf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAA1DF251;
	Mon, 20 Jan 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371733; cv=none; b=RSREJX7H+d58Wj45ZlJk1Roif0iVT+uz1I4FThnygLUoVvrep2+J3o/GsCz8RyAxfnDl90GufOBLXfk/oTkWjVkze+hAuYXUAzuv3IK4N+4u2uE26VFqVhLkW+EfqBfxNPIWhji6LWVEyUYLCY+KZFROOBemYjXKoCV1Ddw37HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371733; c=relaxed/simple;
	bh=GjQy4x7GXESlbgIr3leMmaCtLptNcAfWQxkR/MaBTck=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC615/Suv6NeEQXbi/FJQyP/Aws+Co5hGKORaHnhHssX6ywcKMr1XCOf3NlbSN6zgMzX/+vlOnTPxcjOHRDKTtFGisQZlx8afJSFwqhX8H0JeRKO1xeYVcgvcLUaLpAiZg4kfBpyM3Xy8EjuEJ09hWMW1wrpWDEzO1HpSM1q1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbfAo8lf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5439e331cceso2621889e87.1;
        Mon, 20 Jan 2025 03:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737371729; x=1737976529; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2GVkq9tRDCkhxRDT/CBStGfoQ0If4+e8Z0FyGDV8QRs=;
        b=RbfAo8lfbwMVcCpiq0tb2FsTRUGzh8U4gJ3cQ52oxJ6LPXABl/7O/jKPMabkUGq4sG
         WQ6Qir6qEj9CDXLCLsHxLhVNTgG6+RY0Z8J/AEAOwUxYv5ILoUHtZ/z72/WF2Z9qcU8d
         ahY7YB+WGusP2oyyH6pqiXLOdYB5q2ORRf9oRvoh+Sl6ihMIOAuw9cVjDM6IeSccJTh3
         UeQz62zihvdsUdpf3jDymCidrkvdOXgZ9a7/2f1zaK2EYykcgQlMGYgvS8dlpPkgZv+w
         dHjWXg9tloWJp2kIbd9WrsVnbmNrIAXh0p9bq4ewb5l3HoT5xMa1+AGQmavJUxJ+PKCC
         Jwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737371729; x=1737976529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GVkq9tRDCkhxRDT/CBStGfoQ0If4+e8Z0FyGDV8QRs=;
        b=Bw2N+aIxhWo4oBP30iiCUau9bzFgWXAt9ypemi0C37/kNMb//bKjNivaN2oGma12xk
         Z1wRbfWtOkRVc48Xm+agdigv8nUmzvozfGL76U2ZoY+xunC4jawHVw38igNtanSmMBWu
         wGSa2HeoLVVNPybboaryr6uZZ0p93oPbGF9MM5pPwDgBUfuJhdc8A9gefQKS7mVByiiR
         Odo4Lcb1n2/udKbj+0ztMmFGcUqqpLYdQhWIKvdnPfLWGWHeXorVJdnfdnYCQ08p7vKN
         IWLAjJBlX6o0LH+E++8pF2vgxQaaxamtmgie362NZBeXeAtXfHtZrFwivwzc3//4uMWc
         P6kg==
X-Forwarded-Encrypted: i=1; AJvYcCUO/JVQz3GLWAz8BaVVangrjGHasXn5/OLh2HR7LlMIje1SQX6ZWPncYpb23dtrgsPmB6NH@vger.kernel.org, AJvYcCVEMivwmU97tHxhD/fpuyvA3263COvMNztjoNh6LKnuShf7Y4CIL9JXE2LUcOQIry2TsO2L@vger.kernel.org, AJvYcCVIJfS0tT8LkYJD0C3HjyAsL0AlA3JLb1ZENG3ukoKix06PwGIiH0+QXJ/LTbL+NsX7Vkky3FaehfDiPBBc@vger.kernel.org, AJvYcCVxniCfL/fmXafo/8H7/EZvMi4+fHZMaln2+Wd+vfSeHaJu3Gtk3qCnYxIzIHKwBnfs5L4=@vger.kernel.org, AJvYcCWoFFpuD+Gn1zZSOkh9fqjJaiapr8SQo2m3bdNuW3gMAUOqICSsAO3pvGUfWehbj5x7/1Z7hfvbBZzmdg==@vger.kernel.org, AJvYcCX+2aEYU4WaLT+eFZOP/Ni50CUalXzmd5wXYnIvNcfXVYFvh6rBeEPoG/ljHDYN/rAJQFP6HZS+GArqekC65bUc@vger.kernel.org, AJvYcCX0VOMemCqRDAOuR+6nXvtiE7x0+h9LJyEdeFciGY6qCZhFq6BZAqFbTKjWqs4qhdWU7Jz6Y3puiqY0BulQIp1kCw==@vger.kernel.org, AJvYcCXYM5ct4b5dM21CS9Cxsq/wSuurtHMUBZ28vS8O1/HPYEjYA9zNM/wb+dF7P6ejQNbMtsR372+barAxjDRqAOWF@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVuDqXSbDRO4SJsSsMHaGJHaQkJLJ++yXv7er9tVnwFg9JHtb
	toHX18pci+nUvhxB0rVwD+/9vDFdmjxo34Cx60n3I9HkvHdEO4lc
X-Gm-Gg: ASbGncvzlE2+Bu8GkWzcjOsL+NHnMXrRur68L6pYJGZiQ1A2hMIo5Euk768ZokvErKM
	hfwEZhYTHGMx7VG7Fyx8NLPRCgvDedNgI80iLgRhXMID8tgmO6Yt0UekHM97Ds85Oe0g1YJkm/U
	+v6ShUSRd4sdNGT8w6lNR1dEE15Xmd9l6jgIVIkEbrFBZ+o7KQ/feSxZG44XBWSvrEg9opMIgd+
	nJHI8NDHq+wlsT2S9Ymnuxiahv1PWW1tRqcBZT3DK37AswXSHWRzIsADQi6TsCldDPwR4Ta9dNX
	XuDt7C1o8nx4RPFWpnLY6ykB
X-Google-Smtp-Source: AGHT+IHKV/b4OpTja4V+3bSeLRqiI1pV4ugkz/2qcipp1USPLcCJuF4RKlBH/zOnSXkuGgwcoGAG8A==
X-Received: by 2002:ac2:4155:0:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-5439c216c23mr3426183e87.5.1737371729069;
        Mon, 20 Jan 2025 03:15:29 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af60936sm1298036e87.107.2025.01.20.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:15:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 20 Jan 2025 12:15:20 +0100
To: Valentin Schneider <vschneid@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
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
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
Message-ID: <Z44wSJTXknQVKWb0@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Jan 17, 2025 at 06:00:30PM +0100, Valentin Schneider wrote:
> On 17/01/25 17:11, Uladzislau Rezki wrote:
> > On Fri, Jan 17, 2025 at 04:25:45PM +0100, Valentin Schneider wrote:
> >> On 14/01/25 19:16, Jann Horn wrote:
> >> > On Tue, Jan 14, 2025 at 6:51 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >> >> vunmap()'s issued from housekeeping CPUs are a relatively common source of
> >> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> >> >> flush_tlb_kernel_range() IPIs.
> >> >>
> >> >> Given that CPUs executing in userspace do not access data in the vmalloc
> >> >> range, these IPIs could be deferred until their next kernel entry.
> >> >>
> >> >> Deferral vs early entry danger zone
> >> >> ===================================
> >> >>
> >> >> This requires a guarantee that nothing in the vmalloc range can be vunmap'd
> >> >> and then accessed in early entry code.
> >> >
> >> > In other words, it needs a guarantee that no vmalloc allocations that
> >> > have been created in the vmalloc region while the CPU was idle can
> >> > then be accessed during early entry, right?
> >>
> >> I'm not sure if that would be a problem (not an mm expert, please do
> >> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> >> deferred anyway.
> >>
> >> So after vmapping something, I wouldn't expect isolated CPUs to have
> >> invalid TLB entries for the newly vmapped page.
> >>
> >> However, upon vunmap'ing something, the TLB flush is deferred, and thus
> >> stale TLB entries can and will remain on isolated CPUs, up until they
> >> execute the deferred flush themselves (IOW for the entire duration of the
> >> "danger zone").
> >>
> >> Does that make sense?
> >>
> > Probably i am missing something and need to have a look at your patches,
> > but how do you guarantee that no-one map same are that you defer for TLB
> > flushing?
> >
> 
> That's the cool part: I don't :')
> 
Indeed, sounds unsafe :) Then we just do not need to free areas.

> For deferring instruction patching IPIs, I (well Josh really) managed to
> get instrumentation to back me up and catch any problematic area.
> 
> I looked into getting something similar for vmalloc region access in
> .noinstr code, but I didn't get anywhere. I even tried using emulated
> watchpoints on QEMU to watch the whole vmalloc range, but that went about
> as well as you could expect.
> 
> That left me with staring at code. AFAICT the only vmap'd thing that is
> accessed during early entry is the task stack (CONFIG_VMAP_STACK), which
> itself cannot be freed until the task exits - thus can't be subject to
> invalidation when a task is entering kernelspace.
> 
> If you have any tracing/instrumentation suggestions, I'm all ears (eyes?).
> 
As noted before, we defer flushing for vmalloc. We have a lazy-threshold
which can be exposed(if you need it) over sysfs for tuning. So, we can add it.

--
Uladzislau Rezki

