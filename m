Return-Path: <linux-arch+bounces-13171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64348B28416
	for <lists+linux-arch@lfdr.de>; Fri, 15 Aug 2025 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CE01D03798
	for <lists+linux-arch@lfdr.de>; Fri, 15 Aug 2025 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E34F30E0F0;
	Fri, 15 Aug 2025 16:40:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA330E82B;
	Fri, 15 Aug 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276024; cv=none; b=Mi4YU1V6U/5E9gMHUPghmc3CyZXkZxYHbNtVyOYv/DOMiPZI+WUuqOyVebyF7hzgvXDf0N9oT6GSSXQh2JiesCzsnO7uRR7bhgVgnUZn2eEPGAK89jqNamQCz+aoJVqyRhxVatOOp9dTiObbVLE4kfH3IZBOQElK7jZ1FzCxFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276024; c=relaxed/simple;
	bh=JKqiF9UWISn7sOjd/GaP6Ar/71yL4XvlIOAUaO7+qsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaqAey1XbpIaE80CMAGZ0hHfwL8q0mCVph1lmCSzwfE6zDU7CjD4tP/H40l3Qxi3l0mF5hc1JZ4Oz4e8lrS2v/IKFTvpE+9KcPT5qsfil7QSZpPOfJ2z2+qPzZfVLf2t6ywdf/1Ioqb1C57xV93y/cLrMVo8V8fnatn19Wv3iNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 57FGYuWM2568188;
	Fri, 15 Aug 2025 11:34:56 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 57FGYuon2568187;
	Fri, 15 Aug 2025 11:34:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 15 Aug 2025 11:34:56 -0500
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
Message-ID: <aJ9hsHj9lsHvvhcA@gate>
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-5-kees@kernel.org>
 <7f4f4d07-38f7-444c-adff-ec2a2387e86b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4f4d07-38f7-444c-adff-ec2a2387e86b@linux.ibm.com>

Hi!

On Thu, Aug 07, 2025 at 03:16:35PM +0530, Madhavan Srinivasan wrote:
> making them eligible for compiler optimization.

You can instead use GCC for this.  __builtin_ffs () exists since 2003,
and has this attribute built-in, as well as tens of other optimisations
that the kernel thing misses.

Of course using existing stuff instead of cobbling together something
half working prevents you from having a lot of fun ;-)


Segher

