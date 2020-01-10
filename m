Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619081374E6
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 18:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgAJRfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 12:35:22 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgAJRfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 12:35:21 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MpUEO-1jSHYK0bsK-00pwv1; Fri, 10 Jan 2020 18:35:20 +0100
Received: by mail-qv1-f49.google.com with SMTP id o18so1098049qvf.1;
        Fri, 10 Jan 2020 09:35:19 -0800 (PST)
X-Gm-Message-State: APjAAAVMI5Ojdl+ku5tFrFPiY2uMT0tHB6T3uORVdrK9aLnO332pifmV
        CkjnUF8ZbjDuBgmpMRa35fsDLswLyNaLa4qBnBU=
X-Google-Smtp-Source: APXvYqwWYC8X5W9oF1BgBx7VL/oeohJqrxVJjUso79ib5qHjpCfx0eXAy0BECqjDUxdnwEFL4yYFEX7TreByyDcsQXQ=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr3587885qvi.211.1578677718911;
 Fri, 10 Jan 2020 09:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-2-will@kernel.org>
In-Reply-To: <20200110165636.28035-2-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 18:35:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Message-ID: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qNB50QxgYN6IoCxuOP5OUw+kvbtvU6FPj70Xpb3YkQHBzhScfGA
 LOMjhVZaQYk/fRyYSVS9s1D/Kmeo6MrkW8Aq1WdR4Wfdv9Scag4ZUTOzAOR1vgrr9AUlt83
 NY4NgdMcX19Mmlx3uTymSbSJgoJIzd52ABKIauuObzBFHnc5hXJUD1D5eN7fpgO4dTRkwG6
 XEdZii3mwfxOLHxIhyo1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CNzi4tqatmQ=:jzKjyLV2MH9toF091jMUH1
 fYjwg7S1fuz8OVlWZbAZGM4es6TRvOgGYR7sHf4rWV5n+hIEuZi91Vaq6jGL9kagYQ9NLmEq9
 FBjgN6spbsBkj4MZDF5+YKGqHJRPRwK6UTJqfdpEuozHAwLB0M8jcInrPgjaPAw3G3HPX/QEo
 k73XO1lVNh5Ng0SBLzEpG0B5dRVsaJnRUxs10AARwrlV/E+gpP+J2CrfQknVHfivI94p45ySY
 PNPlSJkLLjss/0dsWg8naPU1qM99iqw7Ag/75m4d+K0ABtHaszeDX3kky0xjPx/YDt/V9Eh2F
 ea2w2R7po3V6RglU295cXIZdMYmJ96wobdGePg5TyRsQE7lc6d0gab5QmW/Mjy2PGxsxvm96s
 Hp+71pBDybruMVKadfhIiqTxdKBB+Vfuh7XanlbBR7ZQT2aeoGGWtjuAW0M3Ppsnc6BfrkRr2
 mnLQj1DIqq+DmKV5VDOs+fiZjoKGpAOzcWSJOwzMV0fhnPZiO8cayZEbFQ8XH1AELO1hTN1LV
 8EJADa6DdyTKUZJycTto7i8nOK8Vdf6DuDUirOsN+1ZM1EMc+5JqL52QsaN2OkYqIXLcmLhKh
 GZRIa44knC7tG+KYwI8Huu2DYVRg+aEiPRURxcfeD+mpb3MKB74mRvJqZDIpOwFJ8IplSiHBk
 dPE3lQ+6FcquEI627fFEoIJsABZeujtF8isG8r1fobh3K5TtOwzzM3pGiwmy9h6Kpm0mF2OMj
 kGaQSWFh3pU8IVPF1lckMoRCfNSLlmXU+tsE0JzmE95FpU80oL9i4gnV/6W7Mh0xrq85wAWLX
 58z6fxPmwgsziqqRxrXDEK8tdPzbXWMsaLPRLhPrcUaMcsmaaUzIo090Id5gpTMU9jTdEhV2+
 tEMC4WG5Yqp66hDTda7w==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
>
> Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> discarding the 'volatile' qualifier:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> We've been working around this using some nasty hacks which make
> READ_ONCE() both horribly complicated and also prevent us from enforcing
> that it is only used on scalar types. Since GCC 4.8 is pretty old for
> kernel builds now, emit a warning if we detect it during the build.

No objection to recommending gcc-4.8, but I think this should either
just warn once during the kernel build instead of for every file, or
it should become a hard requirement.

       Arnd
