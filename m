Return-Path: <linux-arch+bounces-1157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D281C2D6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 02:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042771F25AA5
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 01:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473AA23AD;
	Fri, 22 Dec 2023 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AYuKH2Pl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153823D0
	for <linux-arch@vger.kernel.org>; Fri, 22 Dec 2023 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28b6ea19368so1154026a91.1
        for <linux-arch@vger.kernel.org>; Thu, 21 Dec 2023 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703209074; x=1703813874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/pHml5C4iB2UVOdNccbY5NzIin1Pbsu1DFBGnQ9mBxA=;
        b=AYuKH2PlMSZpPlBghtdLi8cYjGAVnyVZYL8FmKRgRe6hdpEZrmiRFzLdHBX71SzWtx
         LNDjjt8JqX+KLduuugyHlnOuIKRjvS5PPLfZ2Zs5bKw+Ez8vdEC6fKxki5EbuPmaKngd
         7YZAUSJK+m1eWSvSL2zN0XOXcJIm0fuuMXrFtjIehCslPXMXSqkNA0ONTGnEBtkbOWuK
         0H3UKud96Mx8U4dBUBqWfbTgaTfGRAnOK6dg1DN9dWUHyZa7/1hlxgd0lZDNXuHq+QYC
         R4OfmBnDrqeXURs8I3eY2MJ6ZR75PY4S0GePVrRQkmKrLp0imBk5rWhGfkz3AGBp8nxg
         q9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703209074; x=1703813874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pHml5C4iB2UVOdNccbY5NzIin1Pbsu1DFBGnQ9mBxA=;
        b=lp041qdAUDxaUAMk/sZTs6S3w1dPBVywvhA8gOeMV7nqV0aGzMHq3cp2IJLj1gPAZG
         o4pdCWupwxhKuPSISp7cBUNuoqYVLljl604gyZd4D1rC664m+SzrS5nVXdZLZKGJfeqV
         XPV0/lQQpTc5WrV03/fehkMasuvxLdZWt8+BJY9jfuqf4AWPD1+31hqxgitwmeEdaJnZ
         gQ/eX+J3MXtXl/REAXRE4jlUCTydMBWuYZ9sphlstW4Ldudd4dxwgeJKByLiWfWFq7U/
         DVm0mR/Ct2y5I0x6o6nk9XOCv2acDYXFLMhPV2n+5xVpvOVLS+xo58os82sXmie2rtcA
         NvXw==
X-Gm-Message-State: AOJu0YySuL1SGCt3Wfg6zpA4wX9Svd5M0Jg5ch6yboSp0n3Idr219ulP
	rBasQmwjhSpgqdKG3IyFqqVDMrahe2Qeng==
X-Google-Smtp-Source: AGHT+IHv22/ncKELWCuGh/tHAsgFvMxwYlO/s4McjHKY7KJFdAKT4sUqnIxQFPL3y5PE5Y0BnpMIPA==
X-Received: by 2002:a17:90a:6f43:b0:28b:9f7c:177 with SMTP id d61-20020a17090a6f4300b0028b9f7c0177mr513590pjk.18.1703209073698;
        Thu, 21 Dec 2023 17:37:53 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id si6-20020a17090b528600b0028b5812c477sm6343572pjb.35.2023.12.21.17.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:37:53 -0800 (PST)
Date: Thu, 21 Dec 2023 17:37:51 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	David Laight <David.Laight@aculab.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v13 2/5] riscv: Add static key for misaligned accesses
Message-ID: <ZYTobxPZVNct4toQ@ghost>
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
 <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
 <CAJF2gTR9ZxLZwEs=TMeih+vEEuuxNHRkgLsG2ShjXPEZ-G44_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTR9ZxLZwEs=TMeih+vEEuuxNHRkgLsG2ShjXPEZ-G44_w@mail.gmail.com>

On Fri, Dec 22, 2023 at 08:33:18AM +0800, Guo Ren wrote:
> On Thu, Dec 21, 2023 at 7:38 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Support static branches depending on the value of misaligned accesses.
> > This will be used by a later patch in the series. All cpus must be
> > considered "fast" for this static branch to be flipped.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cpufeature.h |  2 ++
> >  arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index a418c3112cd6..7b129e5e2f07 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
> >         return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> >  }
> >
> > +DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > +
> >  #endif
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index b3785ffc1570..095eb6ebdcaa 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/bitmap.h>
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/ctype.h>
> > +#include <linux/jump_label.h>
> >  #include <linux/log2.h>
> >  #include <linux/memory.h>
> >  #include <linux/module.h>
> > @@ -728,6 +729,35 @@ void riscv_user_isa_enable(void)
> >                 csr_set(CSR_SENVCFG, ENVCFG_CBZE);
> >  }
> >
> > +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > +
> > +static int set_unaligned_access_static_branches(void)
> > +{
> > +       /*
> > +        * This will be called after check_unaligned_access_all_cpus so the
> > +        * result of unaligned access speed for all cpus will be available.
> > +        */
> > +
> > +       int cpu;
> > +       bool fast_misaligned_access_speed = true;
> > +
> > +       for_each_online_cpu(cpu) {
> Each online_cpu? Is there any offline_cpu that is no
> fast_misaligned_access_speed?

I think instead of checking offline cpus, it would make more sense to
adjust the static branch when offline cpus come online. Since
riscv_online_cpu is called when a new CPU comes online, I can update the
static branch inside of that function.

> 
> Move into your riscv_online_cpu for each CPU, and use stop_machine for
> synchronization.
> 

I do not understand what you mean by "Move into your riscv_online_cpu
for each CPU", but I am assuming you are referring to updating the
static branch inside of riscv_online_cpu.

I believe any race condition that could be solved by stop_machine will
become irrelevent by ensuring that the static branch is updated when a
new cpu comes online. 

- Charlie

> > +               int this_perf = per_cpu(misaligned_access_speed, cpu);
> > +
> > +               if (this_perf != RISCV_HWPROBE_MISALIGNED_FAST) {
> > +                       fast_misaligned_access_speed = false;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (fast_misaligned_access_speed)
> > +               static_branch_enable(&fast_misaligned_access_speed_key);
> > +
> > +       return 0;
> > +}
> > +
> > +arch_initcall_sync(set_unaligned_access_static_branches);
> > +
> >  #ifdef CONFIG_RISCV_ALTERNATIVE
> >  /*
> >   * Alternative patch sites consider 48 bits when determining when to patch
> >
> > --
> > 2.43.0
> >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren

