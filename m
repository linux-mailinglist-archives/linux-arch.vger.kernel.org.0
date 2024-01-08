Return-Path: <linux-arch+bounces-1301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE47827880
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 20:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844521F23EB9
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17D55C09;
	Mon,  8 Jan 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Botro/Sz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729C55C0A
	for <linux-arch@vger.kernel.org>; Mon,  8 Jan 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so2621780e87.3
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2024 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704741791; x=1705346591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxCaRDmSqsLBvSOC+ec1RaWFfJ/mHhsWAI2gaK+/jy8=;
        b=Botro/SzYLxBCIb3Nu3lKqDSTlUlJdEKIqYN+ncMXHn7leko7mWlfejUWoBPNK8Q6Z
         fGIIfj5uY0wKEod0ppgVG3tc9BrJIBn8MHZ7FZ6kDsQ/S/uHgDIOcEX/kkv544sRjSqd
         Sm38T0KACpMUCdz54H+3dmlItxLZ2w+St3Zsdz7RrUxXWvYgJ8tmwL9AfXtTljK7AEns
         UBRudvKkWWp54My90lAg7/SIt2wOKJufSwQQQwALWUKz2eV9Tj1nKOSC/GVrUQtnAgZX
         qWkJD1gt9yikqcbuGvVWTxXkDX6wIHw1a1MYZ3XiSXZxuxfxEaE3zXC1NqquwNceeJe3
         rz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741791; x=1705346591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxCaRDmSqsLBvSOC+ec1RaWFfJ/mHhsWAI2gaK+/jy8=;
        b=WBt+XKzd7jEpl4rmpo+QCSlj/KsnegEPkU9Zp8OwAcV5kXilvOZmGOoHXPrxgKGg/q
         0U8LM4XNy5uit3GHLbR1XyN49NigCiyQPJXKuLMu2NpDn6DDKU3ZRk1Vt7es0AfQf/CP
         PfWtGJn5MN6L3qAeZK5boBWUlzlBI0lW8VRgfOwUSVg9/KOh1Oe52W4hfJLwS2UKUQSp
         okUG7lZ8a6tl8OWtxYu62lENWECUlvOagTks4CFldqV7f3RHSVWMsCLCDf0axdiAz2fh
         rcFbIFfAwGGK4rIje9Qv2+dXtRWaSEFSC1dBW4Lkil+A5fhDwZPyXCk3koPwURA0KbDN
         4SUA==
X-Gm-Message-State: AOJu0YxH9pSnpe85ValzINRdP66TAQKJs6nsd9OS8S54ADGiLRHmmOdL
	379dmHYqX17F9lwE3ia7p2Up6uSp23EkunJFZcR4ZUvKwv9BHw==
X-Google-Smtp-Source: AGHT+IGX7tj4NQqFdLLzsLhJbSGqUUbtw6AZ3qSFM9YDtORIeW2rw1tTwTJ34SefrTeFxS1hs38T6NjzISoolBVO+oA=
X-Received: by 2002:ac2:5dfb:0:b0:50e:74ec:75f6 with SMTP id
 z27-20020ac25dfb000000b0050e74ec75f6mr1748307lfq.136.1704741790709; Mon, 08
 Jan 2024 11:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com> <20231227-optimize_checksum-v14-2-ddfd48016566@rivosinc.com>
In-Reply-To: <20231227-optimize_checksum-v14-2-ddfd48016566@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Mon, 8 Jan 2024 11:22:34 -0800
Message-ID: <CALs-HssxwMphYSCFEYh6b3paQchmSm+tzeZ=2Ro-S4U_Gkom=w@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Guo Ren <guoren@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 9:38=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support static branches depending on the value of misaligned accesses.
> This will be used by a later patch in the series. All online cpus must
> be considered "fast" for this static branch to be flipped.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

This is fancier than I would have gone for, I probably would have
punted on heterogeneous hotplug out of laziness for now. However, what
you've done looks smart, in that we'll basically flip the branch if at
any moment all the online CPUs are fast. I've got some nits below, but
won't withhold my review for them (making them optional I suppose :)).

Reviewed-by: Evan Green <evan@rivosinc.com>

> ---
>  arch/riscv/include/asm/cpufeature.h |  2 +
>  arch/riscv/kernel/cpufeature.c      | 89 +++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 87 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index a418c3112cd6..7b129e5e2f07 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extension_u=
nlikely(int cpu, const unsi
>         return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
>
> +DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> +
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index b3785ffc1570..dfd716b93565 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -8,8 +8,10 @@
>
>  #include <linux/acpi.h>
>  #include <linux/bitmap.h>
> +#include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/ctype.h>
> +#include <linux/jump_label.h>
>  #include <linux/log2.h>
>  #include <linux/memory.h>
>  #include <linux/module.h>
> @@ -44,6 +46,8 @@ struct riscv_isainfo hart_isa[NR_CPUS];
>  /* Performance information */
>  DEFINE_PER_CPU(long, misaligned_access_speed);
>
> +static cpumask_t fast_misaligned_access;
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -643,6 +647,16 @@ static int check_unaligned_access(void *param)
>                 (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "=
slow");
>
>         per_cpu(misaligned_access_speed, cpu) =3D speed;
> +
> +       /*
> +        * Set the value of fast_misaligned_access of a CPU. These operat=
ions
> +        * are atomic to avoid race conditions.
> +        */
> +       if (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST)
> +               cpumask_set_cpu(cpu, &fast_misaligned_access);
> +       else
> +               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> +
>         return 0;
>  }
>
> @@ -655,13 +669,70 @@ static void check_unaligned_access_nonboot_cpu(void=
 *param)
>                 check_unaligned_access(pages[cpu]);
>  }
>
> +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> +
> +static int exclude_set_unaligned_access_static_branches(int cpu)
> +{
> +       /*
> +        * Same as set_unaligned_access_static_branches, except excludes =
the
> +        * given CPU from the result. When a CPU is hotplugged into an of=
fline
> +        * state, this function is called before the CPU is set to offlin=
e in
> +        * the cpumask, and thus the CPU needs to be explicitly excluded.
> +        */
> +
> +       cpumask_t online_fast_misaligned_access;
> +
> +       cpumask_and(&online_fast_misaligned_access, &fast_misaligned_acce=
ss, cpu_online_mask);
> +       cpumask_clear_cpu(cpu, &online_fast_misaligned_access);
> +
> +       if (cpumask_weight(&online_fast_misaligned_access) =3D=3D (num_on=
line_cpus() - 1))
> +               static_branch_enable_cpuslocked(&fast_misaligned_access_s=
peed_key);
> +       else
> +               static_branch_disable_cpuslocked(&fast_misaligned_access_=
speed_key);
> +
> +       return 0;
> +}

A minor nit:  the function above and below are looking a little
copy/pasty, and lead to multiple spots where the static branch gets
changed. You could make a third function that actually does the
setting with parameters, then these two could call it in different
ways. The return types also don't need to be int, since you always
return 0. Something like:

static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
{
        if (cpumask_weight(mask) =3D=3D weight) {
               static_branch_enable_cpuslocked(&fast_misaligned_access_spee=
d_key);
        } else {
               static_branch_disable_cpuslocked(&fast_misaligned_access_spe=
ed_key);
        }
}

static void set_unaligned_access_branches(void)
{
        cpumask_t fast_and_online;

        cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_m=
ask);
        modify_unaligned_access_branches(&fast_and_online, num_online_cpus(=
));
}

static void set_unaligned_access_branches_except_cpu(unsigned int cpu)
{
        cpumask_t fast_except_me;

        cpumask_and(&online_fast_misaligned_access,
&fast_misaligned_access, cpu_online_mask);
        cpumask_clear_cpu(cpu, &fast_except_me);
        modify_unaligned_access_branches(&fast_except_me,
num_online_cpus() - 1);
}

> +
> +static int set_unaligned_access_static_branches(void)
> +{
> +       /*
> +        * This will be called after check_unaligned_access_all_cpus so t=
he
> +        * result of unaligned access speed for all CPUs will be availabl=
e.
> +        *
> +        * To avoid the number of online cpus changing between reading
> +        * cpu_online_mask and calling num_online_cpus, cpus_read_lock mu=
st be
> +        * held before calling this function.
> +        */
> +       cpumask_t online_fast_misaligned_access;
> +
> +       cpumask_and(&online_fast_misaligned_access, &fast_misaligned_acce=
ss, cpu_online_mask);
> +
> +       if (cpumask_weight(&online_fast_misaligned_access) =3D=3D num_onl=
ine_cpus())
> +               static_branch_enable_cpuslocked(&fast_misaligned_access_s=
peed_key);
> +       else
> +               static_branch_disable_cpuslocked(&fast_misaligned_access_=
speed_key);
> +
> +       return 0;
> +}
> +
> +static int lock_and_set_unaligned_access_static_branch(void)
> +{
> +       cpus_read_lock();
> +       set_unaligned_access_static_branches();
> +       cpus_read_unlock();
> +
> +       return 0;
> +}
> +
> +arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> +
>  static int riscv_online_cpu(unsigned int cpu)
>  {
>         static struct page *buf;
>
>         /* We are already set since the last check */
>         if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
> -               return 0;
> +               goto exit;
>
>         buf =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
>         if (!buf) {
> @@ -671,7 +742,14 @@ static int riscv_online_cpu(unsigned int cpu)
>
>         check_unaligned_access(buf);
>         __free_pages(buf, MISALIGNED_BUFFER_ORDER);
> -       return 0;
> +
> +exit:
> +       return set_unaligned_access_static_branches();
> +}
> +
> +static int riscv_offline_cpu(unsigned int cpu)
> +{
> +       return exclude_set_unaligned_access_static_branches(cpu);
>  }
>
>  /* Measure unaligned access on all CPUs present at boot in parallel. */
> @@ -705,9 +783,12 @@ static int check_unaligned_access_all_cpus(void)
>         /* Check core 0. */
>         smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
>
> -       /* Setup hotplug callback for any new CPUs that come online. */
> +       /*
> +        * Setup hotplug callbacks for any new CPUs that come online or g=
o
> +        * offline.
> +        */
>         cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> -                                 riscv_online_cpu, NULL);
> +                                 riscv_online_cpu, riscv_offline_cpu);
>
>  out:
>         unaligned_emulation_finish();
>
> --
> 2.43.0
>

