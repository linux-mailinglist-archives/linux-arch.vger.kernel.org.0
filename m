Return-Path: <linux-arch+bounces-15643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5229CEFD86
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 10:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82DD0300A980
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A7299AAA;
	Sat,  3 Jan 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF76AE3h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0323C465
	for <linux-arch@vger.kernel.org>; Sat,  3 Jan 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433139; cv=none; b=t6alxcFW0PY6CQx7YAXLIOLL+W0JtCX4b8WFe1J0+jW1RIF/Xf/51AvTdnE/ULuJ1kbiDY3LUq2DN/s6cYVMSIGcX//W41lZ0R+c0yOhez59m4xUiQlj2CxncplV7Vekhi++e27nSThfGMP+mYc+4Q44M0OCy8iwBNUTWPwophQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433139; c=relaxed/simple;
	bh=Dtt4aJ26HXwBmhMnWkq0hwyR+YEk0yHCIxEHQdowN+E=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yqd7L6aO81nqyZUk9pKkAhzhc7jRpuT3h4vSXk5eM/oLf3crd2DUZVraM81M974EZsV08k/1FTgvrUhYrk6xobDW0saVpB7xnr7AzXOfOZpPaELXB6arem1Pd9OTNaVsZag4otiCC5KmLGrOS5iXosaIYqpAc2NFvYN8z8/i7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF76AE3h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0a95200e8so107374805ad.0
        for <linux-arch@vger.kernel.org>; Sat, 03 Jan 2026 01:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767433137; x=1768037937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnEzSME5ZEreqaDKGDnfwcRFUr116aaSg6xWn/3qmRk=;
        b=nF76AE3h/AIs2eKzrLwoog0WVqcwbUFPJd+V0CcvuEHxGxW3VNOPwMrMMPy6U1SYN/
         QiZ2ztHwr1CGBtikIG1Hc9oyZQRVpUmwc8ZF9WVW95pVkVlnebNvP3ayeFmcHT2mHqHR
         0nw1fPrrYbxCmBkDR5xjcyDn8GNSRuhGcK1M8Z6P6x4+olMwnd2z76WUYYK9YhwwwbLm
         LNUvv+jF6TswZRG9DgaFQ+bbuT3eWf1KsqlWU3L97qHmWj2lg5QA9WguykHSWELSVmv5
         ES8GZ6k7XVcUn/lFxHsYLQv6QExBd0Kg2r6eol0ZZ7vtfQtOOgB/Fd6EKISWQzGkPpIr
         SFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767433137; x=1768037937;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnEzSME5ZEreqaDKGDnfwcRFUr116aaSg6xWn/3qmRk=;
        b=iE/Loeq7JdDAxiXyHi+MKsc+Ci5h4Sj4q5G5a12ZyqmBsCfR3lnRwOayF/ztrYvLH2
         ghWS4SJ8ACKU56Z6/Kn1BWSpKCF93CkVj/CXZI+rBJobGXHkHMS9Ihe0YfddCSOWMLjm
         8SP4m1cMKngh+HZOU4y7Y26x7HQ9EMhDUnIXSruo1esy3iZ3D3vWyRXtU27PkslfLr5x
         sB9K6hb5Ltwt92ruSOh1ExO5pFK6PjV5oDl4BPshcNqGgmgXHGU4t25P1dQRUbhQ3mLV
         veFdJJOwPFzZgNtk/gFUh4gj2i4BVo3/Ww86IkKN0r2EMCk6S5UmyXy6utPWQvYtHySA
         N3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVw/QKGDJv4+/dt5t+9/6DY1TUI4JRv6KEe4l0z+XgwXjd5pyK234R+vx1YbKeuhis2B34yRsbKkEUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCGoWdkJvbJWJ87hI4MdILzquBbv6XIZq6EttKMXyKejW1wkz
	hDUSjMxhZ8r68Z/5l44EfKfqGQDB8DpcJRLn26Uu1FsafKv7DE0jBdPj
X-Gm-Gg: AY/fxX6CQeLPbork9RGpmqzMywlKg1Wa1uPjcpYKJWKIfMqrg7IfceVynb858Hkz/Z0
	hQJ/nnaJG361tMh2CS4gA1Pbdc5nOWjbSPJBQZ63CseVcJh9Xj+y0cnzrqG6hZqDoaKFsxvL5vc
	X7YKIZdkWEHphfrkigYSKPiwoCIly+QJK+fKLnS7I93qVSY8wbqD7it2TiCKHJzgiTyGxe/g4nf
	HXHkKr92xzLkcnV7Mci8f0yUT/sw/95flDnsnCtGQIZFoexs9/B4U7Xkx9QE9CZvwoJRQ/3swHx
	mv3RVZJrh1a+dGzseudEQW7D49Jej7W+h6uU55+KarWSFTkjc3rVC1wZkstXM2HRe8nn48xD3x8
	rl+lmQa6M6p7gfmXlgEp8HIcNKmRDfChtXga0i+DopC0m1e+Rl906O7gF3ziXwevqekQpdA9ZJS
	mi40OX6VZpJA3yzkUowX1wyIMXgd5VsSk83lAzarBkFRwZOYlUZA/t+yZK7gy5GczyaSrGg1b0N
	wij5w==
X-Google-Smtp-Source: AGHT+IFVoj1zaInphfyG61S0FoZSYJbN6U+tvCBtglTz7umstEc8FC7EApMR/z45+p+m8QqhppOdog==
X-Received: by 2002:a17:902:ef4c:b0:2a0:92a6:955 with SMTP id d9443c01a7336-2a2f2231751mr428866085ad.23.1767433137002;
        Sat, 03 Jan 2026 01:38:57 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82858sm395844055ad.29.2026.01.03.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:38:55 -0800 (PST)
Date: Sat, 03 Jan 2026 18:38:50 +0900 (JST)
Message-Id: <20260103.183850.1619235309184362207.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: sync: atomic: Add atomic bool support via
 i8 representation
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVjKhRKg-05rjnTX@tardis-2.local>
References: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
	<20260101034922.2020334-2-fujita.tomonori@gmail.com>
	<aVjKhRKg-05rjnTX@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 3 Jan 2026 15:51:33 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Jan 01, 2026 at 12:49:21PM +0900, FUJITA Tomonori wrote:
>> Add `bool` support, `Atomic<bool>` by using `i8` as its underlying
>> representation.
>> 
>> Rust specifies that `bool` has size 1 and alignment 1 [1], so it
>> matches `i8` on layout; keep `static_assert!()` checks to enforce this
>> assumption at build time.
>> 
>> Link: https://doc.rust-lang.org/reference/types/boolean.html [1]
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/sync/atomic/internal.rs  |  1 +
>>  rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>> 
>> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
>> index 0dac58bca2b3..31ac4c83b1a5 100644
>> --- a/rust/kernel/sync/atomic/internal.rs
>> +++ b/rust/kernel/sync/atomic/internal.rs
>> @@ -16,6 +16,7 @@ pub trait Sealed {}
>>  // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
>>  // while the Rust side also layers provides atomic support for `i8` and `i16`
>>  // on top of lower-level C primitives.
>> +impl private::Sealed for bool {}
> 
> This line is not needed since bool doesn't need to an AtomicImpl.

Oops, you are right.

Thanks!

