Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965B85F166D
	for <lists+linux-arch@lfdr.de>; Sat,  1 Oct 2022 01:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiI3XB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 19:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiI3XB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 19:01:27 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0412E42F
        for <linux-arch@vger.kernel.org>; Fri, 30 Sep 2022 16:01:25 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g8so4411752iob.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Sep 2022 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0zt2Q5NN+Rs2C2aEkp8f4auq2xya6N3MePx4qmypsFc=;
        b=K9MohiTFe/jI/NYUnjHZt0j/r3AEx4tWk8aMjFSTQ2wHuJqShRre3HIQaSYMPdsPqw
         CgkBdBtxLiPDFdLfCA6GxIeipwCNfggZQ/FlAtVWHhFws8AnMQjJKh9HcYFItYRxPO9o
         XZ79w2s0es/8qkrg9qrd9Y+BGBx/7JaqjYds66RbwHuYGYC6AyGz7S9dcfKQka/X/yaU
         +YrmO36GxfU598k6MBGgoGPwqLiEYmADAe79yYEjNpKUtT25cS3cvkUjS3O+TDumwRCl
         vdK2JwQniT4vSJ1+KjSMq/WF0h6hTdvi6Zr89DHV15jR6UYe5Wy/UrjSMIaJSTLdYkg9
         OM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0zt2Q5NN+Rs2C2aEkp8f4auq2xya6N3MePx4qmypsFc=;
        b=13hYm0/zBPKpzMH6zTRips2aRxQzc3wmySoDuehEb78Pojmj1dU/k4pAJZKlkHMiql
         vJjQRFevQxnk61J3gNnRmk1ADv9TOxhi/b/NuE94QVnclKLHag2RNA8r7tyTwo/p90HH
         +x8ggyaiaJNEyxY6T5V7e1IErmWdzzJsCIzGPJA+8Nrguq64IjmYvxIt1KDv8qigRHWd
         x7WbeDIAONVi/4KTfXhd6a4/CWPdnRFd0aLit8hSYUNnR9ta3ee3iKVj1U4YCDMs3n03
         iBngPczHAbcoGwYNNV+IIxFLS+SQjN0KtXjAOdz1dPt6w6stNYPOhcyMwVSdJ3mInMLz
         haIw==
X-Gm-Message-State: ACrzQf1hg4w7ZiNHlPyOH3wFMOkwNh+Uy7bhewZsG2/HDLYlaGg3MWR8
        iQMPzGtRZ4iDhztPSvXRtHmlnP+J/uFDILH/5/CVtQ==
X-Google-Smtp-Source: AMsMyM4pyhAAdStKkBOdZk4WLOBE/ewn/Xk3NAXvmNiNkUkh/Xch5qpt+jkA7Ix5YZMuQ0NMUnkAdvv1yy96Z0gQfd8=
X-Received: by 2002:a05:6602:2ccd:b0:6a1:c561:50ca with SMTP id
 j13-20020a0566022ccd00b006a1c56150camr4976341iow.154.1664578884508; Fri, 30
 Sep 2022 16:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com> <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
In-Reply-To: <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 1 Oct 2022 01:00:48 +0200
Message-ID: <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack memory
To:     Dave Hansen <dave.hansen@intel.com>
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
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 30, 2022 at 9:16 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 9/29/22 15:29, Rick Edgecombe wrote:
> > @@ -1633,6 +1633,9 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
> >  {
> >       unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
> >
> > +     if (write && (pteval & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY)
> > +             return 0;
>
> Do we not have a helper for this?  Seems a bit messy to open-code these
> shadow-stack permissions.  Definitely at least needs a comment.

FWIW, if you look at more context around this diff, the function looks
like this:

 static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 {
        unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;

+       if (write && (pteval & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY)
+               return 0;
+
        if (write)
                need_pte_bits |= _PAGE_RW;

        if ((pteval & need_pte_bits) != need_pte_bits)
                return 0;

        return __pkru_allows_pkey(pte_flags_pkey(pteval), write);
 }

So I think this change is actually a no-op - the only thing it does is
to return 0 if write==1, !_PAGE_RW, and _PAGE_DIRTY. But the check
below will always return 0 if !_PAGE_RW, unless I'm misreading it? And
this is the only patch in the series that touches this function, so
it's not like this becomes necessary with a later patch in the series
either.

Should this check go in anyway for clarity reasons, or should this
instead be a comment explaining that __pte_access_permitted() behaves
just like the hardware access check, which means shadow pages are
treated as readonly?
