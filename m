Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9E2545CA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgH0NTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 09:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727846AbgH0NTT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 09:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598534337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BnfuzY1Orxo7bXipPlzF8Clju2SuIQM+XAiS/9TLc4c=;
        b=g1oDaqm5ff5UCWQMR7FlGcBbUN1fRr2PwQRNyiK+LfC/QzCCYNHGAi7XxRZriEB+cM8v8m
        QwyaIe2nmSuFe4SnZesp8iO6gvrLzlsSf7v9bkgvbrHFsEtSCyuvjC7p7i+1VRybpaNOGB
        7JhG7PGLWSds/05cZXmuVAgE8lzuY6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-G8iNeAfnO7-2I6RDlA4A7Q-1; Thu, 27 Aug 2020 09:18:55 -0400
X-MC-Unique: G8iNeAfnO7-2I6RDlA4A7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25ED657050;
        Thu, 27 Aug 2020 13:18:52 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C26375D9E8;
        Thu, 27 Aug 2020 13:18:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for shadow stack
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
        <20200825002540.3351-26-yu-cheng.yu@intel.com>
        <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
        <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
        <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
        <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
        <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
        <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
        <20200826164604.GW6642@arm.com>
        <87ft892vvf.fsf@oldenburg2.str.redhat.com>
        <20200826170841.GX6642@arm.com>
Date:   Thu, 27 Aug 2020 15:18:39 +0200
In-Reply-To: <20200826170841.GX6642@arm.com> (Dave Martin's message of "Wed,
        26 Aug 2020 18:08:42 +0100")
Message-ID: <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Martin:

> You're right that this has implications: for i386, libc probably pulls
> more arguments off the stack than are really there in some situations.
> This isn't a new problem though.  There are already generic prctls with
> fewer than 4 args that are used on x86.

As originally posted, glibc prctl would have to know that it has to pull
an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
then the u64 argument is a problem for arch_prctl as well.

Thanks,
Florian

