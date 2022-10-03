Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D45F3A21
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJCX4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJCX43 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:56:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297F6F0A;
        Mon,  3 Oct 2022 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664841389; x=1696377389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6XLut9fCI2BusF7FW4UFN2zGNXA0WuyqUD1GICm8FWA=;
  b=PAU7jXCXQYiz8NqgKQf8+4NJWWbl1yGODwG5+fnF+p92uRIGDVm6Lhbb
   B8FNQNL1PrmriklqWKLGv5v3bV7bRNQPkbkjeD+w9m0SkA7kuZJP5xF5I
   ZJLH4XAZqrRygFzOsPeXxP7JxrlhfE7bWmEQw5A3PrvRgeMrQjC23kBCo
   gf3DUx3Kke35r8VTAOI74PNy/ILtzgINX8AOTI2MWz9Mo09TUXF08XPy6
   YmYedasf0joNyRPdlf9Z16qllA4xmlFgAApnYn61uLV1MQpBcCSJ2Nwaw
   F871L8h2TLvkBUpw8SNQHwkf1mo63p2msxYuxinZmv9I1L6f/D3RprrKX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302767653"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302767653"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:56:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712821467"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="712821467"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:56:21 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1D6F3104CE4; Tue,  4 Oct 2022 02:56:19 +0300 (+03)
Date:   Tue, 4 Oct 2022 02:56:19 +0300
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <20221003235619.qdoedbrcrplaa4tf@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-18-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-18-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:14PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> With the introduction of shadow stack memory there are two ways a pte can
> be writable: regular writable memory and shadow stack memory.
> 
> In past patches, maybe_mkwrite() has been updated to apply pte_mkwrite()
> or pte_mkwrite_shstk() depending on the VMA flag. This covers most cases
> where a PTE is made writable. However, there are places where pte_mkwrite()
> is called directly and the logic should now also create a shadow stack PTE
> in the case of a shadow stack VMA.
> 
>  - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE
>    directly and call pte_mkwrite(), which is the same as maybe_mkwrite()
>    in logic and intention. Just change them to maybe_mkwrite().

Looks like you folded change for do_anonymous_page() into the wrong patch.
I see the relevant change in the previous patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
