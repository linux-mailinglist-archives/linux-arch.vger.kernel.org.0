Return-Path: <linux-arch+bounces-13157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0CB24C4B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044651BC0EB1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9C1D5CC7;
	Wed, 13 Aug 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzRcJ2Nt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F61BE871;
	Wed, 13 Aug 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096055; cv=none; b=SWUT69Fz7Hh1IGrn9Q7YZPtDdBcu9FDRgmJRwkBLXOmGZbg4hVLHHrYh48BsW+qzO5DY7tPTWKUMJUBeA+BDeO8kH6+BozOBzREeHIq6YOWe/Y44ewMNWm2Yyq1SjJTAqL9/wTq0TrlG49Z3iRTNLB2+hQOuPHkOT2osvLCGjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096055; c=relaxed/simple;
	bh=inQ/V1es7D8C1sOBbU8jmEPoOEVhjXaiS2i+6dubcq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnf7v/8V2qRaevGgBr3yDN7khvU++KwU6+BrLeMcukHyZVp0koK6+eDUcJZfn/bnwUqZa134vraiEh4/nN6SwrNFhJTg10qYWePyBiMlcMA5fQwJMEzIQpKNWNhIcIFv5LQOJMjDxmrbagTuZsuC66Tz9zhkQ32FIEipE7Mkc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzRcJ2Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B74C4CEEB;
	Wed, 13 Aug 2025 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096054;
	bh=inQ/V1es7D8C1sOBbU8jmEPoOEVhjXaiS2i+6dubcq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzRcJ2NtUeX2jVGoBL4N2ZiaZ+RWKs27V6hk8UUocGowRv8jwoLIMjfqQa878K4En
	 ZkHgaSBHYyJBLbueVp+ELKqyfppGM9ej7PWd3ElRROdBNscv6qmt52lp9oJk+OWx6U
	 e/nZ/inbROrVziz2KkR3zQ8p4/jylEmIZLHzQGgWGC1dwkBE5EMMYJHIRo5RTwii37
	 oelH/1Po3SBj35NL9bgY6VLDGZ+3DIr3kUqDcxbXlOKOEtxEyrST7ox3jYhjPTlxCE
	 oIRbAaXr5CZesXe6ca7s00CDo3mEsnKHx7WmCS+e/YoIlyjIlhfjkipukLk0dK3fbH
	 brmmBwiBgpYNA==
Date: Wed, 13 Aug 2025 14:40:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com, Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V6 0/4 Resend] x86/Hyper-V: Add AMD Secure AVIC for
 Hyper-V platform
Message-ID: <aJyj9XkVQRxZxc-f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250806121855.442103-1-ltykernel@gmail.com>
 <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <CAMvTesBngjSrvd1Zuto94NzZ-RztnAs3q9LMJohC4OepnoQRhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMvTesBngjSrvd1Zuto94NzZ-RztnAs3q9LMJohC4OepnoQRhA@mail.gmail.com>

On Wed, Aug 13, 2025 at 07:44:09PM +0800, Tianyu Lan wrote:
> On Wed, Aug 13, 2025 at 7:47 AM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > On Wed, Aug 06, 2025 at 08:18:51PM +0800, Tianyu Lan wrote:
> > > From: Tianyu Lan <tiala@microsoft.com>
> > [...]
> > > Tianyu Lan (4):
> > >   x86/hyperv: Don't use hv apic driver when Secure AVIC is available
> > >   Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
> > >   x86/hyperv: Don't use auto-eoi when Secure AVIC is available
> > >   x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
> >
> > Are they still RFC? They look like ready to be merged.
> >
> > Wei
> Hi Wei:
>             This patchset depends on the AMD Secure AVIC patchset. If we just
> add hv_enable_coco_interrupt() as a dummy function.  If It's acceptable,
> I may send out  a new version for merge.

Let's wait for the AMD Secure AVIC patchset to be merged first. You can
then repost without the RFC tag.

Thanks,
Wei

> -- 
> Thanks
> Tianyu Lan

