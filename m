Return-Path: <linux-arch+bounces-10071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B995A2E22E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 03:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD873A5AA1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 02:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181A22EE4;
	Mon, 10 Feb 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qc6Ggwih"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879B22301;
	Mon, 10 Feb 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739153843; cv=none; b=UMet7yriTkPkQXAKIxr9RRWsjkAEPgMuOgngC+mB2YbqCPA3jFWWAuySXgE0objdFMjaLRis3Ln85K9ZoMGxQrWAPlKdiSx3Cl5BcjpMlI5da0dhUOOeNoEwg8lWFlhO4CM5mGc7MiMiX+0CN8FvnoLN87tqjrnx1jU6gowxvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739153843; c=relaxed/simple;
	bh=OonBsXVcqw16AkZT/JvRk7VH9bQnPgHVTelt+TYvzWs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZOqyuKC08XokRlTvocDUXJSllOpuTPev4D0Yb9jEstB61rMJA/sCWNURE3OD1tdHVOK+oX6/oHR/u7f2EdPlUGt476lsFxs1onOP75c8eaBnyX8NCY44WPfBCPO8ITzkkpQVNSlOtb/ONV0MUzZ/XNBOYXFmcTSrDOlmNXKg6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Qc6Ggwih; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51A2Fa0Q1936056
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 9 Feb 2025 18:15:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51A2Fa0Q1936056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739153739;
	bh=OonBsXVcqw16AkZT/JvRk7VH9bQnPgHVTelt+TYvzWs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Qc6GgwihV10i/7iazZlJA9de3OWWVwwezsmDbahCRSGSF/fy+K3tCR/3FaKyLCsei
	 rUt6+42N2gWeJe/slRPW4qi4hVCcnLwgbDbm/HqMCUuByHAFIeJuJSvaj022R+hRP4
	 xbNgbAWQQJiKjraN8//YXCHE3XSlmHczw7ylhpNz0JzGIguW9FRcUU2HlEL+WoTVyF
	 69oDbl/RiaKs3aPskzcedIu7tOhKjmDb/+5GYk+ol3XtOo6IWHTWQRYN7cngOMt5E9
	 uwa8JNmeidCmOCv2ODKFcJnWt2iVtYuNbaLcAN3jyw2OD3xHmG3jvlKx6W7JyqiR89
	 B74KZOx7gH4oA==
Date: Sun, 09 Feb 2025 18:15:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <david.laight.linux@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-arch@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
        "Paul E.McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/1] x86: In x86-64 barrier_nospec can always be lfence
User-Agent: K-9 Mail for Android
In-Reply-To: <15734b32cecddde7905d3a97005a0c883383cc74.camel@surriel.com>
References: <20250209191008.142153-1-david.laight.linux@gmail.com> <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com> <20250209214047.4552e806@pumpkin> <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com> <15734b32cecddde7905d3a97005a0c883383cc74.camel@surriel.com>
Message-ID: <119B5F1F-7319-4C28-8A91-EB570BF5ABEB@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 9, 2025 5:09:51 PM PST, Rik van Riel <riel@surriel=2Ecom> wrote=
:
>On Sun, 2025-02-09 at 13:57 -0800, Linus Torvalds wrote:
>>=20
>> So on x86, both read and write barriers are complete no-ops, because
>> all reads are ordered, and all writes are ordered=2E
>
>Given that this thread started with a reference
>to rdtsc, it may be worth keeping in mind that
>rdtsc reads themselves do not always appear to
>be ordered=2E
>
>Paul and I spotted some occasionaly "backwards
>TSC values" from the CSD lock instrumentation code,=C2=A0
>which went away when using ordered TSC reads:
>
>https://lkml=2Eiu=2Eedu/hypermail/linux/kernel/2410=2E1/03202=2Ehtml
>
>I guess maybe a TSC read does not follow all the same
>rules as a memory read, sometimes?
>

It probably doesn't, at least on uarches=2E

