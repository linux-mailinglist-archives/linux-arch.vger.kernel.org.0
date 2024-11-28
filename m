Return-Path: <linux-arch+bounces-9183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C659DBC8B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 20:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46033164880
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640E1C1F27;
	Thu, 28 Nov 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9W5VNT7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DFAD4B;
	Thu, 28 Nov 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822448; cv=none; b=lW76/d2wKm35+WAsiPprn51nNQcn+3nHVZYUroTXCJekLRMZAJqUtpM9ppaCH7PGCGBAmOyQ8mGwiiJtJsYMVqzq879rMrJ3Nj1a5UCn2HSpduori0gNgrybW3e7vrC89yTH+K89cGsVz57LVY3zK6Td8OJOg0d7ZWIZyzxllaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822448; c=relaxed/simple;
	bh=gseeCWqiEmclO5yM18nYwsG024dsDV4mFg8cAeAR2sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFpEFM+PDc16Zf7ComUAuglrfd6Z247SZK2gXUpHkn1ZwYSOLR/i77zvHotQ17s9vYwP6vPx7ObtBYsc83/n3jdcDUQt5OGK5LotFHa6OZxpRDSare6hNDah9MEhYl10Nvo+8jg0j1/SzFWoRjEmkWuAbXK+jzk6ygeiCl7SEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9W5VNT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21A5C4CECE;
	Thu, 28 Nov 2024 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732822448;
	bh=gseeCWqiEmclO5yM18nYwsG024dsDV4mFg8cAeAR2sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9W5VNT7lC8p4Hi3gt79K5IovXmLguJOnCMwKxo52CcOVghHfSNHcLXOC4ibPgUt0
	 5DrDKxIZIHVSDHIqjCws199DcUUfiJrSlAbxayZBFVqrprGMwD7fPOaQvwhg1YVHBE
	 QBE38G7/T9zeNR1zuZz9WxUeJ0ZJZwLT4yncG4niW+J4KV1pyNajMuV8dVrdGeREhJ
	 +ADIv762rtwMTRcpwzF/UisWkkYKMny3r48wLIn85I1CwJlopzUOUIljZbBHUGj7Ia
	 tkir2vw0jOsutipdE5enupTzfwxsgjU320fYnNvUPOqcE1LSyjLQcsnz7eCvqQJJxn
	 PTe0vPBtlnI2g==
Date: Thu, 28 Nov 2024 11:34:06 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
	masahiroy@kernel.org, deller@gmx.de, linux-arch@vger.kernel.org,
	live-patching@vger.kernel.org, kris.van.hees@oracle.com
Subject: Re: [PATCH v3] selftests: add new kallsyms selftests
Message-ID: <Z0jFruPWqtieVLtH@bombadil.infradead.org>
References: <20241021193310.2014131-1-mcgrof@kernel.org>
 <CAMuHMdVG3Z63BruhrnQtSadCnaKZ+hpwFDJDnitXST8fRNYoLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVG3Z63BruhrnQtSadCnaKZ+hpwFDJDnitXST8fRNYoLQ@mail.gmail.com>

On Thu, Nov 28, 2024 at 03:10:34PM +0100, Geert Uytterhoeven wrote:
> Despite the warning, I gave this a try on m68k (cross-compiled on i7 ;-).
> However, I didn't notice any extra-ordinary build times.

I had some large values before this got merged and due to this
slowing down builds 2x I reduced the defaults. The current defaults
are no known as TEST_KALLSYMS_LARGE.

> Also, when running the test manually on ARAnyM, everything runs
> in the blink of an eye.  I didn't use the script, but ran all commands
> manually.  I tried insmodding a/b/c/d, c/a/b, a/c/d/b.
> 
> Is this expected?

I tried to clarify the ranges known we can use to mess with this test
a bit more in the recent fixes on modules-next [0] so since you want
to see some things blow up try TEST_KALLSYMS_MAX, on some systems this
is reported to crash the build.

It is why I had reduced the original values a bit...

[0] git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git modules-next

  Luis


