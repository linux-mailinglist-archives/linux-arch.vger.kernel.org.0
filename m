Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0400C2E731C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 19:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2S5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 13:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2S5Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Dec 2020 13:57:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59DC061574;
        Tue, 29 Dec 2020 10:56:35 -0800 (PST)
Received: from zn.tnic (p2e584e83.dip0.t-ipconnect.de [46.88.78.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06BA51EC03C1;
        Tue, 29 Dec 2020 19:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609268194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NIuMIzvx9hILmmvZVPannYZvDr2nT5zF97lPvHJTpIw=;
        b=i597F75BcsrtC4ICf6UxWa3qye27uhmFqbsnIDtiTZJQhvBsQ/AUY+OgrSXiK8PSjEcvEi
        hTo/4uzlaW6+GI1Aix+AzDHyobQxaZ5FLBoId5nSVpeH3L9fR9ZfZb5rgu6tzgpdu1Av/e
        ee0KSKWX2S5DqsVbNY2alGFqYqXgkWs=
Date:   Tue, 29 Dec 2020 19:54:22 +0100
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v16 02/26] x86/cet/shstk: Add Kconfig option for
 user-mode control-flow protection
Message-ID: <20201229185422.GC29947@zn.tnic>
References: <20201209222320.1724-1-yu-cheng.yu@intel.com>
 <20201209222320.1724-3-yu-cheng.yu@intel.com>
 <20201229123910.GB29947@zn.tnic>
 <c193c18e-6a3c-e079-67dc-bca35bceee71@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c193c18e-6a3c-e079-67dc-bca35bceee71@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 29, 2020 at 08:34:51AM -0800, Yu, Yu-cheng wrote:
> Thanks!  I will re-base to v5.11-rc1 and send out a new version.

You don't have to if it still applies and there are no changes pending.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
