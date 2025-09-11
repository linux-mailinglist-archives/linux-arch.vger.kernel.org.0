Return-Path: <linux-arch+bounces-13497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E5B536B7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCD73B4F3A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996334DCEB;
	Thu, 11 Sep 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHuf/TXo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07C343D76;
	Thu, 11 Sep 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602642; cv=none; b=hCOWn/LP1Z3Z+D5whPVFP4FMGuNzwJGe5PNmOAcxTIFzLDnOqHD/M21/07Jw8JaB68E/DdpYrC2y8OORh9mGQuqKR1v/An0EqvlBC+cT42VTT0Uc0xPjEZk0i5yN6bT7YBurRn45GxVIkHVkF5xnr+kzANZL/leCzmo+M3gXGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602642; c=relaxed/simple;
	bh=4oW1cWLMnolFBHxMFf3L378W07wCXBV5VY8o1WrWjaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5JX1/FsUA+b+gIjjEPVuLsil85KaijzLZavydrDs4nqDwaM3scBDMVDRY7vrO0eeVq5plkcoO19YbMYwkMPebvi4n2tY114ZsmU+p8MJJ1kRaf1jbKw5OnYWvStm2XyJ33UKn/bCD96cgyaPXp+jaN87F323+2emmIGZATqfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHuf/TXo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77264a94031so605153b3a.2;
        Thu, 11 Sep 2025 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757602640; x=1758207440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JC25N9kpTU0r3fRNk4l4k+XwpkDghlYJvxtjqZaC94=;
        b=eHuf/TXovtkJMLLT8lodmrqkdOxBAmSBYTqik2M2HGC8TJ/i1yZIXZjDMz6EW7Eclg
         vE43wbikjrmqSRAVMr8b8ULgWg/2hR708QKvGVtbbBTEHU0ESdq9QNeb6aBRl2UektJ3
         o853mk1XicVXHfcOtsbXXJbhcddftk/fNUWGe+LzXHq9cczDzyYwuc8fRAzf02Ppbzo/
         PjCejkhPQPE2E3jvfTc/RS91kYh8fjaeUGPrV/dcyCE/lXhZ4kT8A7JszfOfPWhFyHor
         cYuPxQrSJkNJfYgC/fyIOVWirioffGe7iB8KQPaJrMhfz/jSUJWRqotJPrLkHmoaYdJH
         oXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602640; x=1758207440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JC25N9kpTU0r3fRNk4l4k+XwpkDghlYJvxtjqZaC94=;
        b=Xj1HPZNIVVDAfON1FXkNspGGpbrduyrMjNlOrr8fgBWYd+coerIsfPgPfs7edKUYGn
         OU19RAunfV0sbEAv4I5ZtrIsfpSDPCvfXLVmb8h8LGctScjoefUcImZRbxiIFs2AqNVx
         nL1ebcaBC6zWzA5ppxweKJxcotgWxjsS8EMQrgKNvrXWQz6EFSFvqLD1UNy2sRGrMToy
         rYUI7SJsOaJqOKU/wE2chKyCB8BolSqihOVREtIITcaZi3O5lhClfseekcOgDstMGeW3
         ETny6hV3lvx5tlr2jF6m/zqTBeWr7yMEfzQZfcOb4jXOFFqpqr0r0KLePjO3vvXJG5VN
         B5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfiZ5WqTb6iQq3806GBxllHD3uUuvDNXXfE3e2dsMb612qlBEyNePTr32x82ct4sG8o40bD/Acu6L02A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6UOFAF9wntsCGnvUlIDQp/FcY8jYzSYYoXsDqwfXu+rujqqz
	jaA8RxonZWRrx8aDLRm1zjhgHR8qHc8JSMsgiKYfjv5axH7DrMr91pjlvC+4cq4rGmblSqnqTkx
	v5SEqLlDX2GBMAkrJWSDM/EwSojycXsVA5A==
X-Gm-Gg: ASbGncuLhtNdT1C9UhAfeoUKipladnDISsqHh86B7iqVgqc3ppqrOAkaBmG2eBDGWDi
	rR2I/+Qx5pDhIWFDh5CjGuv/eyxXxZzoaNviz+wwdDc+VmBkhef4L2cfEyb/FTToTPXw5X36Bu/
	/TbI+D7HRWUqhVIJV1xvLYsTdcWDxgSKu/iPDEHAyI+2otjW3xIOMw8BrNdR0PTw0w6nWekr3S7
	kiGgjPU7btKtm1ZX1xXe2Vra0eKOwXYcd4J6lXSwryrl8UmrYM=
X-Google-Smtp-Source: AGHT+IFHj23qBJTuYPJmIDUDNsE+0gkF7sELR1zuExrSeY9m/NmEPzngY7BeRQHCx3UhgvWvpTrSgO1i3jf0bjsceRg=
X-Received: by 2002:a05:6a20:3d85:b0:252:2bfe:b660 with SMTP id
 adf61e73a8af0-2533e18c6fbmr31239473637.1.1757602639956; Thu, 11 Sep 2025
 07:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911015124.GV31600@ZenIV> <20250911015440.GE2604499@ZenIV>
In-Reply-To: <20250911015440.GE2604499@ZenIV>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Sep 2025 07:57:08 -0700
X-Gm-Features: Ac12FXyLRtPJLSePsLRHiEG3JsUonKdaPfltTpwkSsnjnNdd4Uufm5aPWQvafFo
Message-ID: <CAMo8BfJv2qvVj8JBTgH_Hj4e6jFqYDtZyNkRAPkabtg-0w6Uwg@mail.gmail.com>
Subject: Re: [PATCH 5/6][microblaze,xtensa] kill FIRST_USER_PGD_NR
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, 
	linux-alpha@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Jonas Bonn <jonas@southpole.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:54=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> dead since 2005, time to bury the body...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/microblaze/include/asm/pgtable.h | 1 -
>  arch/xtensa/include/asm/pgtable.h     | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

