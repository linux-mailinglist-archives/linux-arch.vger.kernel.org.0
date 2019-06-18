Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FAE4A139
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRM5A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 08:57:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRM5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jun 2019 08:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PYbrunDp8avnP39gEYH1AHS83LwzriBAbK/nP8h6WlU=; b=NFww7+43UaA1stlBZehQjCp02
        Y7PtLUydx/okAC0L065bNSF4kxrjfybpYCytKhBCt/18SskmlAZk54VtmxcTdjaV6l1FMFthC5b0i
        g9LFyUYpap0oM0WUfvOC+uNl0RB8e9btq4wFuWLqtjMG8DydgEMXYlnpOjjh5PK3JwigOIcp8y1qA
        XFJOPsNh/gPO5nCfvM+zPvS4/0w5arjT21lzZ1nIwVKocPkNGOuTqKfPxDJTast1+Si3zME1zgiU5
        V4a5T1WO4eAk1zwJCyZ9GHLBiN9Dqu3GL3wCSnYDNDs1SQpeh8dJAPay0ARexe8rwh5RbgmCRJM2l
        qYBjy0PXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdDdr-0002GP-Ll; Tue, 18 Jun 2019 12:55:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15A3D209C8915; Tue, 18 Jun 2019 14:55:12 +0200 (CEST)
Date:   Tue, 18 Jun 2019 14:55:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
References: <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
 <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
 <20190611114109.GN28398@e103592.cambridge.arm.com>
 <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
 <20190612093238.GQ28398@e103592.cambridge.arm.com>
 <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1906171418220.1854@nanos.tec.linutronix.de>
 <20190618091248.GB2790@e103592.cambridge.arm.com>
 <20190618124122.GH3419@hirez.programming.kicks-ass.net>
 <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 18, 2019 at 02:47:00PM +0200, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > I'm not sure I read Thomas' comment like that. In my reading keeping the
> > PT_NOTE fallback is exactly one of those 'fly workarounds'. By not
> > supporting PT_NOTE only the 'fine' people already shit^Hpping this out
> > of tree are affected, and we don't have to care about them at all.
> 
> Just to be clear here: There was an ABI document that required PT_NOTE
> parsing.

URGH.

> The Linux kernel does *not* define the x86-64 ABI, it only
> implements it.  The authoritative source should be the ABI document.
>
> In this particularly case, so far anyone implementing this ABI extension
> tried to provide value by changing it, sometimes successfully.  Which
> makes me wonder why we even bother to mainatain ABI documentation.  The
> kernel is just very late to the party.

How can the kernel be late to the party if all of this is spinning
wheels without kernel support?
