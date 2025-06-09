Return-Path: <linux-arch+bounces-12288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA8AD19C0
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA831669FB
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A881E8323;
	Mon,  9 Jun 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3tPh7Dj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBC8BFF;
	Mon,  9 Jun 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749457669; cv=none; b=qlJuSazGmuC0Y2VWGRFn/NYYfzBqVIoGxsMKXBQTqlH6/3Cd8KVjkoIswH5JksGvzehZXVDde6hoRK96h+Jp55Hj+zImikpnErouNVO2xl9iSoaHA159nB1H8eWOdh6kafxcegbie5UzDbsTQbem8LK+AnFG6NW3pze5Nn/4OoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749457669; c=relaxed/simple;
	bh=4sH/XwtN6/zyhtM9A103j8Ru62ZnMr73mTEUim9z6dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH+WrJuZ06UP7/kN9MZplCOsdUhe6VhrYO6oDfbSBVQzSp35C7zU9RqtDovEjLN60XR6QZhOrIeLs1y0hq6h6YteiXVbSik3nFsKD9U78+GLHwS+bhwnKRfKyCjG3kanhv1HvjZKqHeOBbPXOrMO93e+ReV2qhLMB+IyMl+RiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3tPh7Dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9984AC4CEEB;
	Mon,  9 Jun 2025 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749457668;
	bh=4sH/XwtN6/zyhtM9A103j8Ru62ZnMr73mTEUim9z6dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3tPh7DjASMZscBcYz4H0Lo96hbRJ6mqF6+RNvufiWIhZpMYHOFvA4Pt/wJGsmWcq
	 xqFTu4AHz+6jrjtrYVJBz+kZpDRyNUeefpyg2ptq8ltNILiO0ZEijWRJpabk7zGkso
	 gSvNZM0Ng2mdGcNMmO94Wfxa275qZDAUzoDionR/902lFFga6Pxr2qa5J1cE+Cvp/I
	 lourn3ffAxnLYhjx+n4F8FvRyk/tN8myutkBveTQC8KzZOtVLGHRZoHBXfDIBcj7Xi
	 wrDnAQG4pkoEn37ITsMqzAN1tkSS/gs7zC3vFLJHtZeEM8J7qdHMGw4zzmWPd9H0WG
	 ZJixSbJlAbHIQ==
Date: Mon, 9 Jun 2025 10:27:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 16/15] bugs/s390: Use in 'cond_str' to __EMIT_BUG()
Message-ID: <aEabAPB5Y9EbSPkt@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-11-mingo@kernel.org>
 <20250520133927.7932C19-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520133927.7932C19-hca@linux.ibm.com>


* Heiko Carstens <hca@linux.ibm.com> wrote:

> On Thu, May 15, 2025 at 02:46:39PM +0200, Ingo Molnar wrote:
> > Pass in the condition string from __WARN_FLAGS(), but do not
> > concatenate it with __FILE__, because the __bug_table is
> > apparently indexed by 16 bits and increasing string size
> > overflows it on defconfig builds.
> 
> Could you provide your change which didn't work?
> 
> I cannot see how anything would overflow. Trying the below on top of
> your series seems to work like expected.
> 
> In order to keep things easy this drops the mergeable section trick
> and results in a small increase of the rodata section, but I doubt
> that would explain what you have seen.
> 
> Also allyesconfig builds without errors.
> 
> diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> index 30f8785a01f5..837bfbde0c51 100644
> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -11,16 +11,14 @@
>  #define __EMIT_BUG(cond_str, x) do {				\
>  	asm_inline volatile(					\
>  		"0:	mc	0,0\n"				\
> -		".section .rodata.str,\"aMS\",@progbits,1\n"	\
> -		"1:	.asciz	\""__FILE__"\"\n"		\
> -		".previous\n"					\
>  		".section __bug_table,\"aw\"\n"			\
> -		"2:	.long	0b-.\n"				\
> -		"	.long	1b-.\n"				\
> -		"	.short	%0,%1\n"			\
> -		"	.org	2b+%2\n"			\
> +		"1:	.long	0b-.\n"				\
> +		"	.long	%0-.\n"				\
> +		"	.short	%1,%2\n"			\
> +		"	.org	1b+%3\n"			\
>  		".previous\n"					\
> -		: : "i" (__LINE__),				\
> +		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__),\
> +		    "i" (__LINE__),				\
>  		    "i" (x),					\
>  		    "i" (sizeof(struct bug_entry)));		\
>  } while (0)

So I'm not sure what happened: I tried to reproduce what I did 
originally, but my naive patch ran into assembler build errors when a 
WARN_ON() macro tried to use the '%' C operator, such as 
fs/crypto/crypto.c:123:

 include/linux/compiler_types.h:497:20: error: invalid 'asm': invalid %-code
 arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
 arch/s390/include/asm/bug.h:50:2: note: in expansion of macro '__EMIT_BUG'
 include/asm-generic/bug.h:119:3: note: in expansion of macro '__WARN_FLAGS'
 fs/crypto/crypto.c:123:6: note: in expansion of macro 'WARN_ON_ONCE'

Which corresponds to:

        if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
                return -EINVAL;

I'm quite sure I never saw these build errors - I saw linker errors 
related to the u16 overflow I documented in the changelog. (Note to 
self: copy & paste more of the build error context next time around.)

Your version doesn't have that build problem, so I picked it up with 
the changelog below and your Signed-off-by. Does that look good to you?

Thanks,

	Ingo

===================================>
From 7128294ca8b997efb1d85c7405c8c6e9af1a170d Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Tue, 20 May 2025 15:39:27 +0200
Subject: [PATCH] bugs/s390: Use 'cond_str' in __EMIT_BUG()

In order to keep things easy this drops the mergeable section trick
and results in a small increase of the rodata section.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Link: https://lore.kernel.org/r/20250520133927.7932C19-hca@linux.ibm.com
---
 arch/s390/include/asm/bug.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 30f8785a01f5..837bfbde0c51 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -11,16 +11,14 @@
 #define __EMIT_BUG(cond_str, x) do {				\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
-		".section .rodata.str,\"aMS\",@progbits,1\n"	\
-		"1:	.asciz	\""__FILE__"\"\n"		\
-		".previous\n"					\
 		".section __bug_table,\"aw\"\n"			\
-		"2:	.long	0b-.\n"				\
-		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		"1:	.long	0b-.\n"				\
+		"	.long	%0-.\n"				\
+		"	.short	%1,%2\n"			\
+		"	.org	1b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__),\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)

