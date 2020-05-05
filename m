Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432681C4F74
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 09:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgEEHpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 03:45:35 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:44441 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgEEHpf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 03:45:35 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 952322031A;
        Tue,  5 May 2020 09:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1588664732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRlYwnUotJRwG1fODwUXaPGeabpY24uzMQlWv3nM2r8=;
        b=S73C0KmoVleZlYJilU8Uqu2eiS6otaGYIo8y92wkWgGAgGxJwZLGmRMOWq4nGMlkCnb76/
        FasObeFVVZDYXUbQ1xKr9Ghr+aHX7PQYNbe0CjdChxtzusNTXoNeXUnz18B6kgpCg/rDcA
        jwkzzEm2pTA5avxCjtYMUc/0pa11BAf2Wp+XpCK61S3Cf13gQfB+5+ZgAFT+KcdM+mhOwd
        rRaXobP/vtfyCbvQBIZ1ukkwU4thmsIDpj/wCvJTXEu4yVlm4XesCZ4xt+ScbQgv5paHMZ
        zYiwuP2Qe/yQORzmCtPtMaPz/8kg/DGUTZSj4HvOAd/oDrw2ysg2xynk2DRqPg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Tue, 5 May 2020
 09:45:32 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Tue, 5 May 2020 09:45:32 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Dave Martin <Dave.Martin@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: AW: Adding arch-specific user ABI documentation in linux-man
Thread-Topic: Adding arch-specific user ABI documentation in linux-man
Thread-Index: AQHWIik/BJ/oVWzXakumst0NY4Xe3KiZGO3j
Date:   Tue, 5 May 2020 07:45:32 +0000
Message-ID: <32259f3763344500a058a8ca8a3a33d8@bfs.de>
References: <20200504153214.GH30377@arm.com>
In-Reply-To: <20200504153214.GH30377@arm.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=1.19
X-Spam-Level: *
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [1.19 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-0.31)[75.37%];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.898];
         FREEMAIL_TO(0.00)[arm.com,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,
you are pointing to an (IMHO) interesting question.
How to document different CPUs ?
Given that an operating system should hide the different CPU's using
CPU specific features should be used sparsely at best.

the easy part are adds-on like flags for prctrl etc. simply add it to the p=
age.

Other things should go to a cpu specific pages (can of worms). The problem =
will
be to keep that small but informative. I have no idea about the level of de=
tail
(and i have worked with a range of CPUs) that could be interesting for a pr=
ogrammer.
An of cause every other CPU now needs also a page.

jm2c
 wh
________________________________________
Von: linux-man-owner@vger.kernel.org <linux-man-owner@vger.kernel.org> im A=
uftrag von Dave Martin <Dave.Martin@arm.com>
Gesendet: Montag, 4. Mai 2020 17:32:35
An: Michael Kerrisk
Cc: Catalin Marinas; Will Deacon; Vincenzo Frascino; linux-man@vger.kernel.=
org; linux-arch@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Betreff: RFC: Adding arch-specific user ABI documentation in linux-man

Hi all,

I considering trying to plug some gaps in the arch-specific ABI
documentation in the linux man-pages, specifically for arm64 (and
possibly arm, where compat means we have some overlap).

For arm64, there are now significant new extensions (Pointer
authentication, SVE, MTE etc.)  Currently there is some user-facing
documentation mixed in with the kernel-facing documentation in the
kernel tree, but this situation isn't ideal.

Do you have an opinion on where in the man-pages documentation should be
added, and how to structure it?


Affected areas include:

 * exec interface
 * aux vector, hwcaps
 * arch-specific signals
 * signal frame
 * mmap/mprotect extensions
 * prctl calls
 * ptrace quirks and extensions
 * coredump contents


Not everything has an obvious home in an existing page, and adding
specifics for every architecture could make some existing manpages very
unwieldy.

I think for some arch features, we really need some "overview" pages
too: just documenting the low-level details is of limited value
without some guide as to how to use them together.


Does the following sketch look reasonable?

 * man7/arm64.7: new page: overview of arm64-specific ABI extensions

 * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
   overview of arm64 SVE ABI

 * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
   arm64 ptrace extensions

 * man2/mmap.2: extend with arm64-specific flags (only two flags, so we
   add them to the existing man page rather than creating a new one).

etc.


Ideally, I'd like to adopt a pattern that other arches can follow.

Thoughts?

Cheers
---Dave
