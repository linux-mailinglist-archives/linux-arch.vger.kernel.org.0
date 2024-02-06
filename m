Return-Path: <linux-arch+bounces-2108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD5C84BCD3
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 19:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78141B24E3B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA914282;
	Tue,  6 Feb 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O/hqT4W3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A21426F;
	Tue,  6 Feb 2024 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243710; cv=none; b=TNEWQcP9dVsfhzEbrC1AU11ACKBkIvu+c8tPySgK9aKmD0Ld6xwQuETjVpA8rIJ565xUCIJGTpsiNICX+nDcLTiYP2HlJvEt+QGDq+VtT+rvTCt2g4ltpBebfZnkJolJsCl/XYdTH1r6wLxWqFTd3TxIKzVbHOhSGkEjo2xptOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243710; c=relaxed/simple;
	bh=yOMecqKjKz7wRgRDV+g/dHefsMm6IJp/Jb++ls3LbmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLCRrGhcyN1YaPuXsrBqBz6URtkHrVkUImNlnS8TuWoQ7dwweCHDlGIUx2E51qrK2ZSePA80zJKWzVdHQdH2xCmeUpno1Mi3VMvn5Z3y4XOMN8IhV7drqTcyWD3k7201L6S1ikp7EHBWijMxo9MCXybSAE+rODtk9d9IIX1Tm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O/hqT4W3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9527F40E016D;
	Tue,  6 Feb 2024 18:21:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FillHEpEmEEU; Tue,  6 Feb 2024 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707243703; bh=wCS6yqrfKCvebslKneG37AHrq0CxVqghInimrV/pRjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/hqT4W3uY4QRLCtLw8xDlsRyZAWqBvfqxS4n7dMpZz6Nt8AU79Lw9th33Vmn+ffN
	 TjBLR0czJCO/z5VB+Kx2iHJYJHGoJPCyt2X7UurJpSZoR3lhWpfbzLEPCJ7tzwR75z
	 lGJ1K61txaOKljvJxXFBUVClWKGU1Zh6rH8C/j7aKmKGNqKZbTAAm21rrRfMt7Q29y
	 QxlRClU0JICH4PQ9YkZvObNm1pYZmwZmpgqtInkzZqJSOTW+tlM06F1bJ+5XPgNTBd
	 Asnl3KGnY6OmdU03ETOZxEqt/K9d1OAY9xLa2BQzqARlTxhO9E3nmVYQPNFuyEnnzi
	 xh/py0fuuSk/fv0CqVYGRmAVeuptsOIaRZnSGGtehFGdvtQvCI2XZ+z+8/jmlr37zZ
	 D64GJOx245qIiquB5P2hlaK1W9I03JXRuXphh289wUJ+pfkDMQB3zGKEWszRqFmDQF
	 1l8bRDU+ogIfqy7sP/ZBSU00QqxmskHqGHGszNQu3qPy5/cWE40M1rqEqU1XuKrktf
	 FOSjSUxLDfbqWX3hTbyYVKEGhoUEslfewfkh0o5Eo437bGyZgCvP5jTa++NFSDfp02
	 ZvN7IAJ1eb72bQP+GSMq8ylglvBvY3Zfm2upg+E873C2MZsZYF09xRP92Ul9lyQXzK
	 PFdjIyg1fqCBJcRDRwpbdvaY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 415CC40E0177;
	Tue,  6 Feb 2024 18:21:25 +0000 (UTC)
Date: Tue, 6 Feb 2024 19:21:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 05/19] x86/startup_64: Simplify CR4 handling in
 startup code
Message-ID: <20240206182115.GQZcJ4m6amwGCc7D4Z@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-26-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:08PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> When executing in long mode, the CR4.PAE and CR4.LA57 control bits
> cannot be updated,

"Long mode requires PAE to be enabled in order to use the 64-bit
page-translation data structures to translate 64-bit virtual addresses
to 52-bit physical addresses."

which is actually already enabled at that point:

cr4            0x20                [ PAE ]

"5-Level paging is enabled by setting CR4[LA57]=1 when EFER[LMA]=1.
CR4[LA57] is ignored when long mode is not active (EFER[LMA]=0)."

and if I had a 5-level guest, it would have LA57 already set too.

So I think you mean "When paging is enabled" as dhansen correctly points
out.

> and so they can simply be preserved rather than reason about whether
> or not they need to be set. CR4.PSE has no effect in long mode so it
> can be omitted.

f4c5ca985012 ("x86_64: Show CR4.PSE on auxiliaries like on BSP")

Please don't forget about git history before doing changes here.

> CR4.PGE is used to flush the TLBs, by clearing it if it was set, and

... to flush TLB entries with the global bit set.

And just like the above commit says, I think the CR4 settings across all
CPUs on the machine should be the same. So we want to keep PSE.

Removing the CONFIG_X86_5LEVEL ifdeffery is nice, OTOH.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

