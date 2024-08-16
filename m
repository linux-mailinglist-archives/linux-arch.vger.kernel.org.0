Return-Path: <linux-arch+bounces-6276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E7B9552DD
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 23:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D444A2848CC
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575301C57A2;
	Fri, 16 Aug 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MPspsmwH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE1839E3;
	Fri, 16 Aug 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845471; cv=none; b=RXguFJ0P2y+Y5GtMlKjqggcpmMM547QxoxTB+KCA2a6Wm7rYC10DrgPBZq486Xxr7ahBQZqMC8rDvlMZJ8lANn4QM7lILwAV61OrChQgCDXU3vnFd26qXDR8A41po/CyUs7W6pVjn8U1mVqN6+xIlrubnDGd1TV6AxbKGkqRJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845471; c=relaxed/simple;
	bh=XIPn/yR2C2fDGrt8rtyiq9Bwcr5TQEUAaaWm4AYnEIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr0/BIDusuqzWXz41PARLaUsbbMqi0VEFSJWny92Ru+YNqMzs1Qo2ZFMe3lG7Ry2AjLVz0tXiXW33HEblPTJ/fW935Zi60YkarsnBiJdB4I5gLb0qDWK7AXR/Ls3r0bLQdOyaEN2EMBbZgYcx9559WgGaSLv2v60PyFyaEEdAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=MPspsmwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D287FC32782;
	Fri, 16 Aug 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MPspsmwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1723845467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIPn/yR2C2fDGrt8rtyiq9Bwcr5TQEUAaaWm4AYnEIY=;
	b=MPspsmwHM9KZ0tUmARAs+LER2NMFSSi18O6cosfSzmUZjc/CkbjjAzRoAf3k1ENrmUjKyr
	yBin64Qo6E8FhIJdrCB/Mb6okEo+xqb1nIWGoJFNgeXhgsDbMbQf6BpNLn/s2iSjykKT0G
	cS7IHUC6dacuhUOWQG4TRPErifqrD9Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ba18aae2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 21:57:45 +0000 (UTC)
Date: Fri, 16 Aug 2024 21:57:37 +0000
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
Message-ID: <Zr_LUQzb6KB6I448@zx2c4.com>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>

Hi Christophe,

Thanks for this series. I'm looking forward to taking a close look at
it. I'm currently traveling until the 26th without a laptop and no
email except for lore+lei+mutt on my phone. So I'll review this in about
1 week. But I'm very happy to see it here.

On first glance, patch number 7 isn't okay. If you want this to work on
32bit, find an available bit for VM_DROPPABLE. Otherwise, just do this
64bit-only like many new features.

Jason

