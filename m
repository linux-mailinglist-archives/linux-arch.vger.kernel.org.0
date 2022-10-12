Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA25FC549
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJLM3c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJLM3b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 08:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC8C513A
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665577769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yatbm6s+sCCHHYxeiS9jcRF6BVrcOy6ikVoqgXdujac=;
        b=RCHw6zae2PnvHI+q9N86tNOJUaMmNtJrvoOY9xzBmT/VJe0gFY0elourDp49VNS7qk6Ull
        kYMzouFsIMOuXzJ3H3XVPYiZaYvQVRfhlkvmC+wHCQLKZ7q3jpFy+lD4nA5pYxD5aDW7sc
        0TmPAaUvtYmzwQLEZ5PYjGCRK4kqlIg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-foHGkTWmNQyaIYxC2fG-KA-1; Wed, 12 Oct 2022 08:29:25 -0400
X-MC-Unique: foHGkTWmNQyaIYxC2fG-KA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8B101C08968;
        Wed, 12 Oct 2022 12:29:23 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5F974EA47;
        Wed, 12 Oct 2022 12:29:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
        <20220929222936.14584-2-rick.p.edgecombe@intel.com>
        <87ilkr27nv.fsf@oldenburg.str.redhat.com>
        <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
Date:   Wed, 12 Oct 2022 14:29:13 +0200
In-Reply-To: <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com> (Rick
        P. Edgecombe's message of "Mon, 10 Oct 2022 16:44:33 +0000")
Message-ID: <87v8opz0me.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick P. Edgecombe:

>> I think the goal is to support the new kernel interface for actually
>> switching on SHSTK in glibc 2.37.  But at that point, hopefully all
>> those existing binaries can start enjoying the STSTK benefits.
>
> Can you share more about this plan? HJ was previously planning to wait
> until the kernel support was upstream before making any more glibc
> changes. Hopefully this will be in time for that, but I'd really rather
> not repeat what happened last time where we had to design the kernel
> interface around not breaking old glibc's with mismatched CET
> enablement.

You're still doing that (keeping that gap in this constant), and this
appreciated and very much necessary.

> What did you think of the proposal to disable existing binaries and
> start from scratch? Elaborated in the coverletter in the section
> "Compatibility of Existing Binaries/Enabling Interface".

The ABI was finalized around four years ago, and we have shipped several
Fedora and Red Hat Enterprise Linux versions with it.  Other
distributions did as well.  It's a bit late to make changes now, and
certainly not for such trivialities.  In the case of the IBT ABI, it may
be tempting to start over in a less trivial way, to radically reduce the
amount of ENDBR instructions.  But that doesn't concern SHSTK, and
there's no actual implementation anyway.

But as H.J. implied, you would have to do rather nasty things in the
kernel to prevent us from achieving ABI compatibility in userspace, like
parsing property notes on the main executable and disabling the new
arch_prctl calls if you see something there that you don't like. 8-)
Of course no one is going to implement that.

(We are fine with swapping out glibc and its dynamic loader to enable
CET with the appropriate kernel mechanism, but we wouldn't want to
change the way all other binaries are marked up.)

Thanks,
Florian

