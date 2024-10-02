Return-Path: <linux-arch+bounces-7631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB8598E3EA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 22:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3938D2818EB
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B109216A1A;
	Wed,  2 Oct 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJhATP92"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD7216A02
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899643; cv=none; b=XAucXBoKQ2XWnImVs+aPYXlX2c2n2g9GKmlnDvu9I7bNugOvk7gzmhd+sTQdTgCjLIC9MM+Buz1sAG9AF4/NXnoduKJ8T32gSb3petwd6ClSiWlRz1f+Xzu4XHShaN6c+Hg0KQevWhgfEUV859uoJaL5Nq6GmDb/AzkHVAlOmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899643; c=relaxed/simple;
	bh=26ch3VLdZlgASzApmc+sdmN42sQrSbzi8ri/yXB2hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir51E06vl3QsApMBRCERcBRhl+MEK05pMtDwsgyMhJmucj12Cg5yms0pmbMMSJTCsn51jty5TfxlnH9FAJIwOYfSuKGeE1lA/v92uIZdpY20mghJNSXOsqDpGzixkS4StvJI81vo8LYMY42vAuVLVvi0r/9q2IAw86TNIMW6C1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJhATP92; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso107235a12.3
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727899639; x=1728504439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=cJhATP92k3famVLd/63o6VVgOzWGIguZoa6xa6+pbcCO55m0FAHQBvae300hDg97Cy
         Ls1VxskTIfo82q/vhJfUiwWxBUyPeG/amyM3t76Mu/ydIgenLhEbfzQhg9tnaKoXie8e
         cxkLfZpGv02krXQw8XVHRfnBOVVg7Blzy8iHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899639; x=1728504439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=TJFOnBiGED9fRUqetgpp2rkQcBMGTkdEOTEpNXGu3GLmv9Vbw8CVhxOkire1S8vtry
         64lf9RV3pmyZ/Gos8xfAqGizwJaWy4B2eKvkkGSga78a2FwIUg5bUmf9+98tWsmL00N9
         JSIeHrlaFw6xc+oLrr1fjadZENy8qtM4Vdp60Wmh6Nh6UOpRtsMhEplbNebXholfbsSQ
         GHK+hLL6b5B0hkINjCf9elB33hJfFpVx9tEPkznZloeW+CV5ToQJ4seCZVYk66H0Zqtm
         ciJEoQ8AMhh3xmbqBfqpfPeYSoIbIytykG9d1CRbZKkPXSokIKEfhJAp0SeSu68s2qaM
         wvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn/YBrLkkTfVpvTrig8FCvJTfaiADDjQexMwIZeMjB1pwjFJ+UI4j7a6GP1wTXIwLhVM/JztMIvnN+@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkdgoa31Utaopyq1G9q6kw9xmOcwDGA64HkO2zMHAcxu8BYPu
	YdPG0R+U74Fjuw8BdV8B89osyrisyatCrun43g3p7tz7wSp2XQ0urt54uZhwOYnvKauuAHxR4F7
	+SDS56g==
X-Google-Smtp-Source: AGHT+IF75k49rPMhuHRjs6wT+5Jrlu4tj5miEOZePh9QwfJm18uxs+l0ouwKk1tfr8TQIsApcsNl6A==
X-Received: by 2002:a17:907:98c:b0:a93:d181:b7fc with SMTP id a640c23a62f3a-a98f836eeaamr401670266b.51.1727899639335;
        Wed, 02 Oct 2024 13:07:19 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947feasm901622466b.129.2024.10.02.13.07.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:07:19 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cce5b140bso121750f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 13:07:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6pgMabRRpsoJVrTh24QWQPa3gDcjIGN5VtFb3ov0d+NB4eHF99hmY7kqccT8n1w61FqHgeLZb/wFP@vger.kernel.org
X-Received: by 2002:a05:6512:e9e:b0:535:6795:301a with SMTP id
 2adb3069b0e04-539a079eb59mr2506573e87.47.1727899328912; Wed, 02 Oct 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
In-Reply-To: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 13:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
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
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I guess you are referring to the use of a GOT? That is a valid
> concern, but it does not apply here. With hidden visibility and
> compiler command line options like -mdirect-access-extern, all emitted
> symbol references are direct.

I absolutely hate GOT entries. We definitely shouldn't ever do
anything that causes them on x86-64.

I'd much rather just do boot-time relocation, and I don't think the
"we run code at a different location than we told the linker" is an
arghument against it.

Please, let's make sure we never have any of the global offset table horror.

Yes, yes, you can't avoid them on other architectures.

That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
feel are a complete no-brainer and should be done regardless of any
other code generation issues.

Let's not do relocation for no good reason.

             Linus

