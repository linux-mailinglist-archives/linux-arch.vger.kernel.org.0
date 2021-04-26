Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994336B21A
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhDZLMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 07:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhDZLMH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 07:12:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DFCF61075;
        Mon, 26 Apr 2021 11:11:17 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:11:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v25 29/30] mm: Update arch_validate_flags() to include
 vma anonymous
Message-ID: <20210426111114.GF4985@arm.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-30-yu-cheng.yu@intel.com>
 <20210426064056.bqbeekpsogd32yvm@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426064056.bqbeekpsogd32yvm@box.shutemov.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 26, 2021 at 09:40:56AM +0300, Kirill A. Shutemov wrote:
> On Thu, Apr 15, 2021 at 03:14:18PM -0700, Yu-cheng Yu wrote:
> > When newer VM flags are being created, such as VM_MTE, it becomes necessary
> > for mmap/mprotect to verify if certain flags are being applied to an
> > anonymous VMA.
> > 
> > To solve this, one approach is adding a VM flag to track that MAP_ANONYMOUS
> > is specified [1], and then using the flag in arch_validate_flags().
> > 
> > Another approach is passing vma_is_anonymous() to arch_validate_flags().
> > To prepare the introduction of PROT_SHSTK, which creates a shadow stack
> > mapping and can only be applied to an anonymous VMA, update arch_validate_
> > flags() to include anonymous VMA information.
> 
> I would rather pass down whole vma. Who knows what else
> arch_validate_flags() would need to know about the VMA tomorrow:
> 
> 	arch_validate_flags(vma, newflags);
> 
> should do the trick.

A reason why we added a separate VM_MTE_ALLOWED flag was that we wanted
MTE on other RAM-based based mappings, not just anonymous pages. See
51b0bff2f703 ("mm: Allow arm64 mmap(PROT_MTE) on RAM-based files").

Anyway, the above change doesn't get in the way.

-- 
Catalin
