Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33495F3C41
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 06:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJDEya (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDEya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 00:54:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210574506B
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 21:54:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b15so3839442pje.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0foMv+yNCzUvsFibuuhT0xJMSn3BsckwqQnYwsSpG6c=;
        b=kP2DU18OL+6JoMmHiz7PTfk7riy2/Rm9Wy/RMJSZw0+4OsYTh77f0vWl9qv7iajjKy
         RIz6U5V4DB8c8PdV0j+66I9QzpbtApMOuki0n8qXkaXGXt3gywvOawzFAo8PZUDgrvLn
         K6ewO49a2ZbsvxZhb+uN62IdqX2lQY719nEKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0foMv+yNCzUvsFibuuhT0xJMSn3BsckwqQnYwsSpG6c=;
        b=GZuV5TnH/YW9SD0IvfbJgnemkQb/HFX9+LgHJq/Bf74rOypoMchP9KlzYdZD3yt77j
         /BPDQkidC5DhalUQGh2ytkihBiMkQtvj8Bp9OqXRVt3KBHGTMZoYQaCUJHZQxP4cWCoy
         OpxN8niwzJ6GSAxkuWBxMPJnpPb45JV+bJAD0wsrgW4Di1IGmsdZReLDZNfZKSXEFEdN
         5eYuGhqQ1Yf8fWqe7UqyWfWMLJcY8YOY47jm/MwqxONRJRq+lkdXK5q2GeVOFfBj76cq
         68j3XeO/VCgupRbhOmG2pO0aewOqTOKUgRJJwYeHDxfpXLIf0Bc0RsuWe/1fSV25Oh6m
         1wSw==
X-Gm-Message-State: ACrzQf3m00ZGYr5Yb8edmkllHQKDVsk+hR8pLDytMWVsPS55nFBWybX/
        qE8mkfMvkzohrrbzs3fJ9gBxmA==
X-Google-Smtp-Source: AMsMyM7h1fPIVLatwHLhSPOimpTJ14eQWo/995Hwz/mCrD36Vca1l16aPrA63CLsA8WZ5DSuZ7p0tg==
X-Received: by 2002:a17:90b:390e:b0:202:5d4e:c1f2 with SMTP id ob14-20020a17090b390e00b002025d4ec1f2mr15728874pjb.45.1664859268650;
        Mon, 03 Oct 2022 21:54:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78f34000000b005617c676344sm2649775pfr.89.2022.10.03.21.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 21:54:27 -0700 (PDT)
Date:   Mon, 3 Oct 2022 21:54:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Message-ID: <202210032147.ED1310CEA8@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
 <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> 
> <hint> <hint>

Hey Gustavo, Nathan, or Nick! I know y'all have some fancy AMD testing
rigs. Got a moment to spin up this series and run the selftests? :)

-- 
Kees Cook
