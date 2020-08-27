Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32D254614
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgH0Ngt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgH0NaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 09:30:00 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B519C061264;
        Thu, 27 Aug 2020 06:29:34 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q14so4866839ilm.2;
        Thu, 27 Aug 2020 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1eAOelctVCvY77k8DvCiSb45R7pJeCygwUiBKj7ylk=;
        b=KslTWM9QTJseKIfQwHyWHYzO4E5V9sz2t0NyQsA+FDYjpJCmberK6r1gK12Pgz7ApG
         aDRwPZnol6vii9x/7psJIZV393QKixDz1vAY5VufdD1L2su0SUGkwUlRjU+kIvkyaGeX
         Xv8Br1OD+OGHSOURsNHIRwVwsadKMnBFpOnlxRBsCEEgk1lMeHMMHZ0uQhY1oocrLzWi
         f/rA2Hze5ic1kTmDnRtSGdsXY7KvtyU0pyWGbPW8qRtEEs8k8OGmLcihOh2a3jLqA/qB
         uaMIxIHMpX9L2puZNu+odYcuv70ElOGc8HwsG1KQOmikZX/84mWmxEypdCTcjsiLCsJ6
         4ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1eAOelctVCvY77k8DvCiSb45R7pJeCygwUiBKj7ylk=;
        b=UlGq8Xnd9xsDahH2Mgdq/GzST7GmqsZywZefLFD9KpOqNC+rB4PnU6Ay3EnYbITqGB
         SY/aUIvshFrJX5XIIVYwUc5IXDdsWJyB3jbbgWOHfUMD4ALfu9sAeerv7IlGFr7LY8lA
         zaa6wvFZhWaFH2bBhjmzdAw5/WNenH5hjq/M81ALBDgD2tRZKfqCrLfB0fqMPuN/KQ5c
         cRq4h9u/qZUPblJBdfKGWqomiovBFH162VKBw22T65KwMPnx/QePGBZhnCfDUf+TUcrC
         Ao7Uw2wf9VumATPZ/yWGyJg6EEkEez1Kdc7UGqXZFc/Wl1bsa90eGA6OgPAWmWZa/v/f
         TCdw==
X-Gm-Message-State: AOAM5324iIiz89iwAdftJxVED2a9cujh6o4vIdIAfq5Qhob08Xu89lWV
        631jh+dF7FFuEb+M2TXa9nF5Ipa0jlDdI49U1Mc=
X-Google-Smtp-Source: ABdhPJyQLY6lTLiuO3mJecjMx6O2y5je1nGXqCTrwwhTyAqqzE4XE1LtMK86oX32gT+TP8wOjBG4bYwXxAka9F8rhOw=
X-Received: by 2002:a92:6a09:: with SMTP id f9mr473727ilc.273.1598534972117;
 Thu, 27 Aug 2020 06:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002540.3351-1-yu-cheng.yu@intel.com> <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com> <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com> <20200826170841.GX6642@arm.com> <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 27 Aug 2020 06:28:56 -0700
Message-ID: <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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

On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Dave Martin:
>
> > You're right that this has implications: for i386, libc probably pulls
> > more arguments off the stack than are really there in some situations.
> > This isn't a new problem though.  There are already generic prctls with
> > fewer than 4 args that are used on x86.
>
> As originally posted, glibc prctl would have to know that it has to pull
> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
> then the u64 argument is a problem for arch_prctl as well.
>

Argument of ARCH_X86_CET_DISABLE is int and passed in register.

-- 
H.J.
