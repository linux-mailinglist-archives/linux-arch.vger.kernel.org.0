Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966AF9F76E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 02:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH1AgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 20:36:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42190 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1AgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Aug 2019 20:36:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so341841plp.9
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2019 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=wmS7FrQPukUY1SYRxTvvzLc7Vj+es0c1WkGNt9QAu3k=;
        b=MuaJswhO/hYBUjfZZyVJFR8oyAZKM/ig0OP3rDwDqD2YbiFFuNppsaq3UZL7LKvHSd
         2CKADiqfXNIj465C67ssRe2UTuIm3LtfLmZZfRpIO8kBQk1IJyhWxnki0866529lnm4P
         q+Velb3UI33KVOGRGEv8/33hFidA9ZMm7qqJZbPy87mtKNoARL57Co5X/3p1yZMF46+f
         +/1PyUysWkZKjFNhMC1MSgSB9+sy1V+jUOsJJlDlof6wK+00WRcsi4P+KhaXJNNP3xwo
         4REAB02FOxOmpT2HdckqeEFeYXeQZSrStRmvzYEzcbly6xBuFVi4metk4sjQO6EfMKXe
         14Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=wmS7FrQPukUY1SYRxTvvzLc7Vj+es0c1WkGNt9QAu3k=;
        b=L5n4aFQSb2T+58mF1qst5N8iW5KviXgasH9pUo3GHtE4KIxgp5xJOEW0jrgxAhXrOB
         M1dk1YIjBqNz+Uexdhj6rL/5lVDmN4rrpsJi76uY2Vzf9uAD/jqno1/viXUwVwXhs4tQ
         qPsPX0UWBIeVCNLYXHmc9RSXMJE9r7K1ytDEKh/+oxCxYgFgbTj5KNDQWQeVTztIHWzw
         E2PMXmpILwVj3N3oQdSXGPGYQG5fj8MYRypJ31zQyXUJUo5ZHQuVv0kNUxOYXrO5GJny
         /YHi7BB3HAa/s1+Qqh+hf2PLHCkw6JVyvGz/YjMm6nWsMGwrgRDU5fku41+dWWFn9A2e
         5PpQ==
X-Gm-Message-State: APjAAAXLD/CjwX+yVGAA1fagty4xx0UPANrYoXkmI2K8KKneEVAFNfGg
        pTkm/J2IdnY8u/dvOLLrdQI=
X-Google-Smtp-Source: APXvYqzAFp57WI5nRoBPJ95nSs4zG2MftKEUTRq3QXaFnRUDFp9tT6Esous8OROyD9OqLE2OC3fy3A==
X-Received: by 2002:a17:902:d686:: with SMTP id v6mr1695246ply.134.1566952577795;
        Tue, 27 Aug 2019 17:36:17 -0700 (PDT)
Received: from localhost (14-202-91-55.tpgi.com.au. [14.202.91.55])
        by smtp.gmail.com with ESMTPSA id m34sm351963pje.5.2019.08.27.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:36:17 -0700 (PDT)
Date:   Wed, 28 Aug 2019 10:35:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
To:     linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190827131818.14724-1-will@kernel.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566947104.2uma6s0pl1.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Will Deacon's on August 27, 2019 11:18 pm:
> can actually raise a translation fault on the load instruction because th=
e
> translation can be performed speculatively before the page table update a=
nd
> then marked as "faulting" by the CPU. For user PTEs, this is ok because w=
e
> can handle the spurious fault, but for kernel PTEs and intermediate table
> entries this results in a panic().

powerpc sounds like it has the same coherency issue with stores vs loads=20
from the MMU's page table walker, and a barrier called ptesync to order=20
them.

> We can fix this by reverting 24fe1b0efad4fcdd, but the fun doesn't stop
> there. If we consider the unmap case, then a similar constraint applies t=
o
> ordering subsequent memory accesses after the completion of the TLB
> invalidation, so we also need to add an ISB instruction to
> __flush_tlb_kernel_pgtable(). For user addresses, the exception return
> provides the necessary context synchronisation.
>=20
> This then raises an interesting question: if an ISB is required after a T=
LBI
> instruction to prevent speculative translation of subsequent instructions=
,
> how is this speculation prevented on concurrent CPUs that receive the
> broadcast TLB invalidation message? Sending and completing a broadcast TL=
B
> invalidation message does not imply execution of an ISB on the remote CPU=
,
> however it /does/ require that the remote CPU will no longer make use of =
any
> old translations because otherwise we wouldn't be able to guarantee that =
an
> unmapped page could no longer be modified. In this regard, receiving a TL=
B
> invalidation is in some ways stronger than sending one (where you need th=
e
> ISB).

Similar with powerpc's tlbie, sender requires extra barriers!

> So far, so good, but the final piece of the puzzle isn't quite so rosy.
>=20
> *** Other architecture maintainers -- start here! ***
>=20
> In the case that one CPU maps a page and then sets a flag to tell another
> CPU:
>=20
> 	CPU 0
> 	-----
>=20
> 	MOV	X0, <valid pte>
> 	STR	X0, [Xptep]	// Store new PTE to page table
> 	DSB	ISHST
> 	ISB
> 	MOV	X1, #1
> 	STR	X1, [Xflag]	// Set the flag
>=20
> 	CPU 1
> 	-----
>=20
> loop:	LDAR	X0, [Xflag]	// Poll flag with Acquire semantics
> 	CBZ	X0, loop
> 	LDR	X1, [X2]	// Translates using the new PTE
>=20
> then the final load on CPU 1 can raise a translation fault for the same
> reasons as mentioned at the start of this description.

powerpc's ptesync instruction is defined to order MMU memory accesses on
all other CPUs. ptesync does not go out to the fabric though. How does
it work then?

Because the MMU coherency problem (at least we have) is not that the
load will begin to "partially" execute ahead of the store, enough to
kick off a table walk that goes ahead of the store, but not so much
that it violates the regular CPU barriers. It's just that the loads
from the MMU don't participate in the LSU pipeline, they don't snoop
the store queues aren't inserted into load queues so the regular
memory barrier instructions won't see stores from other threads cuasing
ordering violations.

In your first example, if powerpc just has a normal memory barrier
there instead of a ptesync, it could all execute completely
non-speculatively and in-order but still cause a fault, because the
table walker's loads didn't see the store in the store queue.

From the other side of the fabric you have no such problem. The table
walker is cache coherent apart from the local stores, so we don't need a=20
special barrier on the other side. That's why ptesync doesn't broadcast.

I would be surprised if ARM's issue is different, but interested to=20
hear if it is.

> In reality, code
> such as:
>=20
> 	CPU 0				CPU 1
> 	-----				-----
> 	spin_lock(&lock);		spin_lock(&lock);
> 	*ptr =3D vmalloc(size);		if (*ptr)
> 	spin_unlock(&lock);			foo =3D **ptr;
> 					spin_unlock(&lock);
>=20
> will not trigger the fault because there is an address dependency on
> CPU1 which prevents the speculative translation. However, more exotic
> code where the virtual address is known ahead of time, such as:
>=20
> 	CPU 0				CPU 1
> 	-----				-----
> 	spin_lock(&lock);		spin_lock(&lock);
> 	set_fixmap(0, paddr, prot);	if (mapped)
> 	mapped =3D true;				foo =3D *fix_to_virt(0);
> 	spin_unlock(&lock);		spin_unlock(&lock);
>=20
> could fault.

This is kind of a different issue, or part of a wider one at least.
Consider speculative execution more generally, any branch mispredict can=20
send us off to crazy town executing instructions using nonsense register
values. CPU0 does not have to be in the picture, or any kernel page=20
table modification at all, CPU1 alone will be doing speculative loads=20
wildly all over the kernel address space and trying to access pages with
no pte.

Yet we don't have to flush TLB when creating a new kernel mapping, and
we don't get spurious kernel faults. The page table walker won't
install negative entries, at least not "architectural" i.e., that cause
faults and require flushing. My guess is ARM is similar, or you would=20
have seen bigger problems by now?

If you have CPU0 doing a ro->rw upgrade on a kernel PTE, then it may
be possible another CPU1 would speculatively install a ro TLB and then
spurious fault on it when attempting to store to it. But no amount of
barriers would help because CPU1 could have picked up that TLB any time
in the past.

Thanks,
Nick
=
