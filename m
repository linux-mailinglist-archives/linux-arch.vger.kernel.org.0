Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33C341CCD3
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbhI2Tsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 15:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344818AbhI2Tsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 15:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632944816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OphKSRDSZgdX5nhZl6LEkHup1MlwE4E4ChnXI2KmIUo=;
        b=hI0eJoZTAjXAZfXz/lmouxtVuU1+kXFvbA1Cx/15uvJkf/CnrGB296rEhB4agx2WeHnNdb
        5SDeUKCRTF5MohQc0+an5Vh61EjYwmp9974d0jgYGMyYHbpaJwLMbybHfyPB/E2TmMgxXQ
        6PXR/SbnPkF/Hq5En9iMS+gCxRUxWEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-HILN_C1ROwGuqXDAIOZcMQ-1; Wed, 29 Sep 2021 15:46:55 -0400
X-MC-Unique: HILN_C1ROwGuqXDAIOZcMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3E09801E72;
        Wed, 29 Sep 2021 19:46:52 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D24D45C1C5;
        Wed, 29 Sep 2021 19:46:48 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        will@kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
        <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
        <20210929174146.GF22689@gate.crashing.org>
Date:   Wed, 29 Sep 2021 21:46:47 +0200
In-Reply-To: <20210929174146.GF22689@gate.crashing.org> (Segher Boessenkool's
        message of "Wed, 29 Sep 2021 12:41:46 -0500")
Message-ID: <877dez5fmg.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Segher Boessenkool:

> Hi!
>
> On Wed, Sep 29, 2021 at 02:28:37PM +0200, Florian Weimer wrote:
>> If you need a specific instruction emitted, you need a compiler
>> intrinsic or inline assembly.
>
> Not an intrinsic.  Builtins (like almost all other code) do not say
> "generate this particular machine code", they say "generate code that
> does <this>".  That is one reason why builtins are more powerful than
> inline assembler (another related reason is that they tell the compiler
> exactly what behaviour is expected).

I meant that if the object code has to contain a specific instruction
sequence involving a conditional, it needs some form of compiler
support.  Adding some volatile here and some form of a compiler barrier
there is very brittle.

>> I don't think it's possible to piggy-back this on something else.
>
> Unless we get a description of what this does in term of language
> semantics (instead of generated machine code), there is no hope, even.

True.  For example, if the argument contains a sequence point, what does
that even mean?

Thanks,
Florian

