Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E671617195
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKBXNh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 19:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKBXNb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 19:13:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62EADF3F
        for <linux-arch@vger.kernel.org>; Wed,  2 Nov 2022 16:13:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c15so284141qtw.8
        for <linux-arch@vger.kernel.org>; Wed, 02 Nov 2022 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVuco/fPOv3fEWTXwRJYz62nlQyqO6H+cs6e/gRx3vc=;
        b=bwoJSQBSGTuFi1Z2JnP4EuzofGlatFFBbp5t2OLtk5xLcsuAdIMjVYu2q+NBodmZVh
         HKKcr8Xop5vJ9wwXF6yy95UeGH7IUAKR42lQakOtgXBragSd1iAzLxEsEnWb8/BpeUeD
         AQHH2G3ajPu4F47YV3OVME+ds1L3iYcSOk6Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVuco/fPOv3fEWTXwRJYz62nlQyqO6H+cs6e/gRx3vc=;
        b=CKrOsB6qHZxaXT9zxXyqRoW3PgseC3W22w4OltcMRt7A1XaecpagwYrM+AUh1kBt9S
         h87XffiWE/XDJ3YnTeH1OQVMZ0GG8CtGgPw0LjLjN0B/ibjbx5Df7OpqsYFxDP2Zf58T
         XzAYx9rWgBa4o2V1cUALPa/pKU6oJPnzCnYB6mGol5COV1W2kO1PIkVxzoPz9b3EuouC
         cC24cBYbye/xRt6omkcNENGrQLkACSz9HW15Je1pVF1E/LAKZ7Z53PskpwIdB62TTAu3
         jQ9VjEphYCORSqGrm68+6MmcNqIcUDGmy7Y382g/XmH8zBG769PT9gM/xnrFWmwN+cJR
         W8Cg==
X-Gm-Message-State: ACrzQf3W/kn82BT4nJZyy8KvyvqW9/eN+PUBbkeWZPpFW8hCFamWV6X6
        jNb/6s6xFwWQ7x017vtgbrZnIeYDshbQ6g==
X-Google-Smtp-Source: AMsMyM6UiHMkPGL7Y390aXIbWjYsJo5zZMnq4pLTNwIKcEqw287TbCLf0KRHTb+RfB1SD383gHr/NA==
X-Received: by 2002:ac8:6e83:0:b0:3a5:1fcb:3953 with SMTP id c3-20020ac86e83000000b003a51fcb3953mr16945391qtv.373.1667430809742;
        Wed, 02 Nov 2022 16:13:29 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a0c4500b006fa22f0494bsm7817521qki.117.2022.11.02.16.13.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 16:13:29 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id z192so417750yba.0
        for <linux-arch@vger.kernel.org>; Wed, 02 Nov 2022 16:13:29 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr24282606ybu.101.1667430798577; Wed, 02
 Nov 2022 16:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com> <20221102233127.423a6112@thinkpad>
In-Reply-To: <20221102233127.423a6112@thinkpad>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Nov 2022 16:13:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtqVTvR2gZx_UgxXyx3t93a6DMmW265xbp3tbJWLxK9w@mail.gmail.com>
Message-ID: <CAHk-=wjtqVTvR2gZx_UgxXyx3t93a6DMmW265xbp3tbJWLxK9w@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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

On Wed, Nov 2, 2022 at 3:31 PM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> Just wondering a bit why you did not also add the
> VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page), like
> in the generic change.

Heh, I had considered dropping it entirely even from the generic code,
since I don't remember seeing that ever trigger, but PeterZ convinced
me otherwise.

For the s390 side I really wanted to keep things minimal since I
(obviously) didn't even built-test it, so..

I'm perfectly happy with s390 people adding it later, of course.

                Linus
