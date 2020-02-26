Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED3170919
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgBZT5O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 14:57:14 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:54622 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgBZT5N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 14:57:13 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C1A811C036E; Wed, 26 Feb 2020 20:57:10 +0100 (CET)
Date:   Wed, 26 Feb 2020 20:57:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Message-ID: <20200226195710.6sma4whvs3o76oux@ucw.cz>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <597fb45a-cb94-e8e7-8e80-45a26766d32a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597fb45a-cb94-e8e7-8e80-45a26766d32a@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > Introduce Kconfig option: X86_INTEL_SHADOW_STACK_USER.
> > 
> > Shadow Stack (SHSTK) provides protection against function return address
> > corruption.  It is active when the kernel has this feature enabled, and
> > both the processor and the application support it.  When this feature is
> > enabled, legacy non-SHSTK applications continue to work, but without SHSTK
> > protection.
> > 
> > The user-mode SHSTK protection is only implemented for the 64-bit kernel.
> > IA32 applications are supported under the compatibility mode.
> 
> I think what you're trying to say here is that the hardware supports
> shadow stacks with 32-bit kernels.  However, this series does not
> include that support and we have no plans to add it.
> 
> Right?
> 
> I'll let others weigh in, but I rather dislike the use of acronyms here.
>  I'd much rather see the english "shadow stack" everywhere than SHSTK.

For the record, I like "shadow stack" better, too.
