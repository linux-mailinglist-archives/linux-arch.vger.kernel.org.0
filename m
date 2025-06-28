Return-Path: <linux-arch+bounces-12498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4BAEC6FF
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F7E3B9BFB
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E672246799;
	Sat, 28 Jun 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bKR/nBwv"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAB244690;
	Sat, 28 Jun 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751112556; cv=none; b=XFCbjjaVP6J7EW3VIIbEGJOpfpmy1Wjv0WDZV9+YciIW+tW2R8GI0kpdLpnzCCGf0JnYm7obhrffuht3YLbRZONyMHOJW5dqf6qO79CYDGu/7mi0Q94ZDzVy1itr90K6L7K9aXy+D5AIbJ1ndRRfHHaPrGYSyG4iafYoWEiLVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751112556; c=relaxed/simple;
	bh=3m6qk9sfbOx97xb5co1w7w/o8852kfwjaeLEfUcRfPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7fNsz1iIXf9h/vZu91wCbItDGkPQGbdE7u7Q8kB8Yi0x75c3EalOEaIWijvCtMN8HX4oa11n1tIFeHIHh1pZkG5kIcgWUcC1PzEZEhVyio/4c8RG7SxdgCh8RzOhMjMhk9IB0EVlUohBOpxkRveWxfwPLxk0QOcvCWul+iUTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bKR/nBwv; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751112549; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jG2LawCA1NNYtazKDVvJGkVVtdv0FBm8VQn9Q5cw1nQ=;
	b=bKR/nBwvhbbX0qTMv2rVPUr0P16VQ0vfxjGO3aredsyOl5eQcs5gpm6Cmc5AjCynWXpGkceHCdmPM/i8+NYzrdK01ZwUXrIfiBpQtvDPETaPI2Zl+m/9JwO4NM8IT5xamVkYseaJ8cfPX9Dk06wHyYMw7pS/3ZgQ/Lk6mpMdRG8=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WfjZU4-_1751112496 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 28 Jun 2025 20:09:09 +0800
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
Date: Sat, 28 Jun 2025 20:08:16 +0800
Message-ID: <20250628120816.1679-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625170234.29605eed@pumpkin>
References: <20250625170234.29605eed@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Jun 2025 17:02:34 +0100, david.laight.linux@gmail.com wrote:

> Is it even a gain in the zbb case?
> The "rorw" is only ever going to help full word rotates.
> Here you might as well do ((word << 8 | word) >> shift).
> 
> For "rol8" you'd need ((word << 24 | word) 'rol' shift).
> I still bet the generic code is faster (but see below).
> 
> Same for 16bit rotates.
> 
> Actually the generic version is (probably) horrid for everything except x86.
> See https://www.godbolt.org/z/xTxYj57To

Thanks for your suggestion, this website is very inspiring. According to the
results, the generic version is indeed the most friendly to x86. I think this
is also a reason why other architectures should be optimized. Take the riscv64
ror32 implementation as an example, compare the number of assembly instructions
of the following two functions:
```
u32 zbb_opt_ror32(u32 word, unsigned int shift)
{
	asm volatile(
		".option push\n"
		".option arch,+zbb\n"
		"rorw %0, %1, %2\n"
		".option pop\n"
		: "=r" (word) : "r" (word), "r" (shift) :);

	return word;
}

u16 generic_ror32(u16 word, unsigned int shift)
{
	return (word >> (shift & 31)) | (word << ((-shift) & 31));
}
```
Their disassembly is:
```
zbb_opt_ror32:
<+0>:     addi    sp,sp,-16
<+2>:     sd      s0,0(sp)
<+4>:     sd      ra,8(sp)
<+6>:     addi    s0,sp,16
<+8>:     .insn   4, 0x60b5553b
<+12>:    ld      ra,8(sp)
<+14>:    ld      s0,0(sp)
<+16>:    sext.w  a0,a0
<+18>:    addi    sp,sp,16
<+20>:    ret

generic_ror32:
<+0>:     addi    sp,sp,-16
<+2>:     andi    a1,a1,31
<+4>:     sd      s0,0(sp)
<+6>:     sd      ra,8(sp)
<+8>:     addi    s0,sp,16
<+10>:    negw    a5,a1
<+14>:    sllw    a5,a0,a5
<+18>:    ld      ra,8(sp)
<+20>:    ld      s0,0(sp)
<+22>:    srlw    a0,a0,a1
<+26>:    or      a0,a0,a5
<+28>:    slli    a0,a0,0x30
<+30>:    srli    a0,a0,0x30
<+32>:    addi    sp,sp,16
<+34>:    ret
```
It can be found that the zbb optimized implementation uses fewer instructions,
even for 16-bit and 8-bit data.

