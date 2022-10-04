Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABA5F3C10
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 06:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJDESV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 00:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDEST (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 00:18:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA227DF6
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 21:18:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d11so11645018pll.8
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 21:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ySm4+MtMrElwdIGDssthem6q+35qWgtrM6IZsGhsUBM=;
        b=b8d7DfhJyod6G/akuEzQS5pK6i7A5VM3gtwDRfd1NbVowaiMxRdZNvCHHaHlQCDxW9
         wdzq6euBV4W6zTkAVlVx1B2eZ78/RUdfpDyVzy3RQiUH5vYjLsIIP8KNqSE1J36z8z7D
         VJB5nvKL26GtEePgnvtpEYw0BfKQ2po1FueIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ySm4+MtMrElwdIGDssthem6q+35qWgtrM6IZsGhsUBM=;
        b=3OggLrXg7WxuZUZnocFLl8l4Uo43Wkg+k8PDANZpxvbTdar6+03ydpsfmP2QepbtGb
         zb/USvPGEjPRpF13kVIhJ8p1n3MHx07igweJpNfuEWEVJwN0gGeGfGJA6SBt9Aga3ghf
         a1BOhsfwOxTb6EokEBWYnIua/eSeuBeBa18P72jzI4YJ8WnC2DqdVlob/HwHLc4G5JwG
         B2TFbg4o2osxzgI7389rA897CaNtAO/yAdbGak1zyqGstLIE7iHKqgxjsZ3kO1HZ08g+
         Hac9lU0l8wPZ8+L3HoLNpaT1Ic0AoDBqNDEOd+dpkdeyK0rRbYWzuRrQKdBTMBRc5Xcf
         qUWA==
X-Gm-Message-State: ACrzQf0t3KNhSZLR14FnG5QhRtcgZKEOrmerSg/EEeuPoimdUHZEE11k
        5763Gn3oMyrbQN88jiaYfR8MPg==
X-Google-Smtp-Source: AMsMyM7oeIR2rhDCPrGi01xA+8CnRjWdmDt8Spgr9GF3IXW2Tx0ZpMSaYGHobZXaskfhNz4J2LeYcA==
X-Received: by 2002:a17:90a:1648:b0:209:6bb1:63d2 with SMTP id x8-20020a17090a164800b002096bb163d2mr15962201pje.154.1664857094786;
        Mon, 03 Oct 2022 21:18:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7978f000000b005617b1e183asm2602084pfp.194.2022.10.03.21.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 21:18:13 -0700 (PDT)
Date:   Mon, 3 Oct 2022 21:18:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        Mike Rapoport <rppt@kernel.org>, jamorris@linux.microsoft.com,
        dethoma@microsoft.com
Subject: Re: [PATCH v2 30/39] x86: Expose thread features status in
 /proc/$PID/arch_status
Message-ID: <202210032114.BECA56BFF@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-31-rick.p.edgecombe@intel.com>
 <202210031530.9CFB62B39F@keescook>
 <b8b3caab-9f0c-4230-8d7b-debd7f79cdb9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b3caab-9f0c-4230-8d7b-debd7f79cdb9@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 03:45:50PM -0700, Andy Lutomirski wrote:
> 
> 
> On Mon, Oct 3, 2022, at 3:37 PM, Kees Cook wrote:
> > On Thu, Sep 29, 2022 at 03:29:27PM -0700, Rick Edgecombe wrote:
> >> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >> 
> >> Applications and loaders can have logic to decide whether to enable CET.
> >> They usually don't report whether CET has been enabled or not, so there
> >> is no way to verify whether an application actually is protected by CET
> >> features.
> >> 
> >> Add two lines in /proc/$PID/arch_status to report enabled and locked
> >> features.
> >> 
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> [Switched to CET, added to commit log]
> >> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >> 
> >> ---
> >> 
> >> v2:
> >>  - New patch
> >> 
> >>  arch/x86/kernel/Makefile     |  2 ++
> >>  arch/x86/kernel/fpu/xstate.c | 47 ---------------------------
> >>  arch/x86/kernel/proc.c       | 63 ++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 65 insertions(+), 47 deletions(-)
> >>  create mode 100644 arch/x86/kernel/proc.c
> >
> > This is two patches: one to create proc.c, the other to add CET support.
> >
> > I found where the "arch_status" conversation was:
> > https://lore.kernel.org/all/CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com/
> >
> > Andy, what did you mean "make sure that everything in it is namespaced"?
> > Everything already has a field name. And arch_status doesn't exactly
> > solve having compat fields -- it still needs to be handled manually?
> > Anyway... we have arch_status, so I guess it's fine.
> 
> I think I meant that, since it's "arch_status" not "x86_status", the fields should have names like "x86.Thread_features".  Otherwise if another architecture adds a Thread_features field, then anything running under something like qemu userspace emulation could be confused.
> 
> Assuming that's what I meant, I think my comment still stands :)

Ah, but that would be needed for compat things too in "arch_status", and
could just as well live in "status".

How about moving both of these into "status", with appropriate names?

x86_64.Thread_features: ...
i386.LDT_or_something: ...

?

Does anything consume arch_status yet? Looks like probably not:
https://codesearch.debian.net/search?q=%5Cbarch_status%5Cb&literal=0&perpkg=1

-- 
Kees Cook
