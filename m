Return-Path: <linux-arch+bounces-9548-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D95D9FEBC5
	for <lists+linux-arch@lfdr.de>; Tue, 31 Dec 2024 01:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3003A27DE
	for <lists+linux-arch@lfdr.de>; Tue, 31 Dec 2024 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB32913;
	Tue, 31 Dec 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e1svhMQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2164A;
	Tue, 31 Dec 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604658; cv=none; b=edgyLTGsiuSuz2pf5FiWM4BsqYMLyNpKm3CjxarCPr8b7X7wQvq5kTWAdZlV64ZDO/g/n8+3xLokeUNIbdTD/iqO+a9p78LILkKdeSlYqAraExPDonlwDFhmsqVYb/1xpZSgOlBbMBFRJxrTvZiGrcfRth1Vdg5oWF1UIORUqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604658; c=relaxed/simple;
	bh=2Z/3V1q46cErKadoV3y8VtC0UOopLVjvmzLFmpjI5ZE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Cbou3nRo1tLpAMkw0B1xahgAVl9ZYMpbkp98X1Hqoh1atwPcvnIYodRrVZ++pauLIbjhr8lfefmxo2CjB448/NHCmDZJaHOcW896QLyIiFEppBuSvPOgWqNQKZxRK1ZklJ7iACA+yHYYLFdFCpe7S++lU95620V0TMZBykMTBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e1svhMQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97495C4CED0;
	Tue, 31 Dec 2024 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735604657;
	bh=2Z/3V1q46cErKadoV3y8VtC0UOopLVjvmzLFmpjI5ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1svhMQUmdhMgcQjt88gUZcpq5ze2FpENDmeroTm5j525bnUbXasg93NeBqNAKuwX
	 4zTZ6tN5Yr2qdY61qOZxnyRQ1159nEMzAQ1YQfsHm2DW8ARwWXBuvfim5detOnI3XI
	 EB0PhrLFTgZnLoKq75DG+Xuc3x8ekQPiOw33OnkY=
Date: Mon, 30 Dec 2024 16:24:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 palmer@dabbelt.com, tglx@linutronix.de, david@redhat.com, jannh@google.com,
 hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v4 00/15] move pagetable_*_dtor() to
 __tlb_remove_table()
Message-Id: <20241230162416.da83460318c4726f65fb4e3b@linux-foundation.org>
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 17:07:35 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Changes in v4:
>  - remove [PATCH v3 15/17] and [PATCH v3 16/17] (Mike Rapoport)
>    (the tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are intermediate
>     products of the project: https://kernelnewbies.org/MatthewWilcox/Memdescs,
>     so keep them)
>  - collect Acked-by

Thanks, I've updated mm.git to v5.

