Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7F5FC98C
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJLQyX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJLQyV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 12:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E8FBCCA
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665593658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qoy7AAHiT4kxg+sBg7GCQnX3x7hXvCR1aAfKGHjNP8Q=;
        b=bcn5xBSzGYdTzTHpyevLSvZEcWi/LfLtzKmduJ3hyf4GrPl4u/4RBUdRC7Sv5uVzL1X0Es
        R1GCtKao1Jk4fwNUzyRItD9338WdtlKbnCeR3/a2qbTvtZtZmJYEWEE0VsEGT26QzAn8cx
        lVyP9/9BxBbQg129OQUYRGEfv33tlzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-YWRLYSt9O42ciCepQ4HeNw-1; Wed, 12 Oct 2022 12:54:17 -0400
X-MC-Unique: YWRLYSt9O42ciCepQ4HeNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A49E185A792;
        Wed, 12 Oct 2022 16:54:15 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BB8640FF71C;
        Wed, 12 Oct 2022 16:54:07 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        <87v8opz0me.fsf@oldenburg.str.redhat.com>
        <e3c3d68d-ce99-a70a-1026-0ba99520ae57@intel.com>
Date:   Wed, 12 Oct 2022 18:54:06 +0200
In-Reply-To: <e3c3d68d-ce99-a70a-1026-0ba99520ae57@intel.com> (Dave Hansen's
        message of "Wed, 12 Oct 2022 08:59:51 -0700")
Message-ID: <87y1tlx9sh.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Hansen:

> On 10/12/22 05:29, Florian Weimer wrote:
>>> What did you think of the proposal to disable existing binaries and
>>> start from scratch? Elaborated in the coverletter in the section
>>> "Compatibility of Existing Binaries/Enabling Interface".
>> The ABI was finalized around four years ago, and we have shipped several
>> Fedora and Red Hat Enterprise Linux versions with it.  Other
>> distributions did as well.  It's a bit late to make changes now, and
>> certainly not for such trivialities. 
>
> Just to be clear: You're saying that a user/kernel ABI was "finalized"
> by glibc shipping the user side of it, before there being an upstream
> kernel implementation?

Sorry for being unclear.  I was refering to the x86-64 ELF psABI
supplement for CET, not the kernel/userspace interface, which still does
not exist in its final form as of today, as far as I understand it.

Thanks,
Florian

