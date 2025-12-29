Return-Path: <linux-arch+bounces-15575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE03CE6AE1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B81AD3011DA8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED230F95F;
	Mon, 29 Dec 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jadn8zAw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9B30F54C
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011234; cv=none; b=e93B/XCphLPxcBnBTKv8FyXX4hfZ4K/lO4AOb8KVZ2rS5/lIL/6DsCKPfvXK5mBBYdlm3u502bBEsqZ1/RRuuwlxAJmTmfyWiPGSDJ1px/KK8day+UIQinkvPO/D6mDljoDnPkg6BGt9WdwfcDsyAa0hbfjR5t6hLFkPNEKaRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011234; c=relaxed/simple;
	bh=s6t7yrU2arAVSH3dbPW8txranCstfOsPfXH8BKTdL7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp+QzMgidVQYFaKbudcZhCOmxbhHr0/srXbDFvrqDAyF1+KTvQ2R3ing6jeTRrLm/mOjtn8n9HZiWzX4/PFS8V7wMbNJEzyO053k0mVMQABKN5L1+MYQb2viJPLxLefFqTrNV8ZbgIR5LJREYUBh6oSpeXTPlrWlRvWLps+Dv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jadn8zAw; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2f2c5ec36so1033671585a.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767011231; x=1767616031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmh9su/ooIZNVK70WmSlaoQTtrbfa3dRAn8PxIujn4A=;
        b=jadn8zAweikZiFNdDF5kVKh6brQClf+pV3RHRJfezyo1BD7drs3XmdOIz2y+R9asJ6
         INdXq5vWg8MKMYNWLsYAcjr6wiSXMo/w8Z3bGKneW69H+OZHGdRiBMimCnCJndkDXSUa
         KHc8uh/ZEND8pZ6F0qPfcdE90RqISHH/Z4vfZnm63DgwrR27DbikmqWCeuQvWxJxpwqt
         oxXcDLfodCe2XCui24o0xh5QyO6BIdrp67V1YhT1162kACPnpLLuUKMEV3iVXCVuDEaS
         Qx9Rq773VJ55aMVmVjonPZXLCrgRBQPh45s3yB0fPDDBxAxGo5lURyvYIRvZWz79miOX
         31jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767011231; x=1767616031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hmh9su/ooIZNVK70WmSlaoQTtrbfa3dRAn8PxIujn4A=;
        b=LpNDv1lg6DpzQZMuqmabIbsYHkZpCHkfKqEK7YHa3vBXgzuCSCJ9vpjLwxWxecoLJO
         qykMvaZh2ovjNVpoQzPPpQxE/CI7Pt+0TqW69+k4F36oHTZCHL8gTY9rAAJSZHFZOEP0
         ZBKlsXL84phrK7XTQagNXS12fb+wxzTWTUe8wLS461AwTU4pNTmzIGOwfip4hznpqYlt
         7WraxjOkYyKxgdsdv2SSJQFNKNLwKWMBcDUYeQB001mz227oeX9o1PaZAiy17EX11ukr
         pjvXUEciKW7aTqdx5Ozt4cLhvLOMnBTnos08CnC1FCdBIUZmAmuYhy97NgPnsMjso7DK
         JHEA==
X-Forwarded-Encrypted: i=1; AJvYcCWN/00unfFiggZ6Tp5N8Dfc2xaXZ+l5Hn7y8SnB9niD/uZ5AxXUbuJ5SE40IWe4C5Eiszq3DftYItlN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlsf8Ju9hDfWTBRoFT4O7oHLGKieT6X18m7Yqqdo05nOyBJGPP
	iqQ3eCtKmPtaKqMn375APL9fqw7xP+EpZACrjeKF4LHs/2ONFTY7ntsK
X-Gm-Gg: AY/fxX4ywYe1lVCbw1WJeDq0G1bTVJoKHoPLJQ0hoTRH+49cXGh95FymyZum+URltEt
	gnsPJWp9rDEOZJnicjk0DSa5F1Xcg/erZi3AxLkjFAsDYyudAIOUFiRFGdBejZV4wfGrstlfcDR
	aBuxve+JFe8oiwoS/OLZRzr3R3v3Q+wDyGtLPEY9FSGSA3BlQtZ+Jwn0kzYMMKg3KjoYV+8l+mq
	8PFKnoQYXFrLBDXCZlh50BBh/7YWi7dAQLQ72FWBjxjFHNv/rTBt6/TMiQffPcUt8uKYxO3/CT9
	NizVHraZEvXQRKGbM9GrYkfooz6gbxcUZ50gzk3yoz3d8VPFIe7aNGEz2Y2cz2H7Q5dcpumD9Ng
	DrEZdo3r1RVET2E6nUzJC9Z6zIcBQtwOaba4M+510Bga8/nUgB/SmjesuCImiS3/23UVyQD0wJv
	fJfhQMWBRxWebM3RVMrgEaG0RouHN5CK6QfTtdf/HIdO9dLVVnABgUIMDQwti4Djhr+6cu3Odnp
	VjqIEBezBXDe+k=
X-Google-Smtp-Source: AGHT+IEjzpTU4WU2uvmhW5+E3116kNojBaFxOOCwkyU2iy1k7w0dvabm+XdEmwxHEHPvzHJYC+glGg==
X-Received: by 2002:a05:620a:440a:b0:89f:1204:504a with SMTP id af79cd13be357-8c08fa9f18emr4494419785a.57.1767011231549;
        Mon, 29 Dec 2025 04:27:11 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fe5sm2390443685a.26.2025.12.29.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 04:27:11 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id AD04DF4006C;
	Mon, 29 Dec 2025 07:27:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Dec 2025 07:27:10 -0500
X-ME-Sender: <xms:nnNSaXBKR3GiuI22FzlxwNSspg40GNcBi_D_9_kjqdxzsa8Z3oKvKQ>
    <xme:nnNSaUDx6GzTycVgn7aTueTm6bOf31SMLs_uBjapFAsq3xmiMd0vlVcudxHHjPZG3
    kH63a8et4UAi42dU09VMrB1uJcOoejNOxzgDC_0SfQFMqk0tcwVqg>
X-ME-Received: <xmr:nnNSaQlD2CdpzfDhdMaHOIuYZU_bSZ1D9SL49rPC48FVze1poOZK8kjOVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtth
    hopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhr
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrg
    hrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:nnNSacjsROsdacj7DjuCxfoGoS-xm0cKOWaPpDHhVkb1uqdBGVjbMw>
    <xmx:nnNSaShkYkvvngsDZKl7-71yzgeQBI_sBCdL8K88T9yh_UzHn6c6XA>
    <xmx:nnNSaWuIhiFKrpHEBfwH5Ej8GLpGSfMAKosrdlRCpqNx8BBobzKtPw>
    <xmx:nnNSaSuF83hjc44NDmIaatDwgVWBOTiPKWi4THxQQAoaQJeS6Zj7UQ>
    <xmx:nnNSacqceIdSA2gnNhNNKCJ9936BVTggTLC2oZTw8dcrv74rQsUebIAq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 07:27:09 -0500 (EST)
Date: Mon, 29 Dec 2025 20:27:01 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, gary@garyguo.net,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 3/3] rust: sync: atomic: Add i8/i16 xchg and cmpxchg
 support
Message-ID: <aVJzlTWx4ybMi1ym@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
 <20251228120546.1602275-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228120546.1602275-4-fujita.tomonori@gmail.com>

On Sun, Dec 28, 2025 at 09:05:46PM +0900, FUJITA Tomonori wrote:
> Add atomic xchg and cmpxchg operation support for i8 and i16 types
> with tests.
> 

I think we also needs the following, otherwise architectures may
accidentally enable Rust but don't have the correct atomic
implementation for i8 and i16.

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 248d26555ccf..a4e5bbd45eb2 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -5,14 +5,22 @@
 use crate::static_assert;
 use core::mem::{align_of, size_of};

+// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
+// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
+//
 // SAFETY: `i8` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
+#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
 unsafe impl super::AtomicType for i8 {
     type Repr = i8;
 }

+// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
+// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
+//
 // SAFETY: `i16` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
+#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
 unsafe impl super::AtomicType for i16 {
     type Repr = i16;
 }

I can fold it into your patch if that works.

Regards,
Boqun

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/sync/atomic/internal.rs  | 2 +-
>  rust/kernel/sync/atomic/predefine.rs | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> index 1b2a7933bc14..55a80e22a7a0 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -274,7 +274,7 @@ fn set[release](a: &AtomicRepr<Self>, v: Self) {
>  );
>  
>  declare_and_impl_atomic_methods!(
> -    [ i32 => atomic, i64 => atomic64 ]
> +    [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
>      /// Exchange and compare-and-exchange atomic operations
>      pub trait AtomicExchangeOps {
>          /// Atomic exchange.
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> index 51e9df0cf56e..248d26555ccf 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -149,7 +149,7 @@ fn atomic_acquire_release_tests() {
>  
>      #[test]
>      fn atomic_xchg_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
> +        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
>              let x = Atomic::new(v);
>  
>              let old = v;
> @@ -162,7 +162,7 @@ fn atomic_xchg_tests() {
>  
>      #[test]
>      fn atomic_cmpxchg_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
> +        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
>              let x = Atomic::new(v);
>  
>              let old = v;
> -- 
> 2.43.0
> 

