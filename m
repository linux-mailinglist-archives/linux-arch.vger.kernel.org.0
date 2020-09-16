Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068026C553
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIPQuz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 12:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgIPQd2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1D8222D5
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2020 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264365;
        bh=mDQ6UTyuaB2u7tLV1Dk8pnrUM2PuADeCLe8cuMXZ8Vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shzyBlLOTXJhv5uEUP9a13eFHZuifidHaD+0Pw/Hi7w8rSPCDS/1+xVICGYgHQO1t
         yWiuYXtowmBQWAofGCYH6UiS3gBJACYqp2KHBVBI+X+mu3S/hxBalizuzm6GbgirpV
         7jH2jFQnS52R+Ljtb6AZnvYViY3zCuRFbinq4Hzc=
Received: by mail-wr1-f49.google.com with SMTP id t10so7056304wrv.1
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2020 06:52:44 -0700 (PDT)
X-Gm-Message-State: AOAM532OgGV6CXs12E8x7mJcn7+vQSVtPcb9soRVEXLUXtioBKRTn534
        QpPuIik+NZqcbw7YTRy3G+Jlfc3qzgkyyXxMsbaJqQ==
X-Google-Smtp-Source: ABdhPJxD/I3WhheFm3L0eJSqFjhj5WfUh9gRyFn04NLA/7Rn8UKNcJjJ0TVa6hRJJ0zHq7OYjPoH15YRyOrXg65QVEw=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr26717007wrt.70.1600264363439;
 Wed, 16 Sep 2020 06:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com> <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com> <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
 <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
 <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com> <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
 <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com> <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
 <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com> <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
 <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com> <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
 <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com> <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
 <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
 <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com> <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
 <c61c9bf3-4097-089c-4e6d-d0ae0e4480f3@intel.com>
In-Reply-To: <c61c9bf3-4097-089c-4e6d-d0ae0e4480f3@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Sep 2020 06:52:31 -0700
X-Gmail-Original-Message-ID: <CALCETrXGSXzqdAOK7tnDDYMJ5Uj4=u=AEvgdroS3BxRoyO3r+g@mail.gmail.com>
Message-ID: <CALCETrXGSXzqdAOK7tnDDYMJ5Uj4=u=AEvgdroS3BxRoyO3r+g@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 2:14 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/14/20 11:31 AM, Andy Lutomirski wrote:
> > No matter what we do, the effects of calling vfork() are going to be a
> > bit odd with SHSTK enabled.  I suppose we could disallow this, but
> > that seems likely to cause its own issues.
>
> What's odd about it?  If you're a vfork()'d child, you can't touch the
> stack at all, right?  If you do, you or your parent will probably die a
> horrible death.
>

An evil program could vfork(), have the child do a bunch of returns
and a bunch of calls, and exit.  The net effect would be to change the
parent's shadow stack contents.  In a sufficiently strict model, this
is potentially problematic.

The question is: how much do we want to protect userspace from itself?

--Andy
