Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B720BE2520
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 23:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406715AbfJWVVi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 17:21:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406354AbfJWVVi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 17:21:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5FA2B148EA243;
        Wed, 23 Oct 2019 14:21:36 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:21:33 -0700 (PDT)
Message-Id: <20191023.142133.1980049426362664052.davem@davemloft.net>
To:     rppt@kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        geert@linux-m68k.org, green.hu@gmail.com, gerg@linux-m68k.org,
        deller@gmx.de, James.Bottomley@HansenPartnership.com,
        jdike@addtoit.com, kirill@shutemov.name,
        torvalds@linux-foundation.org, msalter@redhat.com,
        mattst88@gmail.com, monstr@monstr.eu, richard@nod.at,
        linux@armlinux.org.uk, sammy@sammy.net, deanbo422@gmail.com,
        Vineet.Gupta1@synopsys.com, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        rppt@linux.ibm.com
Subject: Re: [PATCH v2 09/12] sparc32: use pgtable-nopud instead of
 4level-fixup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191023195859.GA24394@rapoport-lnx>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
        <1571822941-29776-10-git-send-email-rppt@kernel.org>
        <20191023195859.GA24394@rapoport-lnx>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 23 Oct 2019 14:21:37 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 23 Oct 2019 22:59:00 +0300

> I've just discovered that I've booted qemu-sparc with the wrong kernel and
> this patch crashes miserably :(
> 
> The better version that does allow qemu-sparc to boot with folded page
> tables is below:
> 
> 
> From a90e1d157b7f8786a4276ffc8553f2167c8bc0e7 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Tue, 1 Oct 2019 17:14:38 +0300
> Subject: [PATCH v2] sparc32: use pgtable-nopud instead of 4level-fixup
> 
> 32-bit version of sparc has three-level page tables and can use
> pgtable-nopud and folding of the upper layers.
> 
> Replace usage of include/asm-generic/4level-fixup.h with
> include/asm-generic/pgtable-nopud.h and adjust page table manipulation
> macros and functions accordingly.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
