Return-Path: <linux-arch+bounces-4636-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B548D6331
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FFB28D200
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E5B158DA3;
	Fri, 31 May 2024 13:37:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253B158D9F;
	Fri, 31 May 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162666; cv=none; b=u/kqOuBRCDmMhAqv6jmU2VHhUOKeomXUzSfBkQ/Rm7ryv9HzsNI7ga9jq2hhEk0KMK0TedPk5gIBjrT473AvApM2bxmGWJh4LckA4ST5bt6Ep2St4CiNarrPmR6czlBdxXk6S2//aS9E3jTYAyVL46Zv1dcweC4li7mGbC7OgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162666; c=relaxed/simple;
	bh=/udGeZpdzNcWFqjbvvd5a2DI+PHGZmgjzwa02jNaJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuXefBqw/3CjTb8hU738rLHCmkZFpna80wgS6A+oeHNZLfr+PVgrL/CCs9Hu8ANyJDEHmzNZqEjk4XGKam70Ur0Fq1o5kFE+4Ne8+Qe91xGBltC/ygn1bMDKKT8IbF84eESBd3/QJkqW7hKG5GWBVhVujmjfLbVwQ7uddqPDwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42D571BF207;
	Fri, 31 May 2024 13:37:38 +0000 (UTC)
Message-ID: <39a9b28c-2792-45ce-a8c6-1703cab0f2de@ghiti.fr>
Date: Fri, 31 May 2024 15:37:37 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <ZlZ8/Nv3QS99AgY9@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZlZ8/Nv3QS99AgY9@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andrea,

On 29/05/2024 02:55, Andrea Parri wrote:
>> +	select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> IIUC, we should make sure qspinlocks run with ARCH_WEAK_RELEASE_ACQUIRE,
> perhaps a similar select for the latter?  (not a kconfig expert)


Where did you see this dependency? And if that is really a dependency of 
qspinlocks, shouldn't this be under CONFIG_QUEUED_SPINLOCKS? (not a 
Kconfig expert too).


>
>    Andrea
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

