Return-Path: <linux-arch+bounces-9236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0269DFBF3
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 09:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3312E2819DC
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B711F9AA4;
	Mon,  2 Dec 2024 08:33:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912513635B;
	Mon,  2 Dec 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128416; cv=none; b=ta5kqXKZeA1yxXGaYCGxa9Nn4dMQjws6umHKbgnKGu3qOA93a/qni0T5/xxhTFZbSIRX1gJ6Dc+2lyAMyzFiRmCqz7zyy8hzMnpeFL3VLULjJdPlOl3zoHwKu96m8yk7liE/XBK8qyPnTpAjCcTFzc0eTpi3WpXu1D8RujfeDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128416; c=relaxed/simple;
	bh=C/1t7RAVxcu8cEx5/wcDw0LInPkx6rt1MttP1kJMsi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooFaCjOg3SHCW8Ym1yKbgp3ikRx6Bh7C2Drydqm0pzX20IqotFL79d324M0RuMnxIsGNyDvyOBPSN1bK1uaVqVl2UInSlhJLBh1i2dKgvNPkvzdbjoF4rpYX3OA9BAcDCLyH1UR4vqu2wRBWj7y+IKwsgiPpeZg4o74e3Wi6284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51511a1bd53so867951e0c.1;
        Mon, 02 Dec 2024 00:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128412; x=1733733212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u56ZXLj3zoJcwhJCVeWsy3FmczwJw23Uyl3fWwY/H5U=;
        b=AxJ/glDUlfm0uTaBSuBtLLD4DdYRbzJOQC6plPp5s/UPn87PazKgWOJ/xV7nvSJVI2
         r6eu1KRsz2O2khU4pig+XO/g/XLxbIjprTBrtS6Nmiq31Yo9coTcOVHo6jDn+r/JhsFf
         2tTtlI1u8wkK2UZV0wrZNSQBFtzcCocui0XHbg+H54aE4CICKzy/vnv7u1HTa+M247Lq
         7Ut2X/j/1TIjiZOIWEUP4/mrBOAfkdEpFnbwK2a4ToVRXSV8v/BZhF+2kfl6M5lJV2em
         NOl2PwOnFli5fpjSmp79ePo8yprumLB6LEHTq41OvcmhKY/YpNKE6ivB/depS+dQT4xV
         6CtA==
X-Forwarded-Encrypted: i=1; AJvYcCVwNi83qnoZw2j66srwZ62UPfGc4i3j/o+K5aAj3HLMhV4d4ah8+um9kLI+Seezia911KCZ1FijT3IJmvak@vger.kernel.org, AJvYcCWCijRn6faq/p9X/cbM2xfU2fr3W+qta8AKoqF9YfsEY5Pzo1Ci3voSszdq5IPFZB1p005mFKLMJYoE@vger.kernel.org
X-Gm-Message-State: AOJu0YzSI66Ig5SyY2POrh+sbh/81i4HqBJNihxHqaeYwDsTNCTz/yoa
	IF4LDOkECyDPmKCbPPZXd/LIgnX2bISrddiGBEUrSk3uO7ijfNpXh9ci4f9K
X-Gm-Gg: ASbGnctBpwYAzQ4BnBUgoT9ByW/VOYmwAkCulZ7bZHPxvcoEn71haabl64Mrr+TJTAy
	EJW9L/p1V6dkdflaCcqzGpHcUlYiARtzkiArfQF0fxBR+U2QOGZMPeP1pcbiqaItBb6XlNz9p7f
	9nWTTP4MCfAHCQmxMkf/CRwUM34B8op7023TYYCalYv2cnVa8y6fy2glKcXceHTM6nyKjNXIgZf
	PCwUF3gq0iGShmlYkr7rUrOm/vl9DNV+L+e/Cww3D3+L+I5mSBdAjXSpnaBx3T7lhG/neKx6f6T
	N4bQYyUuCZp1
X-Google-Smtp-Source: AGHT+IG63Qbab/vg2aOfnfSvWOOBYi+Yu5tWITzEQ4bH4MB0xCs8UWR1H6DBzlHoeHvGdys5PiauLg==
X-Received: by 2002:a05:6122:82a4:b0:50d:4cb8:5aef with SMTP id 71dfb90a1353d-515569cc723mr21531570e0c.6.1733128412070;
        Mon, 02 Dec 2024 00:33:32 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0f6ad8sm1077681e0c.51.2024.12.02.00.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:33:31 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4af638e3e66so700426137.0;
        Mon, 02 Dec 2024 00:33:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVadXCQImLwKV3R64uxXDtF2wh2X5KDjG+Bb1WhxHPVUvOzod3b0DJgvTQORpz5AEzXVlG0I3wo32d9@vger.kernel.org, AJvYcCXMlwcLlRUSTnIxeG3LvW8x9i+WYWWqrU01JupOLIQJ0EH9V+DUWqe3YGGs9GN2qAFCxcweoawB+sNk3KF3@vger.kernel.org
X-Received: by 2002:a05:6102:954:b0:4a9:5d98:6c5f with SMTP id
 ada2fe7eead31-4af448f6d7dmr26891641137.5.1733128410739; Mon, 02 Dec 2024
 00:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202012056.209768-1-ebiggers@kernel.org> <20241202012056.209768-11-ebiggers@kernel.org>
In-Reply-To: <20241202012056.209768-11-ebiggers@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Dec 2024 09:33:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV5rQggS9YHMJfU0gdhg6oFENTnPKp9Tbp3sJKgQdnMTA@mail.gmail.com>
Message-ID: <CAMuHMdV5rQggS9YHMJfU0gdhg6oFENTnPKp9Tbp3sJKgQdnMTA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] lib/crc32test: delete obsolete crc32test.c
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org, 
	Zhihang Shao <zhihang.shao.iscas@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Vinicius Peixoto <vpeixoto@lkcamp.dev>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:24=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> w=
rote:
> From: Eric Biggers <ebiggers@google.com>
>
> Delete crc32test.c, since it has been superseded by crc_kunit.c.
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/m68k/configs/amiga_defconfig    |   1 -
>  arch/m68k/configs/apollo_defconfig   |   1 -
>  arch/m68k/configs/atari_defconfig    |   1 -
>  arch/m68k/configs/bvme6000_defconfig |   1 -
>  arch/m68k/configs/hp300_defconfig    |   1 -
>  arch/m68k/configs/mac_defconfig      |   1 -
>  arch/m68k/configs/multi_defconfig    |   1 -
>  arch/m68k/configs/mvme147_defconfig  |   1 -
>  arch/m68k/configs/mvme16x_defconfig  |   1 -
>  arch/m68k/configs/q40_defconfig      |   1 -
>  arch/m68k/configs/sun3_defconfig     |   1 -
>  arch/m68k/configs/sun3x_defconfig    |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

