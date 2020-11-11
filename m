Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C232AF267
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKKNpE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 08:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKNoj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2020 08:44:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6AC0613D1;
        Wed, 11 Nov 2020 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=g1I41NQbwOIjGBdwjkC+j3mhwkFAgihVuGwfeKOpVXw=; b=rzNsu/t5CsZEaMWoYXHzDbNrPL
        /TAv4GnYapw/nguBJc/zUT6Iv6zn+HStz9N+isLCC57QHu+J6pG15Djaz3zcKpfAbyPp/kSlEaa3W
        mEbFjlVD+sJU7HecHv2/8dQq6r0tSBizpXPqf3dISnGaOJKD8jk4j/JfAwfIhV//EaUaJPiDZnprs
        36YVfqJuWOvquFAkXNiPDWzE5spUp9Bm9cqOmy7E735N2Z9bVxucoC+VF7FfvHug3zuqqoZvTdl+W
        0JzO6UOZENZZWndygSO5ujxeVcZ8pcVOPDG434D8SY+GvGbqGm7ztvF0fyIVm6ToWlsqLr/y/rmPk
        BTx/HJEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcqQ4-0007Ne-3t; Wed, 11 Nov 2020 13:44:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77B7C300238;
        Wed, 11 Nov 2020 14:44:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 619C42BDF9699; Wed, 11 Nov 2020 14:44:12 +0100 (CET)
Date:   Wed, 11 Nov 2020 14:44:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] asm-generic/atomic64: Add support for ARCH_ATOMIC
Message-ID: <20201111134412.GT2611@hirez.programming.kicks-ass.net>
References: <20201111110723.3148665-1-npiggin@gmail.com>
 <20201111110723.3148665-2-npiggin@gmail.com>
 <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 11, 2020 at 02:39:01PM +0100, Christophe Leroy wrote:
> Hello,
> 
> Le 11/11/2020 à 12:07, Nicholas Piggin a écrit :
> > This passes atomic64 selftest on ppc32 on qemu (uniprocessor only)
> > both before and after powerpc is converted to use ARCH_ATOMIC.
> 
> Can you explain what this change does and why it is needed ?

That certainly should've been in the Changelog. This enables atomic
instrumentation, see asm-generic/atomic-instrumented.h. IOW, it makes
atomic ops visible to K*SAN.
