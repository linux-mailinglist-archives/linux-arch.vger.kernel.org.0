Return-Path: <linux-arch+bounces-7389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E3A985304
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569D21C22BDC
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372B155391;
	Wed, 25 Sep 2024 06:39:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606C156227;
	Wed, 25 Sep 2024 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246352; cv=none; b=cfGAuYK04dJLi2uWxz6eAECB/D9gvAAIxIr7ajFR7ddRpr9nILI+xpUouNPCH27MeF7gWm0GaA2TIwWqoHxuxhgbxRNcAVOf3ZryZj+J+/FDL7B9gERySX8XDq26JfpowriFqF6irNNi1ej5upExnf78K9PVD69DHMLgOMeqZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246352; c=relaxed/simple;
	bh=/fB5jas75qAgwriIfaUUpWi3DrcopwRLFv3NAzGkJvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am4ghQ8dNISrMMlfXdPM1qbQ1k3ZVErUyoEHc3/TiA4K/r+FWjKVjBW7qGtc5ULhZVfFtDkM87M2N9nkUeE3C4IpeiX/8Kaa6epc8Zy7KhA4E/OH8qpoaM1KmhiGEy69cXYLDTmga3c7qLQjSFjJDUgTy6FrRwWg0K6BZ42T3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD6Wv2zp5z9sSV;
	Wed, 25 Sep 2024 08:39:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8RozVkktfzl; Wed, 25 Sep 2024 08:39:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD6Wv25Gkz9sST;
	Wed, 25 Sep 2024 08:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 358658B76E;
	Wed, 25 Sep 2024 08:39:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id FR7lY7FiUHXl; Wed, 25 Sep 2024 08:39:07 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 61AE08B763;
	Wed, 25 Sep 2024 08:39:06 +0200 (CEST)
Message-ID: <45dc8060-e5ad-4f8d-b45c-7a9fa3086456@csgroup.eu>
Date: Wed, 25 Sep 2024 08:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] vdso: Use only headers from the vdso/ namespace
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
> The recent implementation of getrandom in the generic vdso library,
> includes headers from outside of the vdso/ namespace.
> 
> The purpose of this patch series is to refactor the code to make sure
> that the library uses only the allowed namespace.
> 
> The series has been rebased on [1] to simplify the testing.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master

This tree includes random support for s390, x86, arm64 and loongarch but 
your series only handles x86 and arm64 it seems.

Christophe

