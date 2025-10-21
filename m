Return-Path: <linux-arch+bounces-14243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41705BF7E7F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD62B3B218C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F334845E;
	Tue, 21 Oct 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="SRu7Npy7"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353FF9EC;
	Tue, 21 Oct 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067901; cv=none; b=qevKgT00rT01lxNFUxRKdVbmtMmSt2OjBgZiGmVew/OHOQvvDYROnquD9NQu9Hmxa2WBYri/LcGmgxI6/oOpwMMAS1R4lNysgqC7k/fmmexGbuFWmVtj8zIKOm8WzeyYN2226MkG6omWr8ipfIPmFCFape4oBAJb/dCTu6ZPCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067901; c=relaxed/simple;
	bh=hltXOIbWWgBTBlvQco48LT2+SFzQye7FM3u76fXl0Cs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fB2vxyi1JYItNrBGFa//IhuUeSzxrcOiePOxsxMvKSCj7ujwuRSUfZYQm5acmmDLALwWC9QSg/atWs9s43JKrpfemMGdEe5SvpVcXRVdXWt4P0eOy4IIgjBVHvW83PYqVIemzXiF7zCDKUDiXIdgdP7+FdkMdmgC638ICQ9YH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=SRu7Npy7; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761067898;
	bh=hltXOIbWWgBTBlvQco48LT2+SFzQye7FM3u76fXl0Cs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SRu7Npy7HxfLnS2UzT8UOEQICfEq8fFhMonn8ojuq2x6uY1SqNw9T7RYvu279i72V
	 Lwqlx30oO7ATXpynvx7oKdcTPd/rdIT4BF8qzcVPuEN3j3El0u8HNPcUPk4ICNU/hU
	 CR9cE3C3hGT6s2WAE7X1IlaYEJsL7RX1Szu8SoEg=
Received: by gentwo.org (Postfix, from userid 1003)
	id F09DD4028E; Tue, 21 Oct 2025 10:31:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id EDE534015D;
	Tue, 21 Oct 2025 10:31:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:31:38 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, arnd@arndb.de, 
    catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, 
    akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
    ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
    memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-Reply-To: <20251017061606.455701-3-ankur.a.arora@oracle.com>
Message-ID: <c8be3663-42db-4c8e-cb5c-b7f28aaefc04@gentwo.org>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com> <20251017061606.455701-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Oct 2025, Ankur Arora wrote:

> +#define SMP_TIMEOUT_POLL_COUNT	1

A way to disable the spinning in the core code and thus arm64 wont spin
there anymore. Good.

Spinning is bad and a waste of cpu resources. If this is done then I
would like the arch code to implement the spinning and not the core so
that there is a motivation for the arch maintainer to
come up with a way to avoid the spinning at some point.

The patch is ok as is.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


