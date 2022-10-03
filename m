Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1605F31B0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJCOC0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 10:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJCOBy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 10:01:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E6241991;
        Mon,  3 Oct 2022 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664805700; x=1696341700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ddjztWhV3UUDkLswvk71WAdPtvy3j53/6CHOczkz9O8=;
  b=n2k8FZkwu5Iz6fdtgPv6jrnfiUai2yAC5bxjn6Oo+HODZx9NBpG9DrzT
   GXQ3S9WyI3jM8tAVMpd44c+NCbvfou/MycbIrZkcchH5nR159JBOb8x0t
   idS3P3k+OEJAtBD+CNvn8rPx9pxlkHviZ0f8vwNArg4pSdSgYVu1wLg1t
   KAf+bkq9CxBV2d3jMTTgQ7BWLtqSuj6P/byyBGKHKzC28X5XFhKV9ranp
   f/bbsqC7oyOgUoJjDLihCvK+pqq29GQZEiniJspR95kGKwPLV82IZsHfl
   wTl55VRol6snT8x0/+JQ23E4FoyRL6mIsR1jPn1uWFGnO/18vuRzcEf07
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302615772"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="302615772"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 07:01:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="798729084"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="798729084"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 07:01:12 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9751D104CE4; Mon,  3 Oct 2022 17:01:09 +0300 (+03)
Date:   Mon, 3 Oct 2022 17:01:09 +0300
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Message-ID: <20221003140109.jgn3per7vbthifn5@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:04PM -0700, Rick Edgecombe wrote:
> +#else
> +static void do_user_control_protection_fault(struct pt_regs *regs,
> +					     unsigned long error_code)
> +{
> +	WARN_ONCE(1, "User-mode control protection fault with shadow support disabled\n");

Why is this a warning, but runtime check for !X86_FEATURE_IBT and
!X86_FEATURE_SHSTK below is fatal?

> +}
> +#endif
> +
> +#ifdef CONFIG_X86_KERNEL_IBT
> +
> +static __ro_after_init bool ibt_fatal = true;
> +
> +extern void ibt_selftest_ip(void); /* code label defined in asm below */
>  
> +static void do_kernel_control_protection_fault(struct pt_regs *regs)
> +{
>  	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
>  		regs->ax = 0;
>  		return;
> @@ -283,9 +335,29 @@ static int __init ibt_setup(char *str)
>  }
>  
>  __setup("ibt=", ibt_setup);
> -
> +#else
> +static void do_kernel_control_protection_fault(struct pt_regs *regs)
> +{
> +	WARN_ONCE(1, "Kernel-mode control protection fault with IBT disabled\n");

Ditto.

> +}
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  
> +#if defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK)
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT) &&
> +	    !cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pr_err("Unexpected #CP\n");
> +		BUG();
> +	}
> +
> +	if (user_mode(regs))
> +		do_user_control_protection_fault(regs, error_code);
> +	else
> +		do_kernel_control_protection_fault(regs);
> +}
> +#endif /* defined(CONFIG_X86_KERNEL_IBT) || defined(CONFIG_X86_SHADOW_STACK) */
> +
>  #ifdef CONFIG_X86_F00F_BUG
>  void handle_invalid_op(struct pt_regs *regs)
>  #else

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
