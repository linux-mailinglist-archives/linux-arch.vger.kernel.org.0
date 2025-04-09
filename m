Return-Path: <linux-arch+bounces-11352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C9A823D1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451D13A14BE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8B725EFBF;
	Wed,  9 Apr 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2PK4x5p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6C25E479;
	Wed,  9 Apr 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199022; cv=none; b=jNxkzWMGw62WuHgJmp4+1MoE0nqETxufm6s+L5XM9fZyu8huESw3JGRIN8DYQtdoxQZZjnKfnxTqy4q214ypBhyQQF5mEnWpJslMc8uh2znHh5I1p0oxFI5+xW+LmG/5LKpSZ8LhQIFVEGxpqW8KJu7nBKLdR3N1MTPZb6a+9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199022; c=relaxed/simple;
	bh=7x2Ww/8t207kNntVHldmoaSNNhjSpbEKuUzDA0pk2+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/0exSt48bfZkMP666cl0TGaso+Vz8iBIVIbdWb/v3yLuxIVdE01UXev+JrKYxmJUkFwjfCkof4ctPi0HwkvbGnV6wP9zlPDDTPlnJQSxjIgVpzPccT8SO+L4xXtNMYqF2JCVcl6ZNx2bnjyB1nzUZ2ZCpBVkBsWiz/DZJ7WKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2PK4x5p; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30c0517142bso59680561fa.1;
        Wed, 09 Apr 2025 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744199019; x=1744803819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBMK+0yCj5pVI3lWqjEquwqkVpMB0DEP0oWlPoEM9ds=;
        b=c2PK4x5pGBs/47TRp4qitXsySCgi0XWc89nmlJl/p2VbmYIU2Ft2bscvoNjvP4GUGn
         7r9Qqnr0WCzBLfQ5PwAqzqHOw05GIR5pe+9amNEWxEWi9xhtqNwNoU4CNOUu5fn7aCPZ
         QMBuly38mjTBdALIZeOWwfjCADQ467OMCpHcqmH7w8ML+mLM3yakNnlyQHKkJ91nYgFm
         U98hVU43R78SYzeSbHVf8SbccK/B9B0+mqEkT8CMIB+u86fWRDizpwWlVscDEhmuO6k1
         6bD7OkFFUEOm/c0xCL3bG/heS4NQnW5n+ziVJ9PNW3pHHdpqWTVftL89HdkiyHcHWtLJ
         /tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199019; x=1744803819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBMK+0yCj5pVI3lWqjEquwqkVpMB0DEP0oWlPoEM9ds=;
        b=mZZyFjRHwLLBd8qZPiFMdDmwodjtWXGEwZerZUDvnZu2QBrKMwGcCH4M0nL6JUOaI3
         ppFATDLr1VTvKgGUVVow7fULtoVowTG45EtP3RRYqxx1NOy/ggtqBQNgBLdu2p35CFg4
         XVdvwAUhKw9RoEem6SyxzA08NUeC+yfcRiznhAqj9ojeQY8Z4U3yaVucUKX+jvekXMeN
         LkF3PHT22qXNXicIsZkPMVMP8Or68K8Fl74s3zzOxUgW3oSuRQjZSklxlCSGAO7RrwYu
         9XPATFzXGsN/aQEdah6GND5y0FYA/Us31Cm990DP8yRP3i1Y5ob2eSd8XqpLhMLPUysv
         64vw==
X-Forwarded-Encrypted: i=1; AJvYcCU7R8gYuxWAsl4jTzpSaDK1IWav07B/Unr4YRdjsDeZhtVJfo9htvRj5Ovpcag3EmQAkY0z1aUSQH0bgJCmKTc=@vger.kernel.org, AJvYcCVlyfHnZpHEOCF4zrd+c061CUjvZcNVkc2vFiXRNiNsYe51UZPm3Rhb2J8Ln+tMpDaWa2D/YATBewuaVmzl@vger.kernel.org, AJvYcCWye89G7bhWhtzAttOUQcvbmxJjYFqNv6kMSJXOdedDx4Z5N8SoRsEYFShKIJ0TFKOkH02B5fYI@vger.kernel.org, AJvYcCWzcz8jLYQyK5HTBuCTm2yhbRQCd1hvkLC0bygQ8ydalCZcgMjINIpigVxw3aXpFHyvRmfgnOvZnOWy@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaJHl6glqbCysG5IRQLqm0QIPZvJz4cPyXjiEdr/4HMrnyPzL
	rmVeaLqaufFd34NZqE8DkcgrCGSq9RgSTh1MRVn7m0RUZSx2tUGM/o/kURvkwYDwvtrwm243ea0
	fDzuRqLD56t+ifZcF3Y3D6FA3MZM=
X-Gm-Gg: ASbGncsVaBlH8wgIav7lJgQdWnz0mfYe00nrH9fMcW/R2jA93zJQ5OLNtX88kCQc1Nb
	jecLvlovBaDknNlLRSzchI9J0r3HQ9lqRzKaVFW1bXz34v+Hd/WLzsqOA/VXTV251j2fAvx6r/D
	EUDhAkR6x+n1sk/AfASTtiIQ==
X-Google-Smtp-Source: AGHT+IHLILaO4FHiXQ6HEiLldUu+4jbxiwgECUQrUvKhKnrG8lAE04WZLWRoT4ZI6kZE9adL8Z8pGuxkMOFYudtSW8E=
X-Received: by 2002:a05:651c:556:b0:30b:ef98:4653 with SMTP id
 38308e7fff4ca-30f438c8db8mr7664881fa.36.1744199018584; Wed, 09 Apr 2025
 04:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <66e54eb9-58b3-4559-af32-66a77fe1ea01@kernel.org>
In-Reply-To: <66e54eb9-58b3-4559-af32-66a77fe1ea01@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 9 Apr 2025 13:43:27 +0200
X-Gm-Features: ATxdqUGmbJ5OXHqfwIkM9Wrb_lrcpIIkF68sC66bDwJWw_DGX50EuQ2sGGGHMMs
Message-ID: <CAFULd4YiYRhqu7mGWMN9pAsV-Nc6a97+EgiTCR34iaYDvXjDwQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] percpu/x86: Enable strict percpu checks via named
 AS qualifiers
To: Jiri Slaby <jirislaby@kernel.org>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org, 
	netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 1:07=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
>
> On 27. 01. 25, 17:05, Uros Bizjak wrote:
> > This patch declares percpu variables in __seg_gs/__seg_fs named AS
> > and keeps them named AS qualified until they are dereferenced with
> > percpu accessor. This approach enables various compiler check
> > for cross-namespace variable assignments.
>
> So this causes modpost to fail to version some symbols:
>
> > WARNING: modpost: EXPORT symbol "xen_vcpu_id" [vmlinux] version generat=
ion failed, symbol will not be versioned.
> > Is "xen_vcpu_id" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "irq_stat" [vmlinux] version generation=
 failed, symbol will not be versioned.
> > Is "irq_stat" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "fred_rsp0" [vmlinux] version generatio=
n failed, symbol will not be versioned.
> > Is "fred_rsp0" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "cpu_dr7" [vmlinux] version generation =
failed, symbol will not be versioned.
> > Is "cpu_dr7" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "cpu_tss_rw" [vmlinux] version generati=
on failed, symbol will not be versioned.
> > Is "cpu_tss_rw" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "__tss_limit_invalid" [vmlinux] version=
 generation failed, symbol will not be versioned.
> > Is "__tss_limit_invalid" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "irq_fpu_usable" [vmlinux] version gene=
ration failed, symbol will not be versioned.
> > Is "irq_fpu_usable" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "cpu_info" [vmlinux] version generation=
 failed, symbol will not be versioned.
> > Is "cpu_info" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: EXPORT symbol "gdt_page" [vmlinux] version generation=
 failed, symbol will not be versioned.
> > Is "gdt_page" prototyped in <asm/asm-prototypes.h>?
>  > ...
>
> That happens both with 6.15-rc1 and today's -next. Ideas?

https://lore.kernel.org/lkml/20250404102535.705090-1-ubizjak@gmail.com/

Uros.

