Return-Path: <linux-arch+bounces-9087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377BC9C90B0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 18:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1F8284ADE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D968188735;
	Thu, 14 Nov 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RjPt2Oos"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FA24B29
	for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604914; cv=none; b=P5wfwk6+mdyVV5XwUnlxV9+l0lKHJBD+uF/MIQlJQI995v4fP67qV5RwXRQBQb3YEJgqMlLLNoW0ZH2CdtKfOpgi8ZA+BgxvPkoPDrKfNNsfIplgtPluvmdCVARm3kcx64u9LWd9CT5OCrompsujJC4HiX77EwNWhXOY6jzn6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604914; c=relaxed/simple;
	bh=ooLd2KnZY+iAsvZpcBbhlZVOlUE4xC2qvGpPzxWgCOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWdMLSyQ//Dn8e4489XR7mbkdsmda2g6oyvzF/K4mpihQefO7xyb7cNyLIvjOGM6Q0n4SLCCU0UJuHBVzqBI3OoORZmqlwHzQ3C08s8vHM31Z+m9nWyAm9WqgPtXW2MfA00X/ksuiShPmNLjOqPEco6A7ERc9QE+XdpwEmyzlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RjPt2Oos; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso15296481fa.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731604910; x=1732209710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hn1K0JlF2yxtKRDiqqXBoVLBpc9QBlyQWe6RfRYuPk=;
        b=RjPt2OosW4tTuisFytAmJXI6hI/1h8x0KHcPMWz++mvsf60ehqR482g3KCqm1dW1/9
         benqXxEjyrEreMhMDAAAjJKtwaD/sPNFawvZMhr/gfR8Bpjt2V5aQH9GPol+5IoDPm/L
         MC8lDysVCBF3quLEnuMtDwMsYELUtLIm/QYmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604910; x=1732209710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hn1K0JlF2yxtKRDiqqXBoVLBpc9QBlyQWe6RfRYuPk=;
        b=iqpC1rR7/P5Ad7Qm2re1kfKeABMaWuiBGu8DjMq9xVSKiV3SSR1tZrn/Nkl1dtkdj8
         HzpX7SPSJ9Dj7LGuBF2ziSKUAX2ihmSHplh8na75TTffIJ6fgWaE9ErJTJK69fI400hd
         jQOoz8jZz0+vESg5b9YoAV+iTK8g+ASjEv734wO2jL2C/kd6Cu3Mwe7JKM1kn+zQilQq
         INzc2lniPySRPKzstg/npoExKoOhLiWOWP095NexQhcd9YquzElZMd80OhU31QWsvcbL
         0dSheJ3XpjHxG3KRT9i/d+sHDVeWVaZ1ny1iT4a5PXPuGT5+zg2xbngqUTJefY1GKSDG
         VU+w==
X-Forwarded-Encrypted: i=1; AJvYcCXwMheEFkFU3Sim1wefKhEGIBB0Xlo/TkiaMYWCHWuiXNvAHz5ov1Gjs8ylRkRYDFFUIJv0vo8lYt0t@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSbdBPfjC+WizshPRs9Vp78/KplRijEdbnhxFNgKjz4UOQuWK
	FxfRk9dU1uO+THmURgF/obIJdXw8nBS5wWsJbHEc1glgWixY/hOg9Wi7t/EboUQWf6L8Gxfkbou
	OUAA=
X-Google-Smtp-Source: AGHT+IGibV1KonPV4clfKa3OrfZVKg4Q0Eg8Iw+ndBeBpXgG39uE6nAdp+Wkjtej1pxYMCEcfHsBNA==
X-Received: by 2002:a05:651c:1593:b0:2ff:5645:121f with SMTP id 38308e7fff4ca-2ff590a1bb4mr26603581fa.40.1731604910075;
        Thu, 14 Nov 2024 09:21:50 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff5985abfcsm2421771fa.87.2024.11.14.09.21.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:21:48 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1380390e87.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 09:21:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWD99ZtcdES/GvM6AcStQgqEt0IKPcDZTUUDumrEzlMFvMK6Gb4XcFsjaHc5K3VOW+Xf19/pUDTOKjb@vger.kernel.org
X-Received: by 2002:a05:6512:224e:b0:53d:a504:9334 with SMTP id
 2adb3069b0e04-53da5c7b565mr2490631e87.44.1731604907586; Thu, 14 Nov 2024
 09:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113124857.1959435-1-chenhuacai@loongson.cn>
 <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com> <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com>
In-Reply-To: <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 09:21:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC===Qx3STDjBWGHuzJ0SNP16gEz3iSc6Ebo_bM-yZtw@mail.gmail.com>
Message-ID: <CAHk-=wgC===Qx3STDjBWGHuzJ0SNP16gEz3iSc6Ebo_bM-yZtw@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 22:23, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Maybe the root cause is that "From" in my patch is loongson.cn but I
> use kernel.org's SMTP server?

Ahh, yes, I didn't even notice that you went through mail.kernel.org,
I only noticed that loongson.cn did SPF but not DKIM.

Yeah, if loongson had had DKIM and DMARC set up to match, it would
have been an even noisier failure about DKIM actively failing, rather
than not having DKIM at all.

If you use mail.kernel.org, using a "From:" with a kernel.org address
too to get the full email verification is likely the best option.

That said, I went back and looked, and you've clearly been using this
mail.kernel.org + loongson.cn model for a long time, and it hasn't
been problematic. So your pull request being marked as spam might have
been just a one-off.

           Linus

