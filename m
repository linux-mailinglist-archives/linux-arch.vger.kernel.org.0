Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8236EF1F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbhD2Rum (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhD2Rul (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 13:50:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAEEC06138B;
        Thu, 29 Apr 2021 10:49:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a4f007f02d405bcb749ad.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4f00:7f02:d405:bcb7:49ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 944CF1EC047F;
        Thu, 29 Apr 2021 19:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619718592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nqBClF7AH8n5dyvE3ZI5y/m01GvXUhCLBNoFKZDQARk=;
        b=IIJWw7wniB9ciZLWpUxNQ3Whs/jCo7pAKplYwyesU44NleMyX8DQkgKbiRu/Uf+ZO759K5
        UyufCRNfP1HfuwLGYlUNvxoRnrpyjAo+Y+vR3xULUMgEWcM8vsMN2jdlw3olY68A4QRYUE
        b2OnOsfxQL59yYyvI2rxM+Un7j32iQQ=
Date:   Thu, 29 Apr 2021 19:49:50 +0200
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
Subject: Re: [PATCH v26 00/30] Control-flow Enforcement: Shadow Stack
Message-ID: <YIrxvk4iM+7DaLhl@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <YIrpT1UxXqFtzySx@zn.tnic>
 <aa1ac406-84c8-b0f0-b70b-7224df4c8c77@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa1ac406-84c8-b0f0-b70b-7224df4c8c77@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 29, 2021 at 10:32:04AM -0700, Yu, Yu-cheng wrote:
> I did send out some selftest patches (link is in the cover letter). However,
> those need to be updated to the Linux standard, and I would like to do it
> separately.

Ok, and they look exactly like what I had in mind.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
