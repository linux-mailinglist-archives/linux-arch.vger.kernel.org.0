Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06C487745
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiAGMBY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jan 2022 07:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiAGMBX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 07:01:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1BC061245
        for <linux-arch@vger.kernel.org>; Fri,  7 Jan 2022 04:01:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586DE60AB2
        for <linux-arch@vger.kernel.org>; Fri,  7 Jan 2022 12:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DACC36AE0;
        Fri,  7 Jan 2022 12:01:20 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:01:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YdgrjWVxRGRtnf5b@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydc+AuagOD9GSooP@sirena.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 06, 2022 at 07:07:46PM +0000, Mark Brown wrote:
> On Thu, Jan 06, 2022 at 06:13:37PM +0000, Catalin Marinas wrote:
> > On Thu, Jan 06, 2022 at 10:09:35AM -0600, Jeremy Linton wrote:
> > > This should only change the behavior for for binaries which conform to the
> > > new ABI containing the BTI note. So outside of the tiny window of things
> > > built with BTI, but run on !BTI hardware or older kernel+glibc, this
> > > shouldn't be a problem. (Unless i'm missing something) Put another way, now
> > > is the time to make a change, before there is a legacy BTI ecosystem we have
> > > to deal with.
> 
> > The concern is that the loader may decide in the future to not enable
> > (or turn off) BTI for some reason (e.g. mixed libraries, old glibc on
> > BTI hardware). If we force BTI on the main executable, we'd take this
> > option away. Note also that it's not only glibc here, there are other
> > loaders.
> 
> Neither of those examples should be concerns - BTI is per page so you
> can mix BTI and non-BTI freely in a process (as will happen now for the
> case where the dynamic loader is built for BTI but the main executable
> is not, and the dynamic loader should do if there's a mix of BTI and
> non-BTI libraries).  The main case where there might be a change would
> be the case where there's individual excutables with incorrect BTI
> annotations which are run under this seccomp MWDE, then the dynamic
> loader might have support for disabling BTI based on some configuration
> but wouldn't be able to due to the MWDE.
> 
> Note also that we're only taking the option of disabiling BTI away in
> the case where there's something like this seccomp filter disabling
> permission changes.

Thanks for the clarification. I think we can look at this from two
angles:

1. Ignoring MDWE, should whoever does the original mmap() also honour
   PROT_BTI? We do this for static binaries but, for consistency, should
   we extend it to dynamic executable?

2. A 'simple' fix to allow MDWE together with BTI.

Regarding (1), I don't remember whether we decided to do it this way
because it was more complicated to handle it in the kernel (like the 4
more patches in this series) or because we wanted to leave the option to
the dynamic loader. It would be good to clarify this and we may have a
small window, as Jeremy said, where changing the ABI won't cause
problems (well, hopefully, there's still a risk).

If we only want (2), I just think we are approaching it wrongly. Looking
at mprotect(), this systemd feature is not even MDWE but rather "deny
mprotect execute" disregarding the previous attributes. If we want this,
something like below would do (conditional on some personality flag or a
prctl):

diff --git a/mm/mprotect.c b/mm/mprotect.c
index e552f5e0ccbd..4262e6f1c14e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -616,6 +616,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			goto out;
 		}

+		if ((newflags & VM_EXEC) && !(vma->vm_flags & VM_EXEC)) {
+			error = -EACCES;
+			goto out;
+		}
+
 		/* Allow architectures to sanity-check the new flags */
 		if (!arch_validate_flags(newflags)) {
 			error = -EINVAL;

But we could also do a proper MDWE covering both mmap() and mprotect()
and keep track on whether a vma was previously writable. A personality
flag seems like a better option as we have READ_IMPLIES_EXEC, we could
add a DENY_WRITE_EXEC.

-- 
Catalin
