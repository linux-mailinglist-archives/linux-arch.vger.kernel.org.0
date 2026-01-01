Return-Path: <linux-arch+bounces-15628-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29106CECC72
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 04:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AE230088A7
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 03:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B021C17D;
	Thu,  1 Jan 2026 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkCgjdJ0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076A1400C
	for <linux-arch@vger.kernel.org>; Thu,  1 Jan 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767238039; cv=none; b=B9MKKzUH9+dEZ+uMvGs9+LwQ2tc8sId95Gh+tlCAld4nGcXKzVRr4UZCJiT2/k1eO5EGNNNPibz5Q+InZNJuVIAM0Jgg4kTFzz2TyltsO9OVgQSTt4DWU+zwldaLS8M/g4ZnbFyOQuT+AfVOJp/gUWFfT96wYOex0d/vPhzSOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767238039; c=relaxed/simple;
	bh=eW21rXYuAMNL/Q/NB+5NsUTIo96fybhUX4uk4OSHdg4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GjuZsCjkKT7tW2ATWomgRzSw9fgyzwfQU4hjEo0fjjg1P9kTt0DJ1A7m/hZ0X4WehOJIiJrj+YhEd08l6vGe89f44XzFSYtXuE/ZZofOS6tDJqz0pZnDjeX6FNI0Vbz2DIBMITqXpQxFOkQAbEBMWpBLDOcNbdqtrJeWiUEzOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkCgjdJ0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0c20ee83dso143504595ad.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 19:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767238037; x=1767842837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URkzJF6KuwnH0SlAYpJCl1hDAluJTaS1mvC2L+e7OI4=;
        b=UkCgjdJ0YGZoK26p19zls1bBRkLmr834Z4mM0VaoWzpiDsHgiFNkxJfVi8M63D69o9
         +yLKSl8NOm0SGdLBa8XSGSd4QUC3GRue9FzXw3Y9VOuM1OX2faoxHjMAgeUIQ5IBWsbJ
         LS5wQCTzDlXaf2lXivLKljw2nWZXRu0TKiyYrK+o2Shox4qQRUpXBjgAtn+IIUUKLISa
         8eLtG8SIRNZneC4KaJ/e4ENlj0TS0Ngr3459/VRAk2VolZh3vMPw1fJucqrgcj5/6Hxe
         VQD0jLn4TarbYcoORUBCDpt2qeQQwlwPofTgjQnvhQ1pGBzDJbisJNDWZo/y5CJ5Xrdo
         xngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767238037; x=1767842837;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URkzJF6KuwnH0SlAYpJCl1hDAluJTaS1mvC2L+e7OI4=;
        b=btcKLfeQEQnCaaBwnyiBEEc053WOVFVU3armymqODZRRcQTK/NDSCMqLaLUyeummd9
         /PhOCEVaokBX6L7xFMkIp19Y68D+sCph18fRx0PH6D9XxTEmAXIHW/Lg9eN6J+7tWTmb
         uk2+bsnqUIBuyiHGGNOTiwPS0/4Xih3CHzwpLe3Ren0ORokT9toW8VFRDoOPDycCrlTu
         yPLL4gRIKKFQm0fiL8qQgdFtfEsKHqnvQAZCcQrhV+f2lzTUgB6d87wC3yyGdoUchCTe
         rECIrVxRNkodL+B10JtXN3p+FvA+pFaJ/Su9FM+K/X8C8GR5GbJcBe6Zc3t1RujdNsD+
         SMdA==
X-Forwarded-Encrypted: i=1; AJvYcCX3hIESev0ZM0XORjLTHa3rsNpic4TGzVWheifX6UZ4dRmjhK6s03TyXSY2ZEPyb1k/NI5zf+GCy3sd@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCp4Qoj2VC43+7Kca+0yh3XTE0Ysls2jFZWblFI9XiTP0lQa8
	2O7LrGE03P9K4D7KAVdwDd+Kb/MR5OeltCk+xsr4GDsc2NAK/fgOM58Y
X-Gm-Gg: AY/fxX6edMi95hv38VjqmLyBSB0wSP/R2YxF9EgU3ZL3INQonYktzXXSiGFNH/3bnpL
	sMnk0LVCIi6YHk1BzIIG1o5gRPGZawWV9s4wqjPJj/kcIF9Tlm4KMUgIdWT1yyj5HoZTy7ImzG4
	uZmGHcGeQ0QNOKuhCdcfgYBvCCTtC2Mc1JSsCfmTuCmrQo0lMcxEdLQQH3CTAbCDPNl/qjPVyL6
	Secq1ATSlpWeJqKDwnW0EfC83+rziESLjxvvQAOERlMUahFvGPnPm4zyxHv7MGXNp7qPpjUP1XA
	63AiJxdt24SwWIWfIZHnAv9YViq6laaz5pG36pQz2aRXlsclEKofZnOPYnx9xQPlPRJTcjvxUrS
	dWN1ZFtu/zlEQDgSF5vr6p/AsRsalbEi8JmkSSQ7tOBLCkJyBoW4akC3pKRE3n34izEmqvfI6T3
	3d4IkgrXDURChj3lOtEY6LPsFedBzoKBiRsAWKJhaHPY8W/RBg9sqsP6tT4FLHlyeZQ3mZLazpu
	Ypf9w==
X-Google-Smtp-Source: AGHT+IH6AF6a1j3gYbiGUaYhPP4PidZgt6F/PO/iHaW4dHygCi0e7n87vvw6c1RFB7wkVjmYs8XEEA==
X-Received: by 2002:a17:903:b90:b0:29d:7b9b:515b with SMTP id d9443c01a7336-2a2f2527092mr393241735ad.20.1767238037313;
        Wed, 31 Dec 2025 19:27:17 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6b7b0sm340978965ad.16.2025.12.31.19.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 19:27:16 -0800 (PST)
Date: Thu, 01 Jan 2026 12:27:02 +0900 (JST)
Message-Id: <20260101.122702.1297255764389254863.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add atomic bool support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251231153431.4a48816c.gary@garyguo.net>
References: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
	<20251231153431.4a48816c.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 15:34:31 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Tue, 30 Dec 2025 13:50:26 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> This adds `bool` support to the Rust LKMM atomics.
>> 
>> Rust specifies that `bool` has size 1 and alignment 1 [1], so it can
>> be represented using an `i8` backing type.
>> 
>> Since `bool` only permits the bit patterns 0x00 and 0x01, the first
>> patch also documents an additional safety preconditions for unsafe
>> `Atomic::<T>::from_ptr`.
>> 
>> `from_ptr()` exists to operate on C-side storage so I don't think it
>> makes sense for bool. We could restrict from_ptr() via a marker trait.
> 
> The C-side does have `bool` type, too (`_Bool` has been there since C99 and
> we have typedef'd it to `bool`). User might still want to perform relaxed
> load/store on these C-side bool storage.
> 
> I think it's fine to leave out this line too (given Boqun also points out
> that the additional safety precondition is not needed for `from_ptr).

I see. I'll drop the description in v2.

Thanks!

