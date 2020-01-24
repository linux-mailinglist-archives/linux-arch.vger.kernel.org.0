Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC7147972
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 09:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgAXIdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 03:33:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXIdP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 03:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wAaIX3Ih8IQ185qLvWSUryJc/NNBflOLyVlEkXyqLT0=; b=GxFqNFVgF5Qvy+bbO1KN26kGt
        SL3UQ4aNwRE0TNGP2OMGlr7OE2wxmVO3HGMlq6JKjBoAChHrcCEnuAaHidCMPcPHC04u+4qQ4KA06
        dQt/HDyYCp0LeSz5ulq6PS4ZzHr5adyESwAfzJTDZvxoSagc5pRBPczwQCF2VVBYWmKSszz8K2/sI
        x8hhYKHGc//wox664zNwtlRaedkEqKSCe0n6AG1568SlYZBRbaRiuNnbsr5slRXq1OpSvlAytzWBc
        s1vCNqtlavdTusKiwGBm7Ze32YHBvmRWRphmZTq+QIrupTpsUeKlhOaEE0LZzFTgnyFKg0+GTHbQn
        XlnyNwdxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuuOr-0002we-CT; Fri, 24 Jan 2020 08:33:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 538913008A9;
        Fri, 24 Jan 2020 09:31:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB2A42B715B69; Fri, 24 Jan 2020 09:33:07 +0100 (CET)
Date:   Fri, 24 Jan 2020 09:33:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Message-ID: <20200124083307.GA14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> >
> > This is version two of the patches I previously posted as an RFC here:
> 
> Looks fine to me, as far as I can tell,

Awesome, I've picked them up with a target for tip/locking/core.
