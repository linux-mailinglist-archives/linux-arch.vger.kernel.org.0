Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8C41C4C2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbhI2Mab (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 08:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343784AbhI2Mab (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 08:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632918529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YOJEA2l7ndawO0L20I9DTw6V5oi9LOOOa8cUEjA/x4o=;
        b=VR6Ce53DzjG2EQ/h/m9LBD3iGNM0nAlRXJP9EVNuE/vY7SBP8pldR3706mrcVXzf+KqfPX
        zAGuSuP+n6H0LYCfbtaviscJbtVRMEvprvc6rmrjP8pfsnL/qOIAdppK9eTsJ6SMoKdfXO
        xiuLbhhTEvbKVnLawWkfDp66BNkE3Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-QBok8GuBO5OtnjGuMK9O5Q-1; Wed, 29 Sep 2021 08:28:46 -0400
X-MC-Unique: QBok8GuBO5OtnjGuMK9O5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A8B0802936;
        Wed, 29 Sep 2021 12:28:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3194160854;
        Wed, 29 Sep 2021 12:28:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     will@kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
Date:   Wed, 29 Sep 2021 14:28:37 +0200
In-Reply-To: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Tue, 28 Sep 2021 17:15:07 -0400")
Message-ID: <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Mathieu Desnoyers:

> + * will ensure that the STORE to B happens after the LOAD of A. Normally a
> + * control dependency relies on a conditional branch having a data dependency
> + * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
> + * provides a LOAD->STORE order.
> + *
> + * Due to optimizing compilers, extra care is needed; as per the example above
> + * the LOAD must be 'volatile' qualified in order to ensure the compiler
> + * actually emits the load, such that the data-dependency to the conditional
> + * branch can be formed.
> + *
> + * Secondly, the compiler must be prohibited from lifting anything out of the
> + * selection statement, as this would obviously also break the ordering.
> + *
> + * Thirdly, architectures that allow the LOAD->STORE reorder must ensure
> + * the compiler actually emits the conditional branch instruction.

If you need a specific instruction emitted, you need a compiler
intrinsic or inline assembly.

So something like this:

#define control_dep(x)                          \
  ({                                            \
    __typeof(x) x__ = (x);                      \
    __asm__("test $0, %0\n\t"                   \
            "jnz 1f\n\t"                        \
            "1:"                                \
            :: "r"(x__) : "cc");                \
  })

with an appropriate instruction sequence for each architecture.

I don't think it's possible to piggy-back this on something else.

Thanks,
Florian

