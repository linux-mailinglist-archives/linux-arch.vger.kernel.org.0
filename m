Return-Path: <linux-arch+bounces-14739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293DC5A5D6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF2B3B13BB
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE82FDC39;
	Thu, 13 Nov 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lToG4/Xs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F9322C81
	for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073768; cv=none; b=YvmsnrXd+e6pba7R8S5qk+c6uTkcplCWOcU4FuJFhBeyAbEJwvJ+fochN8Z3PwQfYRzgw6TI1uApt7gmTrjo4bDqdaIWLFo4Fgc8PlFvtZgAYFuZergEAt9bvq65lOPm6X/QMxWXW/SjRljyHmgvbGw7yvoifpUZrEnXxxDH3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073768; c=relaxed/simple;
	bh=TcHah/xGqOuR/iYF9lSI4H1JN0TWXwa84emMqcbTocM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1U59XvEWk2espyFasR4NoLwN42Op+EOjrVf70G6urdSwqft3ZhAQH6fo626vdsmEROLbhd+sp/Bzoo8N3mZLEyV+es5NyumdLSReC6zCh7cVZYbZ352coA/KlioBJ9S+I0HKm9FlsLkjJwoNsGv6cghxghbzFWLBUFeqype6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lToG4/Xs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edb59dfda5so40311cf.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763073765; x=1763678565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ejv6A8rdWJkpPdH1oULXD4xDIYEN0CZbbCWSORyHwT4=;
        b=lToG4/Xsz5DRF8whn7FoitzA9OohD5ep9to+ffsdZygoyTQeLoLrijRMTLFYj1KNC1
         iuB7gJZpP54LhJAiq5qQemOrklrNR1ICkSKuDrvbwPwHnlelhvzhnuDYOQmPE/nxgxBt
         cp5QKrBGLShgWbAiAWxeqFyGg0tsjGyURUVm+QBVLtxl2JR6+AZFY21SYF8stiywfrgv
         fbir3gvXp1PfJbWw7/z16BLOzoU8HPJGccMrKTqWT4rFWT4jIrAjffmnGqAhIKKNb5g2
         4rS35N2WA6pYXQs7J/YwDpmGx0/g9e+zCoFzLFVJy1jzOvNSnBfrS8X7H7rp+cQ57IqH
         lHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763073765; x=1763678565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ejv6A8rdWJkpPdH1oULXD4xDIYEN0CZbbCWSORyHwT4=;
        b=fWcaDY829RTlRSBTK6o7ukrAPhildA/HrH4+nu7yXSOzZr/BqDKJDXJL+LZwXLKV6N
         FtMj9XHNMLw2xkACGV20IqS45yVFImp6G81X6S8kq+jjZW0fUSpjtInFbx/K2Jg+iQ+9
         xLAZKQHzmTkve1UK8Z68rd4L4ZzIjMDpG6RYzAekoUhQivZItdT5iWWK18WRjD/BDuZd
         mzY4qB5CCZJG8jFsG0EbZFsaLiVT4PnF2G0AuzvH6R3c7FZZIUxunYbet7hhaL1ZYHNr
         SrXsiO01orHsAC9IwKYcLcbSVXJRKYJlGzuDE1JNYt4fHapBXSmx4Ma/SKgxL7UFPVg7
         5+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6lnKcPhEgYPwAqG4pSP7b+/PnDGMuZzzN8xYpSfDihT/36i68E3R440wKySYwJ/JwIOsnprx6nW1@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEvrHe6Wd2zML8CPFWWQVlAt7BxWOxHjKjLoNsgkBbFhE0FrH
	+6M7DyBaqbSrfrEkU3TPix7WS9Hszh5cjLJyaLYJFr3sN0CjQp13ZS+2jMppZ7uBdbZYjJep/j0
	QvdFJ9QleYKbmcz/Bfxh5z8KRaKcfUIGS7uDIr/+c
X-Gm-Gg: ASbGncsVKaftM7QdLfaIZipLyVKOdgS0d36oV0M/XtEjDKv5Pr770gWfcEgVNSQyroA
	LqDu0sgUOCYbMZD+3JE2NEcoNhVSL0+mFI7Nl7sPguQfSwDXNj0ljk6S7n3mOJ92TRiIfflHu1F
	GE/smLoj27iPYWd4eymSl9L9QaYpF6sss9urfsArFSXNQ0SIdFnu3Q7+r40gqaNXKgmgef5dMNo
	tYsFqw5xbiwi9wnY/EoCMsa1bFi2eu/jSPnGKfu4Ft+VJfuVaL4I8uQU+imAlnRwxtDi0u6T9Ja
	U1ZVjQ==
X-Google-Smtp-Source: AGHT+IGQhDcH0SdIn2CvBhwa5KznFKitv2vTdAgxB7lpQqrZkmoO5mHAgC/M/Wvqz1dqGovXjEs1dmJBfzOp/yCogRE=
X-Received: by 2002:ac8:7c56:0:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4edf4815966mr715831cf.9.1763073764466; Thu, 13 Nov 2025
 14:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-3-lrizzo@google.com>
 <87346ie0vs.ffs@tglx> <87h5uycjr9.ffs@tglx>
In-Reply-To: <87h5uycjr9.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 23:42:08 +0100
X-Gm-Features: AWmQ_bnHlM5SNHcFsiCEUUN_5TFZ0ISzIaNj_vtxnJvvdexOWIMupjFYUa2-9mw
Message-ID: <CAMOZA0+XXqau3rW-ZUKBkZASmEYwrmTuHfwkreniJk9NciCe_g@mail.gmail.com>
Subject: Re: [PATCH 2/6] genirq: soft_moderation: add base files, procfs hooks
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:24=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, Nov 13 2025 at 10:29, Thomas Gleixner wrote:
> > On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> >>  [...]
> >> +            struct irq_chip *chip =3D desc->irq_data.chip;
> >> +
> >> +            /* Make sure this is msi and we can run enable_irq from i=
rq context */
> >> +            mode &=3D desc->handle_irq =3D=3D handle_edge_irq && chip=
 && chip->irq_bus_lock =3D=3D NULL &&
> >> +                            chip->irq_bus_sync_unlock =3D=3D NULL;
>
> Q: How does this make sure that it is MSI?
> A: Not at all

Yeah the MSI thing was misguided, as Marc suggested I will replace the cond=
ition
with !irqd_is_level_type(&desc->irq_data)

> Q: How is this protected against concurrent modification?
> A: Not at all

Is there such a risk, specifically regarding changing desc->chip ?
I expected desc->chip to be set when the irq is attached and never modified
until destruction. Then, this function is called from within the
procfs handler so
the desc is already set. If it gets destroyed, changing mode is harmless.

cheers
luigi

