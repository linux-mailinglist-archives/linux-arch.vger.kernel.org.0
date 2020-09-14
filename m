Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9496268EEF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgINPEn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 11:04:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:43601 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgINOvD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Sep 2020 10:51:03 -0400
IronPort-SDR: vVkaVWRYy3Y+ZAu7mNyf+DDbO30vp1I3N8qOw9uX7VXlsyfqcVaEWHrajymhYd22VioBihzzLQ
 7M1rWQUShhGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160019834"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="160019834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:50:53 -0700
IronPort-SDR: D22eyFJtL3FUI50v72FdSc2QGREc8o8ZWP6ylwCDYTERMIczAE9TLj/D9Mh+x6jWZTQK0s+dVI
 Xf7HiQv3zKCw==
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="507168511"
Received: from pkamat-mobl1.amr.corp.intel.com (HELO [10.209.79.20]) ([10.209.79.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:50:49 -0700
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com>
 <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
 <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
 <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
 <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
 <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com>
 <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
 <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
 <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
 <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
 <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
 <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
 <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
 <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
Date:   Mon, 14 Sep 2020 07:50:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/11/20 3:59 PM, Yu-cheng Yu wrote:
...
> Here are the changes if we take the mprotect(PROT_SHSTK) approach.
> Any comments/suggestions?

I still don't like it. :)

I'll also be much happier when there's a proper changelog to accompany
this which also spells out the alternatives any why they suck so much.

> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
> index d4a8d0424bfb..024f006fcfe8 100644
> --- a/arch/x86/include/uapi/asm/mman.h
> +++ b/arch/x86/include/uapi/asm/mman.h
> @@ -4,6 +4,8 @@
>  
>  #define MAP_32BIT	0x40		/* only give out 32bit addresses */
>  
> +#define PROT_SHSTK	0x10		/* shadow stack pages */
> +
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>  /*
>   * Take the 4 protection key bits out of the vma->vm_flags
> @@ -19,13 +21,35 @@
>  		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
>  		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
>  
> -#define arch_calc_vm_prot_bits(prot, key) (		\
> +#define pkey_vm_prot_bits(prot, key) (			\
>  		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
>  		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
>  		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
>  		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
> +#else
> +#define pkey_vm_prot_bits(prot, key)
>  #endif

My inner compiler doesn't think this will compile:

	( | shstk_vm_prot_bits(prot))


> +#define shstk_vm_prot_bits(prot) ( \
> +		(static_cpu_has(X86_FEATURE_SHSTK) && (prot & PROT_SHSTK)) ? \
> +		VM_SHSTK : 0)

Why do you need to filter PROT_SHSTK twice.  Won't the prot passed in
here be filtered by arch_validate_prot()?

> +#define arch_calc_vm_prot_bits(prot, key) \
> +		(pkey_vm_prot_bits(prot, key) | shstk_vm_prot_bits(prot))
> +

IMNHO, this is eminently more readable if you do:

#define arch_calc_vm_prot_bits(prot, key)	\
		(shstk_vm_prot_bits(prot))	\
		  pkey_vm_prot_bits(prot, key))

BTW, can these be static inlines?  I forget if I had a good reason for
making them #defines.

> +static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
> +{
> +	unsigned long supported = PROT_READ | PROT_EXEC | PROT_SEM;
> +
> +	if (static_cpu_has(X86_FEATURE_SHSTK) && (prot & PROT_SHSTK))
> +		supported |= PROT_SHSTK;
> +	else
> +		supported |= PROT_WRITE;

I generally like to make the common case dirt simple to understand.
That would probably be:

	unsigned long supported = PROT_READ | PROT_WRITE |
				  PROT_EXEC | PROT_SEM;

	if (static_cpu_has(X86_FEATURE_SHSTK) && (prot & PROT_SHSTK)) {
		supported |= PROT_SHSTK;
		// Comment about why SHSTK and WRITE
		// are mutually exclusive.

		supported &= ~PROT_WRITE;
	}

>  #endif /* _ASM_X86_MMAN_H */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index a8edbcb3af99..520bd8caa005 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -571,6 +571,17 @@ static int do_mprotect_pkey(unsigned long start, size_t
> len,
>  				goto out;
>  		}
>  	}
> +
> +	/*
> +	 * Only anonymous mapping is suitable for shadow stack.
> +	 */

Why?

> +	if (prot & PROT_SHSTK) {
> +		if (vma->vm_file) {
> +			error = -EINVAL;
> +			goto out;
> +		}
> +	}

You can also save a couple of lines there.  The two conditions are
pretty small.
