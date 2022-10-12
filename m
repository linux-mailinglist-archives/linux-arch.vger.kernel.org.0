Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191A65FC523
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 14:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJLMTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLMTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 08:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B647BEAC0
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665577147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NV9CicB0DRH4ogY4pUsl7yjoSLbllPXxF4kP6gpANzQ=;
        b=ZkdFf4RSyplWIFAZsiTBd1eC38yxC4jqCcTmT2b2alQ3A3NN3PoyHHda7lfpms+UpCV42o
        YinuqKnTn2KnnTI3pA1PMZ8gm6RDgUXPy9ShiVq+ARkciW4TcK1ASiuVoCZHFaP726PPqc
        t1XN8hCIg5p+27MIUNYYcvPVvk6wOaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-Mfy2mdPFOvymBf8YsiyteA-1; Wed, 12 Oct 2022 08:19:04 -0400
X-MC-Unique: Mfy2mdPFOvymBf8YsiyteA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 526D8811E75;
        Wed, 12 Oct 2022 12:19:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D68C414A809;
        Wed, 12 Oct 2022 12:18:54 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
        <20220929222936.14584-24-rick.p.edgecombe@intel.com>
        <87v8os0wx5.fsf@oldenburg.str.redhat.com>
        <8599719452d9615235f7fdd274a9b6ea04ab1f7c.camel@intel.com>
Date:   Wed, 12 Oct 2022 14:18:52 +0200
In-Reply-To: <8599719452d9615235f7fdd274a9b6ea04ab1f7c.camel@intel.com> (Rick
        P. Edgecombe's message of "Mon, 10 Oct 2022 16:28:57 +0000")
Message-ID: <87zge1z13n.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick P. Edgecombe:

> On Mon, 2022-10-10 at 12:56 +0200, Florian Weimer wrote:
>> > +     /* Only support enabling/disabling one feature at a time. */
>> > +     if (hweight_long(features) > 1)
>> > +             return -EINVAL;
>> 
>> This means we'll soon need three extra system calls for x86-64
>> process
>> start: SHSTK, IBT, and switching off vsyscall emulation.  (The latter
>> does not need any special CPU support.)
>> 
>> Maybe we can do something else instead to make the strace output a
>> little bit cleaner?
>
> In previous versions it supported enabling multiple features in a
> single syscall. Thomas Gleixner pointed out that (this was on the LAM
> patchset that shared the interface at the time) it makes the behavior
> of what to do when one feature fails to enable complicated:
>
> https://lore.kernel.org/lkml/87zgjjqico.ffs@tglx/

Can we return the bits for the features that were actually enabled?
Those three don't have cross-dependencies in the sense that you would
only use X & Y together, but not X or Y alone.

Thanks,
Florian

