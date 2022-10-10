Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58D5F9EC2
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 14:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJJMfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJJMfG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 08:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA215A1F
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2022 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665405301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QA6f2HlVW1NJBZ3C2GoKq9SiJ7l5EStNIWPvZ+GnIV8=;
        b=PIon4rHaOshMl+hWKo7mYNaSr8EU69hlP9f/kNJmuh+cjSt0BhvvACNiOHZ5sNcBnankDS
        +gVaPBywPVGfmJ1dSlweFsow7cyydKR0NuRMMs5qi9AX7iUsNRQgyZfr2YqxEVPCjohUG3
        5odEjiZ2FKW7txD01+Tv6M1gx8059oY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-wRjZH-_IOo-OjcM7dr5rog-1; Mon, 10 Oct 2022 08:33:41 -0400
X-MC-Unique: wRjZH-_IOo-OjcM7dr5rog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1E57185A792;
        Mon, 10 Oct 2022 12:33:39 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B496C2C8D6;
        Mon, 10 Oct 2022 12:33:32 +0000 (UTC)
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
Date:   Mon, 10 Oct 2022 14:33:30 +0200
In-Reply-To: <37ef8d93-8bd2-ae5e-4508-9be090231d06@citrix.com> (Andrew
        Cooper's message of "Wed, 5 Oct 2022 02:30:56 +0000")
Message-ID: <87bkqj26zp.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andrew Cooper:

> You don't actually need a hole to create a guard.=C2=A0 Any mapping of ty=
pe
> !=3D shstk will do.
>
> If you've got a load of threads, you can tightly pack stack / shstk /
> stack / shstk with no holes, and they each act as each other guard pages.

Can userspace read the shadow stack directly?  Writing is obviously
blocked, but reading?

GCC's stack-clash probing uses OR instructions, so it would be fine with
a readable mapping.  POSIX does not appear to require PROT_NONE mappings
for the stack guard region, either.  However, the
pthread_attr_setguardsize manual page pretty clearly says that it's got
to be unreadable and unwriteable.  Hence my question.

Thanks,
Florian

