Return-Path: <linux-arch+bounces-7621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B149598CE9E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364A5B21B48
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5351946A8;
	Wed,  2 Oct 2024 08:19:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.sf-mail.de (mail.sf-mail.de [116.202.16.50])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2115C1946DF
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.16.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857180; cv=none; b=GHevl1mL9dwIJ+0fyel/kICbD/blkkaS6gasDQfMNiTseOW24dCAQDLpooS1Ez1/WncJ7xMyihtq67fzMoolnRworIBbNTvzICE+ETmulG4p6tXh+vCgApz33Uy0xWJVgPbdLV3NsNIQM6TxHQvYLP+GvHJerZTtGd1ASETDV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857180; c=relaxed/simple;
	bh=0tnyLiGKdZgUtnOedy7AXIt04SViF9h3qZpsw9H22tQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fHh2UZhC8XeLI99dxbhpI/SWWB7p07Lu/aaS1rZfiP3CKQhmFT8LDz2E/+Gk2u1Dk3qkZ4l1la1Jk4DLyQauoC/SxxkrZLVFW88xGu7M81AbIn/RW7YkWW5VRby7+YvszKOLnsB+SFXY6K6vTblryatiJB5uus4xSQDVblATq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de; spf=pass smtp.mailfrom=sf-tec.de; arc=none smtp.client-ip=116.202.16.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sf-tec.de
Received: (qmail 642 invoked from network); 2 Oct 2024 08:10:52 -0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69]:54934 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
	by mail.sf-mail.de (Qsmtpd 0.39dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
	for <viro@zeniv.linux.org.uk>; Wed, 02 Oct 2024 10:10:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 10:10:51 +0200
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-parisc@vger.kernel.org, Vineet Gupta
 <vgupta@kernel.org>
Subject: Re: [PATCH 1/3] parisc: get rid of private asm/unaligned.h
In-Reply-To: <20241001195158.GA4135693@ZenIV>
References: <20241001195107.GA4017910@ZenIV>
 <20241001195158.GA4135693@ZenIV>
Message-ID: <30ee897e390061ac0211b5f99d9b311b@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2024-10-01 21:51, schrieb Al Viro:
> Declarations local to arch/*/kernel/*.c are better off *not* in a 
> public
> header - arch/parisc/kernel/unaligned.h is just fine for those
> bits.
> 
> With that done parisc asm/unaligned.h is reduced to include
> of asm-generic/unaligned.h and can be removed - unaligned.h is in
> mandatory-y in include/asm-generic/Kbuild.

> diff --git a/arch/parisc/kernel/unaligned.h 
> b/arch/parisc/kernel/unaligned.h
> new file mode 100644
> index 000000000000..c1aa4b12e284
> --- /dev/null
> +++ b/arch/parisc/kernel/unaligned.h
> @@ -0,0 +1,3 @@
> +struct pt_regs;
> +void handle_unaligned(struct pt_regs *regs);
> +int check_unaligned(struct pt_regs *regs);

Doesn't that need an include guard?

Regards,

Eike

