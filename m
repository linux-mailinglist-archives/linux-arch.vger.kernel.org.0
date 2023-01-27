Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AFA67E70C
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjA0Nt6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 08:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjA0Ntx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 08:49:53 -0500
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D07EFC6
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 05:49:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id E19C860B5C6
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 14:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674827388;
        bh=7rslGuy0LFs/A27KvXbfl/OcHHEbOozB3Cd0Um3yM3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=v28inaLNuNGjPUgb2uFQZp78U2jdHRDnP4oaAjnkDzhAbWNTMI0ewT0GXBT1gcOYp
         WIXFRCIXMjPbfLCA6APgnp6bRmj5ksGC/5xn1gqCBUnqlNgIEGCgvFK5xOM+ZznPaO
         H8msrmWc/Eay4ztbDeSNL3D4kqDSa1vHdsi+d8/M=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id A91B660B267; Fri, 27 Jan 2023 14:49:48 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id EB78B60BA03; Fri, 27 Jan
 2023 14:49:47 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id BC10327E02A1; Fri, 27 Jan 2023
 14:49:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 9E91427E0493; Fri, 27 Jan 2023 14:49:47 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 yK0vAahdc_IY; Fri, 27 Jan 2023 14:49:47 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 84D7A27E02A1; Fri, 27 Jan 2023
 14:49:47 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <7d71.63d3d67b.e9b37.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 9E91427E0493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674827387;
 bh=Anms8fnf94ipa7tBFX00h5M9wZzd+Ui5LYvmjbIH5Dw=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=m8Ymrxrvt0SQhMyg0saq0caQjx7MXgK/KCJLgHZ+0fqtM8w9rVeNCXsZGXSoTFU7Y
 h1TwiEcH0RIiw7kuUeKgGTu+636qAb/X2GG081yS93orpsXLA1LzRQ/EY3fpoFNX0C
 +2YYajHmC8s9THtKQdollNlOoKcqr9qJzIapo/go=
Date:   Fri, 27 Jan 2023 14:49:46 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
Message-ID: <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Fri, Jan 27, 2023 at 12:18:13PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 26, 2023 at 06:33:54PM +0100, Jules Maselbas wrote:
> 
> > @@ -58,9 +61,11 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
> >  static inline void generic_atomic_##op(int i, atomic_t *v)		\
> >  {									\
> >  	unsigned long flags;						\
> > +	int c;								\
> >  									\
> >  	raw_local_irq_save(flags);					\
> > -	v->counter = v->counter c_op i;					\
> > +	c = arch_atomic_read(v);					\
> > +	arch_atomic_set(v, c c_op i);					\
> >  	raw_local_irq_restore(flags);					\
> >  }
> 
> This and the others like it are a bit sad, it explicitly dis-allows the
> compiler from using memops and forces a load-store.
Good point, I don't know much about atomic memops but this is indeed a
bit sad to prevent such instructions to be used.

> The alternative is writing it like:
> 
> 	*(volatile int *)&v->counter c_op i;
I wonder if it could be possible to write something like:

        *(volatile int *)&v->counter += i;

I also noticed that GCC has some builtin/extension to do such things,
__atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
can be used in the kernel.


Thanks,
-- Jules





