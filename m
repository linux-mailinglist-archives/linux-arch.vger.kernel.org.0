Return-Path: <linux-arch+bounces-7567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF9B98C7BD
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 23:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312C728216E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2191BDAB1;
	Tue,  1 Oct 2024 21:45:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE8199FCE;
	Tue,  1 Oct 2024 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819122; cv=none; b=BAGESUUKhj9Xq+Zd2Mft065Fc8DPWCJn28Z0wl3V98BXnvgcHricymtOLJlldiXT6CW5lQw3f9Sn5LiTQpokZ2jXYmoloYQDLSE3DNcD6udSR/EyFBP1k58NTDD5bb4J64GEc5W/CXkoDqF9yq4hjP4Z0AHoh3qAdt5BGpre9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819122; c=relaxed/simple;
	bh=49VGG2UtIrsuNP/H3iwnZy3oCyTUraOyIY4zwSgN2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtJXz7zc9XzgUCdsPSprQWmjxc26Eo0Jc/IKv3wFnVIcCAZPSI00yRGwQ+UZ6EmtRRip8BcntGsuFBF5BgdMO3Zma3fDyLx3kiRDqSUSTp740S6IYkHsXoMhuzcmfzC3lQbCQwM/3BFo3nfCY3iWAWKLXlqOVf0qJ+mCZfmsnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139AC4CEC6;
	Tue,  1 Oct 2024 21:45:16 +0000 (UTC)
Date: Tue, 1 Oct 2024 17:46:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak
 <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-arm-kernel@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v9 1/5] rust: add generic static_key_false
Message-ID: <20241001174606.6f396dfd@gandalf.local.home>
In-Reply-To: <20241001211543.qdjl4pyfhehxqfk7@treble>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
	<20241001-tracepoint-v9-1-1ad3b7d78acb@google.com>
	<20241001211543.qdjl4pyfhehxqfk7@treble>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:15:43 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Oct 01, 2024 at 01:29:58PM +0000, Alice Ryhl wrote:
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.  
> 
> Instead of extending the old deprecated static key interface into Rust,
> can we just change tracepoints to use the new one?

Sure, care to send the patch properly, and I can add it to my queue.

-- Steve

> 
> /me makes a note to go convert the other users...
> 
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] tracepoints: Use new static branch API
> 
> The old static key API based on 'struct static_key' is deprecated.
> Convert tracepoints to use the new API.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/tracepoint-defs.h | 4 ++--
>  include/linux/tracepoint.h      | 8 ++++----
>  kernel/tracepoint.c             | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index 4dc4955f0fbf..60a6e8314d4c 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -31,7 +31,7 @@ struct tracepoint_func {
>  
>  struct tracepoint {
>  	const char *name;		/* Tracepoint name */
> -	struct static_key key;
> +	struct static_key_false key;
>  	struct static_call_key *static_call_key;
>  	void *static_call_tramp;
>  	void *iterator;
> @@ -83,7 +83,7 @@ struct bpf_raw_event_map {
>  
>  #ifdef CONFIG_TRACEPOINTS
>  # define tracepoint_enabled(tp) \
> -	static_key_false(&(__tracepoint_##tp).key)
> +	static_branch_unlikely(&(__tracepoint_##tp).key)
>  #else
>  # define tracepoint_enabled(tracepoint) false
>  #endif
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 6be396bb4297..ab5162fc3e4a 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -228,7 +228,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
>  	static inline void trace_##name##_rcuidle(proto)		\
>  	{								\
> -		if (static_key_false(&__tracepoint_##name.key))		\
> +		if (static_branch_unlikely(&__tracepoint_##name.key))	\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
>  				TP_CONDITION(cond), 1);			\
> @@ -254,7 +254,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	extern struct tracepoint __tracepoint_##name;			\
>  	static inline void trace_##name(proto)				\
>  	{								\
> -		if (static_key_false(&__tracepoint_##name.key))		\
> +		if (static_branch_unlikely(&__tracepoint_##name.key))	\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
>  				TP_CONDITION(cond), 0);			\
> @@ -291,7 +291,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	static inline bool						\
>  	trace_##name##_enabled(void)					\
>  	{								\
> -		return static_key_false(&__tracepoint_##name.key);	\
> +		return static_branch_unlikely(&__tracepoint_##name.key);\
>  	}
>  
>  /*
> @@ -308,7 +308,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	struct tracepoint __tracepoint_##_name	__used			\
>  	__section("__tracepoints") = {					\
>  		.name = __tpstrtab_##_name,				\
> -		.key = STATIC_KEY_INIT_FALSE,				\
> +		.key = STATIC_KEY_FALSE_INIT,				\
>  		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
>  		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
>  		.iterator = &__traceiter_##_name,			\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 8d1507dd0724..dc160cc0b616 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -358,7 +358,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  		tracepoint_update_call(tp, tp_funcs);
>  		/* Both iterator and static call handle NULL tp->funcs */
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
> -		static_key_enable(&tp->key);
> +		static_branch_enable(&tp->key);
>  		break;
>  	case TP_FUNC_2:		/* 1->2 */
>  		/* Set iterator static call */
> @@ -414,7 +414,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  		if (tp->unregfunc && static_key_enabled(&tp->key))
>  			tp->unregfunc();
>  
> -		static_key_disable(&tp->key);
> +		static_branch_disable(&tp->key);
>  		/* Set iterator static call */
>  		tracepoint_update_call(tp, tp_funcs);
>  		/* Both iterator and static call handle NULL tp->funcs */


