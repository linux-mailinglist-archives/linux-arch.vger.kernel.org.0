Return-Path: <linux-arch+bounces-294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D07F1804
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC381F23600
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D51DDCD;
	Mon, 20 Nov 2023 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9gIV6rV"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF78AA7;
	Mon, 20 Nov 2023 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oGHosGSu29j4EnbPxYYEuFvEX0yrbNZzWjtFhlk/JMQ=; b=i9gIV6rVlwloPazJ+Gh33k97ew
	0wPexOGHhjKWYUEwEjw1POG5MXviv3p2Dkvb2qeyXjSmlnnhHgHlBH+E7R8wKUCIzo2/zvmWBMwaJ
	fnXYE9gSYCylpexiN4VQRb9khJeYh02DF7L3xvwuLFQIekfP8h0jfeyN7yOA24TMykQrnAtO1dxjT
	w8fLibW3mVqjCwfQgrygjUGG+Ox1dfH2SY75SrJll27kTkmzlprK0V4r78PEDoQzaXMa8t/reXbqC
	zEO66Gkhz80gnyn6hUOT5Nvx3XJIyrBd1wGclGsUZ3VFpdhb8EaNx3A4tJXn7nb8jf8SBgd0f0YpF
	lkG7cDbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r56gS-004iwW-P0; Mon, 20 Nov 2023 15:59:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6677D300419; Mon, 20 Nov 2023 16:59:36 +0100 (CET)
Date: Mon, 20 Nov 2023 16:59:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
	ndesaulniers@google.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
	mark.rutland@arm.com
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <20231120155936.GY8262@noisy.programming.kicks-ass.net>
References: <20231120144642.591358648@infradead.org>
 <20231120154948.708762225@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120154948.708762225@infradead.org>

On Mon, Nov 20, 2023 at 03:46:44PM +0100, Peter Zijlstra wrote:

> @@ -2935,9 +3009,9 @@ struct bpf_prog *bpf_int_jit_compile(str
>  			jit_data->header = header;
>  			jit_data->rw_header = rw_header;
>  		}
> -		prog->bpf_func = (void *)image;
> +		prog->bpf_func = (void *)image + ctx.prog_offset;
>  		prog->jited = 1;
> -		prog->jited_len = proglen;
> +		prog->jited_len = proglen - ctx.prog_offset; // XXX?
>  	} else {
>  		prog = orig_prog;
>  	}


Note the XXX there, I wasn't sure what the desired semantics of proglen
was. As implemented it is the length from where bpf_func points to the
end, not including the pre-preamble -- as indicated by offset.

