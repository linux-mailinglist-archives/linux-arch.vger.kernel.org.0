Return-Path: <linux-arch+bounces-12526-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F19AEF1C2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 10:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B0A3B9004
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631E26B773;
	Tue,  1 Jul 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8GrpRus"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8825E822;
	Tue,  1 Jul 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359773; cv=none; b=YuHpZ5A3U3F8VE1WBtx1HdZ1eH/bpV8wzD0qtKE1HPNUoKP9yHtpzIc9uxYI1Zk+SspIXExnnuXdt8ZshvIAv/rSo8cYtwnm7aWDkveiirZDKTB2tPFmnIIy+89lAz8KZHjSw9O7zKvcYWz1LFcv3ECJ6XZzV6X+EGSm4RR4fOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359773; c=relaxed/simple;
	bh=DTtwMeNSk7OR8vbqD2nzw+mY8T/ya1c5lm8S+YPkjKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+LgFCKQ4yet0SUYwDPEZ/KMCSM4gUQlADZfa5WthwT2PVxEmcAFfcfYiG/jL7SYek52Bj4zZhdcFdUwjhuOD75AYd+ArmVXEtnRJa8cYK8cR9/hZVRhaRh+RtNo9Th3ubpgcxPlNdjsMFUga358/ORaxgxe8rGDzpqVOxg/md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8GrpRus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2174BC4CEEE;
	Tue,  1 Jul 2025 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751359773;
	bh=DTtwMeNSk7OR8vbqD2nzw+mY8T/ya1c5lm8S+YPkjKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8GrpRushY1OUKMgqTnLNTmT4RQ56pC9/ESJuqTHilLlFReoQzDzLcYiZotEOWx2p
	 nZuM81/AbA4802SnyFb6dgt7wn7goa7z3Lv6faHrIN23/g6CCQ/9t2PWO1awd/Lb8p
	 QQY1Q2hxI/XKIPgMXVWl8rnmoq0f9/TyNWEb1+zf+ACL3X4TM/9Qf2NrsmHQfOLOQ/
	 qPgvtnid+rOnITv0umSFn2FxE4+vDOstmuouUUNoLd3UwQoxuIDQ9RFbrDYZii1zr0
	 x+qbWJL4evGlCddzO2n2Xdfa1OVedhAQRaez0iadUajIpn5cDdn65TNLX3WJFABCTd
	 /nQgQVBfCWMfQ==
Date: Tue, 1 Jul 2025 10:49:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-sh@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon+binutils@siemens-energy.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing,
 please fix
Message-ID: <20250701-packung-zweifach-49a0189a1dea@brauner>
References: <202506282120.6vRwodm3-lkp@intel.com>
 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
 <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
 <46c6b0f6-6155-4366-9cbf-9fbbfb95ce30@app.fastmail.com>
 <5375b5bb7221cf878d1f93e60e72807f66e26154.camel@physik.fu-berlin.de>
 <ccf937cb-a139-4a07-aa47-4006b880b025@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccf937cb-a139-4a07-aa47-4006b880b025@app.fastmail.com>

On Mon, Jun 30, 2025 at 02:07:58PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 30, 2025, at 12:45, John Paul Adrian Glaubitz wrote:
> > On Mon, 2025-06-30 at 12:02 +0200, Arnd Bergmann wrote:
> >> Some architectures have custom calling conventions for the
> >> fork/vfork/clone/clone3 syscalls, e.g. to handle copying all the
> >> registers correctly when the normal syscall entry doesn't do that,
> >> or to handle the changing stack correctly.
> >> 
> >> I see that both sparc and hexagon have a custom clone() syscall,
> >> so they likely need a custom clone3() as well, while sh and
> >> nios2 probably don't.
> >> 
> >> All four would need a custom assembler implementation in userspace
> >> for each libc, in order to test the userspace calling the clone3()
> >> function. For testing the kernel entry point itself, see Christian's
> >> original test case[1].
> >
> > Thanks for the explanation. So, I guess as long as a proposed implementation
> > of clone3() on sh would pass Arnd's test program, it should be good for merging?
> 
> Yes, Christian's test program should be enough for merging into
> the kernel, though I would recommend also coming up with the matching
> glibc patch, in order to ensure it can actually be regression tested
> automatically, and to use the new features provided by glibc clone3().

Note that we do have clone3() selftests in the kernel:

> ls -al tools/testing/selftests/clone3/
total 48
drwxrwxr-x   2 brauner brauner   175 Jun  4 22:45 .
drwxrwxr-x 118 brauner brauner  4096 Jun 16 10:10 ..
-rw-rw-r--   1 brauner brauner  7377 Apr 15 10:47 clone3.c
-rw-rw-r--   1 brauner brauner  3939 May 13 12:23 clone3_cap_checkpoint_restore.c
-rw-rw-r--   1 brauner brauner  2512 Apr 15 10:47 clone3_clear_sighand.c
-rw-rw-r--   1 brauner brauner  1437 Jun  4 22:45 clone3_selftests.h
-rw-rw-r--   1 brauner brauner 10738 Apr 15 10:47 clone3_set_tid.c
-rw-rw-r--   1 brauner brauner   113 Apr 11 15:36 .gitignore
-rw-rw-r--   1 brauner brauner   206 Apr 15 10:47 Makefile

