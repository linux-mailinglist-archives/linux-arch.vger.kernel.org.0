Return-Path: <linux-arch+bounces-5843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2394494B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 12:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242FE1C21256
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3086171658;
	Thu,  1 Aug 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qLqxu/A7"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015B446A1;
	Thu,  1 Aug 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508114; cv=none; b=ESj3C5JrdFvQDTPnzAPCDePfcOdD7HTs4JzBrXsvrA68SE/oqkvkeoIFgrOrxanV6tUYMfY+524JwNbryjK3YFYM8TKmK5f3jVmL2cizDyAHYJqbEa8BItSGHzQH6uNhazGihzrD48nEHVxuqUYqmHIrckRawv6RNvtc/0f3kYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508114; c=relaxed/simple;
	bh=yPtcdL9rfkhbng4xukjmHie3gmq6wgHWdXoJQhB6XuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc4vjVJK+v9n3EAoIdzQcNxh8iWR0nmCXThajwBXUBeGEmioBCp337zFvbHN31yC8ovhbI978OwcFFQuTN0MpFkdwPXVt6aX0G6LJpti1peI0md7xI6atBY4BbpwVmZRt4W0FzlpG4C1RGABVAK9sp4tk1DyfLlMR8CYsy51sWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qLqxu/A7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v1s+5Bi9d041LGdTeseO3YDdAQzIcr7DZg2LK0/Pvu0=; b=qLqxu/A7f3yE8trlCtn2zwr4Sr
	HsLHcEDK9/3J6tw7LUc6f6UbjMMG4sOJfSifCTcBNiwZSAV/P3ODLWlG7yA2knS7LCa0qhRE4PlrQ
	ylZjSUWBL9DxVjhdQzws15gwx0gi0lDvz7cXdxLOsjy7w+Ib4IOHWMokdPVtwpOChpjjVn+ye1Uld
	GFG+rsmUPvDikDI9xHGuE71rzQkSd89IUW183/BHQCmgpPHLpOyMsudNwch8jn/2BqO15VJiimQxp
	xtAjbcKmLuxcKg2Ku/JMxVsbtgiI4S+inNFNHpfHD9Z1+dwbMwwNH7EbzTp55VBxzAL5Gb3OZJgjQ
	lwCLoQBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZT2T-00000005RW8-1u0R;
	Thu, 01 Aug 2024 10:28:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8B25A30074E; Thu,  1 Aug 2024 12:28:04 +0200 (CEST)
Date: Thu, 1 Aug 2024 12:28:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradaed.org>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
Message-ID: <20240801102804.GQ33588@noisy.programming.kicks-ass.net>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-1-353d523a9c15@google.com>
 <20240731170508.GJ33588@noisy.programming.kicks-ass.net>
 <CAH5fLghYodekhH-1A0BWZVwgbqkWbP3WP70-us2FtHqvOqD_Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghYodekhH-1A0BWZVwgbqkWbP3WP70-us2FtHqvOqD_Hw@mail.gmail.com>

On Wed, Jul 31, 2024 at 11:34:13PM +0200, Alice Ryhl wrote:

> > Please work harder to not have to duplicate stuff like this.
> 
> I really didn't want to duplicate it, but it's very hard to find a
> performant alternative. Is there any way we could accept duplication
> only in the cases where an 'i' parameter is used? I don't have the
> choice of using a Rust helper for 'i' parameters.
> 
> Perhaps one option could be to put the Rust code inside jump_label.h
> and have the header file evaluate to either C or Rust depending on the
> value of some #ifdefs?
> 
> #ifndef RUST_ASM
> /* existing C code goes here */
> #endif
> #ifdef RUST_ASM
> // rust code goes here
> #endif
> 
> That way the duplication is all in a single file. It would also avoid
> the need for duplicating the nop5 string, as the Rust case is still
> going through the C preprocessor and can use the existing #define.

I suppose that is slightly better, but ideally you generate the whole of
the Rust thing from the C version. After all, Clang can already parse
this.

That said, with the below patch, I think you should be able to reuse the
JUMP_TABLE_ENTRY macro like:

	JUMP_TABLE_ENTRY({0}, {1}, {2} + {3})

> I'm also open to other alternatives. But I don't have infinite
> resources to drive major language changes.

Yes, well, you all picked this terrible language full well knowing it
hated C/C++ and had not a single effort put into integration with
existing code bases.

I find it very hard to care for the problems you've created for
yourself.


---
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index cbbef32517f0..6cff7bf5e779 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -12,12 +12,12 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
-#define JUMP_TABLE_ENTRY				\
-	".pushsection __jump_table,  \"aw\" \n\t"	\
-	_ASM_ALIGN "\n\t"				\
-	".long 1b - . \n\t"				\
-	".long %l[l_yes] - . \n\t"			\
-	_ASM_PTR "%c0 + %c1 - .\n\t"			\
+#define JUMP_TABLE_ENTRY(l_yes, key, branch)				\
+	".pushsection __jump_table,  \"aw\" \n\t"			\
+	_ASM_ALIGN "\n\t"						\
+	".long 1b - . \n\t"						\
+	".long " __stringify(l_yes) "- . \n\t"				\
+	_ASM_PTR " " __stringify(key) " + " __stringify(branch) " - . \n\t" \
 	".popsection \n\t"
 
 #ifdef CONFIG_HAVE_JUMP_LABEL_HACK
@@ -26,7 +26,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 {
 	asm goto("1:"
 		"jmp %l[l_yes] # objtool NOPs this \n\t"
-		JUMP_TABLE_ENTRY
+		JUMP_TABLE_ENTRY(%[l_yes], %c0, %c1)
 		: :  "i" (key), "i" (2 | branch) : : l_yes);
 
 	return false;
@@ -40,7 +40,7 @@ static __always_inline bool arch_static_branch(struct static_key * const key, co
 {
 	asm goto("1:"
 		".byte " __stringify(BYTES_NOP5) "\n\t"
-		JUMP_TABLE_ENTRY
+		JUMP_TABLE_ENTRY(%[l_yes], %c0, %c1)
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -54,7 +54,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 {
 	asm goto("1:"
 		"jmp %l[l_yes]\n\t"
-		JUMP_TABLE_ENTRY
+		JUMP_TABLE_ENTRY(%[l_yes], %c0, %c1)
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;

