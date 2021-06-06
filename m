Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF439D08A
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFFTB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 15:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhFFTB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 15:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623005977;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=KXWrX6wBq5TioPWpDxBNh/+AQclSH0iG9b0SVz2qp/k=;
        b=DhKM0XKu/hHLHiqCQagq2mzfRE1vhwt4+JvJlm0uE+DqG+UYCXuc5Dn3GLc+ykBginGXcJ
        7KVQVFm6gE7s0TJpSIQpnRJBzTxsg5gG4e63eqrhMUcYxX8DUlAhoFNdxlRb48rGy8AH+3
        bXE2JsF6X+OBG2K8gXQQG6EXY33QWo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-2EurjrPUNo--k71WjI_Ddw-1; Sun, 06 Jun 2021 14:59:36 -0400
X-MC-Unique: 2EurjrPUNo--k71WjI_Ddw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550FD8015F5;
        Sun,  6 Jun 2021 18:59:33 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-147.ams2.redhat.com [10.36.112.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9710E5D9C0;
        Sun,  6 Jun 2021 18:59:32 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 156IxSJQ4093308
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 6 Jun 2021 20:59:28 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 156IxMY94093305;
        Sun, 6 Jun 2021 20:59:22 +0200
Date:   Sun, 6 Jun 2021 20:59:22 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210606185922.GF7746@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> Something like this *does* seem to work:
> 
>    #define ____barrier(id) __asm__ __volatile__("#" #id: : :"memory")
>    #define __barrier(id) ____barrier(id)
>    #define barrier() __barrier(__COUNTER__)
> 
> which is "interesting" or "disgusting" depending on how you happen to feel.

I think just
#define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
should be enough (or "X" instead of "i" if some arch uses -fpic and will not
accept small constants in PIC code), for CSE gcc compares that the asm template
string and all arguments are the same.

As for volatile, that is implicit on asm without any output operands and
it is about whether the inline asm can be DCEd, not whether it can be CSEd.

	Jakub

