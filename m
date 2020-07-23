Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9B22B330
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGWQKl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 12:10:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:10382 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQKl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 12:10:41 -0400
IronPort-SDR: QLuu9s7Hp+vjybC9uDZIpXvDMT3zW+g1vEq14+zK/uHNXmrWCvSpmqO98ZX0GjZDYYdAjSdTTB
 gR4KiKIytJ7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148056938"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="148056938"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:10:40 -0700
IronPort-SDR: sMTr1T4Ot5Yvoa3Z7f6Gt+sLRJaAGqkGv0CKqHpKa6bv1iw8QUxMeH7wjKcme7VYbDmyD+KuPr
 iT9q6o6QxZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="320703879"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2020 09:10:40 -0700
Date:   Thu, 23 Jul 2020 09:10:39 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
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
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v10 03/26] x86/fpu/xstate: Introduce CET MSR XSAVES
 supervisor states
Message-ID: <20200723161039.GE21891@linux.intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429220732.31602-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 29, 2020 at 03:07:09PM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 12c9684d59ba..47f603729543 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -885,4 +885,22 @@
>  #define MSR_VM_IGNNE                    0xc0010115
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>  
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
> +#define MSR_IA32_PL0_SSP	0x6a4 /* kernel shstk pointer */
> +#define MSR_IA32_PL1_SSP	0x6a5 /* ring-1 shstk pointer */
> +#define MSR_IA32_PL2_SSP	0x6a6 /* ring-2 shstk pointer */
> +#define MSR_IA32_PL3_SSP	0x6a7 /* user shstk pointer */
> +#define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shstk table */
> +
> +/* MSR_IA32_U_CET and MSR_IA32_S_CET bits */
> +#define MSR_IA32_CET_SHSTK_EN		0x0000000000000001ULL

Can we drop the MSR_IA32 prefix for the individual bits?  Mostly to yield
shorter line lengths, but also because it's more or less redundant info,
and in some ways unhelpful as it's hard to quickly differentiate between
"this is an MSR index" and "this is a bit/mask for an MSR".

My vote would also be to use BIT() or BIT_ULL().  The SDM defines the flags
by their (decimal) bit number.  Manually converting the bits to masks makes
it difficult to check for correctness.

E.g.

#define CET_SHSTK_EN		BIT(0)
#define CET_WRSS_EN		BIT(1)
#define CET_ENDBR_EN		BIT(2)
#define CET_LEG_IW_EN		BIT(3)
#define CET_NO_TRACK_EN		BIT(4)
#define CET_WAIT_ENDBR		BIT(5)

> +#define MSR_IA32_CET_WRSS_EN		0x0000000000000002ULL
> +#define MSR_IA32_CET_ENDBR_EN		0x0000000000000004ULL
> +#define MSR_IA32_CET_LEG_IW_EN		0x0000000000000008ULL
> +#define MSR_IA32_CET_NO_TRACK_EN	0x0000000000000010ULL
> +#define MSR_IA32_CET_WAIT_ENDBR	0x00000000000000800UL
> +#define MSR_IA32_CET_BITMAP_MASK	0xfffffffffffff000ULL

This particular define, the so called BITMAP_MASK, is no longer used in the
IBT series.  IMO it'd be better off dropping this mask as it's not clear
from the name that this is really nothing more than a mask for a virtual
address, e.g. at first glance (for someone without CET knowledge) it looks
like bits 63:12 hold a bitmap as opposed to holding a pointer to a bitmap.
