Return-Path: <linux-arch+bounces-7684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB598FD2C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 08:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB311C21F24
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 06:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893E8120C;
	Fri,  4 Oct 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILz5sw52"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E651FAA;
	Fri,  4 Oct 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022179; cv=none; b=tU14WwCCl8uam/FOiW2JESCcE7DRji+EK0kigON8WrMuDdqI4vRdbsOA520Kf2PiD+nrUPNHzFJ7/F8kVenLeQteFvBulR9WMv4pKccgvMm7MXLr0QX1BUoO7ONtypS+AEfmqGedaY4myM//yimv6RgMxr36DKAAhFJoGKxOrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022179; c=relaxed/simple;
	bh=icX4k6iWTdwKihZml0I/rYivU6TQM0+2sfvP4RFAs1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSL0m8t3rXf31bGqzDqLgQugtaImpzEHezkOgp/ogBtsKWSjXNf77B32az80F8gIdQa0gBc5ek1zhNCnw1AfxG9NIBnjztEM5FcfDZK0Gj/zT1t2qBlmmHZ71IX9RH1D8jjslab7meAQG/SSar6/+rc2FLH3g2za0wxhsn/vGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILz5sw52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD8FC4CEC6;
	Fri,  4 Oct 2024 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728022178;
	bh=icX4k6iWTdwKihZml0I/rYivU6TQM0+2sfvP4RFAs1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILz5sw52smTqREU1uQRy6iDVVRulopDAfhVCQtjKebS7rQmIY9wxFCwxg9Oaxd+16
	 DtN64eLDAhW+4TwvsIJMZc6RQlAIYHpM+/SjdbaGC1IrE6fVK0Efy+leFQ7kmFyiB5
	 Z5uPVpYjMGtqaK1Hiea3m6q3mBtxYuuQdbX7+wRzAdupjEbX6v1cDRJgbgAZNbaJlF
	 JsvJVTepTEI3qkdLdGM76JM+Q59gMRlIDO7ojCDusM4GqbdeyyTkRuBp7IcszSGW/R
	 k7WIIvhAJoa+miQwNmF+RlLuwQTUWbMMo4o7g3QJ3QAv40TCC5aYBBzOPkF1VhbLO4
	 V2ZF0uwTsw58A==
Date: Fri, 4 Oct 2024 09:06:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Han Shen <shenhan@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
Message-ID: <Zv-Fy4hnuscnLH1k@kernel.org>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
 <20241003160309.GY5594@noisy.programming.kicks-ass.net>
 <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>
 <20241003161257.GZ5594@noisy.programming.kicks-ass.net>
 <CAF1bQ=RAizpP-T_sRGpE2-Kjsk_RZD3r_iz_dpn25W+uDzpWOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1bQ=RAizpP-T_sRGpE2-Kjsk_RZD3r_iz_dpn25W+uDzpWOw@mail.gmail.com>

On Thu, Oct 03, 2024 at 11:20:17AM -0700, Rong Xu wrote:
> Writing the doc with all these code-blocks was not fun either.
> We are happy to change if there is a better way for this.
> 
> -Rong
> 
> On Thu, Oct 3, 2024 at 9:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 03, 2024 at 09:11:34AM -0700, Nick Desaulniers wrote:
> >
> > > > It makes it absolute crap for all of us who 'render' text documents
> > > > using less or vi.
> > >
> > > "It hurts when I punch myself in the face."
> >
> > Weirdly enough I have a job that entails staring at text documents in
> > text editors all day every day :-) sorry for thinking that's a sane
> > thing to do.

Something like this should do:

> +- For enabling a single file (e.g. foo.o)::
> +
> +        AUTOFDO_PROFILE_foo.o := y


-- 
Sincerely yours,
Mike.

