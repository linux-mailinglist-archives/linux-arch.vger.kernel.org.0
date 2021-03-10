Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD76334BAE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 23:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCJWjk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 17:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCJWjd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 17:39:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9440864FAD;
        Wed, 10 Mar 2021 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615415973;
        bh=/46Jnxa7GWN9GVouuxzmFfEuec3FnGDcKOJciHOHIws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQVhIJPvxkTfFjVIPmqOKZDu2W4Nh4bCefUys/PH4bS7IXAKLvuIGeL9yhBYKdFP5
         lksoks30ZjiCv8ilR8KqVY0PdBbpG0g0TNcfZHYk6hwqtefg7gFEAY87X7yt8mhdol
         QJ2wOLKtIHhcKvcevYhkWhkRCocXou2LN0rCUhk4Zwgl/MnwRYDLqQcrzt1v6lVUMJ
         Lb+tXWCBqUqRthdAEPSfKPBq6I4FMl068ag+2rhpdfTX7oWzWweApQZ/DYZhaSw0nL
         DnvADmCkmQa8QE8r3T5gVPAbIyjReGYNV0r37VQZ0hTFu5acOicAQLQ41bdECi4BzT
         VOU+cnaHYAdzQ==
Date:   Thu, 11 Mar 2021 00:39:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
Message-ID: <YElKjT2v628tidE/@kernel.org>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310220519.16811-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 02:05:19PM -0800, Yu-cheng Yu wrote:
> When CET is enabled, __vdso_sgx_enter_enclave() needs an endbr64
> in the beginning of the function.

OK.

What you should do is to explain what it does and why it's needed.

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  arch/x86/entry/vdso/vsgx.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
> index 86a0e94f68df..a70d4d09f713 100644
> --- a/arch/x86/entry/vdso/vsgx.S
> +++ b/arch/x86/entry/vdso/vsgx.S
> @@ -27,6 +27,9 @@
>  SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  	/* Prolog */
>  	.cfi_startproc
> +#ifdef CONFIG_X86_CET
> +	endbr64
> +#endif
>  	push	%rbp
>  	.cfi_adjust_cfa_offset	8
>  	.cfi_rel_offset		%rbp, 0
> -- 
> 2.21.0
> 
> 

/Jarkko
