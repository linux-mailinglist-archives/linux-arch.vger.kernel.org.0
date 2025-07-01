Return-Path: <linux-arch+bounces-12544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DFAEF99D
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058A34466FB
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC752749E1;
	Tue,  1 Jul 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LsziNonm"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340D14A60C;
	Tue,  1 Jul 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374936; cv=none; b=Y/FZqAEnH5RsXGx5HifknNSYlNcRC4Iaj8qNuiQquBKuQ08BJWzRUtg2J1B73xevADruzJ8AX+sZQmz5Oc/mNqVeM27iLun//eDs3zb2SUy5LIJWERKK3mnlaxB/Kb8+oYxXvUzoPLdMqzsKNAqtzKyorKUPECBYcmKEq8CpA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374936; c=relaxed/simple;
	bh=/MElPujMYO4YKGVegoRk4j5UOBm6/EvudL5Mm9Ww77I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3GBS2a8N5Uur/F6mQS0CvRotVZ6vyVyduBkmwwku6vM751OJnlrdUGa9J87OPQ7t/77WBr98YXDYIyiyAWYviXkuR2meEY8R7Q1S+SjkyCBZ8NN4nUSt8kiYW6XfqqbIY+bvulaAtV1f7XLVXkkI7zBGzJHxIhNQL8F026Zq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LsziNonm; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751374925; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wQkIck5POixK9EE+T2WkLOuw56coDGeHxNs8KT6qVBc=;
	b=LsziNonmopB9V0ipGXDBk9S2/y5wp7AdSPnI27qf7gIHoZuhmmnbjyAVQbzPNQCL0m1iuClvS5BVcCbYJqIFCl5Bj7uaXmiKEYrgJtVVEIf8Mw/mdHD+wpvn629TMoGtPoixhhDTFHXrJaFtUNG2t2Ip9mS+y54XtAVlK6GHSm4=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WgR.XGA_1751374918 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Jul 2025 21:02:04 +0800
From: cp0613@linux.alibaba.com
To: david.laight.linux@gmail.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	cp0613@linux.alibaba.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	yury.norov@gmail.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb extension
Date: Tue,  1 Jul 2025 21:01:49 +0800
Message-ID: <20250701130149.968-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630183534.160b9823@pumpkin>
References: <20250630183534.160b9823@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Jun 2025 18:35:34 +0100, david.laight.linux@gmail.com wrote:

> > On Sun, 29 Jun 2025 11:38:40 +0100, david.laight.linux@gmail.com wrote:
> > 
> > > > It can be found that the zbb optimized implementation uses fewer instructions,
> > > > even for 16-bit and 8-bit data.  
> > > 
> > > Far too many register spills to stack.
> > > I think you've forgotten to specify -O2  
> > 
> > Yes, I extracted it from the vmlinux disassembly, without compiling with -O2, and
> > I used the web tool you provided as follows:
> > ```
> > unsigned int generic_ror32(unsigned int word, unsigned int shift)
> > {
> > 	return (word >> (shift & 31)) | (word << ((-shift) & 31));
> > }
> > 
> > unsigned int zbb_opt_ror32(unsigned int word, unsigned int shift)
> > {
> > #ifdef __riscv
> > 	__asm__ volatile("nop"); // ALTERNATIVE(nop)
> > 
> > 	__asm__ volatile(
> > 		".option push\n"
> > 		".option arch,+zbb\n"
> > 		"rorw %0, %1, %2\n"
> > 		".option pop\n"
> > 		: "=r" (word) : "r" (word), "r" (shift) :);
> > #endif
> > 	return word;
> > }
> > 
> > unsigned short generic_ror16(unsigned short word, unsigned int shift)
> > {
> > 	return (word >> (shift & 15)) | (word << ((-shift) & 15));
> > }
> > 
> > unsigned short zbb_opt_ror16(unsigned short word, unsigned int shift)
> > {
> > 	unsigned int word32 = ((unsigned int)word << 16) | word;
> > #ifdef __riscv
> > 	__asm__ volatile("nop"); // ALTERNATIVE(nop)
> > 
> > 	__asm__ volatile(
> > 		".option push\n"
> > 		".option arch,+zbb\n"
> > 		"rorw %0, %1, %2\n"
> > 		".option pop\n"
> > 		: "=r" (word32) : "r" (word32), "r" (shift) :);
> > #endif
> > 	return (unsigned short)word;
> > }
> > ```
> > The disassembly obtained is:
> > ```
> > generic_ror32:
> >     andi    a1,a1,31
> 
> The compiler shouldn't be generating that mask.
> After all it knows the negated value doesn't need the same mask.
> (I'd guess the cpu just ignores the high bits of the shift - most do.)
> 
> >     negw    a5,a1
> >     sllw    a5,a0,a5
> >     srlw    a0,a0,a1
> >     or      a0,a5,a0
> >     ret
> > 
> > zbb_opt_ror32:
> >     nop
> >     rorw a0, a0, a1
> >     sext.w  a0,a0
> 
> Is that a sign extend?
> Why is it there?
> If it is related to the (broken) 'feature' of riscv-64 that 32bit results
> are sign extended, why isn't there one in the example above.
> 
> You also need to consider the code for non-zbb cpu.
> 
> >     ret
> > 
> > generic_ror16:
> >     andi    a1,a1,15
> >     negw    a5,a1
> >     andi    a5,a5,15
> >     sllw    a5,a0,a5
> >     srlw    a0,a0,a1
> >     or      a0,a0,a5
> >     slli    a0,a0,48
> >     srli    a0,a0,48
> 
> The last two instructions mask the result with 0xffff.
> If that is necessary it is missing from the zbb version below.
> 
> >     ret
> > 
> > zbb_opt_ror16:
> >     slliw   a5,a0,16
> >     addw    a5,a5,a0
> 
> At this point you can just do a 'shift right' on all cpu.
> For rol16 you can do a variable shift left and a 16 bit
> shift right on all cpu.
> If the zbb version ends up with a nop (as below) then it is
> likely to be much the same speed.
> 
> 	David
> 
> >     nop
> >     rorw a5, a5, a1
> >     ret
> > ```

Sorry, please allow me to reply in a unified way. I did not check the rationality
of the above assembly, but only used the web tool you provided before to generate
it. In fact, I think it is more in line with the actual situation to disassemble
it from vmlinux. In addition, the code is simplified here, and the complete
implementation takes into account the processor that does not support or has not
enabled zbb.

