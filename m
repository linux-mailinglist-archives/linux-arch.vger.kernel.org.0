Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451B741CD3E
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbhI2UOz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 16:14:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:45050 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346005AbhI2UOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 16:14:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3A0DB36CF40;
        Wed, 29 Sep 2021 16:13:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QlOufg1cVnjN; Wed, 29 Sep 2021 16:13:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 70BA136CF3F;
        Wed, 29 Sep 2021 16:13:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 70BA136CF3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632946389;
        bh=BGR3IhMgvnr2C21lVOeoKeIDdeIwpKzGzllTJYFvrn8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eyD4lQM2ftTh+7KXkE4RMV5SfVn3y6qTAqk/rs5QgzV+OVweBf2dnvnGZgy6uxMIL
         ft496HKogEo+YBNBvr0cQaI8YdIwdC/2npBEiWYaJdmK1LIV5EHXvcx/QHBBjJn8b6
         1yZ0UmU8hL8c68R+93wSezqSNzmQxV6tGtU/ovBLN+Kn6DYvhP9lMRHr/Fz6BKyEVf
         BCqbsN8a88H7BWIJq++UMOrfxtOcd1QivaFfYxxGxTcjNJWDKdi/8Fnqqgob4m7JdM
         YgoVNEYn7TcAGpoYGWyLlfncfeR8nqtW0jmdMEXacfvx9yGt1GDVzgw7/bYV6ujCb5
         L7sf9VTJuWv6Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i8VpYX5ZSU8M; Wed, 29 Sep 2021 16:13:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5ABCB36D014;
        Wed, 29 Sep 2021 16:13:09 -0400 (EDT)
Date:   Wed, 29 Sep 2021 16:13:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1587674056.44794.1632946389244.JavaMail.zimbra@efficios.com>
In-Reply-To: <457755093.44604.1632945052335.JavaMail.zimbra@efficios.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com> <CAHk-=wjd_BJiJYZ99PAoc4mQ3QTiZrt-tRdznj3g9kU8-gYsAA@mail.gmail.com> <457755093.44604.1632945052335.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: cL23+1Kw3cVad0ytZvNC6SLA16g8Tx674bOI
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 29, 2021, at 3:50 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

[...]

> void fct(void)
> {
>    int x;
> 
>    if (refcount_dec_and_test()) {
>        var1 = 0;

in this example, this should be "var1 = 1;", so both legs are similar,
otherwise we end up with a dependency on the load.

Thanks,

Mathieu

>        return;
>    }
>    __smp_rmb();
>    var1 = 1;
> }
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
