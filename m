Return-Path: <linux-arch+bounces-7437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9C986710
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759B11C2139D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A31465A2;
	Wed, 25 Sep 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZkUu8R5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5C145B3F;
	Wed, 25 Sep 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293189; cv=none; b=gBn0HcoeidukmcoIqUYxw+GwLpJGoklFrzhzjz6nerB6dCgEsNc8jMReiQJ9HgvXwxdrtZMU4loG3Nm+bAjcExTlMQbPjFOdHe11jdNPteB/0TfNg8fbw9AneUxVoNlHOzuXJ1rX4FxJ8Q9povRXGECmCujGVkcVafYv7FhsLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293189; c=relaxed/simple;
	bh=yp4KiWnI55kflWfEV5sb0zGnBH7ciSvhguN8q9bReGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVAJxKoVwIKwQEsxCG4GjsH2YVPIstRGEIUQf/OOMK+x5iO/0wGWh6GJMfLfo4IdOKjLuv0kk8/CRguQyICd7QlZWLuhZfKohr8+QOPdRY5A2JDZrOWToKmSQqZVujP3nEo8/B+Mf7vLBg/wzPEPUMoibLhCFIX+j3DN4g4iRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZkUu8R5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f763e9e759so2184221fa.3;
        Wed, 25 Sep 2024 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727293186; x=1727897986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp4KiWnI55kflWfEV5sb0zGnBH7ciSvhguN8q9bReGk=;
        b=jZkUu8R5ll+DFw2avT8d4Di1w119iptUGIghf+ne52PC9QNpnD/YBnV3xDsfoOahSH
         rSTRQVTGcXqKpolYy57QYjcvQOzHUMBtYgY4MuLRyo1atTevlnl6xnA7vQGJu5oQJezJ
         4QyrzOM3w2VjZdaJXARptVvQj3EtFyww98h9Bbt4WD0WIQA3IeGACEkUyv/vaI2VbwpS
         SnBKgo05WKiyB4iRGP2Jl4rtPlZLbStQ3WsGOMHivEXDD0rEhu9/QZTqMgNgenwFcuS4
         Iuu9JSnptaFH6zG773uDBOi9tINZrQ1Q+ztNqWuCUaEjoMeDxpwUCc/sin2k1iUG0wQN
         Rbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293186; x=1727897986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp4KiWnI55kflWfEV5sb0zGnBH7ciSvhguN8q9bReGk=;
        b=YcNjovCnddQBoypp3Nvspuqj7lVK+ld1v+GzlvDidabdVRgCkiQwqabLKaFMjbSZMs
         BV/ffGXbdzoUtcXNmg3j4DGrBeneZgdH6EXDCNk1yqDOAZ+NzUDm2vBmxKptQrrh6PUB
         7dHBxCVcVJ0BxVP4lrWhwtTF3joU9QsVfu4dFyVSNRnKBQj84mrThU0pqaLyRxvaCbzE
         gooSwPWsKx46tZoWAtiW+I3A0AcLgPFeBZHevGoJv5YZDMNqtl2HbjyhBMr6Myo9VghU
         dPTUSauzi3dJVsfasWhJebrk71oWNOiX1frCUaB0YHYkVdXFPRsfGCWFyo37pcEpJYO9
         lyoA==
X-Forwarded-Encrypted: i=1; AJvYcCUGTgBHGZ1j8QyAVfZ2kR/+BL15iS0H9cvaCsEUu5K97lS64jCt/DBNnAmYt67uT/LwQURkS9nE4407@vger.kernel.org, AJvYcCUqVfvzIX8qxSiNqzGc6ocwth1yblNVZWNWux0ELlhYyVzptUDZ/7OA3+sU5exbXW9nb6wvjDI5/5v1Dm74@vger.kernel.org, AJvYcCVCDqHCwBl7JUwkq9SkZD3tZf4JfVy4YYWmnDW+bI20IOq8VZX4ATz3QWiQ+AHKT/7USHkdSF3VxFAiWChp7TztRw==@vger.kernel.org, AJvYcCVESRRuGkuQj3U1Sp39n3158tQ5rKzjQAJ2sTfxdy0pql0yVv6M0wIlU3/qO3igxEz1Efmxj2pU8oYlX/0Gs5w=@vger.kernel.org, AJvYcCWAVl/P95x+qVhXzFOF1T4esrAK1PuIWwMfYEkgOvRpuXf0Aaz+PXbt84FPk3sQTGyZ+7Brns8cjYQnm7u+@vger.kernel.org, AJvYcCWLYaTaHrNlUif0o24MM8w3u5RqrQY0+ohc4P8UCQMmKAFnjeq9M04yc40/Sf8hdkvSh5rlyG3gha5v@vger.kernel.org, AJvYcCWaHDR2rU6WLmS8Zlk6542MxaoPYiCxlGv2SR7TwOVVtnhUvuaAxVHCIjZzIAAjzWCFPtnWXl1qoWw=@vger.kernel.org, AJvYcCWkCegGcUgSI4ZhaUeefpSqGrzjX9vd9fBK4YQVSHBXXDmTwBG602FcZCVr/DBijqPvRfE6Y8GkM0jXhteQ@vger.kernel.org, AJvYcCXH8vQMeHxTKBy3MgDm195IDBcI+ZPBPS36wJBfO2YCX3CZYHD13+GL9ZxWCjKGOKgmAUiVBLPhMSTgMQ==@vger.kernel.org, AJvYcCXkfViL/zWM
 ANsr0DbWeuHpI4NFKZAwTAFr0WViUDc4SHZoYUbS6157+L5RahTRjS08IJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Rp2gNJxDM3Hvv3OV4RbI01YZEULB6WbzBGMaOQfWruBFSdLr
	exoy8pb681XOR8/kaMy5gSwE0+sxhuCGVmUqI2BilL9AOct/gsPndymBjVO5A6mexoKcfTHvs/X
	18v7tugmzvs3bt/mEfSKimZh0DCA=
X-Google-Smtp-Source: AGHT+IGDMO+ONSKS8XitoA0ITEi5U77wfWogthP7KZ5PTbGU9A+6a8gl715c2Sg7nQwKl7GBJXFXdPzETY/KKnoKxqg=
X-Received: by 2002:a2e:a553:0:b0:2ef:2e8f:f3b3 with SMTP id
 38308e7fff4ca-2f915ff665cmr27096641fa.21.1727293185428; Wed, 25 Sep 2024
 12:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-57-ardb+git@google.com> <CAFULd4YnvhnUvq8epLqFs3hXLMCCrEi=HTRtRkLm4fg9YbP10g@mail.gmail.com>
 <CAMj1kXEL+BBTpaYzw_vkPdo18gF0-gjxBMbZyuaNhmWZC8=6tw@mail.gmail.com>
In-Reply-To: <CAMj1kXEL+BBTpaYzw_vkPdo18gF0-gjxBMbZyuaNhmWZC8=6tw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 25 Sep 2024 21:39:33 +0200
Message-ID: <CAFULd4bLuHQvHNaoLJ4DoEQQZZF0yz=uD27m49M+AbYnh=+NzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev, Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:14=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Wed, 25 Sept 2024 at 20:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google=
.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Build the kernel as a Position Independent Executable (PIE). This
> > > results in more efficient relocation processing for the virtual
> > > displacement of the kernel (for KASLR). More importantly, it instruct=
s
> > > the linker to generate what is actually needed (a program that can be
> > > moved around in memory before execution), which is better than having=
 to
> > > rely on the linker to create a position dependent binary that happens=
 to
> > > tolerate being moved around after poking it in exactly the right mann=
er.
> > >
> > > Note that this means that all codegen should be compatible with PIE,
> > > including Rust objects, so this needs to switch to the small code mod=
el
> > > with the PIE relocation model as well.
> >
> > I think that related to this work is the patch series [1] that
> > introduces the changes necessary to build the kernel as Position
> > Independent Executable (PIE) on x86_64 [1]. There are some more places
> > that need to be adapted for PIE. The patch series also introduces
> > objtool functionality to add validation for x86 PIE.
> >
> > [1] "[PATCH RFC 00/43] x86/pie: Make kernel image's virtual address fle=
xible"
> > https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgro=
up.com/
> >
>
> Hi Uros,
>
> I am aware of that discussion, as I took part in it as well.
>
> I don't think any of those changes are actually needed now - did you
> notice anything in particular that is missing?

Some time ago I went through the kernel sources and proposed several
patches that changed all trivial occurrences of non-RIP addresses to
RIP ones. The work was partially based on the mentioned patch series,
and I remember, I left some of them out [e.g. 1], because they
required a temporary variable. Also, there was discussion about ftrace
[2], where no solution was found.

Looking through your series, I didn't find some of the non-RIP -> RIP
changes proposed by the original series (especially the ftrace part),
and noticed that there is no objtool validator proposed to ensure that
all generated code is indeed PIE compatible.

Speaking of non-RIP -> RIP changes that require a temporary - would it
be beneficial to make a macro that would use the RIP form only when
#ifdef CONFIG_X86_PIE? That would avoid code size increase when PIE is
not needed.

[1] https://lore.kernel.org/lkml/a0b69f3fac1834c05f960b916cc6eb0004cdffbf.1=
682673543.git.houwenlong.hwl@antgroup.com/
[2] https://lore.kernel.org/lkml/20230428094454.0f2f5049@gandalf.local.home=
/
[3] https://lore.kernel.org/lkml/226af8c63c5bfa361763dd041a997ee84fe926cf.1=
682673543.git.houwenlong.hwl@antgroup.com/

Thanks and best regards,
Uros.

