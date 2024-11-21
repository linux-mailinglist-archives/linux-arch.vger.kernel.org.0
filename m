Return-Path: <linux-arch+bounces-9145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35F9D45B6
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 03:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D6282FAB
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F119A;
	Thu, 21 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7pf7akY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994023099C;
	Thu, 21 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155625; cv=none; b=ONdzpPkcNkmrq6sMtAQMriXeWUi3GSxkvH6ki9cH6SFxCjZAeN1CsvM+9fAQJY9WXGyS5RtMyB06yOrJxGJGEJvubkjmpB9fU7NXuMR7bkmmURgdmx/3NE5YV9eZJYD8EOuhCMnCfMgicPvqODGhpj6ygyk/ivnZxvIfKpYJl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155625; c=relaxed/simple;
	bh=hXIdIXvCKbLDAPCar0Pi04s19BKNkbla144ciVuO/B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9VizjTysLoAJvkKJDbYENYgLLNrB0KFNAPiabcqVJt9GS2TFPRq79Smdc99aGQpBOGRVIpG2a7IBTOgfKT6P/BFcDSiG6rYYPsFoS4grAOWdlBnowcVtPEvWrv3pIQIJ6Cw9bYEnaEpqm992DewEdNG2MexF0XK7n7nN2nOmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7pf7akY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED067C4CED7;
	Thu, 21 Nov 2024 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732155625;
	bh=hXIdIXvCKbLDAPCar0Pi04s19BKNkbla144ciVuO/B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t7pf7akYGWyoXVoL6UhOHz7C9ZVyDJybVBPZUnbyrhKI7BOo+3w4pSxDbQyzmKAOI
	 A8/6sVocJCKwdQQGUaHk/VlVsQb1Lkesg4fjLETWsRVHJcrpzy19kcErKiKq4vJpN6
	 QJZLqmLCrlaw3a0BW/JPc4xj7zktNzCS2RMHJxPzSJrT5Bsr2fPWHHTuTQPcBRq7nE
	 HVjCL5MNa10/JVkeOFu3R7E2vhiL6ZWitRzRtQ4YUxG/BFO0XbYDRnjq30bjURT57n
	 oU6zkeQuOF4IYIwm5xDhRYfr9JaKxFVRSjJKnoFh+hQ2aLox5XY6aZVTahvMzDzeb9
	 uWb2+MmsO2/dg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so73219366b.0;
        Wed, 20 Nov 2024 18:20:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV10kAJrW8XuNeaqvVFfpvgYELqDJztKvr4QAQSohdJviHM5jqfzrwMwO9/bRguV+WVsXrW4OMPA0uL@vger.kernel.org, AJvYcCWkHpSXuD/ti+8fOQM20tH9JDJjrqPkinZahrxmssoauvjt/Pb0NyR3BLwaJfFRlUbzOADQoX916GY1PQod@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzOsngYqPAWrNNmdBmDXf3FJUS9FKwU9ChqIH8xJRxKZgALSz
	xnfF2u/b+/TdY8Wh5zmcSDxwlocUDXNlmxyTahRKqMkTiCY0yTsQSyTFvw6r+SStjE7BQ0FMGQj
	pYjwdPAQD3W9fU7FaihhZlWmo8WU=
X-Google-Smtp-Source: AGHT+IEhawZBFThkaFlUvFNRPz0xfSg2P3rqt12Is1oSMAW88NHLy/ssUzi90bGeOR2ozWJHrhQGfvzpnNDX8R2GWtE=
X-Received: by 2002:a17:907:9715:b0:a9e:c341:c896 with SMTP id
 a640c23a62f3a-aa4dd59f5femr465389566b.32.1732155623468; Wed, 20 Nov 2024
 18:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c09168a6-23e7-40fd-afc2-4c3ac6deaff6@app.fastmail.com> <173214663696.1393168.4436714062176910731.pr-tracker-bot@kernel.org>
In-Reply-To: <173214663696.1393168.4436714062176910731.pr-tracker-bot@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 21 Nov 2024 10:20:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7VLPngEb_pxs4Zc4OX3i5X0W0Ao=7qFhY_PMqyEBVjyQ@mail.gmail.com>
Message-ID: <CAAhV-H7VLPngEb_pxs4Zc4OX3i5X0W0Ao=7qFhY_PMqyEBVjyQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.13
To: pr-tracker-bot@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Julian Vetter <jvetter@kalray.eu>, Nicolas Pitre <npitre@baylibre.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh, no, why the tag name is asm-generic-3.13?

Huacai

On Thu, Nov 21, 2024 at 7:50=E2=80=AFAM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Wed, 20 Nov 2024 23:57:18 +0100:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git ta=
gs/asm-generic-3.13
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/79caa6c88ac484111b24488eb9fe1c86a3d1801=
6
>
> Thank you!
>
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/prtracker.html
>

