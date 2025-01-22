Return-Path: <linux-arch+bounces-9847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71DA188E1
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 01:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8797A3DBF
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB8946F;
	Wed, 22 Jan 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6yz2ru+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC912B71;
	Wed, 22 Jan 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505336; cv=none; b=mXRnw7MoJrKr0fVFK8Tk+gXkhybANZXgq/W1cRBBJEo4RNmDOBhcDw/eOa0LyCvM7tjGzX7lKpij/Mgzn7DBu+6owiyIVhnJyaIA1FNtIxWJltTTEyxxZSfp4Kak/LaTC5Bt7td98S5TKy9QhX5mAY1h1KZ+aj1EZ3wha6su2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505336; c=relaxed/simple;
	bh=/jGFli4cvz5GuKwl53vdKodQbbfB6lqGAT1IVg71WEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6xb0AlHxCL5QW3ZfQOtlZgaCvjSx4j93KZhBGBEhAJHETBXKdAIcvJYop+jbHLxobySvAcSG3DCX1u0+lEgTBrNVMRDoWLikVqRaCAA3D4QrK6DoANtVd/dwnXLXFSZPGY122OlRpXy7FI3bdTKrcqSZCi2Ol6UDzGD1Fys1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6yz2ru+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0ECC4CEDF;
	Wed, 22 Jan 2025 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737505335;
	bh=/jGFli4cvz5GuKwl53vdKodQbbfB6lqGAT1IVg71WEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6yz2ru+LXXh5xzgW1nRGofBLoFG1mOtZGKi5a///oNnHCh2ZlX7+dcv8uCWMxNTP
	 NYc7Ip5HhxveoM1UG1zbALPWHqlghrr9FWkgxzL4ynzknjr2qzRJNXR0bvmmp0LFhV
	 2OSMqyc+t3WixyaNjJpsZ4FqrFQOpqBUkDbXqnD8oIRzHSRo6BI6S0PtYY51ka7mXT
	 F/aNHCRlDP27nrL0iFxyIILAmTVs3KAxdOxLI4Oy09Y/BLpA3KwnyrjprYZYiv2vA6
	 /XRCO70HAGc/N4UdSrMWqxSo9SxN0390mZcC3+duriCj1eGd6MeQlfVWwQxOpCa2cX
	 9AeBV3eiLnmoQ==
Date: Wed, 22 Jan 2025 01:22:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
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
Subject: Re: [PATCH v4 22/30] context_tracking: Exit CT_STATE_IDLE upon
 irq/nmi entry
Message-ID: <Z5A6NPqVGoZ32YsN@pavilion.home>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-23-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114175143.81438-23-vschneid@redhat.com>

Le Tue, Jan 14, 2025 at 06:51:35PM +0100, Valentin Schneider a écrit :
> ct_nmi_{enter, exit}() only touches the RCU watching counter and doesn't
> modify the actual CT state part context_tracking.state. This means that
> upon receiving an IRQ when idle, the CT_STATE_IDLE->CT_STATE_KERNEL
> transition only happens in ct_idle_exit().
> 
> One can note that ct_nmi_enter() can only ever be entered with the CT state
> as either CT_STATE_KERNEL or CT_STATE_IDLE, as an IRQ/NMI happenning in the
> CT_STATE_USER or CT_STATE_GUEST states will be routed down to ct_user_exit().

Are you sure? An NMI can fire between guest_state_enter_irqoff() and
__svm_vcpu_run(). And NMIs interrupting userspace don't call
enter_from_user_mode(). In fact they don't call irqentry_enter_from_user_mode()
like regular IRQs but irqentry_nmi_enter() instead. Well that's for archs
implementing common entry code, I can't speak for the others.

Unifying the behaviour between user and idle such that the IRQs/NMIs exit the
CT_STATE can be interesting but I fear this may not come for free. You would
need to save the old state on IRQ/NMI entry and restore it on exit.

Do we really need it?

Thanks.

