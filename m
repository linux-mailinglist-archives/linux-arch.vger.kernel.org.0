Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA561A4F4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKDW47 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDW46 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:56:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7EE116E;
        Fri,  4 Nov 2022 15:56:54 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13c569e5ff5so7095055fac.6;
        Fri, 04 Nov 2022 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMZlc/noaUmQT+jL3k1NyYl41Q9V/QCtZwr+2iWe/gU=;
        b=aue9ysqknB13MrWTQJefzMKn9cCroji6dFMKri39ezIUDDiL8A/wG3JgwR6JpZjvqK
         pj631Pu/aCzyGUVBM8p70L0RtYFMsiDXQ28MS5g6q6D54WrBIjh3266ate5oAKms4E5t
         eOjek1uUpUkv4sJFuGC9N7P2supriy9ZXzOdV+N7Bmq1W5bUsv2XgxRHg702ki08gHje
         y2NY9/geqkQ66SmCfgSFkQHxxS8VynNV+rl8jfitol39H+YuSbeI7GcJsBXxA9hUmse/
         pumymtlpHs10nTM2wdGadNNhXynLw9hv4vGFZwmO78mal+Nfkmxcsn/3RepRcuMGflFU
         W7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMZlc/noaUmQT+jL3k1NyYl41Q9V/QCtZwr+2iWe/gU=;
        b=OXY4GAiSphKaEV6a/EADqHuosOnZtavP8KPrhFlof39BNCqKd9XsYnPSU9koS9+mI9
         ozGOJNL16vFAbAMmIUvayZI9RCvGJ9BXs88Wfu5OS35slloaIM7lvDY6ptNfU2txFV5W
         sKyqK7fXdwcJjNmqyhssDkI7l/n97LGxuI9NwnwCMmO3SnJ8TRFeKVMZmbCtFji50eLU
         n1UoqCS1KkwL9NqgBEefg92K3gGba3Znr9vRjUKr81DbZBqbrk0q/dQAJmzOtdyUEuIU
         LJ2wqMlF8FMJmOdOnYk7lArKycJxAOiCnP6SfSWusuq7nsa647BDhl1QgzZo2igQgCP5
         SQww==
X-Gm-Message-State: ACrzQf39aTz3EP2JmPg+w7DwfuBVD1bM9OaeUk8xGDg11DEm2z7miqKM
        J8Lh5cfoMNqCZlHYK1fdbQL2ZwJImyOl1uGa4Jw=
X-Google-Smtp-Source: AMsMyM4jQRgetRbSaJkRmQRyoOrbbFRG2yqnENXa16Ghoma1uWoiu/Laipt9hJt/ejjY7mdt7FKzyhz/obnAnjMdWEk=
X-Received: by 2002:a05:6870:f5a4:b0:136:3e0d:acdd with SMTP id
 eh36-20020a056870f5a400b001363e0dacddmr24283694oab.298.1667602613358; Fri, 04
 Nov 2022 15:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com> <20221104223604.29615-38-rick.p.edgecombe@intel.com>
In-Reply-To: <20221104223604.29615-38-rick.p.edgecombe@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 4 Nov 2022 15:56:16 -0700
Message-ID: <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 4, 2022 at 3:40 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> feature called shadow stacks that provides security enforcement of
> behavior that is rarely used by non-attackers.
>
> There exists a lurking compatibility problem for userspace shadow stack.
> Old binaries exist that are marked as supporting shadow stack in their
> elf header, but actually will crash if shadow stack is enabled. This would
> only happens if the loader chooses to call the kernel APIs that enable
> shadow stack. However, glibc plans to update to do just this. At which
> point the old apps will crash.
>
> In a lot of ways this is userspace's business, however the kernel could
> save the user from these crashes. It could do this by detecting the elf
> bit and blocking the shadow stack APIs, so that loader (glibc) will fail
> to enable shadow stack and the binary would then run without shadow stack.
> So implement this logic in the elf processing that happens during exec.
>
> This is a bit dirty, and implemented here just for discussion on whether
> the kernel should actually do something like this.
>
> The elf loading logic in the kernel has to do a little extra scanning
> through the elf header in order to find the shadow stack bit.
>
> Since some people may not mind if some apps crash, also create
> a Kconfig X86_USER_SHADOW_STACK_ALLOW_BROKEN to allow the old binaries
> to still have access to the shadow stack kernel APIs.
>
> This is based on an earlier patch by Yu-cheng Yu that was looking at elf
> bits on the interpreter instead of the execing binary.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/arm64/include/asm/elf.h     |  5 +++++
>  arch/x86/Kconfig                 | 13 +++++++++++++
>  arch/x86/include/asm/cet.h       |  2 ++
>  arch/x86/include/asm/elf.h       | 11 +++++++++++
>  arch/x86/include/asm/processor.h |  1 +
>  arch/x86/kernel/process_64.c     | 33 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/shstk.c          | 15 +++++++++++++++
>  fs/binfmt_elf.c                  | 24 ++++++++++++++++++++++-
>  include/linux/elf.h              |  6 ++++++
>  include/uapi/linux/elf.h         | 15 +++++++++++++++
>  10 files changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 97932fbf973d..1aa76ed02dda 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -279,6 +279,11 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
>         return 0;
>  }
>
> +static inline int arch_process_elf_property(struct arch_elf_state *arch)
> +{
> +       return 0;
> +}
> +
>  static inline int arch_elf_pt_proc(void *ehdr, void *phdr,
>                                    struct file *f, bool is_interp,
>                                    struct arch_elf_state *state)
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f3d14f5accce..da9e43aa91a3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -28,6 +28,7 @@ config X86_64
>         select ARCH_HAS_GIGANTIC_PAGE
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select ARCH_USE_GNU_PROPERTY
>         select HAVE_ARCH_SOFT_DIRTY
>         select MODULES_USE_ELF_RELA
>         select NEED_DMA_MAP_STATE
> @@ -60,6 +61,7 @@ config X86
>         select ACPI_LEGACY_TABLES_LOOKUP        if ACPI
>         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>         select ARCH_32BIT_OFF_T                 if X86_32
> +       select ARCH_BINFMT_ELF_STATE
>         select ARCH_CLOCKSOURCE_INIT
>         select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
> @@ -1977,6 +1979,17 @@ config X86_USER_SHADOW_STACK
>
>           If unsure, say N.
>
> +config X86_USER_SHADOW_STACK_ALLOW_BROKEN
> +       bool "Allow enabling shadow stack for broken binaries"
> +       depends on EXPERT
> +       depends on X86_USER_SHADOW_STACK
> +       help
> +         There exist old binaries that are marked as compatible with shadow
> +         stack, but actually aren't. The kernel blocks these binaries from
> +         getting shadow stack enabled by default. But some working binaries
> +         are also blocked. Select this option if you would like to allow these
> +         binaries to run with shadow stack, and possibly crash.
> +
>  config EFI
>         bool "EFI runtime service support"
>         depends on ACPI
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index 098e4ecfdf9b..7f0cabb3db21 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -22,6 +22,7 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
>  void shstk_free(struct task_struct *p);
>  int setup_signal_shadow_stack(struct ksignal *ksig);
>  int restore_signal_shadow_stack(void);
> +void bad_cet_binary_disable(bool disable);
>  #else
>  static inline long cet_prctl(struct task_struct *task, int option,
>                              unsigned long features) { return -EINVAL; }
> @@ -33,6 +34,7 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
>  static inline void shstk_free(struct task_struct *p) {}
>  static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
>  static inline int restore_signal_shadow_stack(void) { return 0; }
> +static inline void bad_cet_binary_disable(bool disable) {};
>  #endif /* CONFIG_X86_USER_SHADOW_STACK */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index cb0ff1055ab1..95ee133acffb 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -383,6 +383,17 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
>
>  extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
>
> +struct arch_elf_state {
> +       unsigned int gnu_property;
> +};
> +
> +#define INIT_ARCH_ELF_STATE {  \
> +       .gnu_property = 0,      \
> +}
> +
> +#define arch_elf_pt_proc(ehdr, phdr, elf, interp, state) (0)
> +#define arch_check_elf(ehdr, interp, interp_ehdr, state) (0)
> +
>  /* Do not change the values. See get_align_mask() */
>  enum align_flags {
>         ALIGN_VA_32     = BIT(0),
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index a6c414dfd10f..4b333c801010 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -534,6 +534,7 @@ struct thread_struct {
>  #ifdef CONFIG_X86_USER_SHADOW_STACK
>         unsigned long           features;
>         unsigned long           features_locked;
> +       bool                    bad_cet_binary_disable;
>
>         struct thread_shstk     shstk;
>  #endif
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 03bc16c9cc19..461b8e9468df 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -867,3 +867,36 @@ unsigned long KSTK_ESP(struct task_struct *task)
>  {
>         return task_pt_regs(task)->sp;
>  }
> +
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> +                           bool compat, struct arch_elf_state *state)
> +{
> +       if (type != GNU_PROPERTY_X86_FEATURE_1_AND)
> +               return 0;
> +
> +       if (datasz != sizeof(unsigned int))
> +               return -ENOEXEC;
> +
> +       state->gnu_property = *(unsigned int *)data;
> +       return 0;
> +}
> +
> +int arch_process_elf_property(struct arch_elf_state *state)
> +{
> +       bad_cet_binary_disable(state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_BAD);
> +       return 0;
> +}
> +#else /* CONFIG_X86_USER_SHADOW_STACK */
> +int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> +                           bool compat, struct arch_elf_state *state)
> +{
> +       return 0;
> +}
> +
> +int arch_process_elf_property(struct arch_elf_state *state)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_X86_USER_SHADOW_STACK */
> +
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index bed7032d35f2..cb105e69c840 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -445,6 +445,9 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
>
>  long cet_prctl(struct task_struct *task, int option, unsigned long features)
>  {
> +       if (task->thread.bad_cet_binary_disable)
> +               return -EINVAL;
> +
>         if (option == ARCH_CET_LOCK) {
>                 task->thread.features_locked |= features;
>                 return 0;
> @@ -482,3 +485,15 @@ long cet_prctl(struct task_struct *task, int option, unsigned long features)
>                 return wrss_control(true);
>         return -EINVAL;
>  }
> +
> +#ifdef CONFIG_X86_USER_SHADOW_STACK_ALLOW_BROKEN
> +void bad_cet_binary_disable(bool disable)
> +{
> +       current->thread.bad_cet_binary_disable = false;
> +}
> +#else /* CONFIG_X86_USER_SHADOW_STACK_ALLOW_BROKEN */
> +void bad_cet_binary_disable(bool disable)
> +{
> +       current->thread.bad_cet_binary_disable = disable;
> +}
> +#endif /* CONFIG_X86_USER_SHADOW_STACK_ALLOW_BROKEN */
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 6a11025e5850..8b6ae5e423fb 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -764,6 +764,8 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
>  #define GNU_PROPERTY_TYPE_0_NAME "GNU"
>  #define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
>
> +
> +
>  static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>                                 struct arch_elf_state *arch)
>  {
> @@ -821,6 +823,18 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>         return ret == -ENOENT ? 0 : ret;
>  }
>
> +static int check_elf_properties(struct file *f, const struct elf_phdr *phdr)
> +{
> +       struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
> +       int retval;
> +
> +       retval = parse_elf_properties(f, phdr, &arch_state);
> +       if (retval)
> +               return retval;
> +
> +       return arch_process_elf_property(&arch_state);
> +}
> +
>  static int load_elf_binary(struct linux_binprm *bprm)
>  {
>         struct file *interpreter = NULL; /* to shut gcc up */
> @@ -920,13 +934,21 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                 if (retval < 0)
>                         goto out_free_dentry;
>
> -               break;
> +               /* Quit if already found PT_GNU_PROPERTY */
> +               if (elf_property_phdata)
> +                       break;
> +
> +               continue;
>
>  out_free_interp:
>                 kfree(elf_interpreter);
>                 goto out_free_ph;
>         }
>
> +       retval = check_elf_properties(bprm->file, elf_property_phdata);
> +       if (retval)
> +               return retval;
> +
>         elf_ppnt = elf_phdata;
>         for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
>                 switch (elf_ppnt->p_type) {
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index c9a46c4e183b..faf961b92a95 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -92,9 +92,15 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
>  {
>         return 0;
>  }
> +
> +static inline int arch_process_elf_property(struct arch_elf_state *arch)
> +{
> +       return 0;
> +}
>  #else
>  extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
>                                    bool compat, struct arch_elf_state *arch);
> +extern int arch_process_elf_property(struct arch_elf_state *arch);
>  #endif
>
>  #ifdef CONFIG_ARCH_HAVE_ELF_PROT
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 11089731e2e9..d9b58adce321 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -469,4 +469,19 @@ typedef struct elf64_note {
>  /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
>  #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI     (1U << 0)
>
> +/*
> + * See the x86 64 psABI at:
> + * https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
> + * .note.gnu.property types for x86:
> + */
> +/* 0xc0000000 and 0xc0000001 are reserved */
> +#define GNU_PROPERTY_X86_FEATURE_1_AND         0xc0000002
> +
> +/* Bits for GNU_PROPERTY_X86_FEATURE_1_AND */
> +#define GNU_PROPERTY_X86_FEATURE_1_IBT         0x00000001
> +#define GNU_PROPERTY_X86_FEATURE_1_SHSTK       0x00000002
> +
> +#define GNU_PROPERTY_X86_FEATURE_1_BAD (GNU_PROPERTY_X86_FEATURE_1_IBT | \
> +                                        GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +
>  #endif /* _UAPI_LINUX_ELF_H */
> --
> 2.17.1
>

This change doesn't make a binary CET compatible.  It just requires
that the toolchain
must be updated and all binaries have to be recompiled with the new toolchain to
enable CET.  It doesn't solve any issue which can't be solved by not
updating glibc.

-- 
H.J.
