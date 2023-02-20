Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAB69C56F
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 07:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBTGu4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 01:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBTGuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 01:50:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A640AD2A;
        Sun, 19 Feb 2023 22:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231A7B80AD5;
        Mon, 20 Feb 2023 06:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C2AC433EF;
        Mon, 20 Feb 2023 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676875851;
        bh=8ea/W8EPaGnZGcQn5kFoCfUqrn/UjnED2e0Ukr+lUV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ar25jCVK8MzN7+bVdQZtDcBDGEZmSz4d5L1idXv/g3IMG9MkJNLgVG8e/aaSEsSE6
         NBJ81vRXMyri3EtEGciviwl4KiniDa79ObM16tpGxwRjRZY7Lf5lohJPtR6p09pjsf
         UlO70fZO9ocQ9ympyYoaYCRAZ+hEHMtfvj3p8aNeFrEXwwyxoGKg9UikMWbnWWiAlI
         4qDjC0A93LRgT+5FfqKIAigndBOSMIn7GnKWg3NRyJbdPzCHmTKmoXqR5wVcn/I3uY
         gUE95b4j9EoR1/d026lm0ymfIOKTHCdzn5XixoKwZSSRuZ5J0Z0lp3WbO4KGcRyGMj
         pGavmNWjAgRCw==
Date:   Mon, 20 Feb 2023 08:50:29 +0200
From:   Mike Rapoport <rppt@kernel.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
Message-ID: <Y/MYNRHrG61ZiAgt@kernel.org>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:13:52PM -0800, Rick Edgecombe wrote:
> Hi,
> 
> This series implements Shadow Stacks for userspace using x86's Control-flow 
> Enforcement Technology (CET). CET consists of two related security features: 
> shadow stacks and indirect branch tracking. This series implements just the 
> shadow stack part of this feature, and just for userspace.

For the series

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.
