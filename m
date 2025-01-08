Return-Path: <linux-arch+bounces-9652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C6A06511
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8A0188A097
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA220126A;
	Wed,  8 Jan 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlOfZCHh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A81FF1D5;
	Wed,  8 Jan 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363293; cv=none; b=ZPToBZl3g+m5fVvmp9ols8AXT2nwfW/5RATMDA3oCQq8z6HIjMnJBRgG1ytgnrTuuW5aBs4lOsSY9HmXXzoZixKGzXuGXbjBSOXmmqiCcqyhyxdfmsqM6exT+0ZxqnZoRhxcwAm93QC6GoRynsfDXfCHPHpG1rFe7ymHGCN6W1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363293; c=relaxed/simple;
	bh=3PUWUE0j8aX0wTHTz/AyJlaIPaFYJp4EEy+cErusWM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8Jon2fkSTSUp9vmdy3pMcIBEZGUJ54w8IGPWk2DcBlcHZgGg0M708Mwax7/5wEhDZHyI5mQAeHnnYagM8tRpLXmcsuVytbFS7uW4k+TSvLchm8fP/SALOhctYJKhykiQttk8saOjVlys92QSJNZHtDwJfkOjdEboJR0oPnMCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlOfZCHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7925C4CED3;
	Wed,  8 Jan 2025 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736363293;
	bh=3PUWUE0j8aX0wTHTz/AyJlaIPaFYJp4EEy+cErusWM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlOfZCHhdVqInUc2ds5Ab/TSYejNly7psB4Gt6ZNCrBP/FonXZelAArjwYx4++zpg
	 G6uQpgORv/JrWJDqYAIfENqrqGH2pBdKPgtjY0e6ADbuTUeV23WtE9RrGPh6ZvXrX6
	 21bt1alGX6Wm8vrKCO0ud5is0F9fZwc0MOd8aV+LZaz9SNVfelnJ+u+6fB5vL8XS5R
	 QfGDfpq27YCX3V6xIa46Kqed7Vooo2jtSODb2TpBtS94VFx614O1myFaFz0V3lvnNp
	 LpUvPx61gkuHUiPSs7ggvtgFcB/x77nBBd+ufX3v6g382HOc10fueHzrbr06XrS5/M
	 bUZKMcn61J19Q==
Date: Wed, 8 Jan 2025 11:08:11 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
Message-ID: <Z37NGzxnUznefi8x@bombadil.infradead.org>
References: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
 <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
 <Z3iQ8FI4J7rCzICF@bombadil.infradead.org>
 <5c2ef82a-7558-4397-827d-523f8fe4895b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c2ef82a-7558-4397-827d-523f8fe4895b@t-8ch.de>

On Sat, Jan 04, 2025 at 07:30:39AM +0100, Thomas Weißschuh wrote:
> Hi Luis,
> 
> On 2025-01-03 17:37:52-0800, Luis Chamberlain wrote:
> > On Wed, Dec 25, 2024 at 11:52:00PM +0100, Thomas Weißschuh wrote:
> > > diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> > > index 7b329057997ad2ec310133ca84617d9bfcdb7e9f..57d317a6fa444195d0806e6bd7a2af6e338a7f01 100644
> > > --- a/kernel/module/Kconfig
> > > +++ b/kernel/module/Kconfig
> > > @@ -344,6 +344,17 @@ config MODULE_DECOMPRESS
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config MODULE_HASHES
> > > +	bool "Module hash validation"
> > > +	depends on !MODULE_SIG
> > 
> > Why are these mutually exclusive? Can't you want module signatures *and*
> > this as well? What distro which is using module signatures would switch
> > to this as an alternative instead? The help menu does not clarify any of
> > this at all, and neither does the patch.
> 
> The exclusivity is to keep the initial RFC patch small.
> The cover letter lists "Enable coexistence with MODULE_SIG" as
> a further improvement.

Looking forward to that.

> In general this MODULE_HASHES would be used by distros which are
> currently using the build-time generated signing key with
> CONFIG_MODULE_SIG_KEY=certs/signing_key.pem.

The Kconfig needs to describe this, otherwise no one would sensibly
enable this.

> More concretely the Arch Linux team has expressed interest.

Interest sure, but will it be used? If not there is no point to this.
What do the other distro have to think about this?

  Luis

