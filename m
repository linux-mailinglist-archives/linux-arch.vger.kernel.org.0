Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E071686DC2
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBASSb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 13:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBASSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 13:18:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F979202;
        Wed,  1 Feb 2023 10:18:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E9B91EC0426;
        Wed,  1 Feb 2023 19:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675275507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8lNIJZw8YAjz68Gmod7C/9Iqybxq0zMLq+7ven4Sl20=;
        b=rd8PcoO7dO1r26AupmZg9g2ssXOh16XmgZxt/TK8TJJH1OgIhu6/lH9wA76S90K+LFMgrT
        VwL+SfBepqKw9QXHKIn8c8TrClQs2hVh5cG0JKZkdOcWtTcGFyqq5wtvF+I2lLA/DXUdq0
        EWJtkZg5vKanMrt4rPUJyPH7YgHYHgI=
Date:   Wed, 1 Feb 2023 19:18:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 06/39] x86/fpu: Add helper for modifying xstate
Message-ID: <Y9qs7iMmk3MYmfhL@zn.tnic>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-7-rick.p.edgecombe@intel.com>
 <Y9pGfsiG9am4HoTZ@zn.tnic>
 <095e9694a682fc47ebedd34fddb660319549d6bb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <095e9694a682fc47ebedd34fddb660319549d6bb.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 01, 2023 at 05:31:50PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-02-01 at 12:01 +0100, Borislav Petkov wrote:
> > On Thu, Jan 19, 2023 at 01:22:44PM -0800, Rick Edgecombe wrote:
> > > +void fpregs_lock_and_load(void)
> > > +{
> > > +     /*
> > > +      * fpregs_lock() only disables preemption (mostly). So
> > > modifying state
> > > +      * in an interrupt could screw up some in progress fpregs
> > > operation,
> > > +      * but appear to work. Warn about it.
> > 
> > I don't like comments where it sounds like we don't know what we're
> > doing. "Appear to work"?
> 
> I can change it. This patch started with the observation that modifying
> xstate from the kernel had been gotten wrong a couple times in the
> past, so that is what this is referencing. Since then, the fancy
> automatic solution got boiled down to this helper and a couple
> warnings.

Yeah, but that comment right now reads like: modifying in interrupt
context can corrupt fpregs and you should not do it but it kinda works,
by chance. Thus encouraging people to keep doing that.

I guess "but appear to work" can go and then it is fine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
