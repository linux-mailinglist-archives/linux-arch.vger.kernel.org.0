Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C60162B793
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 11:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKPKTM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 05:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKPKTL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 05:19:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400CF12A9D;
        Wed, 16 Nov 2022 02:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fPq7tV/2QrdcGUCtPsVdOGkEWJNB5jMtOAqK/xzSNP8=; b=mvTcBioZ2ydT6zOL0WsZpRiqLF
        /wNmPcS0dCzbIc8xSMuf4oMHZxucJGQhaR/T9uhRjFOZCDLwEV0Zuq27CGInXJkU6AWm9+BEcAHwY
        Z4e0QXqjjJ5nAPfZUU+p4EQna7WqevLJawCiETQtneHLHaIsH5e4Ni83er9A0DqZdmhfCvPgd2c30
        SztwgIhn9KcuN7CHQErI6KbJD5wBii8MmqIp8lw30qV3OjCRZHKf+fBlqzkGLde5LQwQA4dIsx4Rt
        elgCnfTFqNY26L82GW+9Ye5fCTCJHz+MMqlwt99lsBJbOT8AWUEK1nuizoTiWA1hSfnTnZNNw81BQ
        Dx91JRnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovFVB-001GgG-63; Wed, 16 Nov 2022 10:18:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A303300129;
        Wed, 16 Nov 2022 11:18:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50A762B5E019F; Wed, 16 Nov 2022 11:18:40 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:18:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Message-ID: <Y3S5AKhLaU+YuUpQ@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-28-rick.p.edgecombe@intel.com>
 <Y3OfsZI0jFRoUw02@hirez.programming.kicks-ass.net>
 <be65a66baf94cebf0bc8d726a704238787195837.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be65a66baf94cebf0bc8d726a704238787195837.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 15, 2022 at 11:42:46PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-11-15 at 15:18 +0100, Peter Zijlstra wrote:
> > On Fri, Nov 04, 2022 at 03:35:54PM -0700, Rick Edgecombe wrote:
> > 
> > > +#ifdef CONFIG_X86_USER_SHADOW_STACK
> > > +static inline int write_user_shstk_64(u64 __user *addr, u64 val)
> > > +{
> > > +     asm_volatile_goto("1: wrussq %[val], (%[addr])\n"
> > > +                       _ASM_EXTABLE(1b, %l[fail])
> > > +                       :: [addr] "r" (addr), [val] "r" (val)
> > > +                       :: fail);
> > > +     return 0;
> > > +fail:
> > > +     return -EFAULT;
> > > +}
> > > +#endif /* CONFIG_X86_USER_SHADOW_STACK */
> > 
> > Why isn't this modelled after put_user() ?
> 
> You mean as far as supporting multiple sizes? It just isn't really
> needed yet. We are only writing single frames. I suppose it might make
> more sense with the alt shadow stack support, but that is dropped for
> now.
> 
> The other difference here is that WRUSS is a weird instruction that is
> treated as a user access even if it comes from the kernel mode. So it's
> doesn't need to stac/clac.
> 
> > 
> > Should you write a 64bit value even if the task receiving a signal is
> > 32bit ?
> 
> 32 bit support was also dropped.

How? Task could start life as 64bit, frob LDT to set up 32bit code
segment and jump into it and start doing 32bit syscalls, then what?

AFAICT those 32bit syscalls will end up doing SA_IA32_ABI sigframes.
