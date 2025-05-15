Return-Path: <linux-arch+bounces-11962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC25AB8AB6
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EBB1BC29BB
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF5217739;
	Thu, 15 May 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqE3GakU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B92C120;
	Thu, 15 May 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323067; cv=none; b=StmwVkS5EzyFea/Wj81kchF7fo+mmmkJu9n2miJAv1X7Kir+TW/rb0/au7hoGrf8XBc1JiWENy4KO7mzpZEDz/RMqVR/z79LOMSZlUM3fIi2ns799524Fg3k7/BHcQ0rIyTsQrXCdvXqDnGxQRtiRtbDWMGR91d7ekbx//+9cV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323067; c=relaxed/simple;
	bh=QvJJFUVW4pcVo1mYB138Uzw2ONiwVTOAVjUOUsHLKuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIUAyPCSZFn/gtB80QSeXIWYcY3CMRXsdKazdMGNuQ7hdKkpa09/R4Qs2fi9A9JYhqVPzUXphnA5a8Q0Mp4z0OF6gcgEB1A81I4eEkf7+orTPjGWM3mWC6ADeHd5jozpfcoX1LvcL5NL3BHC4KXMuMN+unl50zkPV8QLfwqQKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqE3GakU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB2EC4CEE7;
	Thu, 15 May 2025 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747323066;
	bh=QvJJFUVW4pcVo1mYB138Uzw2ONiwVTOAVjUOUsHLKuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqE3GakUR2ohNnAdt2dGlc4xvWX51liHRAR/L5tyLNAYCxDVXcmUNqV5lL4/2IrpN
	 SlySW10XUAkzlCcVYek2rJPZNP7aI5ghiW9zwCCzVC05UTbHXyyoETuQoDD4VcXc7p
	 Ta2K+PANnRhD3+DtCznuW+AloRZblUB30gLPspXgjQwNKpIvdZwnBNq3eFo6VLwcy0
	 v5YYGxN5Z4GU5Izl+81Jjouely2e8fweGnlHbSiB0iyk0QBLXlpkCDeidsGJ13/zk7
	 uQ3BpULPMR2VhQzW6hdCqWsj6MbliLcjGKqqLa+KiMUTaYawP/eZ88Tz/69twfylwn
	 WvqPmizozgmFA==
Date: Thu, 15 May 2025 17:31:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 13/15] bugs/parisc: Concatenate 'cond_str' with
 '__FILE__' in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
Message-ID: <aCYItp1xdWKSCRi5@gmail.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-14-mingo@kernel.org>
 <7622c721-3335-4200-b2a4-5802c67b4b58@gmx.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7622c721-3335-4200-b2a4-5802c67b4b58@gmx.de>


* Helge Deller <deller@gmx.de> wrote:

> On 5/15/25 14:46, Ingo Molnar wrote:
> > Extend WARN_ON and BUG_ON style output from:
> > 
> >    WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
> > 
> > to:
> > 
> >    WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410
> > 
> > Note that the output will be further reorganized later in this series.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-parisc@vger.kernel.org
> > Cc: <linux-arch@vger.kernel.org>
> > ---
> >   arch/parisc/include/asm/bug.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Helge Deller <deller@gmx.de>

Thanks!

	Ingo

