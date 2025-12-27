Return-Path: <linux-arch+bounces-15556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A11E9CDF580
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D63E300A344
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435593A1E60;
	Sat, 27 Dec 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUp/M71f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D753A1E6F
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766827045; cv=none; b=VgTC7F7lTtaOrVigG/sXEjS96cvoNptXecwvjCP4jh4D8wzdsAgBXi72UZbFmchoTQGN+ifn/tj4V1aE3v3z3zaqSPRvV/PeF5xJ5snfESdLd8rSTgHLo2pcggDlQb5WKRFdDI+RJ6i0nO9A2hU0JrIT1JGkkeCK9Yicz/GGUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766827045; c=relaxed/simple;
	bh=6k8i2HyDBlJeEmoAzrTDq8MMdF3dAWje2vWj2UgKJe8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jFQugC2li57lkVBozqIbd3a/kQqb/kQXOTIOZnq5RpXCVLUpIc+jyTTenpo5+4CkjyY7cIsbeG4LgtsmjBLBftO7sfDInMMfLt8FzAZpxzIrusFZN9dvG4FFoougRuwUlZHIyF/K28ST1Nj3HrCH2Mng3P9kHaiUBZSgjbVT4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUp/M71f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d6f647e2so125630715ad.1
        for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766827042; x=1767431842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lb2awl5oM8YhXOdTB1C7Rw3aEZxsQeDmJkQlR7fqJIc=;
        b=iUp/M71fVorpw9SiCCm7DX0i0QTZ/heSOT13Z9RD6C81Xa05Po0AjsPLDn1iZi55w3
         M4+Rljutd69DIPgXaRjl34H127psNuEGPQ2HWPF7VJlKXklGUMu2JjRPKdDoDdW7U82G
         dtvCtSvY2nSyIJEM35XcNjaks/rr5OfKcHREo0oKr8Cgo7tWpnTHpvMiBtzPtK0zVRp6
         2p2aBMK1FlYU7Ltgaush5vSptXCVdYHLk0LqVqM5twptWjC+WSlsgk7XZj9LUep85IVV
         JhL49v6HDNoBI9sMG+LeZ9h0Wr3ZyARIWHNDz6587aX9rcVSCodQ0RlUL/G2vuUd3LtK
         QDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766827042; x=1767431842;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb2awl5oM8YhXOdTB1C7Rw3aEZxsQeDmJkQlR7fqJIc=;
        b=CZBzyIPPK/FAu3MuAk4+ymwndfQ22XkSsMQoKww4tbh1h8xIJsRO5SHJU3Lm9AK8n/
         olHMBRoyhaq+pC1E97yVgPuYUSxevy/NLJf0GMpCpiEjHY5XtS7NnJMhBhkd7veZ42XP
         PV3Fbp5fcyFHpKfxRId7ok+BVc6B3JNNNkkVYYxBY/TKBV6XxCCmpWLqTAlgmVboGflM
         WebDmsSKvvuHedIzGTLF2O0uPugZZ7vhSkbu7IDi2E3Mo3TTycsTMEbMt1bg5PlWcK1W
         z6VH4Ze8l+v+L7hzX/l1ODKK3x72bWegkKZwLDGphlN2/fZTjDFOau4WGrwNpymQmTRq
         mnIg==
X-Forwarded-Encrypted: i=1; AJvYcCV/c/ipurTFWtqYIcT4Wx3EjtgxFq8+wUy0bjEeb8YzxGqxes/mlY16KCqcD2XlJ9LcpMb03ST2TtHA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wjRO0AKc8cdCIeG8TVzJg+eoiFAzkui5Zp8ogCxoD6pCYVds
	qP9kB26+cHkLy2FdrbylLo+XVEd+6YUszUAYSuUzCFK/k9XhrwoKe7JA
X-Gm-Gg: AY/fxX5lhvIF948HaCAx+ToWwcwLO/+TeRoVzVz15ydoW5dj6f78+0R+uf66AHHjm5e
	Ka/GUcvjmVQRx/DIP0S1pe2CHe/1GQ16fRarGyB/gzfiOwZ1Za6QMkaqWJfLFeCvLCbqbSyUqBL
	EKw9nT2hkFKZXtFSiYoSV+aki1jpBcRrdddNDanL1/ys0BAXVWZ+DtawBuyc/o8PWYXTYozSNw4
	joQPRmaEbOFWmuhHDidCduuH4pMms8T2v/OavtoDU8c+323zdZor53ptp4mZV0W8XpLwrj4wBSC
	geMsa5wQZkDzfdYOXOX9hCeIEx0wkUcs7G3IjIukx1j2SWiyOZw5BaFZ51tVPludlBqujcQzzTW
	Rdl7vR0Ko1jnSAQsvqmUcwVfnKNMdrIhx54kZ8WHE3RwTCi7/Pf07VtUy6RShSfkXWRpNvpp5aw
	ssRRgOggnP2Hlx+mXmLbUN89tEuvNZia9FBA0HUjFwvEug1wdyhSMM72vfyKKmUPQ6uWg=
X-Google-Smtp-Source: AGHT+IFa7jdipzgdchTyteOBcXw28bMexQC8evBC7LfTv8XSFSYVzX4/9rs9easWyCzzYXX4arjVUA==
X-Received: by 2002:a17:902:f542:b0:2a0:c20e:e4d6 with SMTP id d9443c01a7336-2a2f283de1amr234502165ad.39.1766827041936;
        Sat, 27 Dec 2025 01:17:21 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ce3sm226642125ad.90.2025.12.27.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 01:17:21 -0800 (PST)
Date: Sat, 27 Dec 2025 18:17:17 +0900 (JST)
Message-Id: <20251227.181717.1843883205283099818.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, gary@garyguo.net, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rust: Add i8/i16 atomic xchg helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aU-JcvYaOYznqD-M@tardis-2.local>
References: <20251223124639.7771082d.gary@garyguo.net>
	<20251225.095655.275822477142372376.fujita.tomonori@gmail.com>
	<aU-JcvYaOYznqD-M@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 15:23:30 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Dec 25, 2025 at 09:56:55AM +0900, FUJITA Tomonori wrote:
> [...]
>> >> The architectures supporting Rust, implement atomic xchg families
>> >> using architecture-specific instructions. They work for i8/i16 too so
>> >> the helpers just call them.
>> >> 
>> >> Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).
>> >> 
>> >> Note the architectures that support Rust handle xchg differently:
>> >> 
>> >> - arm64 and riscv support xchg with all the orderings.
>> >> 
>> >> - x86_64 and loongarch support only full-ordering xchg. They calls the
>> >>   full-ordering xchg for any orderings.
>> > 
>> > Maybe it's just that I'm reading this differently, but I think this is a
>> > bit confusing, as if there's an optimisation opportunity.
>> > 
>> > x86 is TSO, so even a relaxed xchg is a full xchg. So in this sense x86
>> > has implemented all orderings.
>> 
>> For x86_64, I agree that the wording is confusing. xchg always implies
>> lock so different memory orderings all map to the same full-ordered
>> xchg there.
>> 
> 
> I feel a bit confusing as well about the need of mentioning the exact
> ordering of these primitives on each arch. In my opinion, as long as
> rust_helper_xchg_X() is mapped to xchg_X() in C, then it's clear that
> they have the ordering of the corresponding C APIs. But I keep it as it
> is for now, I may remove them from the commit logs later after I
> re-think about this.

Given the current implementation, I agree that the ordering
explanation is redundant.

When I started working on this, I initially thought we would need
architecture-specific ifdefs to select the appropriate implementation
for each ordering, rather than having a straightforward per-ordering
mapping like this. That's why I added the explanation about how xchg
is handled on each architecture.


> Thank you all! Applied in rust-sync:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ rust-sync

Thanks a lot!


