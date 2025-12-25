Return-Path: <linux-arch+bounces-15552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8FCDD2A6
	for <lists+linux-arch@lfdr.de>; Thu, 25 Dec 2025 01:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1654300AB33
	for <lists+linux-arch@lfdr.de>; Thu, 25 Dec 2025 00:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9A20CCCA;
	Thu, 25 Dec 2025 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxKh7DCN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E7F9E8
	for <linux-arch@vger.kernel.org>; Thu, 25 Dec 2025 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766624233; cv=none; b=gbYbpCu73arwcY9VWKzZ/Kd05mrNQNO7Xht+Vk/+a0fo7PPYaickZUQDFUOYyG7L439sj2EBbzr9UbxT0ugBAflDl13I+YNqFwaLRNAQEzD49/n7yRChvwrZXw3Bejpc24oVP5FZggGa0cobfQCyp4zndY5F99Zf6SXYPpsbwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766624233; c=relaxed/simple;
	bh=jMNmLY7Zo0vR1Cv2A9ndNwj9r7H8MNy8rl3djWJOSzA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fHr+GDybXbsWzMUg4px5ZKCvztDEDpbExQ3EgSQ4ZtzU00/rJe6JAlhN+4YQrAvFMKwU4ewAzXdPLJgqJ5faE7c9ywuKf8UOAgSftBY987p2vDby+hC1ujenEzY0sqJxto1UZG7rc7hWZUeP94B7l9TbnhRn9heCiOxZD6E614U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxKh7DCN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a137692691so72793775ad.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Dec 2025 16:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766624231; x=1767229031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmJlYQp0WKEJKAjJG22CkYH57UeuO3Uma6IPeBjDN9w=;
        b=WxKh7DCNoY0fTRiUss/ROUqrxbA4Ng8PgTC2fXNVFy6NuZy9RK77dVU7S8Ax1aR71Z
         ZQXLdmc3HtIXd5mmENCNsRP7iVBEwwuXbfJMXMYRXd8IabZgfaO9REzGdSgi2D6spXcH
         T+6s4E5iouDgrYXQnNH19KSokIB2OkIm9AA1BDR8BH8M0z5122xZHKPeAWvN52P+wf6G
         vm59w6RtCSQOtBc7sgVKW7IRzBfCy3hB9qNH+Enj+sPX6rufJHfz5rPhSa6eHvPr5Kb4
         37qbkMe2GCYKIT9mr6ffxFcQ5dysFvDKagqII9fbYz4DwCXURcDvwMEHjd2vTlSmjdtI
         L2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766624231; x=1767229031;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmJlYQp0WKEJKAjJG22CkYH57UeuO3Uma6IPeBjDN9w=;
        b=eyxsxcNNZQOQwwBXkP00JaG/vF4in6Nb5zqsa/dw+HLmyLHaCGRa36+4lol9nMVZY4
         AS9056glYfksbcf+ZNZSFSy1bce4iYaky0WAqneB+xfHSY9BbDw9Yqfk9lrC/1lSOMSg
         0QEjZxo3TCu7OHWPycaYAAkpmol1wQOGeZW0rjgIgZofq0ND1Of9Btk4A9/kL0HL7hJ6
         VbIs8/n5s/cROK5gEPhIqe99VBsoexY19aT+iHeAiDMzmOr9Q4//sPSYJcDWFcddOBag
         8JYAr5PLoejwQoJPa6a7l1woOi6Jro+8K8hl3xs/9knfWROt5WCnahgxu49DB3TwC9Ca
         UbXA==
X-Forwarded-Encrypted: i=1; AJvYcCWIdbBGfhW1D+N6X1COa70tbKtg9ihVCHeY1qmWnpDO1s6NuyppK6kvCcML1xtgvwLHG9IPIKbVNvuH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VHFTnjrHlqwim+wKbFpVW8olBF8KMUhR81UDDaRvxuS3EHNE
	56T+bx5JgnZk1NiZUeAuWA0lDHad8jpp50Lct6lfWJWKMer2vN8t1phI
X-Gm-Gg: AY/fxX7APjmgHXiarWNs0GuP3+E2y/lGdNOOb+XxgzE5XOznjWVUgmOrCmeGJbZXAF0
	diR8YtG1jp0eGhWiK0/T0Xa2Ftj4o8eUVLGXMzJwaWkHu/r2G7cefpxadNYDk40DwF+0XxfsNVw
	qMRasX0cPn58Dujhjzx1XwC8/QBX6sSQzQVcUvczbPAdTYYbp3s2aA4gydYTpohSCob1B6/Vv9A
	UEXMuqx1t6pOQDjNmJtBhd3uikrKUmxmycpvZCtDYBPWpjGwsmDOfY0iJ3FCWYVD4XA22SZzBe4
	D4qQR0roxVD11rRcpZXDttQwkVcUmTSWPF0PmTHLR7fApWAdtoeKO9CAB71Eld1QovRa5on2psR
	YT4CTyJ7yj2ghcrPxy/xvCcN9O6B5EDj/r5bAao37GIz1b7/0BvDkF/iEJQIHouqvvhaFFnOOoN
	t8J+jDZbpbfk7eCGREzqS0RXUipKoH/8EzkHBKdila4w20gSp/zi/UdJwqj0qx5XwwVgo=
X-Google-Smtp-Source: AGHT+IHYIT1UKD7G6j1zsAt0oUwMwGT3axWIz87jexYXkCraW4OS8iooI5EJ+aLcAb3WfuCb5sp3Gg==
X-Received: by 2002:a17:902:f70d:b0:2a0:be68:9456 with SMTP id d9443c01a7336-2a2f28404a0mr186470385ad.46.1766624230775;
        Wed, 24 Dec 2025 16:57:10 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c666d5sm164703275ad.21.2025.12.24.16.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 16:57:10 -0800 (PST)
Date: Thu, 25 Dec 2025 09:56:55 +0900 (JST)
Message-Id: <20251225.095655.275822477142372376.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rust: Add i8/i16 atomic xchg helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251223124639.7771082d.gary@garyguo.net>
References: <20251223062140.938325-1-fujita.tomonori@gmail.com>
	<20251223124639.7771082d.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 23 Dec 2025 12:46:39 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Tue, 23 Dec 2025 15:21:36 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> This adds atomic xchg helpers with full, acquire, release, and relaxed
>> orderings in preparation for i8/i16 atomic xchg support.
> 
> 
> Any reason this series is not sent together with the user (i.e.
> Rust support) that uses it?

The users are generated via macros that add xchg/try_cmpxchg methods
and their tests, so sending everything together would result in more
than ten patches at once.

I wanted to send the bindings first to make it easier to review them
on their own. In this case the API is already clear, so I don't think
it is strictly necessary to include the users in the same series.


>> The architectures supporting Rust, implement atomic xchg families
>> using architecture-specific instructions. They work for i8/i16 too so
>> the helpers just call them.
>> 
>> Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).
>> 
>> Note the architectures that support Rust handle xchg differently:
>> 
>> - arm64 and riscv support xchg with all the orderings.
>> 
>> - x86_64 and loongarch support only full-ordering xchg. They calls the
>>   full-ordering xchg for any orderings.
> 
> Maybe it's just that I'm reading this differently, but I think this is a
> bit confusing, as if there's an optimisation opportunity.
> 
> x86 is TSO, so even a relaxed xchg is a full xchg. So in this sense x86
> has implemented all orderings.

For x86_64, I agree that the wording is confusing. xchg always implies
lock so different memory orderings all map to the same full-ordered
xchg there.


> Looking at loongarch ISA manual it's suggested that apart from load/store,
> all other atomic memory instructions are also always full ordering.

On loongarch there are two possible implementations: an LL/SC-based
one, which is effectively always full-ordered (similar to x86), and an
AMO-based on, where weaker orderings may be possible, as only the AM
variants with the DBAR function appear to be full-ordered.


> The change themselves LGTM, so
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>

Thanks a lot!


