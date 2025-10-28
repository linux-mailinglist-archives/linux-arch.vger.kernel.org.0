Return-Path: <linux-arch+bounces-14385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C5C15CE6
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067D4188B097
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24B285058;
	Tue, 28 Oct 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="PUp2zKMD"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3216F288;
	Tue, 28 Oct 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668512; cv=none; b=LMCZwQcIO9zTQbfAoZVv/Y/BdtD0k4tZTStQX30bQGRYurYrL0MpYesqCaObMHDqe51oVpRCHTuriVT8L3Q7sRkrHKBXRmGEnOsXR1pidWJQVAf1kedJ4D3ENmLxE8smNJtnfK/vWZyA+d67UhQJNAshr7XDVhGLcB3QFFLlnNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668512; c=relaxed/simple;
	bh=7ap44HjH0YVkd/U/xEEXKG+E/eyCWGHQhfiU2g2gC+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FlBPjMps1wLl3eWMP4meP2qqb8SbIsTEU1Kglgl1AmtP+fdfxpbZO6hvEw/+IqPBgs7r4zUR1BONdbGwmjh82T6dqAvmB/Jl53vPvuUYm+CcKWqz4ywHKjAajLCSIQaO2CH0Muh48yzQJuACdANgldoCYKxEKDjPMrVv587G1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=PUp2zKMD; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761668510;
	bh=7ap44HjH0YVkd/U/xEEXKG+E/eyCWGHQhfiU2g2gC+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PUp2zKMDVkgsfqqbu0QS4ubCJqzkNXG8lZFZBzraFOsZzmaKQceSqL+JtksJLsT9A
	 ffsdhEajqsL8bl4PDNRqP1qNlWtZ/Z9uxRH+8XTl6M7LY0jQ4rqqhWAtZa/cpemygO
	 X+LwwJfxjDE907dfXDJ6SkH4X2Vx9m8NOD0EyeO0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 56CAD402C4; Tue, 28 Oct 2025 09:21:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 55B4F402BD;
	Tue, 28 Oct 2025 09:21:50 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:21:50 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
    bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
    Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Mark Rutland <mark.rutland@arm.com>, Haris Okanovic <harisokn@amazon.com>, 
    Alexei Starovoitov <ast@kernel.org>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com, 
    xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-Reply-To: <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
Message-ID: <82febb6d-ba14-6a23-1955-9d505372dc23@gentwo.org>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com> <20251028053136.692462-3-ankur.a.arora@oracle.com> <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Oct 2025, Arnd Bergmann wrote:

> After I looked at the entire series again, this one feels like
> a missed opportunity. Especially on low-power systems but possibly
> on any ARMv9.2+ implementation including Cortex-A320, it would
> be nice to be able to both turn off the event stream and also
> make this function take fewer wakeups:

That is certainly something that should be done at some point but for now
this patchset does the best possible with the available systems.

Switching of the event stream is another set of complexities that should
be handled separately later.

Lets just get this one finally in. We have been working on this issue
now for more than 2 years.


