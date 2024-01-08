Return-Path: <linux-arch+bounces-1302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D024827A44
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 22:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D23B227DD
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992956458;
	Mon,  8 Jan 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1c7S71uS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B456443
	for <linux-arch@vger.kernel.org>; Mon,  8 Jan 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso21261365ad.0
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2024 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704749862; x=1705354662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJLvvvJMK3asun1jUdYXWo2TZ3pozvY0KGbDySw/SbA=;
        b=1c7S71uShVuFivFPSytvYFLDgm7CTpmAN23G/rj17+ZNC3A4qPlgXR4OGCvZHwNCtt
         bK33QTgb32UeRcwpnrQqqp/QMfu4QiTdb5AwnjVXZXvGYy4yRK/bXAIC2nu9gPY0RnDa
         MEGm3eOEU6f5VV++r58yTsIXNX9kT3b8x+CQjO2tPfVG0kG81zU7EYlrHp5yToYWA97g
         3EphB5KDj4ivSsK4/jjNLZfl2/p0o88n4BSVmgnSFt8IKYqoZLtdF5RIJG3CfvxGVCxb
         aX3zAQV8CsmH9H3zRWMOJPDum4+P4/5RYLADud5EZ9sOWaJ+iHJGCXQpyZVz5P8tIDzx
         fmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704749862; x=1705354662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJLvvvJMK3asun1jUdYXWo2TZ3pozvY0KGbDySw/SbA=;
        b=I6sccVoeMxchOg3Aa9/uTabSkNPB/w5SMeCywBlrmEq72AzRRAkrbrZbOooUnQ1sgQ
         oVimjcEiWHWghfNERq9FgOGYzJHtiSoB5Rbl6EbyFY7Aqmpd5WhaYxXMnvvBHyo/u5Rw
         r6tL7MBzQr9bQ9tfEeqCz0qiGUGJtNLFUwKhCriJnxHFm8RhLAEjvgPwh6df8KaY4le4
         B6LqRj8PHYGGUR1lqfzdHlVhjMdqF4aQ+FdyikZ/VsGTF3X00z1yKWtrfWtcLHHgWblC
         7+kMBgWeLHqWxL53E6Wa5xgdA6zpEJOj0MDbdourVZAYq5cEJ65Phw9oaYDQJOHVhuXX
         bQ1A==
X-Gm-Message-State: AOJu0YyDn+mUaRw38/X3s32vTOj4u3YaX/KkY2YuuzZN7kzh/Joz7mkz
	924sQHD/YNK+ohPt6U6+zCc1hsOa9pdd3qODG7cLBAmBKg4=
X-Google-Smtp-Source: AGHT+IHQ4QQDXGn4XgDikhyIDnu1OWMDjpzqXqwrJWDdftq8BLIp1IAy6omczLGfxYcLBlFnGQKsEg==
X-Received: by 2002:a17:902:ecc9:b0:1d4:d14b:9ab8 with SMTP id a9-20020a170902ecc900b001d4d14b9ab8mr503559plh.31.1704749861754;
        Mon, 08 Jan 2024 13:37:41 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001d3e3704d2fsm350829plz.31.2024.01.08.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 13:37:41 -0800 (PST)
Date: Mon, 8 Jan 2024 13:37:38 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	David Laight <David.Laight@aculab.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v14 2/5] riscv: Add static key for misaligned accesses
Message-ID: <ZZxrIgggqxiKOZCt@ghost>
References: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
 <20231227-optimize_checksum-v14-2-ddfd48016566@rivosinc.com>
 <CALs-HssxwMphYSCFEYh6b3paQchmSm+tzeZ=2Ro-S4U_Gkom=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssxwMphYSCFEYh6b3paQchmSm+tzeZ=2Ro-S4U_Gkom=w@mail.gmail.com>

On Mon, Jan 08, 2024 at 11:22:34AM -0800, Evan Green wrote:
> On Wed, Dec 27, 2023 at 9:38 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Support static branches depending on the value of misaligned accesses.
> > This will be used by a later patch in the series. All online cpus must
> > be considered "fast" for this static branch to be flipped.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> This is fancier than I would have gone for, I probably would have
> punted on heterogeneous hotplug out of laziness for now. However, what
> you've done looks smart, in that we'll basically flip the branch if at
> any moment all the online CPUs are fast. I've got some nits below, but
> won't withhold my review for them (making them optional I suppose :)).
> 
> Reviewed-by: Evan Green <evan@rivosinc.com>
> 

Thanks!

> > ---
> >  arch/riscv/include/asm/cpufeature.h |  2 +
> >  arch/riscv/kernel/cpufeature.c      | 89 +++++++++++++++++++++++++++++++++++--
> >  2 files changed, 87 insertions(+), 4 deletions(-)
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
> > index b3785ffc1570..dfd716b93565 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -8,8 +8,10 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/cpu.h>
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/ctype.h>
> > +#include <linux/jump_label.h>
> >  #include <linux/log2.h>
> >  #include <linux/memory.h>
> >  #include <linux/module.h>
> > @@ -44,6 +46,8 @@ struct riscv_isainfo hart_isa[NR_CPUS];
> >  /* Performance information */
> >  DEFINE_PER_CPU(long, misaligned_access_speed);
> >
> > +static cpumask_t fast_misaligned_access;
> > +
> >  /**
> >   * riscv_isa_extension_base() - Get base extension word
> >   *
> > @@ -643,6 +647,16 @@ static int check_unaligned_access(void *param)
> >                 (speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> >
> >         per_cpu(misaligned_access_speed, cpu) = speed;
> > +
> > +       /*
> > +        * Set the value of fast_misaligned_access of a CPU. These operations
> > +        * are atomic to avoid race conditions.
> > +        */
> > +       if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> > +               cpumask_set_cpu(cpu, &fast_misaligned_access);
> > +       else
> > +               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> > +
> >         return 0;
> >  }
> >
> > @@ -655,13 +669,70 @@ static void check_unaligned_access_nonboot_cpu(void *param)
> >                 check_unaligned_access(pages[cpu]);
> >  }
> >
> > +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > +
> > +static int exclude_set_unaligned_access_static_branches(int cpu)
> > +{
> > +       /*
> > +        * Same as set_unaligned_access_static_branches, except excludes the
> > +        * given CPU from the result. When a CPU is hotplugged into an offline
> > +        * state, this function is called before the CPU is set to offline in
> > +        * the cpumask, and thus the CPU needs to be explicitly excluded.
> > +        */
> > +
> > +       cpumask_t online_fast_misaligned_access;
> > +
> > +       cpumask_and(&online_fast_misaligned_access, &fast_misaligned_access, cpu_online_mask);
> > +       cpumask_clear_cpu(cpu, &online_fast_misaligned_access);
> > +
> > +       if (cpumask_weight(&online_fast_misaligned_access) == (num_online_cpus() - 1))
> > +               static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
> > +       else
> > +               static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
> > +
> > +       return 0;
> > +}
> 
> A minor nit:  the function above and below are looking a little
> copy/pasty, and lead to multiple spots where the static branch gets
> changed. You could make a third function that actually does the
> setting with parameters, then these two could call it in different
> ways. The return types also don't need to be int, since you always
> return 0. Something like:
> 
> static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> {
>         if (cpumask_weight(mask) == weight) {
>                static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
>         } else {
>                static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
>         }
> }
> 
> static void set_unaligned_access_branches(void)
> {
>         cpumask_t fast_and_online;
> 
>         cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
>         modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
> }
> 
> static void set_unaligned_access_branches_except_cpu(unsigned int cpu)
> {
>         cpumask_t fast_except_me;
> 
>         cpumask_and(&online_fast_misaligned_access,
> &fast_misaligned_access, cpu_online_mask);
>         cpumask_clear_cpu(cpu, &fast_except_me);
>         modify_unaligned_access_branches(&fast_except_me,
> num_online_cpus() - 1);
> }
> 

Great suggestions, I will apply these changes and send out a new
version.

- Charlie

> > +
> > +static int set_unaligned_access_static_branches(void)
> > +{
> > +       /*
> > +        * This will be called after check_unaligned_access_all_cpus so the
> > +        * result of unaligned access speed for all CPUs will be available.
> > +        *
> > +        * To avoid the number of online cpus changing between reading
> > +        * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
> > +        * held before calling this function.
> > +        */
> > +       cpumask_t online_fast_misaligned_access;
> > +
> > +       cpumask_and(&online_fast_misaligned_access, &fast_misaligned_access, cpu_online_mask);
> > +
> > +       if (cpumask_weight(&online_fast_misaligned_access) == num_online_cpus())
> > +               static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
> > +       else
> > +               static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
> > +
> > +       return 0;
> > +}
> > +
> > +static int lock_and_set_unaligned_access_static_branch(void)
> > +{
> > +       cpus_read_lock();
> > +       set_unaligned_access_static_branches();
> > +       cpus_read_unlock();
> > +
> > +       return 0;
> > +}
> > +
> > +arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> > +
> >  static int riscv_online_cpu(unsigned int cpu)
> >  {
> >         static struct page *buf;
> >
> >         /* We are already set since the last check */
> >         if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> > -               return 0;
> > +               goto exit;
> >
> >         buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> >         if (!buf) {
> > @@ -671,7 +742,14 @@ static int riscv_online_cpu(unsigned int cpu)
> >
> >         check_unaligned_access(buf);
> >         __free_pages(buf, MISALIGNED_BUFFER_ORDER);
> > -       return 0;
> > +
> > +exit:
> > +       return set_unaligned_access_static_branches();
> > +}
> > +
> > +static int riscv_offline_cpu(unsigned int cpu)
> > +{
> > +       return exclude_set_unaligned_access_static_branches(cpu);
> >  }
> >
> >  /* Measure unaligned access on all CPUs present at boot in parallel. */
> > @@ -705,9 +783,12 @@ static int check_unaligned_access_all_cpus(void)
> >         /* Check core 0. */
> >         smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> >
> > -       /* Setup hotplug callback for any new CPUs that come online. */
> > +       /*
> > +        * Setup hotplug callbacks for any new CPUs that come online or go
> > +        * offline.
> > +        */
> >         cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> > -                                 riscv_online_cpu, NULL);
> > +                                 riscv_online_cpu, riscv_offline_cpu);
> >
> >  out:
> >         unaligned_emulation_finish();
> >
> > --
> > 2.43.0
> >

