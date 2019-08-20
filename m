Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6801952EF
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 03:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfHTBCB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 21:02:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:19894 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHTBCB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 21:02:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 18:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; 
   d="scan'208";a="180537314"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2019 18:02:00 -0700
Date:   Mon, 19 Aug 2019 18:02:00 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 18/27] mm: Introduce do_mmap_locked()
Message-ID: <20190820010200.GI1916@linux.intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
 <20190813205225.12032-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813205225.12032-19-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:52:16PM -0700, Yu-cheng Yu wrote:
> There are a few places that need do_mmap() with mm->mmap_sem held.
> Create an in-line function for that.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  include/linux/mm.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc58585014c9..275c385f53c6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2394,6 +2394,24 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
>  static inline void mm_populate(unsigned long addr, unsigned long len) {}
>  #endif
>  
> +static inline unsigned long do_mmap_locked(struct file *file,
> +	unsigned long addr, unsigned long len, unsigned long prot,
> +	unsigned long flags, vm_flags_t vm_flags, struct list_head *uf)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long populate;
> +
> +	down_write(&mm->mmap_sem);
> +	addr = do_mmap(file, addr, len, prot, flags, vm_flags, 0,
> +		       &populate, uf);
> +	up_write(&mm->mmap_sem);
> +
> +	if (populate)
> +		mm_populate(addr, populate);
> +
> +	return addr;
> +}

Any reason not to put this in cet.c, as suggested by PeterZ?  All of the
calls from CET have identical params except for @len, e.g. you can add
'static unsigned long cet_mmap(unsigned long len)' and bury most of the
copy-paste code in there.

https://lkml.kernel.org/r/20190607074707.GD3463@hirez.programming.kicks-ass.net

> +
>  /* These take the mm semaphore themselves */
>  extern int __must_check vm_brk(unsigned long, unsigned long);
>  extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
> -- 
> 2.17.1
> 
