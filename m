Return-Path: <linux-arch+bounces-7618-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BB98CB82
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 05:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564991C21937
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 03:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F32F22;
	Wed,  2 Oct 2024 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D75FSPtC"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F2DF59;
	Wed,  2 Oct 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839427; cv=none; b=FX3/9jxOAvmz4j2GNh7E96iozJxmaQzKsQe0eYY+iR9Lm4KOAOqkGdFaX4Y1E20Q4MuTgyEr81hPPHFdfpOA3whGOBrIuj2dVync+akdMM5XFtIjNtVh2M3a+tt8ytYLwLl0MJlXPDERTkd7c7K/brsPi0/wIqxXcbcbO4v6rE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839427; c=relaxed/simple;
	bh=rxd0x/69N9j1RO08S9L0U0LL0WsLv4aEHYIOTfnjuyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0g2wtnt3BippRGp6mgTQpUB+JfjmVAUL/iGsE8JhnH/zxd3AmmXydo7kgMpXc1ZkTlLmmpFScwfY4b1zRi3iKGdKKv0jKuj3Rlop35+CtAl+yw/GwiiLNkfh1xh6CswF0VALnrNM97QePle5nsbl/IO+Tv/QJPULuGccUobMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D75FSPtC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v22S1wy+8+mstC2IdfqvhGcg9lttAnvty2xj+9m6TX0=; b=D75FSPtC/pmXkEbzPPpGfhjCCW
	vtIR4awwndzdAAwihfjNKxsWKuXrkjoGCPtSDKPHDkk1cFiRlnMsCR2KvW6P2In9FgM6zk5G1+Ag2
	6pxn9w6zay5ve0GeE2xtpgsMezcV3/aH6E+Jl2MF+MjfMNYXXvrclgMQpoxy9vNyXkjYhKtyb+KvV
	y4CaB27TD9Ng45Dx6BYIzZhNvL8Q7jlO9IVS2POR0zfOW5rK/F3UTH03Yjr5ujYMDkedIRmVWs2Sk
	h9mtQeFxrXULGJT0dn1QjrLolm4otTS2Urz0iK5b0UqxVnGidxj5A78JfxnePHN6LYr3TFtrAvqw+
	jXmn7WOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svpxm-0000000HZ4M-0WPg;
	Wed, 02 Oct 2024 03:23:42 +0000
Date: Wed, 2 Oct 2024 04:23:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Helge Deller <deller@gmx.de>
Cc: linux-arch@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH 1/3] parisc: get rid of private asm/unaligned.h
Message-ID: <20241002032342.GD4017910@ZenIV>
References: <20241001195107.GA4017910@ZenIV>
 <20241001195158.GA4135693@ZenIV>
 <9e7fa2c6-ae0b-458a-a4ae-a216a3b11a77@gmx.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e7fa2c6-ae0b-458a-a4ae-a216a3b11a77@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 02, 2024 at 02:57:48AM +0200, Helge Deller wrote:
> On 10/1/24 21:51, Al Viro wrote:
> > Declarations local to arch/*/kernel/*.c are better off *not* in a public
> > header - arch/parisc/kernel/unaligned.h is just fine for those
> > bits.
> > 
> > With that done parisc asm/unaligned.h is reduced to include
> > of asm-generic/unaligned.h and can be removed - unaligned.h is in
> > mandatory-y in include/asm-generic/Kbuild.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Acked-by: Helge Deller <deller@gmx.de>
> 
> Al, I prefer if you could take it through your "for-next"
> tree, as you offered in your header mail.

Done; that commit (with your Acked-by) is in #for-next (via #next-unaligned).
If Vineet is OK with the arc one, it'll also go there...

