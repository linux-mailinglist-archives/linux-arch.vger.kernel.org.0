Return-Path: <linux-arch+bounces-3737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9F8A74A1
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C3E1C2095B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC3137C4E;
	Tue, 16 Apr 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnDXIQvd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173D137C25;
	Tue, 16 Apr 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295502; cv=none; b=pBpEOgmjzHdxmzDyLZ7q1R/Czd43vz9tYxhrBnLsw0adP8+48RVFyJnB7iZ2yZCjF2QhLj+jaqwU4Y/PdOnLAA1uEy/8jVFYeS6B2hf/luKUoRuUowVNnc/hEHqAgNyom3o1JQ5mA12rhfGFt0Am8zbTg9gWKB9M2E5kgk5dZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295502; c=relaxed/simple;
	bh=7ffRkoqd8Raf8fUSuuAKNPwc8vUdDnYdW+Q6ugXQYuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsN+YA1TlKH9rkug52JR8HZhFnPQwkPa4OJZ+L9QR6uMG82h+PGbqRlirJfCpvIycTwGPkDtnjp8Bmh2m9UatACAnrXx30+kIaB03ijVUt/Qy5YqUtPuMzG4rGUGM9gvn/qu0Q3G968syLiD+qDYyuBTkc5ImFa0TxW5IUV8NZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnDXIQvd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a53b331400so2901800a91.1;
        Tue, 16 Apr 2024 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295500; x=1713900300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ffRkoqd8Raf8fUSuuAKNPwc8vUdDnYdW+Q6ugXQYuM=;
        b=GnDXIQvdettLOGq6N7BhuH31MxsBIy1TWrHxga0L0ifBIPw60+KCK7tb4DCWA/H52U
         3bA7l9yGDLgGKP2BiScqveCyJ7Et9kicQPr93w3ItOXQicpGjSkhP77WXQ4c0EwgTR82
         F+LrigmFQ9BlyHlw2FXikdhmDRgpPaK3mL8rWVj+wDqKksIxjipmv4m6dRR7f5OKX2UZ
         P5Yu0pABeZaHL8Qs6uPLU3lj0T1yhPCQSC/OYePrVWTB0+E0mcHbDHKXzwzSblca5Jxp
         UlDwrWrQwyOQj1clLV/reqn1YtAW/KDbP4GBtdT/T+RLNVYWCddx93k00RWwUd5sIo72
         kbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295500; x=1713900300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ffRkoqd8Raf8fUSuuAKNPwc8vUdDnYdW+Q6ugXQYuM=;
        b=FndH1lJWcBYkZQfFaUirOUkuGfWCO2geMdglnm3wVTUgiFTBq1uHUeoHUKzhXtcQgi
         X6UI9jC103jZ8zwDPyHNqGXNEr7Qcr616yC9+wvEU4s5xWrsM4BJwFGMOdFApC+XlCFu
         d7TAi8XIoVb/uDKEW5owIjl5vcxGQTs7RcRP3gRXvRD6o/4NPsX3BLpAnhHuaOPCiikV
         oYQxtYirefe1TlRqHjDWQJxbvhKjWuSnYC6Z6Wc8y2+Q7QtYaW6C9vGUFEWIdwKs9W1k
         kHc/vzpklSTlXK1+eSgrluWAEI/utOhJVONOpXFTI6xi68wCvGv2ddkmf4QoGb8llAiH
         sVRA==
X-Forwarded-Encrypted: i=1; AJvYcCUMhhz1JLd9cxSFdxAiERPa+LPlKRIOalt9Tbd9lMHOxo6BZfpjJdjBWRjQIKgZpnZoN9sMuAXjbfvdWKkXTeIYNAlC8M6WNJmklXIU6m0hbO1ihgjWEa38t3GK36mGkg==
X-Gm-Message-State: AOJu0YwASeAA/mseUkoRyqwTixFNhProfPnqOll3NeqQZ0tUO8QsQyq+
	HHVuG828Q1pRxadadJoL3ggJdBdjhl1tEpC+60kH2ZlWZTRT+7z9gO2Mw/qZ1T7hqM4A8FaEQtG
	WFDWceTUKUVIikbhRVP6r27kinWyFDKCP
X-Google-Smtp-Source: AGHT+IEacr+WK0M3ZF4z2ZTYY1pegpjK4L93Kit6rRktM90mWV0eYXk2xPvWNjCZQ+q0OF2du9cQzMc/KnT2IjI0uzI=
X-Received: by 2002:a17:90b:4b4e:b0:29c:582d:bade with SMTP id
 mi14-20020a17090b4b4e00b0029c582dbademr11298028pjb.2.1713295500304; Tue, 16
 Apr 2024 12:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416144926.599101-1-david@redhat.com>
In-Reply-To: <20240416144926.599101-1-david@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Apr 2024 21:24:01 +0200
Message-ID: <CANiq72kACt+FfeYXJxfQpmGH=uPqkDA0oprfnebw52VSKyn7kQ@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch/tlb: fix "error: parameter 'ptep' set but
 not used" due to __tlb_remove_tlb_entry()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, loongarch@lists.linux.dev, llvm@lists.linux.dev, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:49=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> With LLVM=3D1 and W=3D1 we get:

Hmm... I didn't need W=3D1 to trigger it (LLVM 18.1.2).

> Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks, looks good to me -- built-tested:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

