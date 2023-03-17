Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309896BEF40
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 18:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCQRK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCQRKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 13:10:10 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA42457D6
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 10:09:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e71so6494849ybc.0
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679072982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyGiCOuzpCUygYrGB2PwFluAD4+Kj2HT1bQEGXBzqqs=;
        b=Z7nmpkLKoGRLV+P2V/8LME8aWSNFmNhPgyFVKqtl2aYwfLMBFAy6IMaHXlp4FvtbZp
         sKYJeU2zg04OOU+M8DqUhdKDmF7CtBnyJF3DMmZ2lCQEWexghjH2XTbPUAENd2lKOEbJ
         7vrbI5pnmVpv2N0sNAYLpmfWtkXRNeBYMnYo7leB0kUTfRFH+FQYCvXjsdNB6THdBg4t
         8zlIbIx0O6DH/n6MnYPSE7Bd4EMyp6tRtl8L/QYFYGMWkiu8752qSl9k4rD8eb+D36al
         DtH4cdKh6iSZNyV79DtBAMOaQXxbV5eILGoWqiE06QQ4rmbfz9F7OI/W6UE2RAfld7KL
         A7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679072982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyGiCOuzpCUygYrGB2PwFluAD4+Kj2HT1bQEGXBzqqs=;
        b=ytQ5bzaqSANa1JGFNmA0FhoWye9pAhA9tjkQQysoKp32ekgiSNKIHIYGBPizvjZW1z
         mlWC4tTrHAR3UKJTuwqxKDrv90GlQawnq2m+0kL0PJdXLelnLd07oJ1JLxNPkRDQdHmE
         zJDW0RKZ3LBIkHesHak2c/hgQWmwt8SzQjKWJtsTAqsMCqZ1SmAPyCjdMT2ffnomg+hh
         iMw6MYIvqBI5PA23cGlGl3W/X3NuH3l9DCpmEs/cVgwt0+t0RN5iJJ4y5Jffxu9V62tj
         ni4AFAJWVrCGGagM+pxGDH+IDhjKT64cGVXf1txnw8jHhcRVNo0WXLiv2G9PHX8FLzTz
         PFUw==
X-Gm-Message-State: AO0yUKXkmfYHeD5Cpuh/IuaavR5qRLUUzFlBFz7nbFVRdk+nP8+kvJ40
        U7NWitJv2pxqzNRCjtPShfp9uVEjCenqRlYcejRMOg==
X-Google-Smtp-Source: AK7set8WHpFUpGLzM3ZMAI8efrv3wxVYI2960/n8L99qdwz+ch5b09JYgpcWyA+XYcURNxejBGDwGuAnYXXWegpW86k=
X-Received: by 2002:a5b:406:0:b0:a09:314f:a3ef with SMTP id
 m6-20020a5b0406000000b00a09314fa3efmr160914ybp.12.1679072982266; Fri, 17 Mar
 2023 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com> <20230227222957.24501-22-rick.p.edgecombe@intel.com>
In-Reply-To: <20230227222957.24501-22-rick.p.edgecombe@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Fri, 17 Mar 2023 10:09:33 -0700
Message-ID: <CAKC1njTexZ3-8u8iW3cDv9FBSUx107N-MMekMoLL5ShRFaryYQ@mail.gmail.com>
Subject: Re: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 2:31=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
>
> The architecture of shadow stack constrains the ability of userspace to
> move the shadow stack pointer (SSP) in order to  prevent corrupting or
> switching to other shadow stacks. The RSTORSSP can move the ssp to
> different shadow stacks, but it requires a specially placed token in orde=
r
> to do this. However, the architecture does not prevent incrementing the
> stack pointer to wander onto an adjacent shadow stack. To prevent this in
> software, enforce guard pages at the beginning of shadow stack vmas, such
> that there will always be a gap between adjacent shadow stacks.
>
> Make the gap big enough so that no userspace SSP changing operations
> (besides RSTORSSP), can move the SSP from one stack to the next. The
> SSP can increment or decrement by CALL, RET  and INCSSP. CALL and RET
> can move the SSP by a maximum of 8 bytes, at which point the shadow
> stack would be accessed.
>
> The INCSSP instruction can also increment the shadow stack pointer. It
> is the shadow stack analog of an instruction like:
>
>         addq    $0x80, %rsp
>
> However, there is one important difference between an ADD on %rsp and
> INCSSP. In addition to modifying SSP, INCSSP also reads from the memory
> of the first and last elements that were "popped". It can be thought of
> as acting like this:
>
> READ_ONCE(ssp);       // read+discard top element on stack
> ssp +=3D nr_to_pop * 8; // move the shadow stack
> READ_ONCE(ssp-8);     // read+discard last popped stack element
>
> The maximum distance INCSSP can move the SSP is 2040 bytes, before it
> would read the memory. Therefore a single page gap will be enough to
> prevent any operation from shifting the SSP to an adjacent stack, since
> it would have to land in the gap at least once, causing a fault.
>
> This could be accomplished by using VM_GROWSDOWN, but this has a
> downside. The behavior would allow shadow stack's to grow, which is
> unneeded and adds a strange difference to how most regular stacks work.
>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
>
> ---
> v5:
>  - Fix typo in commit log
>
> v4:
>  - Drop references to 32 bit instructions
>  - Switch to generic code to drop __weak (Peterz)
>
> v2:
>  - Use __weak instead of #ifdef (Dave Hansen)
>  - Only have start gap on shadow stack (Andy Luto)
>  - Create stack_guard_start_gap() to not duplicate code
>    in an arch version of vm_start_gap() (Dave Hansen)
>  - Improve commit log partly with verbiage from (Dave Hansen)
>
> Yu-cheng v25:
>  - Move SHADOW_STACK_GUARD_GAP to arch/x86/mm/mmap.c.
> ---
>  include/linux/mm.h | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 097544afb1aa..6a093daced88 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3107,15 +3107,36 @@ struct vm_area_struct *vma_lookup(struct mm_struc=
t *mm, unsigned long addr)
>         return mtree_load(&mm->mm_mt, addr);
>  }
>
> +static inline unsigned long stack_guard_start_gap(struct vm_area_struct =
*vma)
> +{
> +       if (vma->vm_flags & VM_GROWSDOWN)
> +               return stack_guard_gap;
> +
> +       /*
> +        * Shadow stack pointer is moved by CALL, RET, and INCSSPQ.
> +        * INCSSPQ moves shadow stack pointer up to 255 * 8 =3D ~2 KB
> +        * and touches the first and the last element in the range, which
> +        * triggers a page fault if the range is not in a shadow stack.
> +        * Because of this, creating 4-KB guard pages around a shadow
> +        * stack prevents these instructions from going beyond.
> +        *
> +        * Creation of VM_SHADOW_STACK is tightly controlled, so a vma
> +        * can't be both VM_GROWSDOWN and VM_SHADOW_STACK
> +        */
> +       if (vma->vm_flags & VM_SHADOW_STACK)
> +               return PAGE_SIZE;

This is an arch agnostic header file. Can we remove `VM_SHADOW_STACK`
from here? and instead
have `arch_is_shadow_stack` which consumes vma flags and returns true or fa=
lse.
This allows different architectures to choose their own encoding of
vma flags to represent a shadow stack.

> +
> +       return 0;
> +}
> +
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  {
> +       unsigned long gap =3D stack_guard_start_gap(vma);
>         unsigned long vm_start =3D vma->vm_start;
>
> -       if (vma->vm_flags & VM_GROWSDOWN) {
> -               vm_start -=3D stack_guard_gap;
> -               if (vm_start > vma->vm_start)
> -                       vm_start =3D 0;
> -       }
> +       vm_start -=3D gap;
> +       if (vm_start > vma->vm_start)
> +               vm_start =3D 0;
>         return vm_start;
>  }
>
> --
> 2.17.1
>
