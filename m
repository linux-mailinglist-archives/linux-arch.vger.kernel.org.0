Return-Path: <linux-arch+bounces-7505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243898B081
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFFE1C22939
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4E188CAE;
	Mon, 30 Sep 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvm5oWhw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18C188A3E;
	Mon, 30 Sep 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736586; cv=none; b=hPdWOYDbEytJYC8OE7E2imyUyu/13Cwen0aZBik2N8C48JTiXWcNDiWPStJBLEY/1i4w2DgQSBzY4U51HPfuTuYY1RSPD2glYvnDBLkHXFV/z9fOq0BY1iut60kY3qgrozcdkXaN9txxJJWzLm/YJZ/E9dz9VOpAbnq/EwLJv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736586; c=relaxed/simple;
	bh=zPoLRt30bJVlKVAVXOnZ6LB2fb7tqlZvHqVSPN3qN5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxcN8NUfF4HW+d/t1h+wOpXHeLclB1V6gz6+qJ3D4dqDbWtVAy5CJFhHTrbhX/jK59tjefeWMOIIPeUDwuWCz1sqsbhdBCIHXndbc1L/dXmdjc0NvE1ru7HPe4Z9qiXg57vaChSzpUjTKWEmITCrj+rGvwP76N2at0VESWCdImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvm5oWhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35696C4CEC7;
	Mon, 30 Sep 2024 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727736585;
	bh=zPoLRt30bJVlKVAVXOnZ6LB2fb7tqlZvHqVSPN3qN5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pvm5oWhwhPBJ9hBKrGu8RZermgl7Exe0AntaSLL131DwlrBb+LoCYsW4wBuq93RlJ
	 0TtbJ1S/I4hXSV6nbGAZFv2/48JahA/DaAiiDqJ33FTurG8DBtXzqk70f/i1MBh0f8
	 AGB4oiTjRxI6kS/t4czj++14/PuAdB5wPyQzkbw1lV0GZ7dUvmN/S2X2rv3QgC1JUb
	 jEmXRQAk+kCDu5/pIp+mUuXjdX1rNGk7hElIHm85aConWIF0bZuLY5RYedv855xwer
	 bJO44JjAvsLFTCnBYXiIewsDpU/AHDmbJ4LkNyMKSwu/2+EeF9GIwhx9w3+zaV84Kb
	 txw4AP6ZMD4pw==
Date: Mon, 30 Sep 2024 15:49:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240930224942.puecrr63o6q2pe3o@treble>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
 <CAK7LNAQ0Z38a1Nt=_XKT3i-UpauiO9RaZAye6LXGCFzvg2R8Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ0Z38a1Nt=_XKT3i-UpauiO9RaZAye6LXGCFzvg2R8Bg@mail.gmail.com>

On Sun, Sep 29, 2024 at 08:08:43PM +0900, Masahiro Yamada wrote:
> > +++ b/Makefile
> > @@ -1025,6 +1025,7 @@ include-$(CONFIG_KCOV)            += scripts/Makefile.kcov
> >  include-$(CONFIG_RANDSTRUCT)   += scripts/Makefile.randstruct
> >  include-$(CONFIG_GCC_PLUGINS)  += scripts/Makefile.gcc-plugins
> >  include-$(CONFIG_AUTOFDO_CLANG)        += scripts/Makefile.autofdo
> > +include-$(CONFIG_PROPELLER_CLANG)      += scripts/Makefile.propeller
> 
> 
> 
> Please do not ignore this comment:
> 
> https://github.com/torvalds/linux/blob/v6.11/Makefile#L1016

That comment is well hidden, it really belongs right before the
gcc-plugins line.

-- 
Josh

