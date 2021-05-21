Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7738CDA6
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhEUSmM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhEUSmL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2021 14:42:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE1C061574;
        Fri, 21 May 2021 11:40:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea400fbcd5718c7a034c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a400:fbcd:5718:c7a0:34c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFE9D1EC06F6;
        Fri, 21 May 2021 20:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621622445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xkROTNt6AI31m2jdBOyiECteV9VsPpyw0WnUQpk+Wzc=;
        b=VaADoicO3S+yFEcIUtcM3sOjNaJE0WZ+C0kd7zHM3NhGF6PJSn5GjYz2Si/yXNYyn+xuPE
        Yjpcj0qOk95X1N65SeP8DvLIA2jvzUiMMIOlr4cobPuJN3EvD0c0YoQVE4zqjWaqGVRoXK
        yz9AePJ4Z/wC7pgXgLxPK4UBY8FQDeE=
Date:   Fri, 21 May 2021 20:40:39 +0200
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
Message-ID: <YKf+pyW+WXtnPFfp@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com>
 <YKIfIEyW+sR+bDCk@zn.tnic>
 <c9121ca1-83cb-1c37-1a8e-edaafaa6fda2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9121ca1-83cb-1c37-1a8e-edaafaa6fda2@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 09:17:24AM -0700, Yu, Yu-cheng wrote:
> If !IS_ALIGNED(ssp, 4), then certainly !IS_ALIGNED(ssp, 8).

... but the reverse is true: when it is aligned by 8, it is already
aligned by 4. Whoops, that's tricky. Pls put a comment over it so that
we don't forget.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
