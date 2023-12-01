Return-Path: <linux-arch+bounces-596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6192800AE3
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C54B1F20ED2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C72511E;
	Fri,  1 Dec 2023 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJ8jDacF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0724B58;
	Fri,  1 Dec 2023 12:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD1C433C9;
	Fri,  1 Dec 2023 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701433742;
	bh=2msErawXU1FtCRCS5sg1Q8l3QB+7X8g5Q4ahABRE7v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJ8jDacFlSnfz6vHti2Hqo/yYnjTmAowPHXSHHs/ZVAyHKK3vqYmj15fWpmlFSwyK
	 oDGOQXI0cD4TOPugWR4XLWNsKEWov5ibPPHMGBZmtzjTJjHNBvU0cN9CgmbjjZoerF
	 FiLiZFU4qf9MaXbefoLTcFW9iipaY39QNIHlh/Ag=
Date: Fri, 1 Dec 2023 12:28:59 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com, Len Brown <lenb@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/21] Initial cleanups for vCPU hotplug
Message-ID: <2023120131-leotard-deprecate-4e27@gregkh>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <87plzqxiyl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzqxiyl.ffs@tglx>

On Fri, Dec 01, 2023 at 12:25:54PM +0100, Thomas Gleixner wrote:
> Russell!
> 
> On Tue, Nov 21 2023 at 13:43, Russell King wrote:
> > This series aims to switch most architectures over to using generic CPU
> > devices rather than arch specific implementations, which I think is
> > worthwhile doing even if the vCPU hotplug series needs further work.
> 
> I went through the whole series and I can't find anything
> objectionable.
> 
> Vs. merging: It does not make sense to split this up and route
> individual patches.
> 
> So I can pick the whole pile up and route it through tip smp/core unless
> Rafael or Greg prefer to take it through one of their trees. For the
> latter case:
> 
>        Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Greg, Rafael?

I can take them, will do so this weekend when I catch up on patches on a
14+ hour flight...

greg k-h

