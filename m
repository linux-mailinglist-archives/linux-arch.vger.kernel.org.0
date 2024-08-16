Return-Path: <linux-arch+bounces-6277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351495531F
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 00:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BAD28339C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 22:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC97144307;
	Fri, 16 Aug 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vx6udTu1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8219143C6F;
	Fri, 16 Aug 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846268; cv=none; b=lIryUOHaqS4fbuxiPdqDky+l+5S4Ulr+xqtfnvt4MiKyI9kzOHAk4EauefsieaW9dXiqQ3qHR4D7DDEu3HRbfOXdh+4SiZsPK15dBz471Aj0zCHTzSfou5/aGwJCkkrjurEaacaOHa81EDh5BDo4s5GPhFUHE+aX2Nj6NdFP9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846268; c=relaxed/simple;
	bh=nvXQQW5h0YhuEWfavkvTqchHGfd4wLDh0p1IgH0TPF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFD7p7unr+9APC23xglesQjtnQrsHIlZVmTdN/aFhn9b1/U5/+/GoXf7R9w3AsqIuxn+/9D2U2m+C0VH8a+qzDGGqm+yrwzW6Yt4AoNhsDAMmA46s7uuLKbnRRgClBbPzv10xdfp5Ugdjyn+ZwLahtqP5rm6p4oX4Ntkl4oJphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Vx6udTu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9112DC32782;
	Fri, 16 Aug 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vx6udTu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1723846264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvXQQW5h0YhuEWfavkvTqchHGfd4wLDh0p1IgH0TPF0=;
	b=Vx6udTu1kdOom/Ify2C6I2Nocu8Ylvr4Bn4kVfZ/HlGh6p0Yz55yApnf6XOAIvVppg00Hx
	9ILLygbPqJlGxpxobQtIFjBl01lAWoeBA95uhw226C6t1PhtvghVLK3tKExPDwuHApACv9
	tyBQ5Jp5XQ8y5VxUuBA6usDPNg2s6j0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5126d285 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 22:11:03 +0000 (UTC)
Date: Fri, 16 Aug 2024 22:10:56 +0000
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/9] Wire up getrandom() vDSO implementation on powerpc
Message-ID: <Zr_OcF0Da9fgfKtS@zx2c4.com>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
 <Zr_LUQzb6KB6I448@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr_LUQzb6KB6I448@zx2c4.com>

On Fri, Aug 16, 2024 at 09:57:37PM +0000, Jason A. Donenfeld wrote:
> On first glance, patch number 7 isn't okay. If you want this to work on

Sorry, I meant 6.

