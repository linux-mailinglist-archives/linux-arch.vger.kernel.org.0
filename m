Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D305F3E71
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJDIgf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJDIgd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 04:36:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499827FF8;
        Tue,  4 Oct 2022 01:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E90B80D6C;
        Tue,  4 Oct 2022 08:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C95C433D6;
        Tue,  4 Oct 2022 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664872589;
        bh=Vta9NNBr6nkHrzFHJhf3d1KXNnH13ptRWqXqAZ9UuEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fd64pqzS0vr1Ay1lpgWB0pzIJx/pan0dcKrQm+bEESTb6QvXN8YvuzOiuxvO9KTVb
         ek5+IBL+J9KydBy0BbecAAwU/jxjdjCx56Ix+M4Fx5jiW8JCShwS8lw8EgWGDBZ39w
         imMW7YzBADcIahbEZlNGpHe/fwLHm0MzdExPXLojDaBIOxijF18NtWIpX3cjiXiq14
         fdUAAFs6aJtZBqP0tmFC061PEhUaAjdIpRo1lbbVrBDU1hH8c4ylTSdv75dGF/t0Pp
         B31dqnsqa4pOzRFODOizMXWBrH8EJlmGGC1zGaiWCUjHcwYrfuGNdzIQZsvIT/Y5jX
         31+AYNaAKcBkQ==
Date:   Tue, 4 Oct 2022 11:36:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
        dethoma@microsoft.com, Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Message-ID: <YzvwdSiQeLghucVW@kernel.org>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
 <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 05:09:04PM -0700, Dave Hansen wrote:
> On 10/3/22 16:57, Kees Cook wrote:
> > On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe wrote:
> >> Shadow stack is supported on newer AMD processors, but the kernel
> >> implementation has not been tested on them. Prevent basic issues from
> >> showing up for normal users by disabling shadow stack on all CPUs except
> >> Intel until it has been tested. At which point the limitation should be
> >> removed.
> >>
> >> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > So running the selftests on an AMD system is sufficient to drop this
> > patch?
> 
> Yes, that's enough.
> 
> I _thought_ the AMD folks provided some tested-by's at some point in the
> past.  But, maybe I'm confusing this for one of the other shared
> features.  Either way, I'm sure no tested-by's were dropped on purpose.
> 
> I'm sure Rick is eager to trim down his series and this would be a great
> patch to drop.  Does anyone want to make that easy for Rick?

FWIW, I've run CRIU test suite with the previous version of this set on an
AMD machine.
 
> <hint> <hint>

-- 
Sincerely yours,
Mike.
