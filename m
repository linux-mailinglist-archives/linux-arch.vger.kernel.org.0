Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C3620BE2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 10:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKHJPU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiKHJPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 04:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD702F646
        for <linux-arch@vger.kernel.org>; Tue,  8 Nov 2022 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667898868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KP+tiCnk9vCKqrx4wl6vmjk9CSIgAcrzK2YQ6PLAxpU=;
        b=ilaXudgg1dHX/dLJEUorxDWt+w1Vovosv0p5Y1Pvj2aMBYXERvzWKpeiUrXSki2IXA4uBK
        6YclGFKMekoBMQUd2TtwcROJRR2TuoED8UEANh+9+h3LRkn0MUNPem5cIsKvY6TSum2O1J
        EVoiUTdyOELSRHEiVI4tKXIQoB6MFXY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-Ut-AJcnsP0m_xLQD9tcXTQ-1; Tue, 08 Nov 2022 04:14:23 -0500
X-MC-Unique: Ut-AJcnsP0m_xLQD9tcXTQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C9E41C06EE9;
        Tue,  8 Nov 2022 09:14:22 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B29FC4B3FC6;
        Tue,  8 Nov 2022 09:14:14 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
        <20221104223604.29615-38-rick.p.edgecombe@intel.com>
        <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
        <87iljs4ecp.fsf@oldenburg.str.redhat.com>
        <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
        <87h6zaiu05.fsf@oldenburg.str.redhat.com>
        <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
        <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
        <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
Date:   Tue, 08 Nov 2022 10:14:12 +0100
In-Reply-To: <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com> (Rick
        P. Edgecombe's message of "Mon, 7 Nov 2022 21:10:52 +0000")
Message-ID: <87leolkduj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick P. Edgecombe:

> When we have everything in place, the problems would be much more
> obvious when distros started turning it on. But we can't turn it on as
> planned without breaking things for existing binaries. We can have both
> by:
> 1. Choosing a new bit, adding it to the tools, and never supporting the
> old bit in glibc.
> 2. Providing the option to have the kernel block the old bit, so
> upgraded users can decide what experience they would like. Then distros
> can find the problems and adjust their packages. I'm starting to think
> a default off sysctl toggle might be better than a Kconfig.
> 3. Any other ideas?

This problem is fairly common nowadays for new system calls.  Before
glibc can use them internally, we need to port userspace first,
otherwise key applications fail to work.  Yet we do not require ELF
markup to make the new system call available to glibc.

The situation here seems similar: before deploying a new glibc, we need
to upgrade parts of userspace.

Thanks,
Florian

