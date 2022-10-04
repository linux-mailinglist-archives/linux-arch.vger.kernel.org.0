Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D195F3C13
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 06:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJDEWH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 00:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDEWE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 00:22:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983A2C12A
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 21:22:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z20so5122103plb.10
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Uece0fM7JiJORIh7QBlH2yQn1WOcaEDf7Srsu/hsgUw=;
        b=IZPCBJgARGka0cb7Qhti4Q0beiVA8VD+iN0oph+SF1rux57WDNrOg/IH/L2x8sF66T
         wE1b/47QrbUn/SS4rziRMS8qZhqgjpEkP5cpCXXbtgH5Bo+tSWTz06ERHb+jcyYipBRf
         Tfqd8ab5NKyZQQkEKz8IN56bLeH1Rh/dfyOqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Uece0fM7JiJORIh7QBlH2yQn1WOcaEDf7Srsu/hsgUw=;
        b=d2r9w06DKHh97isu9Hp5dd4e2vVdiEhf/rt8Kx9ZKA+CGrYG3WJzRCG0tRQx6I+PDU
         q7JHWFBO2Vj68QNgCxvpqYlKFlLbRwduvU90i7+RuVd20FjifaTwIIvf3wkNQlriMRgP
         9I+bm8kfWj5K7uIig0v1kCddDP61HNmZQMY1PH7awD82tYLaC/hqTdTnF9h+v2SPoQD9
         zW6R1HyOEWShVmXKvMaP52FOTueBXtPJIqyP8O1Twz6/eWKr+fhMqv5zBnMrHcm++0Xk
         /z1VTrD5gA8EAKiSz/bJr2H+h3iuQ9VpHrILzwAhnkNWqPnO659FF/p8jCytw+FjqhYS
         U4nw==
X-Gm-Message-State: ACrzQf2W+a5UHyKO+xOFPR1x2adMINjeR0jF2lHFY3RNudaEhqljXR6N
        nqm/SlclIfLVA06H2VyOzuvyaw==
X-Google-Smtp-Source: AMsMyM61KNxyPA9BhzyQ+UiKn0Jm9LQ+eZMj7fa8DZwgn3vRmElmfsAwichq5aJoTDxwBEmVW2pxWw==
X-Received: by 2002:a17:902:7408:b0:17b:546a:17 with SMTP id g8-20020a170902740800b0017b546a0017mr23824925pll.134.1664857320258;
        Mon, 03 Oct 2022 21:22:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b001782f94f8ebsm8086293plh.3.2022.10.03.21.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 21:21:59 -0700 (PDT)
Date:   Mon, 3 Oct 2022 21:21:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Message-ID: <202210032119.EF573F9E@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com>
 <202210031134.B0B6B37@keescook>
 <bcfca48f-e02a-fc43-fb92-9cc119e2d28f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcfca48f-e02a-fc43-fb92-9cc119e2d28f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 03:49:18PM -0700, Andy Lutomirski wrote:
> On 10/3/22 11:39, Kees Cook wrote:
> > On Thu, Sep 29, 2022 at 03:29:19PM -0700, Rick Edgecombe wrote:
> > > [...]
> > > Still allow FOLL_FORCE to write through shadow stack protections, as it
> > > does for read-only protections.
> > 
> > As I asked in the cover letter: why do we need to add this for shstk? It
> > was a mistake for general memory. :P
> 
> For debuggers, which use FOLL_FORCE, quite intentionally, to modify text.
> And once a debugger has ptrace write access to a target, shadow stacks
> provide exactly no protection -- ptrace can modify text and all registers.

i.e. via ptrace? Yeah, I grudgingly accept the ptrace need for
FOLL_FORCE.

> But /proc/.../mem may be a different story, and I'd be okay with having
> FOLL_PROC_MEM for legacy compatibility via /proc/.../mem and not allowing
> that to access shadow stacks.  This does seem like it may not be very
> useful, though.

I *really* don't like the /mem use of FOLL_FORCE, though. I think the
rationale has been "using PTRACE_POKE is too slow". Again, I can live
with it, I was just hoping we could avoid expanding that questionable
behavior, especially since it's a bypass of WRSS.

-- 
Kees Cook
