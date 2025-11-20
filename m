Return-Path: <linux-arch+bounces-14982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9BC72BF6
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75EC64E3540
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED01DED57;
	Thu, 20 Nov 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2OCf8V8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FE372AD7
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626586; cv=none; b=DGytqDhVCKqo/mPCgNLyoSH0vamnCSzduMT2qMiHlcerrJz1pTeAxekTI4+jNG/FXHTlojAIa/27snRzX9k19cHfUZv5SwH7/sPgoXR1/xX4TSQWhkKCVlh9xaGefYLt0FreJEaRrnuxRI4XmQYLBQeTs21NG869Ain6FRUmaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626586; c=relaxed/simple;
	bh=9VmKx3DsKgccHbRLWpfhAqN6UYvAPmeZ2H8WDGmj584=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoVMM+1rjE3/kc8gdn18JMD/6RANhr8UnCUK4DLHBfR4epm4UobHm0x+xNQPD0jd3MySaX13rYiXPKy+G8tohLfge3PF3CdYIa1pqM/2GuIwhJ5jp0smO5V3pN/Y7tUeBin6KdUIov6EU3ztNzou7Rl/yaf/5inLH1Ochz6qNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2OCf8V8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74D1C116C6
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763626585;
	bh=9VmKx3DsKgccHbRLWpfhAqN6UYvAPmeZ2H8WDGmj584=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R2OCf8V8n/AVVTmewIK8wGhN+MJ4LjCRQotC/Kl40ug/wluvo1RQ1d0QxHFar22jo
	 nSPJFn/Q6hvjGA+WIR6ogG7MafAHB5leeNZvr0IdUnsSrC8lpZ7vNQdS1gHN5ao65Y
	 B3U+uFFW6ATLeM486n8baDozMyZuY+DxfBfUV+ZQFQUO9E7WQ5+4SJSivc2oHfHMaR
	 i8sb0+UPah217KGVqvtjRjyoSWFe9fhtEjcvAjtHU7d7bMdaspo1nS//wg1/qq1dJR
	 Giwo0Hcr24MJJeBeYejQilg3vHJ6Yo36JNBajmydz7Sx1pRoO1ZhrzAHD3109310qZ
	 YRR4HHRotr6TA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73545723ebso116094566b.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 00:16:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk+Ha8Kjl/LQFKtXQ5gtnhIKFHFBS6Zgd8lLqQMD/mMpCHmVDx8MtDX18zREpNX0K/8VaMsUUHyb5h@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaUAf19v7qHIGJLiRdo3yJRSdzspTAx+FM82t+16wnu2fj8m4
	dbEatrttodpS6OV3ajo/smCVDg44u1krU+DxVKOaggfWaA/QHLQwou00pTD6v+hXhTyZo85i8wk
	uwsbT0r9bwSBHMdHSh1BJOwUcbNRqtb8=
X-Google-Smtp-Source: AGHT+IHOAOXwgs9uq6iC/8iC5U2DujvoLlpN3kPnt3j5x/MXN7Xw7n2tHkKvyHkCMbQZ68l4jfPJfjD3DGhIDWmLWig=
X-Received: by 2002:a17:906:c109:b0:b72:6b3c:1f0d with SMTP id
 a640c23a62f3a-b7654fc9810mr269896566b.35.1763626584534; Thu, 20 Nov 2025
 00:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn> <20251120090846-746f973f-e08a-46ab-a00d-87a5be759941@linutronix.de>
In-Reply-To: <20251120090846-746f973f-e08a-46ab-a00d-87a5be759941@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 20 Nov 2025 16:16:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H52FAORNDM48nYjQUWjnDFxc7+RGUsOW+JNteJrpbF6ww@mail.gmail.com>
X-Gm-Features: AWmQ_blKyIOJ5f9QG9XluvZKGjOdJIlJwU5_bDSgd8PEpdPgCaKn1AkBGV3rxuY
Message-ID: <CAAhV-H52FAORNDM48nYjQUWjnDFxc7+RGUsOW+JNteJrpbF6ww@mail.gmail.com>
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Thu, Nov 20, 2025 at 4:11=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Tue, Nov 18, 2025 at 07:27:27PM +0800, Huacai Chen wrote:
> > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> > loongson64_defconfig (for 64BIT).
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++++++
> >  ...ongson3_defconfig =3D> loongson64_defconfig} |    0
> >  2 files changed, 1110 insertions(+)
> >  create mode 100644 arch/loongarch/configs/loongson32_defconfig
> >  rename arch/loongarch/configs/{loongson3_defconfig =3D> loongson64_def=
config} (100%)
>
> KBUILD_DEFCONFIG also needs to be adapted to this rename.
That is done in the last patch.

>
> FYI the cover letter says the series is based on v6.16-rc6, but the serie=
s
> doesn't apply to it.
Not 6.16-rc6, but 6.18-rc6, and the next version will be on top of 6.18-rc7=
.

Huacai

>
> (...)

