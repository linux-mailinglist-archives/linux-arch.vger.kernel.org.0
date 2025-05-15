Return-Path: <linux-arch+bounces-11960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B5AB884D
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A19189B650
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336113B284;
	Thu, 15 May 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4f9KJuI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AB746E;
	Thu, 15 May 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316632; cv=none; b=t068l9/53v+3Kxj2BwIEcyp7h95moIsKHtfNcBQV95UCc04G4vwfc/piWadrPeGMHwcJbjsZNUCsayLKNPpWVFDZsnt4IEQBTF4LJ4CJckiHndSwXDVpf2sPaQ3ijq22kGyZtEI5jciPUGyQMpYyO/FMOuNXZELbCNmO3hs70KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316632; c=relaxed/simple;
	bh=8MTb86WtHPIIKwMQGNsvwYBlq3tR7OBJIhM8yr8RDVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjLIEQdaVyGb/gbvd2IDGfe3GXLSr60OT/UMi4AfvbEdLBB5aWDqEHr47zMdJ6Jyiog9Ar8418ttBIEg8/Vl7cXxhLuktOE8iZfgLX5GjJvXw4WfMOBv6XvgCuJ0M2Scknjk/a0/ss3CJ7Irj6oLTo8oEMuX6Hfrae2WMZvACjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4f9KJuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F1C4CEE7;
	Thu, 15 May 2025 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747316631;
	bh=8MTb86WtHPIIKwMQGNsvwYBlq3tR7OBJIhM8yr8RDVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4f9KJuIdu2JV5VvDlxTIP7U+NJsb89js0dcU6bKRpSJFK5HQiXjeD7/5AOMOZ+kf
	 utfwJQOvfbsvNPuwZwV47NMcLFl/56uiZG4rzMnwSNjQsNbgNlSnDcuQPmRpYRnLCi
	 RTXOCDClEYgn0GAshgYUDL8IQ270Rm1WO3Tj5sgZSPgjWTx2HrRdVe9i0nLQX+5iBk
	 4NDoi6k5nHD3GaJc13BH5OWYKxOHiwCtQ5e0HSkZFw6Jb5mfX0Nu63jVZt0MoE1H5b
	 lk+RGYDgAhldk4d6UqtZks62P7Ew5R06OukYJfIJwXL/HiBxL06XTjYAWmmvY+VZCC
	 fKf2I809VA6EA==
Date: Thu, 15 May 2025 15:43:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 14/15] bugs/sh: Concatenate 'cond_str' with '__FILE__' in
 __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
Message-ID: <aCXvknfaKRzvXLxz@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-15-mingo@kernel.org>
 <ba1e1ae6824f47bcb49387ae4f2c70dfd45209bc.camel@physik.fu-berlin.de>
 <aCXtGRr5pSLKoKg8@gmail.com>
 <bb170eb0524d04de13cb5b2a1cca9467bc2def87.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb170eb0524d04de13cb5b2a1cca9467bc2def87.camel@physik.fu-berlin.de>


* John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On Thu, 2025-05-15 at 15:33 +0200, Ingo Molnar wrote:
> > > It's too long and the prefix "bugs/sh:" is very confusing. I usually just
> > > use "sh:" to mark anything that affects arch/sh.
> > 
> > Fair enough, I've changed the title to and pushed out the new tree:
> > 
> >   sh: Concatenate 'cond_str' with '__FILE__' in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
> 
> Thanks! Minor nitpick: I think that comma is wrong and should be removed
> (I'm not a native speaker though ;-)).

Yeah, so both with and without a comma this sentence is proper English 
grammar, but a comma before the 'to' adverb slightly emphasizes the 
second part of the sentence, which was my intent with this phrasing.

> > > Can I pick this patch for my sh-linux tree?
> > 
> > So since it depends on the previous patches, in isolation this would 
> > break the build.
> > 
> > Can I add your Reviewed-by or Acked-by?
> 
> Yes, sure.
> 
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks!

	Ingo

