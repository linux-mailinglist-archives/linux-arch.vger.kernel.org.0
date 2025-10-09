Return-Path: <linux-arch+bounces-13990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733BBCA237
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B8D189CCB7
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8B21FF21;
	Thu,  9 Oct 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9qbG4Vz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C921B918
	for <linux-arch@vger.kernel.org>; Thu,  9 Oct 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026352; cv=none; b=u7jmXgPZ4j+DPJ2O9HTWMR86CxHYFMjgRDD4KkTHUdck4kJwzf22ig5houjqeKzTt2O79iIaAYgIiuhi5SMA8t9z9ChqlAnj+yhIKm6WJVZOCFKf9aZpV1LjeZlc4/IfgoMhJWeanK1niSYj3wNRMPTDh36P83u4DzFOUADNnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026352; c=relaxed/simple;
	bh=vt4Xr6majFlHqQzO6UU/LJul2QasGvXgAd+DJc28JMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtjuF6WsGMmaXhJo4/WO/DVgKQIyG2ZBm+o6T8U4CtD8Z9JULGGZceMQYh0mQvYiLvByWh/y6R9x1wMltqHJ6VDrZ5GZiTqzpA8avQpPPfgtxqqj8iOSVwRt5hA3s8thckUTEumlcOLxzCOk5+25VZmtOiRIfqS1cgX89El/vxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9qbG4Vz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso8485965e9.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Oct 2025 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760026348; x=1760631148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt4Xr6majFlHqQzO6UU/LJul2QasGvXgAd+DJc28JMo=;
        b=J9qbG4Vz6uAkx2+Unz5KNMI4Ycv/n9Gv+EX8ZVjOP945xoEv5nJt1zCGp+nyvBgs/P
         4YXNXPgTTbofdtaf6B457UaYZie7+bcRA3uREZZ1XdHQVtiFtBshjVJVzerbqtvfz3Q3
         rJEzOIvhNqK0qZXNtTy3zbTmBcUumNLM3gSyCKlLswjm770TMXte2GkTXBOfTJO+CObk
         Cd29ODmlLyma7Hs2Psby/9htyOFJxsn5U6YE/kuTMzvmYAcNXAtHpUSetDNpAYMCsApi
         P58q5NBhNnOhJC6emL/ifjr37PvIVIRH3tADHqaaqD6nWHxsxiIGpgj4xB4bbw+dQW7/
         bF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026348; x=1760631148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt4Xr6majFlHqQzO6UU/LJul2QasGvXgAd+DJc28JMo=;
        b=gCvPZfa9wMBrGuYVNB8VYi+1UYrNDbzxF/52K5y16lmojuJa/Npvp4AGIhQP3lz0I4
         xPbyv48NjBG8Y9bSjwTxim7lrPOiadyy5TWurOa0DcjRd/OFUucmzDohfK1GqMG9HJEt
         SwDHpOHahpoKOryiCrYAJ58l2yM5F7gnvZI/KgR19IPYsZJNUZaPzsoK2LrQZFutiSnR
         rj0VIuVbLr6gZ6AzrvuG/nFqQAlkkOrPv/SQMS8SPx0vOJ7z8SNd+AjfjwYHkXUyYMIO
         3PjRpaBiIK13AOY//1neeSfgcKeUpW+HgLyJXTk9lOtknBxxK2dMRCEaAlLi5k3BIqVv
         DZvA==
X-Forwarded-Encrypted: i=1; AJvYcCUp6M8lDrbeWeRK/TneIcthMqKuLCepEXdN+Bf9JJq/46tDGJJO1PzOAJN6o9/diB8RoTykm9Y3u0Qw@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8Ar1xvAYak8tgUOoukZATM8+FkyJLog23aYLPKjiYDmECoBk
	1lydEhfu2IgdirADojPeIBSM8Shet/Dts4ftBW3wFJUFZKgFp1TECmxFGyQNNCV+AQWQd9Y8/6/
	wZKq8/tyH1KVzyQLrc8oUGBw5q2Qjcsc=
X-Gm-Gg: ASbGncuytl9FxEm2JW7S7GIutBaHgBeifK84MB7VWo9P/SNp9nGSVQeOVwsGjQF/M1y
	7HBXAN9ra5NZgrjeatSRGbdMGDbY9Uz+EfTYb2XsgJ3EWjgZP8DyfPsJWgooz9SAbcMvd+htE6d
	vukpA1rpmJHh+1E5DLC3pKk9pje4nXb/4MkK/05oZ8cK8a7fIOiWLZzua8x9RllpRLHbxrDhvbH
	/KAsAR6/IPE2OZCGBRIGbxC112WH9SWXCtIwMAYPKSnkqODFfjzo0J0d1XsLxbr
X-Google-Smtp-Source: AGHT+IFI12A7o4l5UIWszOSSqVwW7+IdmNEVBD602Qs920M96fLWTNMVF9DKFjQfLowasrstk8O4FuoK3byvRdyjw34=
X-Received: by 2002:a05:600c:19c6:b0:46e:3d17:b614 with SMTP id
 5b1f17b1804b1-46fa9a9440emr67530035e9.6.1760026348350; Thu, 09 Oct 2025
 09:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759875560.git.fthain@linux-m68k.org> <807cfee43bbcb34cdc6452b083ccdc754344d624.1759875560.git.fthain@linux-m68k.org>
 <CAADnVQLOQq5m3yN4hqqrx4n1hagY73rV03d7g5Wm9OwVwR_0fA@mail.gmail.com>
 <20251009070206.GA4067720@noisy.programming.kicks-ass.net>
 <CAADnVQK1GqQKxdoM9e1Z92QK68GEjqgMnC36ooVgS1uUNiP6eg@mail.gmail.com> <b9ab4c28-52c8-4fa7-85cb-109ef4c0d7f4@app.fastmail.com>
In-Reply-To: <b9ab4c28-52c8-4fa7-85cb-109ef4c0d7f4@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 09:12:17 -0700
X-Gm-Features: AS18NWAh8o7ul2E7KaW4Pi6pgz_IUWTKFALZRPApDvY8RHlwRKBhNejOgDh2MHw
Message-ID: <CAADnVQL9PRCVEJBJ++TCRBWqshQLn7dz0SiJ6KWDYPeWLSK22w@mail.gmail.com>
Subject: Re: [RFC v3 2/5] bpf: Explicitly align bpf_res_spin_lock
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Finn Thain <fthain@linux-m68k.org>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Arch <linux-arch@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:02=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 9, 2025, at 17:17, Alexei Starovoitov wrote:
> > On Thu, Oct 9, 2025 at 12:02=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Wed, Oct 08, 2025 at 07:10:13PM -0700, Alexei Starovoitov wrote:
> >>
> >> > Are you saying 'int' on m68k is not 4 byte aligned by default,
> >> > so you have to force 4 byte align?
> >>
> >> This; m68k has u16 alignment, just to keep life interesting I suppose
> >> :-)
> >
> > It's not "interesting". It adds burden to the rest of the kernel
> > for this architectural quirk.
> > Linus put the foot down for big-endian on arm64 and riscv.
> > We should do the same here.
> > x86 uses -mcmodel=3Dkernel for 64-bit and -mregparm=3D3 for 32-bit.
> > m68k can do the same.
> > They can adjust the compiler to make 'int' 4 byte aligned under some
> > compiler flag. The kernel is built standalone, so it doesn't have
> > to conform to native calling convention or anything else.
>
> I agree that building the kernel with -malign-int makes a lot
> of sense here, there is even a project to rebuild the entire
> user space with the same flag.
>
> However, changing either the kernel or userspace to build with
> -malign-int also has its cost, since for ABI compatibility
> reasons any include/uapi/*/*.h header that defines a structure
> with a misaligned word needs a custom annotation in order to
> still define the layout to be the same as before, and the
> annotations do complicate the common headers.
>
> See
> https://lore.kernel.org/all/534e8ff8-70cb-4b78-b0b4-f88645bd180a@app.fast=
mail.com/
> for a list of structures that likely need to be annotated,
> and the thread around it for more of the nasty details that
> make this nontrivial.

I see. So this is a lesser evil.

Acked-by: Alexei Starovoitov <ast@kernel.org>

for the patch then.

