Return-Path: <linux-arch+bounces-15574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DBCE6A1A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09FF30076B1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7630F539;
	Mon, 29 Dec 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPpD3fWa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB122D6612
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767009999; cv=none; b=A3tkcwC1gdRBThwk7i0d9fjI2qH41czNcYBNGwGbpQZLhdmg0Bl+QMKuBZGVEhxd780+5Z1MuGLBsaxC5FFibdDOb3MWZAQMO5RGWRVSjCdEwHjpGV5wo/i2oiGPGVnlz6Par18gw7qQOroYPUPrThiamV47mr6oUMVGZF/zu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767009999; c=relaxed/simple;
	bh=BKCz/tM6dAZ8GnWpTL63eM2u/w94sOmkPtOgZkz8RIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAIDKOkaweWGwzf8+mai54jDK8wEWHpwPI3kt3+3Pu86nAP45KAcbmJPOGjqf52PLBvVh0UWX+yxknO4UxYh32Wi3xdU1P8uKpfOEhOfmUFm96BGFnXll5N8cRLlCIZ/FHwb+jf8XTWqoCqNtn6MshMxQ+yTH//jQqWDr2BXSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPpD3fWa; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a2ad13c24so87364826d6.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 04:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767009996; x=1767614796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9PuUbuLj1jXE7VFBwncU784YnXmslScQ7DrrmVMmXs=;
        b=kPpD3fWaOVIF6vfVwoX+dJn4/jCAm/hu+ZJ8aiVysic/PfmM1qM0L89JQQcOy685iE
         vKTJjxO9p5FQVe1yHW+U/mdarxwIXKf4xoHrhlH6CJkRvN8eZ2mfm4/LvEveXwaHcK+o
         SP7TZ3aDAqXxeRBCOa956lC4Stxh87OFrG+F5p/Pj4yFqUqgYmoasHDe1dZumWAQA2Xd
         rTK8z62UDErzwGKxlDoW1E1wnK/ZLOWXjwrbxvk1vYRON8h1KYbEtlIj3qgghcjyIcWr
         5JTn15i3pj93R1x2fpOc4gkFVQ97V+NQAO1GWNSQMDHnxDGsIyAa8uF3Rq1AV4LmjkV3
         17Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767009996; x=1767614796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9PuUbuLj1jXE7VFBwncU784YnXmslScQ7DrrmVMmXs=;
        b=QkovYYDQYzJXnjlKI9GKtYwSGXwEtSYr85gPZwY3mGXx0EkE1hOQWqjvTpZE3rgRL1
         SeVv3GBSoYJMGnneoBcQe1MuEpWurWEykOHhtFZQ93uIpeESkWCLWvdRl6UJZSDAWnqO
         NDHRvi6DJv6dX0WSQkNSO5r3dircv2pGHkwm3M2y07N6jakVI7TVMaHDyKLwx7skHFKU
         oOC/lW3Hr/tLqsDqRCAq18CY6h0961j+Z+3hYAS3dB+r0AZHk3HKVMP4H4UF8z5knChb
         QgwO4NvMpdqKbcYGSBmoJ9GnyFcUcwIbhSh53rgBH946BNfvHD9MP2Syk1jhV5mTfnYL
         Mo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3W8e0/7DXUidrc54G4L9k+sSUecu1xNgVPbOKFFTqjpy8scebxCojgV5nKmbMEZAMMwXOqKw3RQNk@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLVNIEcVCjAosNxawxCBgiXLz7GW1rAbOuR8YGI4p+3wipn86
	2zC2eooV8anw8BT+QNuE4Sc8GpmO/JZCG/D3PODQ9/yamKmOakBcr0CC
X-Gm-Gg: AY/fxX5qqwsKDZdVXtoifUT5xRDfrCsRi7WBTSnI6flQeHMYMjfL+hK2emJKFhCRpEM
	mfHYqr4qTBSQghlweei2bKkR7/LS17op+n7oRpUqHSpMPxz+tPGKw8RNmcR05xASQ1Z8OTelq7T
	6B1cLqyBS8GM53C/WOHQslHptKJptwFMko3R7K/6ikAF7OJ05re6zaNsC2aRkK+A/ptV1UvIzMs
	sipFTxVDxM1yGKndUI0VTV2iLKB0G8q/a3fcAL80zQzA5aaC8h0hmvH8X6bT41BcXFN2iaBFzlP
	Xy4jiwm1YSymMUN5iclFk9EQkCqjRgcE6p/WblhWWEDgnT8SsjdQMZ34aqHKSZfMbc67TZlzuGu
	NWSlbwGcOF6C4wDPh5MrsR8Rh6oe2LRSSyG7tah74cx314V1ymqvWPknyCDALS5LDgcSkHrN7IX
	Ud7r4yUHvUQqvBurgTm61O0BALCzGVoaYXlWZ0L7uaEJmS98f/X2SWTKH1LkXlfaURLbd3iATR3
	clNZrbAnUNMGLcSv9JYA4wVUw==
X-Google-Smtp-Source: AGHT+IG5SYKzBrzpsdml5IXoKLLqAoU99MJ3uswMnD2CyluDfI4+jpvuo1q26PqDS5Qff0ha4PIBQw==
X-Received: by 2002:a05:6214:570a:b0:888:4930:7982 with SMTP id 6a1803df08f44-88d8712bd9fmr533365516d6.70.1767009995737;
        Mon, 29 Dec 2025 04:06:35 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96bec097sm224478436d6.16.2025.12.29.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 04:06:35 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id A16F5F40069;
	Mon, 29 Dec 2025 07:06:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Dec 2025 07:06:34 -0500
X-ME-Sender: <xms:ym5SabIHAEi82MPcYM-DRfDAtjANw3RLt4i8VGXOeB9Wq3c--JInQg>
    <xme:ym5SaZM977uR7vaVWTb_QDI8vjsWwrlQ2lVU2j1w5ETcQ2uGYjFKk4NU1xbjil8cO
    EpUnbZWNjJ7zVurmx8J726UlbBDX8gS47CFuXUkBcdtkzRxV7IUNw>
X-ME-Received: <xmr:ym5SaYqVXUF_uxaVa05TMuwobOAYnpUoa2PFiR2O4-HqDLIZYcd_Tedopw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjedutdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ym5SacKKWOo3iovAvRmG4yKzllcziNtEoL4AV-3kv92h0-tiJkKZ1Q>
    <xmx:ym5Saf1T-xjsllyWxur-81IOrawiXbxmWdw3oogzVSHuQjrF17soQQ>
    <xmx:ym5SaVVeKwuwahCI1fnfKccZ0GNdFEBWE-oYzcttDw4qy9XYdaL-sQ>
    <xmx:ym5SaazPE5Xn7F4ts-tutIp2zSm23-WGDJC2bfAN393vL5oIkDEbzg>
    <xmx:ym5SaUx8_v_x3h06PLEQuWjrRpSnvVha6uEuUI99tmSyh5ekht4RpSfw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 07:06:33 -0500 (EST)
Date: Mon, 29 Dec 2025 20:06:25 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, gary@garyguo.net,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/4] rust: helpers: Add i8/i16 atomic try_cmpxchg
 helpers
Message-ID: <aVJuwRCnyF7r5ygF@tardis-2.local>
References: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
 <20251227115951.1424458-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227115951.1424458-2-fujita.tomonori@gmail.com>

On Sat, Dec 27, 2025 at 08:59:48PM +0900, FUJITA Tomonori wrote:
> Add i8/i16 atomic try_cmpxchg helpers that call raw_try_cmpxchg()
> macro implementing atomic try_cmpxchg using architecture-specific
> instructions.
> 
> x86_64 implements try_cmpxchg() with full ordering.
> 
> On other architectures, try_cmpxchg() isn't implemented; so calling
> try_cmpxchg() ends up using cmpxchg() implementation.
> 
> loongarch, arm64, and riscv implement cmpxchg with full ordering.
> 
> arm v7 only supports relaxed-ordering cmpxchg; __atomic_op_fence()
> macro is used to add barriers before and after the relaxed cmpxchg.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

One more thing, we should add this to comments in atomic_ext.c as well:

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 10733bb4a75e..5ef81d2b47cf 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -91,6 +91,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
        return raw_xchg_relaxed(ptr, new);
 }

+/*
+ * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
+ * architecture provding try_cmpxchg() support for i8 and i16.
+ *
+ * The architectures that currently support Rust (x86_64, armv7,
+ * arm64, riscv, and loongarch) satisfy these requirements.
+ */
 __rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 new)
 {
        return raw_try_cmpxchg(ptr, old, new);

I can add it myself if it works for you.

Regards,
Boqun

>  rust/helpers/atomic_ext.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
> index 089f31bc8de8..9d62f659c8d2 100644
> --- a/rust/helpers/atomic_ext.c
> +++ b/rust/helpers/atomic_ext.c
> @@ -90,3 +90,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
>  {
>  	return raw_xchg_relaxed(ptr, new);
>  }
> +
> +__rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 new)
> +{
> +	return raw_try_cmpxchg(ptr, old, new);
> +}
> +
> +__rust_helper bool rust_helper_atomic_i16_try_cmpxchg(s16 *ptr, s16 *old, s16 new)
> +{
> +	return raw_try_cmpxchg(ptr, old, new);
> +}
> -- 
> 2.43.0
> 

