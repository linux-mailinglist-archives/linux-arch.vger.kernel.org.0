Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927805F3A50
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 02:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJDAD5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 20:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJDADv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 20:03:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F3E193EA;
        Mon,  3 Oct 2022 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664841829; x=1696377829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Os63+EX8WH0KuFh3ggC0GBsbdgmNnf/a/c28uddDCRs=;
  b=EZvh8XdO1EBPFl2b4cjCcrZmrosIvJdkJXcT90hLU79P2EbNFS2B1WsB
   dfx1NGWcq6hqYvvnwayHO3SXUoEXDn0QKKnSIu0+evh9iGxDFIF30rqTY
   72Ha8E/qHVWlBIpveJ4V6gaGdBI5bOR5pOFQU0+pEGRZN88pk1wFCWOhm
   HxZX4wlTHkBCNTt/TRvIggQvjo2tHQ5kI+Urfwy05bqoyVAhRW9IDgisU
   y5V7KQNUOaKO9acNf8IUmOvINnfdOw4nGrLscSLEzM4aKQX/XpWSioip/
   mfVTPSNX+zd4crb5U4O1yYMYdDyuoQPyIBf4z2AX8oXzwczj61QmJbdNU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="290010298"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="290010298"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:03:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="656943083"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="656943083"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:03:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 659E3104CE4; Tue,  4 Oct 2022 03:03:36 +0300 (+03)
Date:   Tue, 4 Oct 2022 03:03:36 +0300
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
Subject: Re: [PATCH v2 19/39] mm/mmap: Add shadow stack pages to memory
 accounting
Message-ID: <20221004000336.cpuats6iamw5ob3h@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-20-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-20-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:16PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Account shadow stack pages to stack memory.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> 
> v2:
>  - Remove is_shadow_stack_mapping() and just change it to directly bitwise
>    and VM_SHADOW_STACK.
> 
> Yu-cheng v26:
>  - Remove redundant #ifdef CONFIG_MMU.
> 
> Yu-cheng v25:
>  - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().
> 
>  mm/mmap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f0d2e9143bd0..8569ef09614c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1682,6 +1682,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	if (file && is_file_hugepages(file))
>  		return 0;
>  
> +	if (vm_flags & VM_SHADOW_STACK)
> +		return 1;
> +
>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;

Hm. Isn't the last check true for shadow stack too? IIUC, shadow stack has
VM_WRITE set, so accountable_mapping() should work correctly as is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
