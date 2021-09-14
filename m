Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD52640AB2E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 11:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhINJyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhINJyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Sep 2021 05:54:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF63C061762;
        Tue, 14 Sep 2021 02:53:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1048004bf380b26d2cf776.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:4bf3:80b2:6d2c:f776])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07D1D1EC0453;
        Tue, 14 Sep 2021 11:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631613192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViyruqyaOCoCW/0p2JZLgQLm3FfQGbXjvmpiABsrfCI=;
        b=RJB4znnZ3Vdx8xwIRKp/GquN5eUjvPjpfOZhxfz0G06K+1tAtY4CRKjGHkci8G6uqT909A
        hWeLlUA99oGVkIlEzNF1pgmmUafrY+0e3mG4RMHGGDr5b4CPS7Wv3qN3hMvbzoi15ZESpr
        gJLpU/Z822KRQonHTRZ/g1iP6GsO1d4=
Date:   Tue, 14 Sep 2021 11:53:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
Message-ID: <YUBxAut2PtGzX/6k@zn.tnic>
References: <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
 <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
 <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
 <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
 <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
 <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
 <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
 <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
 <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
 <45c62101c065ed7e728fadac7207866bf8c36ec4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45c62101c065ed7e728fadac7207866bf8c36ec4.camel@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 14, 2021 at 01:33:02AM +0000, Edgecombe, Rick P wrote:
> The original prctl solution prevents this case since the kernel did the
> allocation and restore token setup, but of course it had other issues.
> The other ideas discussed previously were a new syscall, or some sort
> of new madvise() operation that could be involved in setting up shadow
> stack, such that it is never writable in userspace.

If I had to choose - and this is only my 2¢ anyway - I'd opt for this
until there's a really good reason for allowing shstk programs to fiddle
with their own shstk. Maybe there is but allowing them to do that sounds
to me like: "ew, why do we go to all this trouble to have shadow stacks
if programs would be allowed to fumble with it themselves? Might as well
not do shadow stacks at all."

And if/when there is a good reason, the API should be defined and
discussed properly at first, before we expose it to luserspace, ofc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
