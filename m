Return-Path: <linux-arch+bounces-7289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C486978320
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49321C22950
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36D1A276;
	Fri, 13 Sep 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAJMkQFc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42728366;
	Fri, 13 Sep 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239656; cv=none; b=sUKX2K7Dpzqa/W3KGt2R/KXYqSn3fCI6UMijHIen9hj7Vhkq6oHD9chYicPGpna+A1GcuGxBaaWJM/DO+VH77ziFKalEYfHGlBxoWz1NxflOnV9HUCksCBHblHnXIHQDGmpf6mbu+NzvT7jRdv+c83zcY+kyZzil8mrq4JgwFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239656; c=relaxed/simple;
	bh=BA0ANnltDBBfuoBltj9aaFdaXEL//Iks38XJnB02U/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co7cmp9Uu7WupKwSJaX6VxtjpoYw4H0P0ZNW5kprOfFR6Eo/5yoCYsQtsiB0hOm+5ff8UvkTig6mE+lPtTZRwfpA9JyVBHZUiC2u7h/UUFPYpFb1k9xCj+S6TaXnUIRiCUiktbwdvTjxXGWIEJHhsqKVCC4yKI5MopNfb50WT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAJMkQFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81CBC4CEDB;
	Fri, 13 Sep 2024 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726239656;
	bh=BA0ANnltDBBfuoBltj9aaFdaXEL//Iks38XJnB02U/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YAJMkQFcS9yQrD3CD9uf2YDAnPedZRu2sdG3Uq7zy8+8g4fHsdnaV9YMu/zLJ/1tj
	 EDiCdYnV0pGG/cGSGCoqzc1yz3NAQwdRBBLRfL0AaT5mhRSd5SqOtQjToavlsk96bb
	 oKdYkALvWRv8THfAoHVYOAKmMboDnCW5qhSOfsTXSAkiRSZcMGaGh7XxCBtwPbd5yo
	 iYcY5nqsZThg8+lFTkl4wHHIxP84VsBur9fkHWLMiLx+uY355fMP3Bd0gFRq3KpUT4
	 TIJSScKe0wBqYY1i+xFQfTmvYKL4lkyD4Paj6wDyvXKCliGwP8nsVtdZV47PWrdook
	 qWRlseRXwzJPA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f759688444so20775241fa.1;
        Fri, 13 Sep 2024 08:00:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULir8RU8+P9W/UUHicJGDrkLQQQZokBhHGLCgoRNfZP5TViqAqbSAXmiHiCpE3I4KmoIht3k9rS+Siils=@vger.kernel.org, AJvYcCUw1AyxawrWxc/j7v03nO2ad+l8y8OsrCz5pbPc/VzKwI9EJJmUUtSCFw0eA/l6pJGyb5/cDl5DKnQ=@vger.kernel.org, AJvYcCUxvSkjTNBJJDMNVxAvXbjdUHZ/3Nt+B2q46ZDB04fOYwaKARUBkey1NT4qRYE9nxdmslUPtXBA1/HAyspyqQ==@vger.kernel.org, AJvYcCVdAG1QR7P19Qz6OOO+svTOKlqL+qfFD5IncHKX6ncPJbq3+KSig5TlZG63fEGm4XAcPKOk0F/jiJxTrA==@vger.kernel.org, AJvYcCVtsDg+0MZeHZXjkKJB5t4vEgnbgBgcaPpdxY0ymQIWPxqZZrQFJbmrMc3znAsWgGxYQLbhegaDEB2DqCfD@vger.kernel.org, AJvYcCWDfqc+xc5hMcP3JG9ctERZe79q8aNyXVE+E5pCvWB6KlMThkVtFs6UlosHUd/t1hU19VNmxptRYCVDkFsxW/X0eFcr@vger.kernel.org, AJvYcCWGtaY1eP2j7izTOEJFsnrMSzpYhaPwr0exKMiB5O+/mq76CXmOgUZrjpuOASxh6x3VE9HbMkNCD04D+lUd@vger.kernel.org, AJvYcCXcxpURX017fZYRq9h+F8GTJvPfaCx7MZElPErCIf64gAItKFh63Cs2rLul+y7fgZ/ocONgNGudDyNUv3S5G8Q=@vger.kernel.org, AJvYcCXfiy1yV18uLg4r+FuZM20TQHKTVUAaAE0RKHt/zmpwyWmOGY0zCJSxp68VCO3nyNEoMSEpB4mG0K+msQ==@vger.kernel.org, AJvY
 cCXk2/tlXIAd3IMCDQYvMLnknHPNku9g3pNxzJ9w0sAAw/5/winZpdHmdwqfzRJ2WZiakDZYLL+WjFLOVs2zAw==@vger.kernel.org, AJvYcCXlfdVgjN27YkAH2elz+3KHzyWh9zIYQyR1021lTaYvwcmrngYb4QAxxoL68i57hLLldJARGZIYJ+OUhA==@vger.kernel.org, AJvYcCXtJH5o/uZ+9iGulxzcMyKL/DTTv+fLQUgrVZrR4ONsJetKnUkp/9U3yVe/rIK7yPgKy/gbycUfKwTMZQ==@vger.kernel.org, AJvYcCXutrGseycTn/cGyeHK5TPzQZ/a3JPOl811M6oAlencO81EUw8g2O1/Z6+kdY+Jd+mE5kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKtUy3CnOCc7qGHJ4H+Fk8HiVo4sszEh3tjAp6mLuMyCeG757
	p10UIAD88ar0TpjeZDZmqeFbJMqDiIYc+Mc/p65ZtHPq05vDROGYbZDZFwUdm23eNAfLJ10hUuL
	Ge96rXQf6wDtaqAEFP4xJCU8WZmY=
X-Google-Smtp-Source: AGHT+IEIp2MygUsW5Tc1gnqrEXhSi4Y5LfaJ7pDs2t1FcVSY61BEs2pVKMYAU/+O+nJIsawLe6NqpBRTPpsi7cWLSzQ=
X-Received: by 2002:a05:651c:1a0c:b0:2f0:1e0a:4696 with SMTP id
 38308e7fff4ca-2f787dabe7emr39035411fa.7.1726239653924; Fri, 13 Sep 2024
 08:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909064730.3290724-1-rppt@kernel.org> <20240909064730.3290724-8-rppt@kernel.org>
In-Reply-To: <20240909064730.3290724-8-rppt@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 17:00:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG_Z=7B_eDAk3vhtDjfcnka3AoSKNzvFQDzpvYY2EyVfg@mail.gmail.com>
Message-ID: <CAMj1kXG_Z=7B_eDAk3vhtDjfcnka3AoSKNzvFQDzpvYY2EyVfg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] execmem: add support for cache of large ROX pages
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christoph Hellwig <hch@infradead.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

On Mon, 9 Sept 2024 at 08:51, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
>
> Extend execmem_alloc() with an ability to use huge pages with ROX
> permissions as a cache for smaller allocations.
>
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
>
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
>
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
>
> The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
> definition of an execmem_range.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/execmem.h |   2 +
>  mm/execmem.c            | 289 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 286 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index dfdf19f8a5e8..7436aa547818 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -77,12 +77,14 @@ struct execmem_range {
>
>  /**
>   * struct execmem_info - architecture parameters for code allocations
> + * @fill_trapping_insns: set memory to contain instructions that will trap
>   * @ranges: array of parameter sets defining architecture specific
>   * parameters for executable memory allocations. The ranges that are not
>   * explicitly initialized by an architecture use parameters defined for
>   * @EXECMEM_DEFAULT.
>   */
>  struct execmem_info {
> +       void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
>         struct execmem_range    ranges[EXECMEM_TYPE_MAX];
>  };
>
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 0f6691e9ffe6..f547c1f3c93d 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -7,28 +7,88 @@
>   */
>
>  #include <linux/mm.h>
> +#include <linux/mutex.h>
>  #include <linux/vmalloc.h>
>  #include <linux/execmem.h>
> +#include <linux/maple_tree.h>
>  #include <linux/moduleloader.h>
>  #include <linux/text-patching.h>
>
> +#include <asm/tlbflush.h>
> +
> +#include "internal.h"
> +
>  static struct execmem_info *execmem_info __ro_after_init;
>  static struct execmem_info default_execmem_info __ro_after_init;
>
> -static void *__execmem_alloc(struct execmem_range *range, size_t size)
> +#ifdef CONFIG_MMU
> +struct execmem_cache {
> +       struct mutex mutex;
> +       struct maple_tree busy_areas;
> +       struct maple_tree free_areas;
> +};
> +
> +static struct execmem_cache execmem_cache = {
> +       .mutex = __MUTEX_INITIALIZER(execmem_cache.mutex),
> +       .busy_areas = MTREE_INIT_EXT(busy_areas, MT_FLAGS_LOCK_EXTERN,
> +                                    execmem_cache.mutex),
> +       .free_areas = MTREE_INIT_EXT(free_areas, MT_FLAGS_LOCK_EXTERN,
> +                                    execmem_cache.mutex),
> +};
> +
> +static void execmem_cache_clean(struct work_struct *work)
> +{
> +       struct maple_tree *free_areas = &execmem_cache.free_areas;
> +       struct mutex *mutex = &execmem_cache.mutex;
> +       MA_STATE(mas, free_areas, 0, ULONG_MAX);
> +       void *area;
> +
> +       mutex_lock(mutex);
> +       mas_for_each(&mas, area, ULONG_MAX) {
> +               size_t size;
> +
> +               if (!xa_is_value(area))
> +                       continue;
> +
> +               size = xa_to_value(area);
> +
> +               if (IS_ALIGNED(size, PMD_SIZE) &&
> +                   IS_ALIGNED(mas.index, PMD_SIZE)) {
> +                       void *ptr = (void *)mas.index;
> +
> +                       mas_erase(&mas);
> +                       vfree(ptr);
> +               }
> +       }
> +       mutex_unlock(mutex);
> +}
> +
> +static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
> +
> +static void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable)
> +{
> +       if (execmem_info->fill_trapping_insns)
> +               execmem_info->fill_trapping_insns(ptr, size, writable);
> +       else
> +               memset(ptr, 0, size);

Does this really have to be a function pointer with a runtime check?

This could just be a __weak definition, with the arch providing an
override if the memset() is not appropriate.

