Return-Path: <linux-arch+bounces-12553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E443DAF15AA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2421D16A248
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A011EA6F;
	Wed,  2 Jul 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uOclpbdW"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03C1E480;
	Wed,  2 Jul 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459461; cv=none; b=PNVe6Qu8PFlu22rgtzTmGIxGgMZi1sJvVDt7i6SxI55AwtfZIRRk8pXG5ziS4JeBMjhJjnTCV2lr3lx8YvzY27Mqo2ugn9twAvLeZp8F1onKr36jjjrYzBgufZz9huiVdfuBjQjj0k0o34bGGILz9JD5hzVwvQUwGYx0kQ6YDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459461; c=relaxed/simple;
	bh=ochG6ugWYbmuJiaEjRqcoWoR0DKCjQg/LTcy4LEQKPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+2zgrzzipJZ0VLZnHorxA8NmJmn6KOQlCeVW5Mm+Easj3rZKUClIYODrsd2EBXOZp4FEYEzqnRYj3Sz47HTKvzwBow3zBj18wK3ybfHzMGymPf6qr6Uw2wYUBe7Pm7I4mkmexGoGw+z05r4DvPqzgcNOm+E25aMH88ByXNhoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uOclpbdW; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751459448; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8sg3F1xvFGQ55WLtut50r+Q56w4tVb4Lz11K8/MRd6o=;
	b=uOclpbdWwgfALoqMQEtxPocZTP0mS6A0zdpTW6+Q0Kw7VaA0O/4TNcdZvywFkYqjKsXpU7rC02mXFWlYrc6W7UIpDgKrhZPsdBFuMC3p5b6v1hP9Wgp/QG0QhXHOFvAZ/ZMRWi6DQtbdc5Ffn10dtUk/Vrg4W07bo8eWkh6kIpA=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WgftUI4_1751459444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Jul 2025 20:30:48 +0800
From: cp0613@linux.alibaba.com
To: yury.norov@gmail.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	cp0613@linux.alibaba.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb extension
Date: Wed,  2 Jul 2025 20:30:43 +0800
Message-ID: <20250702123043.1460-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aGQprv3HTplw9r-q@yury>
References: <aGQprv3HTplw9r-q@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Jul 2025 14:32:14 -0400, yury.norov@gmail.com wrote:

> > static inline u8 variable_rol8(u8 word, unsigned int shift)
> 
> Now that it has assembler inlines, would it help to add the __pure
> qualifier?

Even if the same parameters are passed in, after comparing the disassembly
with and without the __pure qualifier, it is found that it does not help.

> Please do the following:
> 
> 1. Drop the generic_ror8() and keep only ror/l8()
> 2. Add ror/l16, 34 and 64 tests.
> 3. Adjust the 'loop' so that each subtest will take 1-10 ms on your hw.
> 4. Name the function like test_rorl(), and put it next to the test_fns()
>    in lib/test_bitops.c. Refer the 0a2c6664e56f0 for implementation.
> 5. Prepend the series with the benchmark patch, just as with const-eval
>    one, and report before/after for your series. 
> 
> > > Please find attached a test for compile-time ror/rol evaluation.
> > > Please consider prepending your series with it.
> > 
> > Okay, I'll bring it to the next series.
> 
> Still waiting for bloat-o-meter results.

Ok, in the next series I will provide a patch for the benchmark, and then
prepend the const-eval and benchmark patches, and also provide the results
of the bloat-o-meter.

Thank you very much,
Pei

