Return-Path: <linux-arch+bounces-10134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91DA3317A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 22:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE233A63F8
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 21:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66609202F8D;
	Wed, 12 Feb 2025 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g25Zma8j"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF6202F68;
	Wed, 12 Feb 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395748; cv=none; b=Hi0ZABiye4hWHtSrx8JoohRhu3CrbCs3tSpEHPOpiDsNAqAyT1qZ6aBuUn2dU44qqZStgcy1vZ24jKDbpXOulWGTgollkQynA7FozY1bXPLFyCmue2WXrZqYJZyevtP1fJEu8fof3waCfVxlM8YUfVyhjlrasRVZZahsHVpzlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395748; c=relaxed/simple;
	bh=FNuraFRyLvUDzNAGJQHElNh8dikm+1tZHhcNvHqnA6I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WT9ufVKEeXe97NAFDateWTUcsDKL7dZNgHB4QDeh9B6S+PZjEAtU2Rovyoois5Og3ZLnkNZ4+phMxf/M1UWxBdLyIy3jGw1dTBKfpqfoFO2obbeS4RXxcEhgAf8I6ngKunbf8x8ZsNDrubuXcsQDPWOdxglfehWWdvY+50qCtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g25Zma8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A0BC4CEDF;
	Wed, 12 Feb 2025 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739395747;
	bh=FNuraFRyLvUDzNAGJQHElNh8dikm+1tZHhcNvHqnA6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g25Zma8jRSe+HcXS14/PzbDN2QKhvyGISAuzT2nTIcyi0tzAmRIiqNVvrNFgRTdFY
	 7uSES7p8xqHyJhu1dnWAgQ66RboNYCKaRWkv7q9b9WRZV8cvb4OZZ1PAnjokgIQ+jB
	 A9e3YOA0hMF/EY4DR8hYmGquvFcPFjAowGvJdhHY=
Date: Wed, 12 Feb 2025 13:29:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yury Khrustalev <yury.khrustalev@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org, Kevin Brodsky
 <kevin.brodsky@arm.com>, Joey Gouly <joey.gouly@arm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Sandipan Das <sandipan@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, nd@arm.com
Subject: Re: [RESEND v4 0/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Message-Id: <20250212132906.fdf85ea62b3672cfc1115c09@linux-foundation.org>
In-Reply-To: <Z6zZanGRGd15770_@arm.com>
References: <20250113170619.484698-1-yury.khrustalev@arm.com>
	<Z6zZanGRGd15770_@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 17:24:58 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Mon, Jan 13, 2025 at 05:06:16PM +0000, Yury Khrustalev wrote:
> > Add PKEY_UNRESTRICTED macro to mman.h and use it in selftests.
> > 
> > For context, this change will also allow for more consistent update of the
> > Glibc manual which in turn will help with introducing memory protection
> > keys on AArch64 targets.
> [...]
> > Yury Khrustalev (3):
> >   mm/pkey: Add PKEY_UNRESTRICTED macro
> >   selftests/mm: Use PKEY_UNRESTRICTED macro
> >   selftests/powerpc: Use PKEY_UNRESTRICTED macro
> > 
> >  include/uapi/asm-generic/mman-common.h               | 1 +
> >  tools/testing/selftests/mm/mseal_test.c              | 6 +++---
> >  tools/testing/selftests/mm/pkey-helpers.h            | 3 ++-
> >  tools/testing/selftests/mm/pkey_sighandler_tests.c   | 4 ++--
> >  tools/testing/selftests/mm/protection_keys.c         | 2 +-
> >  tools/testing/selftests/powerpc/include/pkeys.h      | 2 +-
> >  tools/testing/selftests/powerpc/mm/pkey_exec_prot.c  | 2 +-
> >  tools/testing/selftests/powerpc/mm/pkey_siginfo.c    | 2 +-
> >  tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 6 +++---
> >  tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 6 +++---
> >  10 files changed, 18 insertions(+), 16 deletions(-)
> 
> Andrew, Arnd - are you ok if I take these patches through the arm64
> tree?

Sure.

