Return-Path: <linux-arch+bounces-13821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FDABAF5B9
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 09:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E051897D0F
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 07:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B9247284;
	Wed,  1 Oct 2025 07:08:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464FB7261E
	for <linux-arch@vger.kernel.org>; Wed,  1 Oct 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302513; cv=none; b=OpqkQLZhiUwLpkrRv+IYpgv2xIpS26mQdzX6cGrgRp4PpwFnp8C+09n1EGcQw2fSah8MqvwR+INmTOjJDYV5npyzHeNOvrQl/UobNWDlORBk1dX6ksnwilM0pxOfN9m+zKznIZzcDpFTYSICgaA3teZS2olByTqq3CZbjzOlm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302513; c=relaxed/simple;
	bh=7ANDfXM38Gq8udquxdGN69lHmB9wggZcgP0ai0VsdIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ6oENgIKayLxUbW2nTzUTADeUdXJAoPp6S71CyHvSaOBFeV4eenq/6t6ZUYcTLuXB1py4vcy02C8sTD7ZpAuh8TrieLLepianKL5f16D9WIAFFpnIQC23ZdNF1zVfPbPuSGONd547gdRimkPv8OpC3cvWk7SRWznQlyKHMO9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2931451e0c.1
        for <linux-arch@vger.kernel.org>; Wed, 01 Oct 2025 00:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302511; x=1759907311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1Xe/yIXoUfwDHnypUCkmL2agWH96d+WyVy9U6y5GP4=;
        b=WbP9oMUGgQ1Asg8CcQQLeu3r7PKm4jahffjWGocXIa+RFpSF9q2n9nSXc+6Gcg7zor
         Rj79Z6vBBEEwHu5rQ6qrK9slPk2U4C4rJJwoxre4lsU1nuT1TUujWpjQJjB9AnCfPsqX
         CSHmUKd4aTsaT0vGaUq+bQ14PhnT2vLMabCh+VsZCmktDEAWmJ1PK4KltMvuH/UX/thj
         FYKWuoUQqOLgTU1DL7+/HMBaASof/jFgyhujtz+9zv8F9bgfnihRF5w4ejjFSbKn0mQ4
         R8imKPmC8Pzg8hciXHuSXOfC6PfCa7d9KVqQS+zLAopYJ7yGAq5kAvEjS5ZShOZlAk6R
         MJbw==
X-Forwarded-Encrypted: i=1; AJvYcCVU9gQ8lFK80EE8HNHEbkQwzY8uISXwLLNRT6MTlJ256lYZKpypfREhC8xzKHW60hel6E2BtTIZAGia@vger.kernel.org
X-Gm-Message-State: AOJu0YwozeelydZEsVpdI/cu3UEGMIzYwUWYvGQOa5Y5yv50HeoAfP6F
	LUyA65z8XXia0edllWZoOfpLnPAKCt5p+on22qS2e53lb5meQIPz0bdlyRMP8zO9
X-Gm-Gg: ASbGnctziiKYhDd9dlNx2WpguIapWXqpZ/PQL2yM9PHZaZBXab42JW2TeeVQnN04gsx
	d/NfNsIwUPZmsW4ESDf4Fh69BYjrniCUwq1L+OW3GmRpBNjPljeEYBftNRzgrlK50Cj2UuADWzF
	LaZlZ24vaKim3RffNIubUpUimoli406GLtp7qq+KJU+oh60gT6dKEdPJL1LJv+cWgJ8uaQSls2t
	qtGVXKSnzeWX+3PJWbFcUcbWITVqdhHY4VAijmVD533K1g8l6ce/skZgRIkry10682VMfG0dTKC
	9fJIGPekfhnKAY92166cd+apcOMvd8pnWusg96gqerQBJAldFqYSWtHX9wSbAKOfcmpivJxDQ7Q
	pKtyuM0+pap1GiGqavnicF/0n3zhOMkbaeeDGbRfUdlu4nUmPMJxo9vnvoZWedwSWS8BI99WwLZ
	MwuYMZNr3C
X-Google-Smtp-Source: AGHT+IE2hZuvlUwekJIeSBX3L+qz8Kh4zsOuSs9GDkcJqq+sF0zSZdJLM5gjpGLzD4WZa5xVPXnunQ==
X-Received: by 2002:a05:6122:251a:b0:544:8d16:4541 with SMTP id 71dfb90a1353d-5522d2a3936mr899232e0c.7.1759302510676;
        Wed, 01 Oct 2025 00:08:30 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed88199csm3330467e0c.3.2025.10.01.00.08.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:08:29 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1802714241.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Oct 2025 00:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcsC1AANf6NVwkohI9xWYSHosxmSOml3hOrM6iq+mUPh5FNraRTQY2yjH9J6lCCi7tCz0DDW8BmBw8@vger.kernel.org
X-Received: by 2002:a05:6102:26c3:b0:558:72c1:2762 with SMTP id
 ada2fe7eead31-5d3fe5358bdmr972805137.11.1759302509044; Wed, 01 Oct 2025
 00:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org> <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com> <7c2c4da1-57f6-23b6-dbff-6288ef3f2a4f@linux-m68k.org>
In-Reply-To: <7c2c4da1-57f6-23b6-dbff-6288ef3f2a4f@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 09:08:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwYvJSoAWDTJJYOTt8mgtfa+sB_uevYR3NXFUK2fVS5A@mail.gmail.com>
X-Gm-Features: AS18NWD9LDo6xA5ckwXmlLEmk9kfyHz5Y83hVqr1eWllj9E1zqRP90XkriKsg1k
Message-ID: <CAMuHMdVwYvJSoAWDTJJYOTt8mgtfa+sB_uevYR3NXFUK2fVS5A@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Wed, 1 Oct 2025 at 03:46, Finn Thain <fthain@linux-m68k.org> wrote:
> On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit
> > > atomic operations, for my small m68k .config, it was also necesary to
> > > increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a
> >
> > Probably ARCH_SLAB_MINALIGN should be 4 on m68k.  Somehow I thought that
> > was already the case, but it is __alignof__(unsigned long long) = 2.
>
> I agree -- setting ARCH_SLAB_MINALIGN to 4 would be better style, and may
> avoid surprises in future. Right now that won't have any effect because
> that value gets increased to sizeof(void *) by calculate_alignment() and

Ah, so there it happens...

> gets increased to ARCH_KMALLOC_MINALIGN or ARCH_DMA_MINALIGN by
> __kmalloc_minalign().

Thanks for checking!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

