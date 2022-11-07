Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE061FAAF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiKGQ5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 11:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKGQ5H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 11:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24511F2E4
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667840167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T50w0nkUuy7T2kUqSnZIRriHtEbo2iSXTPmDVdxQoV8=;
        b=BBBappHDpXzSDzbpyr58g/lpQFryWFSqGr7/HYROgluYZHTjHWzduuT79L6NoKwrsKGFF4
        7ojOlp92BmN/YN8fdgYlDfKiLBL2P0IbnawP/s9WXKpkOwiYAvHB2fcNp6gBwLFsqPHHDH
        MeSmX7upUrW5NVIXajAHHiD57rhjDT4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-vUiqRtnoNq-2EW1fMouqkA-1; Mon, 07 Nov 2022 11:56:02 -0500
X-MC-Unique: vUiqRtnoNq-2EW1fMouqkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61A36101E14D;
        Mon,  7 Nov 2022 16:56:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A58641121314;
        Mon,  7 Nov 2022 16:55:55 +0000 (UTC)
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
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
        <20221104223604.29615-38-rick.p.edgecombe@intel.com>
        <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
        <87iljs4ecp.fsf@oldenburg.str.redhat.com>
        <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
Date:   Mon, 07 Nov 2022 17:55:54 +0100
In-Reply-To: <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com> (Rick
        P. Edgecombe's message of "Mon, 7 Nov 2022 16:49:58 +0000")
Message-ID: <87h6zaiu05.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

> On Sun, 2022-11-06 at 10:33 +0100, Florian Weimer wrote:
>> * H. J. Lu:
>>=20
>> > This change doesn't make a binary CET compatible.  It just requires
>> > that the toolchain must be updated and all binaries have to be
>> > recompiled with the new toolchain to enable CET.  It doesn't solve
>> > any
>> > issue which can't be solved by not updating glibc.
>>=20
>> Right, and it doesn't even address the library case (the kernel would
>> have to hook into mmap for that).  The kernel shouldn't do this.
>
> Shadow stack shouldn't enable as a result of loading a library, if
> that's what you mean.

It's the opposite=E2=80=94loading incompatible libraries needs to disable s=
hadow
stack (or ideally, not enable it in the first place).  Technically, I
think most incompatible code resides in libraries, so this kernel change
achieves nothing besides punishing early implementations of the
published-as-finalized x86-64 ABI.

Thanks,
Florian

