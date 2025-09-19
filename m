Return-Path: <linux-arch+bounces-13691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97092B8881F
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552FC3AB77A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1E2BE638;
	Fri, 19 Sep 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fOZ5QFge"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8E1BEF7E;
	Fri, 19 Sep 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272815; cv=none; b=tBAYmBd2QOenQCa9ogn2X6jjoxfdhEtC/tOzDIkkp311FgyeENoVxhpTyYG1PZDjgHmYhK+kOQWR8qVPNACn95xuTZfmdiE0YX4GAfM/d96f3Ysy+qUP95RdGUg5NuA+PDitnYyE+HU80gEZ02ViwuZTGh0nZrymof2Pzg5eOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272815; c=relaxed/simple;
	bh=1yW7A+oComf/wcAUSW0nWfvML7FUNggSBtaw622QSOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivh8JCr/WxCtmy6+17cnsoykm3ujp/KvvGMEFcCVx/LqdeUnNqc4VJW1OfVDSzBleaqPTxrTdOAanEUSKsiIRuxHSNRZjAeDyxEljTSODEIw3JOa6ydKWAGJsZP4lXg0F2Sj/41OVuzWNazQNbuBQdO4YkDv88/nPxIKeFybPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fOZ5QFge; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B64F940E01A3;
	Fri, 19 Sep 2025 09:06:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2qjkM8NXCu5T; Fri, 19 Sep 2025 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758272806; bh=wGHRDwqpnW3oFoks5BATinRh9aEQBXbKrHaBS+ur7ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOZ5QFgevnHtJt0zKv1lcNNgyEYUi6N8xK3UhNLQiCaNEj3akCCp3itoaX7XnnFZD
	 6pmX9+97hyLNFlrkv5S+FKC8dBVlGKfNNgCtZrbcCbW4IS9pjHnP39HYb6cPmB0k0Z
	 uogOHwDg5SQoRqPGJveZnxRRNZ0FMRgr65z4XxUT8NQHTyUCxEITt0dHk6sPsy/jiX
	 PfCM11+ZPBo39JvUaEWbaWEjsSoT82N9Ud6orUGQq9M/KoLMjVctYRRZ5NBFLk4QZO
	 bAPek+3GZMcq5S/ozy3Pu0ezKYra+Rkiz+us9lW7QVcuSV6sYFGn754TkFNsLqeZcB
	 hQKw3P7EK/1YqKWA1cgQTQHCKzEItUKTJixChmKBkNtIoBfCuR7vOilR+ylWfrnkdU
	 voRo7+8pG2SIXeFYHnGbufBtE+a3eQKpLouYK60BTNQTdfaqTL2ixDDJXgLiN4yGUq
	 1/QuXiFKVezl7Sf1RGJeU2dYO83/k1OyPpWLR9gkiINBeqy4w2RxRoo4BiNm0knehf
	 xWoHLSdLfGAQ9/r/W+fPCEreIdTIzfoktMfmRerkUujvdTCgZPxNDg8Car05r0bMXx
	 Xf6MeEzjYDTNI9YppOmx4DBUd/gOzzJdy4uqb/DiBtpb9fh1JKSt/l6UdYgtrfo+1e
	 LGzKEfkRDi1sFa5EWwe6DNcw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9BBCA40E019E;
	Fri, 19 Sep 2025 09:06:31 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:06:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Kelley <mhklinux@outlook.com>,
	Mukesh R <mrathor@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Message-ID: <20250919090625.GBaM0dEegelsB724bZ@fat_crate.local>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-5-mrathor@linux.microsoft.com>
 <SN6PR02MB41570D14679ED23C930878CCD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <79f5d0ac-0b3e-70fc-2cbe-8a2352642746@linux.microsoft.com>
 <SN6PR02MB4157CAE4FA74E482A96471B1D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157CAE4FA74E482A96471B1D416A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Sep 18, 2025 at 11:52:35PM +0000, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 16, 2025 2:31 PM
> > 
> > On 9/15/25 10:55, Michael Kelley wrote:
> > > From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
> > >>
> > >> Introduce a small asm stub to transition from the hypervisor to linux
> > >
> > > I'd argue for capitalizing "Linux" here and in other places in commit
> > > text and code comments throughout this patch set.
> > 
> > I'd argue against it. A quick grep indicates it is a common practice,
> > and in the code world goes easy on the eyes :).

But not in commit messages.

Commit messages should be maximally readable and things should start in
capital letters if that is their common spelling.

When it comes to "Linux", yeah, that's so widespread so you have both. If I'm
referring to what Linux does as a policy or in general or so on, I'd spell it
capitalized but I don't think we've enforced that too strictly...

> I'll offer a final comment on this topic, and then let it be. There's
> a history of Greg K-H, Marc Zyngier, Boris Petkov, Sean Christopherson,
> and other maintainers giving comments to use the capitalized form
> of "Linux", "MSR", "RAM", etc. See:

MSR, RAM and other abbreviations are capitalized and that's the only correct
way to spell them.

> > >> upon devirtualization.

What is "devirtualization"?

> > since control comes back to linux at the callback here, i fail to
> > understand what is vague about it. when hyp completes devirt,
> > devirt is complete.

This "speak" is what gets on my nerves. You're writing here as if everyone is
in your head and everyone knows what "hyp" and "devirt" is.

Commit mesages are not code and they should be maximally readable and
accessible to the widest audience, not only to the three people who develop
the feature.

If this patch were aimed at the things I maintain, it'll need a serious commit
message scrubbing and sanitizing first.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

