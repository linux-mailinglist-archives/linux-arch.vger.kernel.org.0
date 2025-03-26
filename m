Return-Path: <linux-arch+bounces-11149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFFA723D2
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 23:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33C47A687A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429725F7A0;
	Wed, 26 Mar 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifjLmfaS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216F1A315D;
	Wed, 26 Mar 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027533; cv=none; b=q1rNdJ/S2RBtO0Ork2tfoMrEE0xJIGPmnh3gywfaFk7LL/1Oo8pBUu8fnaZx/xhuskCRhqiy0kNyg0wNH3MA7o0WatdMXNyBndBouWWXg1PmukeriOvV0yvDCMeRgaMwuT+fIYQcZz0fXAzUXAQgd2duWfAvrBxVmaARNyT4SNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027533; c=relaxed/simple;
	bh=K3WzyobfO96VNIeCwweVniqoBNNYchgUhG7DiNyc5EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWPjLwJWOFY88Eyx/5yEycKuR2NEqyVi4x4knc5i4S1qozKZUetGHBjWdEpDqAAHDDJP3W5hjh0iyp5SjklxzNzKKS0M6kR7ip66D5vVLUN21vBa9/5lU9Z9c3mGyKJ1iKPWMippNGcpU8dvgLp+muIxl8kZBOISf6t5jriI6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifjLmfaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A95CC4CEE2;
	Wed, 26 Mar 2025 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743027532;
	bh=K3WzyobfO96VNIeCwweVniqoBNNYchgUhG7DiNyc5EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifjLmfaS2b4f7yPXPBYDL8GniFgR4/5QORIB0KiKrKbw8TMYvZLpEjxS4r8+AHL51
	 1nJDIfjqXE20glqDByMeKjfCoQbeCeRuk4K+LlELS93+UjLtTmohwTre8tPNUWjy+n
	 BA+MP5idArlIuTujU6w9pvSbAz3jf5iEd9drp8Mzb6CidDHp+ezUXiGhL4Y5uvTSWD
	 +cwyVC9985wCJq9kk6C40hZsW7JISRfixOfmQ+F+jaJ/rekskoTRPI8NN8KdE79CnN
	 YrXtkuLzLbNOcR9o0s6Dwx6/wzeQ2vGaVjcvCIch771RIAFXe03DzNm9f3uaQ2ClnZ
	 WpiIDKpe1q0ig==
Date: Wed, 26 Mar 2025 15:18:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] asm-generic changes for 6.15
Message-ID: <20250326221848.GA14731@ax162>
References: <31097083-a444-4bd1-8722-d8b7c4b7a43a@app.fastmail.com>
 <CAG48ez0ZahF98zN+qKrizDC8MBM7CM=WMBOzk7ybr55Er37=pA@mail.gmail.com>
 <8ec475fb-9972-45d9-8fd2-9406ed3862ec@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ec475fb-9972-45d9-8fd2-9406ed3862ec@app.fastmail.com>

On Wed, Mar 26, 2025 at 10:32:39PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 26, 2025, at 22:08, Jann Horn wrote:
> > On Wed, Mar 26, 2025 at 8:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> >>
> >>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.15
> >>
> >> for you to fetch changes up to ece69af2ede103e190ffdfccd9f9ec850606ab5e:
> >>
> >>   rwonce: handle KCSAN like KASAN in read_word_at_a_time() (2025-03-25 17:50:38 +0100)
> > [...]
> >> Jann Horn (1):
> >>       rwonce: handle KCSAN like KASAN in read_word_at_a_time()
> >
> > Uh, sorry about this...
> >
> > Nathan Chancellor just pointed out that my commit "rwonce: handle
> > KCSAN like KASAN in read_word_at_a_time()" breaks the arm64 build when
> > LTO is enabled (<https://lore.kernel.org/all/20250326203926.GA10484@ax162/>).
> > I just posted a patch that undoes the buggy part of my patch at
> > <https://lore.kernel.org/r/20250326-rwaat-fix-v1-1-600f411eaf23@google.com>.
> >
> > @Linus: Sorry for throwing a spanner in the works here... maybe you
> > should only pull up to the commit before mine (luckily mine's the last
> > in the stack, and it's not important), or wait for Arnd to give his
> > opinion.
> 
> I've already tagged a tags/asm-generic-6.15-2 with your fix included
> and the same tag description.
> 
> I don't think it's worth doing a partial pull here.
> 
> Linus, if you have already pulled the tags/asm-generic-6.15 tag,
> I suggest you just apply the fix directly yourself, otherwise
> you can use the tags/asm-generic-6.15-2 tag instead, or hold off
> for today and wait for me to send a new pull request after
> I get an ok from Nathan.

Jann's patch resolves the issue for me. My two arm64 boxes happily
boot with it applied to next-20250326 and the virtual test case passes
as well.

Cheers,
Nathan

