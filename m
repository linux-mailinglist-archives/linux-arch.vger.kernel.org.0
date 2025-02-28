Return-Path: <linux-arch+bounces-10464-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3CA494CF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 10:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F361894F2A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD3256C9C;
	Fri, 28 Feb 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lGT3I5C6"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098E25335E;
	Fri, 28 Feb 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734663; cv=none; b=lOIjdSnTH0BvZjKYaxdKNzcKL9h1nmE9DSWC40fdyBYpPPyXN8s2ieLKkbSaZS06nL98fkqjoQQurURf2KLTJ7goC9uUmG9szHqN4sdUF1CkldtPCFtPK78apsqqCX9HrWwK8/aXgWFiPYm6SU4soBTTPHnIJGoVsU+ragwOEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734663; c=relaxed/simple;
	bh=/jeHPGx6jm3R1xDJMMDaYjvBALHQReLwn93izWT/Byo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3nxNTGJgXWRGkTndFnGMCFISUT1tCd9SUZhXmwEUtKnHS5rl15lR1uXf+kWn9u0KSwD0mfiA1kWM999Cv2AQBKHrib7xu2bc0XKqpN54ScllE3MDVp6r5u2d5o3F3/8zUw3bTNYDUcfuLdzoCuzS1bLVzReoe5OjaZs6YO1bc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lGT3I5C6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/jeHPGx6jm3R1xDJMMDaYjvBALHQReLwn93izWT/Byo=; b=lGT3I5C6xKvNBqb7eUq6t1oyMA
	TKIoHFnWDeq6k809BZtIhypUMx/9yIkACdkXQsfqZYh7cwTuKb8ur/v3r/e5h0DhBJ7GTxELBBPEU
	PTDcCY+uNMxYO7Xe+1tKuuw7l8JEuOEXdotDmQ4ZVDppqjXNnkVBRnI2BabPZrL1epAJperOINnok
	HMNUOGxzSMonqZ/qtdGSBxtHwSbHx0UdOrL4iRIGbukCttTLYAOvEFxW0+Egs5aypmVtYUFOJ9K/u
	w8uSkvz+kQfsap8Fz6keuxovTlnUfUO3DPZs4jiUEUryiItJ/OScuvrcSrd/yiSegPuDFjnc0M7a/
	VThUpajQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnwbG-00000003wMH-2wNy;
	Fri, 28 Feb 2025 09:24:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E673D300756; Fri, 28 Feb 2025 10:24:05 +0100 (CET)
Date: Fri, 28 Feb 2025 10:24:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 2/9] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <20250228092405.GE5880@noisy.programming.kicks-ass.net>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-3-lyude@redhat.com>
 <20250228091509.8985B18-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228091509.8985B18-hca@linux.ibm.com>

On Fri, Feb 28, 2025 at 10:15:09AM +0100, Heiko Carstens wrote:

> I couldn't find any cover letter for the whole patch series which describes
> what this is about, and why it is needed.
> It looks like some Rust enablement?

Yeah, more or less.

It's replacing local_irq_save() and all related functions
(spin_lock_irqsave etc..) that take a flags argument with this new thing
that frobs a recursion count in preempt_count(), obviating the need to
carry the local flags argument around.

This is nice, even for C code, less flags muck to carry around.

It would be even better if they then went and deleted all of the _irq /
_irqsave nonsense entirely.

Yes, that's going to be a big patch :-)

Also, IIRC there is some arch stuff that comes unstuck if you do this
blindly (I tried at some point, it didn't boot).

