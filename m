Return-Path: <linux-arch+bounces-15555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB85CDF4FF
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 08:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978523007947
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272C241663;
	Sat, 27 Dec 2025 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hody+CQ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8380139579
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766820219; cv=none; b=AszrCGWnebiR7FQUuA5TGO3w28/uZNSbWogq+0hyVV++09ifWb4RnktkBM+awk2c5qNI0FM+6KzxpkFPCOHnbLBxbXFqD/313SfZpcXR5nztIqFTHxWrOfCxQcrFDpxLJqEz95Re+/OgHiCqULkhZitOADR5C/ee0+tFwUcuARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766820219; c=relaxed/simple;
	bh=g9ldB6O6bVHCvyESM/CQAWSSYcQLbHp0GjU/NyOaOME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMSHpHGcmT01yNJ4fiGhVmWmsIKD5nBLv9qHA6zzG/kypkK+3KE49vfvl0c0VMQygGTIHlxxGk+1fezb/EMoWot9RHyPtj+NeM1E8dGqa88E+ZSRcos/5jKahgmmLH4OGG7qN7BS5aOfxwAsivGZVklFHPSgJU/RDggI0qQT8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hody+CQ8; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed75832448so111554981cf.2
        for <linux-arch@vger.kernel.org>; Fri, 26 Dec 2025 23:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766820217; x=1767425017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVDaDyn3dfV/+peO8SiV62+8Z0bhbSec+/MWVYkLLCM=;
        b=hody+CQ8gr+tECgNyOaZu+/4ohkRtTium+y2aJl8AMXJP4gj923VDCvnvQJrH/yp+b
         0BiIpAPME/vMNkQUW9SdOJS4bcl60xuAV8SlKK80DxBnImpOzSXu9S/rEkT18NV+/t3u
         u9GUWpaJUK6RmOv6kOiQ43xyub9IsRh539tKCE/P5VWxRpXFnz5aGj7k5G1un52yKowP
         YyRAaz7jqd/TzVEQA7PptJQKizNPqyAp1bM1DBrBc05d9NH943pXMJAzL9id9wln6pWC
         Qnk5mx0Qb8euvw5enBs9hMeVsYgBwzO8dVfNTpxFA8Kgdly5ysAtrO7kN8jD5vIX3llH
         cb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766820217; x=1767425017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVDaDyn3dfV/+peO8SiV62+8Z0bhbSec+/MWVYkLLCM=;
        b=Y4ICYWLRH2X67DCJdKAInHy4YgF/uIiukP9G+A1+bs5IckOOH+CCADIP2TNzDm7uy1
         x7J9BdvvSGaIgVe9eP1VaWzZQkleKcAuIgfPxQ7yDiOCwoM6NyY+ClnWpAXGrbt7c/qo
         OLhDQta2rhgU5sIa4EmwqGjK6HsFne63BauWex7z3T6uNbMS1++levab+I3/YoTdJYQH
         Fvke9bKqbDp5h+af9b2iyMXScO/EyBsIfSd/v1Ag1yh3aC5YmQl/gD6gX2EwD6zOA2oE
         wjIpxeVH1Jr/3+3XOFwGyzIDkHlYVTlIN6hQahm7rgaHO8x+ru6+pr42y9HBQ5SPaWWo
         wWeA==
X-Forwarded-Encrypted: i=1; AJvYcCXJgkWAibNdcN56OkTfMeR95llB5CK4J810iR732oCKq5bQ6eLfvKVmO7uWedJhPURgpp9OprDp6zpY@vger.kernel.org
X-Gm-Message-State: AOJu0YzodbuCaPMeWIiCitJeHognqlTeUUSSuBt/1ZqylPaPscYUjqm0
	guARAilOut4p7GNC5fP/8ZtSeZZqiqNcUGFUcNx/gef2L70HD7stTceL
X-Gm-Gg: AY/fxX616d6PuvBNaGYxV3pfTiedo7+WZkR51m+JlN6cG8k2aRdlMROYwxHkmXb6WJx
	+wpms9M+1GSL3y/2saFSbLOL5j5i7RO9fK2sOqm/JeikaiQOWugrZpgo/2xYAkXalGw6xdjTsoe
	hZBz7CS3rqlqxNOPZDI5b/gWY2NZAmAgkiSkbs6pHVyJ6BAfqRJx73yis4s1e0xrauw/aOxS27C
	QkTFuNv4DLF45WlFWHShvyH7CrkDYX4Psq6Wl8AZ8RDPcPZQuQ9xDP/Lq4HbAItzEWf5embfs6h
	7i9ZOCQ+Og7/mIngQ/UhSV/djOoas43SRFsVBZDf0OyyqkfHiDgbuJHnh6T+PtOxUiJLqM3yh2v
	vqPt+hQHHQZxQOSFtnuhqvAE85EWMV4vTiW/E7j7OMIDDPJtpl3Mbk2M7t2sMIZpMh7YKDGUHjm
	ukKHInnr015AKmEVfXQLMdpsIIuz8aVeVtZ9HJCXmtPqnS3h+bjNFZ1+NRbmiYTNTOeIrk2tTZM
	vaCpL16Nt12Urs=
X-Google-Smtp-Source: AGHT+IH5YlDNuhdqgZkcT8Q71X+gLy2cngnRcFn5/w5BdkiLdny1m5eUvNOpk7WIIjn5j+XzqyYYug==
X-Received: by 2002:a05:622a:6982:b0:4f1:b3cc:2d04 with SMTP id d75a77b69052e-4f4b45ddc56mr219167781cf.44.1766820216709;
        Fri, 26 Dec 2025 23:23:36 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62fa56sm190298711cf.17.2025.12.26.23.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 23:23:36 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 78603F40068;
	Sat, 27 Dec 2025 02:23:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 27 Dec 2025 02:23:35 -0500
X-ME-Sender: <xms:d4lPafEDY_u5y7hHXuwGc-2o0BgJEtOd3bLGWVbHoAgRXNQ_nc2_kw>
    <xme:d4lPaWY-yTeJKhh-7pja5od6A9KNieBzqvi5p0KOh-ZdF42oSAmwIOJAolscDjdPy
    cE3ca_aFWa232mkjnwsPsRvmtvpAjuewRRGzSCowBr_zAJKyu2jSPU>
X-ME-Received: <xmr:d4lPaWGBcZawmQZ9rAZRmkDf8lf3WeDIBi5dAPcqS1L5Al0WSNpOaWFwz5K->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejtdejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonh
    horhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    drhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhih
    hhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhoth
    honhhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrh
    hoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:d4lPaU0f6-Uhk8wilVjJ5tRp9woN4EZmKo9GqhAJzpXRKCd9iIDMBQ>
    <xmx:d4lPaSx1_WGNrP3itiwka3T2yqFv48u6cmF-iJqvZvaYTGDxXQ9p9w>
    <xmx:d4lPaVi5N2R6yQRX48YXIgwBdKSsLRRhR0kNTH3GGvYaCFCpNN8xIw>
    <xmx:d4lPafNB3xlVqmlK9s2D4Y3rKuEttggQLNCiKa5vQveJgMUnBT4Iew>
    <xmx:d4lPaYfuvT7UrMWtL8Nao27_pr1DY28w2KFeyneWsFVgSG-x5BSQ6Jvz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 02:23:34 -0500 (EST)
Date: Sat, 27 Dec 2025 15:23:30 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gary@garyguo.net, ojeda@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rust: Add i8/i16 atomic xchg helpers
Message-ID: <aU-JcvYaOYznqD-M@tardis-2.local>
References: <20251223062140.938325-1-fujita.tomonori@gmail.com>
 <20251223124639.7771082d.gary@garyguo.net>
 <20251225.095655.275822477142372376.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225.095655.275822477142372376.fujita.tomonori@gmail.com>

On Thu, Dec 25, 2025 at 09:56:55AM +0900, FUJITA Tomonori wrote:
[...]
> >> The architectures supporting Rust, implement atomic xchg families
> >> using architecture-specific instructions. They work for i8/i16 too so
> >> the helpers just call them.
> >> 
> >> Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).
> >> 
> >> Note the architectures that support Rust handle xchg differently:
> >> 
> >> - arm64 and riscv support xchg with all the orderings.
> >> 
> >> - x86_64 and loongarch support only full-ordering xchg. They calls the
> >>   full-ordering xchg for any orderings.
> > 
> > Maybe it's just that I'm reading this differently, but I think this is a
> > bit confusing, as if there's an optimisation opportunity.
> > 
> > x86 is TSO, so even a relaxed xchg is a full xchg. So in this sense x86
> > has implemented all orderings.
> 
> For x86_64, I agree that the wording is confusing. xchg always implies
> lock so different memory orderings all map to the same full-ordered
> xchg there.
> 

I feel a bit confusing as well about the need of mentioning the exact
ordering of these primitives on each arch. In my opinion, as long as
rust_helper_xchg_X() is mapped to xchg_X() in C, then it's clear that
they have the ordering of the corresponding C APIs. But I keep it as it
is for now, I may remove them from the commit logs later after I
re-think about this.

> 
> > Looking at loongarch ISA manual it's suggested that apart from load/store,
> > all other atomic memory instructions are also always full ordering.
> 
> On loongarch there are two possible implementations: an LL/SC-based
> one, which is effectively always full-ordered (similar to x86), and an
> AMO-based on, where weaker orderings may be possible, as only the AM
> variants with the DBAR function appear to be full-ordered.
> 
> 
> > The change themselves LGTM, so
> > 
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> Thanks a lot!
> 

Thank you all! Applied in rust-sync:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ rust-sync

Regards,
Boqun

