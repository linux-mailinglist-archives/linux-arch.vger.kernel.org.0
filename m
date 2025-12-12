Return-Path: <linux-arch+bounces-15384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FCCB9926
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06D77300B905
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB6308F3A;
	Fri, 12 Dec 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FSKlyM7e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F43090C0
	for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564402; cv=none; b=BdeBOvgr4rvBJ3MW+qtRyEAo5VKbauViHso3gnUe4WZoRdkWgXj3CsNOAGlJ3IQNFmwwpq6sbyuLkuTGLTxRowZILKjNTKIHwH+kFv6IqqEWFQ/oxhKeAbzKM2dIeslVie+KWsXzv+Dv6G1zxV0V9iu6fE0wfXlhS1FZO2dnlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564402; c=relaxed/simple;
	bh=v8LGo5rep+oNiHljlHrcb1/qPP3q5ouQwFXofTc8V8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5OV3HX6GcT18rc1LjbGocWHLmw3GVfIfG3qgoziCJAD2LFaenu7Jv/E0XZtuUFUUoAMYTHhATZAPCQtCTdl56voGHHMTValkDkZuYO+UuzUB+++5EOEZAMpBIsI06G+x9avlfjLL7KG/OWk5bGZjuDAluN1+gXoRbrNfCPyqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FSKlyM7e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2984dfae0acso27883835ad.0
        for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1765564401; x=1766169201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUSGmEJqTzYByGnUlGU1GkRTgZG6xNYZQ+XlXEoFmO0=;
        b=FSKlyM7eSovvmr5cj3Hu93OFhDLQSJZWqkQ3xqj/yrR8BnMb4QZW8ArYGL+QIEeDLa
         meBncfDWtcrvqRkgIYrSzSAnW4JcmFxZnuuCZuysf2HN5I63zIFyy5mUQGIPsJ7qOcjM
         5Oi1AFHY8QS+1yGNUzFcR1k0oXNA1hjSu3RbCdG6d0XHg1Z7LYCWmB+fCWDA10KVMyzF
         JvTS5XbYQZ8qdZEu4mQqoo6mBGvuKZ/M6eWiCRd8h5xG/mDVZMyvJ+wRF1LAkmnqq3xI
         GCoFNKwjXxXdqUgutKTzFoBpsK3oDgdyriyYdIa2dTmqMucgVcvy2qeySSy/xL2EsNJ4
         kGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765564401; x=1766169201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUSGmEJqTzYByGnUlGU1GkRTgZG6xNYZQ+XlXEoFmO0=;
        b=Y+sBb0P2fsMIJvSgc4932SkGQrd0G6RpX2IX3FuaS3TJgCHqQyzSfRoQbOFCL6ZL8V
         mLg+uL46klZd51jkJCYgYyfGgRHdTdc3JQvMsEDR72PrnM7/Spgd80LRWtuOMRXQceSS
         W59TS098hbwm0vVWZWYaJcFDi5b1BO1IdYO7o0B1ktEuO3eVLtrqKX67ImAhE2sCXwl3
         YDzD5RMDHPfNtxJHVTuhuOdWqqg23+RyGIzBkAW0bM41nIH1ey8d+7iwYTcGARS/C49t
         6iElzqJMLOkxc06b1Ex9KDsVyVVU6Ogzh/oJIA8UZpHZzQ8MzwkkxZF/fHopc/iPB9qM
         Z0HA==
X-Forwarded-Encrypted: i=1; AJvYcCU2UYi93L9Ejdqdo+DNisbulIR/+iuFcvMbYmQUEKiwEU5HZ/3JVyDbQRnqLfo8e+GGzBRgqZM302Yu@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUiEdPqQGOmq5IOLDXfF05MLOQ9Mbk3WJYp+TprJg7OVH7jPV
	X7dEsR/o15mm6Riaj+dO62Z3TuvjrweSyZl76cUmVLalJUom5T73rstRi5oeMh4JtNw=
X-Gm-Gg: AY/fxX5TluzePXh2Abd/6oUQvBejAaQkA/Yendme2OtDreHqrbUhLjVxNihT2dj9bAI
	TZ2ZUHcmEsmqSF9iGfQ/+WwgXlGtgciHzb+voJQ14X55bpY6P/pGMujtyn1Gi2ZSqxFJgmQM3CM
	B3AEKimP0uauSR7tOVTcARHNh9HBUBfQ4PnqQntxBiKlBoAYvXK0HVE+akDq/l9JS+WKhYU/s4y
	ionqlAmKUuaqpl+T0sdBhBtuCErJQrCbC9jOn0rIN3TIDGRsrmnRaxzvH7FOIzBUwpikVykFwHs
	av60FSvMAlEeK4HwqUTimzgE3DRJhXgx5sMu9JcECl8/YSsNLdBMODImSW0wrar5WWf+sHrG5o7
	fDZiqqKGMD57xf7fibS5mZQZ+3fZ1OhzXrnRAgEaKLWU1nvnT2j8gVllVdexEjaN9BLQLPGUABu
	nlRcOl/AIhNW5AFsF+iN34
X-Google-Smtp-Source: AGHT+IFtnl41QfJeu3IJ/uV+L4EiFBX8zP0ux5EampS/J9pJIP4sBjIMESLAF9z1UPcxbBQKr8xzaw==
X-Received: by 2002:a17:903:22cc:b0:29f:2456:8cde with SMTP id d9443c01a7336-29f245690bdmr29337135ad.4.1765564400511;
        Fri, 12 Dec 2025 10:33:20 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea04b7bdsm59970265ad.85.2025.12.12.10.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:33:20 -0800 (PST)
Date: Fri, 12 Dec 2025 10:33:16 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Paul Walmsley <pjw@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
Message-ID: <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org>

On Fri, Dec 12, 2025 at 01:30:29AM -0700, Paul Walmsley wrote:
>On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
>
>> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow stack
>> on MMU). Used b4 to pick tags, apparantly it messed up some tag picks. Fixing it
>
>Deepak: I'm now (at least) the third person to tell you to stop resending
>this entire series over and over again.

To be very honest I also feel very bad doing and DOSing the lists. Sorry to you
and everyone else.

But I have been sitting on this patch series for last 3-4 merge windows with
patches being exactly same/similar. So I have been a little more than desperate
to get it in.

I really haven't had any meaningful feedback on patch series except stalling
just before each merge window for reasons which really shouldn't stall its
merge. Sure that's the nature of open source development and it's maintainer's
call at the end of the day. And I am new to this. I'll improve.

>
>First, a modified version of the CFI v23 series was ALREADY SITTING IN
>LINUX-NEXT.  So there's no reason you should be resending the entire
>series, UNLESS your intention for me is to drop the entire existing series
>and wait for another merge window.
>
>Second: when someone asks you questions about an individual patch, and you
>want to answer those questions, it's NOT GOOD for you to resend the entire
>28 series as the response!  You are DDOSing a bunch of lists and E-mail
>inboxes.  Just answer the question in a single E-mail.  If you want to
>update a single patch, just send that one patch.

Noted. I wasn't sure about it. I'll explicitly ask next time if you want me to
send another one.

>
>If you don't start paying attention to these rules then people are going
>to start ignoring you -- at best! -- and it's going to give the entire
>community a bad reputation.

Even before this, this patch series has been ignored largely. I don't know
how to get attention. All I wanted was either feedback or get it in. And as I
said I've been desparate to get it in. Also as I said, I'll improve.

>
>Please acknowledge that you understand this,

ACKed.

>
>
>- Paul

