Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7534125151A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgHYJPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 05:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729021AbgHYJPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 05:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598346900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92i+0YUtQgEC4ia+7x4FHZS4hUNlAuigR1V4PDLFWpU=;
        b=dXID83x2aRkxAWfQMPZWk/vI0Qh6hxbzpf47lTeb+tvwUuSj24TdgkBRIgaD3YGlKDHCvj
        SX0gBQ3rs/KB+oGq+tV6STleCJU2EMW74zeeqTsUIgHcgFv0Gbs6KFrUuNrUir9FoGGTcZ
        CrwCG66NpsxslHzCJrVNy5/sTPOAUQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-qjGmojjQPt2LSoxrEMPg0A-1; Tue, 25 Aug 2020 05:14:56 -0400
X-MC-Unique: qjGmojjQPt2LSoxrEMPg0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7438100746B;
        Tue, 25 Aug 2020 09:14:52 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5353C808AB;
        Tue, 25 Aug 2020 09:14:39 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v11 9/9] x86: Disallow vsyscall emulation when CET is enabled
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
        <20200825002645.3658-10-yu-cheng.yu@intel.com>
        <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
Date:   Tue, 25 Aug 2020 11:14:37 +0200
In-Reply-To: <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
        (Andy Lutomirski's message of "Mon, 24 Aug 2020 17:32:35 -0700")
Message-ID: <87pn7f9jeq.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> On Mon, Aug 24, 2020 at 5:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>
>> Emulation of the legacy vsyscall page is required by some programs built
>> before 2013.  Newer programs after 2013 don't use it.  Disallow vsyscall
>> emulation when Control-flow Enforcement (CET) is enabled to enhance
>> security.
>
> NAK.
>
> By all means disable execute emulation if CET-IBT is enabled at the
> time emulation is attempted, and maybe even disable the vsyscall page
> entirely if you can magically tell that CET-IBT will be enabled when a
> process starts, but you don't get to just disable it outright on a
> CET-enabled kernel.

Yeah, we definitely would have to revert/avoid this downstream.  People
definitely want to run glibc-2.12-era workloads on current kernels.
Thanks for catching it.

Florian

