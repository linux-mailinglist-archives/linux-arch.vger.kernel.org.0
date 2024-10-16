Return-Path: <linux-arch+bounces-8246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E819A165A
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 01:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C51B21554
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420F1D54EF;
	Wed, 16 Oct 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUyJRTRo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB08161326;
	Wed, 16 Oct 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123099; cv=none; b=hvWB13YpvSDMupLs2xW+03HRgDOwga50spkpqLx52kc6tTV4f+inKHLvfO5ZofLkSRRdNqmPVnbQ1QxNzAmBNNmRpqXtJb03Wo6OIlBZGSqDELrN31ud2oKaqYErCMtmZSb96fY3xsVX/1Qv1/VynQCi7s2ikNOVEp25xFzqR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123099; c=relaxed/simple;
	bh=dl4ZMMi6UkY66eeJUj39rk75iod/Rq4ydDN6GkT6Ce0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6ltQe0Uez5ux6YgMw2Obb/cHsFqXjgU3ORgKYV7BmZRvo6MKTwAYZ5pMnOAbsSpLxNJClr6ShxUa4D729VDBcpVyaRP8hDtCGfRchUMslOCCVEUUFWodp2Rnq1f3mYbBuFl4US+RE9/BphEEWDpGKO354pyHivz/xKbx23r/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUyJRTRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0128CC4CEC5;
	Wed, 16 Oct 2024 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729123098;
	bh=dl4ZMMi6UkY66eeJUj39rk75iod/Rq4ydDN6GkT6Ce0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUyJRTRo0x2+3z/2y/FQ+aEK3XYUoN8mcz2N9MbvfVeg7WtoOgXSHf9qFPMa9WqK4
	 I4Eb7NqiTNyvOxrYQ0Ck1crWzLXaJyBVvU1iHXhrLqptfZmWv1nwU+oeXM6onwo7B1
	 Bjome/eLzoTdbg0LAyDRkQaPt6vpNKaP3Fks19G43RKkcc3xWsk/OAukW5yOL9KK4T
	 DRNRLea/INzHDvb30jc2JX11dyzgwAjaplu5U/zrOnXLPkT+ALdxPNd3g3qhlwF7Nb
	 IhixQCW/u2nVSk7r2vmTsqvA+1zxrdLaddel3zcxJ5QIG57g91CYpQvbUsqReiBH8k
	 JX5BKTdKfsQpQ==
Date: Wed, 16 Oct 2024 16:58:15 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org, kdevops@lists.linux.dev
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <ZxBTFyyzZhByMjmo@bombadil.infradead.org>
References: <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
 <ZwuIPZkjX0CfzhjS@kernel.org>
 <20241013202626.81f430a16750af0d2f40d683@linux-foundation.org>
 <Zw1uBBcG-jAgxF_t@bombadil.infradead.org>
 <Zw3rDS3GRWZe4CBu@bombadil.infradead.org>
 <Zw4DlTTbz4QwhOvU@kernel.org>
 <Zw7MirnsHnhRveBB@bombadil.infradead.org>
 <Zw-YN4JIltntY52Y@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-YN4JIltntY52Y@kernel.org>

On Wed, Oct 16, 2024 at 01:40:55PM +0300, Mike Rapoport wrote:
> On Tue, Oct 15, 2024 at 01:11:54PM -0700, Luis Chamberlain wrote:
> > On Tue, Oct 15, 2024 at 08:54:29AM +0300, Mike Rapoport wrote:
> > > On Mon, Oct 14, 2024 at 09:09:49PM -0700, Luis Chamberlain wrote:
> > > > Mike, please run this with kmemleak enabled and running, and also try to get
> > > > tools/testing/selftests/kmod/kmod.sh to pass.
> > > 
> > > There was an issue with kmemleak, I fixed it here:
> > > 
> > > https://lore.kernel.org/linux-mm/20241009180816.83591-1-rppt@kernel.org/T/#m020884c1795218cc2be245e8091fead1cda3f3e4
> > 
> > Ah, so this was a side fix, not part of this series, thanks.
> > 
> > > > I run into silly boot issues with just a guest.
> > > 
> > > Was it kmemleak or something else?
> > 
> > Both kmemleak and the kmod selftest failed, here is a run of the test
> > with this patch series:
> > 
> > https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11352286624/job/31574722735
> 
> Is there a kernel log to look at? Could not find it in the run report

No, I forgot to include the guestfs console on artifacts, I'll do that
in the next run.

  Luis

