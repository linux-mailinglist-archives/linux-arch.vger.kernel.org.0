Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69373F85E8
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhHZKzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 06:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbhHZKzk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2021 06:55:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09596C061757;
        Thu, 26 Aug 2021 03:54:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131000e9f5f92baa539bd3.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1000:e9f5:f92b:aa53:9bd3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A18D11EC059D;
        Thu, 26 Aug 2021 12:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629975285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UY5DNLToKd5xwJOlrBkq9pntqa2rgUSXGZ4c4wOSBHI=;
        b=Nf6+7JQ+1UHWWaFyXqaDwBB03jewogdeyeAnWVLy8YGitsUxVccnjivC4TlNhygdvTSHrs
        /ivOk3s/Hnt7PeDAA5CSCp8DuxFyTUDPIAXSRKps4R/Lqhpk81GgPESNTSekB/h56US72K
        jUj3f7muxiQsexLYbyK5/hAAY0kxI0c=
Date:   Thu, 26 Aug 2021 12:55:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v29 15/32] x86/mm: Shadow Stack page fault error checking
Message-ID: <YSdzGwzSKB5GHbDL@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-16-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820181201.31490-16-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 20, 2021 at 11:11:44AM -0700, Yu-cheng Yu wrote:

> Subject: Re: [PATCH v29 15/32] x86/mm: Shadow Stack page fault error checking

					 Check Shadow Stack page fault errors

Needs a verb in the name.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
