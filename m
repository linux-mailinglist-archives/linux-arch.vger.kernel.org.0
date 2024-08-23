Return-Path: <linux-arch+bounces-6555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078395D235
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5FDB28AA4
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F6190051;
	Fri, 23 Aug 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULK5zsyi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB318EFF3
	for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428594; cv=none; b=Acd7+5lMG/hTZnjyjFT8cMFKEtM/UpnJOU4n+QlwsO0llgvTYn2F7xlTTFr+RYcycP1cgYeeac8VHaHoWgkuKVAEIg9AmiuKu0epR2YeUGBqLW0PvognKPcSfuY5MeKvPjXO2rACVipBcWwiaLeaTKKNYLgHKXdclZXpfVEtDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428594; c=relaxed/simple;
	bh=HGqhcQes5Ttfrfat5u189/JTp3kgH468GuYjDVQlEsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4If9cJgwE/KR9w8ceTvQBNrnP7oh8Q8gQdvu2EbazIFe5gyc4UficI0mxjMlM6PIZzvLALnZ/r2H8+Wj4k0rI9Or2krrt9nbukfXT3HUEMCWoWGLbz1DNTgTBlF4TQak/DFxQXVSjAFy8D0i66J2Q+xMAEWvltaz0CBUiZhfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULK5zsyi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso3463272e87.0
        for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428588; x=1725033388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGqhcQes5Ttfrfat5u189/JTp3kgH468GuYjDVQlEsE=;
        b=ULK5zsyi7EshijB5bsVouhIqAj9xq7elWP6IrA0bo0GcHf8Hbk5w4RvLDLHTZ+Jucu
         tST58t2QXF7zmT+yfrnHIyMxYVR6Bj4XGelQuFHnBsegZJCsUpVmVCkskM7NfBwesC0y
         g1jgTNwR7poxDu67BrnrakEORpE58f0ycdIebMYu5hrBGkYOELij2jRSNpcpamdj9PdU
         com+ea+t5KopRsbTF+jn9f801/+tZMr8RFDCLOBNROq/igkjMLX8xsLYHja9dl/521dX
         UZaWNXBl/JRLcNMnmJcmXT2NDygAr9rGNmHz583sZ+Jq30AcwqLXkS7JwwQDt5vE6fuO
         ISTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428588; x=1725033388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGqhcQes5Ttfrfat5u189/JTp3kgH468GuYjDVQlEsE=;
        b=DImz3+wWsyMGFM6nNm2/HhG8db96PdmvM6LmPELhpXGnuRJNqb4ba9UlVs/kZsC5Up
         TpyiN7Ld1MFisKeuO2N6bmI3hyd7zuJu6cRWKpZZ8e55VElS2BQwf7lvNYaC3Zm09g8B
         4rGBDImFQSj/ZhtuS2HSi9yHZAQLBNhbbil3QL0Dnrk0CL+RBUTMzMJMSmvxbzMfVFSC
         fDDum3yZIgYo7Ox202Lp7179pgGe7yjPvQd2arP8jDRpdNJBWxk4stz6mWM7r82gS36p
         mQaCDFof6wVaH0jcBPvHmPLJVyjGLdNbgvTsuYTYZ+YQl6XTSlq6+A7l8SD9JyFBEuND
         CIjw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTEZarh7nnQN3IQ6U5YqA+kSO1IN1qj24+NKzKcnu6WRqecdAYX2T9MmxD6VlcadwaWtxkhwKEEiA@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSulghCs7lOYJisAM03H0O6ihDcFOZ11VLSUlUbzBBdzUs6zO
	L5IEunQKLkcNKomtqzpo/AzlwrNdktIa0L41DAfEjOONM02cEdgZON0Y0zVOUfRWboqVMCJTuOq
	PjGjmtbzhxJrV5SUon7zSlmgKPTp8Wuo2t1NBsg==
X-Google-Smtp-Source: AGHT+IF+VJqrZG6jMDTEJ3q6NJ/NApbAQdSMXyFziZqx6qMBZdyXh5nvJ/NMn+LngJ0u+dNzIY1IbzFCNGCR5eMpqEM=
X-Received: by 2002:a05:6512:239e:b0:52f:d15f:d46b with SMTP id
 2adb3069b0e04-5343877a8f0mr2130796e87.14.1724428587991; Fri, 23 Aug 2024
 08:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
 <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com> <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
 <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
In-Reply-To: <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:56:16 +0200
Message-ID: <CACRpkdYfn6Wxo6N4hNRoMVSQXnsSVAjZXRfYzZtbRuzZyKvhkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, eric.devolder@oracle.com, robh@kernel.org, 
	vincent.whitchurch@axis.com, bhe@redhat.com, nico@fluxnic.net, 
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:03=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:

> By the way, currently, most architectures have simplified assembly code
> and implemented its most functions in C functions. Does arm32 have this
> plan?

I would turn it around, since I saw that Huawei contributed generic entry
code for Aarch64, do you folks have a plan to also do patches for ARM32?

I have many ARM32 systems and I am happy to help out with reviewing
and testing if you do.

Alternatively I might be able to have a look at it, because the entry code
is right in my work area all the time.

Yours,
Linus Walleij

