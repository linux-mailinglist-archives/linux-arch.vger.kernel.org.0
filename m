Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2F8CDA3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHNIH6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 04:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfHNIH6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Aug 2019 04:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53C9C31499;
        Wed, 14 Aug 2019 08:07:57 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F4B4413C;
        Wed, 14 Aug 2019 08:07:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 01/27] Documentation/x86: Add CET description
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
        <20190813205225.12032-2-yu-cheng.yu@intel.com>
Date:   Wed, 14 Aug 2019 10:07:45 +0200
In-Reply-To: <20190813205225.12032-2-yu-cheng.yu@intel.com> (Yu-cheng Yu's
        message of "Tue, 13 Aug 2019 13:51:59 -0700")
Message-ID: <87tvakgofi.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 14 Aug 2019 08:07:57 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yu-cheng Yu:

> +ENDBR
> +    The compiler inserts an ENDBR at all valid branch targets.  Any
> +    CALL/JMP to a target without an ENDBR triggers a control
> +    protection fault.

Is this really correct?  I think ENDBR is needed only for indirect
branch targets where the jump/call does not have a NOTRACK prefix.  In
general, for security hardening, it seems best to minimize the number of
ENDBR instructions, and use NOTRACK for indirect jumps which derive the
branch target address from information that cannot be modified.

Thanks,
Florian
