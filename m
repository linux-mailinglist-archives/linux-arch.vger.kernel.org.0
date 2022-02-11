Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE14B304F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354038AbiBKWT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 17:19:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354034AbiBKWTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 17:19:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B614ED5E;
        Fri, 11 Feb 2022 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644617993; x=1676153993;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=QhwemLJz6XJr4WABSGeGJItc6/s04gnX8fKaV4emL8o=;
  b=RVeAhIHC8pPpmfl3USyTn2BShq9mrCdK8YGuhDI+NkPy8zeGLghkvxLk
   lf6qWGWsJGYdiFN4OKID7GNlhqG3ClvblwVkQ+XBgJdurSOuR6aur7pzg
   xsf/71RWhk2vT9mNJ0ym3pDiv+N933v3YIYeu9WV2WeAeCLWRbFSBZOkw
   G5fdaDJwvqoSwNfDNGgIrvTnW89mgc9kbdMdGqERXvhfo8LGujFxbpNsS
   h8W80lFafIg2vhPieX3G5KyOwYsZa1tUCZ1PLPVTHyXv72LKoKAcQrddk
   i448uERDKnGtw6xiHepTXB4yOChusSH+8QkmWfuUSXX101WF0CLYU2Ii/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237224081"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="237224081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 14:19:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542262078"
Received: from nsmdimra-mobl.amr.corp.intel.com (HELO [10.209.96.127]) ([10.209.96.127])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 14:19:52 -0800
Message-ID: <3df8595d-46d9-aaee-dd33-3118102ef750@intel.com>
Date:   Fri, 11 Feb 2022 14:19:49 -0800
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
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-23-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 22/35] x86/mm: Prevent VM_WRITE shadow stacks
In-Reply-To: <20220130211838.8382-23-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> Shadow stack accesses are writes from handle_mm_fault() perspective. So to
> generate the correct PTE, maybe_mkwrite() will rely on the presence of
> VM_SHADOW_STACK or VM_WRITE in the vma.
> 
> In future patches, when VM_SHADOW_STACK is actually creatable by
> userspace, a problem could happen if a user calls
> mprotect( , , PROT_WRITE) on VM_SHADOW_STACK shadow stack memory. The code
> would then be confused in the event of shadow stack accesses, and create a
> writable PTE for a shadow stack access. Then the process would fault in a
> loop.
> 
> Prevent this from happening by blocking this kind of memory (VM_WRITE and
> VM_SHADOW_STACK) from being created, instead of complicating the fault
> handler logic to handle it.
> 
> Add an x86 arch_validate_flags() implementation to handle the check.
> Rename the uapi/asm/mman.h header guard to be able to use it for
> arch/x86/include/asm/mman.h where the arch_validate_flags() will be.

It would be great if this also said:

	There is an existing arch_validate_flags() hook for mmap() and
	mprotect() which allows architectures to reject unwanted
	->vm_flags combinations.  Add an implementation for x86.

That's somewhat implied from what is there already, but making it more
clear would be nice.  There's a much higher bar to add a new arch hook
than to just implement an existing one.


> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
> new file mode 100644
> index 000000000000..b44fe31deb3a
> --- /dev/null
> +++ b/arch/x86/include/asm/mman.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_MMAN_H
> +#define _ASM_X86_MMAN_H
> +
> +#include <linux/mm.h>
> +#include <uapi/asm/mman.h>
> +
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static inline bool arch_validate_flags(unsigned long vm_flags)
> +{
> +	if ((vm_flags & VM_SHADOW_STACK) && (vm_flags & VM_WRITE))
> +		return false;
> +
> +	return true;
> +}

The design decision here seems to be that VM_SHADOW_STACK is itself a
pseudo-VM_WRITE flag.  Like you said: "Shadow stack accesses are writes
from handle_mm_fault()".

Very early on, this series seems to have made the decision that shadow
stacks are writable and need lots of write handling behavior, *BUT*
shouldn't have VM_WRITE set.  As a whole, that seems odd.

The alternative would be *requiring* VM_WRITE and VM_SHADOW_STACK be set
together.  I guess the downside is that pte_mkwrite() would need to be
made to work on shadow stack PTEs.

That particular design decision was never discussed.  I think it has a
really big impact on the rest of the series.  What do you think?  Was it
a good idea?  Or would the alternative be more complicated than what you
have now?
