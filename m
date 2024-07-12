Return-Path: <linux-arch+bounces-5377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727092F725
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAD928281E
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74551422D0;
	Fri, 12 Jul 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoECx6WJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4165635;
	Fri, 12 Jul 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773875; cv=none; b=WmBMY4rkgpM0mIFZpWpo+0PTTH7680TV961oc/S3ekIkEUvlJMff+GbxPRso7danAp6EQ61BLfcZRfAzYKgmNAlI4eUGo786DXhmCebPLM8Hs3G7dsIqKQ2E8lJy9mJ9Bsrp7ZrwIJtQ8Ko4eMxWsIhovJi18a+R6PtwcusuHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773875; c=relaxed/simple;
	bh=NumRR0RCvVDFyEdBAXLJ0YgPft63M41HMl+6GgZ3D5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9GoPBG9wyxniyMd+x3MkYyZPJNOLEZt1NQaLtnwp8amSY4i/i4Xr3y/pXF8dNeZjxOY2kzD5qY5JRhn8JBtoEurgwSYZq9VktDyVLEpqymjoWEscTsntRscJNeKmvVw6K0WQ1ptkpSfPkti+QL59ZDtIYMs4OEnP2Ngdb3wVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoECx6WJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F34C4AF12;
	Fri, 12 Jul 2024 08:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720773875;
	bh=NumRR0RCvVDFyEdBAXLJ0YgPft63M41HMl+6GgZ3D5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HoECx6WJPivcwwOtmNO4WSnbKAxK+F1X/nIXrzqX7I2ClCPkenzPNgmgcxWYnNNTr
	 +eHg7IrEnrrU/XLq1PPYujLigkRRFnsFiBFJz3EKMLz5DZuqO3C6EIsJ0R7fW1UHFY
	 d7WfuSsvFL5h3n0uFcUqMWlc6R3aYc3tyfYMvM6/pp8PQ4mTGG56Cd7FDkiUCrtdB9
	 3Rq2+EUgfhUEvAU/s0ktnei2dq/hiFSK00QPsG+dqzs0YXk3HdpH4FBb8Egjw9bQBk
	 7YjnI+z7hm91e30k8L//zRdR12FJrlJ8KbkH8Wogzh90Be8QJ9tcCXFGsdizyBPFNA
	 Mc3hJTqf71MUQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso1973939e87.1;
        Fri, 12 Jul 2024 01:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcNLuTlR8RIooFIhDz58+7/TH6WJyRZXXe5mo1VRiKlKjT3Vm0EHyFrHGTt61wuCinMFcHdVcxxNV7SxG2c1EbE92WAIM8ZmumP5LgYomLg0wBALmT8mWWm+K3hWoBinBIFsFo7inQvYarIHE/JPbx80CYkLM6k/qJ5YwdKs3WGEMtY9Q7rV62AaaJOTlr+pURMywP4RE7jTV/jPF4DoQn882xJFftwHzc2NSJRNgePNh7+KXiWvQ0thgsR/0GZbvUIqmtDw==
X-Gm-Message-State: AOJu0Ywj6QZL/NCvEZTM8ojdngJQdnf1GoJ4HiWQTqgLBFJGkhKgIrUe
	pFac8jwGOXe3aa7Pks6n4QXPAPGUQp4S/0QenhzkoKGJqUHSahKtVV2vbVahKBzQ5HauxBcxf35
	02fyskksASZLakAZodAwamW506wU=
X-Google-Smtp-Source: AGHT+IHZKCf4H2Js0tpWEkxjRgvOVSTSmHh2++u39t+AXmtYzsuw+IcCP9SIl21t50d9MSfsFywqiN6yBQKVqEDvNIk=
X-Received: by 2002:a2e:8e8c:0:b0:2ee:8698:10ed with SMTP id
 38308e7fff4ca-2eeb3190d76mr66407281fa.49.1720773873600; Fri, 12 Jul 2024
 01:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704143611.2979589-1-arnd@kernel.org> <20240704143611.2979589-2-arnd@kernel.org>
In-Reply-To: <20240704143611.2979589-2-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 12 Jul 2024 17:43:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpWB6Pqa80KDmpdJ_Rf5FZc71_bX9eSy3fFVCAyg8CAg@mail.gmail.com>
Message-ID: <CAK7LNARpWB6Pqa80KDmpdJ_Rf5FZc71_bX9eSy3fFVCAyg8CAg@mail.gmail.com>
Subject: Re: [PATCH 01/17] syscalls: add generic scripts/syscall.tbl
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 11:36=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The asm-generic/unistd.h header still follows the old style of defining
> system call numbers and the table. Most architectures got the new
> syscall.tbl format as part of the y2038 conversion back in 2018, but
> the newer architectures that share a single table never did.
>
> I did a semi-automated conversion of the asm-generic/unistd.h contents
> into a syscall.tbl format, using the ABI field to take care of all
> the relevant differences that are encoded using #ifdef checks in the
> existing header.
>
> Conversion of the architectures is done one at a time in order to
> be able to review or revert them as needed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---



> +65     common  readv                           sys_readv                =
       sys_readv
> +66     common  writev                          sys_writev               =
       sys_writev


Nit.


I know this is already written in this way
in include/uapi/asm-generic/unistd.h, but
the native and compat have the same function name.


Can we simplify it like this?

65     common  readv                           sys_readv
66     common  writev                          sys_writev






--
Best Regards
Masahiro Yamada

