Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202B6313F8F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 20:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhBHTvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 14:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236330AbhBHTtj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 14:49:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92C1164E56;
        Mon,  8 Feb 2021 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612813738;
        bh=fiMaPfVra/2zEjkMsZvR8Iyt6gmFiqnTTP4gAMQuARo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTPknMTmNhE9DO36kKtRa7zJ2V5noBJBWB2U8EeHHO6MU76BZaAVYfbCCxMvHgNBe
         D9LD+e3ehRFEhc2ZrcI+BLv11Pnzl/dtrwDbc4XJxBZvLi6h/tH+YlaYJANtx/m19P
         UJTMWWsq4MxVBfXOB4lIOm65+CDZrCHF8dJc4vfc=
Date:   Mon, 8 Feb 2021 11:48:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huang Pei <huangpei@loongson.cn>, ambrosehua@gmail.com,
        Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
Message-Id: <20210208114856.e8062823b2e84e1adb1d59bb@linux-foundation.org>
In-Reply-To: <30b3fcb5-a60d-228f-15d2-cd182953de45@csgroup.eu>
References: <20210204013942.8398-1-huangpei@loongson.cn>
        <20210204152239.GA14292@alpha.franken.de>
        <20210205154105.32bb13df439aa49b7fc167e7@linux-foundation.org>
        <30b3fcb5-a60d-228f-15d2-cd182953de45@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 8 Feb 2021 18:44:22 +0100 Christophe Leroy <christophe.leroy@csgrou=
p.eu> wrote:

>=20
>=20
> Le 06/02/2021 =E0 00:41, Andrew Morton a =E9crit=A0:
> > On Thu, 4 Feb 2021 16:22:39 +0100 Thomas Bogendoerfer <tsbogend@alpha.f=
ranken.de> wrote:
> >=20
> >> On Thu, Feb 04, 2021 at 09:39:42AM +0800, Huang Pei wrote:
> >>> MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
> >>> + 2 TLB Invalid), butthe second TLB Invalid exception is just
> >>> triggered by __update_tlb from do_page_fault writing tlb without
> >>> _PAGE_VALID set. With this patch, user space mapping prot is made
> >>> young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
> >>> and it only take 1 TLB Miss + 1 TLB Invalid exception
> >>>
> >>> Remove pte_sw_mkyoung without polluting MM code and make page fault
> >>> delay of MIPS on par with other architecture
> >>>
> >>> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> >>> ---
> >>>   arch/mips/mm/cache.c    | 30 ++++++++++++++++--------------
> >>>   include/linux/pgtable.h |  8 --------
> >>>   mm/memory.c             |  3 ---
> >>>   3 files changed, 16 insertions(+), 25 deletions(-)
> >>
> >> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> >>
> >> Andrew, can you take this patch through your tree ?
> >=20
> > Sure.  I'll drop Christophe's "mm/memory.c: remove pte_sw_mkyoung()"
> > (https://lkml.kernel.org/r/f302ef92c48d1f08a0459aaee1c568ca11213814.161=
2345700.git.christophe.leroy@csgroup.eu)
> > in favour of this one.
> >=20
>=20
> Pitty. My patch was improving page faults on powerpc/32.

How does it do that?  By running pte_mkyoung() for powerpc32?  Such a
change is still valid, isn't it?

> That one is only addressing MIPS.

It cleans up core code nicely, by removing a MIPS wart.  We can still
add a ppc32 wart?

>=20
> Any plan to take the series from Nick=20
> https://patchwork.kernel.org/project/linux-mm/list/?series=3D404539 ?

I expect so.  After -rc1, if the churn is settling down and reviewers
are happy enough.
