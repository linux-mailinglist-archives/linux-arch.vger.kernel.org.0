Return-Path: <linux-arch+bounces-13808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462D1BAEA2B
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2DF17E9B0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 21:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3E255E53;
	Tue, 30 Sep 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9zRW5f1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E9283FCB;
	Tue, 30 Sep 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759269570; cv=none; b=bkx1nCXdxyZ9Qnoo30mlLfYHh9wfvUm+BBK/Uth/suZUDkrk/iRwmffuGSl95H+0OGr7gRA1cj4RoOXM8ye2eODCvKeWMzDmCFh4g9fCphA+ld5M2dskJXFgUcOud/8xGTTl8qQ/z4SCGlOicoKYz9yeWc4Tag8QFMFDdCblaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759269570; c=relaxed/simple;
	bh=BVnmmKLHLEcnQVn984iBuQrv+XBJSYDym/oSwUyQgx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU3NQU1Mw0L3HTRgXEstXl88ep5REeoZMQpabUZDnFXjRlQK63JFCJUARINFSZkaB60kHa6QYzcbIShRfJOSC0EnbS7QVXaCv6CEIzmOAo3/otu1ALXa6AhEt82WcrwatVxfg+He1SlwK7G5wjoz1us7HuIaOooKcfQo6cm1N5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9zRW5f1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C22C4CEF0;
	Tue, 30 Sep 2025 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759269569;
	bh=BVnmmKLHLEcnQVn984iBuQrv+XBJSYDym/oSwUyQgx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9zRW5f1iSgD/0wmJZ/sYnhqEw5BkzmmMOMo3UvjOaQcbvvr8jWIgVVKU6+NOAX/p
	 sPkV+DgUzKNqX9tGNyktOm3KiGA89ghYhU7Gp8aVDt0ICm2Koqb07NId9ESHjquhkq
	 pOO4+WZLDbx/JYgcsUJzq3WjfOyafPJ35eDZedXB4nK14k3RetOZjFlu3iWiz9HLUk
	 IMXXKk6ZGpARVIVFCKoJKwbO2JwNDx64Vv6CTT0JNbO2zNMfaJNUFqNn63pWre1O/B
	 iWqDu+wXuUgDLjuh8IQ7bTnunYGd1nWu55gI1fY+BAqxX1v414ogVAg1YlF5HAGLF9
	 iiUJgvMEvaB1A==
Date: Tue, 30 Sep 2025 21:59:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"mikelley@microsoft.com" <mikelley@microsoft.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"benhill@microsoft.com" <benhill@microsoft.com>,
	"bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: Re: [PATCH hyperv-next v5 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Message-ID: <aNxSwL_Wga9XP-0z@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-5-romank@linux.microsoft.com>
 <BN7PR02MB414878837D34F40D23DB9506D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB414878837D34F40D23DB9506D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>

On Tue, Sep 09, 2025 at 03:11:47AM +0000, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, 2025 6:06 PM
> > 
> > hv_set_non_nested_msr() has special handling for SINT MSRs
> > when a paravisor is present. In addition to updating the MSR on the
> > host, the mirror MSR in the paravisor is updated, including with the
> > proxy bit. But with Confidential VMBus, the proxy bit must not be
> > used, so add a special case to skip it.
> > 
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> > ---
[...]
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index a619b661275b..5e2c6fd637d2 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -28,6 +28,7 @@
> >  #include <asm/apic.h>
> >  #include <asm/timer.h>
> >  #include <asm/reboot.h>
> > +#include <asm/msr.h>
> >  #include <asm/nmi.h>
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/msr.h>
> > @@ -38,6 +39,16 @@
> >  bool hv_nested;
> >  struct ms_hyperv_info ms_hyperv;
> > 
> > +#define HYPERV_SINT_PROXY_ENABLE	BIT(20)
> > +#define HYPERV_SINT_PROXY_DISABLE	0
> 
> Seems like these definitions belong in hvgdk_mini.h together with
> the definition of "union hv_synic_sint". Since that union already
> defines the "proxy" field, the definitions really should be in terms
> of that field (though I'd have to fiddle with the code to figure out
> if there's a reasonable way to do that).
> 

If we use sint.proxy (or sint->proxy) then we don't even need this
definition. I think this is only needed because the code writes u64
directly to the MSR without reinterpreting it as hv_synic_sint.

Wei

