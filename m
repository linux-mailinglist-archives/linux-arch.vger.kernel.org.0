Return-Path: <linux-arch+bounces-12511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F239BAEDC77
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AE8188519B
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FE528507C;
	Mon, 30 Jun 2025 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZskL992U"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDA21C186;
	Mon, 30 Jun 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285683; cv=none; b=hblfoGwnGysZblNPXdox+3o9wTEnQshUXMqcw4H8Jwa0oRWVizaW4IqURpLlvlSEadK16I/565ds13sKHIWtvHg3GEhNTbTkjM+ExGvXSeYTPDz6uY4a1/rTa46vO43rCc5aXPlQixU/Nyo1hu7/TAZjiXIIi7HseugqHEH9/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285683; c=relaxed/simple;
	bh=8FAcqR+oJMD9khdH7biBb/06gHWL5Lp51C29BEBo9h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmW07aqfWjnqn1SmKKVnsnjI0HvovT5luJT0Jd1S0HGK5Q/QuLnvDE1RYbreu0Ngxffu7HAkwshr77ldbmNcWjdgUEvQNpc6lbseq8OYo7l1kzPdMmVfQfdNlHFbo4pGDY7aeEvMBnRkd0RJW9mcB8cBfkFC3i7ai47t3a4zjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZskL992U; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751285676; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TEyW6enmLuv9dUWsoyuMlg4cv4ltLIiIq6AY8UJQMfQ=;
	b=ZskL992U9rq5PHdUOtrW/JQqzFhWF3e4QqU0qbm79jVFIYtdbIUNCvmvx4QxGqN4ZYSOZ6oMvd3EUKycCLsTafl3Jg7VPvx0Uz19GmZNmm9hQtF9yWxltoheqTaeqQWVffD2VFUVWxN3UYKLrCYzteJD/2gBbACRQIjZtfnZGac=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WgCGCGw_1751285670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 20:14:35 +0800
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
Date: Mon, 30 Jun 2025 20:14:30 +0800
Message-ID: <20250630121430.1989-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629113840.2f319956@pumpkin>
References: <20250629113840.2f319956@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Jun 2025 11:38:40 +0100, david.laight.linux@gmail.com wrote:

> > It can be found that the zbb optimized implementation uses fewer instructions,
> > even for 16-bit and 8-bit data.
> 
> Far too many register spills to stack.
> I think you've forgotten to specify -O2

Yes, I extracted it from the vmlinux disassembly, without compiling with -O2, and
I used the web tool you provided as follows:
```
unsigned int generic_ror32(unsigned int word, unsigned int shift)
{
	return (word >> (shift & 31)) | (word << ((-shift) & 31));
}

unsigned int zbb_opt_ror32(unsigned int word, unsigned int shift)
{
#ifdef __riscv
	__asm__ volatile("nop"); // ALTERNATIVE(nop)

	__asm__ volatile(
		".option push\n"
		".option arch,+zbb\n"
		"rorw %0, %1, %2\n"
		".option pop\n"
		: "=r" (word) : "r" (word), "r" (shift) :);
#endif
	return word;
}

unsigned short generic_ror16(unsigned short word, unsigned int shift)
{
	return (word >> (shift & 15)) | (word << ((-shift) & 15));
}

unsigned short zbb_opt_ror16(unsigned short word, unsigned int shift)
{
	unsigned int word32 = ((unsigned int)word << 16) | word;
#ifdef __riscv
	__asm__ volatile("nop"); // ALTERNATIVE(nop)

	__asm__ volatile(
		".option push\n"
		".option arch,+zbb\n"
		"rorw %0, %1, %2\n"
		".option pop\n"
		: "=r" (word32) : "r" (word32), "r" (shift) :);
#endif
	return (unsigned short)word;
}
```
The disassembly obtained is:
```
generic_ror32:
    andi    a1,a1,31
    negw    a5,a1
    sllw    a5,a0,a5
    srlw    a0,a0,a1
    or      a0,a5,a0
    ret

zbb_opt_ror32:
    nop
    rorw a0, a0, a1
    sext.w  a0,a0
    ret

generic_ror16:
    andi    a1,a1,15
    negw    a5,a1
    andi    a5,a5,15
    sllw    a5,a0,a5
    srlw    a0,a0,a1
    or      a0,a0,a5
    slli    a0,a0,48
    srli    a0,a0,48
    ret

zbb_opt_ror16:
    slliw   a5,a0,16
    addw    a5,a5,a0
    nop
    rorw a5, a5, a1
    ret
```

Thanks,
Pei

