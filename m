Return-Path: <linux-arch+bounces-7761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B790C992B31
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B442840C0
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B741BA285;
	Mon,  7 Oct 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZ+I7tmS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNYj2nxJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19C18B473;
	Mon,  7 Oct 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303154; cv=none; b=YH7ZMMYm5MO6nmx8m+iEvzzzwxcSkA7Q1sNirI2/mT9DvH87KPJNJROtiAivtQ5fcHS3WDTJ1uYu5+HrItTP0ERGALLjBSZNSO6ZfBiD1BxWFssRHOiW2k0M0yKl5f/HbkY/6BhbOvacBaEn/lJOfPNdCj8eVrS+/+Pg+q+FhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303154; c=relaxed/simple;
	bh=/3gF5WSmnrMC8RcaEvqsqk+3dQTWVF6TB6HixTIyzUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oixj9bNt3qmYsn+HJDtBfPIyd2fWJttkpJGmeWko6thA1pNkBu+kU8f2kwLeyZ5KLJIs/rkveav5/wGGZCoaLe5pkISteOotEMDT68DyL4q0w04o/TZYPmd9Z1fe2uhk1+vUh04pybFDDLpqq9+DdAWzr4s2I8Q1gBXbkYUlJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZ+I7tmS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNYj2nxJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728303150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3gF5WSmnrMC8RcaEvqsqk+3dQTWVF6TB6HixTIyzUQ=;
	b=yZ+I7tmSNp0OEdpVbfMNMpE1KLZqDeaPAkjXo3TWv1Z8S84RijJEm1e91q9q3iCI1/rXwU
	0VhW7MhJWHv4Uwpx7L8rdRfmbeZ6RiwFaSKrIOhldOvEcEwUI5IvcFHpNlSk+5i2FVBuPv
	Y+vmxuazFnzVCtSyVUxH37wNZpi1r3RQ2iKKmsBjN83B0x5UhROgJa5qCe1Yvg7Hf+yl3F
	BTTYKFkLO4diFj5FYSO9grAIVqCrpwksvK4zUIvnJUpyNl68nrzCvyDLVdhuYitvoeq7mc
	EjLwbnwULS0l2/JdlXmI4thmRPlLs3MpoS3etcCs+BMY0dpmJImlGwJyX8spDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728303150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3gF5WSmnrMC8RcaEvqsqk+3dQTWVF6TB6HixTIyzUQ=;
	b=JNYj2nxJfb8A27pC3yl8EJnMNSG4yMLJs2FJgLaDMvQh+DsD/g/YiZ8VSddjrBW0AfSftG
	wlBFs1Q36PnhslCg==
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, x86@kernel.org,
 Borislav Petkov
 <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
In-Reply-To: <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
References: <2210883.Icojqenx9y@gongov> <878qv8ypkl.ffs@tglx>
 <864022534.0ifERbkFSE@gongov>
 <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
Date: Mon, 07 Oct 2024 14:12:30 +0200
Message-ID: <871q0sun69.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04 2024 at 12:29, J=C3=BCrgen Gro=C3=9F wrote:
> From: Juergen Gross <jgross@suse.com>
> Date: Fri, 4 Oct 2024 12:22:12 +0200
> Subject: [PATCH] x86/xen: mark boot CPU of PV guest in MSR_IA32_APICBASE
>
> Recent topology checks of the x86 boot code uncovered the need for
> PV guests to have the boot cpu marked in the APICBASE MSR.
>
> Fixes: 9d22c96316ac ("x86/topology: Handle bogus ACPI tables correctly")
> Reported-by: Niels Dettenbach <nd@syndicat.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

