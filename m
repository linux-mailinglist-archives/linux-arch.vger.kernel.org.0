Return-Path: <linux-arch+bounces-6442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE75795A495
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A070C1C20980
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB511B2EF9;
	Wed, 21 Aug 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyMZ/Iai"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BF14C5AE;
	Wed, 21 Aug 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264203; cv=none; b=nsXEBrj+FDeosk3DhhwkQoHNN+9TLXLcKgN0YMd2rZyK77tVH8iQTb8Ws6goFOU9J43fnGW5W9dEJ/1SdhwHa2XxQa9UKxLxbTJCXMYvyyIHH/IWW1ImppN6qlvjIzBtvbolaTw1EI++0mHJ8xBfsKE6/t8ICe7OTCUiMWXy7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264203; c=relaxed/simple;
	bh=JnxeSLPQhSwfoYfEPIBCpVy3r4CFvAx9fVu3+4VZyrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfk+5SQ4GRgMGdUB0u5+rV93CTJ/hVqlsm5+ajd68cpQW0ejN9M3rlFnOoCjRpT5babxVL0ob2j6CxrQroFpUFu2qV1QKbgXoa6LaGyzY0zkVchAZiBWSUoPr3pAL3TzAzarTgN6HfwJcP7BUMyMCR/TlFLO2R/ysm+jZDlgwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyMZ/Iai; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44ff6f3c427so134681cf.1;
        Wed, 21 Aug 2024 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724264201; x=1724869001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sG1wp5ENtjpkC5FIqQpPJO0RYHtQ0kKqwcDpDZ1g0uo=;
        b=UyMZ/IailQrM4Uz7POhp/pMWLwfIkg5IduP0yga9pCLK6ntmYb+0GrQgbe8j+6Kzml
         83EF1Pht9b0581+xBSdnM+XSs4SABPicozves9FQCmquwuTuboGjxlmMxaNQKv209RCf
         hyIfmHWzrdlOQ7mhwIy0AGK7AJ9Qyq/gWzJSW2yZJSxzPum0+rjvtyvqxtiZWBUdKnmt
         HAWgYRnHWhzGghnh0x2Cy8xPISgPAckgKkdA3S0dhckoWsZdNbHcAitQBoEOnGzJIiZC
         9W5blbSuDL8pyIj67r0FIcaMKL8wNeXZTnWtlS3Nu8tR2Sg3/IGxYyaNtARuwLtBAaMq
         ARbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264201; x=1724869001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG1wp5ENtjpkC5FIqQpPJO0RYHtQ0kKqwcDpDZ1g0uo=;
        b=HekTuJCUSGAnroEOxwME2RhKze+pfa5uZb9cWFH0i37SuML3EDMLdfVW9A6r7sHUsE
         oAomG1n6OMh3Ui2mH4KN0VVMgAynnlFqd5ujLHMFDUWsH8fky5uMKWKmiLyR5xeE1vJr
         f6BdDpA+h9sAzXRMLiWQkbML9NfXtWLSe1FQhHT4YVOXERBtfrkAHQeIDCkd6e+tENxD
         etVMiPW/I3hCaqN9PmQcl1O1OZj7BZX/o/pI6wPJEf8kVhylJMBPdlJIgeoEbMHNp5jr
         iN8DNmNB7kuw899horJ13NYIwIU/D6rmj8oSHlet/c2t9R6s1m3IntdDgvk2TqBwXss9
         5GXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2FqyDu4DZwdKHK5ppvUa5sblLx2BXHUaSEz8+s9s54dDKt0Ombb6+WjKxbvhirvEJZbUFUMTGekdSDNd5@vger.kernel.org, AJvYcCXAdav1JQx5SHn4JL3YwA61mSK2YkNdioaPiqAx+XG25GCc0UMnZp5OlmBR03TuI+Nza6MYAIciF5GN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42xm6540K3cY9b5ZN5HzZjACGVe9GFQ5B/K1pBRi6KtUOOIpw
	DP1A2JH/iloK8OcQQ3ZjEQIABWjvBj0/q/GmdCpcs8YbkClzz59+
X-Google-Smtp-Source: AGHT+IEmIudWwUZSOHrAG/eup+YcE8K3ibS5ReEgFCUmkDy3yMOQddDLaWBfo/D6lfVEz1iolaNsRQ==
X-Received: by 2002:a05:622a:4c87:b0:447:e542:ab00 with SMTP id d75a77b69052e-454f2572a5bmr39175031cf.50.1724264201152;
        Wed, 21 Aug 2024 11:16:41 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff5348sm61597621cf.32.2024.08.21.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:16:41 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D2D001200068;
	Wed, 21 Aug 2024 14:16:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 14:16:38 -0400
X-ME-Sender: <xms:Bi_GZjkYOU0_uPVPB7K8kPU5t6uwe1a7iRrD-8l2b4FwhEEHvPWNqA>
    <xme:Bi_GZm2ilDewDM48ADFZyAyLkN8ETYp8o2kgHXVk2M3oH1XV2KSY8l8XSHpaXSdPi
    vUWJDJ9vpJCTKTtBQ>
X-ME-Received: <xmr:Bi_GZppuE27zSpGhNm_MKiRYFzIueXaa6Olt3HDwdTYkHLAy97t7mvl_E4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnh
    guohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrgh
    dprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpth
    htohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhpohhi
    mhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrg
    hirdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Bi_GZrnffxrLWDEUyOfAuK4X7MxRHl41DuNXEXwU9qN7EOxG4IC8rw>
    <xmx:Bi_GZh08QhTMZZDvPplmdtt8yUAyIg0RVUC7Hs34ECG-0ApoLpa8Lw>
    <xmx:Bi_GZqtC2DOqemnStVjIsc28f6yLb0riAR4qzKHtDsMZ3qIXiCyfOg>
    <xmx:Bi_GZlWWO5FFsKpoIG5v09YA8ZfPbtyqcLKXJfL7WsrB9b0kzX0aXg>
    <xmx:Bi_GZg0tfLSerjrQuTHq9tMZrxOF1nPbYUVoJWR9XLUkCH6bFCPKKA61>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 14:16:38 -0400 (EDT)
Date: Wed, 21 Aug 2024 11:16:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Jason Baron <jbaron@akamai.com>,
 Ard Biesheuvel <ardb@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>,	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,	Ryan Roberts <ryan.roberts@arm.com>,
 Fuad Tabba <tabba@google.com>,	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v7 5/5] rust: add arch_static_branch
Message-ID: <ZsYvAJbGB8qUcjXA@boqun-archlinux>
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
 <20240816-tracepoint-v7-5-d609b916b819@google.com>
 <ZsYfAFrBFVewchGM@boqun-archlinux>
 <CANiq72np8GhZ4V22b7RekvQOhCbM67A-19Px2aVLgweC4Qxebg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72np8GhZ4V22b7RekvQOhCbM67A-19Px2aVLgweC4Qxebg@mail.gmail.com>

On Wed, Aug 21, 2024 at 07:54:51PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 21, 2024 at 7:08 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Have you try this with "make O=<dir>"? I hit the following issue, but I
> > am rebasing on rust-dev, so I might miss something:
> >
> >         error: couldn't read ../rust/kernel/arch_static_branch_asm.rs: No such file or directory (os error 2)
> >           --> ../rust/kernel/jump_label.rs:39:17
> >            |
> >         39 | const _: &str = include!("arch_static_branch_asm.rs");
> >            |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >            |
> >            = note: this error originates in the macro `include` (in Nightly builds, run with -Z macro-backtrace for more info)
> >
> >         error: aborting due to 1 previous error
> 
> Yeah, we should use a `*TREE` everywhere. In addition, we should not
> use `SRCTREE` but `OBJTREE`. It is my fault, this comes from my
> prototype I gave Alice.
> 
> Please see the attached diff.
> 

Yes, this fix works, thanks!

Regards,
Boqun

> Cheers,
> Miguel

> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> index 7757e4f8e85e..ccfd20589c21 100644
> --- a/rust/kernel/jump_label.rs
> +++ b/rust/kernel/jump_label.rs
> @@ -36,7 +36,7 @@ macro_rules! static_key_false {
> 
>  /// Assert that the assembly block evaluates to a string literal.
>  #[cfg(CONFIG_JUMP_LABEL)]
> -const _: &str = include!("arch_static_branch_asm.rs");
> +const _: &str = include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> 
>  #[macro_export]
>  #[doc(hidden)]
> @@ -45,7 +45,7 @@ macro_rules! static_key_false {
>  macro_rules! arch_static_branch {
>      ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
>          $crate::asm!(
> -            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
>              l_yes = label {
>                  break 'my_label true;
>              },
> @@ -65,7 +65,7 @@ macro_rules! arch_static_branch {
>  macro_rules! arch_static_branch {
>      ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
>          $crate::asm!(
> -            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
>              l_yes = label {
>                  break 'my_label true;
>              },
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 4f0f6b13ebd7..746cce80545f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -269,7 +269,7 @@ rust_allowed_features := asm_const,asm_goto,new_uninit
>  # current working directory, which may be not accessible in the out-of-tree
>  # modules case.
>  rust_common_cmd = \
> -	SRCTREE=$(abspath $(srctree)) \
> +	OBJTREE=$(abspath $(objtree)) \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
>  	-Zallow-features=$(rust_allowed_features) \
>  	-Zcrate-attr=no_std \


