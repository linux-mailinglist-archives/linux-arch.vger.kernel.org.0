Return-Path: <linux-arch+bounces-13172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12698B2842A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Aug 2025 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08681D06B83
	for <lists+linux-arch@lfdr.de>; Fri, 15 Aug 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F330E84C;
	Fri, 15 Aug 2025 16:42:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489D30E82D;
	Fri, 15 Aug 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276134; cv=none; b=VWJUWfRbRGRmIk3aH+l6EU9NXUnSluVW7QrbrofiLWSB/Yc7nr/9Wym1kauqxNqR7e6pN0Mq92+dKVeopNmKsm1W3EH7nUH26NtdI45RodeZRxINkmZXz7AMi9V2LywrAu8kSVf2eYKTl9WcFBMbgF5LW11AZKXc8RNUwjec5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276134; c=relaxed/simple;
	bh=YNnF98V/d1J/g71YSMmy+PpRsNt0b+QK8zrhLaRJBBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIcsCbK0iTylR4QrWQVdnZJ3f1d3EjPJKGWvbAG/7Je9fqn7pzY8i+h5BbkO3KKAJ3HEUNduSbM6j+qjmrWis/IYO8GJYsN4+uTvmEq3YBKIN6v7D7J2On5MFp4CmOkxaXBx8NU64bRU4btTjrjHE1c9qnbtwkxZR99esWvl0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 57FGg0P42568454;
	Fri, 15 Aug 2025 11:42:00 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 57FGfxjE2568453;
	Fri, 15 Aug 2025 11:41:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 15 Aug 2025 11:41:59 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 05/17] powerpc: Add __attribute_const__ to ffs()-family
 implementations
Message-ID: <aJ9jV80oYG6rPN1o@gate>
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-5-kees@kernel.org>
 <7f4f4d07-38f7-444c-adff-ec2a2387e86b@linux.ibm.com>
 <aJ9hsHj9lsHvvhcA@gate>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9hsHj9lsHvvhcA@gate>

On Fri, Aug 15, 2025 at 11:34:56AM -0500, Segher Boessenkool wrote:
> On Thu, Aug 07, 2025 at 03:16:35PM +0530, Madhavan Srinivasan wrote:
> > making them eligible for compiler optimization.
> 
> You can instead use GCC for this.  __builtin_ffs () exists since 2003,

Erm, 1992 actually, but stuff has moved around since then :-)

> and has this attribute built-in, as well as tens of other optimisations
> that the kernel thing misses.
> 
> Of course using existing stuff instead of cobbling together something
> half working prevents you from having a lot of fun ;-)


Segher

