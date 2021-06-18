Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9998F3AD124
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhFRR2p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 13:28:45 -0400
Received: from mail.efficios.com ([167.114.26.124]:48982 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFRR2o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 13:28:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7AEE0345C4E;
        Fri, 18 Jun 2021 13:26:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TuF5gIHS_P9W; Fri, 18 Jun 2021 13:26:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 39D64346030;
        Fri, 18 Jun 2021 13:26:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 39D64346030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1624037193;
        bh=RVU1L7Bs5o8SF/s3fQLWZ2mgUojZ65JgsimVBayw7WM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QxaZv37PI2T8k93cxNlviHuor7Eo1jdIh84JQW8lKtRqEnYg+leveVO3V0WFWrykT
         MvqRXaDcPeJ0eAiUxm+yvxtY3zYscfcARDn2rN0ViMIPWwVcsj7n0OufUs3b9Z1+9R
         oEl+McAQbfLVbznVaLyI+IjT8OEOZRe3hMWnqTSYXPrFjcy1639fmawQUsbPISdolV
         vzjbXySgml575Cim3yIEQOpynXR/OAVs0L+ob5PmJZT2AamgShg4nH+wblsIvv+a9o
         2rIOi5IDZ47uAsVlnSrTmJsFS38xpSUbGgJqwa7YawAOIt4JkaTWO/VI7k6xNPxC35
         h+2QpUFHgBE5Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aQITEBiYLT6c; Fri, 18 Jun 2021 13:26:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1BA0A346100;
        Fri, 18 Jun 2021 13:26:33 -0400 (EDT)
Date:   Fri, 18 Jun 2021 13:26:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        maged michael <maged.michael@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        David Sehr <sehr@google.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        Andrew Hunter <ahh@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <2077369633.12794.1624037192994.JavaMail.zimbra@efficios.com>
In-Reply-To: <8b200dd5-f37b-b208-82fb-2775df7bcd49@csgroup.eu>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com> <20180129202020.8515-3-mathieu.desnoyers@efficios.com> <8b200dd5-f37b-b208-82fb-2775df7bcd49@csgroup.eu>
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Topic: powerpc: membarrier: Skip memory barrier in switch_mm()
Thread-Index: CQE5LhemvVU5Lc+W1e2QOiB/EG3b7A==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jun 18, 2021, at 1:13 PM, Christophe Leroy christophe.leroy@csgroup.eu wrote:
[...]
> 
> I don't understand all that complexity to just replace a simple
> 'smp_mb__after_unlock_lock()'.
> 
> #define smp_mb__after_unlock_lock()	smp_mb()
> #define smp_mb()	barrier()
> # define barrier() __asm__ __volatile__("": : :"memory")
> 
> 
> Am I missing some subtility ?

On powerpc CONFIG_SMP, smp_mb() is actually defined as:

#define smp_mb()        __smp_mb()
#define __smp_mb()      mb()
#define mb()   __asm__ __volatile__ ("sync" : : : "memory")

So the original motivation here was to skip a "sync" instruction whenever
switching between threads which are part of the same process. But based on
recent discussions, I suspect my implementation may be inaccurately doing
so though.

Thanks,

Mathieu


> 
> Thanks
> Christophe

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
