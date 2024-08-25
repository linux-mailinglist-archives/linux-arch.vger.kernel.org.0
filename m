Return-Path: <linux-arch+bounces-6584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3C95E329
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2024 13:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FB3281D5F
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2024 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060EB143755;
	Sun, 25 Aug 2024 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQ2h2jQM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DL289A9E"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7E143740;
	Sun, 25 Aug 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724586749; cv=none; b=sK+QEXXkzFBm5BFU0SBs9XL5Oc9J8FHB7/SLj80sDgvUIXIbtWcU2f/hnsg8evTnWRzspDHRI5Pau+e2LT0EtGyBXo7ikyUgMIN8Lq6O4wKgZJ5gxejzsc86aCK16Ok8sBT53VcLcNshqBkABzQZPX5Wr+ww+tFHeytTiiYaEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724586749; c=relaxed/simple;
	bh=wcfJEOEK/OVFU9E0skQRjHALsyzqGuvuGOQZ8DvQiQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ku+NrH8H3jBGALClvUR7dLfFsxIEIlgFWzXMnlLfXcA6mGisXyhks+me0IdPkD/IZDBIbA6RZlURM1rdui+rq0f+xdjZCC8QZtRZ5h8DXS2ipG06Hto1CWjGy4mOtbXfnJmdWlJ8aaCzDSKzYKbl1vFiiQTxE6Dx1dxUY0w3zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQ2h2jQM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DL289A9E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724586746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ldBgTs8Tk2fbqUbBu8bF82g0r8dVN8CCueqSsUf5M=;
	b=oQ2h2jQM93DzsxgJjVsgviGy1RNH/XdCWJdNvahneWZQju/i0dcSNeReXz1Tm93C6YNmIR
	gvvL5eqL3Q7zLRJ0nOndWmVSTaoR/4sEZIs5PVI4I8/jq3FMuBZ+0ROiotbd6Kkt0bvSJg
	vtYjtp7w52XXTGmEsKSw9iCON+MP7IqwnqmhX5JSHNWsEl0erRhJPnijoppWsVeiqvwBPQ
	t8jPmgpRL9hIRn9KRLL3le3uOnQPARvfnvihwe03+iud1IBGSgf1dPwnjnO2c7t5e/spS7
	IltNumUbVNOIz6WAzp/JWk0U0/u0MRe9JJztGPSFCtqb3OOv082o2/OfC3LFCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724586746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ldBgTs8Tk2fbqUbBu8bF82g0r8dVN8CCueqSsUf5M=;
	b=DL289A9EY5v+PCgODp7o87ZmPdhY4czZmZ+XJrpwdjxWFC8KGEUs8DdIRZCJVaroUQJYth
	dH91vnXc9X4DQIDQ==
To: Wentao Zhang <wentaoz5@illinois.edu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org
Cc: wentaoz5@illinois.edu, marinov@illinois.edu, tyxu@illinois.edu,
 jinghao7@illinois.edu, tingxur@illinois.edu,
 steven.h.vanderleest@boeing.com, chuck.wolber@boeing.com,
 matthew.l.weber3@boeing.com, Matt.Kelly2@boeing.com,
 andrew.j.oppelt@boeing.com, samuel.sarkisian@boeing.com, morbo@google.com,
 samitolvanen@google.com, masahiroy@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org,
 ardb@kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, arnd@arndb.de, rostedt@goodmis.org,
 mhiramat@kernel.org, oberpar@linux.ibm.com, akpm@linux-foundation.org,
 paulmck@kernel.org, bhelgaas@google.com, kees@kernel.org,
 jpoimboe@kernel.org, peterz@infradead.org, kent.overstreet@linux.dev,
 nathan@kernel.org, hpa@zytor.com, mathieu.desnoyers@efficios.com,
 ndesaulniers@google.com, justinstitt@google.com, maskray@google.com,
 dvyukov@google.com
Subject: Re: [RFC PATCH 1/3] llvm-cov: add Clang's Source-based Code
 Coverage support
In-Reply-To: <20240824230641.385839-2-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240824230641.385839-2-wentaoz5@illinois.edu>
Date: Sun, 25 Aug 2024 13:52:26 +0200
Message-ID: <87bk1gg6px.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 24 2024 at 18:06, Wentao Zhang wrote:
>  Makefile                          |   3 +
>  arch/Kconfig                      |   1 +
>  arch/x86/Kconfig                  |   1 +
>  arch/x86/kernel/vmlinux.lds.S     |   2 +
>  include/asm-generic/vmlinux.lds.h |  38 +++++
>  kernel/Makefile                   |   1 +
>  kernel/llvm-cov/Kconfig           |  29 ++++
>  kernel/llvm-cov/Makefile          |   5 +
>  kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
>  kernel/llvm-cov/llvm-cov.h        | 156 ++++++++++++++++++
>  scripts/Makefile.lib              |  10 ++
>  scripts/mod/modpost.c             |   2 +

Please split this into two parts:

   1) Add the infrastructure
   2) Enable it on x86

Also the ordering of this patch series is wrong.

First you enable it on x86 and then you mark the places which cannot be
instrumented. You really want to do this in this order:

   1) Add the infrastructure
   2) Prevent instrumentation in drivers/firmware
   3) Prevent instrumentation in kernel/trace
   4) Prevent instrumentation in modfinal
   5) Prevent instrumentation in x86
   6) Enable it on x86

Thanks,

        tglx


