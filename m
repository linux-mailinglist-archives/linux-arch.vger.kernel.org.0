Return-Path: <linux-arch+bounces-6528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AE895B70B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04853282A3C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358D1CB31D;
	Thu, 22 Aug 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN3G4Z1l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCC1CB30A;
	Thu, 22 Aug 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334200; cv=none; b=nVVcxF6h7uC+cXJfsNlD+2HFMxU3dD+S27EYJh8ggZfw5RcVkdFFeY0/2831W7/LkWOs/lpPSCF84aQZFCeCnNWcqy+aaBG9D69Wvcd+eNpy1YGBC8wh7lbeeaucFlBMfbfGxsytJA8t/Sh185UK3AMOp0z2cunOwbI2/p0AK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334200; c=relaxed/simple;
	bh=sQvd+bwcFWTX/oc4OS7Btb+0j0aSoPqVXbUm0Nn6uig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgCjAgd797Zg371aOwN+GkkFdzg/Jcb+CcdvAvuE1ToBkQJuHNE4lEp0UKqKnjeW8BPmvyi3ImQRKAPbpEnlVJYQScG/EE2xuHDPYgspKAyt/7f+qd9zTt3VxlUw63u+py4oqopEZFt1SU+3+HoGw64B9MrTmbKEYf7gfOb3AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN3G4Z1l; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so6016046d6.0;
        Thu, 22 Aug 2024 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724334198; x=1724938998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdl67ic8HgEb8M4S4PfeCh58b8P52iTtl7Cnr2VuH+w=;
        b=nN3G4Z1l2MI2LwwgHLuNKrlrTpdsrqv1x5+JKLN9zOLnDoKlcFOaQXkmNgP1TAvC9Y
         P+IKn4mSsF4tdwL2xmNCm2fuc2Y/wlLlgLFzjpTa23uxWqL4qyW4/X3G0A0KvJLYoM0Y
         cugnvkj2IHGK/CPx1F5aewJoJybauZTi+092YuXLJIXVFscy9MWCdG7YVhjzWl/OF/Vg
         VTwuK+VpspkYNU1RAz9rrQRqLjzgd3WcCfWxe7mudaSRFHb4VCgwT7/EU6Td15miBMSe
         HG+Junl4a0efOdBSyxceURi5JjK+uRqxGATrPL0jaHTsE7e5BDvxUP9BQ7q9neS0IVxz
         /9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334198; x=1724938998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdl67ic8HgEb8M4S4PfeCh58b8P52iTtl7Cnr2VuH+w=;
        b=YHOKH/lwcaIbX7Eb+ZkTahGJS5FhNN/Bx1Lwa+xzLQcxTm5jRvs7Gt7uQjI14lYs12
         oWIlz8bIYMgs6kVtTwthGSFXkjnMzQXatnCz4JnW8KmZDLnZwLj60+t5Yb3UkA37n7wd
         0imLzObKUhdylxVVttP0hJMj9SkYViUBj1iiQQ9TfDGRhHZMCpoJqpocyxzHbI0uQOj+
         YqSzxIeXWIoKGI15OotQwRfFFE+q0kS+iDte4wZ74uGgR3M2Jrgd2lzUYmJA9nGrVXEX
         m1aekhr580wRjoJbIy4Re8s+KIZymjmH0GalXX4KYfMHki92HBWgHaM1jJKLAJfnHaWP
         l9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBSrGrvr/Dg+LSnm9HKoc87zW+DCxSRleEgFTzvn1RqtuK+88pEQkpGmG1c5aaDXUOfj2lE+mZHwcYZ6d9s3T3R3T8@vger.kernel.org, AJvYcCW0/oDfkY8CRAWwAZApHir4G8PTY2qyc/ruiLHiy51Bow6WzQkdffHAEAtlnYA+O8IavZd1Vkrz3QFi@vger.kernel.org, AJvYcCXwJXz67eQyKOO1sGKs+O4FBAlknGVZxtn5cH5yaQRke6AJ0KOL8ujF9z2GwNsnBBoXwdKRhwG9ddKV2vg/@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtwG2/44muVmEkNp0looG+j6WF/jsqTEs/x0A/G/BSGlElcgg
	VulPxB8Mf5R/VLg+8GSIWgHbsxy/cx+GGOZXcyaPrjPgLMW8be6D
X-Google-Smtp-Source: AGHT+IHPd/emMpe/HlyJz5A8zoG1MQ2R+I3aFfYWd3NjI3tG1Nm/rfs1sEJSU53wBMynWLouK7H2HQ==
X-Received: by 2002:a05:6214:4613:b0:6bf:6b6e:95b3 with SMTP id 6a1803df08f44-6c160c44047mr68047206d6.1.1724334197887;
        Thu, 22 Aug 2024 06:43:17 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d242sm7731876d6.16.2024.08.22.06.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:43:17 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 16C45120006B;
	Thu, 22 Aug 2024 09:43:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 09:43:16 -0400
X-ME-Sender: <xms:dEDHZs-Uu1QrKkiY-oVdLHzWtxqROV2farUj6grkkH4X-fGNWEAUxA>
    <xme:dEDHZktyWpS3ITVw6h89oq81ca9j_3hKKZ_Vq14gZuz-jFubxeBlEOVXSn6gAJ8q3
    ao4D5FFAR4YzSj7jw>
X-ME-Received: <xmr:dEDHZiBktsutJsHa1EDcwS_U3aKQBNlH10nc5Qeqfbb17_kgryGFLlZxeRIwsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeehfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgdrhhhinhgu
    sghorhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheprghjohhnvghssehvvghnth
    grnhgrmhhitghrohdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdp
    rhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoh
    eprghprghtvghlsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopegrrhgu
    sgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dEDHZsfNAO2KfbEz1kaXZ_nbhnDePpyUV1gRLFjtHVlMaNflg6iZJg>
    <xmx:dEDHZhMs8CPRen4V_NIyCqBFPKnZ4_sN9UCLAWbcQFrM1oVZaahJVg>
    <xmx:dEDHZmlyRrHJ8PnL-3vgbYRcqbaNA4U5IsLMGLpi571JC6kYee4bJA>
    <xmx:dEDHZjueMr_6ePqPIv3LdRePtsn5wEwdSWWYW5z6pFHU6oxEuMb_5g>
    <xmx:dEDHZvsty_NFU9voKfT8TVM2to8A7PqU9JWozXcbc_HkfyMAjmPlXZ-3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 09:43:15 -0400 (EDT)
Date: Thu, 22 Aug 2024 06:43:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, ajones@ventanamicro.com,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,	alexghiti@rivosinc.com,
 aou@eecs.berkeley.edu,	apatel@ventanamicro.com, ardb@kernel.org,
 arnd@arndb.de,	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
 bp@alien8.de,	catalin.marinas@arm.com, chenhuacai@kernel.org,
	conor.dooley@microchip.com, dave.hansen@linux.intel.com,
	gary@garyguo.net, hpa@zytor.com, jbaron@akamai.com,	jpoimboe@kernel.org,
 kernel@xen0n.name, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, maobibo@loongson.cn,	mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com,	maz@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com,	ojeda@kernel.org, oliver.upton@linux.dev,
 palmer@dabbelt.com,	paul.walmsley@sifive.com, peterz@infradead.org,
 rostedt@goodmis.org,	rust-for-linux@vger.kernel.org,
 ryan.roberts@arm.com,	samuel.holland@sifive.com, seanjc@google.com,
 tabba@google.com,	tglx@linutronix.de, ubizjak@gmail.com,
 wedsonaf@gmail.com,	will@kernel.org, x86@kernel.org,
 yangtiezhu@loongson.cn,	zhaotianrui@loongson.cn
Subject: Re: [PATCH v8 1/5 alt] rust: add generic static_key_false
Message-ID: <ZsdAawBhPXojpDA1@boqun-archlinux>
References: <20240822-tracepoint-v8-1-f0c5899e6fd3@google.com>
 <20240822-tracepoint-v8-1b-f0c5899e6fd3@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-tracepoint-v8-1b-f0c5899e6fd3@google.com>

On Thu, Aug 22, 2024 at 12:08:07PM +0000, Alice Ryhl wrote:
> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
> 
> This patch only provides a generic implementation without code patching
> (matching the one used when CONFIG_JUMP_LABEL is disabled). Later
> patches add support for inline asm implementations that use runtime
> patching.
> 
> When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
> function, so a Rust helper is defined for `static_key_count` in this
> case. If Rust is compiled with LTO, this call should get inlined. The
> helper can be eliminated once we have the necessary inline asm to make
> atomic operations from Rust.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> This is an alternate version of patch 1 that resolves the conflict with
> https://lore.kernel.org/all/20240725183325.122827-7-ojeda@kernel.org/
> 
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/tracepoint.c       | 18 ++++++++++++++++++
>  rust/kernel/jump_label.rs       | 29 +++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  5 files changed, 50 insertions(+)
>  create mode 100644 rust/helpers/tracepoint.c
>  create mode 100644 rust/kernel/jump_label.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..e0846e7e93e6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -14,6 +14,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/firmware.h>
>  #include <linux/jiffies.h>
> +#include <linux/jump_label.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 173533616c91..5b17839de43a 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -20,6 +20,7 @@
>  #include "slab.c"
>  #include "spinlock.c"
>  #include "task.c"
> +#include "tracepoint.c"
>  #include "uaccess.c"
>  #include "wait.c"
>  #include "workqueue.c"
> diff --git a/rust/helpers/tracepoint.c b/rust/helpers/tracepoint.c
> new file mode 100644
> index 000000000000..02aafb2b226f
> --- /dev/null
> +++ b/rust/helpers/tracepoint.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Helpers for tracepoints. At the moment, helpers are only needed when
> + * CONFIG_JUMP_LABEL is disabled, as `static_key_count` is only marked inline
> + * in that case.
> + *
> + * Copyright (C) 2024 Google LLC.
> + */
> +
> +#include <linux/jump_label.h>
> +
> +#ifndef CONFIG_JUMP_LABEL
> +int rust_helper_static_key_count(struct static_key *key)
> +{
> +	return static_key_count(key);
> +}
> +#endif
> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> new file mode 100644
> index 000000000000..011e1fc1d19a
> --- /dev/null
> +++ b/rust/kernel/jump_label.rs
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for static keys.
> +//!
> +//! C header: [`include/linux/jump_label.h`](srctree/include/linux/jump_label.h).
> +
> +/// Branch based on a static key.
> +///
> +/// Takes three arguments:
> +///
> +/// * `key` - the path to the static variable containing the `static_key`.
> +/// * `keytyp` - the type of `key`.
> +/// * `field` - the name of the field of `key` that contains the `static_key`.
> +///
> +/// # Safety
> +///
> +/// The macro must be used with a real static key defined by C.
> +#[macro_export]
> +macro_rules! static_key_false {
> +    ($key:path, $keytyp:ty, $field:ident) => {{
> +        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
> +        let _key: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*_key).$field);
> +
> +        $crate::bindings::static_key_count(_key.cast_mut()) > 0
> +    }};
> +}
> +pub use static_key_false;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 274bdc1b0a82..91af9f75d121 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  #[cfg(CONFIG_NET)]
> -- 
> 2.46.0.184.g6999bdac58-goog
> 

