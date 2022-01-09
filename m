Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A04A488863
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiAIItK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiAIItJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 03:49:09 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95AC06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 00:49:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s1so8648852pga.5
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o9EmHZcSICKN316fHMY91MizRyPQShQCNbAS0hB713c=;
        b=XYpfUt383JWJwGaKWZpAKdo+YiAFBQ5m/K4QI6Tne9Whlr0hkgZwS9tvANsRb4ENTK
         jqvkZCoyQRExqElL0pgO2DleCTZSlnnSXQmS057zcjyB4kw7w3ARhRZm1fiBg7jH9GtL
         zCJuzLANVVdTJ5pFBLn0d62zhCCUj80qr1QlwnNxiiJ/HtKz8soDFznLgZ5UMiVAsu33
         pdRL0eImc8vQlH3I6U96B+8mD0nSeyA23HgCDOCyXNqzdHLlOMXXcNr2MlFkSflf7y5Z
         G584l0qyC8KYW+kJZDfa69zndj+MqgtypqUHo9pmUonJ/9/st8mCX14r5ooGHskfg/WC
         vs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o9EmHZcSICKN316fHMY91MizRyPQShQCNbAS0hB713c=;
        b=IRxtdG8YSwviNN3U8Fz0+l2LnWbxPgASjSAV36Y3JWdMPVEieBmlMpHGNfJJIviRES
         iebvzkvKbxcAcw8ewldGVvSaQSDzUNCJppKb3oQd0ODY4cNFB2ng3plApNbAYBJR3lx/
         vGbp6fm04pwCLmlixHK1cZxT4yo6qvhGWyMFPE3YXGc+LNmWgQ+gzqelfwsVSfbEGB2V
         K5wUH2/bCFKrPS8DNrbVEcMe/pnayCyKRnq/HiCujoyYoSXW8nK0AdhjTsgH9/fg06cH
         VjMPzm8+U+V+ukJN3p56bPRKTmfmiwgIGIPJb+zhgTtb/wAE2U6VriZrCmwPjnMK55pJ
         jrEA==
X-Gm-Message-State: AOAM533+Jd6j8TBpyrseHAgsUXXFWNwZUKR264OTdp2eJ1J1cKxlpBck
        rV4BLUg4bJweKGy2UJua48dtrNz4pN8=
X-Google-Smtp-Source: ABdhPJw54hlsdqK5QlC8xHoSFSJbx4qK6uGUtHw76Ab4RaLHRTPSSAtuWGbuy+FRrO+Ni/5OI8XHmw==
X-Received: by 2002:a63:9544:: with SMTP id t4mr4391363pgn.175.1641718148228;
        Sun, 09 Jan 2022 00:49:08 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id x19sm2545676pgi.19.2022.01.09.00.49.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 00:49:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
Date:   Sun, 9 Jan 2022 00:49:06 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
 <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 8, 2022, at 10:48 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Sat, Jan 8, 2022 at 9:56 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>=20
>> Just wondering: In a world of ASID/PCID - does the =E2=80=9Clazy =
TLB=E2=80=9D really
>> have a worthy advantage?
>>=20
>> Considering the fact that with PTI anyhow address spaces are switched
>> all the time, can=E2=80=99t we just get rid of it?
>=20

[snip]

>=20
> Or maybe it's only worth it on platforms where it's free (UP, possibly
> other situations - like if you have IPI and it's "free").

On UP it might be free, but on x86+IPIs there is a tradeoff.

When you decide which CPUs you want to send the IPI to, in the
common flow (no tables freed) you check whether they use
=E2=80=9Clazy TLB=E2=80=9D or not in order to filter out the lazy ones. =
In the
past this was on a cacheline with other frequently-dirtied data so
many times the cacheline bounced from cache to cache. Worse, the
test used an indirect branch so was expensive with Spectre v2
mitigations. I fixed it some time ago, so things are better and
today the cacheline of is_lazy should bounce less between caches,
but there is a tradeoff in maintaining and checking both cpumask
and then is_lazy for each CPU in cpumask.

It is possible for instance to get rid of is_lazy, keep the CPU
on mm_cpumask when switching to kernel thread, and then if/when
an IPI is received remove it from cpumask to avoid further
unnecessary TLB shootdown IPIs.

I do not know whether it is a pure win, but there is a tradeoff.=
