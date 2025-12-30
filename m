Return-Path: <linux-arch+bounces-15604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD0CE8805
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 02:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EADBE3009F92
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7962D248D;
	Tue, 30 Dec 2025 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd3T8yU4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D31C4A24
	for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058945; cv=none; b=u1U8rYQxRWBUiwla0EGlelgYHh+0+EgH8joaP0E+laigZm/t4ghZupP7FdzMq2S04fGqNv1z0dzG9MnTxr3kMeRCT021FGeMJSsR67MSNU1a5bLHOvS3uQwbeLg7nE6WOmeBCg0Mmu88ZI4dbH3Epxf57w4NRtNlDsd3DiywtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058945; c=relaxed/simple;
	bh=SV/az+nQQGZqRrPMjW+L6FIQ1B9FchmJEu2rCok4a3Y=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qFPirFH2qoNTWJS0yaZz4a//ScT7AXiUJ8mYHTMtTlI7kGp5gYDbpnffYoMsJJUnmT2qYiQNVgAV7zHqtWLi5W9kdD3SuFYqrO3FEPWmhVUoxXHjQOUtfcmaKKv9U2nA7OG8k3vKzgqIO/mhgZjsZTf7BHR41YWFdZMPK/seMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd3T8yU4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso8556513a91.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767058944; x=1767663744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvi8oT65YQWIOV8o9Ed5WOO6+zupyeKcxsj5RVAs+yg=;
        b=Gd3T8yU4zU9c9uYRDy0HuH/7CjlDDAqJxlO1Yi6cFrtOPXf1zAR1D72K8jPqxLER9i
         s8EwhnkyX2wVFDTSpghb4evM0cxkh/9EqSA51xzCiEDQLU4v4eNazOrghTtukXi/Zwno
         T/UvWGSnBqFSeTxAJn5l1aW4rqtWtSiOUHFlpUih1IXBScxHztfSl38wFYun5c9uxATy
         cpePRf1sj262baR19JZNPLduTTFinjMbNkvaGWkK+Iv+GI0BtxJasUrvI0cyHnEb4bqt
         qVU22AC1C2bpxv4tq6F6hBh/zzmIJYlU0Anjow4dtP669yNd5eIjFwpaH9B3ZXw6tFCg
         6SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767058944; x=1767663744;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvi8oT65YQWIOV8o9Ed5WOO6+zupyeKcxsj5RVAs+yg=;
        b=bTLQiEi/tZ52YxO/5+2ew0VcY2yulvT03arWWSN7+wGf3CEbAzLgMI2hPI4btmXPXt
         L2vCtvK+ssck1279cW9CsR6Nb6uKEP4dHiRZfYiJL9GUzNaAFbVIuTc8h+Tnzpm8HFj2
         mFtJb0wuLkkOyG/Rk4wQYjBJfXX3JEEZnagzgFV9Ra81k6wV9rsaeDtAokl7hk5VUd8Y
         oUpeVuQrfpepG749JnSKoC93GdARmAFgH5gFvZq3hTs69ecPRs6JHOMG1/Og2yi0HjPV
         izxZA1xx1swrGmoJVBfP3bn6HruP5+YhEc8SDJpVxL8FPjE0W9D63s4uWLUV3Okja/l3
         4RYw==
X-Forwarded-Encrypted: i=1; AJvYcCV+T6vuMQjYJ8QIwxDDK292I93IaKSkKEINb1QMASQMEYTyCp6B3EGIglyyLeNRfgg7yDv08y4a1WBh@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3A3SNFgOM2p+z9b1utkxlwgHHfFMWl6tic2ypP1O4s2bQ8ai
	TOiV5b1VltbY1en2b2SV5DdZpbmFGo8TLgL5uwE5DukvbI3M5IvFmj7Z
X-Gm-Gg: AY/fxX7dn6gYv+LcqwY2eM6IbpN1/h07uovxAgiONXwjqWAvSwnn1Lwd5dH0AIYBHGp
	Kqu3a1SbNWW/4E7AGNgbApAOFcp4LRxBA2km5x51dgMGP0JxSc2WiOYKxSaUfwIutJX2HSyH+7E
	/eLuHfVrl0RvkMQZJ3h1+2TngJBn4jrZdbMMmQVQoGdLgE/iZpWalmWJYGu3e1Y/YoKMrkqgYGk
	JZTMbVzC+roAOagncnvKZiXRKTc6CWBOf9aEDHRAgrcrDEw9WzKdxtpnuHgREIV6qsdU6ZVUMM/
	ExVSSWxSrnYi6NtPmOtg0QuZFmLraT8ClUQMDI4TQBAFrJiDJ+2lgP2k76czs+gJ9Fy1xlHkpFM
	+UOEONpJxttIEUtHPw8bMFpDhz/LIE4zc8gg/3o7zHLttcfNvtUKyDMbJLiH9SlquLNnXed5R/w
	wawOp7pG34IgtONgdiFFj52OvVycpQM6pPsRpsPB3OU91lt+quR96g8KxhlVdSRmdrOI0=
X-Google-Smtp-Source: AGHT+IEs+feop/b6vR5W+sInfZx+PX0Xf7ym8mfF7mwYWQqCEqn0aF2PvKiUuPuGGE3HYdI22MiaHQ==
X-Received: by 2002:a17:90b:17d0:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-34e921b7386mr29250224a91.21.1767058943678;
        Mon, 29 Dec 2025 17:42:23 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7af2b537sm30366067b3a.20.2025.12.29.17.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 17:42:23 -0800 (PST)
Date: Tue, 30 Dec 2025 10:42:13 +0900 (JST)
Message-Id: <20251230.104213.6061700722666003.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, gary@garyguo.net, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rust: Add i8/i16 atomic xchg helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVMna3OX5gIZJKCV@tardis-2.local>
References: <aU-JcvYaOYznqD-M@tardis-2.local>
	<20251227.181717.1843883205283099818.fujita.tomonori@gmail.com>
	<aVMna3OX5gIZJKCV@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 09:14:19 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Dec 27, 2025 at 06:17:17PM +0900, FUJITA Tomonori wrote:
>> On Sat, 27 Dec 2025 15:23:30 +0800
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> > On Thu, Dec 25, 2025 at 09:56:55AM +0900, FUJITA Tomonori wrote:
>> > [...]
>> >> >> The architectures supporting Rust, implement atomic xchg families
>> >> >> using architecture-specific instructions. They work for i8/i16 too so
>> >> >> the helpers just call them.
>> >> >> 
>> >> >> Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).
>> >> >> 
>> >> >> Note the architectures that support Rust handle xchg differently:
>> >> >> 
>> >> >> - arm64 and riscv support xchg with all the orderings.
>> >> >> 
>> >> >> - x86_64 and loongarch support only full-ordering xchg. They calls the
>> >> >>   full-ordering xchg for any orderings.
>> >> > 
>> >> > Maybe it's just that I'm reading this differently, but I think this is a
>> >> > bit confusing, as if there's an optimisation opportunity.
>> >> > 
>> >> > x86 is TSO, so even a relaxed xchg is a full xchg. So in this sense x86
>> >> > has implemented all orderings.
>> >> 
>> >> For x86_64, I agree that the wording is confusing. xchg always implies
>> >> lock so different memory orderings all map to the same full-ordered
>> >> xchg there.
>> >> 
>> > 
>> > I feel a bit confusing as well about the need of mentioning the exact
>> > ordering of these primitives on each arch. In my opinion, as long as
>> > rust_helper_xchg_X() is mapped to xchg_X() in C, then it's clear that
>> > they have the ordering of the corresponding C APIs. But I keep it as it
>> > is for now, I may remove them from the commit logs later after I
>> > re-think about this.
>> 
>> Given the current implementation, I agree that the ordering
>> explanation is redundant.
>> 
>> When I started working on this, I initially thought we would need
>> architecture-specific ifdefs to select the appropriate implementation
>> for each ordering, rather than having a straightforward per-ordering
>> mapping like this. That's why I added the explanation about how xchg
>> is handled on each architecture.
>> 
> 
> I will remove those ordering explanation and I will also apply other
> changes to the xchg/cmpxchg helpers: we should use xchg() and
> try_cmpxchg() instead of raw_xchg() and raw_try_cmpxchg() because we
> want to keep the KCSan instrumentation for those helpers.

You are right, I should have used those. Thanks for pointing it out.

Please let me know if you'd like me to send updated patches for the
bindings. If you prefer to apply the changes yourself, that works for
me as well.


