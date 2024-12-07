Return-Path: <linux-arch+bounces-9301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7E9E8279
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 23:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB941617AA
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278901537C6;
	Sat,  7 Dec 2024 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF6lRiwV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB683126BF9;
	Sat,  7 Dec 2024 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609875; cv=none; b=ELlipY/OADQfDl813wunZIwd0dBKaYddLxW4iYVqwG4kPRGhg9u+hd4vOJ6J79FPFHeBbDTegp0FgiMa9W3JfDXkgVUY2D7O2IIQAIthCUN/Gvqbcfx/GYtXLL0PwylkdBX1/S00HwFNSes5cKcFlEk9/nKI34hGdfxWYwBOadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609875; c=relaxed/simple;
	bh=BqwKwMO341fQMxnI16s9Indc0ImUaaDExgRgKT2knn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoIUKl62WDVRAzE7+bny9RGJsKtP2BanMA6lgp0le047fw5sAO9rOgiT6fuhi4tyli9OmC0MnZhT5ADRwvTsJX0TSGQbdgNPIfxVVflWEpozlUwVDX+5D9tetwm/Rb8zHdpwWdWnZOAhzA/edRMZGX0C0ZhtJr1+hI0+0aJfRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF6lRiwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ACCC4CEDD;
	Sat,  7 Dec 2024 22:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733609874;
	bh=BqwKwMO341fQMxnI16s9Indc0ImUaaDExgRgKT2knn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RF6lRiwVKtwa8ayPbCqQnNg/WZ81ZibVaF3/Schw9NgKk6qSPjXRGAnkpDkUZ9PD8
	 27RvV5nV9/xvpqlg0XVekHyrAtCWrJ5dBx4Qx72RPbvVcF1h39vUlueuDK/wxWC4n7
	 Rrs/omfk3wX1wwrOFVfpg0Rv4tEnXDNCGSytDNCmiql9xCCnlRNoW/DmFNJeARNAD4
	 DEKULR2h2hJaF0w6LbYUlk4Jn3m7eN34PWvLbavSRoin1C+4UYqdaGEm0BRqBy69uf
	 2M9TdQxY5IedoEevoqDhAKPERDpAmvqzSmWLLjamfu8UGLU7tVRwSdpQuUVb53lr+n
	 ef0O7+PNsgf+A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df80eeeedso3199976e87.2;
        Sat, 07 Dec 2024 14:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4CXo4aQWNiHwMbht3px4quWOzRvQMDFCCozaLbRJq8zBjnhUYBwDEyoI2bN8RFXqeRAbej3XEjOd6lP+I@vger.kernel.org, AJvYcCV7knfEUWVwMuPYfP4P/aQ8c+colRmZ8uuvXGBfeXuB1jFpDDEgeN4c25jmaSRgTsudfBrvfroaV803Skdh@vger.kernel.org, AJvYcCX/kK0bWfZIJs23shnqNhVw3uhzW53HKB0hvRQk2zjFISWu+77ZuIpcIyrMgRruIi0mcO+AJdeY6yJD@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYOYYmeU/J4pw7RH1W8dOl+iIYQ0mCne+BCmXmQ3WeOpF2iBz
	xL8kT5rOnSC8WIeuBjKVUGkY2F21wgCAN96uEJyVvVDy4VvbX7DEZTYfDufEObEJOARQ9+z/Wza
	EL1UQ8h3s0AhFOiDuTV2pJnUE9qU=
X-Google-Smtp-Source: AGHT+IGlkeqOENBomT2emeUeaLEilCldgRhpWtFMHdv5OeNMylhMqO+ydAP87PnHBTfKb8fUuSSKgY3QkUBnq3Dlbos=
X-Received: by 2002:a05:6512:159a:b0:53d:ef49:5b5a with SMTP id
 2adb3069b0e04-53e2c2b19cfmr2017761e87.1.1733609872950; Sat, 07 Dec 2024
 14:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733404444.git.geert+renesas@glider.be> <541258219b0441fa1da890e2f8458a7ac18c2ef9.1733404444.git.geert+renesas@glider.be>
In-Reply-To: <541258219b0441fa1da890e2f8458a7ac18c2ef9.1733404444.git.geert+renesas@glider.be>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 8 Dec 2024 07:17:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7-M6MOCJ9qktBQQziwynk6EEMaKpKJkaZDfKg76KRqw@mail.gmail.com>
Message-ID: <CAK7LNAR7-M6MOCJ9qktBQQziwynk6EEMaKpKJkaZDfKg76KRqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] include: Update references to include/asm-<arch>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 10:21=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> "include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
> time ago.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/asm-generic/syscall.h | 2 +-
>  include/linux/bitmap.h        | 2 +-
>  include/linux/types.h         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)




"git grep include/asm- | grep -v generic"
will find more instances.






--=20
Best Regards
Masahiro Yamada

