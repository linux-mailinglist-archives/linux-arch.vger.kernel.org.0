Return-Path: <linux-arch+bounces-8916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD59C1408
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 03:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F38284A1E
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9651CABF;
	Fri,  8 Nov 2024 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="LDk3Byiz"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CA1BD9D1;
	Fri,  8 Nov 2024 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032758; cv=none; b=gwio6zT2pLEPppkTpogTwQNe30+qrcXKriyJYm4t6IAXmrPG6vm8GDqQth/OqfM/2KV/smgnrTqyHK2rUpovEvogcRgmjH6cx40+y04b6SACe7Z+5ieGNOcakkWFYDodiThPahmQWANszPBECRbjliX4ySS/UCZWwGbbEjtHSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032758; c=relaxed/simple;
	bh=SWfO8QKNiUh3tSfBP+ujLCZPjULvdzRieaxb7RSVPps=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=utYmsojAMa/yUTrXJdvfaRdkbkQvEjp9hxVXB3CJpo2ZyrhSv7W5cVi6wgwJHgbpaEebV8PdhuBw6QGCNc4ZWN5lzZcKoQZ26ncoVx/cNAZFnqqYZcRXuKgZbssMMMJgV05VpuvnKD+JPg9HzgMaJdZSctssbO8EfWORg/BZjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=LDk3Byiz; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1731032748;
	bh=SWfO8QKNiUh3tSfBP+ujLCZPjULvdzRieaxb7RSVPps=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LDk3ByizwoL7zjEeeTcxEYJJESMkTxCPLUA0Y932pS5cSm5Ew4HvCFiFPXxbWPJhO
	 8StFtu5g+LHwDbqoUfxUBf7f+nDADFp0kHR6o6hl0GGu2FiSbDph71/atX/OSq99wD
	 GOoRyf4NvcCIL7iuxPuyc6g0s8/ptAX0XuSTp/Tc=
Received: by gentwo.org (Postfix, from userid 1003)
	id D7D454027B; Thu,  7 Nov 2024 18:25:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id D4546400CA;
	Thu,  7 Nov 2024 18:25:48 -0800 (PST)
Date: Thu, 7 Nov 2024 18:25:48 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
    tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
    dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org, 
    daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de, 
    lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com, 
    mtosatti@redhat.com, sudeep.holla@arm.com, maz@kernel.org, 
    misono.tomohiro@fujitsu.com, maobibo@loongson.cn, zhenglifeng1@huawei.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [RFC PATCH v9 14/15] arm64/delay: move some constants out to a
 separate header
In-Reply-To: <20241107190818.522639-15-ankur.a.arora@oracle.com>
Message-ID: <db90518c-a0e4-02cb-87c8-ea2609960dc4@gentwo.org>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com> <20241107190818.522639-15-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Nov 2024, Ankur Arora wrote:

> Moves some constants and functions related to xloops, cycles computation
> out to a new header.

Constants are correct...

Reviewed-by: Christoph Lameter <cl@linux.com>


