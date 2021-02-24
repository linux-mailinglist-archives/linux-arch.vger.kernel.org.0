Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0E3244BC
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhBXTms (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 14:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhBXTmr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 14:42:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083DC061574;
        Wed, 24 Feb 2021 11:42:07 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d180087c1c74682a645c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:87c1:c746:82a6:45c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F109E1EC0328;
        Wed, 24 Feb 2021 20:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614195726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9ezgUQlQbbX7408pbcJrxnn71TdUJUjIpNkknyJCDRw=;
        b=VnSrIXBlqTORmrkgznFXrhpvc+CB1vlkNwYoJMdpewn99QaGbXEvOBOK/lD/XS+//KalF3
        c5zTEwyImAn3425u7nHBNlLBjwHhiHsMhAQYE1oG76/9ve5NBLA6qumhCn4GNT7MOfmydT
        zHNMzYp6o5Qbh5hqT78fY22+8M/YJ5g=
Date:   Wed, 24 Feb 2021 20:42:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
Message-ID: <20210224194204.GI20344@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-7-yu-cheng.yu@intel.com>
 <20210224161343.GE20344@zn.tnic>
 <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
 <20210224165332.GF20344@zn.tnic>
 <db493c76-2a67-5f53-29a0-8333facac0f5@intel.com>
 <20210224192044.GH20344@zn.tnic>
 <CALCETrXKteS9K=OOgsCvBU4in_3zcYccqF9hh2=OdCJPknvB8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXKteS9K=OOgsCvBU4in_3zcYccqF9hh2=OdCJPknvB8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 11:30:34AM -0800, Andy Lutomirski wrote:
> On Wed, Feb 24, 2021 at 11:20 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Feb 24, 2021 at 09:56:13AM -0800, Yu, Yu-cheng wrote:
> > > No.  Maybe I am doing too much.  The GP fault sets si_addr to zero, for
> > > example.  So maybe do the same here?
> >
> > No, you're looking at this from the wrong angle. This is going to be
> > user-visible and the moment it gets upstream, it is cast in stone.
> >
> > So the whole use case of what luserspace needs to do or is going to do
> > or wants to do on a SEGV_CPERR, needs to be described, agreed upon by
> > people etc before it goes out. And thus clarified whether the address
> > gets copied out or not.
> 
> I vote 0.  The address is in ucontext->gregs[REG_RIP] [0] regardless.
> Why do we need to stick a copy somewhere else?
> 
> [0] or however it's spelled.  i can never remember.

Fine with me. Let's have this documented in the manpage and then we can
move forward with this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
