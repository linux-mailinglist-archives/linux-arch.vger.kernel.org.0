Return-Path: <linux-arch+bounces-9958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A7A24BC5
	for <lists+linux-arch@lfdr.de>; Sat,  1 Feb 2025 21:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8DF163EAA
	for <lists+linux-arch@lfdr.de>; Sat,  1 Feb 2025 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD71CCEE9;
	Sat,  1 Feb 2025 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UUTioE72"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76431C5D52
	for <linux-arch@vger.kernel.org>; Sat,  1 Feb 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440622; cv=none; b=bSDdyzC3FugJzlhYXT5Jscg3w2NCxhZZS0ElM9+FpJYoYUfXguEBAFiEaNn6hTXfgofQ3O1Ng63F8f7FokaLDF2hRBWYz8TFSRveAMolpuuUqqLKoYKsYuNJum75SS1eAk9uqSGt5hHIGG/758c54pBqB2jUo/NNvuM7IVaJyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440622; c=relaxed/simple;
	bh=dwKZ9e6C8H5YVBM0MWljIbNoLbFovSt/j2W45tqojAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaD7CUnAbpyG/1PkAkjH3GZ5AzB07Hoq7moZwshJuJQrqT8FJYASeMoyMalBd44qWfJ9bYoVbWDdq6K7Hv/QnMzL2Bl2Np7ScB2rSLXmJlgnQfWY2PWJ14menbVJYyZ9u2CBleEw8YoRwzwxfkhUI97GyZCv2KPzVU9ktJ6acE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UUTioE72; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab651f1dd36so643104966b.0
        for <linux-arch@vger.kernel.org>; Sat, 01 Feb 2025 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738440619; x=1739045419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7/IZGOLu+lbC+EOSNvACW6MUOzlKWZfo7umiRgi7s4=;
        b=UUTioE72YBFF+11yoHXoPSMobUlakX1xOlYfKXLHeVpUPIr35p04lH5DvJQDfeiFAf
         K2CwECDveZcARygvC7eq2EOoeqZBZk3/9JL5TLMP8K/H0W8ykpw3mcTaFtxv0V5doE4Q
         R6qqaK0Pi1EHyLLK8wSRYjTUsRnf3VR8e6ieA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738440619; x=1739045419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7/IZGOLu+lbC+EOSNvACW6MUOzlKWZfo7umiRgi7s4=;
        b=uAi4bgnrjIE9+nrnG+advLP6kLj6G4vjZJ2vASw13Kie4sf1yk788QH4VR0oCqjGLo
         nxFT04H/KO3BGn1CoBAjTSEYG6uGTrTMSD482S9zRCI/kJDXvdUXLBKMPZI0ZkpsilKf
         x301bfwTIuiXvmDXDbVx6aBGPfa7wt0Rutom+Yda0ZgKMmIxijKkzvFQ4wkFK1lYOxOE
         4ve66le7RwjzVSiR0mE4dMNa94xGMiRgC0hjQisgv0AGA0tlpmeH41ptTY7Ba4BZRcu0
         PjtbvUybrpfA/+E0sZDX5s3jlj5br0aTaOTdM4I3Dtugm2+pbF+3IDzPgKZWoVIwoV96
         J3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk+0M47VQ+6BBztVIjiabXLMeRIQQ4tz+n1Yk3LCEhTrf35MMF+H10JfYcJLSlF63V/6iG3oh8rlu0@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXNojesImCuqOGoUnxgH9AzjEVPLNrYB9r69HMbSPP7+KRrSt
	otrSveJRFWfsdtJn2ZM4E17PMwMCK7nIa1ZcFY3jI5iJiFBjrqzDORJjZp7aAPms+pmwM18MHt9
	PtC0=
X-Gm-Gg: ASbGnctOsj6QjBVIQOkvnHCZAGsvEnhd6cxWF+xr9kDlCClTX24M8itFSCu7dHL2op7
	+2q0ZkykXsUFg3L+e+RK4W8gpC12BaYTJ7h90yiOLYChWgAgQddVfGv8JvzWfznbM2zZwqAT3OB
	v5vaspP4hVI8mhqkywYPSbOPgM0BhXQRdgwRQcOFIjBDf5PyF9fbJI7dLXQNB5DLZ5msOjeUrXu
	8LAaAThyjbk+I1mdLSyjrV19AzkdnIlGozqPK3bplySPrDG/ocMRJydgMRFOB7NbQkjgul3HXKZ
	11O5x42F1TliyDi9WcZyXMF3xJNUVRAWR4jCzoZVgbHstoRo5VV2i9w0Y/OLNzblwA==
X-Google-Smtp-Source: AGHT+IEotNbbmBi349ZOwIuvnvsDwHCOBFWuHtX2u5G3kJX89qmdGIm4gAFtSC09pYrTFlLowbTCrQ==
X-Received: by 2002:a17:907:7213:b0:ab2:d721:ed8e with SMTP id a640c23a62f3a-ab6cfda4266mr1517344766b.39.1738440618704;
        Sat, 01 Feb 2025 12:10:18 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff3d4sm477657566b.112.2025.02.01.12.10.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 12:10:17 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so6013023a12.1
        for <linux-arch@vger.kernel.org>; Sat, 01 Feb 2025 12:10:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1J+07G9kSjL/+jh4Klv63ceglzq5SkGJNXAywcfcLOcagdYoKU8Y5IyAxWZ0tqMKPL9uW24vmEsI/@vger.kernel.org
X-Received: by 2002:a05:6402:270a:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5dc5effb6c9mr16000184a12.32.1738440616999; Sat, 01 Feb 2025
 12:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201185143.1745708-1-masahiroy@kernel.org>
In-Reply-To: <20250201185143.1745708-1-masahiroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 12:10:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWTPjGk5BDUu-49LeTAr21qurcv9BnjmrYi=ZqbFfufg@mail.gmail.com>
X-Gm-Features: AWEUYZlBdDHAj8QtpERwR2LQThxWjeLDU2DywKdmKDGbnm9LYxABBIuPfrICgqA
Message-ID: <CAHk-=wiWTPjGk5BDUu-49LeTAr21qurcv9BnjmrYi=ZqbFfufg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 10:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This commit addresses the issue by leveraging modpost. Symbol names
> passed to symbol_get() are recorded in the special .no_trim_symbol
> section, which is then parsed by modpost to forcibly keep such symbols.
> The .no_trim_symbol section is discarded by the linker scripts, so there
> is no impact on the size of the final vmlinux or modules.

LGTM. And I still assume that I'll just get it in some future kbuild fixes pull.

          Linus

