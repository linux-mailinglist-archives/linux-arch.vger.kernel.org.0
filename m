Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF45F6DB6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJFSuz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJFSuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 14:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8CB0B02;
        Thu,  6 Oct 2022 11:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F4E61A59;
        Thu,  6 Oct 2022 18:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91689C433D6;
        Thu,  6 Oct 2022 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665082252;
        bh=AGnaOsCZJB2D12fIhHy6tdcZWEtEWaGlKpZIQ+DL/bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUIJwKsq7bClVzGiRmW5rpzBZ8wyXxXV76CAkIxeLxec40X5Vtjk6vT+2r7DW0Nx7
         yZb6toL1wruJgIHaRrLqSrpdeqO7ZD/zUqr7aKpNOHcjmx/oLirEAVRATqNGBfd1vS
         wiI4yiJWXdSfw21Qyb50R2AjH4zkdhdQEMa4+Yo0xkgWdkkLy1ursPzT7TQt6mX96L
         c3AXWzTVSOxggtPlKPvuWrLoV1QXtYui5575fLqMCbUCfs3b+UxdIGVenet9JGTYgb
         +hZgAOAgjDgLtzzzZvL0pZ1edFp3t+7oVw4ivAxymvcdohOxuGIxmD+wyBoKBHThH6
         hflmjmfQYFAPg==
Date:   Thu, 6 Oct 2022 21:50:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Message-ID: <Yz8jdMgv6jEm9rcH@kernel.org>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-24-rick.p.edgecombe@intel.com>
 <202210031141.0E0DE2CAEE@keescook>
 <8d453bb86cfe45125f2c9f2dba273d1f45d33638.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d453bb86cfe45125f2c9f2dba273d1f45d33638.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 10:51:02PM +0000, Edgecombe, Rick P wrote:
> CC Mike about ptrace/CRIU question.
> 
> On Mon, 2022-10-03 at 12:01 -0700, Kees Cook wrote:
> > On Thu, Sep 29, 2022 at 03:29:20PM -0700, Rick Edgecombe wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > Add three new arch_prctl() handles:
> > > 
> > >  - ARCH_CET_ENABLE/DISABLE enables or disables the specified
> > >    feature. Returns 0 on success or an error.
> > > 
> > >  - ARCH_CET_LOCK prevents future disabling or enabling of the
> > >    specified feature. Returns 0 on success or an error
> > > 
> > > The features are handled per-thread and inherited over
> > > fork(2)/clone(2),
> > > but reset on exec().

...

> > > +#include <linux/sched.h>
> > > +#include <linux/bitops.h>
> > > +#include <asm/prctl.h>
> > > +
> > > +long cet_prctl(struct task_struct *task, int option, unsigned long
> > > features)
> > > +{
> > > +	if (option == ARCH_CET_LOCK) {
> > > +		task->thread.features_locked |= features;
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* Don't allow via ptrace */
> > > +	if (task != current)
> > > +		return -EINVAL;
> > 
> > ... but locking _is_ allowed via ptrace? If that intended, it should
> > be
> > explicitly mentioned in the commit log and in a comment here.
> 
> I believe CRIU needs to lock via ptrace as well. Maybe Mike can
> confirm.

Actually, I didn't use ptrace for locking, I did it with "plain"
arch_prctl().

I still can't say for sure CRIU won't need this, I didn't have time yet to
have a closer look at this set.
 
-- 
Sincerely yours,
Mike.
