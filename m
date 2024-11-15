Return-Path: <linux-arch+bounces-9108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1469CD5CF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 04:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EEF9B23515
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC36155A2F;
	Fri, 15 Nov 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CmfODcf7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534714386D
	for <linux-arch@vger.kernel.org>; Fri, 15 Nov 2024 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640793; cv=none; b=M2Gs+sKvIcgNGOcrf7wYr1L4DW4sbO1C0AW83mcCXHBwplYfBN6zfKjylekduFJY+qpSGkZOVJ9E4UAeezpwNHBri6w3GGp0uyVzy0vBanhPgDp7Fkx61FF30acafvTx+158nGoJQwXt0ffdU1l9c6OQ5CsFh1OuEnFnJcw/pFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640793; c=relaxed/simple;
	bh=TPjSJdHo1IX+pvaoqYIQxKWoTfyMnTl7yQ1a19nbTAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geyHnYQLMk57hUSEirnzCoOYMEuO6EAKRWPFnhHidpSxCvJ1KECY8A7gnVucF7jE4A5QAlOlh+ibCQPA3CW88IDgd4BfwZzuouGn6id/pzPC5MDKPF2eUoORVmxdvOxampjxNEfhmNoKgqNouhU5RKNujrWpJPGOT2sBKNdkDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CmfODcf7; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ee763f9779so740902eaf.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 19:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731640790; x=1732245590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wHT7UOLhFt9tb7tI16LMGdFlLAI81aR1dzrwfzW0EI=;
        b=CmfODcf7Y62W+Bc19rBr9jFlEYF9XxADhKpNQWjgp6c6WvzLkOAAUev0WABsNS/XGQ
         RJR+w+9w4u8H9jjcuD6qsPwL1VFpQN3f4YP9ow5QAv4duxuDL/e30i+8ezcDWbTH7sHv
         fMCpxtRXrRCZsEnNs9zCYFMdREzdykXbXd4dh0RgPWGEIl2oOpWtRl9DtfqFcfMOMFwC
         eagYSB4rc5BxsG45wPe0sP+fTHtYt1+uAs29PET1zRQAXQ5BTAKohpywKVN5/lCSTx1D
         oW08ApGDPdyvgJ1gCvAtZwFYLbcAdhIyImrSKxyduwJKYPkBvE7PGLVMHc6AX2xJXRV+
         wyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731640790; x=1732245590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wHT7UOLhFt9tb7tI16LMGdFlLAI81aR1dzrwfzW0EI=;
        b=bxDRBwRDBONcvJQpJ7CMHP1B3XMlYpAue2OeNwYLGt5qXzcS7yh2xjkYWm6KYmH+h6
         PPCBdIFC9mjCYwCecHejhF9Bokg64nLKFOWwWTLye4oZZRSHatYEwCSbD95Tyibc8EXK
         dkE8mR8v2r02gSYhrm66ZeqBUmdeeWmYn6nhJsWA5lJNakw0GXl63yddVOrU8EYZ+iM8
         +yZFKV+i+fvAc/xSJcCZsRcfR00odmH0A9M72y9t585ZlpYLiuHPFQ2fiaI4DgEe4ZA7
         y1jh9Y70TQoo53MXNTZa+qrmvt1E6/dqXRwVn4N8OUdTP3qYuiwFj8NA2S3wfgdd858B
         G5zg==
X-Forwarded-Encrypted: i=1; AJvYcCX+KdC+a6xcHG/gQq/sHN+1TP2jlLjVP3TJa/mn/z7QdGFHckXb3wnUfKFjboyMvqW7xow/1AfAEtVi@vger.kernel.org
X-Gm-Message-State: AOJu0YwF43P6T3XsBmZ7CB1zkPzwpmetVhpGlcSCik6Zv5vDsEC6imiU
	opSgpk8friMiFhJ4VBkCatzWEqL637trnAt74IzCHM6grce13KqE/NIeH7LTRKHRh3owv4nKOlu
	6X/kg2UZGrGdes3JQ2jpvk1fvU4i3thT7vBxwZw==
X-Google-Smtp-Source: AGHT+IHz3zxPQbbbUsepKHUF1uUsADOynrdvoPD0uimJS+ZQZoflzX/TbG/ec+1dOiYfpEXSQ93zscANzNpMS8LAAoQ=
X-Received: by 2002:a05:6870:4d1a:b0:261:b48:3c99 with SMTP id
 586e51a60fabf-2962dddcaa4mr1182864fac.23.1731640790020; Thu, 14 Nov 2024
 19:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
 <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
 <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com>
 <ZzVNKvCu4MOs7O5z@debug.ba.rivosinc.com> <CAKddAkDbGYeONaksq6fzLzx47BHZo3Ar7Sog3MOgf7Y+Birovw@mail.gmail.com>
 <ZzVRbCZP9N4Os8Bj@debug.ba.rivosinc.com> <CAKddAkBCByf570PXfz798FtBbeGQWe2LJpdzxkE+jv3Zd3ZV1w@mail.gmail.com>
 <ZzYcVW/4M0jab1T4@debug.ba.rivosinc.com>
In-Reply-To: <ZzYcVW/4M0jab1T4@debug.ba.rivosinc.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 15 Nov 2024 11:19:39 +0800
Message-ID: <CAKddAkA7X7WeT8Fn6BdEij8sfHvd9cAJWf+8vJAQ95jn70F1Ug@mail.gmail.com>
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak

On Thu, Nov 14, 2024 at 11:50=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
>
> Hi Nick,
>
> Thanks for reviewing and helping.
>
> On Thu, Nov 14, 2024 at 02:17:30PM +0800, Nick Hu wrote:
> >Hi Deepak
> >
> >On Thu, Nov 14, 2024 at 9:25=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> On Thu, Nov 14, 2024 at 09:20:14AM +0800, Nick Hu wrote:
> >> >Hi Deepak
> >> >
> >> >On Thu, Nov 14, 2024 at 9:06=E2=80=AFAM Deepak Gupta <debug@rivosinc.=
com> wrote:
> >> >> >> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> >> >> >> index 356d5397b2a2..6244408ca917 100644
> >> >> >> --- a/arch/riscv/kernel/head.S
> >> >> >> +++ b/arch/riscv/kernel/head.S
> >> >> >> @@ -164,6 +164,12 @@ secondary_start_sbi:
> >> >> >>         call relocate_enable_mmu
> >> >> >>  #endif
> >> >> >>         call .Lsetup_trap_vector
> >> >> >> +       li a7, SBI_EXT_FWFT
> >> >> >> +       li a6, SBI_EXT_FWFT_SET
> >> >> >> +       li a0, SBI_FWFT_SHADOW_STACK
> >> >> >> +       li a1, 1 /* enable supervisor to access shadow stack acc=
ess */
> >> >> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
> >> >> >> +       ecall
> >> >> >>         scs_load_current
> >> >> >>         call smp_callin
> >> >> >>  #endif /* CONFIG_SMP */
> >> >> >> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
> >> >> >>         la tp, init_task
> >> >> >>         la sp, init_thread_union + THREAD_SIZE
> >> >> >>         addi sp, sp, -PT_SIZE_ON_STACK
> >> >> >> +       li a7, SBI_EXT_FWFT
> >> >> >> +       li a6, SBI_EXT_FWFT_SET
> >> >> >> +       li a0, SBI_FWFT_SHADOW_STACK
> >> >> >> +       li a1, 1 /* enable supervisor to access shadow stack acc=
ess */
> >> >> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
> >> >> >> +       ecall
> >> >> >>         scs_load_current
> >> >> >>
> >> >> >>  #ifdef CONFIG_KASAN
> >> >> >>
> >> >> >> --
> >> >> >> 2.45.0
> >> >> >>
> >> >> >Should we clear the SBI_FWFT_SET_FLAG_LOCK before the cpu hotplug
> >> >> >otherwise the menvcfg.sse won't be set by the fwft set sbi call wh=
en
> >> >> >the hotplug cpu back to kernel?
> >> >>
> >> >> Hmm...
> >> >>
> >> >> An incoming hotplug CPU has no features setup on it.
> >> >> I see that `sbi_cpu_start` will supply `secondary_start_sbi` as sta=
rt
> >> >> up code for incoming CPU. `secondary_start_sbi` is in head.S which =
converges
> >> >> in `.Lsecondary_start_common`. And thus hotplugged CPU should be
> >> >> issuing shadow stack set FWFT sbi as well.
> >> >>
> >> >> Am I missing something ?
> >> >>
> >> >This is the correct flow. However the opensbi will deny it due to the
> >> >SBI_FWFT_SET_FLAG_LOCK already being set.
> >> >So the menvcfg.sse will not set by this flow.
> >> >
> >> >if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
> >> >                return SBI_EDENIED;
> >> >
> >>
> >> hmm... Why?
> >>
> >> `conf` is pointing to per-hart state in firmware.
> >>
> >> On this incoming cpu, opensbi (or equivalent) firmware must have
> >> ensured that this per-hart state doesn't have lock set.
> >>
> >> Am I missing something?
> >>
> >Current OpenSBI doesn't clear the lock in the warm init of the hotplug p=
ath.
> >It seems like we need a patch to address it.
>
> Got it thanks.
> Since you already know what's the problem, can you send a patch to opensb=
i.
> If you want rather have me do it, let me know. Thanks.
>
No problem. I'll send a patch to opensbi.

Regards,
Nick
> >
> >Regards,
> >Nick
> >> >Regards,
> >> >Nick
> >> >> >
> >> >> >Regards,
> >> >> >Nick
> >> >> >>
> >> >> >> _______________________________________________
> >> >> >> linux-riscv mailing list
> >> >> >> linux-riscv@lists.infradead.org
> >> >> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

