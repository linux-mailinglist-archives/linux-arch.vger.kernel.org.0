Return-Path: <linux-arch+bounces-5294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17199296C5
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 07:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58242B20E42
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70A79E0;
	Sun,  7 Jul 2024 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+0bs7dI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201DAD24;
	Sun,  7 Jul 2024 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331964; cv=none; b=djZe57k9tb7gRYh9EpGM+/t3GjpwaQctmfDMXtZEcOtN2a5ELTeeK0nDNB+b6JIe+97+YRZFC6YYyUHUXTI1/eaN2NaYH0lA+T+p4ujscrUrTmhiYJ0f+RDPEHI3+F5P7tQYiaP0l2SSDkMvjjcFHx/0AbwSHH2U6msvPTv8u80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331964; c=relaxed/simple;
	bh=Souahe9tmKRZ29JP8McuBBsQCwArtB13MA5Me7subfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKrIqghcJyn2sH3l6Xn3/hPCTzNPh9hMbVn1ed0t/dZWK/0d+i/pgjTkn2KG6L46whFWfA4P2XwtPXeDmeRcDBEfurxN3Nrj7YefqR2Rg/ypdWx7cFvV/7vr0/g+MxsXBiTGbDebBBdP4KPxxEM2Jr2opElpSjpzpUkZ71G/RDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+0bs7dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8EEC4AF0C;
	Sun,  7 Jul 2024 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720331963;
	bh=Souahe9tmKRZ29JP8McuBBsQCwArtB13MA5Me7subfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G+0bs7dIgTz04LpiO0Iqjg07/+8M+5nIGQcW2RTrA8bMg83F1P4ZnB9aTcjLOKGx9
	 XIwZ7jV26YpsGgCfbz2hUFYzdgK+OQE2YzfYNlmeuTFTo0LmSJPlcYJaJai/dyUMPn
	 VsQVHpwUpQYAZzyq8qBDDuSP3Haf79YerhIWc774oYA7hkMyfYMOKBQaECKB7QDfnp
	 Wx39fp38IO9dcEcxKQ9uTeF+fqGZ6pIOZCvNNGJB/TUub86NOzvOUkzy+63TqsFFbA
	 pDs3NzdfLiu7xSuzf2QVXqrQZ9oo4z6c4+xQQvgkwKWFP5CN6IQl8JBsWX7fvhT5Hk
	 1e9VBJy/LBlXw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea8320d48so1152910e87.1;
        Sat, 06 Jul 2024 22:59:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXscOqZOwtlrKGONu6GHtgEeTV7uT0K7Ptck+iCwMxrU1TJ0HJgQKJ+xl5xkCDpnygkwxe3eInXRUWAbsUxGLMPD2mAkInT7823lqO9YrO7oA5B6E4w7Y/JH/JcA6Hnc1dybOuZ4YK5Zw==
X-Gm-Message-State: AOJu0YxNRvXTeXCqPmjpFzuGwXQn+GmWTNKga3rqvm9qIkHvQQULdPP1
	jkd0CGuVKP+hsCaOjENgxBT6Ky4//Bq/QxzHZY4EO3svacUit/JD3unGMfTJbg9lRVlwgDjW0MH
	/CF3FHHDywxlS+TxfrkkPdAbi0+o=
X-Google-Smtp-Source: AGHT+IGqKpmq9RauJawwf+Puf56sdjbnUc7rMNCyksTeVaTLeFNdmXhAg3tSMSXmfMoM/Y01GxKm59qa4tjr/PcgscA=
X-Received: by 2002:ac2:599b:0:b0:52c:81ba:aeba with SMTP id
 2adb3069b0e04-52ea0de4274mr2387155e87.14.1720331962185; Sat, 06 Jul 2024
 22:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706160511.2331061-1-masahiroy@kernel.org>
 <20240706160511.2331061-2-masahiroy@kernel.org> <20240707000117.kpotqs3xgfrtllzd@master>
In-Reply-To: <20240707000117.kpotqs3xgfrtllzd@master>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 7 Jul 2024 14:58:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBvP8gawg5XFxA=mVRNMgTkYBnPtG+R4e6W6d7BHF3bw@mail.gmail.com>
Message-ID: <CAK7LNAQBvP8gawg5XFxA=mVRNMgTkYBnPtG+R4e6W6d7BHF3bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] init/modpost: conditionally check section mismatch to __meminit*
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 9:01=E2=80=AFAM Wei Yang <richard.weiyang@gmail.com>=
 wrote:
>
> On Sun, Jul 07, 2024 at 01:05:06AM +0900, Masahiro Yamada wrote:
> >This reverts commit eb8f689046b8 ("Use separate sections for __dev/
> >_cpu/__mem code/data").
> >
> >Check section mismatch to __meminit* only when CONFIG_MEMORY_HOTPLUG=3Dy=
.
> >
> >With this change, the linker script and modpost become simpler, and we
> >can get rid of the __ref annotations from the memory hotplug code.
> >
>
> Oh, totally get rid of .meminit.*. Looks nice.
> Maybe we can plan a __ref cleanup after this on is merged?



Yes. We can remove __ref.


All __ref annotations in mm/memory_hotplug.c will become
redundant.


--=20
Best Regards
Masahiro Yamada

