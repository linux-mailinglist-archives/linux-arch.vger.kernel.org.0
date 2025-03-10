Return-Path: <linux-arch+bounces-10600-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E5A589A4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 01:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E206A7A4C79
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CFB664;
	Mon, 10 Mar 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWoq/Wfj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF5A923;
	Mon, 10 Mar 2025 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741566131; cv=none; b=REu7xqDZyVvTS0diucu9uhUjtpEwjFVbcMI0ljj2kjcMbbObn9EMj1GdjUYc6qhrcn9glZW10CMPZ1RQAcnHVj5/raQm8uYpCtILddIAk5I/04OT2Bs0yv5ch6eN8iMTUwqZN9RQrs8ElC8jZsdnZ2PwwQ1rJzwzqsyFrM5Vwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741566131; c=relaxed/simple;
	bh=FYjQC5mh8x+Hka3tJHdCG5/gL2oMN/JPR566i+y+ZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqfVugto1lQtB8AeJHzBvE1/0ZxpClVC6Up0wlD5RyEHWqXbxHkKI44NrjRwCZPrxdSR46imI2hxCCsVsNFV67QiFauCyaCDX41Sn21D9fhvhSIii0jVxKFRF0bQVE9envBD6s8sIXy8Uhl7LhKBCm3Ke2GcfAjFA69gtHZnJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWoq/Wfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A5C4CEE3;
	Mon, 10 Mar 2025 00:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741566130;
	bh=FYjQC5mh8x+Hka3tJHdCG5/gL2oMN/JPR566i+y+ZE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWoq/WfjxHOollcBZFzbuS2LL5a2hh3EvGiVEeillSO6nSKlyjiy3r7gD0RujkLBl
	 qmI/XPB17xvuob1ImnJmfq3/MGZsajC7FhIiXiMA9AmXjJe/mAvgjWMeNz+VYDK/Qc
	 Ymyuza6kxYy+EAilWgAYeOqNPD3hC8QRfdnsRelOIfnntqygfjkA/ziVDNtgjRvYZ8
	 W+5fRKSiTE0f9q8m9iysuEdplycCeKvtwyO3dQ6gsvFXfWtqq/v8t6sirzmatiRgOn
	 J4qKHOGYSu4/JTskx7/UVcrk+1ZiaAhXjJyhSY1C6BUjRPB6gh7vwnddK94aykxRi/
	 Vj/E2zyA1AUvQ==
Date: Mon, 10 Mar 2025 00:22:08 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] x86/hyperv: Fix output argument to hypercall that
 changes page visibility
Message-ID: <Z84wsC8ADzZusVVY@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-2-mhklinux@outlook.com>
 <f6115867-281d-4c97-87d2-3698e6474b7a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6115867-281d-4c97-87d2-3698e6474b7a@linux.microsoft.com>

On Wed, Feb 26, 2025 at 02:59:53PM -0800, Nuno Das Neves wrote:
> On 2/26/2025 12:06 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > The hypercall in hv_mark_gpa_visibility() is invoked with an input
> > argument and an output argument. The output argument ostensibly returns
> > the number of pages that were processed. But in fact, the hypercall does
> > not provide any output, so the output argument is spurious.
> > 
> > The spurious argument is harmless because Hyper-V ignores it, but in the
> > interest of correctness and to avoid the potential for future problems,
> > remove it.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > I have not provided a "Fixes:" tag because the error causes no impact.
> > There's no value in backporting the fix.
> > 
> >  arch/x86/hyperv/ivm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > index dd68d9ad9b22..ec7880271cf9 100644
> > --- a/arch/x86/hyperv/ivm.c
> > +++ b/arch/x86/hyperv/ivm.c
> > @@ -464,7 +464,6 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
> >  			   enum hv_mem_host_visibility visibility)
> >  {
> >  	struct hv_gpa_range_for_visibility *input;
> > -	u16 pages_processed;
> >  	u64 hv_status;
> >  	unsigned long flags;
> >  
> > @@ -493,7 +492,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
> >  	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
> >  	hv_status = hv_do_rep_hypercall(
> >  			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
> > -			0, input, &pages_processed);
> > +			0, input, NULL);
> >  	local_irq_restore(flags);
> >  
> >  	if (hv_result_success(hv_status))
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-fixes, thanks!

