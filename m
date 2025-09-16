Return-Path: <linux-arch+bounces-13655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80D6B59305
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 12:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F751BC2F18
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD42F8BCB;
	Tue, 16 Sep 2025 10:10:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8502BDC0F
	for <linux-arch@vger.kernel.org>; Tue, 16 Sep 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017457; cv=none; b=QKj4E6PY+XBCAExebEHteHfCgGyHVseDTsIyThXv4THS47kypMzfzvSpO28Ur0B5r2m/Fx+NGITjpqdqVxbh+8f2KA2k163EHW/3BTkwhin4mMuTE2CQ5dwN20uht9FXYlZOO+y2Hm6gywyA4KaVj1Yp+tIeR+yb2Nle1y8Pd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017457; c=relaxed/simple;
	bh=/9wF0vy0tw5T0bKnAANkQEvrwPKBiKOdApMI1SEJeAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XX/l4BgLbNPDDLtQ7yPPV/PklTE5c1ABp7LxPjc3+kU7jaiZlwZl2VCb//fQRZ90eYz/hzajfuw+U2JfyYFsyik4zo3Dps8VXu/GAIUB6VXy6SSGXnZryuBvebfu5K/yjfb8JTM+KjewkTIR4L45gIAxBLQCL6xC10UMqBpCOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54a1bc43aacso1001821e0c.3
        for <linux-arch@vger.kernel.org>; Tue, 16 Sep 2025 03:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017454; x=1758622254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1pUZdanyHlRQIc45clyhD7FxJZAK/SGkllVoia3idE=;
        b=XvIn6gvMe9ijJ572VpFP7WllaM3df9BBWJvMJVOhDnnyWY5RzKiajpkRuhq4Gn20Yi
         aHHn4jO0Bw/Q6PORrthBvCQ2wUVHlRTHqnZ4p79fUmGtbhqi5wyERQ/U/KmWaZHFLaSS
         v+WVaN81MZMnuXv22q9zlOK7zYr1frvKt0wAfVejEmjusjiZ6IwMpI3KS40otyQtL4Ia
         v+Bh4mo73pg1TVBd3SU/KNBpTbSf30kShTS/Zh5A4CHOrZd36fAREr3PLiISN7QL2ghE
         koCtpq6PtBz/xjDRQWK+EfbEARshWTSSsMIeuevDN5AEemogkgewdYRcMEfELSFk3pZn
         n25g==
X-Forwarded-Encrypted: i=1; AJvYcCUp0lNASktte29HUPVhF/M1PZJs2E7TWPjSOwvxYjv1MELOR3p4wnoPUCIK0W/xPntR97PRROFXwB6a@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oFv8j82VZ2wxdTSy7yQCr1i3KlYZlS3KXEqqUSTbE2vXIqd4
	akZApeB9OPjVElSY71OR2vAurlq+ONDbHkDImQTuZ6CtgjW4SkD2WLGttNxUtzjc
X-Gm-Gg: ASbGncuLSP+w3CRYP4NNMIm5SikKY3n17bCiaFDSUTvoOHrAE8lFtP6lbE6zN246GaJ
	p0pAtg9X2uENjyLxv64R3xB/N1L5WtNt8fOuDAh6MMj59H0v+IglJ+8T5zc2nx0ipFqsJN7Z7iy
	IjmVPHZXfsoWrYMfGUqARzvfhFfVhy6Px4zKF+aYoLY3ewbgEIwk57mEQEo9+4q6ASuOJY5ES0q
	HjcE6tVN+9u0g4VgUDVUpl1lEPEMqCPNlDl00dbkJV5zCinV7qKd+YlLQfo0I2tGmNEP/yhMWY9
	vHxeKyrMwJ+/DgGIbSJDIwTSvTSGH6V+vQNm1kVAunkjGJhKSxrZfB/ug9EImuLfUuVrvSr+SFu
	HJXjnQh67lSI5y2Z88jcD0M5GOlgXbSTfHzBlhJT8CcUnNoHlH4re6iObjlHV
X-Google-Smtp-Source: AGHT+IFKedVoH7mH4uhbi9BB9IaL7cuG+zgH3Dv1Jz3WN9FX8sxRSfluzIIiBapZf0e47rRXASnuGg==
X-Received: by 2002:a05:6122:221d:b0:54a:4b08:a12c with SMTP id 71dfb90a1353d-54a4b08a23emr1419106e0c.2.1758017454488;
        Tue, 16 Sep 2025 03:10:54 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a34c12419sm1131914e0c.18.2025.09.16.03.10.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:10:53 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52e231e3d48so1933888137.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Sep 2025 03:10:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtYBt7avN/+EbeD4A2bQ5ELB303tFefFOA9uZdoS2x+iP6r10K0ImKJIpsLeDdeOpXAgox1zkxsL49@vger.kernel.org
X-Received: by 2002:a05:6102:418c:b0:523:d987:2170 with SMTP id
 ada2fe7eead31-5560ecac853mr4460438137.21.1758017452861; Tue, 16 Sep 2025
 03:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org> <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
 <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org> <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
 <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
In-Reply-To: <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 12:10:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV92Lu646bJ3cmEoR5C4rfkFsaf0E_uYPbSiLwrTtMbTw@mail.gmail.com>
X-Gm-Features: AS18NWBQnqcmNaklvhAZCp1NFZT2CLc-AZ2UDUvO79JO3zIGXT7yGUxg2731AZo
Message-ID: <CAMuHMdV92Lu646bJ3cmEoR5C4rfkFsaf0E_uYPbSiLwrTtMbTw@mail.gmail.com>
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic operations
To: Finn Thain <fthain@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

CC Adrian,

On Tue, 16 Sept 2025 at 02:16, Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 15 Sep 2025, Arnd Bergmann wrote:
> > On Mon, Sep 15, 2025, at 12:37, Finn Thain wrote:
> > > On Mon, 15 Sep 2025, Peter Zijlstra wrote:
> > >>
> > >> > When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
> > >> > - 1) probably doesn't make much sense. But atomic operations get used on
> > >> > scalar types (aside from atomic_t and atomic64_t) that don't have natural
> > >> > alignment. Please refer to the other thread about this:
> > >> > https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/
> > >>
> > >> Perhaps set ARCH_SLAB_MINALIGN ?
> > >
> > > That's not going to help much. The 850 byte offset of task_works into
> > > struct task_struct and the 418 byte offset of exit_state in struct
> > > task_struct are already misaligned.
> >
> > Has there been any progress on building m68k kernels with -mint-align?
>
> Not that I know of.
>
> > IIRC there are only a small number of uapi structures that need
> > __packed annotations to maintain the existing syscall ABI.
>
> Packing uapi structures (and adopting -malign-int) sounds easier than the
> alternative, which might be to align certain internal kernel struct
> members, on a case-by-case basis, where doing so could be shown to improve
> performance on some architecture or other (while keeping -mno-align-int).

indeed.

> Well, it's easy to find all the structs that belong to the uapi, but it's
> not easy to find all the internal kernel structs that describe MMIO
> registers. For -malign-int, both kinds of structs are a problem.

For structures under arch/m68k/include/asm/, just create a single
C file that calculates sizeof() of each structure, and compare the
generated code with and without -malign-int.  Any differences should
be investigated, and attributed when needed.

For structures inside m68k-specific drivers, do something similar inside
those drivers ('git grep "struct\s*[a-zA-Z0-9_]*\s*{"' is your friend).

Most Amiga-specific drivers should be fine, as they were used on APUS
(PowerPC) before.  I guess the same is true for some of the Mac-specific
drivers that are shared with PowerPC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

