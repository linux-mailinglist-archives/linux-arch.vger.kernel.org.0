Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB505F9E96
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJJMTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJJMTR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 08:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B0D1901C
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2022 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665404354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuVFVTcNy3PvU+4gEYPhzjX6GgrNG/BY4EXShYmdUcQ=;
        b=gFSOsuIhrtRLHWjL0DS2bVPtrratVW2oTgiPwq6VNbbkUirG6uzIlH9S1hR3viaR0M6C+q
        eLgCrqbZ/1u0vUNplR+c4BZz0/09jVQjf9RYIpCrnnlj64AlngZsfM7vPjsyqtYcr/S3FB
        ovlh/V+RbNpIm7WQg6RlH3NIpdE8WJw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-cHpdmPekN6WixYccXEvHVw-1; Mon, 10 Oct 2022 08:19:11 -0400
X-MC-Unique: cHpdmPekN6WixYccXEvHVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF8433810D22;
        Mon, 10 Oct 2022 12:19:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBAE401D45;
        Mon, 10 Oct 2022 12:19:02 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
        <20220929222936.14584-2-rick.p.edgecombe@intel.com>
Date:   Mon, 10 Oct 2022 14:19:00 +0200
In-Reply-To: <20220929222936.14584-2-rick.p.edgecombe@intel.com> (Rick
        Edgecombe's message of "Thu, 29 Sep 2022 15:28:58 -0700")
Message-ID: <87ilkr27nv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick Edgecombe:

> +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0.1
> +or later are required. To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.

Uhm, I think we are using binutils 2.30 with extra fixes.  I hope that
these binaries are still valid.

More importantly, glibc needs to be configured with --enable-cet
explicitly (unless the compiler defaults to CET).  The default glibc
build with a default GCC will produce dynamically-linked executables
that disable CET (when running on later/differently configured glibc
builds).  The statically linked object files are not marked up for CET
in that case.

I think the goal is to support the new kernel interface for actually
switching on SHSTK in glibc 2.37.  But at that point, hopefully all
those existing binaries can start enjoying the STSTK benefits.

Thanks,
Florian

