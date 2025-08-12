Return-Path: <linux-arch+bounces-13148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715EB23C69
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 01:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94E91A261AA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB272857C1;
	Tue, 12 Aug 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7+b0Qzm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BA4C92;
	Tue, 12 Aug 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042432; cv=none; b=oX3puKIb4w3QMHq8oFXiW670X+naQ/OrbWIeseLF7gc8aeWNRRXcHq54uBlmVbMF+JaaXsw7zi3UyLuS+/P4gG+Dvq20n6IDjL1U8dz14m3qe0uHwCCCgeD2jJY5vkJsr2yWp4sVviUe/aqbm46E+PEWY9RRfHnuubZwRPDndno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042432; c=relaxed/simple;
	bh=6/+orTgGYBQfHXPoerjO8V9IKyQHK1j/VpihArC4tGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7RZux2Lx29gB/uECp1UHi0bMwxVqYJNOAVYnhrQrPre/yyTxnXEna7hoqTx2FZ77MI/vG3wh7+3e2QLElgNYb5AslI61apm8OU0esWaAo4Bxasy8//6R9bEmRHZEVHKyfcyy1S4ZAI7YVKAaISRyyTDhqgjJmJZqWfWHqL/Jpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7+b0Qzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4825FC4CEF0;
	Tue, 12 Aug 2025 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755042431;
	bh=6/+orTgGYBQfHXPoerjO8V9IKyQHK1j/VpihArC4tGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7+b0Qzm64vGjtcIXKsO7ef+X3Cj0DsR/4Nq/RPnvkMLFHcmJBxhHkrnTTxAjDTDV
	 dvVMxJO95zCT/bfXQQarkH4bvygThDl4uVqROsi5qMKA06UislR6SVRssodHiZotfn
	 ohk1jjxyHAP02diqTrAUkPQfFuG1ovB1mnM1+rPlkZJzko0wiZ9Byu0w8mPUSAlBI/
	 zW9ymEWAybMq6DrgZRGyrwJQhSeLZj9X8pPSqXfUXU5nK48cvhbz7VOW1dIP08lCBw
	 Ow+jiKV4pTqa2B2YQ9p7lfrsl8iugrKdBZPyPQvKH2CIf9DEG0JQaGzm3SSPwY/3U2
	 e/n/s7l+MAagA==
Date: Tue, 12 Aug 2025 23:47:10 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com, Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V6 0/4 Resend] x86/Hyper-V: Add AMD Secure AVIC for
 Hyper-V platform
Message-ID: <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250806121855.442103-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806121855.442103-1-ltykernel@gmail.com>

On Wed, Aug 06, 2025 at 08:18:51PM +0800, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
[...]
> Tianyu Lan (4):
>   x86/hyperv: Don't use hv apic driver when Secure AVIC is available
>   Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
>   x86/hyperv: Don't use auto-eoi when Secure AVIC is available
>   x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

Are they still RFC? They look like ready to be merged.

Wei

