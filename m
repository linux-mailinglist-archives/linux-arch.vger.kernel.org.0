Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC162A285
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKOUJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKOUJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:09:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08952872B;
        Tue, 15 Nov 2022 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BdlW7Dx+5GRrqB7M0f3vkI2hlEusdOzRBLTjRYgAEIk=; b=Nd1jimO7ta7TIyO5oEoeOGgvNa
        1jfoFJ1p0O7En6bYFK8Z5q9HBRpCAp/mS/lwEcRyNAlSlfGr0PW2E2YVRZc54MLxHRloO1jGqXXfI
        p4w17nc47kM2NBmW3NVKFdGnmcJl/qsigMX0rgRTxP3BCqpt29VpoDufaRsVp80K3/jeu2jhYNPdV
        m1POgqhAlSYYLOaZITZ+d+06ME/tAHdmt+IzMgd8kGBLfT8Oq3y+gQhLOT875S3OIEBqbxJSb4FNK
        vdvh7qWg90RhGwFEiY1SO6mrZ0TYa2J2Qyi5krFvv1i6VvICPoZ9Hf8XZbLQ2U5jsfojQz9cW4kB3
        nVKhuwjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov2EP-0015lV-IL; Tue, 15 Nov 2022 20:08:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D301301C4B;
        Tue, 15 Nov 2022 15:43:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2617B2015BE8A; Tue, 15 Nov 2022 15:43:37 +0100 (CET)
Date:   Tue, 15 Nov 2022 15:43:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Message-ID: <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-36-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104223604.29615-36-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:36:02PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Some applications (like GDB and CRIU) would like to tweak CET state via
> ptrace. This allows for existing functionality to continue to work for
> seized CET applications. Provide an interface based on the xsave buffer
> format of CET, but filter unneeded states to make the kernel’s job
> easier.
> 
> There is already ptrace functionality for accessing xstate, but this
> does not include supervisor xfeatures. So there is not a completely
> clear place for where to put the CET state. Adding it to the user
> xfeatures regset would complicate that code, as it currently shares
> logic with signals which should not have supervisor features.
> 
> Don’t add a general supervisor xfeature regset like the user one,
> because it is better to maintain flexibility for other supervisor
> xfeatures to define their own interface. For example, an xfeature may
> decide not to expose all of it’s state to userspace. A lot of enum
> values remain to be used, so just put it in dedicated CET regset.
> 
> The only downside to not having a generic supervisor xfeature regset,
> is that apps need to be enlightened of any new supervisor xfeature
> exposed this way (i.e. they can’t try to have generic save/restore
> logic). But maybe that is a good thing, because they have to think
> through each new xfeature instead of encountering issues when new a new
> supervisor xfeature was added.

Per this argument this should not use the CET XSAVE format and CET name
at all, because that conflates the situation vs IBT. Enabling that might
not want to follow this precedent.

> By adding a CET regset, it also has the effect of including the CET state
> in a core dump, which could be useful for debugging.
> 
> Inside the setter CET regset, filter out invalid state. Today this
> includes states disallowed by the HW and states involving Indirect Branch
> Tracking which the kernel does not currently support for usersapce.
> 
> So this leaves three pieces of data that can be set, shadow stack
> enablement, WRSS enablement and the shadow stack pointer. It is worth
> noting that this is separate than enabling shadow stack via the
> arch_prctl()s.

Does this validate the SSP, when set, points to an actual valid SS page?
