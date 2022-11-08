Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70A621D8B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 21:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiKHUTX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 15:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKHUTR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 15:19:17 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0131A80A
        for <linux-arch@vger.kernel.org>; Tue,  8 Nov 2022 12:19:15 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l15so9325022qtv.4
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2022 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYTJsr3y3DSpzuW7jbv9zORF+HiPBsmrV3dtI+qjb2g=;
        b=RktMLy/W0Aalvj/azaMLVb1FNgDV1yEPtRfoOCAalX5a3JOa/QZKm/gQYlMeehBILF
         Z8FRelGTxwLlt2r/PHfGWfm7hcJhjQ+Ccxx9+6hwjwDVkjbRbmOXWEwQ5Og3WEMnSrUe
         jvI9rMDLZTywmAFs2PxsTOcuGTZL45ITlqnps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYTJsr3y3DSpzuW7jbv9zORF+HiPBsmrV3dtI+qjb2g=;
        b=FFWnpaWsIyUdYYe4Vs9jQrPK8ugm0ugGr519QTIj4tF/Ds1u6t/+rAh0Bw1bnOqvhD
         NXyS8j6VoRh+WOQphHgzk1p4FVpIVbyD4QJgjJR89fwuNw1Mii+kFCwlPk8BHt2D5Zhf
         gMLzJvbiqZMaK2HLyRzm8NIRCOO61GM162jauylJRBqNnX9s1sqR9xttm0DeKPRubLH1
         ZkmBfU9B7HbmXi51edcdR6oeTExmyN+JtO8XUShT6qsILKxjmFopuiGzj14Ui4LP1DDy
         NRfuTyuUTMV5ViK/ZAmSTnznHUziIrPdlI6ROmf1tlH9VnupttnI4TUXo8+HL/Rnzejl
         CmNA==
X-Gm-Message-State: ACrzQf1yCZXfSLZWUTzFENKrV1HQ3Z+5/mszDJ6Tj5bEHOVGAvBVlesA
        brKEJrdKa+mqei71STkpZsv+5hBkHO7oxQ==
X-Google-Smtp-Source: AMsMyM66uYM31RBxIO2fYrni2EaG50ARXUmDqUFmiEBwRtlnUZOLNhmCBClgHSEvZBEy78W+ITi5zw==
X-Received: by 2002:ac8:6e83:0:b0:3a5:1fcb:3953 with SMTP id c3-20020ac86e83000000b003a51fcb3953mr39749343qtv.373.1667938754637;
        Tue, 08 Nov 2022 12:19:14 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id q37-20020a05620a2a6500b006ee7923c187sm1655532qkp.42.2022.11.08.12.19.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:19:14 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-36a4b86a0abso144205927b3.7
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2022 12:19:13 -0800 (PST)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr35789530ywe.401.1667938743084; Tue, 08
 Nov 2022 12:19:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <Y2llcRiDLHc2kg/N@cmpxchg.org>
 <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
 <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <CAHk-=whi2BB9FviYiuUWV0KHibP_Lx_CWDWkxxv3SXA1PKV0Lg@mail.gmail.com>
 <CAHk-=wivgyfywteXoO7K0Mj_KoCRF-RyXDH-eGW0A_fev+dGug@mail.gmail.com> <20221108200345.xxcvnsnwgjyb7w3a@meerkat.local>
In-Reply-To: <20221108200345.xxcvnsnwgjyb7w3a@meerkat.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Nov 2022 12:18:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFdzHxB+f9WOTM1jZKBig9sY0s_-ASCZEUGsQ1mirjgQ@mail.gmail.com>
Message-ID: <CAHk-=wjFdzHxB+f9WOTM1jZKBig9sY0s_-ASCZEUGsQ1mirjgQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Konstantin Ryabitsev <mricon@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 8, 2022 at 12:03 PM Konstantin Ryabitsev <mricon@kernel.org> wrote:
>
> Yes, --no-parent.

Ahh, that's new. I guess I need to update my ancient b4-0.8.0 install..

But yes, with that, and the manual parent lookup (because otherwise
"--no-parent" will fetch *just* the patch itself, not even walking up
the single parent chain). it works.

Maybe a "--single-parent" or "--deadbeat-parent" option would be a good idea?

Anyway, with a more recent b4 version, the command

   b4 am --no-parent
CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com

gets that series and only that series.

              Linus
