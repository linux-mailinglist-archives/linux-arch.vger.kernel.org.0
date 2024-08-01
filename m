Return-Path: <linux-arch+bounces-5897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD40945353
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 21:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800D0B20D3C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2901494A7;
	Thu,  1 Aug 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AAx+yb1B"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9441487E9;
	Thu,  1 Aug 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540316; cv=none; b=ji3XbCZWSq2Blyw7oaE2u/k6Fx7YwG9WJ3FuVOTZeocHYDJPpjAWGnhuM6CkEUJOS1i7SLhT1uripvqPB5JS4BT88ELXWbtfm4biZFgDnd58E0EawUOgxvglhR5OnwRmNWvvuw4xj1uGGuq4Qf3ZwNpaOy0ZxPzrpVNTSojAa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540316; c=relaxed/simple;
	bh=XeAYVv5IiXsaFsbon/gBhh3DJoaHiS0ddxk+GgIN4NE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o0JgGFDuyx2iDY7FVqr8c5F7c6xWvPPlkGlVnNIKyrzXw7FGDiP9CSH6zppcZuLagiUlNe7nQFtGGlom0IigehbbQ+ohLoiJA6fCFi+RJ3GKCtmrPZftoviPWwugimrvJpZWY4wSKuyfQCzrpHh2gmKT048hiBEbdp5DFwTKdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AAx+yb1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8E7C32786;
	Thu,  1 Aug 2024 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722540315;
	bh=XeAYVv5IiXsaFsbon/gBhh3DJoaHiS0ddxk+GgIN4NE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AAx+yb1B8es2fdR4Fd6gN9M6XoyAndyP7nz0YAQ6vfd/ClSBDWsvf7XApd4iKtNSt
	 8dvGZS4hgzEpBzNmPQk3rmlRY6v+zktI6Ci+2/gptK1yoU/C2VQhY/zsXvCIDvbIMZ
	 +HI9vIVtpOIGpcN83in0c2G8vQS6fZmAy+ok7F38=
Date: Thu, 1 Aug 2024 12:25:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: BiscuitOS Broiler <zhang.renze@h3c.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <chris@zankel.net>, <jcmvbkbc@gmail.com>,
 <James.Bottomley@HansenPartnership.com>, <deller@gmx.de>,
 <linux-parisc@vger.kernel.org>, <tsbogend@alpha.franken.de>,
 <rdunlap@infradead.org>, <bhelgaas@google.com>,
 <linux-mips@vger.kernel.org>, <richard.henderson@linaro.org>,
 <ink@jurassic.park.msu.ru>, <mattst88@gmail.com>,
 <linux-alpha@vger.kernel.org>, <jiaoxupo@h3c.com>, <zhou.haofan@h3c.com>
Subject: Re: [PATCH v2 1/1] mm: introduce MADV_DEMOTE/MADV_PROMOTE
Message-Id: <20240801122514.60ceff638d97f460361f09de@linux-foundation.org>
In-Reply-To: <20240801075610.12351-2-zhang.renze@h3c.com>
References: <20240801075610.12351-1-zhang.renze@h3c.com>
	<20240801075610.12351-2-zhang.renze@h3c.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 15:56:10 +0800 BiscuitOS Broiler <zhang.renze@h3c.com> wrote:

> From: BiscuitOS Broiler <zhang.renze@h3c.com>

Please use a real name.

From Documentation/process/submitting-patches.rst:

: then you just add a line saying::
: 
: 	Signed-off-by: Random J Developer <random@developer.example.org>
: 
: using a known identity (sorry, no anonymous contributions.)


