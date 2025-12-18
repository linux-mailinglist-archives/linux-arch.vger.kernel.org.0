Return-Path: <linux-arch+bounces-15491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EDDCCB8CF
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 12:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADF55304AB75
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBF83126B7;
	Thu, 18 Dec 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1g4Wd7B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFB2DFF1D
	for <linux-arch@vger.kernel.org>; Thu, 18 Dec 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056128; cv=none; b=RT5o2XHuZvSMLN67MsFMlC+eA0aalWVjYUuBj9quKCTheHx+CNXoTRNuyRUwQfsj4WAYWuycbGBVs6TjnBBZCHn8vr0iGIQ0IEoCez0KbwicYA5ujx9zyVtXka6BavyNa5vxie+qznJfYYx8PwJBwLXBccpMjVnmR2w3Chjy/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056128; c=relaxed/simple;
	bh=5ae4jwThX22GsqQgWrYZpZKKD1C+wqRFa+cbCkUbJkM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Uf+wCV560g6u0BwDfHEI1F6w5T0oN/NwBoJp4PF0iRo/3ra/rFoEcPEgg/ayavCQQ4qn+OsTDVrMi6jq23NYuh4Z1WBje9ANVcSerNlnB27z2P6ww5f4NCQP3+WKcIvrDy4FKTBqkcoH+4GbkDfX9RICKUPCpvpKu+uoxykGA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1g4Wd7B; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so456621b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Dec 2025 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766056125; x=1766660925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvrOODWWF0yZN0kTruhNLT8tt7pIP8wMKuLRwhFsSME=;
        b=C1g4Wd7BARsbkRJe0oAR4w8atQbrErRn+cI/n8mMImNacVG4ZPCfyxJPTsz4kn263/
         1GawtQ9i7Ep7A4QL2mEHbXQYvpZwO1+aZqE32yVyd4TgAyOeTfQj+1yosn/82b41nlUs
         CJrLQUbFRDzGtZ6PIkWOa2ZaKg+rGfawDVWJf7uxvlK7Vdx3T2dVWwaJDnPYP/+suhoK
         3ZoZBOtrXZlEUdMiSAKITWD+K3+dCssxYYETxuA2+NY25oy4O1bB9g43qu9cY8sMMITN
         FM5r+DRZiEVg7GA1T4OVbbtbAJuKDszVemvarwAoWPEU4/fcxm63i/pgqe0ECqDVv0Zr
         bRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766056125; x=1766660925;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvrOODWWF0yZN0kTruhNLT8tt7pIP8wMKuLRwhFsSME=;
        b=h38ENin24sOb25+DD8of5T8f4xno0PiI5Lv51ylnp5GH3vT2GEdNXX00IayHx5wA3G
         XqaFmUvYAFs5iulhkpB9TSD7ckN82O1QVOFuRH3JSEzvtvUwbnMY/1hTxLDKDmBELIha
         kYDOF7i5VIpgP1kW3X/N51Vlthfn3QvSalIDvy3fzqE2Qt323WGG82aqxsBTZ2tPAHrV
         E7S5CUfpqTtScPN0Cc1DJ6qoeyYEeaiP3BQuOsXQ7bxSGZ7pPp83IjlDj7klGKr/CrX0
         iwo2ZwtxC7movvTrQQLz1QNdKCfjCWVbq3oRyfnxr+ObWTlehDAEoDnplKfsgGQ1jYP9
         xB9w==
X-Forwarded-Encrypted: i=1; AJvYcCVVIgGqm+oOsU/cg0K/Tm0ZzJj5Ro0U3aQqiTEycyXC5nsOeQXmBdU4XXfXUE6JmXgY6QDsvaH+eRs9@vger.kernel.org
X-Gm-Message-State: AOJu0YybF+cAc5RhuUk4ZT8U/PNLo76ajPObIzUfe7G0tDBiZ5YMYt2c
	etVquwfCVqBRYJzmRu0s9rv5VSSX7MfLVK/TalkJ2DfC1folOp8jl7qI
X-Gm-Gg: AY/fxX6FQsu6a8jGeXDhjnlM58KWOB9/roEZ9e8tun3Cm8LRfnt3hFDLjuavxhXngGb
	3+guTIs2BNb6aPi75zan7rz+09EtgG6OjSTvzLDnMemiDlxL8wN32I5E6fSBakuQZM7FJEN46Tg
	gyjw/detK7LjdaJpoDaPqhKPDeMUppkrq3lMMyV19k2eLXZ5SJ32FK2omKVZZ1k+GmBeyGXO482
	xsOuYXWGR7gGw7LDoWbPBdUwC+aYDSwpV/sSkKeHPUZ5BqbHLa11dKjbCZV923toF16htq1xCvj
	H9hsk8udUxClo/PtOTEECwaeYf9rr0D5F3tr3+kboykAydbdZ93E8G88gAVuG2n+ORF6tnzSQeI
	Q1aVtc6eQvDtesMNIrLxOd9XP0bKMLbxc6v/HJf2hxWmiJCcRkYCG+02obObUZR1bDN94EK3APC
	pbc9eb4ln4L5LoqwhMkdaiOb21pi8TV3jve5Go9Gd8CQIZi20/F1u1FIP944lzjYY0Zzs=
X-Google-Smtp-Source: AGHT+IGAV2/r1YTG/myMJw8Xx7HTeJ86vOJi7XK0y5urcjohswz9dbr215J8uix2rwoqrzjY/V5ZRA==
X-Received: by 2002:a05:6a20:7343:b0:366:5332:466 with SMTP id adf61e73a8af0-369affec42fmr22254047637.53.1766056124849;
        Thu, 18 Dec 2025 03:08:44 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2dc9dec9sm2029744a12.10.2025.12.18.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:08:44 -0800 (PST)
Date: Thu, 18 Dec 2025 20:08:24 +0900 (JST)
Message-Id: <20251218.200824.2202311883856399078.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, peterz@infradead.org,
 will@kernel.org, acourbot@nvidia.com, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, mark.rutland@arm.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org,
 James.Bottomley@hansenpartnership.com, deller@gmx.de,
 linux-parisc@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com,
 sparclinux@vger.kernel.org, vgupta@kernel.org,
 linux-snps-arc@lists.infradead.org, bcain@kernel.org,
 linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 0/4] rust: Add i8/i16 atomic xchg helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aUPG2Q_sSPDnlQ0G@tardis-2.local>
References: <20251217213742.639812-1-fujita.tomonori@gmail.com>
	<aUPG2Q_sSPDnlQ0G@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 18:18:17 +0900
Boqun Feng <boqun.feng@gmail.com> wrote:

> [Cc parisc, sparc32, arc and hexagon]
> 
> On Thu, Dec 18, 2025 at 06:37:38AM +0900, FUJITA Tomonori wrote:
>> This adds atomic xchg helpers with full, acquire, release, and relaxed
>> orderings in preparation for i8/i16 atomic xchg support.
>> 
>> The architectures supporting Rust, implement atomic xchg families
>> using architecture-specific instructions. So the helpers just call
>> them.
>> 
>> Note that the architectures that support Rust handle xchg differently:
>> 
>> - arm64 and riscv support xchg with all the orderings.
>> 
>> - x86_64 and loongarch support only full-ordering xchg. They calls the
>>   full-ordering xchg for any orderings.
>> 
>> - arm v7 supports only relaxed-odering xchg. It uses __atomic_op_
>>  macros to add barriers properly.
>> 
> 
> Thanks for the work! And please do Cc linux-arch next time when doing
> architecture-related changes. We would get more experts to take a look.

Will do, thanks.

> I think the current implementation expects that xchg() work with normal
> store/load, and that requires ARCH_SUPPORTS_ATOMIC_RMW. So could you add
> a comment saying the current implementation only support
> ARCH_SUPPORTS_ATOMIC_RMW architectures? And when you wire up the rust
> helpers, I think using #[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)] is a good
> idea. This will at least let the !ARCH_SUPPORTS_ATOMIC_RMW archs know
> that something is missing here.

I will add a comment.

ARCH_SUPPORTS_ATOMIC_RMW is required, but we also rely on xchg
supporting i8/i16, which is not currently required on the C side, I
suppose.

As I wrote, at the moment, the architectures that support Rust
(x86_64, armv7, arm64, riscv, and loongarch) satisfy these
requirements, so my plan was to use cfgs in internal.rs to restrict
xchg support to those architectures.


