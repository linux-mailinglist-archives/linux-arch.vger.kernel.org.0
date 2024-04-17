Return-Path: <linux-arch+bounces-3740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226268A7AFF
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A3F1F23B99
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792CBA4B;
	Wed, 17 Apr 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqLw8Z27"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE38F66;
	Wed, 17 Apr 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323919; cv=none; b=r8P+NA+6b8X4cbz9aChuMuW0ud/kEy5GdR+U/OAH7OMIfTnYJa4dTGJlX/QLAfYDRgG9qTSIKUn2yQvrN0vllYL029R4GPLFoKY7GQYOW6NVEi/2xBl4zJTek85K72VwvbjHl09h/MakS44FvByNTx1opSwYnzYjyVtgw7NuhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323919; c=relaxed/simple;
	bh=QROgXz5UDuoxzxyfomvlU9PtVelcpq1hfiHqc4D5Rl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpdWEdy9ipzN4E7UtHI1h33Wvdi8EBXuwybgHqsPtWpDaIKgscWbktvhjKKn5l3zRLyfcUJQk5mllzWJvmrAc6WQgqoKGmHpe8Jvd7LQ7glZG+zsnJTYBKlZQkNH+aE46enytHiug3iOiGcjtR4PlMjWf/TT1cFnyEFIdX/BnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqLw8Z27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8643C113CE;
	Wed, 17 Apr 2024 03:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713323918;
	bh=QROgXz5UDuoxzxyfomvlU9PtVelcpq1hfiHqc4D5Rl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kqLw8Z27o9tczw3gVr+DQw78bY/vuXNieAm6RyqMBwaTqF/7X62dbj+UjOxE3ttnL
	 2ZHQRFwFQ527o1zHAoWGxPRsSChSta5s3Qdo8utMdB0p8CyQwhT8DI8Kd7jhYvuiG7
	 33RNm5tlzJ02TMnUvv20OfOTueGMJK1t/sON/wuc5oqLkuzcny3J/WV6W4QMOb8rMo
	 cM6UPl1gX0DIebasc6xLyZzMu+E5mqXOzHmwGQCtfDXO/i/uHJ0HVlY00nqjPICMG1
	 JcBGCdqzs/ZVRCDuJKxwrLWIJsYfpOFoN/8QpAdGI35eTR2Dpr6eF/R4ItNr8donPs
	 ySgxiuYSJOLuw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51969e780eso665324566b.3;
        Tue, 16 Apr 2024 20:18:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtwSKA1LqTH1kIyO1kT10hx7beoh69PHL/+hqOaMycKUMFc2NqRZgXPSuwrHT16h1dJ0hHl1FGzrcNyRvoQ4WO0RAkIf/zXaFTorSnl4labBY3NbUAhgqePdazYLMme69hwztGX8wIAoH7KOPX/SVJJdRpMxsbBIxQX5i0tA==
X-Gm-Message-State: AOJu0YywLV5fM28Sg3p7iuY2FRA/nO4KIjRr6HjSDBRsAwkefuKRk+iw
	F2AmAdCi7rKvsvLvt0e4ahT/IpfudHbpvDfTLsK9SFliGEwQ4H5A5B9icAqXYTbWztxMFwj+TUl
	KE+eN6JF9trt/6v+eMV/DQoqQjK8=
X-Google-Smtp-Source: AGHT+IGAV0JKt0Q8Wt6Fx+5t3raYHvV2CbyQ2onGWJZvBZMtZILfGwV4qyHAs5ucw4zU1joYNfqugznQTR7cPZhmh20=
X-Received: by 2002:a17:907:1c0d:b0:a4e:7a36:4c38 with SMTP id
 nc13-20020a1709071c0d00b00a4e7a364c38mr13676826ejc.20.1713323917285; Tue, 16
 Apr 2024 20:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416144926.599101-1-david@redhat.com> <CANiq72kACt+FfeYXJxfQpmGH=uPqkDA0oprfnebw52VSKyn7kQ@mail.gmail.com>
In-Reply-To: <CANiq72kACt+FfeYXJxfQpmGH=uPqkDA0oprfnebw52VSKyn7kQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Apr 2024 11:18:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mt0GaaZ3s44CYb4aKqYeDYm+Q16hY__FdQ6xYJh+bgg@mail.gmail.com>
Message-ID: <CAAhV-H5mt0GaaZ3s44CYb4aKqYeDYm+Q16hY__FdQ6xYJh+bgg@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch/tlb: fix "error: parameter 'ptep' set but
 not used" due to __tlb_remove_tlb_entry()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, loongarch@lists.linux.dev, llvm@lists.linux.dev, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	WANG Xuerui <kernel@xen0n.name>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued for loongarch-fixes, thanks.

Huacai

On Wed, Apr 17, 2024 at 3:25=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 4:49=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > With LLVM=3D1 and W=3D1 we get:
>
> Hmm... I didn't need W=3D1 to trigger it (LLVM 18.1.2).
>
> > Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> Thanks, looks good to me -- built-tested:
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel

