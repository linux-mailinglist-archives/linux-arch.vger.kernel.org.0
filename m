Return-Path: <linux-arch+bounces-9810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE1A153DF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28C81889A22
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C619CCEC;
	Fri, 17 Jan 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIyLfqKO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4719C56D;
	Fri, 17 Jan 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130301; cv=none; b=uLB1UFSq8AK2heCzhXaTIm1rJGWHKI8Fv/3ZAS/PiYntToZSKe+mrwEfI2Mlwk8I2ChiWAgFVidhLRk2BGD4xyKdupos1LfMBfxempqLlEZB2V58vqxkvemhCPpxhLQcdMFs8Rw4NsjQR4D8goAZLp7+2Ms7rmYZp9ra5WagKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130301; c=relaxed/simple;
	bh=J+c0tdWpIHr0KlbOLBzEFr0vBExsTwyn4LFfRX4AfIk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsYQEGA4lQ/dnz9J78njIpDzX9CUpxPhk9WMkcEdt6XIoJ1Xj4gSmg7DLx9C2x1qpKRQBbuHJSJWVCu3B23IgX4ry5kAFi8JF5JRzA5gjvhpm8T+5//RhAnsgBsSFFZqhC29GIYTkh3B+fn/2kWmvgUPnLRyUfJ/VMqOj7PvPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIyLfqKO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3022484d4e4so21922211fa.1;
        Fri, 17 Jan 2025 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130297; x=1737735097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mwf/8xvajfVfuiw0AKepwMJBFKP0lwWuKM/onBPK6d8=;
        b=YIyLfqKO1w01qo4BK1cb7TU/xUkmTl45xJ0GMxOmqkN2Wen8zQTg+bhv3ZeeHT25U7
         7O5IjAJMlWs3/YdLj06FIn05Dzk0zu7zgUVx7ua/pkNct9ifmmlgJ+Zl4Td0GubyKlbi
         pQhKOiOodVIlqDij7mnP/U1hL/b48G8olQkTLCG0cI6Gl+VfwY/pnszQx+jKt0SEyf2C
         dXGsR7jVuLXY0pun1yEaKRTUEnoUBqELV/+h+lepc65AZf0Tv773eeNcZQHhPX7grd32
         hdfn4KYMTb386Sa3gQrM3da+MY7bFq+0jVuonfNnMyI24U/w26W0HzN/gON8GR3o0sTY
         /lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130297; x=1737735097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwf/8xvajfVfuiw0AKepwMJBFKP0lwWuKM/onBPK6d8=;
        b=XrqquKPIkl0V6AWxmuoH4Br0q2h8D7YBWuUZzeGXvafyniy4pgX/AojwrybKV+ELym
         lEyHsbWAEl01s3ZFmyrF9vkoT9pP1QhC9eoqVfBdBzoviuTFU8W6rR8s4PqLWFZfyXJq
         batrzUmKrM9oiBYGmy5zG7R2n4/wdhaEJkrcJ1Jo2oIBEm+6afWusQhiTRvUbzvWjx0H
         RCSJ01mc+QIAfQq87GMelwyV4zfhkRmdNMMmdm3Q/BjRD94v3ZNb5iH6UnNWhbQL1eIH
         Ub16OtwMZwONS+1kUPBVYjlQnYSEfNxU+N6bh1tU+GgKuKulP10XlswltvZKDG8MoO7G
         Wbqg==
X-Forwarded-Encrypted: i=1; AJvYcCU/fLWuoidPz8cVBtwKS6KxXM1v6JLqam4lfJ657h2zvZiNhOD8xHGn42cvcBpWAF+U7DRvP79J/yQDfw==@vger.kernel.org, AJvYcCU8//FFn0GFAVyPXd5Yykj7vDil6Sc9xWAmeBtEHTjFmJeZldHIadyATDGGshmEgiwaUV+y@vger.kernel.org, AJvYcCUkdKOoNinnv+xRTrrRPBUsxnfmgJUrWS5gwxJuynMsYqOI1wcA1hkldij+KbnMKMuMxaR+Ny2+3kwc0YySV1n7@vger.kernel.org, AJvYcCUl0MDFfyKHU8vjqxWqL9BQMQ+r+/b1tPSUffnNDqFJBvbWjZFy+gIGtDhdphjOfE5iyPfF@vger.kernel.org, AJvYcCVRcF7cJYinXm5Leb3yprFu56a0xEtColtOENPXeXq14sGWKj9MvUV5WJG/K3GRNuJ3xK8=@vger.kernel.org, AJvYcCVi25GCqJjYFdI7HjgDZ4mkWukstFgnHFBBwB05LiVXNIsDd4ogTAYNHf8oztdyipWwS5GT+y2LY4ogw9Pk@vger.kernel.org, AJvYcCWbMFyM5uPi8lIkxgGVVXGQ0rHG07cxZFY5XRClWELpbtUDVaOmUrGO4XomdcRBSD59wqvjS9FXgD6t5lm10Mgl@vger.kernel.org, AJvYcCXBDMvkB2RvSfQIQzZ0IoBv89X/1o7/LwlhJ8n4C3MBVna1yEzxM1WCgcFZxyLXnVD9kg3WLeoL4PH5wqUDrwXWyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBF0KbmlFxBiLO2Tz/iI6MMGlv1lSdMV/71NaXnV5z+qltvAYQ
	pyj2LXPa/5iy/vFAJXhf3988+7SlVQgwkNV3yEC82E9wVJBDA9Pg
X-Gm-Gg: ASbGncuWuFkXI0z41O9QJvntg3khxuglYw5Ln4FJuG0VF9ULY5LXswBLFHOjFx0DZS5
	S5ReJwjLeATLEak++QrHbR3a289Z0HKLd+NVQrqoU74rh7+THtZfsrGZGoObsMSyvc5F/9cLjqQ
	1ZZZ07yD05Kf414UCjYsN3hU96awDzZVkeCFwz5om9SXLFLpgqr66CgDFjTHcBLMiIx52Gm0vsI
	DexUf1i6APU42IPei5Osd4ZRCG6FYw9qDKXnlUsfGHn9HUhxA0GpbEdzFgVWHMH9C5gH92KK1bF
	NIT1uzwunIU=
X-Google-Smtp-Source: AGHT+IFH9kfhzB42dITXdZg9xXnIuIrCtLCGkWK8kDwmfncKlFAzifmDHoUZVUHtKkW5iC7Zz8oHDA==
X-Received: by 2002:a2e:bc27:0:b0:302:40ec:a1b3 with SMTP id 38308e7fff4ca-3072caa166amr12690871fa.21.1737130297134;
        Fri, 17 Jan 2025 08:11:37 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed4bcsm4854351fa.71.2025.01.17.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:11:36 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 17 Jan 2025 17:11:30 +0100
To: Valentin Schneider <vschneid@redhat.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <Z4qBMqcMg16p57av@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Jan 17, 2025 at 04:25:45PM +0100, Valentin Schneider wrote:
> On 14/01/25 19:16, Jann Horn wrote:
> > On Tue, Jan 14, 2025 at 6:51 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >> vunmap()'s issued from housekeeping CPUs are a relatively common source of
> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> >> flush_tlb_kernel_range() IPIs.
> >>
> >> Given that CPUs executing in userspace do not access data in the vmalloc
> >> range, these IPIs could be deferred until their next kernel entry.
> >>
> >> Deferral vs early entry danger zone
> >> ===================================
> >>
> >> This requires a guarantee that nothing in the vmalloc range can be vunmap'd
> >> and then accessed in early entry code.
> >
> > In other words, it needs a guarantee that no vmalloc allocations that
> > have been created in the vmalloc region while the CPU was idle can
> > then be accessed during early entry, right?
> 
> I'm not sure if that would be a problem (not an mm expert, please do
> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> deferred anyway.
> 
> So after vmapping something, I wouldn't expect isolated CPUs to have
> invalid TLB entries for the newly vmapped page.
> 
> However, upon vunmap'ing something, the TLB flush is deferred, and thus
> stale TLB entries can and will remain on isolated CPUs, up until they
> execute the deferred flush themselves (IOW for the entire duration of the
> "danger zone").
> 
> Does that make sense?
> 
Probably i am missing something and need to have a look at your patches,
but how do you guarantee that no-one map same are that you defer for TLB
flushing?

As noted by Jann, we already defer a TLB flushing by backing freed areas
until certain threshold and just after we cross it we do a flush.

--
Uladzislau Rezki

