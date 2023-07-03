Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E487462B8
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 20:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGCSu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCSuW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 14:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2C137
        for <linux-arch@vger.kernel.org>; Mon,  3 Jul 2023 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688410175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGW3b/q8l7CXKgcfZ4b/QVlRua/Of3iP83P5k+7J+8o=;
        b=C6nCzYInPFBOYXnOdqzU3f42Gi2Uhg/Eie03rJa9spHZH1qjEzOxSmnL9E/9vfsOkdGkKp
        BiEIFEnjR6dqdwo+SWou8aEvUfH+HcVymb6ulUPxxPC6HglrlyRiN4JApJr0mljEMbAMmM
        ITPiPwN69pW6i+SwWbcFheKttLYqUMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-P1gDR9jLN9GbuzEdR1I4Vw-1; Mon, 03 Jul 2023 14:49:30 -0400
X-MC-Unique: P1gDR9jLN9GbuzEdR1I4Vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB61F185A791;
        Mon,  3 Jul 2023 18:49:28 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AD7DC00049;
        Mon,  3 Jul 2023 18:49:19 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     szabolcs.nagy@arm.com
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
References: <ZJFukYxRbU1MZlQn@arm.com>
        <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
        <ZJLgp29mM3BLb3xa@arm.com>
        <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
        <ZJQR7slVHvjeCQG8@arm.com>
        <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
        <ZJR545en+dYx399c@arm.com>
        <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
        <ZJ2sTu9QRmiWNISy@arm.com>
        <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
        <ZKMRFNSYQBC6S+ga@arm.com>
Date:   Mon, 03 Jul 2023 20:49:17 +0200
In-Reply-To: <ZKMRFNSYQBC6S+ga@arm.com> (szabolcs's message of "Mon, 3 Jul
        2023 19:19:00 +0100")
Message-ID: <87r0pox236.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* szabolcs:

>> alt shadow stack cannot be transparent to existing software anyway, it
>
> maybe not in glibc, but a libc can internally use alt shadow stack
> in sigaltstack instead of exposing a separate sigaltshadowstack api.
> (this is what a strict posix conform implementation has to do to
> support shadow stacks), leaking shadow stacks is not a correctness
> issue unless it prevents the program working (the shadow stack for
> the main thread likely wastes more memory than all the alt stack
> leaks. if the leaks become dominant in a thread the sigaltstack
> libc api can just fail).

It should be possible in theory to carve out pages from sigaltstack and
push a shadow stack page and a guard page as part of the signal frame.
As far as I understand it, the signal frame layout is not ABI, so it's
possible to hide arbitrary stuff in it.  I'm just saying that it looks
possible, not that it's a good idea.

Perhaps that's not realistic with 64K pages, though.

Thanks,
Florian

