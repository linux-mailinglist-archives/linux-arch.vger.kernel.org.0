Return-Path: <linux-arch+bounces-11760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7AFAA5286
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 19:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48D73AA8AC
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AAC263C7F;
	Wed, 30 Apr 2025 17:20:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB52609C5;
	Wed, 30 Apr 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033655; cv=none; b=po5KW45EueBSa+Ip5hdMDNBwI+m/dcFETDy4mNNzAL5zQPGniKI5t5dSnTYnGtIMxVWyLEPRC68OsV2yY1CBMO5bxP9o0/bdaE7x9ObePsQe8RVA/UtFMO5ZyNcCk5REATmZ+3Pqc89Z2HiEn5cldt0jppzqKzJDEXObsKX10ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033655; c=relaxed/simple;
	bh=39KWSZA/+5ZTjQd4vRuOPIK2i+N4nybWhXUJllaBu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5KntVeZGijtm27y0qoRBsKEEiFDMkIKwEvZM0FeCpVtTB54aV5+y+O5v2hyhZBSCsjWQVAw7nEzVvV5/Qmb0KAoEiU+o+OeCC8SjkJEB3be28rMTHxDNpWwUpG2iLO9pMjr2o4vb/8ZzBaKa5X2sLL0bWAcXuBH8s0RJTK3efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD676C4CEEB;
	Wed, 30 Apr 2025 17:20:43 +0000 (UTC)
Date: Wed, 30 Apr 2025 13:20:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Daniel Wagner <dwagner@suse.de>, Petr Tesarik
 <ptesarik@suse.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Naveen N
 Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rong Xu
 <xur@google.com>, Rafael Aquini <aquini@redhat.com>, Song Liu
 <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Vishal Annapurve <vannapurve@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <20250430132047.01d48647@gandalf.local.home>
In-Reply-To: <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
	<fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Apr 2025 09:11:57 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> I don't think we should do this series.

Could you provide more rationale for your decision.

>=20
> If folks want this functionality, they should get a new CPU that can
> flush the TLB without IPIs.

That's a pretty heavy handed response. I'm not sure that's always a
feasible solution.

=46rom my experience in the world, software has always been around to fix the
hardware, not the other way around ;-)

-- Steve


