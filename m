Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082EE5F3EB3
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJDIpM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJDIov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 04:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437ECBF53;
        Tue,  4 Oct 2022 01:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4C9612DC;
        Tue,  4 Oct 2022 08:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE40C433D6;
        Tue,  4 Oct 2022 08:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664873080;
        bh=FLxJujkrEz8c6n9mzp1mDrchZzbrKurHkU3rXpxIpvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNzz79AB2yicRFSXFG0MXGmNNYDmFVrbVKIiKFHEOY/gF8rAr+98YrhPRTyDZQp94
         B0IgHfkpfkOXUXPQguDzENFcNoTP2rzEtjlC5g5ZtqrIVfp06wURtskr6E9zM3akFy
         sArcwFJ8JUwIJ1t4uo1gZ7s+m2JNm5fphzyG7szfX1G7a07hmtJ9UAYJ004z4tTl39
         BTyaA93JiXNKYzXCWWXBgiWD3oEQp081Z2ITDXwXbDBL9fDT0BEUoKcEz9za7G768E
         fY8K+3hlj6OSojkjGw2n7lKYynIIcdxERpgICaqjzHKt6tPnNzDRb9NxqQwS57u0h/
         97gkm22qL4CKg==
Date:   Tue, 4 Oct 2022 11:44:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [OPTIONAL/RFC v2 37/39] x86/cet: Add PTRACE interface for CET
Message-ID: <YzvyYDOg8GZIBtz8@kernel.org>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-38-rick.p.edgecombe@intel.com>
 <202210031658.EEC88324FD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210031658.EEC88324FD@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 04:59:43PM -0700, Kees Cook wrote:
> On Thu, Sep 29, 2022 at 03:29:34PM -0700, Rick Edgecombe wrote:
> > From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > 
> > Some applications (like GDB and CRIU) would like to tweak CET state via
> 
> Eee. Does GDB really need this? Can we make this whole thing
> CONFIG-depend on CRIU?

GDB, at least its Intel fork uses this. I don't see how they can jump
between frames without an ability to modify shadow stack contents.

Last I looked they used NT_X86_CET to update SSP and ptrace(POKEDATA) to
write to the shadow stack.
 
> -- 
> Kees Cook

-- 
Sincerely yours,
Mike.
