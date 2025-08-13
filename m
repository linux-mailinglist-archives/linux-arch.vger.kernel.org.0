Return-Path: <linux-arch+bounces-13161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E818B25199
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106E1585D17
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E7305E1D;
	Wed, 13 Aug 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="MuvLHElZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F7302CDF;
	Wed, 13 Aug 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104544; cv=none; b=U3Wzs3cE9hIoB4WC8HpNVbmRYKY5mRfJge4EIpGtBkiMMgp2KAjzyx9ziMZU+yFyXgGeCa2qKai/UfhSY5CDsfAFIr6GyiCUtNI3omnEUlFVsa0wyEFvwkaQIrxwECjq+xkZ7cUfED581P0tbZ2ahcvUIiUC4sESV9fVHRdJnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104544; c=relaxed/simple;
	bh=WGrKcUl/Wvx3TiCpmjIl2Pof2fd57towgC+IHdtL1ag=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QgHRfH4lH/h3Vvjf0OdK6xdMM/K2P7G9Qg+kDE2xFaWrAJ75imp798CrTr6C0X+EK9aOBYZGTW4wOHd5ECD/oiKUM/kMHaEjJcQqpZvksOh84UNwBJShv5wmVnGfbllIAT3XYiL8lvCh20C0IOuXcSSYT5kiq2eFIj5QIU3K8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=MuvLHElZ; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755104052;
	bh=WGrKcUl/Wvx3TiCpmjIl2Pof2fd57towgC+IHdtL1ag=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MuvLHElZGRDWFnCVT+NnlI4W1mHq8Ana3HPCeK9yoKM3itBo63t8EmK9V0Gjjig4N
	 aDnFxVINYAGe8PT4NaDbWoR7XM9bSscicq8jYUqq/EAPxHPr7sLS/oWfJ+RQScdTJO
	 x06fSt4M4hlFa/hNyjK4d/BfPPUfKxxh6torBlDk=
Received: by gentwo.org (Postfix, from userid 1003)
	id 88AB9401FB; Wed, 13 Aug 2025 09:54:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 87A7D4010E;
	Wed, 13 Aug 2025 09:54:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:54:12 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
    Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Mark Rutland <mark.rutland@arm.com>, harisokn@amazon.com, 
    Alexei Starovoitov <ast@kernel.org>, 
    Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com, 
    xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-Reply-To: <67b6b738-0f1c-4dd4-817d-95f55ec9272b@app.fastmail.com>
Message-ID: <e4f4cc15-194a-5203-c9a8-c9cd0334a922@gentwo.org>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com> <20250627044805.945491-2-ankur.a.arora@oracle.com> <aJXWyxzkA3x61fKA@arm.com> <877bz98sqb.fsf@oracle.com> <aJy414YufthzC1nv@arm.com> <67b6b738-0f1c-4dd4-817d-95f55ec9272b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Aug 2025, Arnd Bergmann wrote:

> I think there is a reasonable chance that in the future we may want
> to turn the event stream off on systems that support WFET, since that
> is better for both low-power systems and virtual machines with CPU
> overcommit.

WFET is coming in with V9.something I believe so its good to be prepared
and it will simplify the logic.


