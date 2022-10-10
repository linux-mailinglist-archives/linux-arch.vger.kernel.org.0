Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC25F9F8A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJJNkh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJJNkg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 09:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C253019
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2022 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665409234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRewDE0rZn6hJgooSIadeEW16yLPv94UEqowboDO7Tg=;
        b=OYlPsTshuSM346bpU1F70uOCDx8qrTrkPn96epyVt85lfHRiYAOxXnBe2KrIMWZPrJJ0A1
        Sl4MLEXeJ7aLKbm7hDDL+nk7jIzzoMdq9ryG6cZ+Vknul5BVKa8u6N5QRq5q2C/drfmVzT
        K//UT8uDK6pRm9kvZGwl2YxoSC0MC+s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-1jG5H1LFPHOCdfbzFg3Vtg-1; Mon, 10 Oct 2022 09:40:29 -0400
X-MC-Unique: 1jG5H1LFPHOCdfbzFg3Vtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A3E01C05157;
        Mon, 10 Oct 2022 13:40:27 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2C5EC210E;
        Mon, 10 Oct 2022 13:40:19 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
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
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 18/39] mm: Add guard pages around a shadow stack.
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
        <20220929222936.14584-19-rick.p.edgecombe@intel.com>
        <202210031127.C6CF796@keescook>
        <37ef8d93-8bd2-ae5e-4508-9be090231d06@citrix.com>
        <87bkqj26zp.fsf@oldenburg.str.redhat.com>
        <6e75eb27-c16b-ccfe-08b9-856edeff51eb@citrix.com>
Date:   Mon, 10 Oct 2022 15:40:18 +0200
In-Reply-To: <6e75eb27-c16b-ccfe-08b9-856edeff51eb@citrix.com> (Andrew
        Cooper's message of "Mon, 10 Oct 2022 13:32:51 +0000")
Message-ID: <87tu4bztj1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andrew Cooper:

> On 10/10/2022 13:33, Florian Weimer wrote:
>> * Andrew Cooper:
>>
>>> You don't actually need a hole to create a guard.=C2=A0 Any mapping of =
type
>>> !=3D shstk will do.
>>>
>>> If you've got a load of threads, you can tightly pack stack / shstk /
>>> stack / shstk with no holes, and they each act as each other guard page=
s.
>> Can userspace read the shadow stack directly?  Writing is obviously
>> blocked, but reading?
>
> Yes - regular reads are permitted to shstk memory.
>
> It's actually a great way to get backtraces with no extra metadata
> needed.

Indeed, I hope shadow stacks can be used to put the discussion around
frame pointers to a rest, at least when it comes to profiling. 8-)

>> POSIX does not appear to require PROT_NONE mappings
>> for the stack guard region, either.  However, the
>> pthread_attr_setguardsize manual page pretty clearly says that it's got
>> to be unreadable and unwriteable.  Hence my question.
>
> Hmm.=C2=A0 If that's what the manuals say, then fine.
>
> But honestly, you don't get very far at all without faulting on a
> read-only stack.

I guess we can update the manual page proactively.  It does look like a
tempting optimization.

Thanks,
Florian

