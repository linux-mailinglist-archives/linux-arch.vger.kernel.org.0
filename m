Return-Path: <linux-arch+bounces-12500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4902AECC30
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jun 2025 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8447F172D20
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jun 2025 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B31D5154;
	Sun, 29 Jun 2025 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/adjtES"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8F288D6;
	Sun, 29 Jun 2025 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751193527; cv=none; b=BQRV0Zc4I/ga/OmCeTlUafiNRgfwDMxFfjeJcGdByQc3DliCDNsKOn5qQQEvXDa5xYGe3gte/KnafkCaWyYeTirwzlHIO7oekj9yoR36ZgzMMsb9dsennp1b/HO5lp62ZMFr3wiPJgdARJNRrde9Qq/YePs1W1+cZ98/HpQnXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751193527; c=relaxed/simple;
	bh=/kdnT3P6nL3BX71tLYfTuMKQKEYKcVgHqLHrifxIBbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkgXo/ZC0VGO4/Exuq4wwsK/zeXL9stOj3773WByFJWFsR/OC1DHZOvbq8axSAKWWv9Kq+ZgJ86l1fJhuydC+0ojpaPX+zouT+Zbp2vWJnycBn4LhjKMy0xZuyDvVGbutqpLQMIEFBgQB8dxNJvKG7tknoNfz7VXi7SZWWaDdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/adjtES; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a53359dea5so629645f8f.0;
        Sun, 29 Jun 2025 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751193522; x=1751798322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1gaJEPn6+FMoWhU8f8CNz5ykYo4nCgXjpfeshekYKU=;
        b=V/adjtESBPabm3G0Yh4C7gwNfycTj7vxahJbDao/8ml/2rn9CjA9TLGUrSKOfd40Wl
         op7/GchzTOLvTnDY//WM69dJxeUw9BCG55EvqgSJw+Q5MwZ6cOc3iFHti/29/Y8cpRjr
         SA/BqIuHTx2E4SSK4BTnrXHAC5dywM+sp0kpUHxM+nrPiDouim7ERqBhk05ctZa6VHIh
         DPCUJo2btER3NAwaFXzRA1/TdE0xtc/UIUgT3w7zl5yitoyfUynBTG3wX8MhJ0OeWhoE
         7IZZisD4oQ9Ryzoo4goKKEC4hakmxeFuSSo2edB/uCT31rzBdfqbS3Esv3LRsNYNUxbX
         V12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751193522; x=1751798322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1gaJEPn6+FMoWhU8f8CNz5ykYo4nCgXjpfeshekYKU=;
        b=S7Lm0P7HKPVUBFTyjhrySzAXRYAFdjRCyRBQIwfMBpu62j32HPWa1EB/Yf1jxt+rCp
         m5PZP2pbGLAhCa/+/9ti3DCWjaabc5iWWjKJp5GK9epg+0i+MMWymkmUDidOamZYE3uy
         i9AEFTExjcwx0PSOO+06G2C/lA7RIqyg22ueD8ggfNWfp+ftLUZxqoNh0TgkA2J3r8vB
         k/UACcsEY0usGGiPCslGPRvmFbXmEaDfUEH2GuINSduUhgw2GTvMtSB1Fg9wihRjXdRN
         i0U7/TRymOBwuo1r7l4TWdS5ez0cYrqMpPIqPHYP4lgTpHEv5+G7M3R95JIjG+uLWD5r
         4Dow==
X-Forwarded-Encrypted: i=1; AJvYcCWd/03i4sHhWd9oFTEdOIyxXVnsmckka9oPVrz8hJkpgBanxFEvlUspJsTm/BuLJGjPiwFSwAsvDYsl3gXb@vger.kernel.org, AJvYcCXphVM8WdzsOpMXX8yoEepu3fspyzCh+V2HMgZRMqmYEIVImh8DHLMy9VW9vIOcUEORalcIcKAeOENg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9hyl56WqmqlxNTqU+En1YL+fWsJaVn0W0FYneT2pPii5NihP
	RWdtY9FUruiVyUvJlOYPuPhV83t1Nfu4zLOuHREvBVZwSwIAfCkoFhoo
X-Gm-Gg: ASbGncsI1QFmbGry+E5O4ebGKjHdGpcInyaxzV5HXk2Lwo0gfQuaDJqy+oV11zS34Et
	ejHRKUwwhRqOchuNicMGA5tBcU+ob0TDj755PwKD26RgKx58W43JHOU1AVjCOfIER8Zm+tti8CH
	cuThmgG598ysos4a0zglZk2VGjfjcvlKFY+qe7QmWsGXcarq4dp+RZLj2pnjewFRnYcfiEYB52Z
	tw2NE4JUSQACaiPw1XkBsVbjRWQwhN2sX4xAJwG6WHqTCO4Z+rQ3w51wzSMaBQvG3ZrhltGqNoa
	xiWfq9uPutQ9QTKeVm5qKem2UOtn9IXXq5UyhB9wMD9kAmSZNHP61duWOIdsEN9CsFIBhtljMVs
	8pjZMXsTmPeJtwbwnXg==
X-Google-Smtp-Source: AGHT+IEdh0HApkzZdnPXw3HFe7Fd77TFNlHLJgOlIBuKyKHExXHiW7W73K/qKPWuNfigD6vS5J8l8g==
X-Received: by 2002:a05:6000:1786:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a8f577fdf7mr8560588f8f.1.1751193522433;
        Sun, 29 Jun 2025 03:38:42 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab15sm7550537f8f.33.2025.06.29.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 03:38:42 -0700 (PDT)
Date: Sun, 29 Jun 2025 11:38:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: cp0613@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, arnd@arndb.de,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
 palmer@dabbelt.com, paul.walmsley@sifive.com, yury.norov@gmail.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <20250629113840.2f319956@pumpkin>
In-Reply-To: <20250628120816.1679-1-cp0613@linux.alibaba.com>
References: <20250625170234.29605eed@pumpkin>
	<20250628120816.1679-1-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 20:08:16 +0800
cp0613@linux.alibaba.com wrote:

> On Wed, 25 Jun 2025 17:02:34 +0100, david.laight.linux@gmail.com wrote:
> 
> > Is it even a gain in the zbb case?
> > The "rorw" is only ever going to help full word rotates.
> > Here you might as well do ((word << 8 | word) >> shift).
> > 
> > For "rol8" you'd need ((word << 24 | word) 'rol' shift).
> > I still bet the generic code is faster (but see below).
> > 
> > Same for 16bit rotates.
> > 
> > Actually the generic version is (probably) horrid for everything except x86.
> > See https://www.godbolt.org/z/xTxYj57To  
> 
> Thanks for your suggestion, this website is very inspiring. According to the
> results, the generic version is indeed the most friendly to x86. I think this
> is also a reason why other architectures should be optimized. Take the riscv64
> ror32 implementation as an example, compare the number of assembly instructions
> of the following two functions:
> ```
> u32 zbb_opt_ror32(u32 word, unsigned int shift)
> {
> 	asm volatile(
> 		".option push\n"
> 		".option arch,+zbb\n"
> 		"rorw %0, %1, %2\n"
> 		".option pop\n"
> 		: "=r" (word) : "r" (word), "r" (shift) :);
> 
> 	return word;
> }
> 
> u16 generic_ror32(u16 word, unsigned int shift)
> {
> 	return (word >> (shift & 31)) | (word << ((-shift) & 31));
> }
> ```
> Their disassembly is:
> ```
> zbb_opt_ror32:
> <+0>:     addi    sp,sp,-16
> <+2>:     sd      s0,0(sp)
> <+4>:     sd      ra,8(sp)
> <+6>:     addi    s0,sp,16
> <+8>:     .insn   4, 0x60b5553b
> <+12>:    ld      ra,8(sp)
> <+14>:    ld      s0,0(sp)
> <+16>:    sext.w  a0,a0
> <+18>:    addi    sp,sp,16
> <+20>:    ret
> 
> generic_ror32:
> <+0>:     addi    sp,sp,-16
> <+2>:     andi    a1,a1,31
> <+4>:     sd      s0,0(sp)
> <+6>:     sd      ra,8(sp)
> <+8>:     addi    s0,sp,16
> <+10>:    negw    a5,a1
> <+14>:    sllw    a5,a0,a5
> <+18>:    ld      ra,8(sp)
> <+20>:    ld      s0,0(sp)
> <+22>:    srlw    a0,a0,a1
> <+26>:    or      a0,a0,a5
> <+28>:    slli    a0,a0,0x30
> <+30>:    srli    a0,a0,0x30
> <+32>:    addi    sp,sp,16
> <+34>:    ret
> ```
> It can be found that the zbb optimized implementation uses fewer instructions,
> even for 16-bit and 8-bit data.

Far too many register spills to stack.
I think you've forgotten to specify -O2

	David

