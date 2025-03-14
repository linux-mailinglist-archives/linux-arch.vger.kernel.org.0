Return-Path: <linux-arch+bounces-10837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28523A61D17
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 21:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E919C4FE4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD11547E2;
	Fri, 14 Mar 2025 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/98iReX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC9A32;
	Fri, 14 Mar 2025 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985223; cv=none; b=CJXZf0IUS4Zrwz6QipJhq66Z3jQwgJJr6yr4MrP1RCOj+Oohft+AkKG181TiU5KcM9yXg0re7JoUdiDF0LdFSkv1yGksTdbOMNx74k5EGenOAehXNuYGHpY03hUCa1ipp4vrpdzdwhj3mgXJIgIzcMlX7uHDxZgkIx/ad/5ksiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985223; c=relaxed/simple;
	bh=uHSV6oY5quPamows8Y184bxeGipJYh6CjEiQx+OX2Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb16+3BBtyF7EdbMBaxs4z/plIZaYXXjnEv4yWKsAu7s89P0M+Qgh0YhBdb8+/M9rrejWT1T3ZcRsk/ur6dJDkR1iFeji/UG+0xycKoaGGoSY/EL3Ilo0DnF3Y9gWoCLa8JW1FYTEK8VtlIHZpEv2YuPgc2M84RO+HBjo0j2ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/98iReX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE63C4CEE3;
	Fri, 14 Mar 2025 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741985223;
	bh=uHSV6oY5quPamows8Y184bxeGipJYh6CjEiQx+OX2Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/98iReXXOLjYrepz3vviDIrzCZLl/CP0pj1030dfRTdu1sSiZahBAFxCrMnxT5gq
	 rKlz8eMfLgWTLcUC6z5luotArVLP91A5XX+UXB1g8MF7V+lJfhBumzAtllMmkw6SFO
	 177D9nJ1C+lM6Leb8ChkE32UZPmlde/UmSioi7yiU7q8e7AWHiZ9JYtSMAlB4qB8Q4
	 pkvHb00vfzguhKiKYtm0HwywDNkSXs3Lb3z9sXiOYmHcE2B1H3Iv4TjaMlkGX4Zp3k
	 SdhmjoHifg8Z+9VokMTG9Aj2KMENVj4I6ivbnWqqppFuvWXMYDEKF/UIWyMRJdMVlI
	 HAdDQY+jLcuAQ==
Date: Fri, 14 Mar 2025 15:47:01 -0500
From: Rob Herring <robh@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 40/41] scripts/dtc: Update fdt.h to the latest version
Message-ID: <20250314204701.GA2210106-robh@kernel.org>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-41-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071013.1575167-41-thuth@redhat.com>

On Fri, Mar 14, 2025 at 08:10:11AM +0100, Thomas Huth wrote:
> Update the header to this upstream version to change the
> __ASSEMBLY__ macro into __ASSEMBLER__ :
> 
> https://web.git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=f4c53f4ebf78
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/dtc/libfdt/fdt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Are you wanting me to apply this or ack it? Normally we only change dtc 
with the sync with upstream script.

Or maybe it doesn't matter? Do we use this header in any assembly in the 
kernel? Offhand, I don't think so.

Rob

