Return-Path: <linux-arch+bounces-557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364507FF079
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E649F282409
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC555482F5;
	Thu, 30 Nov 2023 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ab88EBl5"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9A131;
	Thu, 30 Nov 2023 05:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nTDEByR8M40duXbJYISBwBBcacxMogIgHwTMF/IlaPs=; b=ab88EBl58upGSeTBpe4Vrkh75o
	nYzYKpq9wEt3x47E/cOvkiJur81GoqDqoYi6s74VQaga3MieJo7RSEDJJn9EHrsZ46o/Vt0PPba1O
	7N5MIGE2WkZ/1Npup0E2UMyjY99eQrOiAjDzCz+uiwRFWY8STstyrd8wuNrmhS3G+8ZpNFPKPpiMt
	Lz9iDzeQng+KlkneqRr7su3ELXk2i6rPC9rSP57zMgxdI/AfqeNJ4DjMvpgNXy85ZYBUNySuUb/WE
	pmLEr6Rc8OdsHi1fUzABmTXTUCWk9SqdOdJwom8QGOR8Hb55UVkXG+n8YE+knnmgF+D9jpOO841TP
	jGKbXRSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hJs-0013s7-0o;
	Thu, 30 Nov 2023 13:43:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 50E0B300427; Thu, 30 Nov 2023 14:43:07 +0100 (CET)
Message-Id: <20231130133630.192490507@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 30 Nov 2023 14:36:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@google.com,
 haoluo@google.com,
 jolsa@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 samitolvanen@google.com,
 keescook@chromium.org,
 nathan@kernel.org,
 ndesaulniers@google.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 jpoimboe@kernel.org,
 joao@overdrivepizza.com,
 mark.rutland@arm.com
Subject: [PATCH v2 0/2] x86/bpf: Fix FineIBT vs eBPF
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Hi!

There's a problem with FineIBT and eBPF using __nocfi when
CONFIG_BPF_JIT_ALWAYS_ON=n, in which case the __nocfi indirect call can target
a normal function like __bpf_prog_run32().

Specifically the various preambles look like:

   FineIBT				JIT

   __cfi_foo:
      endbr64
      subl	$hash, %r10d
      jz	1f
      ud2
   1: nop
   foo:					foo:
      osp nop3				   endbr64
      ...				   ...

So while bpf_dispatcher_*_func() does a __nocfi call to foo()+0 and this
matches what the JIT generates, it does not work for regular FineIBT functions,
since their +0 endbr got poisoned and things go *boom*.

Cure this by teaching the BPF JIT about all the various CFI forms. Notably this
removes the last __nocfi call on x86.

If the BPF folks agree (and the robots don't find fail) I'd like to take this
through the x86 tree, because I have a few more patches that turn the non-fatal
'osp nop3' poison into a 4 byte ud1 instruction which is rather fatal. As a
result this problem will also surface on !IBT hardware.

Changes since v1:
 - added wee comment to asm/cfi.h (ast)
 - added asm comments to bytecode (ast)
 - renamed bpf_func_proto() to __bpf_prog_runX() (ast)
 - added bpf_prog_aux::ksym_prefix (ast)


