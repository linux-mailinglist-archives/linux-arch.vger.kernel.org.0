Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855144B163F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 20:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbiBJT1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 14:27:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbiBJT1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 14:27:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC51BF;
        Thu, 10 Feb 2022 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644521259; x=1676057259;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=KgGGYz1uf3JX/t90pBcGCFyoEJL2Bi12Sok3epGvjoU=;
  b=Q3XCtvxEN8ejztXdjfWGuXT/iSEa5/ftyrHs/SecpTNtpO8MpeifNCR2
   ZXw0zmf9xMvGLExjFyyRe17N0ZXTYJyPdjnQ5HQw8Tcu4k7xG+4dyWjRc
   yvshqU2pSsMCzhMQgLpltaOO6p1xsoI+/y+jvoAUKo5ytCa4bakLv8nyJ
   7JJKzH4yKKn+BdyR+E/yc7/mBv2VFJ1CIRHX5g0it0Q/isMYBhhelnnF5
   Mr2t7mapvSS+VrPZG05Tv9N8bpjiCe1hhEzP1tIoAdr1ZfZj7dWs2agLG
   QqW7iKPtn21GpwbdAd+IFgwpv0BUxNyxgoogwPV/KzbeoJlXZDNG7rkUA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="335996186"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="335996186"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 11:27:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500514005"
Received: from pengyusu-mobl.amr.corp.intel.com (HELO [10.212.149.216]) ([10.212.149.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 11:27:37 -0800
Message-ID: <fc2274d4-4f1d-d86b-38ad-d80141c3115c@intel.com>
Date:   Thu, 10 Feb 2022 11:27:34 -0800
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
 <20220130211838.8382-22-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 21/35] mm/mprotect: Exclude shadow stack from
 preserve_write
In-Reply-To: <20220130211838.8382-22-rick.p.edgecombe@intel.com>
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
> In change_pte_range(), when a PTE is changed for prot_numa, _PAGE_RW is
> preserved to avoid the additional write fault after the NUMA hinting fault.
> However, pte_write() now includes both normal writable and shadow stack
> (RW=0, Dirty=1) PTEs, but the latter does not have _PAGE_RW and has no need
> to preserve it.

This series creates an interesting situation: it causes a logical
disconnection between things that were tightly coupled before.  For
instance, before this series, _PAGE_RW=1 and "writable" really were
synonyms.  They meant the same thing.

One of the complexities in this series is differentiating the two.  For
instance, a shadow stack page can be written to, even though it has
_PAGE_RW=0.

This particular patch seems to be hacking around the problem that a
p*_mkwrite() doesn't work on shadow stack PTE/PMDs.  First, that makes
me wonder what *actually* happens if we do a plain pte_mkwrite() on a
shadow stack PTE.  I *think* it will take the [Write=0,Dirty=1] PTE and

       pte = pte_set_flags(pte, _PAGE_RW);

so we'll end up with [Write=1,Dirty=1], which is bad.

Let's say pte_mkwrite() can't be fixed.  We should probably make it
VM_BUG_ON() if it's ever asked to muck with a shadow stack PTE.

It's also weird because we have this pte_write()==1 PTE in a !VM_WRITE
VMA.  Then, we're trying to pte_mkwrite() under this !VM_WRITE VMA.

	pte_write() <-- returns true for on shadow stack PTE!
	pte_mkwrite() <-- illegal on shadow stack PTE

I need to think about this a little more.  I don't have a solution.
But, as-is, it seems untenable.  The rules are just too counter
intuitive to live.
