Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAC2CA7B2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 17:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbgLAQC6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388988AbgLAQC5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 11:02:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F526C0613D4;
        Tue,  1 Dec 2020 08:02:17 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e6a009ae7ed3e982f3c10.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:6a00:9ae7:ed3e:982f:3c10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD9341EC04B9;
        Tue,  1 Dec 2020 17:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606838535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SxSydwEX7m96SIq00HrPmCp+mPAnCkJ48WYzsRg9t2w=;
        b=iJYk51lYHndAR22VW5aqtG8DZmC26iF5UFfr3bh2BnR+sTzvvpV653bT3cxXBCWtbz76cL
        LO93i127VhTlLn0X1nhsOK0o/4EWL74UjiUQZEJ08Ep3dbwkmbm9z1bt+iMe8HwDdUrv3W
        e1BLblJOCST0k1xlGtguap+j53Mc8TY=
Date:   Tue, 1 Dec 2020 17:02:12 +0100
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
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack
Message-ID: <20201201160212.GF22927@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-6-yu-cheng.yu@intel.com>
 <20201127171012.GD13163@zn.tnic>
 <98e1b159-bf32-5c67-455b-f798023770ef@intel.com>
 <20201130181500.GH6019@zn.tnic>
 <1db3d369-734e-9925-fa14-e799a19ac30c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1db3d369-734e-9925-fa14-e799a19ac30c@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 30, 2020 at 02:48:09PM -0800, Yu, Yu-cheng wrote:
> Logically, enabling IBT without shadow stack does not make sense, but these
> features have different CPUIDs, and CONFIG_X86_SHADOW_STACK_USER and
> CONFIG_X86_BRANCH_TRACKING_USER can be selected separately.
> 
> Do we want to have only one selection for both features?  In other words, we
> turn on both or neither.

Question is, do they need to be handled separately at all?

If not and IOW, I like dhansen's X86_FEATURE_CET synthetic feature
suggestion.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
