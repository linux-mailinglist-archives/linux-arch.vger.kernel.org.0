Return-Path: <linux-arch+bounces-10822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12742A612E9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568194628C5
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24A1FF7D7;
	Fri, 14 Mar 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqywUOCe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A171FECA2;
	Fri, 14 Mar 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959741; cv=none; b=FbyC75YsqlsOE9B3R/HFcbxKRIJWAvyl7NknlksoXxOXobjSuBcjwtBgBXAEVzohiDuyedau7+JKzMzQD4Fvl4oX1bxl2eQyXFRyWQEzsRA2Ps05G7Gn2c9X3owZNXwOtPD/Cd2PteOaPmXdfXnRfovg3fI3aTXKjz0RmoPoldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959741; c=relaxed/simple;
	bh=ivdYHqGLMkeXJqwqg++93TWjmOD1Os6/6DS4DUvAFeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeGDVL75jxom8PxMRrxzEUPYJFm6TUGYL1syEl2FfzufCEy/DL3E5y/cMZ23XBm9TPEe7XKXFVnBBSP/NJuSsYTwU7DkjjXE5Oc9tdASy+C+MbMm6V2R071hfuC1umU1u5cGsurpi8s+7hTyWBW+0AX6B6LUiRng3NGy4YoxXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqywUOCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1064C4CEEB;
	Fri, 14 Mar 2025 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741959740;
	bh=ivdYHqGLMkeXJqwqg++93TWjmOD1Os6/6DS4DUvAFeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqywUOCeJ+nONc2C6iNusLSzDRIra+gplxk1sdomCDT+GbRMBvq1Iqsq/xcfjuFhF
	 5s6thcX21YS3Hk3CMW7u3orC1NEkSvG2ZcMM2g9bECOWlPxCwluDVA2c4EBjT/zOgT
	 Z6vGuq4pTqh/2atppwQVpnG7+NO4x6jQpJlaqZMiZks//28H9F8WrJzXcvurGeKdoP
	 xDwqrkJ6dQNYQXG1EJ6nHqmVQ05mINopc3TkcaPfb13ohvbfDMGpja/y47rwxSFkkI
	 ILGfpldhxE9+/fKHgn9wfKsHu/rZ1z5gGfd1FIzUggNIrF+Yht5w6pKIpIZGDVJYXh
	 l9MaYy65Uz7zw==
Date: Fri, 14 Mar 2025 13:42:16 +0000
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 08/41] arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
Message-ID: <20250314134215.GA9171@willie-the-truck>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-9-thuth@redhat.com>
 <20250314115554.GA8986@willie-the-truck>
 <df30d093-c173-495a-8ed9-874857df7dee@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df30d093-c173-495a-8ed9-874857df7dee@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 14, 2025 at 01:05:15PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 14, 2025, at 12:55, Will Deacon wrote:
> > On Fri, Mar 14, 2025 at 08:09:39AM +0100, Thomas Huth wrote:
> >> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> >> this is not really useful for uapi headers (unless the userspace
> >> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> >> gets set automatically by the compiler when compiling assembly
> >> code.
> >> 
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  arch/arm64/include/uapi/asm/kvm.h        | 2 +-
> >>  arch/arm64/include/uapi/asm/ptrace.h     | 4 ++--
> >>  arch/arm64/include/uapi/asm/sigcontext.h | 4 ++--
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > Is there a risk of breaking userspace with this? I wonder if it would
> > be more conservative to do something like:
> >
> > #if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)
> >
> > so that if somebody is doing '#define __ASSEMBLY__' then they get the
> > same behaviour as today.
> >
> > Or maybe we don't care?
> 
> I think the main risk we would have is user applications relying
> on the __ASSEMBLER__ checks in new kernel headers and not defining
> __ASSEMBLY__. This would result in the application not building
> against old kernel headers that only check against __ASSEMBLY__.

Hmm. I hadn't thought about the case of old headers :/

A quick Debian codesearch shows that glibc might #define __ASSEMBLY__
for some arch-specific headers:

https://codesearch.debian.net/search?q=%23define+__ASSEMBLY__&literal=1

which is what I was more worried about.

> Checking for both in the kernel headers does not solve this
> problem, and I think we can still decide that we don't care:
> in the worst case, an application using the headers from assembly
> will have to get fixed later when it needs to be built against
> old headers.

Old headers might also just be missing definitions that the application
wants, so I suppose there's always the potential for some manual effort
in that case.

Will

