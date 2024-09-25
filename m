Return-Path: <linux-arch+bounces-7393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530698534E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE12282F43
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147FB156222;
	Wed, 25 Sep 2024 06:56:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96967155333;
	Wed, 25 Sep 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247372; cv=none; b=buxFfRKSGPTIuIzhTzpGssfNotRiQ8gTdZkv8l9lJbP5Jk3PoAOUFEEX3DxPxT86KriMDVFB88x3nDXB3S1myUtOHEtmGqo4rvHynIgjLhYHMFybymMa5ZeiGrN6w27NbAKmpnHIMCuwESHqTRxKmlyC/3G2upxu/Zr1Vp/UcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247372; c=relaxed/simple;
	bh=ywm8MsTpWtLtdCnCp1uCSH6B4TBbne4q8r3Lh7mTMXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxeELFW2oW4mQVzi0aQsZeUN7REDOdURXvjRgiUL0sQrjYw4pYdcNAF6z2OcjRhgXRcCkaXtTbEr4HMeg+U9ZiwrYmryZraKp+xmtpbKF4E4rXwX9yFo0c2bAcA2Ko2YvYaFjyxSopycI5zab3RKCZn95p44tPcg/u1l/nL+0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD6vX6ldgz9sSd;
	Wed, 25 Sep 2024 08:56:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ysTbM_bUh49K; Wed, 25 Sep 2024 08:56:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD6vX5wyQz9sSc;
	Wed, 25 Sep 2024 08:56:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B8E8A8B76E;
	Wed, 25 Sep 2024 08:56:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LVlMeYO2MV_A; Wed, 25 Sep 2024 08:56:08 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C90648B763;
	Wed, 25 Sep 2024 08:56:07 +0200 (CEST)
Message-ID: <db41387b-f705-4855-b6fe-1d57547f6844@csgroup.eu>
Date: Wed, 25 Sep 2024 08:56:07 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vdso: Introduce vdso/page.h
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
 <20240923141943.133551-5-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-5-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Introduce vdso/page.h to make sure that the generic library
> uses only the allowed namespace.

This patch looks good to me, maybe it is worth some more description, 
for instance to explain why PAGE_MASK has two different definitions.

Christophe

