Return-Path: <linux-arch+bounces-9530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F99FE26F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 05:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C8D161A3C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 04:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833413C82E;
	Mon, 30 Dec 2024 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rhe3QlxD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972913633F;
	Mon, 30 Dec 2024 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534548; cv=none; b=GjfPfIskX5O1SfKqF72cG51/hlxSSNoEqvQdMshhrUFBUtB3RbLWwYwHhUuJf1pTPrclDLIcGV9PLaKJo0NtGuadJjxtQ5SGnOzy9cVoD4Kwu6Dgours5O+hwrfy9wbtCLPy4hHL5KXi6wwLmNUvdM/XRevY4HvMHkIr1edRbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534548; c=relaxed/simple;
	bh=AJswIJAQd5FETiIh0u+rfDfZfqamfQp06InUDAPDuXA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b+JjTqKCZVchG7ZZlmUmndAxreL1/piroF8I1stE5Mch0D6pjRpUPVEATm6p+1NVrfApLGTb2B5kgdELdQ4FXELLbK4v6eJNFsuUBBHDXPG2Perq7W//mOI/Em5Z/2UsKbm3LIFfN/EHGfm/ITNthahOKUc7Io/5dEZcPI4vDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rhe3QlxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0FAC4CED0;
	Mon, 30 Dec 2024 04:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735534547;
	bh=AJswIJAQd5FETiIh0u+rfDfZfqamfQp06InUDAPDuXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rhe3QlxDLrSSLi3sUiu8VVb+GHWge7MOiJcFxtA8oK28fW9HmGNW19VjrwSTcCGgb
	 r2YmGYGxTSfcYGqg8CrarFXVALRtvCpH5QUm8X8Dcox5YzUhoHoyUwOYqQ6lnY9L2Q
	 H2PY79bq6wwE7WdNlWq8aScHu3jsSCDF3yqMjhok=
Date: Sun, 29 Dec 2024 20:55:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Mike Rapoport <rppt@kernel.org>, kevin.brodsky@arm.com,
 peterz@infradead.org, agordeev@linux.ibm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Message-Id: <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
In-Reply-To: <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
	<b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
	<Z2_EPmOTUHhcBegW@kernel.org>
	<9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 11:12:00 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> > For now struct ptdesc overlaps struct page, but the goal is to have them
> > separate and always operate on struct ptdesc when working with page tables.
> 
> OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
> intermediate products of the project.
> 
> Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
> [PATCH v3 17/17] from the mm-unstable branch?
> 
> For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
> can help do this in his patch series. ;)

I think it would be best if you were to send a v4 series.  Please
ensure that the changelogs are appropriately updated to reflect these
(and any other) changes.


