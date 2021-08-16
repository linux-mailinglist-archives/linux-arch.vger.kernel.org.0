Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2B3EDB04
	for <lists+linux-arch@lfdr.de>; Mon, 16 Aug 2021 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhHPQft (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 12:35:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhHPQft (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Aug 2021 12:35:49 -0400
Received: from zn.tnic (p200300ec2f08b500a9c2327ac48af0d7.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:b500:a9c2:327a:c48a:f0d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 074D81EC01B7;
        Mon, 16 Aug 2021 18:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629131712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Fl5YWTL0C8PiwMTzshA9ckbCB+YmFNF66gMHeCJyyE=;
        b=VnK6ZyGjzS0hqOjB9/RYnWtKKbiGNk2vrjbauFy3rCMkklgRjSXSjv+U9pf/yGeOZ/DdUI
        +BE9dZnDzIAUiqRR00IUYG8UHu6rfrgIM9OezD4H86J56M3Z85cZtUTMolU+5LcBNjSY2w
        nz/m6R5h9wUf0wEsN7ke7wBNyouBG24=
Date:   Mon, 16 Aug 2021 18:35:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 14/32] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Message-ID: <YRqT5+ggVQ1zW9PK@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-15-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:52:01PM -0700, Yu-cheng Yu wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index eb97468dfe4c..02c70198b989 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -662,6 +662,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
> +		[ilog2(VM_SHADOW_STACK)]= "ss",
> +#endif


ERROR: spaces required around that '=' (ctx:VxW)
#109: FILE: fs/proc/task_mmu.c:666:
+		[ilog2(VM_SHADOW_STACK)]= "ss",
 		                        ^

total: 1 errors, 0 warnings, 49 lines checked

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
