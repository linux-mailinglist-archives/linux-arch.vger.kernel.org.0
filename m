Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05053255476
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgH1GYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 02:24:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725849AbgH1GYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 02:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598595857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZgOlmN9m49e++aSj4JPimMgy9NjdrTL35m0T++hZyQ=;
        b=aM1pukEv+frLqm1sbyFKzeg1EoWbysRX8S/zmBAWwJk66sGw/kBgFd5oc8lKQWCMNBgYfC
        lKRRMdrLR+/e2IH33VRqKiJk/mQP9SwcBVq/HSYyKzifAg71m3WSY60+71wR5EXmdHRnwU
        ncWWn1k5/RxU4+sgqXd6DzOL5ayINro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-M3H7_1grNueY-FhKFkSSmQ-1; Fri, 28 Aug 2020 02:24:12 -0400
X-MC-Unique: M3H7_1grNueY-FhKFkSSmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 501DC1DDFF;
        Fri, 28 Aug 2020 06:24:08 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A6655D9F1;
        Fri, 28 Aug 2020 06:23:55 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for shadow stack
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
        <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net>
        <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
        <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
        <CAMe9rOrt5hz6qsNAxPgdKCOhRcKKESv-D3rxdSfraeJ-LFHM4w@mail.gmail.com>
Date:   Fri, 28 Aug 2020 08:23:54 +0200
In-Reply-To: <CAMe9rOrt5hz6qsNAxPgdKCOhRcKKESv-D3rxdSfraeJ-LFHM4w@mail.gmail.com>
        (H. J. Lu's message of "Thu, 27 Aug 2020 18:44:27 -0700")
Message-ID: <87v9h3thj9.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* H. J. Lu:

> Can you think of ANY issues of passing more arguments to arch_prctl?

On x32, the glibc arch_prctl system call wrapper only passes two
arguments to the kernel, and applications have no way of detecting that.
musl only passes two arguments on all architectures.  It happens to work
anyway with default compiler flags, but that's an accident.

Thanks,
Florian

