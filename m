Return-Path: <linux-arch+bounces-9785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34698A112C5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 22:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD53188488A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030820E709;
	Tue, 14 Jan 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdal1sZu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C620CCEA
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889241; cv=none; b=ZZDBrhaTIHm/gUrNNLa4iwfhJ4PvLZot6GIdv6uXjyjn1V6nmhViwr1OaJXgim6ZpfJsrz/3qMf0F09J+t9eqV78+Snap/QvZMzKIfW3gVx6+yFckhkEKKu2bV6SpbpR12Z7oTSXCS+pGuMPfe8dDpK3stjQrJtYbdq8ZRskIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889241; c=relaxed/simple;
	bh=HPeOyPTCGGTDHOMXLb+UXWG1X7FxbwpONqdOtUySSrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tj/LHr+i71wxblHOosuBgaWrtQDJA2PLwksXZ5f4bVa0iLN6Rp+sbxGIRm0n+yucK1hSrtKStL0CqdCv6m8t2HttXXvjPp4Fvq7Qvh5xaE69fcC8PoSv1cxuYpXnKeZgDWO3alYixa1EstZuNexXt3YCIH1NZXoBXrNhCRXsKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdal1sZu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so10666532a91.2
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 13:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736889239; x=1737494039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9cRGGic7Te5o12Iwy1M3OB31drPOXRp+PHli2u04Fc=;
        b=tdal1sZu79aUYEJfdP1gM9Xcda9j8Wwc4Tr5g7qpUO5NRZ7iabU1ZFvpgbZtTzfbBd
         QHSuHYSZorVXmiWAGPR+NqJx0xIYP4Ro4dtIgEM2k1Ap0E6HbTMlDo7wxa77Rvy6jjph
         z7ln0jTq4mLdSJFLR+HRPA5g+EPuLxoHVnBOMJa1iCdMwZBNwfPK5lU/umsM4pKTLkyn
         xdFrMH4+9KXg4DO3kLyTN/L1RoO0oaZkWrp39eI25LyL6GbhY/NF0TCtt4ykMiSvfram
         jXm1aHRzkXPSYYs0OljrbiGSfMUJYtQlNhWckV29e/yccyIiV2hPSJe5IJV1yElmyU+1
         rYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736889239; x=1737494039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9cRGGic7Te5o12Iwy1M3OB31drPOXRp+PHli2u04Fc=;
        b=iQMR5V8koxzuJ0GDPpzlQkw6UsSkKjeX6JPFQayEz3Wao06ZFK5acmcKHzpqDY5PHx
         QH9pwiz77B2SA9PiKiK2Qk9KPLR26fp+gkukAgs3exbzgFO+z8GHSO7K9oDcnElvdVhQ
         1uqEHLSLEnNGH4LBb/JLnihjPg3WEoS77mWOyG32ZDgaXYQ8CTcpRxaturlyyTC1TUhY
         wNrm2g0J4wtiO4NmwScbUnfKiahZzbzYj4wGvfLtsnH3IosMusAXgNezbjU43a/LuPUF
         7X8UDWEjJDGXYmj/NUXpmsnAc16XWt0/hNBk9P6CCZxOFe4ReVVgj4OMQbdAPfCPYcQn
         RnSA==
X-Forwarded-Encrypted: i=1; AJvYcCVUsyi8fAlwd3mfo7KW6jwumZEypIGrmjIMZ+q5jJUnchkZEcPQ4HCIxY+hxOmlnj1qibutElfh/vDe@vger.kernel.org
X-Gm-Message-State: AOJu0YxHj4vspqsbwrlwGHpZRE+ATnBW7S3VQUO9iK5Y9xfxI2zOkoqf
	b1NVplyRAXRNLEjePnSPawD00XppAKZ3gCrBDIRusfObD32mtP6bfUbNCEdtepltz9FC8IJaDHG
	uSA==
X-Google-Smtp-Source: AGHT+IFnD8IBYtaFLZfmn+yp8faKF4j5W1D2QQ93HaiFkyR3KITtNCKyHKA+6Vtw5k/ROipPB4Gea/5UJbQ=
X-Received: from pjbsn8.prod.google.com ([2002:a17:90b:2e88:b0:2f4:465d:5c61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8b:b0:2ee:bf84:4fe8
 with SMTP id 98e67ed59e1d1-2f548f1d44cmr36656404a91.30.1736889238866; Tue, 14
 Jan 2025 13:13:58 -0800 (PST)
Date: Tue, 14 Jan 2025 13:13:57 -0800
In-Reply-To: <20250114175143.81438-26-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
Message-ID: <Z4bTlZkqihaAyGb4@google.com>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text patching IPIs
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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
	Geert Uytterhoeven <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 14, 2025, Valentin Schneider wrote:
> text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
> them vs the newly patched instruction. CPUs that are executing in userspace
> do not need this synchronization to happen immediately, and this is
> actually harmful interference for NOHZ_FULL CPUs.

...

> This leaves us with static keys and static calls.

...

> @@ -2317,11 +2334,20 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * First step: add a int3 trap to the address that will be patched.
>  	 */
>  	for (i = 0; i < nr_entries; i++) {
> -		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
> -		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
> +		void *addr = text_poke_addr(&tp[i]);
> +
> +		/*
> +		 * There's no safe way to defer IPIs for patching text in
> +		 * .noinstr, record whether there is at least one such poke.
> +		 */
> +		if (is_kernel_noinstr_text((unsigned long)addr))
> +			cond = NULL;

Maybe pre-check "cond", especially if multiple ranges need to be checked?  I.e.

		if (cond && is_kernel_noinstr_text(...))
> +
> +		tp[i].old = *((u8 *)addr);
> +		text_poke(addr, &int3, INT3_INSN_SIZE);
>  	}
>  
> -	text_poke_sync();
> +	__text_poke_sync(cond);
>  
>  	/*
>  	 * Second step: update all but the first byte of the patched range.

...

> +/**
> + * is_kernel_noinstr_text - checks if the pointer address is located in the
> + *                    .noinstr section
> + *
> + * @addr: address to check
> + *
> + * Returns: true if the address is located in .noinstr, false otherwise.
> + */
> +static inline bool is_kernel_noinstr_text(unsigned long addr)
> +{
> +	return addr >= (unsigned long)__noinstr_text_start &&
> +	       addr < (unsigned long)__noinstr_text_end;
> +}

This doesn't do the right thing for modules, which matters because KVM can be
built as a module on x86, and because context tracking understands transitions
to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
use the wrong static path.

I don't expect this to ever cause problems in practice, because patching code in
KVM's VM-Enter/VM-Exit path that has *functional* implications, while CPUs are
actively running guest code, would be all kinds of crazy.  But I do think we
should plug the hole.

If this issue is unique to KVM, i.e. is not a generic problem for all modules (I
assume module code generally isn't allowed in the entry path, even via NMI?), one
idea would be to let KVM register its noinstr section for text poking.

