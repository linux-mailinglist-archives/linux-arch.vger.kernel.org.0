Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE003CA24B
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhGOQcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 12:32:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:49267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhGOQcN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jul 2021 12:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626366525;
        bh=OcRXNsviwurygE1IdT1yHy5S4gG5TQvirddXgjVWR/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ahJVCkm/FdLJ+4oarpCw2a+4XePCWqVQlouaDUI6/tdGqxnBbP8/PgFITy5rHbcga
         8uqxWq0Y7nCdyTmKv3EIcAiHNmtCQ1blBoOgV9gS17MoEmCAZanDHcB37MrtAdgR86
         aESs5+0bL2HMOABnhithEQnEWrawdF19GUPKgC2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1l07iv10CG-014CCP; Thu, 15
 Jul 2021 18:28:45 +0200
Subject: Re: [PATCH 0/3] Make PMD_ORDER generically available
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20210715134612.809280-1-willy@infradead.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <a79b8c48-fd45-01c5-e43d-66077c495941@gmx.de>
Date:   Thu, 15 Jul 2021 18:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715134612.809280-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FzbxmF9aOJAjtQAfd1LAp5lT41PaGd62CWt1oLdKLLTyA/85ym
 dcF5k8giMAUf3zf9laSuLN4gSjmYKGSLD3oE1kiY/UbxcJPHVQUKctMzoFKfrNRP3R+zIy/
 thjmw6XXkb/l5omb79Z9Pk3HwyuXWWnOLtjYxFVpV288Mxf3r/4ZTH6YHhPcbg7SCasRWJj
 +5iFpIwUd1wTvp7HPHFBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DUd47bxSuMk=:etFQuFQ9vUWEzcLrrLyetJ
 /jrh+n+tQHz78kCB4mVK4l2U72tvcjhI75l22QJtnVUvQ9i6jfdOrr0wgm06njaXsPstgs+M6
 0AzoQql3Bu/1fLAnF4v4c8C/z7z1Qp1fU6/XrfNDEHV0kf56nhBtrocqJFz/64QnoSDN5jy12
 QM+HGgoqPXKifReivgjchjnppJ+clrRi/qIzg4aFj6yDxIM1vLfRX+f/o6FWdPnorTP5l1+rJ
 XbRRAeFSfFOgeNZNMPRboQG8TbMMlzc1m5+lses7kAwZbwWGoF3MnVufkq6ElCJjqFnejzyL6
 vTkxvey2uILdQyIqLpOPB77gUk54S2mC6Khg5O05e0srKnPR4hNaV+m9e+2QonPSJj5F7jj+h
 Z3DzEvvMcio/DpRqD/Fnd+r+BqDEMVsZfEUXFNBNk3yoCwQiHUF3lc8oTIbpF5etoerN8NAc8
 fx/FoiLkO4IGd+8px1Fco/nnhBnYHgOdd5r2NCzqpOI+V3E1X2oFbSzkgqkmDil9BbLRnN69a
 rLmFJIhDVinVCMgPxx24qCQ4BcEI5ifQRyUy+aGQqTcsM+1a/EqWNIQ6DskNO+ee//nDB9Pz7
 HkJG8kW9rAG1FeH3ejfWtYR8/aZvFdXYe4pTfZo9uJraISaHOZ7cNuM0+nyCEjnf/7w/KdW3Z
 peEvXd6WYJ8yu46/UlIfiR6Q4Qp+sBAg2aJJ3GWg/8gE6We1MD1lziql7w591G+g/EYUT/yvu
 ju4WeZYBlDv9XNwTxP2H7qFQRnkB5YWWNh3HNlse9jxpBXBUfdcEybON6QjyOQQurzs5s+wW0
 OEJ6AZ2W+soSahrvaQ9lk4w4t+JwtEhoB42vISooj8eiT4d86SKyjc6qBp+ezDuD9JPdNqsKB
 8sWcBxy5Hk/Qfxnkpu1vFs1tuYFYqPe6JOojei99l78LVmoJDtfzPeZEkYqP1pTtgU6ugkvM6
 LY2YqQsz4B+VY2dVqFpLdrbtHi6yk23KGTotfZsRjxUGaBNbuJGI1FfmynxN/r10dLI35TUiQ
 FCGTvO2L1WZNvFhZxd/NTZG2lHTqpQ+awtLwh8Q9SH5uFeboOYCWq+c2QtTvHugpDYU5ShdeA
 sFQkr40MDgSGxKPox2HlCkwVOfl3xzCvSvS
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/15/21 3:46 PM, Matthew Wilcox (Oracle) wrote:
> These three architectures each define PMD_ORDER to mean "the order of
> an allocation for a PMD table", but logically PMD_ORDER should be the
> order of a PMD allocation, ie (PMD_SHIFT - PAGE_SHIFT) as DAX defines it=
.

Some architectures do have PGD_ORDER, PUD_ORDER and PTE_ORDER as well.
If you rename PMD_ORDER, IMHO the others should be renamed too.

Why not simply rename "PMD_ORDER" in fs/dax.c to e.g.
#define DAX_PMD_SHIFT   (PMD_SHIFT - PAGE_SHIFT)
and use that inside the dax filesystem code?

Helge

> Could each architecture maintainer please apply the appropriate patch
> to their respective trees?
>
> Matthew Wilcox (Oracle) (3):
>    arm: Rename PMD_ORDER to PMD_TABLE_ORDER
>    mips: Rename PMD_ORDER to PMD_TABLE_ORDER
>    parisc: Rename PMD_ORDER to PMD_TABLE_ORDER
>
>   arch/arm/kernel/head.S             | 34 +++++++++++++++---------------
>   arch/mips/include/asm/pgalloc.h    |  2 +-
>   arch/mips/include/asm/pgtable-32.h |  2 +-
>   arch/mips/include/asm/pgtable-64.h | 18 ++++++++--------
>   arch/mips/kernel/asm-offsets.c     |  2 +-
>   arch/parisc/include/asm/pgalloc.h  |  6 +++---
>   arch/parisc/include/asm/pgtable.h  |  4 ++--
>   arch/parisc/mm/init.c              |  4 ++--
>   8 files changed, 36 insertions(+), 36 deletions(-)
>

