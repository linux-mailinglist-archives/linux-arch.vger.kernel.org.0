Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119F6B8BD5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCNHT4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCNHTx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 03:19:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDB19C68;
        Tue, 14 Mar 2023 00:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ACB9B81887;
        Tue, 14 Mar 2023 07:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B34C433EF;
        Tue, 14 Mar 2023 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678778388;
        bh=rEcwpr6ZTgtGaQrka2qK+7yPmKYXTmYdMJswZJ4beXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xc+htRg4jwkaQ1NdwL15ZlqUDMviGCnMWy9asoPgzTkQsycHYyOuxImk+2fwxRjJg
         ANSpQgtaUXSm5JxSsOEx18+zhZX4fFXLwaw89hdRjNu+43fhg7cT2exl6XR/v50yQx
         PVdG/eSVNK9EXDfcDdUf3czRPirAefJxegCSQo0VUSKps7q9gqtPs+f87B4YaMdsgM
         pnULmDVF+F93AQhI8H5MAQdQAK2mCfBbSxV6ARQ0lKbuqqyuK7HcPID8wRiIB/R/S1
         ksVWWlmvLvg/6n6asn34itV+OVlWruZdWD4KY/wTe8Y6R7U2VUCKtue6AvIarS974i
         U01UkRTpXIeng==
Date:   Tue, 14 Mar 2023 09:19:25 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, nd@arm.com, al.grant@arm.com
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <ZBAf/QI42hcVQ4Uq@kernel.org>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com>
 <ZADbP7HvyPHuwUY9@arm.com>
 <20230309185511.GA1964069@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309185511.GA1964069@debug.ba.rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, Mar 09, 2023 at 10:55:11AM -0800, Deepak Gupta wrote:
> On Thu, Mar 02, 2023 at 05:22:07PM +0000, Szabolcs Nagy wrote:
> > The 02/27/2023 14:29, Rick Edgecombe wrote:
> > > Previously, a new PROT_SHADOW_STACK was attempted,
> > ...
> > > So rather than repurpose two existing syscalls (mmap, madvise) that don't
> > > quite fit, just implement a new map_shadow_stack syscall to allow
> > > userspace to map and setup new shadow stacks in one step. While ucontext
> > > is the primary motivator, userspace may have other unforeseen reasons to
> > > setup it's own shadow stacks using the WRSS instruction. Towards this
> > > provide a flag so that stacks can be optionally setup securely for the
> > > common case of ucontext without enabling WRSS. Or potentially have the
> > > kernel set up the shadow stack in some new way.
> > ...
> > > The following example demonstrates how to create a new shadow stack with
> > > map_shadow_stack:
> > > void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);
> > 
> > i think
> > 
> > mmap(addr, size, PROT_READ, MAP_ANON|MAP_SHADOW_STACK, -1, 0);
> > 
> > could do the same with less disruption to users (new syscalls
> > are harder to deal with than new flags). it would do the
> > guard page and initial token setup too (there is no flag for
> > it but could be squeezed in).
> 
> Discussion on this topic in v6
> https://lore.kernel.org/all/20230223000340.GB945966@debug.ba.rivosinc.com/
> 
> Again I know earlier CET patches had protection flag and somehow due to pushback
> on mailing list, it was adopted to go for special syscall because no one else
> had shadow stack.
> 
> Seeing a response from Szabolcs, I am assuming arm4 would also want to follow
> using mmap to manufacture shadow stack. For reference RFC patches for risc-v shadow stack,
> use a new protection flag = PROT_SHADOWSTACK.
> https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
> 
> I know earlier discussion had been that we let this go and do a re-factor later as other
> arch support trickle in. But as I thought more on this and I think it may just be
> messy from user mode point of view as well to have cognition of two different ways of
> creating shadow stack. One would be special syscall (in current libc) and another `mmap`
> (whenever future re-factor happens)
> 
> If it's not too late, it would be more wise to take `mmap`
> approach rather than special `syscall` approach.
 
I disagree. 

Having shadow stack flags for mmap() adds unnecessary complexity to the
core-mm, while having a dedicated syscall hides all the details in the
architecture specific code.

Another reason to use a dedicated system call allows for better
extensibility if/when we'd need to update the way shadow stack VMA is
created.

As for the userspace convenience, it is anyway required to add special
code for creating the shadow stack and it wouldn't matter if that code
would use mmap(NEW_FLAG) or map_shadow_stack().

> > most of the mmap features need not be available (EINVAL) when
> > MAP_SHADOW_STACK is specified.
> > 
> > the main drawback is running out of mmap flags so extension
> > is limited. (but the new syscall has limitations too).

-- 
Sincerely yours,
Mike.
