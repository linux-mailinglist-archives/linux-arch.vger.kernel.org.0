Return-Path: <linux-arch+bounces-5964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB899474BF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 07:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96669B20A4B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94811411F9;
	Mon,  5 Aug 2024 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a/xoOzL/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBA13D601;
	Mon,  5 Aug 2024 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722836715; cv=none; b=q2CTYl1DafptkE+MqR3RUHaotybj6AsPNugXZq1S+JkKKzdFqZxwfFCY3/2OOED4+RcQdT03MMZMkTMWB3S1lewhBX96yNYewYAL6TouXWTN8LDdDHPCn4I/ZXyKXQQ5Fj5eQbD3p1c/qb5e3W+6YhC9WP3+8pdhugi7+CWnnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722836715; c=relaxed/simple;
	bh=xgAvTmM7O7bvPSR38dn8bXIRrhb9B5U9BWQYWUc2fig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGPgGIX+uk8fyfBJov5itVKbwgVsXvPQOeViCdP39cbmorMOhkTcamypBk9tDcgu6vYkqbQ2kXZ9J8UsJJuOTv1AszVGJ5PlwXRExeedpYqWLGIi1v69wAC0vCQx0/PW7V1DgptWwgU8kYERZZVbaxU3JFe5jSZvhfa3aDXfgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a/xoOzL/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id D724C20B7123; Sun,  4 Aug 2024 22:45:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D724C20B7123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722836713;
	bh=i5i+KuQ6TGpWP8YXxONrIPb1JeA6n+teDHyNuesadOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/xoOzL/JCoYAk2vYHA/XAI5n+9WwnTr3GNx+lpOHeoMJxMlf+usRapO4O8YMs3iQ
	 eJMH2uQSs3X1N/Z61BajbD/JZHAP3Ecb23Qp9v27qleWLyQmG7fEkmhdv5t2I/hepw
	 KKYi8y5VlaBexIoVP6R3OZOGijYJNWs3Ra9SauL4=
Date: Sun, 4 Aug 2024 22:45:13 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de,
	bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com,
	kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
	mingo@redhat.com, rafael@kernel.org, robh@kernel.org,
	tglx@linutronix.de, will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
Message-ID: <20240805054513.GA28829@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-4-romank@linux.microsoft.com>
 <Zq2GMNnRFqH4psLv@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq2GMNnRFqH4psLv@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Aug 03, 2024 at 01:21:52AM +0000, Wei Liu wrote:
> On Fri, Jul 26, 2024 at 03:59:06PM -0700, Roman Kisel wrote:
> > To run in the VTL mode, Hyper-V drivers have to know what
> > VTL the system boots in, and the arm64/hyperv code does not
> > have the means to compute that.
> > 
> > Refactor the code to hoist the function that detects VTL,
> > make it arch-neutral to be able to employ it to get the VTL
> > on arm64. Fix the hypercall output address in `get_vtl(void)`
> > not to overlap with the hypercall input area to adhere to
> > the Hyper-V TLFS.
> 
> Can you split the fix out? That potentially can be backported.
> 
> > 
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> > +
> > +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> > +u8 __init get_vtl(void)
> > +{
> > +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> > +	struct hv_get_vp_registers_input *input;
> > +	struct hv_get_vp_registers_output *output;
> > +	unsigned long flags;
> > +	u64 ret;
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> 
> Hmm... I don't remember why the old code didn't use
> hyperv_pcpu_output_arg but instead reused input+OFFSET as output.
> 
> Saurabh, can you comment on this?

This was done to optimize memory usage. Michael has provided more
details on this in his review of the patch today.

