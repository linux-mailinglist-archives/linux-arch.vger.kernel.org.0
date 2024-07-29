Return-Path: <linux-arch+bounces-5674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2466F93F1E4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57A7285A25
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8871419BA;
	Mon, 29 Jul 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNxfuwMT"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE01422C5;
	Mon, 29 Jul 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246820; cv=none; b=uzSZF02cuIoxY9k4gsaTi1LPK4+alM6ybWS2N5qp7BOgpOkQzdXO+3XDNvsZGV+s73wa+rfjOQmVlxf3Po3MiKVd+CxLuorL/jjQpn74LIBOCnSA8Gyf6JYAKBu6t1Jflcg4N8TQvlh/74PIYgDFSa+CXCY4lUa2YLPP5ui8Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246820; c=relaxed/simple;
	bh=waGwMlMybwNO3CltygzQrDphXSMn46LZiyi6g/R+yFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYC4tEmfx2rIXTlvcVQUtpx7Aic5seBrN47nxOtehhPIgoWUkl7tUEsCu2HhIKzox1EW/AflVt142frT0xzokB6wgG8ijsjtImpDkNG0sNG8/+mT/Lk3C9bFWR6uyo/uYsR/B5CqwGDTN0ZGuRGuPP6AQ6dNg/KKQRGgTNe7G7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nNxfuwMT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jjG+pKIqGn1D+6CeUBJo2nl6wL62M7n6k540Ij2MXrA=; b=nNxfuwMT+vQO2UECrfkJeM/Ij8
	klMYiiXJ2Fe+pRKQGp8v0P+WGTRieUHCYRFial9e21r3/M5G6rlbH/Lw6Q+4zrKsi1dRBhNEZvPO3
	fYpMrXvrRt00mrbQTlz7dHIcekYQYFM868EC29eRAdp6ChUHTx/yq4WfvHhIB24JVpxpW+aCYJpuM
	h8aJTxiFg9bTN3JmB7twL3/lCYjjlb8cCNTn3u4b4uABIDcGApJYChhOXskIGhBHuvhekQrFcNUZE
	TqjJ5bkzJ1/L3LKv3VQWsbldpxPjGM/bcwdAFsGotHdZIJZuTk+ouFKWSHR9458/SoxoaqEudAsZf
	+000/EFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYN3v-00000004lAr-2tHM;
	Mon, 29 Jul 2024 09:53:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D409300439; Mon, 29 Jul 2024 11:53:03 +0200 (CEST)
Date: Mon, 29 Jul 2024 11:53:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	John Moon <john@jmoon.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Benjamin Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
Message-ID: <20240729095303.GD37996@noisy.programming.kicks-ass.net>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728203001.2551083-7-xur@google.com>

On Sun, Jul 28, 2024 at 01:29:59PM -0700, Rong Xu wrote:
> Add the build support for using Clang's Propeller optimizer. Like
> AutoFDO, Propeller uses hardware sampling to gather information
> about the frequency of execution of different code paths within a
> binary. This information is then used to guide the compiler's
> optimization decisions, resulting in a more efficient binary.
> 
> The support requires a Clang compiler LLVM 19 or later, and the
> create_llvm_prof tool
> (https://github.com/google/autofdo/releases/tag/v0.30.1). This

What's the relation between this and llvm-profgen? Is the above simply
a google 'internal' proof of concept thing that will eventually make its
way into llvm-profgen?

It seems a bit weird LLVM landed propeller without the required profile
generation tool.

