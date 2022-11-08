Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C071622011
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 00:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKHXHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 18:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKHXHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 18:07:42 -0500
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51C63159
        for <linux-arch@vger.kernel.org>; Tue,  8 Nov 2022 15:07:41 -0800 (PST)
X-ASG-Debug-ID: 1667948858-1cf43916953bcb50002-nV0IUL
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id lYGEv62L2AfLvHwX; Tue, 08 Nov 2022 18:07:38 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=Ltmgz4FRGZvYJ6x9NIHhx3nQQsP+YYpgZpdkS9JvU+o=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=CYxZCfWI9CbLN1OQJ+F/
        lwI/60xTPhKB9vLfRVxOtlpVip1ZX818BGZVCOx0M+/d5dhtONKggrqo35EvYWpK5LeWR7KCcNYK9
        Uu39J11IXKaGtG99iwsRZLDHr6rCR/gtHmFLTeclZXqUP9XdBDY2UEuE/CpD6ceXZSW1OGYti0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12318971; Tue, 08 Nov 2022 18:07:38 -0500
Message-ID: <bb6dfd57-0a46-9aa5-050f-40e207bd44f4@cybernetics.com>
Date:   Tue, 8 Nov 2022 18:07:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: io_ordering.rst vs. memory-barriers.txt
Content-Language: en-US
X-ASG-Orig-Subj: Re: io_ordering.rst vs. memory-barriers.txt
From:   Tony Battersby <tonyb@cybernetics.com>
To:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
References: <1924eda8-aea6-da64-04a7-35f3327a7f4f@cybernetics.com>
In-Reply-To: <1924eda8-aea6-da64-04a7-35f3327a7f4f@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1667948858
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 4231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(resending in plaintext; damn Thunderbird upgrades...)

While looking up documentation for PCI write posting I noticed that the
example in Documentation/driver-api/io_ordering.rst seems to contradict
Documentation/memory-barriers.txt:

-----------

Documentation/driver-api/io_ordering.rst:

On some platforms, so-called memory-mapped I/O is weakly ordered.  On such
platforms, driver writers are responsible for ensuring that I/O writes to
memory-mapped addresses on their device arrive in the order intended.  This is
typically done by reading a 'safe' device or bridge register, causing the I/O
chipset to flush pending writes to the device before any reads are posted.  A
driver would usually use this technique immediately prior to the exit of a
critical section of code protected by spinlocks.  This would ensure that
subsequent writes to I/O space arrived only after all prior writes (much like a
memory barrier op, mb(), only with respect to I/O).

A more concrete example from a hypothetical device driver::

		...
	CPU A:  spin_lock_irqsave(&dev_lock, flags)
	CPU A:  val = readl(my_status);
	CPU A:  ...
	CPU A:  writel(newval, ring_ptr);
	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
		...
	CPU B:  spin_lock_irqsave(&dev_lock, flags)
	CPU B:  val = readl(my_status);
	CPU B:  ...
	CPU B:  writel(newval2, ring_ptr);
	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
		...

In the case above, the device may receive newval2 before it receives newval,
which could cause problems.  Fixing it is easy enough though::

		...
	CPU A:  spin_lock_irqsave(&dev_lock, flags)
	CPU A:  val = readl(my_status);
	CPU A:  ...
	CPU A:  writel(newval, ring_ptr);
	CPU A:  (void)readl(safe_register); /* maybe a config register? */
	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
		...
	CPU B:  spin_lock_irqsave(&dev_lock, flags)
	CPU B:  val = readl(my_status);
	CPU B:  ...
	CPU B:  writel(newval2, ring_ptr);
	CPU B:  (void)readl(safe_register); /* maybe a config register? */
	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)

Here, the reads from safe_register will cause the I/O chipset to flush any
pending writes before actually posting the read to the chipset, preventing
possible data corruption.

-----------

Documentation/memory-barriers.txt:

==========================
KERNEL I/O BARRIER EFFECTS
==========================

Interfacing with peripherals via I/O accesses is deeply architecture and device
specific. Therefore, drivers which are inherently non-portable may rely on
specific behaviours of their target systems in order to achieve synchronization
in the most lightweight manner possible. For drivers intending to be portable
between multiple architectures and bus implementations, the kernel offers a
series of accessor functions that provide various degrees of ordering
guarantees:

 (*) readX(), writeX():

	The readX() and writeX() MMIO accessors take a pointer to the
	peripheral being accessed as an __iomem * parameter. For pointers
	mapped with the default I/O attributes (e.g. those returned by
	ioremap()), the ordering guarantees are as follows:

	1. All readX() and writeX() accesses to the same peripheral are ordered
	   with respect to each other. This ensures that MMIO register accesses
	   by the same CPU thread to a particular device will arrive in program
	   order.

	2. A writeX() issued by a CPU thread holding a spinlock is ordered
	   before a writeX() to the same peripheral from another CPU thread
	   issued after a later acquisition of the same spinlock. This ensures
	   that MMIO register writes to a particular device issued while holding
	   a spinlock will arrive in an order consistent with acquisitions of
	   the lock.

-----------

To summarize:

io_ordering.rst says to use readX() before spin_unlock to order writeX()
calls (on some platforms).

memory-barriers.txt says writeX() calls are already ordered when holding
the same spinlock.

So...which one is correct?


There is another example of flushing posted PCI writes at the bottom of
Documentation/PCI/pci.rst, but that one is consistent with
memory-barriers.txt.

Tony Battersby
Cybernetics

