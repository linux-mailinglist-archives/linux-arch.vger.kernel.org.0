Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED4D4AFF7C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiBIVvu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 16:51:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiBIVvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 16:51:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB78C0F8692;
        Wed,  9 Feb 2022 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644443508; x=1675979508;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=2XmQo/8+05nnCFD6IB5G6G1lj5TYd6uWzLLIRuhEalQ=;
  b=d3EnY428EmiNpKkzFpWC/JPWIifX/DdHy8jhx/tEoF3iXtjaunIrcqRO
   ztzv+e+73vzSjXeFeNKd1HKhVF1MfVZds8Rw142+1VswqjtkNkUZYVTRL
   yuHA4SMcuGtYVw7MwU8zUQS5LY8bJKY7Fv6zJX0tNkKEMFku1sc+8ozIN
   nEkfD+zlgNCwinFV6TLNDlVDmyggCCtgXOk6ML9Ax26hK0PPifb5uqYto
   SHQ3hTRdXba/3b8Jta0kyYGwPmMffNO62Jb9mCf5G9rRpoZjnTgy2dP8U
   e7oci8g0kla64QBE7xmfUjjqfJbuqEB4Br7xMDZpoQwPZLxaJ/H2o+SHK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249102647"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249102647"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 13:51:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="585733999"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 13:51:45 -0800
Message-ID: <8065c333-0911-04a2-f91e-7c2e0cc7ec51@intel.com>
Date:   Wed, 9 Feb 2022 13:51:42 -0800
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
 <20220130211838.8382-18-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 17/35] mm: Fixup places that call pte_mkwrite() directly
In-Reply-To: <20220130211838.8382-18-rick.p.edgecombe@intel.com>
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
> - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
>   and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
>   them to maybe_mkwrite().

Those look OK.

> - In do_numa_page(), if the numa entry was writable, then pte_mkwrite()
>   is called directly.  Fix it by doing maybe_mkwrite().  Make the same
>   changes to do_huge_pmd_numa_page().

This is another "what", not "why" changelog.  This change puzzles me.

*Why* is this needed?  It sounds like pte_mkwrite() doesn't work for
shadow stack PTEs.  Let's say that explicitly.

I also this this is ab/misuse of maybe_mkwrite().

The shadow stack VMA *REQUIRES* PTEs with Dirty=1.  There's no *maybe*
about it.  The rest of this is essentially a hack to get
VM_SHADOW_STACK-required bits into the PTE.  We have a place where we
store those VMA-required bits: vma->vm_page_prot.  Look at how we store
the pkey bits in there for instance.

Let's say we set _PAGE_DIRTY in vma->vm_page_prot.  We'd come into
do_anonymous_page() for instance and do this:

>         entry = mk_pte(page, vma->vm_page_prot); <--- PTE is Write=0,Dirty=1 Yay!
>         entry = pte_sw_mkyoung(entry);
>         if (vma->vm_flags & VM_WRITE) <--- False, skip the pte_mkwrite()
>                 entry = pte_mkwrite(pte_mkdirty(entry));

In other words, it "just works" because shadow stack VMAs don't have
VM_WRITE set.

I think the other VM_WRITE checks would be fine too, although I'm unsure
about the change_page_attr() one.
