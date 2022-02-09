Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED464B002E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiBIW2j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 17:28:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiBIW2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 17:28:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86480E01A2DD;
        Wed,  9 Feb 2022 14:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644445677; x=1675981677;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=SfeEZ6Op0bvafHg5MlJ6fjdSi90N4yjAydK+PCRbadk=;
  b=lly4Pgpp4F2zK0o/xha6ocMtS/XxRo1XzPkLQ2tCtu17LSx0wu34pJrw
   uOkr52lfHWnHNO7wrwas5AzAgoHk/a2k2KaubN38xYrLC20HgYFFRHO0Q
   fAxiC2S9gkb0bff4S0hrYkhKrGko3Ls9dfOcgCiMizHZZffGEDhmg1yHk
   1zcmSMJ0ePiUKYN2X5TAgGHfdX9wWeuYiG5n6f8nt72MqbmOrjUytZYHN
   Uwgd1Rz/0cBTED8y+AsSsApbls5l2kM3wVQMbHiQmSiDRkOHApzzU0eK+
   u6dN7qe4BkhpeC2FjL9Lmi3O7BHC4CFelB/KmXL8IwIbBCKXYlb9y3+P5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="230003811"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="230003811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:27:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="585744850"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:27:55 -0800
Message-ID: <804adbac-61e6-0fd2-f726-5735fb290199@intel.com>
Date:   Wed, 9 Feb 2022 14:27:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-20-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 19/35] mm/mmap: Add shadow stack pages to memory
 accounting
In-Reply-To: <20220130211838.8382-20-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> +bool is_shadow_stack_mapping(vm_flags_t vm_flags)
> +{
> +	return vm_flags & VM_SHADOW_STACK;
> +}
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index bc8713a76e03..21fdb1273571 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -911,6 +911,14 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	__ptep_modify_prot_commit(vma, addr, ptep, pte);
>  }
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> +
> +#ifndef is_shadow_stack_mapping
> +static inline bool is_shadow_stack_mapping(vm_flags_t vm_flags)
> +{
> +	return false;
> +}
> +#endif

Hold your horses there.  Remember:

+#ifdef CONFIG_X86_SHADOW_STACK
+# define VM_SHADOW_STACK       VM_HIGH_ARCH_5
+#else
+# define VM_SHADOW_STACK       VM_NONE
+#endif

Plus:

#define VM_NONE         0x00000000

That means the arch-generic version, when CONFIG_X86_SHADOW_STACK is off
compiles down to:

bool is_shadow_stack_mapping(vm_flags_t vm_flags)
{
	return vm_flags & 0x00000000;
}

I _suspect_ the compiler *might* compile that down to the same thing as:

	return false;

So, why not just have one version, no additional #ifdefs, and be done
with it?  Heck, why have the helper in the first place?  Just check
VM_SHADOW_STACK directly.
