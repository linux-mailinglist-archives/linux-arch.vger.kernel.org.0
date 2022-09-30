Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271C5F0C7C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiI3NdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiI3NdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 09:33:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BDD15FC7A;
        Fri, 30 Sep 2022 06:33:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0E2B27C0;
        Fri, 30 Sep 2022 13:33:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0E2B27C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664544792; bh=X9KMoc6wKBFQqqh02TQnYl/8HMk3OVzEUhHumF3CpUI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kAqoBsdLwJvwA/TnNO/OyRTe2bzVmSSUI9PjBrUPKUk9/BKv7DANoLUEyUh86zUzM
         Tbc5O4vzMtnEr14y3c0B5KoNEloNewUcVaNYsryTveAiUZJdd9tDUFy8BkrMkk6+1Z
         4DO9iLaZs6s6psbIVtfQAEv89PJUiK/SzYjo2UkehxhoEG3FavVvfiuFvfztMr7aT8
         xe1dQBqlt3fAwse16dnmBymfM3LKrJNUgB+404pJu5Az8ICKy1S/V4gyFtA3mwCe40
         MSN+M9e1UAjp8Vm+qWOaCB5LdtBTcrwIgapidvz/MjTAdezwNNCm0q6BavLWAZYAeg
         89b3RqCM2Ljkg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
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
In-Reply-To: <YzZlT7sO56TzXgNc@debian.me>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me>
Date:   Fri, 30 Sep 2022 07:33:11 -0600
Message-ID: <87v8p5f0mg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The documentation above can be improved (both grammar and formatting):
>
> ---- >8 ----
>
> diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
> index 6b270a24ebc3a2..f691f7995cf088 100644
> --- a/Documentation/x86/cet.rst
> +++ b/Documentation/x86/cet.rst
> @@ -15,92 +15,101 @@ in the 64-bit kernel.
>  
>  CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
>  a secondary stack allocated from memory and cannot be directly modified by
> -applications. When executing a CALL instruction, the processor pushes the
> +applications. When executing a ``CALL`` instruction, the processor pushes the

Just to be clear, not everybody is fond of sprinkling lots of ``literal
text`` throughout the documentation in this way.  Heavy use of it will
certainly clutter the plain-text file and can be a net negative overall.

Thanks,

jon
