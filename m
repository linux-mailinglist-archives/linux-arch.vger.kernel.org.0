Return-Path: <linux-arch+bounces-5430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CA9335EE
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C10F1C21838
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 04:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8986779FD;
	Wed, 17 Jul 2024 04:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gwMJbG0t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B66FB6
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188950; cv=none; b=p8Wy9cLq2TLfxBqYxaPBKebFocRgHVZI2ccSO59s35nYrBlDTakuXl6hj1mJok4CukM5K1D2378MVYG1NxoXFRjsWnpi3k39Qk0IUpp5uU4xhARYfU+88eDAwB+/vzAt1PYpkfN8YhOtu4j3Ztz33jSZkqyExEJh8QbFI+PtCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188950; c=relaxed/simple;
	bh=+PBwcB9983LmNCN43zPYuSin1XxQnwumx190TVwsnxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE3V+2GXPyRh2s1B61o+TnBx6J1N/rDhmohD/AsOw9tp1YjmJyJk3mz84xq2gNl9akuzRma0dVWfUnCrEYYRT0IRREoPPqL41GeQ78sDqcYlXWEetUDYxMaT8hkdLUFcxfac1omzPbOigtzEBNrY93SASKUg2ZKjJ2DLy4BYhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gwMJbG0t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so689953a12.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721188946; x=1721793746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=gwMJbG0tJIJM/k1sGte6A+Me9dXuCkgtAc93rUM/jbmra6OgoBiQuweDzf/joLpxMT
         +gx4yhcXdnXPDUq9jR6bkBiLXlwx1gyGi2v8fzaD8rVOlynQG0NGPPrWtc8fuCXRsJ1h
         +QKIU+DDxps2FnxdlS/DfrjODAxovep/V9wp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721188946; x=1721793746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=t8q8uvQ2wJPTyP8zYFg02IgNluJWuVMMyc+RNUYG9UOpqWnv7mMINKLltIePrGDOG+
         GuS4hI06kDMhplz1c64cIG/ybJaC+cDe6JV2f8HiYQON4CQgGo8h1PTrB4UJ/xhI2HsP
         VC87MDgMCoyhe8jxKjcn6knI+OGhzMX+NTbnStTYLf1AySKV7mYMeZGhhvON8GI8oXML
         pFY6C53xHdbE0WoMqtagIqBgpIAJizC08BWBhFgz3A9AZbYrKQD4JhGTXQkyP6EnZNzc
         04iAGQ+WHJ3BMuaD4qgDQ0EVIVPx4Wc8HEElE7PG3hu/o3124f5/n20Le/NXtFNOPCFy
         R62g==
X-Forwarded-Encrypted: i=1; AJvYcCWA4Z8t4WN7oFGW5NVwu9MwyjyJn5H1ig+4bEIcG4WD8owhzGXc88rWBq6yWlp4Oa04YGZNIGvE8i175PCoNFOuxD4EdC8Mo4fV5Q==
X-Gm-Message-State: AOJu0Yw1qRB2bDpPv0MkNlwRlAQ6vn9MLUDKuycA6+LDQgh8Q8KI2Jv2
	WdBvxzbPLn50fuKdyHHg1vcl/znbMQ3Hgl/TDH2n8MPibMRW2mjOKPoEelUVEjgavi6lqgGBLYX
	rq2lX8A==
X-Google-Smtp-Source: AGHT+IEXUko3mj23J4+Zsa7aFxfmDqnk8cM8kTNFYAKhSwV6K/LNNNgcyLM+N38xLYnIeUx4CpEFGw==
X-Received: by 2002:a05:6402:524e:b0:58c:77b4:404b with SMTP id 4fb4d7f45d1cf-5a069e9bd96mr574300a12.15.1721188946226;
        Tue, 16 Jul 2024 21:02:26 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24f56ccasm6083978a12.22.2024.07.16.21.02.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so698502a12.0
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVbwW31tCvnzCKSr6a5qNIsM7BLCZxFB9NKmePp5cQu27t/C5mHIdHmtbhOC3OMrznlOnBOpuSG3m/24gR4DbVno7A+mUFzpW41Q==
X-Received: by 2002:a50:8ad2:0:b0:57d:4409:4f48 with SMTP id
 4fb4d7f45d1cf-59f0c41dfa9mr3193440a12.15.1721188942100; Tue, 16 Jul 2024
 21:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
In-Reply-To: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:02:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 14:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Most of this is part of my ongoing work to clean up the system call
> tables. In this bit, all of the newer architectures are converted to
> use the machine readable syscall.tbl format instead in place of complex
> macros in include/uapi/asm-generic/unistd.h.

I haven't bisected things, but I think this code is seriously and
utterly broken.

When I do a

    make allmodconfig
    make -j199 > ../makes

on my arm64 machine, it keeps rebuilding pretty much the whole thing
every time - whether I have made any changes or not.

The second time it should be basically a no-op. Sure, a fairly slow
no-op, because 'make' will go through the motions and check all the
dependencies etc, but it shouldn't *build* anything.

But that's not at all what I see. It rebuilds pretty much the whole
tree (not quite everything, but at an estimate it rebuilds the
majority of files).

And the first things I see in the build log is

  SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_32.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_64.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_32.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_compat_32.h
  HDRINST usr/include/asm/unistd_64.h
  CC      arch/arm64/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  ...

which is why I'm suspecting your changes without having actually
bisected the build time regression at all.

And yes, I checked - it does update the timestamps of those four
generated files: unistd_compat_32.h, unistd_32.h, syscall_table_64.h,
and syscall_table_32.h

Every time.

So I'm pretty sure it's on you, even if I didn't do the bisection.

This needs fixing, urgently. Because it turns a "small pull" into
always taking 5+ minutes for me. I didn't notice immediately, because
many of my core pulls I _expect_ to rebuild everything, but...

Btw, I don't see the same effect on x86-64, so this is purely an arm64
issue (well, and presumably any other architecture that uses
'syscall-y').

You might want to do a build like this:

    make allmodconfig
    make

twice, and then do

    find . -newer .config -name '*.h'

to find things where the build has generated header files with new
timestamps despite no changes.

There are other bad cases, but the syscall ones seem to be the ones
that cause problems.

I'm adding Masahiro to the participants, because of some of the other
files that *do* show up for me when I do the above thing:

On x86:
  arch/x86/boot/voffset.h
  arch/x86/boot/zoffset.h
  security/apparmor/net_names.h

On arm64 (ignoring the above and the syscall ones):
  include/generated/vdso-offsets.h

That 'find' also shows that the install headers thing does the same to
the ./usr/include/ directories, but the kernel build doesn't care
about those.

             Linus

