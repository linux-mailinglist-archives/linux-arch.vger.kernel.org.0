Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC944CAC
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 21:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfFMT6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 15:58:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36268 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFMT6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2019 15:58:10 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbVrD-0002N9-07; Thu, 13 Jun 2019 21:57:59 +0200
Date:   Thu, 13 Jun 2019 21:57:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCHv2 0/3] improve wait logic of stop_machine
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
Message-ID: <alpine.DEB.2.21.1906132157281.1791@nanos.tec.linutronix.de>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 13 Jun 2019, Heiko Carstens wrote:
> 
> Heiko Carstens (2):
>   processor: remove spin_cpu_yield
>   processor: get rid of cpu_relax_yield
> 
> Martin Schwidefsky (1):
>   s390: improve wait logic of stop_machine
> 
>  arch/powerpc/include/asm/processor.h |  2 --
>  arch/s390/include/asm/processor.h    |  7 +------
>  arch/s390/kernel/processor.c         | 19 +++++++++++++------
>  arch/s390/kernel/smp.c               |  2 +-
>  include/linux/processor.h            |  9 ---------
>  include/linux/sched.h                |  4 ----
>  include/linux/stop_machine.h         |  1 +
>  kernel/stop_machine.c                | 19 ++++++++++++++-----
>  8 files changed, 30 insertions(+), 33 deletions(-)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
