Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD481320A9F
	for <lists+linux-arch@lfdr.de>; Sun, 21 Feb 2021 14:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUNnA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 08:43:00 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:51227 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBUNm6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 08:42:58 -0500
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C7EE1100002;
        Sun, 21 Feb 2021 13:42:09 +0000 (UTC)
Subject: Re: [PATCH 0/4] Kasan improvements and fixes
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210208193017.30904-1-alex@ghiti.fr>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <24d45989-4f4e-281c-3f58-d492f0b582e9@ghiti.fr>
Date:   Sun, 21 Feb 2021 08:42:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208193017.30904-1-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Le 2/8/21 à 2:30 PM, Alexandre Ghiti a écrit :
> This small series contains some improvements for the riscv KASAN code:
> 
> - it brings a better readability of the code (patch 1/2)
> - it fixes oversight regarding page table population which I uncovered
>    while working on my sv48 patchset (patch 3)
> - it helps to have better performance by using hugepages when possible
>    (patch 4)
> 
> Alexandre Ghiti (4):
>    riscv: Improve kasan definitions
>    riscv: Use KASAN_SHADOW_INIT define for kasan memory initialization
>    riscv: Improve kasan population function
>    riscv: Improve kasan population by using hugepages when possible
> 
>   arch/riscv/include/asm/kasan.h |  22 +++++-
>   arch/riscv/mm/kasan_init.c     | 119 ++++++++++++++++++++++++---------
>   2 files changed, 108 insertions(+), 33 deletions(-)
> 

I'm cc-ing linux-arch and linux-mm to get more chance to have reviewers 
on this series.

Thanks,

Alex
