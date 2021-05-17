Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7C386CAB
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbhEQVye (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 17:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245697AbhEQVyc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 17:54:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A091610CB;
        Mon, 17 May 2021 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621288395;
        bh=U9deKdKok+VzFOKlTKX/QNSM6gu2QbQroTH/5xZ/7fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aP84ny8Fs/au6FOc58Vbu8tzwXecGsPkJXIznd2YNXehsIGFUzIDud/9eX62S28hT
         XcBwDm/MTKgFYwXN4XpIRlVr9PCez/oLptRcnWPJyfMB1cwHni+LUs6lfDGY+8IuIj
         RStmlVeD0jwN2Tmwg3977fVIZjPXm8be2N4pWHHt6DLAF7XmDj2KrZqSdJ1Qr1abK/
         WdQ65OqPMXbw9jvdxjlLcAlU2N5ulOt9R6HyODKNsMR8dRU2y7UV7Pbj2sWsQLG7Pk
         FhyDKPr3JQTro1a4HjiJD/zrYGToQg/ecdSArZN/J1BBsrYYEDrYE9dQb/VBcNviM3
         osTbC5axoSHlA==
Date:   Mon, 17 May 2021 14:53:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
Message-ID: <YKLlyQnR+3uW4ETD@gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-8-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514100106.3404011-8-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 14, 2021 at 12:00:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As found by Vineet Gupta and Linus Torvalds, gcc has somewhat unexpected
> behavior when faced with overlapping unaligned pointers. The kernel's
> unaligned/access-ok.h header technically invokes undefined behavior
> that happens to usually work on the architectures using it, but if the
> compiler optimizes code based on the assumption that undefined behavior
> doesn't happen, it can create output that actually causes data corruption.
> 
> A related problem was previously found on 32-bit ARMv7, where most
> instructions can be used on unaligned data, but 64-bit ldrd/strd causes
> an exception. The workaround was to always use the unaligned/le_struct.h
> helper instead of unaligned/access-ok.h, in commit 1cce91dfc8f7 ("ARM:
> 8715/1: add a private asm/unaligned.h").
> 
> The same solution should work on all other architectures as well, so
> remove the access-ok.h variant and use the other one unconditionally on
> all architectures, picking either the big-endian or little-endian version.

FYI, gcc 10 had a bug where it miscompiled code that uses "packed structs" to
copy between overlapping unaligned pointers
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94994).

I'm not sure whether the kernel will run into that or not, and gcc has since
fixed it.  But it's worth mentioning, especially since the issue mentioned in
this commit sounds very similar (overlapping unaligned pointers), and both
involved implementations of DEFLATE decompression.

Anyway, partly due to the above, in userspace I now only use memcpy() to
implement {get,put}_unaligned_*, since these days it seems to be compiled
optimally and have the least amount of problems.

I wonder if the kernel should do the same, or whether there are still cases
where memcpy() isn't compiled optimally.  armv6/7 used to be one such case, but
it was fixed in gcc 6.

- Eric
