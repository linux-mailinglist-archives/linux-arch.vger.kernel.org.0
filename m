Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A02631A77
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 08:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKUHlk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 02:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKUHlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 02:41:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491B303F1;
        Sun, 20 Nov 2022 23:40:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99ABECE0F54;
        Mon, 21 Nov 2022 07:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4E3C433C1;
        Mon, 21 Nov 2022 07:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669016426;
        bh=ghyXIiLZQR1VJJWRY9yXFbB0NXqU+1Bza1GDza4IlCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ON7jOHT51zmDztSDGialBKHHhuuS8etEB+bzLNnYkOPuzYN8CzSyJhiEze7ax2aBO
         ufY0+yMDRRomJ5SnzKhYhmsL6IFNJvTPXwuvGvC4nRehqiVkfBBVAZCHUpbyuGe7zw
         8qyR42WL6O0WdCVMdC4iY4YR8BPp6OFE19ah0VVphN7mby7bqoomsRHFPmCmvPqu1I
         ZnoM9Oh03Xtb+zWDQzFh9M7r0kiExUA3Ljpm5yUnN42RVxbzJFiKEVzguQV+9ZzUqd
         kosXMOvDYZShEIMFzkfzNMn4c3HLbi7MzR91+xzo1GdrseepOOBii5ghopRFO9hEbc
         WaVzQsjgH6RiQ==
Date:   Mon, 21 Nov 2022 09:40:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Message-ID: <Y3srU89TAwMURoEj@kernel.org>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-36-rick.p.edgecombe@intel.com>
 <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
 <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
 <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
 <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 17, 2022 at 07:57:59PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2022-11-17 at 12:25 +0000, Schimpe, Christina wrote:
> > > Hmm, we definitely need to be able to set the SSP. Christina, does
> > > GDB need
> > > anything else? I thought maybe toggling SHSTK_EN?
> > 
> > In addition to the SSP, we want to write the CET state. For instance
> > for inferior calls,
> > we want to reset the IBT bits.
> > However, we won't write states that are disallowed by HW.
> 
> Sorry, I should have given more background. Peter is saying we should
> split the ptrace interface so that shadow stack and IBT are separate. 
> They would also no longer necessarily mirror the CET_U MSR format.
> Instead the kernel would expose a kernel specific format that has the
> needed bits of shadow stack support. And a separate one later for IBT.
> 
> So the question is what does shadow stack need to support for ptrace
> besides SSP? Is it only SSP? The other features are SHSTK_EN and
> WRSS_EN. It might actually be nice to keep how these bits get flipped
> more controlled (remove them from ptrace). It looks like CRIU didn't
> need them.
 
CRIU reads CET_U with ptrace(PTRACE_GETREGSET, NT_X86_CET). It's done
before the injection of the parasite. The value of SHSTK_EN is used then to
detect if shadow stack is enabled and to setup victim's shadow stack for
sigreturn.

-- 
Sincerely yours,
Mike.
