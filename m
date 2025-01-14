Return-Path: <linux-arch+bounces-9787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C62A112F9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 22:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6230E1675CC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E21211488;
	Tue, 14 Jan 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8ZD90/R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCB20F996
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889865; cv=none; b=cn9K8C9TeK7QQDgIa9gmZNmccC9irPMPONNE+GcYmaczamp/RbVEKf9BrtNFkGWX7VS6IpJvLkOtWt6ruJeC7EGvlgVlAORbF7QADrWUtfCrCgfcisqSoWqruY+gIpth1aawe0+7P7ADzzarSJjK5K/Jgi9Sb2Z0sCeaxJ0URmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889865; c=relaxed/simple;
	bh=UhsLziMJuir9EcfHw8J9VL7USXU5IkN4Qt5js8SLo28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6TORALnfzaiZ6FNx7skNnmtyRn4cUuEkeyvg3rard6RDMbjN8ARCMrSnbPXy8pI4RSsDR55FC6JJMOY9upviEfcaO8muZhdIH3BIjtqkNQDJQXW5jRyqDhz/v91YL/+JT2oQBkIJ+6ACxv/jduEp+W8Arb2ehucXfI6iR1Vmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8ZD90/R; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso10845990a91.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736889862; x=1737494662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cSsXdzV+ZwQOEMikMUZ9KmnzJy+D1+up+g+W/Xr/ho=;
        b=a8ZD90/R1fxBjGKIJ7nNIE7UWpawA2Y5lURTFsAsoI4Pvc+bWV1DkY4skjpES//Uv5
         uTgLQhJu3plYnPnKulVXi3jTMKXDUisjINvNtFok402/QQ/azqSmJrGc+2coZFO6uG2p
         pc/DU/wG4qQBOzUD5A2Zw7QiBC4zYlBHcOPNqXRSX8ANgaA/Zy9wnA/r0tSpgASG0Oav
         mLQZBPujtPWXHO54lYkHrQJaZeQq5YGQQlHQdf/hldXx/lmjsg9TVWus3SGyrG5z3KdF
         zWebYYAVF/jIfSPDIB6iPpbgOPd48G/RMxDuW6XI/sT7+glnYuf8H7EkScahRdvQvLCb
         tY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736889862; x=1737494662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cSsXdzV+ZwQOEMikMUZ9KmnzJy+D1+up+g+W/Xr/ho=;
        b=HW6uLebp4zWCIxOUUIH6Mc5zmxnp7QhpNQzw4lwIq28ci06dXnLychNgWuKu7SfLrU
         UbnpFbwm/UnN6w/S63Nd5V6FJ78db8TK9me4Nc33UsMhFzfjbwL6DMVj7L5BN0d4TInJ
         P/ihD4WqpOeLboRoNZUw3Wg7fgj2LmnRAUqtrULiyQp54efZFSajTwzaIA3nzfX5eaTH
         +A7gue92dGdblPy2ZuZW+BBIKeP2UO3FSkV6P7jcVdZs6YcO2EuUARwlaT74ysDEW+bM
         4c7WTtJoFrV0dPVGp66D6N6Tv6e4fglX2k13ZJcHDy7f7gir4mWlD9dOpdXIrcOfNFwz
         GUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4v39oAhZ3PIAtKDURwkDLzoExxRWsudWUKRHBjhKuz5tq+ZLkjTiCeZpI8cRkJ/cLW/TYPxBe07eI@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBqC9FoZy4aUAWDJFphfOkBiShYTZi7mnTxcdoaZSnB5Juh05
	1gmC2sUAm8UN5x/MrIgomefNtk1I075ZUf0l95oxT+tXjE88+OmIdgMmeFzATOVoUEdXIUzC+17
	H+g==
X-Google-Smtp-Source: AGHT+IGaqEwoic7xvDyznY8cDg+F7K5+qe11MRhfXOt+1PBXtCG3HV5nSK8yv8Q3/q/HTXMyOsqLmKxvwkg=
X-Received: from pjbtc8.prod.google.com ([2002:a17:90b:5408:b0:2ef:abba:8bfd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b87:b0:2ee:8031:cdbc
 with SMTP id 98e67ed59e1d1-2f548f1ec3fmr32208440a91.23.1736889862547; Tue, 14
 Jan 2025 13:24:22 -0800 (PST)
Date: Tue, 14 Jan 2025 13:24:21 -0800
In-Reply-To: <20250114175143.81438-28-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-28-vschneid@redhat.com>
Message-ID: <Z4bWBUGUH34qLUt0@google.com>
Subject: Re: [PATCH v4 27/30] x86/tlb: Make __flush_tlb_local() noinstr-compliant
From: Sean Christopherson <seanjc@google.com>
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
	Kan Liang <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 14, 2025, Valentin Schneider wrote:
> Later patches will require issuing a __flush_tlb_all() from noinstr code.
> This requires making both __flush_tlb_local() and __flush_tlb_global()
> noinstr-compliant.
> 
> For __flush_tlb_local(), xen_flush_tlb() has already been made noinstr, so
> it's just native_flush_tlb_global(), and simply __always_inline'ing
> invalidate_user_asid() gets us there
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---

...

> @@ -1206,7 +1206,7 @@ STATIC_NOPV noinstr void native_flush_tlb_global(void)
>  /*
>   * Flush the entire current user mapping
>   */
> -STATIC_NOPV void native_flush_tlb_local(void)
> +STATIC_NOPV noinstr void native_flush_tlb_local(void)

native_write_cr3() and __native_read_cr3() need to be __always_inline.

vmlinux.o: warning: objtool: native_flush_tlb_local+0x8: call to __native_read_cr3() leaves .noinstr.text section

