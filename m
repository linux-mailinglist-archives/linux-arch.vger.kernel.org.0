Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE94A4EB9
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 19:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357324AbiAaSp2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 13:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355479AbiAaSp1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Jan 2022 13:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643654726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vtLdnydhSAxPSqAH4Eff+DcCHxcUpx4pphU3ycHuRAA=;
        b=F8RHP4PDheT8vRCH7jAa9+p7kRmYpHs+8gYXnCfcbOznv89LMGpFm8CPdEKs5FtDBMPxzF
        p+ungUpoSZcVzy4JytulTDg5lk+IgctmUDHY/Ig5+AwYYVQdil/6CXiCGxVb1IQqCtaZzD
        xGeoKwAYNlExlVK5zfFNgVyEw8BicNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-gIdbnm9XMoie-uVd8V9g0g-1; Mon, 31 Jan 2022 13:45:25 -0500
X-MC-Unique: gIdbnm9XMoie-uVd8V9g0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 011FF1923B8D;
        Mon, 31 Jan 2022 18:45:21 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42C7B7D526;
        Mon, 31 Jan 2022 18:45:12 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        Kostya Serebryany <kcc@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 34/35] x86/cet/shstk: Support wrss for userspace
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
        <20220130211838.8382-35-rick.p.edgecombe@intel.com>
        <87wnig8hj6.fsf@oldenburg.str.redhat.com>
        <CAMe9rOrVvjL1F3UgOWL-gAGRyyiG6r20TWUusEUFhZMEEAjH7w@mail.gmail.com>
Date:   Mon, 31 Jan 2022 19:45:10 +0100
In-Reply-To: <CAMe9rOrVvjL1F3UgOWL-gAGRyyiG6r20TWUusEUFhZMEEAjH7w@mail.gmail.com>
        (H. J. Lu's message of "Mon, 31 Jan 2022 10:26:49 -0800")
Message-ID: <87a6fb7nih.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* H. J. Lu:

> On Sun, Jan 30, 2022 at 11:57 PM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Rick Edgecombe:
>>
>> > For the current shadow stack implementation, shadow stacks contents cannot
>> > be arbitrarily provisioned with data. This property helps apps protect
>> > themselves better, but also restricts any potential apps that may want to
>> > do exotic things at the expense of a little security.
>> >
>> > The x86 shadow stack feature introduces a new instruction, wrss, which
>> > can be enabled to write directly to shadow stack permissioned memory from
>> > userspace. Allow it to get enabled via the prctl interface.
>>
>> Why can't this be turned on unconditionally?
>
> WRSS can be a security risk since it defeats the whole purpose of
> Shadow Stack.  If an application needs to write to shadow stack,
> it can make a syscall to enable it.  After the CET patches are checked
> in Linux kernel, I will make a proposal to allow applications or shared
> libraries to opt-in WRSS through a linker option, a compiler option or
> a function attribute.

Ahh, that makes sense.  I assumed that without WRSS, the default was to
allow plain writes. 8-)

Thanks,
Florian

