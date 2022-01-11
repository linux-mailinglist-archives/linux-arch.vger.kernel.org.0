Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371D348A594
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 03:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346587AbiAKCZC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 21:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346579AbiAKCZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 21:25:01 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D5C06173F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 18:25:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w7so14928833plp.13
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 18:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=1nSGYhHp6awGMeT+4Vew5HuXwiw2XBFjZuDQom4mnVc=;
        b=kDFEy8ysPKyieBoDc7io/9sZ0SbCerAYh7rc9yDQ7cmqNe6xIbCsAUcheBXpdFEhx8
         RlAYYVDZmDT7GUNEPmdw6Tz2mSbDrZSPnBiV0OcwIvXPJ9dI//jxFzobdq1aNoS241IK
         BLXjipehxEmQeSGCu5UcGArLzUcw7utkyaFdfzOobGSWPPtWvOUgQcx5vV76DFQdjyT2
         TRXXGPlQY7FY1QfmbfyytMIQN15whWKUknzV1/oRNJa9+FpGgBpHG4qdezG8Rv3ifnlZ
         AxjydkZJxGY5pekNzpTurt6qZyem3NLL9LLmlR/yY0fBRWhXt3F3ym2Tjf5RPX08VQaE
         v9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=1nSGYhHp6awGMeT+4Vew5HuXwiw2XBFjZuDQom4mnVc=;
        b=qCMmHccHealyciJyWZZk28eX2wviVu52cYyXvZw959uUsnMNJ2UxM7o+XZ7sxxi60m
         7llplIYWhbHYxXMqe6KLYNo5ywHqYhXvpFcyI8DOkpzEWdxGOdWQQCOqC5giJOj2IEOw
         ZOU1uEChGLH2UaykAZ53jaTMVs3B858riI45H+F/H9bwvnvdAxqO/oqhmMe3WVv02D3C
         OMRXUtXT7WzB0PFnGduYYNvPj0ewlO248V6n8ryqq4wFg3jvBtZDqjZjCPwSfeKqjgIz
         Td3szfsxN/sSk5gJDkAqjVUE5PYcfyhTlvTt87HRJa98FCbcruNwAhyN9rwQGqdDedAt
         PSDw==
X-Gm-Message-State: AOAM531CzMx0YYvO1M73x/6hBmX4B8NaDABg8j2jpbWrjZWO11K02mVF
        JXt9dW47QI4IxwmXcrqNTdk=
X-Google-Smtp-Source: ABdhPJyRpojrUNiFPVD5I45rygGKiOTmajqSsgVpMyce095UmYc7P4v0rn9U8PDDl607h9zaAvQ4uQ==
X-Received: by 2002:a17:902:6906:b0:149:7087:355c with SMTP id j6-20020a170902690600b001497087355cmr2189351plk.153.1641867901044;
        Mon, 10 Jan 2022 18:25:01 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id kb1sm318355pjb.56.2022.01.10.18.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 18:25:00 -0800 (PST)
Date:   Tue, 11 Jan 2022 12:24:55 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
        <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
        <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
        <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
        <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
        <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
        <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
        <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
        <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
        <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
        <1641790309.2vqc26hwm3.astroid@bobo.none>
        <1641791321.kvkq0n8kbq.astroid@bobo.none>
        <CAHk-=whX3cMJ30ZwX+BUJm8Eov3Ae3C76Ba51FAzX4nJz24Kmg@mail.gmail.com>
In-Reply-To: <CAHk-=whX3cMJ30ZwX+BUJm8Eov3Ae3C76Ba51FAzX4nJz24Kmg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1641867685.59h0j3zwhw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Linus Torvalds's message of January 11, 2022 3:19 am:
> On Sun, Jan 9, 2022 at 9:18 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> This is the patch that goes on top of the series I posted. It's not
>> very clean at the moment it was just a proof of concept.
>=20
> Yeah, this looks like what x86 basically already effectively does.
>=20
> x86 obviously doesn't have that TLBIE option, and already has that
> "exit lazy mode" logic (although it does so differently, using
> switch_mm_irqs_off(), and guards it with the 'info->freed_tables'
> check).
>=20
> But there are so many different possible ways to flush TLB's (the
> whole "paravirt vs native") that it would still require some
> double-checking that there isn't some case that does it differently..

Oh yeah x86 needs a little porting to be able to use this for sure,
but there's no reason it couldn't do it.

Thanks,
Nick
