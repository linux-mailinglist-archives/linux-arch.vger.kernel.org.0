Return-Path: <linux-arch+bounces-13703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4178B8BE99
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 05:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 577204E0456
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 03:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5122A4E8;
	Sat, 20 Sep 2025 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFPKZ+Oq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831112222D1
	for <linux-arch@vger.kernel.org>; Sat, 20 Sep 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758340539; cv=none; b=D6lPCRZCCdu5eJBPHo4LaajgPr9Lct/wvX5B8+zsgHepFPQoHmQxLtv7IIOlJ6C+HOnEkXW9oq2LvVuueV1rBPz5Pj0eV5PZD6agUkB6HoFPHWmrww/CMFGAT7hSzLJDmY4YXeIIgq+9b/FsO+lpRHwDqZqipyMYd+vHSpzIJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758340539; c=relaxed/simple;
	bh=wLR5A4WVJygISPHG42IIvYb+LPD25B9I3WH7jC2e5xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sps9oXZXlnblEITZmO5YKYd25Z4wGhRazs+J2a0MNg5PkhQ/+udVe82NELRGLlZ06Ni4OHR/oKzjfqEjx3PL/HqJNMT2vZqwmJsqdTvHzK8mA+jUpk7AOQe4hlHplI5QnRMT0DWMBQ+0E/D7/nQYdH3daT6QmeKsWP6g1zxdr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFPKZ+Oq; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea669836e8dso1444139276.3
        for <linux-arch@vger.kernel.org>; Fri, 19 Sep 2025 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758340534; x=1758945334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLR5A4WVJygISPHG42IIvYb+LPD25B9I3WH7jC2e5xU=;
        b=ZFPKZ+OqAAj1VhKugky3kjemp/VIqd75of38HGEmt1IOj91W4b7jLe+Myfu3ent1n8
         I+OsNztO7baVS7SDNqQDhsKyRcudzp5fPl2dQ3EsKmIi5TGzzTSREF9BOYtdvwLtcCQ9
         lX8BgfQDKyo0m2JfxIC+zD4CzDFgLzCucCTNnl0sqYXFOybMgodTGPU/RxeED3KpD6Ge
         7yQG/mA18ZVwa9TAvZspdmtVMoFft3MmApalEp7/PJVnD7pAqdNfemDIdWOkktS1fK7N
         5MIan1ZBYEJnEUm4lD9oNaRI/NjfTi3RIA4zVC5lAmPgo6eel/h/B86mXEMgdrCKJemE
         DM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758340534; x=1758945334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLR5A4WVJygISPHG42IIvYb+LPD25B9I3WH7jC2e5xU=;
        b=b+U0gCIY1mhCn9KNhcbQ6qpxB9Yy57RgkCQkN3syZgROCPk7/3WV7Xw0o9luJ8kT8R
         91ccVJA4wuEThjd68PesiHhenAnD91qvzRza8OhV35a3pdvkjiiKZYxwAH41etydEw9R
         PHJ2HXKQ2HpG4imwEwUJxVegCKTG+xxaQnsxmJTQL9yoGoB7l03nZ3tUwZO5VpfByqVE
         lGQjRIgFxtSp98deo6tW35v0Frp7EWpVNEyQ1v++fpWyPduS34Lqiv9vrPdu3TdI21rG
         W54Jiw9nxahsjOXEGgOnRqjpdlsK9rI7+OgElPVb5cRwYY12UZOThBPptj0ddO+IyfE3
         vacg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwvXm2QxkIUGnoYRXTux/NQ2tRr8bbRjTq9cHehMUKwGt5RrMbmPc93kViVozUMf+38gIBw8RKXn0@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvj0p6B0VGYPANHlIhw54JxieMAFeVewLZZNpGhbkGeovtgDH
	Z5zLtWJORdFaM4pUr6EL/DRJgIYtczhKy7P84p1AEpkv4o7bMQ1h0x4/vqXV4dJcLDRPhHheBmn
	RlqK1nWsfWciXdNm7uezfnLJH2bFWoSw=
X-Gm-Gg: ASbGnctNkC3TfY7Q9IKFnPQPJtjX7kxNL+svBKTeD5j3/yS6hOTHZG53nLigFwMURNL
	IDVOjnq0ppW/uSbHE9mT5NUqy9U8ZoeIKplo0/HDoj7X2dU/gb/fNaw/dWpko+bsi12C0WVGIqZ
	fRaDkV2JKdL9pU3paFSULy2UrMdEs6Up5R+M3tU9LHYsn+RlwRwLXrrpPJsHdU5jO67x8WcuQO7
	8KuSk8=
X-Google-Smtp-Source: AGHT+IH7cxRQcDAWrx6iopGK0fgAvvotX/SwRt/T/KElvH4XQULrd96czgOrVv1CSvA0vDpbRNCMKcVlhfdowxEBryU=
X-Received: by 2002:a53:b3c5:0:b0:622:4818:ce38 with SMTP id
 956f58d0204a3-6347f610c7emr3546092d50.37.1758340534336; Fri, 19 Sep 2025
 20:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
In-Reply-To: <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 20 Sep 2025 06:54:58 +0300
X-Gm-Features: AS18NWCqg0xtU5KiNe17DWjmiPCEbBI_FSj5NCOyDGZFj_7oFaRqSu7O_vUKCrA
Message-ID: <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:25=E2=80=AFPM Nicolas Schichan <nschichan@freebox=
.fr> wrote:
> Considering that the deprecation message didn't get displayed in some
> configurations, maybe it's a bit early at the very least.

I changed my opinion.
Breaking users, who did not see a deprecation message at all,
is unfair.
I will send a patchset soon, which will remove initrd codepath,
which currently contains deprecation notice. And I will put
deprecation notice to
other codepath.

Then in September 2026 I will fully remove initrd.

> SMTP server I used wasn't authenticated to google, so all gmail
> recipients were dropped. Hopefully this work better today.

Yes, this time I got your email

--=20
Askar Safin

