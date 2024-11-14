Return-Path: <linux-arch+bounces-9083-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A49C8304
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 07:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA22284B9F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC31AF0DC;
	Thu, 14 Nov 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeznJqzz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5D1DFD8;
	Thu, 14 Nov 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565411; cv=none; b=YChHSK2r1mRMVZKscpKpV2EJUMj8xGkkqtZZwvzHpS+6GYVvQQs1xlzqDVDOB/1Q/2Hinmy9WZgWJE0Cchlwwh3hzVytK41k2OSKBHM1tD9ggWCzYLAZ+qhXPl3YUUC1Hw+coKA+8Va3Soy/Xg9tAmEJ+JFWMDDgy0ObQATV63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565411; c=relaxed/simple;
	bh=s7Mfdv4GRYa2OR5o4x+wbZZfKOfHszZQimqrnUlWVhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoiBVOIFlUqZmGk+0kJ1mIlqECgT1SJkA6xOp79CJnwwbmKw2MRb+cy+onRdGYqdZOWCLPYJe2V5hAcV2L+KNhSmVsfQ03n+DE/LUo0nA47D+d1JDjW5b1a5sY5cPhiWZshuSLB5Ivw1doJuq1hg9mns/JQ8OnsCtP1eTNaWitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeznJqzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C0AC4CED8;
	Thu, 14 Nov 2024 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731565410;
	bh=s7Mfdv4GRYa2OR5o4x+wbZZfKOfHszZQimqrnUlWVhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KeznJqzzU5jKxFDlGu5NtCxM3WFCgRqWb2XnrIFX2ORpth2eruoL7j5D+ulEPFdcd
	 j98B12VGtab1OElYE84BNknpqYwFCNzoIATJqs3sZk/CESiB8o1MaoINnxsXgPZBIv
	 JCP1zkBypluGW8dRKq1lh69Xwm+uThF0qKi4weCnH4wqvFR9W2WEU+cruKRj3KmH5y
	 0PniR2v4OT8OCC8jwuet9WCW2mVtT5N0/f4YwmMSqmwS05cDr01BgMviDAzN7VOFT5
	 LqmGT/FZHockIMrnHH7I4pDI8iFBlw7tF0bKXPP+AHELMdk9iyV0b+OSZawaysbBvT
	 LCB98fjjbMPHw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99eb8b607aso28862766b.2;
        Wed, 13 Nov 2024 22:23:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMrjNbI8rChPuBrlqBlcSQ4d09t4pKnjv7F6pEWf4eVKpscG0hLdXcujNFB5B33maNZQ6SvGhEMQdd@vger.kernel.org, AJvYcCX5SDnfYyImSf3hOrl3H9Xh8PAlE2tjlS/wKhPrp7MNAk/ArbBP4TVcYynqDIRIo+lvDFadoMHPaa78QhD+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHqhKZ9Rav8UMXEUBFTBB+/v3p9vkSFDgxuw3N748EaIgwwi7
	Ygj8VsxKxNpzAVAx59MLE6pjkkjfzgX6tr+qXCXvn1X+wOr7Qa9NMfsYdIpYEraokMeW9eJVBXo
	5GTh6b13uXKKqtH0NwQZdtvQReVA=
X-Google-Smtp-Source: AGHT+IG+g5gwmqrc+hBmet+m5InXK/ExhZqLxMNhRWbxlJVd2mb6LgxKGdsrgfoA3NRDPjlFKU3UtGWk1LCYXTiCZVg=
X-Received: by 2002:a17:907:728d:b0:a99:eb94:3e37 with SMTP id
 a640c23a62f3a-a9ef002177amr2359460566b.58.1731565409312; Wed, 13 Nov 2024
 22:23:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113124857.1959435-1-chenhuacai@loongson.cn> <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com>
In-Reply-To: <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Nov 2024 14:23:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com>
Message-ID: <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Linus,

On Thu, Nov 14, 2024 at 1:06=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 13, 2024 at 4:49=E2=80=AFAM Huacai Chen <chenhuacai@loongson.=
cn> wrote:
> >
> > LoongArch fixes for v6.12-final
>
> Hmm. This email was in my spam folder. I'm not seeing anything
> horribly wrong with it, but I do note that loongson.cn does not seem
> to enable DKIM, and that does tend to make gmail (understandably) more
> nervous. Yes, you do have proper SPF, but in this day and age SPF+DKIM
> (and a proper DMARC policy to enable strict enforcement) really is a
> good idea.
Maybe the root cause is that "From" in my patch is loongson.cn but I
use kernel.org's SMTP server?

>
> Maybe you can talk to your MIS people about setting up DKIM and DMARC too=
?
OK, I will try my best to do this.

Huacai

>
> Yes, it's a bother. But spam is a scourge.
>
>                       Linus

