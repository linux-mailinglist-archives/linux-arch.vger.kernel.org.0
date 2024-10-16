Return-Path: <linux-arch+bounces-8231-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851799A0B66
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DFF1F263DC
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DA208D7A;
	Wed, 16 Oct 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGX/pFJh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFB20720B
	for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085176; cv=none; b=HnbOeaZ4jiS7wN8Q0wKsLSXYO2Jzj01nUo/M+2WIR8br5UCqnK9aN9lsOnCh2CM6HVMsdhBKL41Gsc3HB8Lfc53hWWyY9u841OJa6Iorke2lPoUnxVbdR1Uh6r/KxC2VC7gZBArgQ9nJz8N1ziFKhDx5hUiu2DrF/LDDw6R4DpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085176; c=relaxed/simple;
	bh=O7EgR5OSjoWSs3q+41nfNzDZd6mbVvdVr2357ZxksYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvWWbX5n5sQ/6o5NggxIzmAIhVsaLknZv4lVCAfBDbszlqhE53AaA243zZuYxq+HLC4Pk+MwVBXj/r9uEAA3bTO4hEBi/Dp2AksvHAiGiBFdYPA5B2XnOoQpmryh6YdXvMNUasDxJAtjmbkx/a51WsSwOPiQJGSefQX3wilmo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGX/pFJh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so18733a12.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2024 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729085173; x=1729689973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7EgR5OSjoWSs3q+41nfNzDZd6mbVvdVr2357ZxksYQ=;
        b=nGX/pFJh+wzH1/diPW9LoH78Xy/4/Gs8GVJAwGrsr43WqGcuVcqH0F2jt+GjeGRjzV
         ykB+Cgp8AN/rtf16UBaw+mhmVfpVGV6jtbWiPExeGYhiXxZDV/OXhz3B+jbU8YN9Xrbx
         L7E2HHK+TXPo9e2QSU3Cd9S/XzV4kI5s3pSVLEIOsqlV3KytlY4BgJs8Ppuo6aQMmUyM
         S5bFHWrPpjne+vYkante4qsk+ZGMfbLwEoHDJuZvQO0X3//C0ojB57ncawVQdlMzADId
         A9aEDrfQkNPbraQEeHSrSRlnizylfZ4nKDubqXMgd4dFXfeMI6OmwZzo04hkMv86wcKa
         1kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085173; x=1729689973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7EgR5OSjoWSs3q+41nfNzDZd6mbVvdVr2357ZxksYQ=;
        b=vR52yPUtcNtC5sO0rr6B0Z1LvqrpzcC6NE1+iwtP2x1Ped9tSFDEAhOfg6XV5elMia
         xaaGf2tZpg1uuaM6Y6Dvl5eIPXzEp4SxRYS8PIBysC7m/PoNO6lpQDqbqSCRrBdJLg+5
         2pttxyfcbuxKvaOojgslATjbbF3GvhEijfFiY3KSeyy8BjJv0azoIOTdOPm6yhjyuYKO
         MUd+ZMkgJCF3RBizhk/h0Z3t5FLxFsTuY7b/cNbePOdfJRgB/IvVRfajDZrsUN8QGORu
         SBDnKMwVvQgdx3YDBnizq7/MB9TN8utvqW+nh/47dcnj5z4RGzql9+g3f2ne7o0Wv8Ey
         XkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxbiZwCKMHZnCQr0WskgxoE5Mly+jteG7aY6uuWX+kMW9a9Z4izMoXDG14ECzGR2m8cowDkJ/rv0nK@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfhNbEkHU1rX0MV6GrDqmfgclOat2W4G/RN3n64y9cGJf9dds
	nyjNDA1kaGcGJXOFRMzNvIuFEXr6L+IOuFSE3hOnwyQoK+/p04Xe7oRI94DDuzUZ/JLPlIP+IJy
	PN5zYe1IXspj2Wz0TFB5b8wP9OX9OjHpAggBZ
X-Google-Smtp-Source: AGHT+IHm4uAnm6x4gqyE8JxaDYdv12A+djBdgtqoCDD2tCHeA1XFE3cLD3QA0GXWVVrvkSNF4Qk2pPtyOLiHFomBKfc=
X-Received: by 2002:a05:6402:234a:b0:5c8:a0fd:64f0 with SMTP id
 4fb4d7f45d1cf-5c9979d0b81mr492682a12.2.1729085172800; Wed, 16 Oct 2024
 06:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <CAG48ez0=9O-V0V6v_LUgRcF46BooJdk3eqb6xgDpKpNZuW1L2A@mail.gmail.com> <a185df19-c8a5-4b2f-8bed-19770744a944@oracle.com>
In-Reply-To: <a185df19-c8a5-4b2f-8bed-19770744a944@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Oct 2024 15:25:34 +0200
Message-ID: <CAG48ez33CQmWnQR13WvuP+eiX=MEXch2s6n2+Ck+zT5Tgi5fEg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:59=E2=80=AFAM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
> On 10/14/24 1:07 PM, Jann Horn wrote:
> > Second, there is a newer mode for IOMMUv2 stuff (using the
> > mmu_notifier_ops::invalidate_range callback), where the idea is that
> > you have secondary MMUs that share the normal page tables, and so you
> > basically send them invalidations at the same time you invalidate the
> > primary MMU for the process. I think that's the right fit for this
> > usecase; however, last I looked, this code was extremely broken (see
> > https://lore.kernel.org/lkml/CAG48ez2NQKVbv=3DyG_fq_jtZjf8Q=3D+Wy54FxcF=
rK_OujFg5BwSQ@mail.gmail.com/
> > for context). Unless that's changed in the meantime, I think someone
> > would have to fix that code before it can be relied on for new
> > usecases.
>
> Thank you for this background! Looks like there have since been some
> changes to the mmu notifiers, and the invalidate_range callback became
> arch_invalidate_secondary_tlbs. I'm currently looking into using it to
> flush all TLBs.

Ah, nice, that looks much better now. With the caveat that, from what
I can tell, the notifiers only work on x86/arm64/powerpc - I guess
maybe that infrastructure should be gated on a HAVE_... arch config
flag...

