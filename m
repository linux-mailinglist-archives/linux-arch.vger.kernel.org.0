Return-Path: <linux-arch+bounces-6962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8D96A267
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8E28206D
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56A194A5A;
	Tue,  3 Sep 2024 15:23:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DC194A4B;
	Tue,  3 Sep 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377027; cv=none; b=hnVjKxsUTLWF4tSHasYpJ1RAWTRLf/P6jieBmJN1+mZi8CfkVb8arOOnA0WYSkint7rTzcj5Vp9To7f5xE2rd+/aTv0qPO2A3VF3Q9L9bA3X0qztTYCKcYyiNKy2Zzv8LwQweVGY2jkA+XA8DXRedfqZx9A1D2GyK3lSuYbus3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377027; c=relaxed/simple;
	bh=dnEKtRjj1Zkc12HzhKlC5AqBoC1c4+RRUDJvRg4Eztw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFJ3UrO0+NM8oGxrnoHfxuZFfS1N+T2tv3nB8i98KG5eiUkqi4bek3uvEjEkH2BDg7SBy8ZCotcxTIOBW8rLSmPHQNg8H8bpK+PGy1nigBHBHDxFRbxp7btE+/EF8ya4UkvEq76p9D8LwIuTZjcYE9NwQOq2XqLH5yJJAKrwxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B793EFEC;
	Tue,  3 Sep 2024 08:24:10 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9892D3F66E;
	Tue,  3 Sep 2024 08:23:41 -0700 (PDT)
Message-ID: <59945d5a-8251-449a-b75e-878e6c50584e@arm.com>
Date: Tue, 3 Sep 2024 16:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] x86: vdso: Introduce asm/vdso/mman.h
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-2-vincenzo.frascino@arm.com>
 <CAHmME9qvj9r71G3QOvQm8dqAsFROWGT0BDU=89MWyEUdAQbBZQ@mail.gmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <CAHmME9qvj9r71G3QOvQm8dqAsFROWGT0BDU=89MWyEUdAQbBZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2024 16:16, Jason A. Donenfeld wrote:
> Christophe explained the issue with this in
> https://lore.kernel.org/all/85efc7c5-40c8-4c89-b65f-dd13536fb8c7@cs-soprasteria.com/

And I think I replied to Christophe here:
https://lore.kernel.org/all/632b8da1-c165-4d17-804f-4edf1438d55a@arm.com/

Can you please explain what you are referring to explicitly?

-- 
Regards,
Vincenzo

