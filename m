Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482273F8D06
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbhHZR2p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 13:28:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37214 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhHZR2o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 13:28:44 -0400
Received: from zn.tnic (p200300ec2f131000d5458c5ba0c26ca5.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1000:d545:8c5b:a0c2:6ca5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 732D91EC0559;
        Thu, 26 Aug 2021 19:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629998871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7X9hy+BK0MrLN+oeN6aQ5lOMX3urBZA+yGYtxctLkPE=;
        b=qnSZuoWB5DiqTWlKZVhTTUXX5fDHmTwQKf69YtyR2gK7Okaxf51kEEXQRZ7yFdn7PwQHAB
        glYmFOZbCt2RGHOMxQymkOY92ddCqNcxJYamRl1mNIklK4lLYci3Dv/YkV7ZL8pnv7E6xb
        Z70jtdgdJqJVQksx/YGoAIFLokcvtes=
Date:   Thu, 26 Aug 2021 19:28:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v29 25/32] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YSfPQYjNxFPALmgC@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-26-yu-cheng.yu@intel.com>
 <YSfGUlGJdV/5EcBs@zn.tnic>
 <CAMe9rOoo5wC7AWbo3WO_GWvT5CXV3r3ysZ2qB8ZPi=giRBDetg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMe9rOoo5wC7AWbo3WO_GWvT5CXV3r3ysZ2qB8ZPi=giRBDetg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 26, 2021 at 10:22:29AM -0700, H.J. Lu wrote:
> > > +     /*
> > > +      * Earlier clone() does not pass stack_size.  Use RLIMIT_STACK and
> >
> > What is "earlier clone()"?
> 
> clone() doesn't have stack size info which was added to clone3().

/me goes and reads the manpage...

   clone3()
       The  clone3()  system call provides a superset of the functionality of the older
       clone() interface.  It also provides a number of  API  improvements,  including:
       space  for additional flags bits; cleaner separation in the use of various argu‐
       ments; and the ability to specify the size of the child's stack area.

Aha, Yu-cheng, pls use those words to make your comment understandable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
