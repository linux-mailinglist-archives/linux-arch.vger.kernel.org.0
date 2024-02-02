Return-Path: <linux-arch+bounces-1985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239648465FE
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 03:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0F41F24B04
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 02:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E85BE56;
	Fri,  2 Feb 2024 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gCsC0g1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4BBA24
	for <linux-arch@vger.kernel.org>; Fri,  2 Feb 2024 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842103; cv=none; b=DRKbB0Mh4HiPb1iOvn60cIuclvFIBDhfvZXmrazCQKTNK8nXh4t9WjhLp5BGuzEtI9prktq7uvmLihhh5ubzEaaJylO0EXgb0Ru67mtD7VWHDNA/g9mXBxAYHkEJopZgmfzunMFtyZU2t7X7+XmLg2lKS3sxgT/6G2ZDBX0BJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842103; c=relaxed/simple;
	bh=zIIpUuEoGAvnfSEBReTZfSlHCEQaoLye+kascfFXjWc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IdmxU9m4C6aRPcoQf57kOqHUvgOxdcdmhttax8CbanyBGBGN3BFg1KOj0AzmCp0wUreg7oEivReHsFAztXBB4c5n5vk+mGVL12Faa8EnsxaLIjjFI5qEh5ar1czusy9Z+Rjb5JbLt6IozhGdO6JfCacOVZXYS/h2VcuwJp2eOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gCsC0g1f; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706842099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7FTBqL1wruOvwY0oHy4r35LgNgIlPN2kq6tk9075c=;
	b=gCsC0g1fiYWL4j1hVqwtCkt8EfpdQt6ijcnoO92PxSnEglzx7yCrIFc3n6eJN2tOuoke2G
	U61IE+3Uy4EyKKfFTgPgLCOqUDMVJt4BMFyurzixOAJhSsqBBWYQ/5zFm/zKDFGSVecJ6d
	r9FkbIzxCE5zhXf6+MDWztFcBMV9yR8=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
Date: Fri, 2 Feb 2024 10:47:41 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 david@redhat.com,
 willy@infradead.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A7CAA1CD-8BD2-4517-BC37-F13E4D9C00CF@linux.dev>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 1, 2024, at 16:05, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> For kernel PTE page, we do not need to allocate and initialize its split
> ptlock, but as a page table page, it's still necessary to add PG_table
> flag and NR_PAGETABLE statistics for it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


