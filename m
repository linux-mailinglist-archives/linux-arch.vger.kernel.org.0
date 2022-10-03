Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8757E5F358B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJCSYP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJCSYO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:24:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B809422E4
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 11:24:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q99-20020a17090a1b6c00b0020ac0368d64so1359335pjq.3
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wwu9lS4IvfCeN8Phj9REKX62enam27neFFF0OO9ppKE=;
        b=lKYqWl6A7r7Sr3/E8BW6VSg1cqafipTQuK3eeQGyiGtbferERJ1wgzXHmp//KGEi2u
         8h9uWTewlGL3XnZ5UgKRaznBiAGYZQBq50XP0umLoU6PolD2t32jNaRYebTAta7cD5AD
         ZPlpGlvp8IeKDGNn/JAOTfP3n9rQeemlrq1uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wwu9lS4IvfCeN8Phj9REKX62enam27neFFF0OO9ppKE=;
        b=lfreU61JlfKR3JATRvTKHMYnylAOsdXK4RhblQvUgzGtKuy3ksjr5vcX/hZRrq/Bgx
         VYgUvr+WcXC4JlOwHbPqpeo0EcvMiFS6MalaHB7afvRxjlwPf7Ar21C70PeKISMAXB80
         FW79IbSQPKbruOTSuhRLkPp6TSY4DzqLKYEx4oX/F4eJIN1UkIgBemwjLOLun8cb+rcA
         sfkE/85GCyx8YllOrmw9IlfXIyqbtO+Ue3icZl4QGCabpf6x5EoPNgocTKRKRel87oZZ
         8cljFPzgeHe/DFu1b7NBKff9md+LiSA7NyQhzNqrLnrNXV83IHJi7OdNLkcQKK2D7DCX
         LSkg==
X-Gm-Message-State: ACrzQf0tiToQF0AorM3Kjv3modxV6sGJtRfcs9bqedqoqZ4JDb6/HeEz
        kwcOSWYLjRG4yHGNvRuPlAnEHQ==
X-Google-Smtp-Source: AMsMyM48Fs8gaQUQGBbjWpok2lFT9yYn1cXchH8flHZ8xyiWHgOGJ7sBj0XqkcvhSLNZbKtef4o3rg==
X-Received: by 2002:a17:902:b589:b0:179:f8c5:7212 with SMTP id a9-20020a170902b58900b00179f8c57212mr23373642pls.174.1664821449445;
        Mon, 03 Oct 2022 11:24:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b0053e8f4a10c1sm7717403pfb.217.2022.10.03.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:24:08 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:24:07 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <202210031124.81D807B6B@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-18-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-18-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> 
>  - When userfaultfd is creating a PTE after userspace handles the fault
>    it calls pte_mkwrite() directly. Teach it about pte_mkwrite_shstk()
> 
> In other cases where pte_mkwrite() is called directly, the VMA will not
> be VM_SHADOW_STACK, and so shadow stack memory should not be created.
>  - In the case of pte_savedwrite(), shadow stack VMA's are excluded.
>  - In the case of the "dirty_accountable" optimization in mprotect(),
>    shadow stack VMA's won't be VM_SHARED, so it is not nessary.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
