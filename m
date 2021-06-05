Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3839C444
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 02:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFEAVA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 20:21:00 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36817 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEAU7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 20:20:59 -0400
Received: by mail-pf1-f173.google.com with SMTP id c12so8621525pfl.3;
        Fri, 04 Jun 2021 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/jqiL/qTfJjmBNhopBIMzK+jxUaOluXuMLOEamwPvz4=;
        b=ooclrGet83DUu230tf4FqjEw2jni37mOcex/cGUcFjMlNdwwCLSISFDiNRYVGZ9NQA
         B4SgPsfHY6NHGf+Gp66PHRzYG/TuTxaFDmhYJhFKvW/6CFD1XZdBVUoDjbjWjY8FD6oh
         t9nz3xwRWtomGIQkOo8YDeWKAC17Y1UmYvFzpar/5hOKvXSH6R2IfU0ngKebihdFo86X
         VAWza+XExghJ6BtC+oyThvexpU6t7NfhWBExIhZJENY8GlAF6gPpaMAgdHMO2s/qUW5V
         4TnJfwhemtLgA49w4ebjwlJ4GOhiqZDiQUS6bn4D5Y2ZoQBlU7zppo8mkYcZ1Gpiybv0
         dF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/jqiL/qTfJjmBNhopBIMzK+jxUaOluXuMLOEamwPvz4=;
        b=gnCQucdFcDrP1F2BpVMaILobt73/5/WxnjYZ3JXWLZ6CqP3n9A+XM0X09FC/Mqxb3F
         lNzzNPxD56DRL39nWg6BPbn9WQzBEOJ9Sr1qjYoX/Lb8xvMjo/5+kyPupW8OPogHfX5Q
         5wMdRUp8Kh4IyQB+yFcxP27ZMYR1EfqiqUYMTh7/RWUr1Kpn0K6unwR1xBwacYMaAQL3
         CEltDlI3BOGdLGa61JA1MKOa+VYmaUEc0g15jQ/pEZr7Xl+xOIlGc6VbqBnuzOmRNAaN
         eUTGGQ8mcBJf/etv905erIa2fTmyN8i0Y86/4MAwL7pSriP9y1yR0jxJLt078SJq/x0V
         hLAA==
X-Gm-Message-State: AOAM532SmUHLPoXq+tbFoWB76KWd/4TuoM6926ypmj1S0byqubc/yHB2
        P3W6TfrRTFamnLxk4eLw6QI=
X-Google-Smtp-Source: ABdhPJxX5xGQ+5qD398du3WDmRtK/4PslOYTIhUdOtbETp67cATNtF6hZ89Y4CwdJ6aYpZEVsE0mEw==
X-Received: by 2002:a63:8c09:: with SMTP id m9mr1584275pgd.392.1622852276317;
        Fri, 04 Jun 2021 17:17:56 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id l126sm2665004pfl.16.2021.06.04.17.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 17:17:56 -0700 (PDT)
Date:   Sat, 05 Jun 2021 10:17:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/4] shoot lazy tlbs
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>
References: <20210601062303.3932513-1-npiggin@gmail.com>
        <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
        <991660c3-c2bf-c303-a55c-7454f0cc45f7@kernel.org>
In-Reply-To: <991660c3-c2bf-c303-a55c-7454f0cc45f7@kernel.org>
MIME-Version: 1.0
Message-Id: <1622851909.wxi3vcx3m8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 5, 2021 3:05 am:
> On 6/4/21 9:54 AM, Andy Lutomirski wrote:
>> On 5/31/21 11:22 PM, Nicholas Piggin wrote:
>>> There haven't been objections to the series since last posting, this
>>> is just a rebase and tidies up a few comments minor patch rearranging.
>>>
>>=20
>> I continue to object to having too many modes.  I like my more generic
>> improvements better.  Let me try to find some time to email again.
>>=20
>=20
> Specifically, this:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dx86/mm

That's worse than what powerpc does with the shoot lazies code so=20
we wouldn't use it anyway.

The fact is mm-cpumask and lazy mm is very architecture specific, so I=20
don't really see that another "mode" is such a problem, it's for the=20
most part "this is what powerpc does" -> "this is what powerpc does".
The only mode in the context switch is just "take a ref on the lazy mm"
or "don't take a ref". Surely that's not too onerous to add!?

Actually the bigger part of it is actually the no-lazy mmu mode which
is not yet used, I thought it was a neat little demonstrator of how code
works with/without lazy but I will get rid of that for submission.


> I, or someone, needs to dust off my membarrier series before any of
> these kinds of changes get made.  The barrier situation in the scheduler
> is too confusing otherwise.
>=20

I disagree, I've disentangled the changes from membarrier stuff now,=20
they can be done concurrently.

Thanks,
Nick
