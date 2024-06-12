Return-Path: <linux-arch+bounces-4845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6FC904FFC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 12:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CFB1F212E7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91F16DEA7;
	Wed, 12 Jun 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fPC0L8/w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6716D9D0;
	Wed, 12 Jun 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186699; cv=none; b=ZXlRGRt9hzxCEuRHkg414hHNPMZU0TNAkwHf3u75bWsf1ZQiUO+h6eZrXrc33vHQCaSplVzA9JFvgPGZAiZyrNt/pZjWzCfjIOcOECRfpDkMhVUd3AeaPql0FTBRpUcTV86V65CLONShv0uuLtNMTOHGW1zB6MrCcjUQ6TMLOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186699; c=relaxed/simple;
	bh=iEUoNaayB2BlJnVCPB8Po5Qwl6xQduvYeyz+LVKfHzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiTaX4g849PWVquUSP4X0IqinRYTopmxPVX4LSqpsYDJ3FsuY7bZALfe0evHDE7hIbWbWZaCSbhTroCsI9QiZ21NI6jdeH6utfYGSabWDi+xLpOfI5YJbngkGtf0Po7A+AN04kLznI6DQX/z0c6reYbBTWTCdax2oZ2XoKWqM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fPC0L8/w; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC97940E0176;
	Wed, 12 Jun 2024 10:04:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r_odZfOLMdTS; Wed, 12 Jun 2024 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718186691; bh=aIgbnAOKTeM+FB8d5W9nTCjTvuJnn62DaSg830jf+FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPC0L8/wkmwCve3ZScwFP4VavsptqNjHj6aPqaJyJB3LbWg7Ua6HU3DFE9eDnMZYz
	 rti2QWpOW4G7XfITaRc7J/zkGRKyjN8Ek8A1gd3gJCxExvGFDx0bhF2BE8AW0rEWar
	 8UUEGkRkdBd3v4Dd44vFSvFUvKIpgS+7Skj8nq1JCHtUTW9n5iKRHmtnxGOx1lr78q
	 TspzNTVhsPIDM27pkjuthmFWzev1by6hvTK8wtboUoTHWeGU2TfcB3bDrGt+dBxKM2
	 PPEEQ7kKuSJ5PVLC2wrJATFRnKjWim77b4HNdNDJ06OJqNTWV1f7BSq+XB8XeAiA7m
	 WP/g1+Vat2EVDWCV4t2KrcB8M4rfiv5bbCf6HK05w+soJyyPj+S1qwZJW1fXn+nA2n
	 zimz8QtS78/iTV2e9lDL+owZw5lAvXwAdtnTS0SKtpXxJk+wKUZnPhEZv0nQZWqgHh
	 EgBIRdXKmQYp+A1HqstpTcyHLe0KkIVrB5PAIFtmPe10OpjY9diM9ufbYXqNQo70zt
	 4rh3N1gZZNHpIhXD0QBvXCoLFH21IQ2DMWfmMJ6qOmgraMIY9yfMajZS+ahzsxlrAn
	 v3L1wR/FhLiJ6lhhwap0IleUoyPCJv3F5dHrPU9YCQaciGr7J3lXdzKPD7L6AY7bc5
	 GnJ027YNlP7es90YP0ebIy0E=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2EFE40E0031;
	Wed, 12 Jun 2024 10:04:39 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:04:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/7] add default dummy 'runtime constant' infrastructure
Message-ID: <20240612100438.GAZmlytlj99BvVqlwd@fat_crate.local>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-3-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610204821.230388-3-torvalds@linux-foundation.org>

On Mon, Jun 10, 2024 at 01:48:16PM -0700, Linus Torvalds wrote:
> Subject: Re: [PATCH 2/7] add default dummy 'runtime constant' infrastructure

Probably need a subject prefix:

"runtime-const: Add default..."

> This adds the initial dummy support for 'runtime constants' for when
> an architecture doesn't actually support an implementation of fixing up
> said runtime constants.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

