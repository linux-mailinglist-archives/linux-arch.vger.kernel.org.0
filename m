Return-Path: <linux-arch+bounces-9184-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A89DBE49
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 01:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E45C282438
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 00:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01514AD58;
	Fri, 29 Nov 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gENkKgIO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEF647;
	Fri, 29 Nov 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732841721; cv=none; b=sDyzs8/091+JnJy99m9veRQmd6KPOxb8hhNyjgDzEUbm3rkdoryIXHT0/2NFBAvLpDgvaleuWNpwf5ShSkE2C0P6BRVP5+wsLiMtptER7ybZ60PHNDUMJl8BIrzdgghxjbmRaoxz21kpAw2jxGrrrKhmMrlWVDG1vSc6M1JZY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732841721; c=relaxed/simple;
	bh=YGjyotpBwbfXL17yErbP8SKQ1ul5skOnjRIYm1O4IH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRop46wN0h/2xkBEsWM6sTpJbzjeLcJZBIqN4lQd6tiWwkyOo6L+P/bjtylEanCwBoW2Dd9M9s30n0uh3QOag+FLxrj/dCXEwPpkytkODgitqAvpT0qbfnfXfbhu6vxyo4eP0FgLUgjV09eBCnkxaDFUFY4elZ8nuRHvBRBfAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gENkKgIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4809AC4CED2;
	Fri, 29 Nov 2024 00:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732841721;
	bh=YGjyotpBwbfXL17yErbP8SKQ1ul5skOnjRIYm1O4IH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gENkKgIOX7riDYV3T6iW2kd/jBwqv61hgm7LJrq75Q6iW4MCw3yGaFRiOvNHHhcrD
	 b3lRs6VfbX0rOxbQpfoxsuUaHqrnqmEt6INJJ1NDdzD+45UzP49A7Nh/Yvhuaec6qa
	 bCekcDsobthnKyaZfM0xh6byzNUKwJOSSGJ2x0AAg2yWzKC11ejaUkC2/QeFL6gS9y
	 dA4H1QOw35YhMb4loHKJrq7b78UZ3ctaF8WwGuE3LeGeE4QjeKRtS1ihYB/I7RZgwV
	 8tU74v9UjvLWw+Xpj/+sEplaFI0Ng5qnYdY7/+SN6q65NTWsqGhWttFtlEpDpz7AN2
	 Ymlh4Y2+7zHsA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa54adcb894so154969766b.0;
        Thu, 28 Nov 2024 16:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGy2F92MoGLNFtOKSOGlf7mhUrgkBypNOa7F+CXoVVU/9WeakHP47MPWZ4wbucv003tUuJbb7HqXvv@vger.kernel.org, AJvYcCVvbCaeSMs4F/YdN/fKqEWuWSikk47LgOS/ZIluT8PIIT+hFmMh5Z+pk37VeR1AKNOKlGfn683DXB3f7TEo@vger.kernel.org, AJvYcCWBPmJW3UEwM17bxZDn2gCXuH5kCQkhNKHoHSW/gUj13pf5xpGH8FAfb/k8t/Ufe4DTjVuGFiEsJNIU@vger.kernel.org, AJvYcCWpnJeCtuTx6X1fMDzWAtMQ18Ey7BKrzr6vnicmRVutodrQCWWnD9JfVWaDbITtL6l7xRGEBk5iDgpBSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9HprMQRbvleaW2R2vRwHhZFJuafKuFg/snRs1bMmBcPOq8LT
	udvMBW6cDwFoeYvm8WNkncgsgL24ioPxW6ZmFPvNa2Jglz+OXj1wbe12uQwkpYuyT6J5EpBD3yp
	bkYEXiGGD9eD4iZsoiC5yyEViu58=
X-Google-Smtp-Source: AGHT+IFeDlqZOVMgOL8009xKZgLenXig1Ow6dpsDX7zAwO6rse3Q8pTl7jvVHnF/kSyfxU9JR7kitB7iCUYlXhcfUlE=
X-Received: by 2002:a17:906:6a27:b0:aa5:47f8:b923 with SMTP id
 a640c23a62f3a-aa58109a565mr781155366b.61.1732841719820; Thu, 28 Nov 2024
 16:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com> <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck> <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr> <20241128-goggles-laundry-d94c23ab39a4@spud>
In-Reply-To: <20241128-goggles-laundry-d94c23ab39a4@spud>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 29 Nov 2024 08:55:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
Message-ID: <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor.dooley@microchip.com>, 
	Will Deacon <will@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 12:19=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Nov 28, 2024 at 03:50:09PM +0100, Alexandre Ghiti wrote:
> > On 28/11/2024 15:14, Conor Dooley wrote:
> > > On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> > > > On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
> > > > > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> > > > > > In order to produce a generic kernel, a user can select
> > > > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ti=
cket
> > > > > > spinlock implementation if Zabha or Ziccrse are not present.
> > > > > >
> > > > > > Note that we can't use alternatives here because the discovery =
of
> > > > > > extensions is done too late and we need to start with the qspin=
lock
> > > > > > implementation because the ticket spinlock implementation would=
 pollute
> > > > > > the spinlock value, so let's use static keys.
> > > > > >
> > > > > > This is largely based on Guo's work and Leonardo reviews at [1]=
.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-riscv/20231225125847.277863=
8-1-guoren@kernel.org/ [1]
> > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > This patch (now commit ab83647fadae2 ("riscv: Add qspinlock suppo=
rt"))
> > > > > breaks boot on polarfire soc. It dies before outputting anything =
to the
> > > > > console. My .config has:
> > > > >
> > > > > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > > > > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > > > > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
> > > > I pointed out some of the fragility during review:
> > > >
> > > > https://lore.kernel.org/all/20241111164259.GA20042@willie-the-truck=
/
> > > >
> > > > so I'm kinda surprised it got merged tbh :/
> > > Maybe it could be reverted rather than having a broken boot with the
> > > default settings in -rc1.
> >
> >
> > No need to rush before we know what's happening,I guess you bisected to=
 this
> > commit right?
>
> The symptom is a failure to boot, without any console output, of course
> I bisected it before blaming something specific. But I don't think it is
> "rushing" as having -rc1 broken with an option's default is a massive pai=
n
> in the arse when it comes to testing.
>
> > I don't have this soc, so can you provide $stval/$sepc/$scause, a confi=
g, a
> > kernel, anything?
>
> I don't have the former cos it died immediately on boot. config is
> attached. It reproduces in QEMU so you don't need any hardware.
If QEMU could reproduce, could you provide a dmesg by the below method?

Qemu cmd append: -s -S
ref: https://qemu-project.gitlab.io/qemu/system/gdb.html

Connect gdb and in console:
1. file vmlinux
2. source ./Documentation/admin-guide/kdump/gdbmacros.txt
3. dmesg

Then, we could get the kernel's early boot logs from memory.

>
> > Does the polarfire soc provide Ziccrse?
>
> I don't think that is relevant because ziccrse is not listed in the dts,
> so the kernel should not be assuming that LR/SC has a forward progress
> guarantee. It's not even getting as far as riscv_spinlock_init() given
> several things before that should be emitting logs, so it doesn't even
> get to make any decisions about Ziccrse.



--=20
Best Regards
 Guo Ren

