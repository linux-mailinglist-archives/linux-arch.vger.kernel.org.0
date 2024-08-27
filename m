Return-Path: <linux-arch+bounces-6647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BFE960428
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA43B237C6
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3E17BEA4;
	Tue, 27 Aug 2024 08:16:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958115535A;
	Tue, 27 Aug 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746593; cv=none; b=kFdg/K4A4o0XkqvEt/cDzVxge3qlxdUxZ4Cgs2OSQZ3cCx3MBnP35LeXiZRuRdkFpOUIhsaGcQeDhSnQU3YM0ebDZxi0qy2NjqHnFbYFw+y5tY6Lmb60rd6Pmqr09GV1lkT2gOEB5DKlos5xbA2raqvS/HoXSU5EtmlXRoZB+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746593; c=relaxed/simple;
	bh=4e4KFn3X2o9YId0RS3JogVooSFyHhVczdXK2/wJftVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLBFYbAymumHr2025HID/RbpHJOrviTp/vgVLPy6LGhdTsb9WNx9A9e0nAc5jYOgXwkDxJv64ZN2GEKTf0SrnpRRO0j7XumHRxGEChoe2Armc8s6n/Wt7GQbQuQ1kelog3YZCLX/vi5Z8zOYrEnc0/UFu315GO5XUBKlfKdzwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtL3V5NkGz9sRy;
	Tue, 27 Aug 2024 10:16:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOUXLlQcHZNN; Tue, 27 Aug 2024 10:16:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtL3R6BsYz9rvV;
	Tue, 27 Aug 2024 10:16:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C3B4D8B77B;
	Tue, 27 Aug 2024 10:16:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nz5gQiZQEV5x; Tue, 27 Aug 2024 10:16:19 +0200 (CEST)
Received: from [192.168.233.149] (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 270028B763;
	Tue, 27 Aug 2024 10:16:19 +0200 (CEST)
Message-ID: <55a7d3ba-b384-4fb0-8fbb-e05ddf0d1fb8@csgroup.eu>
Date: Tue, 27 Aug 2024 10:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] random: vDSO: Don't use PAGE_SIZE and PAGE_MASK
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
 <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <Zs2FJku2hM2bp4ik@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zs2FJku2hM2bp4ik@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 09:49, Jason A. Donenfeld a écrit :
> On Tue, Aug 27, 2024 at 09:31:48AM +0200, Christophe Leroy wrote:
>> -	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
>> +	const unsigned long page_size = 1UL << CONFIG_PAGE_SHIFT;
>> +	const unsigned long page_mask = ~(page_size - 1);
>> +	ssize_t ret = min_t(size_t, INT_MAX & page_mask /* = MAX_RW_COUNT */, len);
> 
> I'm really not a fan of making the code less idiomatic...

Ok, I have another idea, let's give it a try.

> 
>> An easy solution would be to define PAGE_SIZE and PAGE_MASK in vDSO
>> when they do not exist already, but this can be misleading.
> 
> Why would what tglx and I suggested be misleading? That seems pretty
> normal... Are you worried they might mismatch somehow? (If so, why?)

All architectures have their own definition, they are all based on 
CONFIG_PAGE_SHIFT and should give the same value but with some 
subtleties. The best would be to have an asm-generic definition of 
PAGE_SIZE and PAGE_MASK that all architectures use, but that's another 
level of work.

tglx or yourself suggested to put in a one of the vdso headers instead 
of directly in getrandom.c. This is too fragile because PAGE_SIZE might 
be absent in that header but arrive in getrandom.c through another header.

Christophe

