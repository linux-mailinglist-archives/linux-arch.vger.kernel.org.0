Return-Path: <linux-arch+bounces-1430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688CF8372A9
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189D1294615
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A0D3F8C4;
	Mon, 22 Jan 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLUHDki6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EC3B790;
	Mon, 22 Jan 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952103; cv=none; b=U0PRKLaR9hZtOSTnoBsNNSKbhMRkD4NM17299HDhY3N5h4F0qYyBuAViZ6DvF/zcGFZXYKo54MQ9s7nkCXGUiUuKztNh4MqiyU+CZvHdGvvUmfEKVSuoFD0lGMm3d69JtdGE2vhuqhx2YG6r53b4BfvatKkB4L/SCzV5oR6Rbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952103; c=relaxed/simple;
	bh=vdvpcTidybzQ1RK072QFzF5p8j2Hvk8YbCbq1G5RlCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jP83d0Emhd+jp748QHz+iBLwKdq9BBAOcwuo2iPX/cQjK6aUDkCQDH76j87c7hC4lMhfAy4owdog3v9PffPUBBfN6a1IVE6BIDaq+ZnUosj18/b2amFX/HVV7WXUMLix5Dl1tjn2y1IwofnOc23iN2XXfmuWR3Fpgrfe3GgewVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLUHDki6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so4737029e87.2;
        Mon, 22 Jan 2024 11:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705952099; x=1706556899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsyX6o96ll0tborqmT2tH2D5yYkTiItob646Hhae/V0=;
        b=NLUHDki6j21vUA3iMM5sEiD3mJs/BfCmFlXnWEGxUelkswe9SCLBsiRC4rbyePxeVi
         qmMPWLmvFXKG3LDjCxW9VyUHwJqDDjOA3VFEBZnM00hLkts82ITWcpgfFIHITe//f8tS
         OZ9dOtsu90PenqHumlvepYSXywBnK6z3HUiqu+ln6XgmQGzvKRy+2i/ZiRc0zYkx5OPb
         dZ8c+ZaQeXSwaXqQ3Q9PG20v0R1whS9yawOIzVl+tdEOCtbV4KfBRnY/rbsM63GsruOF
         gsEhv2MiMRbL6Q/ieopTKNHhqG4V+8zqPYVHeqNQDVuIb7/qBMNXZs0RG5o1cIHyI7Vr
         vviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952099; x=1706556899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsyX6o96ll0tborqmT2tH2D5yYkTiItob646Hhae/V0=;
        b=d431WbVy2xgROFyETDwyL9YB4dB+J0o1+RzPQUGF04StFuBzr8XdH2PlSnNiR4Y6+Q
         MO4F7YqPRK9n2K/bEtPUFRif44fDMLsEaVB4EzB0ZCM2VKctqJJgSaXt8/oPTZSEMd6D
         nDCJnAfgnZOtKsSGQV29qqSGSBaOuIqaK7G4iNDNSW9l6VOwmkGm4cK+PPuVU6c1Qzv2
         d0knVMXTHYzqdsCP0CFHa0QRmARm+tZ00UQb41Cj4VILWPC7LrHqWK9LN1bTYbqPTgeE
         dYJoNxiq43MeFr8a5u9pjstmoyt6bnRNe2q3sew59toKQgQ+2F9PSHXwCV/wLLytLzMU
         dJZg==
X-Gm-Message-State: AOJu0YxDMZ/th8aNhetDaYfyROQgYtH4pyFv7k6cOt4+80XT1cOG7ETW
	3AzZzxiQPzJsEXsuPDV73vWWLc35mP9V8WU2RWBkoHORo7WI4XdgVnPwrs8H8nsboJ69qreTGly
	7fQFJzD0IoPeczsOXvK0P0XOhHA==
X-Google-Smtp-Source: AGHT+IFitbZJ/8g2IdDBY826s8oZ0mtT6w1M0vukl8ff9CMkxM1Ayl6tSHcD4WdNXux41i0H/QurAc2g/9qBGoSonow=
X-Received: by 2002:ac2:5471:0:b0:50e:67c5:9854 with SMTP id
 e17-20020ac25471000000b0050e67c59854mr1869713lfn.123.1705952098697; Mon, 22
 Jan 2024 11:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com> <20240122090851.851120-11-ardb+git@google.com>
In-Reply-To: <20240122090851.851120-11-ardb+git@google.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 22 Jan 2024 14:34:46 -0500
Message-ID: <CAMzpN2jcWxCy=H-1uvS7kN8gVohee2_cMwyC0SbSEwEoedo3WQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] x86/head64: Replace pointer fixups with PIE codegen
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:14=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Some of the C code in head64.c may be called from a different virtual
> address than it was linked at. Currently, we deal with this by using
> ordinary, position dependent codegen, and fixing up all symbol
> references on the fly. This is fragile and tricky to maintain. It is
> also unnecessary: we can use position independent codegen (with hidden
> visibility) to ensure that all compiler generated symbol references are
> RIP-relative, removing the need for fixups entirely.
>
> It does mean we need explicit references to kernel virtual addresses to
> be generated by hand, so generate those using a movabs instruction in
> inline asm in the handful places where we actually need this.
>
> While at it, move these routines to .inittext where they belong.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Makefile                 |  11 ++
>  arch/x86/boot/compressed/Makefile |   2 +-
>  arch/x86/include/asm/init.h       |   2 -
>  arch/x86/include/asm/setup.h      |   2 +-
>  arch/x86/kernel/Makefile          |   4 +
>  arch/x86/kernel/head64.c          | 117 +++++++-------------
>  6 files changed, 60 insertions(+), 78 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1a068de12a56..bed0850d91b0 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -168,6 +168,17 @@ else
>          KBUILD_CFLAGS +=3D -mcmodel=3Dkernel
>          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
>          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
> +
> +       PIE_CFLAGS :=3D -fpie -mcmodel=3Dsmall \
> +                     -include $(srctree)/include/linux/hidden.h
> +
> +       ifeq ($(CONFIG_STACKPROTECTOR),y)
> +               ifeq ($(CONFIG_SMP),y)
> +                       PIE_CFLAGS +=3D -mstack-protector-guard-reg=3Dgs
> +               endif

This compiler flag requires GCC 8.1 or later.  When I posted a patch
series[1] to convert the stack protector to a normal percpu variable
instead of the fixed offset, there was pushback over requiring GCC 8.1
to keep stack protector support.  I added code to objtool to convert
code from older compilers, but there hasn't been any feedback since.
Similar conversion code would be needed in objtool for this unless the
decision is made to require GCC 8.1 for stack protector support going
forward.

Brian Gerst

[1] https://lore.kernel.org/lkml/20231115173708.108316-1-brgerst@gmail.com/

