Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BEB3E7DCB
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhHJQuv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJQuu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Aug 2021 12:50:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE94C0613C1;
        Tue, 10 Aug 2021 09:50:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD16D1EC01DF;
        Tue, 10 Aug 2021 18:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628614221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dJ3McOp6GAWMX9lMvbCNin2G349VMHYC/ZPMdsNmIDQ=;
        b=THHqHQdG5NOH8KE4zUN+hcNyc5eR3ZuFzp719QN2wydoaiNqnG8umE976PGxExzUhR4Xbc
        UnFkaKVlGrHG0odgq4JOy6nA2RSqrk6Jj67JB93xbQf1dqL9mfQDq+YG94nqS1ODNHhZg5
        5DFJRS451oOD5VfRfqSwv6YKn/2Gdrg=
Date:   Tue, 10 Aug 2021 18:51:06 +0200
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v28 04/32] x86/cpufeatures: Introduce CPU setup and
 option parsing for CET
Message-ID: <YRKueiV82YmvT8a3@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-5-yu-cheng.yu@intel.com>
 <YRFSg45dDMfeiGbt@zn.tnic>
 <c7867ec7-f03e-8928-3cce-88eaafd1efa1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7867ec7-f03e-8928-3cce-88eaafd1efa1@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 10, 2021 at 08:39:00AM -0700, Yu, Yu-cheng wrote:
> We have X86_FEATURE_IBT dependent on X86_FEATURE_SHSTK (patch #3).

Ah, do_clear_cpu_cap() will handle the deps, missed that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
