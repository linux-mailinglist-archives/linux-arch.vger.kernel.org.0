Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0C5F3A18
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJCXxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJCXxN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:53:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335523BE3;
        Mon,  3 Oct 2022 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664841192; x=1696377192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XsbQqB1kOV5HDsgsc4ONdzxsJU1pLr3Pc/WAWDj/ozo=;
  b=nRPEqYmVaE0MM0Ksv7Q55Z32YUCsu5AGy1PuPLcRRvM2Tb4fKqko0j5z
   QFrHXgJmhWTCNSMvXl0vIGEz2csaqMX/vf/k/ecibZeexVXa3Wd8/63r0
   69o7gYYP+9c8A2NjUfot0OpL6tpGRuWNCFSxtUzV12Q3V427Itpsa2PjI
   YNeESS3tOpPqiZm1Qq7ThsviLl0SOnZreH8vwo/8Ec9chI7s0Pmm31jzI
   3WXwUsG1vRVNEGLtM86odAq5L2ICxBom2CpOY1zrBHfGhDSEU50icqWho
   b5n2q1+QO5Y5e8mbkPMwFwJHAc2fZao1WqqP8CRf6XMTie7+asLWpF2kL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366887311"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366887311"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:53:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="749189186"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="749189186"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:53:03 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 319D8104CE4; Tue,  4 Oct 2022 02:53:00 +0300 (+03)
Date:   Tue, 4 Oct 2022 02:53:00 +0300
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
Subject: Re: [PATCH v2 16/39] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <20221003235300.zkf6lfemd7kyl47z@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-17-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:13PM -0700, Rick Edgecombe wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8cd413c5a329..fef14ab3abcb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -981,13 +981,25 @@ void free_compound_page(struct page *page);
>   * servicing faults for write access.  In the normal case, do always want
>   * pte_mkwrite.  But get_user_pages can cause write faults for mappings
>   * that do not have writing enabled, when used by access_process_vm.
> + *
> + * If a vma is shadow stack (a type of writable memory), mark the pte shadow
> + * stack.
>   */
> +#ifndef maybe_mkwrite
>  static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>  {
> -	if (likely(vma->vm_flags & VM_WRITE))
> +	if (!(vma->vm_flags & VM_WRITE))
> +		goto out;
> +
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		pte = pte_mkwrite_shstk(pte);
> +	else
>  		pte = pte_mkwrite(pte);
> +
> +out:
>  	return pte;
>  }
> +#endif

Maybe take opportunity to move it to <linux/pgtable.h>? It is really not a
place for the helper.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
