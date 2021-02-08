Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A3313F91
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 20:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhBHTvR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 14:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbhBHTtj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2021 14:49:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A338C06178B;
        Mon,  8 Feb 2021 11:48:59 -0800 (PST)
Received: from zn.tnic (p200300ec2f073f00132389f64ded89c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:1323:89f6:4ded:89c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82CA81EC0516;
        Mon,  8 Feb 2021 20:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612813737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MLLsJOPUX5aC5wPkAZgeTUlSqwoaRJCYi5u/Gu9Lyu4=;
        b=j20s4Z1nZxUMIW4Emy6zOTMhJS+Xcv5dR20kO53dQqDMjCNNDTkNdDLIKPjBdy0I7OAcvH
        qCppIT7lV0+u4OOJveK2lU/0X+HWSI+7IcRzU0HqTj7rUbn6tT9F57SbEPLGVY1cnpwBgQ
        aZzuKYY7ZAMsOTAcYe/u7IMVKwUM220=
Date:   Mon, 8 Feb 2021 20:48:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
Message-ID: <20210208194854.GI18227@zn.tnic>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <20210205135927.GH17488@zn.tnic>
 <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
 <20210208182009.GE18227@zn.tnic>
 <690bc3b9-2890-e68d-5e4b-cda5c21b496b@intel.com>
 <20210208185341.GF18227@zn.tnic>
 <0e0c9e9d-aee1-ad1e-6c63-21b58a52163f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e0c9e9d-aee1-ad1e-6c63-21b58a52163f@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 08, 2021 at 11:23:18AM -0800, Yu, Yu-cheng wrote:
> exc_general_protection() and do_trap() both call show_signal(), which
> then calls printk_ratelimit().

You could've done some git archeology and could've found

  abd4f7505baf ("x86: i386-show-unhandled-signals-v3")

which explains why that ratelimiting is needed.

> For example, if a shell script, in a loop re-starts an app when it
> exits, and the app is causing control-protection fault. The log
> messages should be rate limited.

I think you should be able to get where I'm going with this, by now:
please put a comment over the ratelimiting to explain why it is there,
just like the above commit explains.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
