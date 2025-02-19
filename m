Return-Path: <linux-arch+bounces-10216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C017A3BD74
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B3D1682D3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA81DE4F8;
	Wed, 19 Feb 2025 11:52:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E40286291;
	Wed, 19 Feb 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965927; cv=none; b=ZEpYzLrgg+3VeoA4kv7aEPUmsmgRYdePi6GNkTuq0YU4G5y1Tpk2PXrBARgAATNfgkCUURh8WOMt8Ys6ya5Z1PeMCwQd2MXzEQ5V2C3145hOU8RVofuEfrtsGsHSHlQjFbBWbLeyntdhjLiL5pNbQVPB8rPXvCMZw6RPhjkf/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965927; c=relaxed/simple;
	bh=vrUYosQoceRE+Qxq6ZkfIGNIJkHF30yAY3d6CnC8kNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFrxlAIY0gBz1gM3cLA06NDeHGEydwuvVEQS0EW2OoxaJHnH/ElSi8wNTZ/86i8/c0YURgjm6brWGLROQs9FssohlQ8iNO4hWPT5ziHXqnlAAHfazeXdYdJa0+3wVObRaxpuk2kPA2CA621eemGSLOnF5Jt0s0S0RqMp8Kt7Nnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C01EC4CED1;
	Wed, 19 Feb 2025 11:52:03 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:52:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ioremap: Pass pgprot_t to ioremap_prot() instead of
 unsigned long
Message-ID: <Z7XF4Y3FIbSrSP9u@arm.com>
References: <20250218101954.415331-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218101954.415331-1-anshuman.khandual@arm.com>

On Tue, Feb 18, 2025 at 03:49:54PM +0530, Anshuman Khandual wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> ioremap_prot() currently accepts pgprot_val parameter as an unsigned long,
> thus implicitly assuming that pgprot_val and pgprot_t could never be bigger
> than unsigned long. But this assumption soon will not be true on arm64 when
> using D128 pgtables. In 128 bit page table configuration, unsigned long is
> 64 bit, but pgprot_t is 128 bit.
> 
> Passing platform abstracted pgprot_t argument is better as compared to size
> based data types. Let's change the parameter to directly pass pgprot_t like
> another similar helper generic_ioremap_prot().
> 
> Without this change in place, D128 configuration does not work on arm64 as
> the top 64 bits gets silently stripped when passing the protection value to
> this function.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-sh@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

