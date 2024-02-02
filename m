Return-Path: <linux-arch+bounces-1986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33111846671
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 04:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653971C23B8B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C4C131;
	Fri,  2 Feb 2024 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fD8ihIZV"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF72F9CE
	for <linux-arch@vger.kernel.org>; Fri,  2 Feb 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843805; cv=none; b=lI410juEKi5EROx9prpY431oz5jxNc5R+EgOnGUItaIL52jzLFjAvhvCiU+V/+d3NJ2MARfkGXBqVzdnbrB2wMMZeL8zbPr1rTfRWPOyypfq41gByIitY4hDFyj8NAiMkxqMgKxSLTLhtONC9KrKjPbf4AB44FXrNKXPyEWj9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843805; c=relaxed/simple;
	bh=+HM6b3J4KRsVwmwcl2Sz7q6Tzn+kSIwtUuSs2wF92vE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uYlRYCZ0r/FVnL4dRF69n+m5JnX042VZ/AUtsOwZa0+mcRutgcHw0M5IUgNjNVc7iUy7S/tTAhNlZWpe4uO9b3Qazp3TPH65Qqf7KKHF6CP49bMpcv/DFBrnFor3tU09RjEMOrt1b+ozbMUjAOQ0KfZsS83KKkt56SUAGphLMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fD8ihIZV; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706843801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrrbzyhWydlS8Xk/sEBJXzD8ErCx+QyvPiHcxbCKTO8=;
	b=fD8ihIZVvkBd1uw8RGSQLSex9Hr25nnHMFBhxkXWVRjZFMYpeZMheeDc2dha3/ZOctwEBu
	4eDhdSNfHMCpH3yKsk8Hu7lkh4ybOxZOHVyDk7hrSj/0pUK6IelR3YsmjRZ8xF1QyPbnJ4
	9IqwEZWWmZHmIbqPbYBn/rQeDXDpD6c=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] mm: pgtable: remove unnecessary split ptlock for
 kernel PMD page
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
Date: Fri, 2 Feb 2024 11:16:02 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 david@redhat.com,
 willy@infradead.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <996AA3FE-47DD-408E-960C-EB805DBE8EFE@linux.dev>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 1, 2024, at 16:05, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> For kernel PMD entry, we use init_mm.page_table_lock to protect it, so
> there is no need to allocate and initialize the split ptlock for kernel
> PMD page.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


