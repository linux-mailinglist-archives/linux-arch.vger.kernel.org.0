Return-Path: <linux-arch+bounces-7503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F098AE61
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE02825C9
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B341A2545;
	Mon, 30 Sep 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y36Z5gFU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BE19882F;
	Mon, 30 Sep 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728156; cv=none; b=AkLL96vLbEMJm5jkazzaiioUfquMsl5BQ9VOXHSnUdZiFNEQrSkmESF81bwpBeUz1o7tRA/jNKfNgobSptfvLxPi8ihURjpVkdm9zWqkZTbC15b/AEbzwME5JV6ySGNHzlD4s1ihhrv3uparS1lQAoIv/httC8SS9cfF0Dbk57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728156; c=relaxed/simple;
	bh=YiaWmx4C+Wz5BdawBQdt6XQcHpZFtuPbrE1OBh+7RHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQqfTtAxbihpPsoVmDUuYd9TQXTir6n+oJuJNh505GHNT2n2S6SbLFGCoBLGzmtFV4z3wUMYSi+zuzNwl9jZOi4HZEheXXKXy6xHT1/YgHQ5ywYkeHm1+W6R0exphi6snYeFri771ucEWKP+XSU4ezIMrhlcQ7gBF2SW3IhSVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y36Z5gFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C96EC4CEC7;
	Mon, 30 Sep 2024 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727728156;
	bh=YiaWmx4C+Wz5BdawBQdt6XQcHpZFtuPbrE1OBh+7RHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y36Z5gFUJMhKC1P3Fgs33xQwUxd7cXW0xvyy75tpTfLf3iKm0NocvzMZFqkFiS5tu
	 W0anNMdHAiPyWLdBvvNvfIrTYKIK1Stb01bo+V0xg5uqt6tHD+/I3RXe1URRD2AW/r
	 kq/ghRbt2mV/xoMb7mJB4CTp5XincIJADHBVerxaZFKKUZAbAX59ksLP9cQjn5KufN
	 g/aSKsbeEtPHRe0uBIrHO/PwJJY8ilgb+Ytl6O53uFhoh+yw9skrJK5Bosqrf0nRPt
	 TR5ft9baBq6pWSjsF7T8WRURA/naor6G0QMc16aTAHFZ9l64fag/acedSUrLYyjE06
	 9DlSRg5ucss4g==
Date: Mon, 30 Sep 2024 13:29:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Maksim Panchenko <max4bolt@gmail.com>,
	Han Shen <shenhan@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Stephane Eranian <eranian@google.com>,
	Maksim Panchenko <maks@meta.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
Message-ID: <20240930202911.GB1497385@thelio-3990X>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
 <c65a07ef-6436-4e04-a263-7cad9758e9be@gmail.com>
 <CAKwvOdm0iZspjpuueBV1=eFt+Bf4edWBZsDsj10kEvTGZRye2w@mail.gmail.com>
 <20240928173530.GC430964@thelio-3990X>
 <CAF1bQ=QoNNLVKRpaXyJ8pm+NcnSyzmpgAN5ktu=Fqim9HkF4rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1bQ=QoNNLVKRpaXyJ8pm+NcnSyzmpgAN5ktu=Fqim9HkF4rA@mail.gmail.com>

Hi Rong,

On Mon, Sep 30, 2024 at 10:07:05AM -0700, Rong Xu wrote:
> I don't find the Clang Build Linux meeting in the link of
> https://clangbuiltlinux.github.io/. There is no Wednesday meeting in the
> upcoming event. Can you confirm there is such a meeting.
> We will be happy to join to chat about this.

It is in the "Useful links" section, under the "Bi-weekly video meeting"
line. I'll copy it here just to make sure you have it.

Calendar, which should show the October 2nd meeting at 12pm Pacific
time:
https://calendar.google.com/calendar/embed?src=47005f8f50f21da6133d7239f3cb93d1624d2e1949963ea75dd86d5f2d5721e0%40group.calendar.google.com

Meeting link:
https://meet.google.com/wrr-mxkn-hdo

Cheers,
Nathan

