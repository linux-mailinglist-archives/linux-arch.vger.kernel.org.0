Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F086AC8A6
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCFQsI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 11:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCFQrq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 11:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1F4E5C5
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678121109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gChhWa5+pV9cvva7KKeCwxEw+kt5hxoG0ztKCrLbRE=;
        b=NPEIShZ3VGqpCc23xpluG//e1dlTgsX90QSKXYbTxI95JFPpkqTKHF0ZoxjXlogglZPsV1
        yubm8M+yvrsuls9T/NLE9Sc4PLZiZy4zHMgAh2wIv5U8c/hlb1C8SD0mDcy8pfwDrJ7yee
        kkIAT4OvcPFEQIePGm9ZciKPOuc5ae8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-xAeRr96XNX6SiROa8aY1Yg-1; Mon, 06 Mar 2023 11:31:52 -0500
X-MC-Unique: xAeRr96XNX6SiROa8aY1Yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 583BE3850545;
        Mon,  6 Mar 2023 16:31:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62FB140C10FA;
        Mon,  6 Mar 2023 16:31:42 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     szabolcs.nagy@arm.com
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
        <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
        <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
        <ZADQISkczejfgdoS@arm.com>
        <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
        <ZAYS6CHuZ0MiFvmE@arm.com>
Date:   Mon, 06 Mar 2023 17:31:40 +0100
In-Reply-To: <ZAYS6CHuZ0MiFvmE@arm.com> (szabolcs's message of "Mon, 6 Mar
        2023 16:20:56 +0000")
Message-ID: <87wn3tsuxf.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* szabolcs:

> syscall overhead in case of frequent stack trace collection can be
> avoided by caching (in tls) when ssp falls within the thread shadow
> stack bounds. otherwise caching does not work as the shadow stack may
> be reused (alt shadow stack or ucontext case).

Do we need to perform the system call at each page boundary only?  That
should reduce overhead to the degree that it should not matter.

> unfortunately i don't know if syscall overhead is actually a problem
> (probably not) or if backtrace across signal handlers need to work
> with alt shadow stack (i guess it should work for crash reporting).

Ideally, we would implement the backtrace function (in glibc) as just a
shadow stack copy.  But this needs to follow the chain of alternate
stacks, and it may also need some form of markup for signal handler
frames (which need program counter adjustment to reflect that a
*non-signal* frame is conceptually nested within the previous
instruction, and not the function the return address points to).  But I
think we can add support for this incrementally.

I assume there is no desire at all on the kernel side that sigaltstack
transparently allocates the shadow stack?  Because there is no
deallocation function today for sigaltstack?

Thanks,
Florian

