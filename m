Return-Path: <linux-arch+bounces-15691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929BCFE73C
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 16:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D1763075D09
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E98350D74;
	Wed,  7 Jan 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gfgvtMRN"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BB32D0E1;
	Wed,  7 Jan 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797321; cv=none; b=GQ93Q606tV1lNbT31tiw3oB4egKnS9NlgaHR6GA/UKmFCtr0pt2PiE3BH5c1BVWdjqLfPeT0L8WdVQL+YNAU/t0Dz8WlswY47sYw6HnnZd87v5qdD2BKEDEhwiBNYB0ZWeIU+GAiLFkAgR0yOMTjO8Ag9doNF5vdUG9mnTtbWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797321; c=relaxed/simple;
	bh=Ka/9bAPYyvlWh8lhj++E2nVztRrXEX+s3NjRksU4e6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/b0DrFbxx4KuZDp0nnx0CMkHsCSVBBZnqRlgOlgqNUQUK8+8a1bnyQFolLxau//Fnedl9u0mdEvZtoamofj8ZmLIXlloK1JnZPJjuLBa8t7cgIjO/APpexOA7voUOZeAucvVlXXD8osFvAorXz0c7jqhrfemC131ZbLBvNCOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gfgvtMRN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+xIhfMAtjHYjFTH+p76wSQ0KBZqEgJllYmQCn9tPHTw=; b=gfgvtMRN85Hh6ULIivj+/lsOiA
	MybjhOoCgrIWL+bUF4ZEyrlnJ3BCKR4kow6Y6NDL92/3cFJxBWTaKb1rIOfGBe+Dw0TMz+F6hTAg8
	Crnru+IpjVNRY8M3Yo5pEqYsNvsbroxjMFB+JLG+kn8JUv7wu/qgJNEaHLWZYnCI/h9377j2QaiDj
	Wp4USeOE/onY3OPFlzQZveXDAm1UarU5jmZ6+7+4LDv4lZECvq9bRsaYpa+NQlBAndtaGIh51toTF
	IydUvltqxiSopJRhJfdcYVF+WCRW6z7IOhoMVL5JAXrCp/2naH+s5TUY9eMaE3iE1xilEVS8ykNR8
	zYY+BTvw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUpO-0000000DVbI-1rdl;
	Wed, 07 Jan 2026 14:48:02 +0000
Date: Wed, 7 Jan 2026 14:48:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alex Shi <seakeel@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, alexs@kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
	"open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
	"open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
	"open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
	"open list:LOONGARCH" <loongarch@lists.linux.dev>,
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
	"open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:SUPERH" <linux-sh@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
Message-ID: <aV5yIuGi9Ni5YP5E@casper.infradead.org>
References: <20260107064642.15771-1-alexs@kernel.org>
 <aV4h5vQUNXn5cpMY@kernel.org>
 <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>

On Wed, Jan 07, 2026 at 05:28:36PM +0800, Alex Shi wrote:
> Right, I will fix this. and sent the 2nd version.

No, the patch is stupid and wrong.  Don't send a v2.  You seem to have a
hairtrigger resend, so I'm trying to prevent a v2 being sent instead of
sending a patient reply.

