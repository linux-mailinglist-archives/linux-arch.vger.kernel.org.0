Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48243BAE6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfFJRZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 13:25:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfFJRZR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 13:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31DE23EDBF;
        Mon, 10 Jun 2019 17:25:01 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-27.ams2.redhat.com [10.36.117.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AE095B681;
        Mon, 10 Jun 2019 17:24:45 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
        <20190606200646.3951-23-yu-cheng.yu@intel.com>
        <20190607180115.GJ28398@e103592.cambridge.arm.com>
        <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
Date:   Mon, 10 Jun 2019 19:24:43 +0200
In-Reply-To: <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
        (Yu-cheng Yu's message of "Mon, 10 Jun 2019 09:29:04 -0700")
Message-ID: <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 10 Jun 2019 17:25:17 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yu-cheng Yu:

> To me, looking at PT_GNU_PROPERTY and not trying to support anything is a
> logical choice.  And it breaks only a limited set of toolchains.
>
> I will simplify the parser and leave this patch as-is for anyone who wants to
> back-port.  Are there any objections or concerns?

Red Hat Enterprise Linux 8 does not use PT_GNU_PROPERTY and is probably
the largest collection of CET-enabled binaries that exists today.

My hope was that we would backport the upstream kernel patches for CET,
port the glibc dynamic loader to the new kernel interface, and be ready
to run with CET enabled in principle (except that porting userspace
libraries such as OpenSSL has not really started upstream, so many
processes where CET is particularly desirable will still run without
it).

I'm not sure if it is a good idea to port the legacy support if it's not
part of the mainline kernel because it comes awfully close to creating
our own private ABI.

Thanks,
Florian
