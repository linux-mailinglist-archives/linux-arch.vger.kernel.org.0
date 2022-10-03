Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49A5F34CE
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJCRsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJCRsT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 13:48:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783717E25;
        Mon,  3 Oct 2022 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664819298; x=1696355298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=32i7PipZSw6KqH6MkU9eJfthXyxPQbhK8WM6mxd9tBw=;
  b=Kx9Gdvpk0EWZwJFoQMdi5o8IrHk3chz+sOPahhi97D45Yf+8q/776WGN
   z+x0eqikv1PmlE+pSvjN+qvJk5fmU3nQTCxcdTDH5kuIrwcIYjokOcoR7
   ggXeI3twWM+/aGF69c55hUSYoQAyi/5uD5lH++BgB7nVmZoSboEjyr216
   QjVKTQu82hifRP0cmrCujYryaBDqui/Keyr9k6yv0C95zLwT7mUGqhGMY
   xmalSfHMbQBTna+qbO2CLE7Qk4EHaPL5XJ/8PxM2ZQrdRWSM65OrVd1Zp
   GHp8HWAp/Skjpc0jpETjSbpYN5qpZOrP0NT9R0Uog8pa/WTP78DxIZMiX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301431894"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="301431894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 10:47:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601318407"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601318407"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 10:47:31 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6BB78104CE4; Mon,  3 Oct 2022 20:47:27 +0300 (+03)
Date:   Mon, 3 Oct 2022 20:47:27 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 14/39] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Message-ID: <20221003174727.vvposwdd4fmmi3hw@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-15-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-15-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:11PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> A shadow stack PTE must be read-only and have _PAGE_DIRTY set.  However,
> read-only and Dirty PTEs also exist for copy-on-write (COW) pages.  These
> two cases are handled differently for page faults. Introduce
> VM_SHADOW_STACK to track shadow stack VMAs.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/filesystems/proc.rst | 1 +
>  arch/x86/mm/mmap.c                 | 2 ++
>  fs/proc/task_mmu.c                 | 3 +++
>  include/linux/mm.h                 | 8 ++++++++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index e7aafc82be99..d54ff397947a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -560,6 +560,7 @@ encoded manner. The codes are the following:
>      mt    arm64 MTE allocation tags are enabled
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
> +    ss    shadow stack page
>      ==    =======================================
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index c90c20904a60..f3f52c5e2fd6 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -165,6 +165,8 @@ unsigned long get_mmap_base(int is_legacy)
>  
>  const char *arch_vma_name(struct vm_area_struct *vma)
>  {
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		return "[shadow stack]";
>  	return NULL;
>  }
>  

But why here?

CONFIG_ARCH_HAS_SHADOW_STACK implies that there will be more than one arch
that supports shadow stack. The name has to come from generic code too, no?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
