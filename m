Return-Path: <linux-arch+bounces-2559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F346185D6C2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816D5284E2E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB933FB30;
	Wed, 21 Feb 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qsml+ais"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF433DB89;
	Wed, 21 Feb 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514657; cv=none; b=LqIHhj5sa3DX5fbEkmR9Lm/Q3wS3vvETkxCr/d4DxyRxJ45gkWjU7EPFrDV9UFdcqgH0bP9GuUOq0Srs1rhYai+wrPAEe7fx8cARClURJDoUSOyQjKjt0cKa7Kmiv2cLmKse1h0Z+fd7t6T7jsGbTImyPhNl8ywGnnIRdEsPvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514657; c=relaxed/simple;
	bh=NccVI3FAA9fTge9YiKXvwt2QjmR73U54s9TFKEqSga8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmbKxeclTtAdFiIKGZ57tIWjScqh3xyv3lzDYXn9bzN9rYxGlOWPn3oGfL+IYRJ6pbgu/qOxdewhqKm6axikG8QqyntSvERTy2usA44XOPeJsGAmuoE3vJVHXagnamgxZkgbnLn0aDxf1l3mYyGw6l4jlyjCUxJlapvGYOdkcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qsml+ais; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E450940E0192;
	Wed, 21 Feb 2024 11:24:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DrMWaeKeHObJ; Wed, 21 Feb 2024 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708514650; bh=5QuFgKyiV5YPFG20+DBSNeSkI1yspmo1RrcmntLK4n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qsml+aisrUe8zKn4FPsV8dCPSGpakaZQcKkR8rZztfyfKq+jQLdpHlfme9E2tnb11
	 fWu5ifGSJ/KT4a9Dc3qdDBxF+gYqOMNPgK038rqXc8x3ss1IMGTnKix+q0WHpUq6jn
	 aHIuJhxLDQDlImdbRTDBdoKJP3mQjRRFi340m4HFPUqL3wNjo290BQykdoXVxo0kA3
	 vjJKyWNlwCfmEbK39Hs+oDmjBelKrJnD53WoiB1ni/rTnb3WBNNDpjameTwT+A3mSM
	 nngm+BipLvnTzPX9edTd0jkUP8YPdxdElC2XzbHOBPY/vKO1T5NGGeaYoJb14EL2cq
	 SpH6h9y654jhxUaCcNOhmcpohT4c+ls6+KFARaJoee8RG9R/Vkk3bVZilz2o0rT4eW
	 zmaLfMcB/nIUU27/qTAy5uL4iVSHsZ6jbsYE4hLaUtS5HKfJFK9y5th5Mczz57yO7d
	 dXzJraQlQ8sphoycu++o6qbrrKaEkoT37j4/KlcBLdb9OzDmVdvew53oqGJczZs4dP
	 kjO8xilK7avvNJLDxzpQqrYaBlkbJsyutGlPljf2RpvWpZxd/mtedKl5oCyhyMu/Ty
	 Ju+7oBziXFV1MPycWyr4AahF3+oXEnFggJk5UMOGMimWs4Hqxhjgw5tuzRptGYcsHK
	 7jZ267IMCAuYbQbmtlwovvBQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4222940E016D;
	Wed, 21 Feb 2024 11:23:53 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:23:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>,
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
Subject: Re: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240221112348.GEZdXdRJ1wvovvSm2D@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com>
 <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
 <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>
 <20240221100916.GCZdXLzHb-31GMw-f-@fat_crate.local>
 <CAMj1kXGqHf3b3zho_0CPccTkgXRnTrxsG_qDjhP9P+US-u2AGw@mail.gmail.com>
 <20240221111245.GDZdXarZsZd7eZw_BK@fat_crate.local>
 <CAMj1kXFNFxARF4bmB=a2PWT8uYLacs0GxOGkP319RLXH9Q0k7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFNFxARF4bmB=a2PWT8uYLacs0GxOGkP319RLXH9Q0k7A@mail.gmail.com>

On Wed, Feb 21, 2024 at 12:21:20PM +0100, Ard Biesheuvel wrote:
> Btw v5 is good to go, in case you're ok switching to that:

Sure, send it on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

