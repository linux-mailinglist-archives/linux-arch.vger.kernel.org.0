Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B896220CD
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 01:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKIA2s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 19:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIA2m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 19:28:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E961EECC;
        Tue,  8 Nov 2022 16:28:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k5so15257523pjo.5;
        Tue, 08 Nov 2022 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJmmnqUvoyru+n8wHlQaiVa6vQcrmOu462lEVViJXgI=;
        b=KSHV0LcwnvHiZhQdBGTXtkZYIUy2TxwG8QwilhYNrzZOWC0d6o7RX4MmlF9gxXmG/Q
         DX8QyYM9KoBIK3AAhdyT8aXoIrak7upCSUP4haa8cnFheAjA8Vg0H9C1MfHrDCENiEVZ
         i4DKlHxqjIiWH8h6IvDHbxgMdXbNRpgjLRbRSA7f3+DfoOyqUAnHIwqjA8WkKZcH0wYi
         427N2SIBRCimG81YcJkEXBVc/af7z1om+njP3YzflpbKr/ZCoYj+3eueJIdVyIS6Qynn
         I0GxmJ/YAdQIQ50ALzLVdOZbDXb7ToncG+fOccgLGZHsRd5cAPBIlFRSRIwyQhu6A5OA
         kO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJmmnqUvoyru+n8wHlQaiVa6vQcrmOu462lEVViJXgI=;
        b=3dcTkB0g4+bIMMQR6UwqtPWTqpl5kAYmIvggvGnY1ctsERIe6IEeKcJG/lrncga7Gh
         lQLnJnNzKvGNjfmaos+0z5JXOSCE3R3Cdvp35yvy39AGaADNxnjIVBeS/+yA6hxeHahh
         c1FLTvn7SbWj0PTpFeuOIyRhiaRWnwvw+QtokaBB4x01s4rVGj35/PNmJF27EwZYtauP
         TAZj2dHLBPjJ54KVZB0wwx7t2hneEZyMZ/bzCB27S3NQkZlVB81Yk187Km4cukw78spK
         Tic4a3ThHXC9qq4ro/E2uNojfxOFPs0K8I6f4rRnSIMeb8mbhuszy3u1W4nVE+ergS3Q
         sU0Q==
X-Gm-Message-State: ACrzQf0AQiMkdIAUyiKUS58XOkHv7uEv4dc6Mv9cmD7jwP7i6/nfuPfB
        luYV9EEbr1HCLV4zRATfne8=
X-Google-Smtp-Source: AMsMyM4KKKbhmuUvKLrjrLeaBbVnfWO6bDYum8llPRbQoWUgx9/PBMhacf2N83VBuHJxTZfZKp5pUw==
X-Received: by 2002:a17:90b:d88:b0:211:4d8:1c93 with SMTP id bg8-20020a17090b0d8800b0021104d81c93mr76224284pjb.41.1667953720822;
        Tue, 08 Nov 2022 16:28:40 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090a474400b002135e8074b1sm8421250pjg.55.2022.11.08.16.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 16:28:40 -0800 (PST)
Message-ID: <e43b20a4-58f9-1f0e-cd08-9defd494c49f@gmail.com>
Date:   Wed, 9 Nov 2022 09:28:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: io_ordering.rst vs. memory-barriers.txt
To:     Tony Battersby <tonyb@cybernetics.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <1924eda8-aea6-da64-04a7-35f3327a7f4f@cybernetics.com>
 <bb6dfd57-0a46-9aa5-050f-40e207bd44f4@cybernetics.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <bb6dfd57-0a46-9aa5-050f-40e207bd44f4@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tony,

On Tue, 8 Nov 2022 18:07:37 -0500, Tony Battersby wrote:
> (resending in plaintext; damn Thunderbird upgrades...)
> 
> While looking up documentation for PCI write posting I noticed that the
> example in Documentation/driver-api/io_ordering.rst seems to contradict
> Documentation/memory-barriers.txt:
> 
> -----------
> 
> Documentation/driver-api/io_ordering.rst:
> 
> On some platforms, so-called memory-mapped I/O is weakly ordered.  On such
> platforms, driver writers are responsible for ensuring that I/O writes to
> memory-mapped addresses on their device arrive in the order intended.  This is
> typically done by reading a 'safe' device or bridge register, causing the I/O
> chipset to flush pending writes to the device before any reads are posted.  A
> driver would usually use this technique immediately prior to the exit of a
> critical section of code protected by spinlocks.  This would ensure that
> subsequent writes to I/O space arrived only after all prior writes (much like a
> memory barrier op, mb(), only with respect to I/O).
> 
> A more concrete example from a hypothetical device driver::
> 
> 		...
> 	CPU A:  spin_lock_irqsave(&dev_lock, flags)
> 	CPU A:  val = readl(my_status);
> 	CPU A:  ...
> 	CPU A:  writel(newval, ring_ptr);
> 	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
> 		...
> 	CPU B:  spin_lock_irqsave(&dev_lock, flags)
> 	CPU B:  val = readl(my_status);
> 	CPU B:  ...
> 	CPU B:  writel(newval2, ring_ptr);
> 	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
> 		...
> 
> In the case above, the device may receive newval2 before it receives newval,
> which could cause problems.  Fixing it is easy enough though::
> 
> 		...
> 	CPU A:  spin_lock_irqsave(&dev_lock, flags)
> 	CPU A:  val = readl(my_status);
> 	CPU A:  ...
> 	CPU A:  writel(newval, ring_ptr);
> 	CPU A:  (void)readl(safe_register); /* maybe a config register? */
> 	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
> 		...
> 	CPU B:  spin_lock_irqsave(&dev_lock, flags)
> 	CPU B:  val = readl(my_status);
> 	CPU B:  ...
> 	CPU B:  writel(newval2, ring_ptr);
> 	CPU B:  (void)readl(safe_register); /* maybe a config register? */
> 	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
> 
> Here, the reads from safe_register will cause the I/O chipset to flush any
> pending writes before actually posting the read to the chipset, preventing
> possible data corruption.
> 
> -----------
> 
> Documentation/memory-barriers.txt:
> 
> ==========================
> KERNEL I/O BARRIER EFFECTS
> ==========================
> 
> Interfacing with peripherals via I/O accesses is deeply architecture and device
> specific. Therefore, drivers which are inherently non-portable may rely on
> specific behaviours of their target systems in order to achieve synchronization
> in the most lightweight manner possible. For drivers intending to be portable
> between multiple architectures and bus implementations, the kernel offers a
> series of accessor functions that provide various degrees of ordering
> guarantees:
> 
>  (*) readX(), writeX():
> 
> 	The readX() and writeX() MMIO accessors take a pointer to the
> 	peripheral being accessed as an __iomem * parameter. For pointers
> 	mapped with the default I/O attributes (e.g. those returned by
> 	ioremap()), the ordering guarantees are as follows:
> 
> 	1. All readX() and writeX() accesses to the same peripheral are ordered
> 	   with respect to each other. This ensures that MMIO register accesses
> 	   by the same CPU thread to a particular device will arrive in program
> 	   order.
> 
> 	2. A writeX() issued by a CPU thread holding a spinlock is ordered
> 	   before a writeX() to the same peripheral from another CPU thread
> 	   issued after a later acquisition of the same spinlock. This ensures
> 	   that MMIO register writes to a particular device issued while holding
> 	   a spinlock will arrive in an order consistent with acquisitions of
> 	   the lock.
> 
> -----------
> 
> To summarize:
> 
> io_ordering.rst says to use readX() before spin_unlock to order writeX()
> calls (on some platforms).
> 
> memory-barriers.txt says writeX() calls are already ordered when holding
> the same spinlock.
> 
> So...which one is correct?

From quick glance of io_ordering.rst's git history, contents of this file
is never updated since the beginning of Git history (v2.6.12.rc2).

Which strongly suggests that you can ignore io_ordering.rst.

        Thanks, Akira

PS:
Do we need to keep that outdated document???

I think Documentation/driver-api/device-io.rst is the one properly
maintained.

> 
> 
> There is another example of flushing posted PCI writes at the bottom of
> Documentation/PCI/pci.rst, but that one is consistent with
> memory-barriers.txt.
> 
> Tony Battersby
> Cybernetics
> 
