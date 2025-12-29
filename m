Return-Path: <linux-arch+bounces-15572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A78CE69E1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 12:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAEB03005FCE
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369D2D8DA6;
	Mon, 29 Dec 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdPdEBYW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E422D97AA
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767009312; cv=none; b=r70AwmtToW9h2SSQH2o3gqMCZQrS67Y81t7lJN3U9sEqtw2FPfVkOeFYjY8FkxRRM3VFPt+ZF38rTnB2fHfIca+R+6c3DXQcoJ//61T1/Gb8HA+uGelFhvIyOEL5rdkIzoe7q2OhnFe/clTNdRI1JljB4iGzEpigexaO9kAqX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767009312; c=relaxed/simple;
	bh=2UHmRmoXWeVJuSC4QC2czvIeBfX/Ei1ahpC0tfWmCyw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h4O6zvB0mWSw5OOx+twO8XS06dIVT5fJ/WAhB/7Prqn6D5uEEE96+vrujm3zoUN0UXcB9/RuKLJpJEIhm5if4ffXGqZrSBmAvpoXGFzzjNQpDrKnMg0B5UDcUprqGPNwZCOCFHYtgdx4qeX9MtqRWDFCSs+jU10nTaeLEKP5DyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdPdEBYW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso10387551a91.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 03:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767009309; x=1767614109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPLUbxjgWCgN0vsRKS1WyRCGYPSvsQjEIbdCCRkhqsQ=;
        b=HdPdEBYWVr0l0mHgbWNPupjqPoVexZ5bRY1kcshiD1j2zd0QmaXVdzQZzcSrdhiPlK
         wDFxO+3ubBBzEwO3gEDzQ5eT8oTkZqSokeTgIITGKb04g/CKshKHvlXByNDl86MbdFyB
         UjBvGuwEBpgn6Zq0ZCG7ycBvxA7QAYyjFG0DZA798zylqWjvdKnRWshzcT8etrEXDUBb
         QX4RcHhbKyF0caCMp9cz+3Hs+twvLuIrvs9+ATl5F4gQxr+zqlB3E8G5v+V3Z8S97otr
         ycjQQeclgV0zdLGeozrmYZHOHL+L2vdzotL3VL/CSXnnxF2qg+tBWmaPw6oLRyQDNeo8
         GsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767009309; x=1767614109;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPLUbxjgWCgN0vsRKS1WyRCGYPSvsQjEIbdCCRkhqsQ=;
        b=VlIaJLeoacs/k1f8323R+S96ZdTDga5e55UpUF85x0CEO857HH4L8WSKZomPXO8u32
         i8EgMQQaIP+73L1tYUM2zT1balLxmTQu0i2Su9zuku2OPPPbP6Y59/8EHssWioCCNZ9g
         T/AqRU65hwB6kQCd1AdCMUqfIhB/zPWBitM9QiTY1KM7gTpqK85DQUhjOKp06pzBoOa/
         ZG3YP+Iye18KVjTHqsczVnjzEKge8rS4+XUwWL1wICkMioh1kj6wKpJGEiKpYJcq6vSr
         sXoWdM37DObX+MH7/ccrtZmLIgIFAFCA3nZVODNCs4M1CQ+ORz9DAW0dME6YEdtxY2jW
         T2gw==
X-Forwarded-Encrypted: i=1; AJvYcCWN8Vta4iD5MaPp2sD600myYem4lUMrrRuCrQ+qcdfEGCdWYbcomtYdpFNYaUzcBD18egw3TZQRSmSo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RctA51qXU3bdE+tummWT1idVN7nO58pfACBu+47x2g3ZIngq
	xxlUZki8twYEHCAx7dmhPaACu6wRav5fs+EdWeF68rIlFXPk+0RZ5kLEGXIiNA==
X-Gm-Gg: AY/fxX5ejbnxa7LXtNCotd8d7ETJklGbnANBikbpBmykotE3+jvwytuImW/Ha1AYOWL
	2XdeEe7e99hu2+pes2507XVwp4BxBkpg/bzjcqVYFDmUHMzUgxPloLZbVvaImeN/C3jv7gaeU+S
	of2OCUIaO/YGCTi3SisHecJC4gQGBOeBk8tX7iSeQoKDdhg0rvKpZ8l3sQdkvPws3bc0c3aJL5X
	Bm49YL15kNC6yunFk5+VAyu7Yw3Bczj3XNXRSNm1+GgJJcwo7Ng7QUxHIUe4AIeUC+DrP88Mfdi
	26Np2dn9ZMztuVnVuTw46QbQb25xTd7QtCNWuoufuCEUtc2NqNTPxgohe4j15rzbmEf3Mt2SYMF
	se8bEpMGb0R5CjErm0UWn0DqCZ/9BIix1oOeRQSN7WVOauiFosSneyNIJwq3LRY9RigoHR+GRov
	oVS5zegaP6c5Tpp81z73X6JDOV/mZRr2fXmhBdtqxflsYWZdZJvlqjwnfguMUTX3c2dnk=
X-Google-Smtp-Source: AGHT+IFqi0/hM2TBTczvURv0i5GVkN1X/kCu7v11mqWTtgi4jukIDw2QBEFK7bu82Sk1IdQUVyktkw==
X-Received: by 2002:a17:90a:d406:b0:349:5b1b:78bf with SMTP id 98e67ed59e1d1-34e921b0646mr27277305a91.23.1767009308670;
        Mon, 29 Dec 2025 03:55:08 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9219eb13sm27105493a91.1.2025.12.29.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:55:08 -0800 (PST)
Date: Mon, 29 Dec 2025 20:54:53 +0900 (JST)
Message-Id: <20251229.205453.623137996017774034.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: sync: atomic: Prepare AtomicOps macros
 for i8/i16 support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVJiR72gcz_uonoS@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
	<20251228120546.1602275-2-fujita.tomonori@gmail.com>
	<aVJiR72gcz_uonoS@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 19:13:11 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sun, Dec 28, 2025 at 09:05:44PM +0900, FUJITA Tomonori wrote:
>> Rework the internal AtomicOps macro plumbing to generate per-type
>> implementations from a mapping list.
>> 
>> Capture the trait definition once and reuse it for both declaration
>> and per-type impl expansion to reduce duplication and keep future
>> extensions simple.
>> 
>> This is a preparatory refactor for enabling i8/i16 atomics cleanly.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Thanks! I have an idea that uses proc-macro to generate the Atomic*Ops
> impls, e.g.
> 
>     #[atomic_ops(i8, i16, i32, i64)]
>     pub trait AtomicBasicOps {
>         #[variant(acquire)]
>         fn read(a: &AtomicRepr<Self>) -> Self {
> 	    unsafe { binding_call!(a.as_ptr().cast()) }
> 	}
>     }
> 
> But I think the current solution in your patch suffices as a temporary
> solution at least.

Thanks!

I'll leave the proc-macro approach to you. If this can be merged as a
temporary, incremental solution, that would be great. Once this is in,
I'll send follow-up patches shortly to add Atomic<bool> support and
migrate the remaining core::sync users in the tree.


