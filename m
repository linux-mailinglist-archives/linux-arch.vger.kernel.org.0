Return-Path: <linux-arch+bounces-12521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D98AEE5F1
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01E93AF5AD
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8528F95F;
	Mon, 30 Jun 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgxoUnpK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEF23FC5F;
	Mon, 30 Jun 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304949; cv=none; b=kKPSB9IBHEA75CQSyW5Y/qlLO0Qpg0anMeaLQ3kvTBJzAxKp8yyUNlnl+yitTejyno3+MAexeGAHMM8UK9aU+81MfUpZj1jRwT+XXffcgvzugcYHaNVm/EDp1188tMkCgbgewh1OGoBXqFackne0qbzVG7/gtL6g2SOt+Sk1aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304949; c=relaxed/simple;
	bh=t53v+u2fEaz+sIb0/gvxcqSPbkHO+HPQHJu+AFckw1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cnr8T6DIB80rnNFdk1Em/1opqBGyoHUzYxz07w0hm9iaMoGYDsv7Huo99OTYo3wiMcJiIaZajxLORx1Xd6/hdiAZvEHcw07iDjzX8l+IaXuEa8PSrDbIHj0LK5fnS9Q5FQbSrAN/cLpGMPR49+qvrKNIgDf+G9OaF6/A9gEhH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgxoUnpK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so17801225e9.3;
        Mon, 30 Jun 2025 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304946; x=1751909746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8UzOjuYiP+6COT/0DGz1uZwVPKOOEYuoLLIXwCIIFs=;
        b=jgxoUnpKGczUGM6KHYxIHElfFHPtDh0s1SP/WKY0v/cc5U+m/wa46D2CIlHQVch212
         RZGjvMzKFPq4/DSZ139TATsUggLxufl0tVm9JdkKSvfljCcakmLPxp/jRgwyW5b/O/5U
         imrl91HpsB73KBds+6CHc4U22gWlqoef7+H0tu25mTKTwANTnIAxHZEWGHPSmDdbdKCf
         0qM9OiAOxVbskJ45ANKvGk8lmKNJCEt0wgIb+bWqUnRDb5nn46288GOT1BYMnLWZHeUp
         B4Kdk2ng2mp+DCEPz46K3ERxXtq+rzY7TgLp/T8R36BWEH7CYBDjJfx8/79Tb5pKTBb4
         m2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304946; x=1751909746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8UzOjuYiP+6COT/0DGz1uZwVPKOOEYuoLLIXwCIIFs=;
        b=maLiraEI3Yzkt1okcMMP4X9tm1OdriT9jHO+loV6A8sC0eSbuElwnvyunNj2nOL7fV
         re1hK2f9xKFck+CGcnEt7+Rouri9CgjYRl6DmYxIckineiXnyQocW2uVjlsQUtWbsSVj
         7KPyh4r/6cpb1lYIaq4AB5qEhGp3AHO1hVc/zn81fFFZ/OQbefNw8P0Up2Y6fjq/Nd8I
         QS6NMADoFwJhWxEz5wQEzjEUC71Gut0AusnPzZ/eC3wMA+xCtUJaAsiQLuAH43pihCU7
         afcx1BNTi1G8VXXwxxcP0ptWYKgE1MrkDAJwwhK8655YirNJyul0l7L6/EGXI7YHY1hP
         y+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTsBiXU8F8iSwxpkUQPPbCBxPjTLKxLkTuNuFVDPNEeAB+ycruE7qV34wSHft/YVkHJkXnKb2AuqVh@vger.kernel.org, AJvYcCVuZNh6R+9T/b6y/jGxHd9jvZmRDKg14M5U+aQ/ePNhdw6tlCL6k/MqZvdSVu5OE1vR9hScLql7opmRVwuE@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAuqiZ9Iayc7sCIZ0o255KF4nOK4zzoOafcvGKyx6AtJdMzZA
	ntO9Q6fVYs0KSnmYzCZAw9Yudwl7d3Uljd6GmLRUaFz7sLp2Hq1g2+Sv
X-Gm-Gg: ASbGnctOVlc1tH+Yy6XHvaVFmKft2w287eQl+sksHldjtOhv1EITYilB+ReUNWsDLNb
	781wHYrodOS9CWnVWqcu2sVit+tUonJUM8iyiq8iPx0FYw2vsmii7x/jTgoNvgEt3/EoCMZ2yD0
	xWy7CIXf1o0tfAA1ULmc9ah1NoFD5w9Ry3764fekEDoYmwXHlG+zWAGm4CFnLvviBaxE9y5ylN8
	6Uu2cRfVR5U+elYiL8HuY4CBPfOOFmPDkp2WCJx48H1QNDoabmbjjqEd6WzMyMs06axCkGKmnJk
	1zT39XpNKcj2djzUmDAcfz7VYvZPbcIUelJfY4UEOwaUicWifqbgVkyR+ngZcCWsRwqSzU9Sc0N
	44owiTIrvpsu8F3htVQ==
X-Google-Smtp-Source: AGHT+IFUgJpGHTHreJd2V4YxIs3BSqWmS5u8aylaBhtbUqxygRzxU7eVkC51ET0af1KjL/WOFJ+ycw==
X-Received: by 2002:a05:600c:1552:b0:450:d61f:dd45 with SMTP id 5b1f17b1804b1-453a7fa138dmr1464735e9.4.1751304946001;
        Mon, 30 Jun 2025 10:35:46 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5972bsm11052648f8f.68.2025.06.30.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:35:45 -0700 (PDT)
Date: Mon, 30 Jun 2025 18:35:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: cp0613@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, arnd@arndb.de,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
 palmer@dabbelt.com, paul.walmsley@sifive.com, yury.norov@gmail.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <20250630183534.160b9823@pumpkin>
In-Reply-To: <20250630121430.1989-1-cp0613@linux.alibaba.com>
References: <20250629113840.2f319956@pumpkin>
	<20250630121430.1989-1-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 20:14:30 +0800
cp0613@linux.alibaba.com wrote:

> On Sun, 29 Jun 2025 11:38:40 +0100, david.laight.linux@gmail.com wrote:
> 
> > > It can be found that the zbb optimized implementation uses fewer instructions,
> > > even for 16-bit and 8-bit data.  
> > 
> > Far too many register spills to stack.
> > I think you've forgotten to specify -O2  
> 
> Yes, I extracted it from the vmlinux disassembly, without compiling with -O2, and
> I used the web tool you provided as follows:
> ```
> unsigned int generic_ror32(unsigned int word, unsigned int shift)
> {
> 	return (word >> (shift & 31)) | (word << ((-shift) & 31));
> }
> 
> unsigned int zbb_opt_ror32(unsigned int word, unsigned int shift)
> {
> #ifdef __riscv
> 	__asm__ volatile("nop"); // ALTERNATIVE(nop)
> 
> 	__asm__ volatile(
> 		".option push\n"
> 		".option arch,+zbb\n"
> 		"rorw %0, %1, %2\n"
> 		".option pop\n"
> 		: "=r" (word) : "r" (word), "r" (shift) :);
> #endif
> 	return word;
> }
> 
> unsigned short generic_ror16(unsigned short word, unsigned int shift)
> {
> 	return (word >> (shift & 15)) | (word << ((-shift) & 15));
> }
> 
> unsigned short zbb_opt_ror16(unsigned short word, unsigned int shift)
> {
> 	unsigned int word32 = ((unsigned int)word << 16) | word;
> #ifdef __riscv
> 	__asm__ volatile("nop"); // ALTERNATIVE(nop)
> 
> 	__asm__ volatile(
> 		".option push\n"
> 		".option arch,+zbb\n"
> 		"rorw %0, %1, %2\n"
> 		".option pop\n"
> 		: "=r" (word32) : "r" (word32), "r" (shift) :);
> #endif
> 	return (unsigned short)word;
> }
> ```
> The disassembly obtained is:
> ```
> generic_ror32:
>     andi    a1,a1,31

The compiler shouldn't be generating that mask.
After all it knows the negated value doesn't need the same mask.
(I'd guess the cpu just ignores the high bits of the shift - most do.)

>     negw    a5,a1
>     sllw    a5,a0,a5
>     srlw    a0,a0,a1
>     or      a0,a5,a0
>     ret
> 
> zbb_opt_ror32:
>     nop
>     rorw a0, a0, a1
>     sext.w  a0,a0

Is that a sign extend?
Why is it there?
If it is related to the (broken) 'feature' of riscv-64 that 32bit results
are sign extended, why isn't there one in the example above.

You also need to consider the code for non-zbb cpu.

>     ret
> 
> generic_ror16:
>     andi    a1,a1,15
>     negw    a5,a1
>     andi    a5,a5,15
>     sllw    a5,a0,a5
>     srlw    a0,a0,a1
>     or      a0,a0,a5
>     slli    a0,a0,48
>     srli    a0,a0,48

The last two instructions mask the result with 0xffff.
If that is necessary it is missing from the zbb version below.

>     ret
> 
> zbb_opt_ror16:
>     slliw   a5,a0,16
>     addw    a5,a5,a0

At this point you can just do a 'shift right' on all cpu.
For rol16 you can do a variable shift left and a 16 bit
shift right on all cpu.
If the zbb version ends up with a nop (as below) then it is
likely to be much the same speed.

	David

>     nop
>     rorw a5, a5, a1
>     ret
> ```
> 
> Thanks,
> Pei


