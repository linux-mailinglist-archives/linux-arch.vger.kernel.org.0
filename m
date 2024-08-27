Return-Path: <linux-arch+bounces-6644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E89603D5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A241B1C21CB2
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0A189BA8;
	Tue, 27 Aug 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d/d8V9Ey"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FDA18756A
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745765; cv=none; b=AnZjEJjxHYWKTTyOP9jHCCrcmrix5DOCNUVALIIfFIJWAJ2qDaCkISh88MwziFapXGJ14FHZZFZNqlloleGMl/qg+jLUPoKmbukq3VDyufisrB4Q6OI1k8pmcPg03WAMqvdpLpeC++yrfAfbE3Z/QY+m8SlDETWLGCNcufmvZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745765; c=relaxed/simple;
	bh=wlrG+jo4u8AssfQwalnT72u3VqV0xp8FeGbzhPN+7dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi1uhJljVKbqzIAElix2sSktUsT5XHwa+Xmf3MoSaj3XCcN/lStY0/cjYIkYgyO4LpUPigKtNAka8st1DQkjSxAhF4BiufAdnaaQEpRZ3oC43n1PzxhXyzNYg05EebN1fsasFXLWX015t5TDYNrZDGELbAOvgOtYumtgfzLsFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d/d8V9Ey; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a80eab3945eso526724466b.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724745762; x=1725350562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBms7y/tBFsZy50lNtASZmPiwThWbZhDKwKfTMeuMMA=;
        b=d/d8V9EyCtSK3lO6+QCfgmIfZYr+/TxcAETOda01RNVAvNfq2TH5XTdBPE8O0L46GH
         t39WsHGrHdg9VkfEKAZh1EPhtCRPVeFtkF3p+IdL/iyVcG+9/5FmaZI1H0UuhZ+wozsw
         Q26TW5VGHx7uhO1pK/g7ufLyKhIRIJwLQKWmBdXb5TFrkQtls87pSjKZto2y3qTShwbC
         3jtwESCOhG/+4PCIXBNx3i+TVkNgH8BzftqejYVDeSF3PEfLroYGzV0zX7RY2Kv3xEal
         RBihUDPdk2pXgi/CZ5I+u6Yu/ImMCPwvgfdPrxqSIGRq7y2w+nBirDBCSqKwOrUUuc0z
         6igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745762; x=1725350562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBms7y/tBFsZy50lNtASZmPiwThWbZhDKwKfTMeuMMA=;
        b=EX19UnBF5b+RdAFOTOWkZtsaoUdR+le5wz3lQJSHX3eXvbymwcu8SBv+EImWK9wYOL
         ixmlI/Gd1onqoO+GGuway+tBsUd7gp4AoN84cdDPk0N4+XZofocuR27f6hcRfLlZ0S4t
         auxeiuAuBuioXFwQ27Bzvh9rdNZ06iK/ctFqAnghmJpy1MX0EqhmeAVldXSqQktG/unS
         dfVmjlXMZmR7X0J5NKKGqmGgq5SLqhq3RZ/cXxRThhTwVzU+bTHp/yPT+Z+95qChrBxF
         3mIK0nj0gPnthfm4hdjTth87iUPO2NpPPss44Gy5Y7Md6E+Zhoc4Zg7c9l31+JKl610S
         q5ig==
X-Forwarded-Encrypted: i=1; AJvYcCUabMSWxB8LWsWZbB5T8N3SpsPH1xa+t/lG8m38Hi/uZxsTmiklWXqWLpjd6hj7g8g51TxCl/iVy3kT@vger.kernel.org
X-Gm-Message-State: AOJu0YziiL8tLrbonzDnk4FAK9Rj/YDxT9b9ydwZk0kOs4KjtolGscCP
	NNKl4lnODmXZTAdx3tGB9Ss93nHWvlMW5/cAmZKEDKUBnDqdcCK822VIbfGsJAI7ypd3h39JuNV
	4wElP1W5sI3wCfFYzGGZfJuBM62b7Pcq7UDnszg==
X-Google-Smtp-Source: AGHT+IEPKjzBgfiAk9G0dnZjYH9HkHNAZ5iX4+y8YvtQs+BwlAOu22sCjko/Iouwb9iDtzPGYnZU+k2kKs5nhqRDXTc=
X-Received: by 2002:a17:907:9491:b0:a7a:b643:654f with SMTP id
 a640c23a62f3a-a86e39f9082mr158372366b.15.1724745761303; Tue, 27 Aug 2024
 01:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com> <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>
 <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr> <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
 <20240821-6befd27b90a9e9ff89f4a277@orel>
In-Reply-To: <20240821-6befd27b90a9e9ff89f4a277@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 27 Aug 2024 10:02:30 +0200
Message-ID: <CAHVXubiy3=bEf29qpzGX0MoBXkjBy38p9Xhz7yRYN5Sr3qRw0g@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Wed, Aug 21, 2024 at 2:18=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Aug 17, 2024 at 01:08:34PM GMT, Guo Ren wrote:
> ...
> > > So I have just checked the size of the jump table section:
> > >
> > > * defconfig:
> > >
> > > - ticket: 26928 bytes
> > > - combo: 28320 bytes
> > >
> > > So that's a ~5% increase.
> > >
> > > * ubuntu config
> > >
> > > - ticket: 107840 bytes
> > > - combo: 174752 bytes
> > >
> > > And that's a ~62% increase.
> > The size of the jump table section has increased from 5% to 62%. I
> > think some configuration triggers the jump table's debug code. If it's
> > not a debugging configuration, that's a bug of the Ubuntu config.
>
> And I just remembered we wanted to check with CONFIG_CC_OPTIMIZE_FOR_SIZE

Here we go!

The size of the jump table section:

* defconfig:

- ticket: 12176 bytes
- combo: 13168 bytes

So that's a ~8% increase.

* ubuntu config

- ticket:   73920 bytes
- combo: 84656 bytes

And that's a ~14% increase.

This is the ELF size difference between ticket and combo spinlocks:

* ticket:   695906872 bytes
* combo: 697558496 bytes

So that's an increase of ~0.23% on the ELF.

And the .text section size:

* ticket:   10322820 bytes
* combo: 10332136 bytes

And that's a ~0.09% increase!

So that's even better :)

Thanks for asking!

Alex

>
> Thanks,
> drew
>
> >
> > >
> > > This is the ELF size difference between ticket and combo spinlocks:
> > >
> > > * ticket: 776915592 bytes
> > > * combo: 786958968 bytes
> > >
> > > So that's an increase of ~1.3% on the ELF.
> > >
> > > And the .text section size:
> > >
> > > * ticket: 12290960 bytes
> > > * combo: 12366644 bytes
> > >
> > > And that's a ~0.6% increase!
> > >
> > > Finally, I'd say the impact is very limited :)
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > >

