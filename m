Return-Path: <linux-arch+bounces-2986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFC87B6B5
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 04:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036471F24F3C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CF4A1B;
	Thu, 14 Mar 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kUGN9n/p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4646A0;
	Thu, 14 Mar 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385573; cv=none; b=jCyQn1cUbJwShoHANIAK/o21yGeNbvxVNKDPw0o+a78usLFGgdlBO+rqY6/QIbx+2Edk8nL0bPoU5JqoFWlGK8N+EYZGoEAg6MoQ5gLr+mf5CpNR5Nj349KKYXNiBmcDdiSsWgroAWorfbUES8rE2k+kY4V2CQ26+FgzzkDs8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385573; c=relaxed/simple;
	bh=Zy7G5gkxAhePFRmAZBqv4sg0IfP1/ZT/DzlhbJR2C/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr2B2OJKGDt1WH74pNvaFk4INactTxX6MvHI/FKOBD8UIAeYBA5kUxQVt2IjlAPyGGelG4i2FVEsZyeYHaAn49zLOxEhysmtWjRJuC4oeCH9XV30hbmM3L2aFhSTFNdu8y8Ji4Lnm3qP9XLKH9BWxukmLhqdSgxYShLLqfq9O5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kUGN9n/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0760EC433F1;
	Thu, 14 Mar 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kUGN9n/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710385569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mfqn13tNITO64Ws27/XSGmkIxrY7ymxmZCHLwDn78Ds=;
	b=kUGN9n/pD7Ai65B5Lq4dRGx0dBUtYKNprblt8xNXPhIK0jjdne52fMHfRZ8UoeD87AmoQC
	aAJ8wRVvQPrPDodTjw+yYLn0SXYor7bjyyIVfQm3kffCZONJxlGxwtMOllMuhBlCDIiwz+
	jXnwcp3WeM7fUrrp4mt4mfNZZo79mT0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 634e0280 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 03:06:08 +0000 (UTC)
Date: Wed, 13 Mar 2024 21:05:55 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"tytso@mit.edu" <tytso@mit.edu>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Message-ID: <ZfJpk94mtwzRaJzv@zx2c4.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
 <ZfI3owmQOKc4Ta_X@zx2c4.com>
 <SN6PR02MB41576DD458EB3C72F3784EDBD4292@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41576DD458EB3C72F3784EDBD4292@SN6PR02MB4157.namprd02.prod.outlook.com>

Hi Michael,

On Thu, Mar 14, 2024 at 12:30:06AM +0000, Michael Kelley wrote:
> OK, fair enough.  But just to double-check:  When this is called,
> the EFI RNG protocol has already invoked add_bootloader_randomness(),
>  and this line has been output:
> 
> [    0.000000] random: crng init done
> 
> I don't see an obvious problem with calling add_bootloader_randomness()
> again, but wanted to confirm.

Yea, that's very much okay. It'll just get added as extra, which can't
hurt.

> Also, if we're adding this ACPI-based randomness for VMs that
> boot via EFI, then for consistency we should use it on Hyper-V
> based ARM64 VMs as well.

Agreed.

> Both bounds are just a check for bogusness.  Having the hypervisor
> provide just 4 bytes (for example) of randomness seems like
> there might be something weird going on.  But widening the bounds
> is fine with me.  I'll use "8" and "SZ_4K".

Ahh, as a sanity check that seems like a reasonable heuristic.

> > > +	for (i = 0; i < length; i++) {
> > > +		header->checksum += randomdata[i];
> > > +		randomdata[i] = 0;
> > > +	}
> > 
> > Seems dangerous for kexec and such. What if, in addition to zeroing out
> > the actual data, you also set header->length to 0, so that it doesn't
> > get used again as 32 bytes of known zeros?
> 
> What's your take on the whole idea of zero'ing the random data?   I
> saw the EFI RNG protocol handling was doing something roughly
> similiar.  But yes, good point about kexec().  Zeroing the header->length
> would make sense to prevent any re-use.

Yes, I think zeroing it out is the right call. I wonder, though, what's
the deal with the checksum adjustment? Should we be checking the
checksum before using the random data? And do we have to adjust it like
that at the end, or can we just zero out the entire header (including
length) along with the random data?

Jason

