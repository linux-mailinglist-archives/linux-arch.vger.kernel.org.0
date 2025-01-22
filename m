Return-Path: <linux-arch+bounces-9854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A667BA198C5
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 19:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A53A8C9B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92AE21325D;
	Wed, 22 Jan 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxmTLW9F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543621518B
	for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571692; cv=none; b=TS2bodDNZ1oLXN7tigCXpslsBT3ObnXifahZ//Yx3NlsVArJnY+m43Rkyi3TzWA3Ar9cKn6BocjCG3uPy63RhhWhBB7fdlwpB2QvOEgOqrqj/NgJymFDJgHGvP6/WN4RMM343qXswBdwfP83QddZUXGz9kwn6s0br4kzZwaL2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571692; c=relaxed/simple;
	bh=l3nganunuTO0I8caZ29KPDKWn49joghDgA/HwxSNAhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6icUW+VMMB3ggjVJ6yyXTOT7nTn9FrRGZG4/0rzGau//nEBZOMaayS6YT6h+QVDHM5hI0M8kMySxV1DS4bSryQrFil3r/K5K/vyaMpxCR/uwEbPWAn9xE5UncFUmReeik16/ZZa5mynAqhz9OtLlyYm9j/qMKY0cEg8kRg5pPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxmTLW9F; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678c9310afso29571cf.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737571690; x=1738176490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKydrizajiZyiDzpM90s5csJ2UY4C/EjmVPrhqEURc8=;
        b=IxmTLW9FiJcQuudT5oBCj9ecXbC4s4w0dQ6+nTpzhGs4UVcfcNYruL7Lco4pqfyFaw
         bgcARwU7RTUZCkOJuZcrfiwn7Ak+RusVn8AEqqq8U/kcvcWtWUNyjlUmlBzlvHCHLImC
         VaEH1vbgzJkhG2wjFkYeg3jdtM49x+f9q6Shjh+0GevGeaHtxsRU0Po5sn7gycXIX67K
         EXD2yG2AqQDiQ0oBPvu70wlsxu6jQJOy5Q/unaSJgs5/k+3FN1pfMaT0zRIoqf3NHS/R
         tthUuf+CWt0pqQ5woHizLMPZW3SkXDeUP3XZaQB7LdAWIox0mySz9A+RCP5wvfMrcYoP
         5kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737571690; x=1738176490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKydrizajiZyiDzpM90s5csJ2UY4C/EjmVPrhqEURc8=;
        b=GiSWfPWljAhoZSxEFwUrhfZSw2cnslRddhUfnznFX8x6XFbXgGADDwCcoEGoEZqBeL
         E7fJhUc4JWgL73Hk1drmLPvrxI5Lw9OQED6bWOELQFnaIalu4/A0ghnaTPkWOT5nuM57
         AFsM84xnGF9rm19U0WDsN7rwBT/MfuQzb7WEmHbTF5VZpUgQ5D7GRa95GbwZ23+AQB+4
         ss/gb6v4AEQiGustK8fYFeC13+7d6tBuyf0LALpHgLNDx0y9di3inoqcATpKcIIvAXga
         8KI/Nu+8GApQLrTn9zEcN6R1O1dGCqGpgBKDxSWSr/hFlX5XY9J6WWbN/hLaqOsjCAaT
         8VPw==
X-Forwarded-Encrypted: i=1; AJvYcCWbw7wLdA0MAhSgiUDObO+VLJ98ouufb5M0YA88dFXaktt78bfj6joNxwl730GNIwwLVjdVXpEM2mqn@vger.kernel.org
X-Gm-Message-State: AOJu0YyXF9v1Q7cLuOdWanc+k18afCi6gcaHkp65zu4kYsiWkYJc36l3
	hZqIDseqhQq4t3ZI1TorIApXq1Bxk0m6qhA/6ThZr9rcc0sofcTlIvdo10XQYXx48RgWQU/xN8e
	LY08RDrQzUQuUqb4WAVSWnyHlm6epVqM2IYCc
X-Gm-Gg: ASbGncsuF3vbNG+R+1Qjps5u+I17u3YAT2WvPtLG7SZeGt9PaUJokCGj+bmnd4+aCem
	594ASAWQdtGixoQRUOOGG79WkQPNiyeanw7D3yBJR8IrQFqkAXlYjrEJi4svcy74VKtP2VjXwnE
	ycd1bfUO7p60p89Dni
X-Google-Smtp-Source: AGHT+IHcSKNZCGpPW7UbU8PKxihWgjo1H8ZK9FqkFOttjj+ZTAxgYbApIiufTqEle+NmXwKtaJOVCFj2ZCwtoALKiUE=
X-Received: by 2002:ac8:7f0d:0:b0:46e:2561:e8a9 with SMTP id
 d75a77b69052e-46e5c0fc91bmr118661cf.2.1737571689712; Wed, 22 Jan 2025
 10:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120212839.1675696-1-arnd@kernel.org> <CAF1bQ=QFxE8AvnpOeSjSeL1buxDDACKVNufLjw99cQir0pyS_Q@mail.gmail.com>
 <c5855908-df1f-46be-a8cf-aba066b52585@app.fastmail.com>
In-Reply-To: <c5855908-df1f-46be-a8cf-aba066b52585@app.fastmail.com>
From: Rong Xu <xur@google.com>
Date: Wed, 22 Jan 2025 10:47:54 -0800
X-Gm-Features: AbW1kvbLk69MQRckuu9UcPreOF9jS0FZVYh5fU54olNNQd-dqqvtjn73DZA4fRA
Message-ID: <CAF1bQ=SEybO_+UMDqspA+9OecYqJhE56D-zJyxEUiPcj+Af_fA@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Han Shen <shenhan@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 1:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Jan 21, 2025, at 18:45, Rong Xu wrote:
> > On Mon, Jan 20, 2025 at 1:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > Yes. The order could be conditional. As a matter of fact, the first
> > version was conditional.
> > I changed it based on the reviewer comments to reduce conditions for
> > more maintainable code.
> > I would like to work from the ld.bfd side to see if we can fix the prob=
lem.
>
> Makes sense. At least once we understand what makes the linker so slow
> and fix future versions, it should also be possible to come up with
> a more effective workaround for the existing linkers that suffer from it.

@Arnd: Can you send me the instructions to reproduce this regression?

I tried my x86-64 machine in v6.13 kernel with the following ld.bfd:
(1) GNU ld (GNU Binutils) 2.36.90.20210703
(2) GNU ld (GNU Binutils) 2.39.90.20221231
(3) GNU ld (GNU Binutils for Debian) 2.42.50.20240625
They all used about ~2s to link vmlinux.o.

The config I used was "make randconfig".

Thanks,

-Rong

>
>      Arnd

